//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "D2xx.h"
#include "Func.h"

#include <stdio.h>
#include <sys/types.h>
#include <sys/timeb.h>
#include <string.h>

//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
void MyThread();        // прототип функции потока
TForm1 *Form1;
TMenuItem * DevList[5];
char *BufPtrs[5];

char Dev1[64]; // буфер для описания первого устройства
char Dev2[64]; // буфер для описания второго устройства
char Dev3[64]; // буфер для описания третьего устройства
char Dev4[64]; // буфер для описания четвёртого устройства

unsigned int  ToUSB_Data;
unsigned char BinByte;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
void __fastcall TForm1::CreateForm(TObject *Sender)//при открытии программы
{
// настройка необходимых переменных класса Form1
hPort=NULL;
hThread=NULL;
List1Num=0;
NumCicle=10;
WriteFlag=0;
NumDev=0;

EnDis(false);

// установка начальных параметров порта
ComboBox6->ItemIndex=0;         // 10 раз

DevList[0]=Form1->N11;
DevList[1]=Form1->N21;
DevList[2]=Form1->N31;
DevList[3]=Form1->N41;

BufPtrs[0] = Dev1;
BufPtrs[1] = Dev2;
BufPtrs[3] = Dev3;
BufPtrs[4] = Dev4;
BufPtrs[5] = NULL;

SearchDevices(DevList,BufPtrs); // поиск присоединённых устройств

ThreadStart();                  // создаём поток
//
TForm1::InitPort(0);            //
//
}
//---------------------------------------------------------------------------

int TForm1::InitPort(int nDev)// открытие порта и установка параметров
{
char NumStr[10];
FT_STATUS ftStatus;

if (hPort!=NULL)
        {
        FT_Close(hPort);   // закрытие старого указателя
        hPort=NULL;
        }

ftStatus=FT_Open(nDev,&hPort);
if (ftStatus!=FT_OK)
        {
        MessageBox(0,"Ошибка при открытии порта","Error",MB_OK|MB_ICONERROR);
        return 0;
        }

ftStatus=FT_SetUSBParameters(hPort,16384,16384);  // установка размеров буферов
if (ftStatus!=FT_OK)
        {
        MessageBox(0,"Ошибка при установке размеров буферов","Error",MB_OK|MB_ICONERROR);
        return 0;
        }

ftStatus=FT_SetTimeouts(hPort,5,5);
if (ftStatus!=FT_OK)
        {
        MessageBox(0,"Ошибка при установке таймаутов", "Error",MB_OK|MB_ICONERROR);
        return 0;
        }

ftStatus=FT_SetBitMode(hPort,0xff,0);
if (ftStatus!=FT_OK)
        MessageBox(0,"Ошибка при выключении Bit Mode","Error",MB_OK|MB_ICONERROR);

ftStatus=FT_Purge(hPort,FT_PURGE_RX|FT_PURGE_TX);
if (ftStatus!=FT_OK)
        {
        MessageBox(0,"Ошибка при очистке буферов I/O","Error",MB_OK|MB_ICONERROR);
        return 0;
        }

EnDis(true);

Form1->CheckBox2->Checked=true;
Form1->CheckBox3->Checked=false;
Form1->CheckBox4->Checked=false;

return 1;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)//нажата кнопка ПОСЛАТЬ
{
char buf[4096], bb[30];
int proverka=0, schetchik=1, l;
long time;

Memo1->GetTextBuf(buf,4096);
if (Memo1->GetTextLen())
        {
                if (Form1->CheckBox1->Checked==true) schetchik=NumCicle;


                if (Form1->CheckBox2->Checked==true) // Hex
                        {
                        if ( ToUSB_Data > (unsigned int)0xFFFFFF ) l=4; else
                        if ( ToUSB_Data > (unsigned int)0xFFFF   ) l=3; else
                        if ( ToUSB_Data > (unsigned int)0xFF     ) l=2; else l=1;

                        for(int i=0;i<l;i++) buf[i]= (ToUSB_Data >>(l-i-1)*8 ) & 0xFF;
                        proverka=WritePort(buf, l, schetchik, &time);    // запись в порт
                        }
                else
                if (Form1->CheckBox3->Checked==true) // ASCII
                        proverka=WritePort(buf, strlen(buf), schetchik, &time);    // запись в порт
                else
                if (Form1->CheckBox4->Checked==true) // Bin
                        {
                        buf[0]=BinByte;
                        proverka=WritePort(buf, 1, schetchik, &time);    // запись в порт
                        }

                if (!proverka)
                        MessageBox(0,"Ошибка при записи в порт","Error",MB_OK|MB_ICONERROR);
        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button2Click(TObject *Sender)// нажата кнопка ОЧИСТИТЬ(посылка)
{
Memo1->Clear();

ToUSB_Data=0;
if (CheckBox2->Checked==true) Label3->Caption="Hex:\n"; else
if (CheckBox3->Checked==true) Label3->Caption="ASCII:\n"; else
if (CheckBox4->Checked==true) Label3->Caption="Bin:\n";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Button3Click(TObject *Sender)// нажата кнопка ОЧИСТИТЬ(приём)
{
ListBox1->Items->Clear();
List1Num=0;
//Label7->Caption="Количество строк: 0";
}
//---------------------------------------------------------------------------

void __fastcall TForm1::OnClose(TObject *Sender, TCloseAction &Action) //при выходе из программы
{
FT_STATUS ftStatus;

// завершение потока
GetExitCodeThread(hThread,&(Form1->ThExitCode));
ExitThread(ThExitCode);

// закрытие указателей перед выходом
ftStatus=FT_SetBitMode(hPort,0xff,0);
if (ftStatus!=FT_OK)
        MessageBox(0,"Ошибка при выключении Bit Mode при выходе из программы","Error",MB_OK|MB_ICONERROR);

ftStatus=FT_Purge(hPort,FT_PURGE_RX|FT_PURGE_TX);
if (ftStatus!=FT_OK)
        MessageBox(0,"Ошибка при очистке буферов I/O","Error",MB_OK|MB_ICONERROR);

CloseHandle(hThread);
FT_Close(hPort);
}

//--------------------------------------------------

int TForm1::ThreadStart() // функция создания потока
{
DWORD dwThreadId, dwThrdParam = 1;

hThread = CreateThread(
NULL,                        // default security attributes
0,                           // use default stack size
(unsigned long (__stdcall *)(void *))MyThread,  // thread function
&dwThrdParam,                // argument to thread function
0,                           // use default creation flags
&dwThreadId);                // returns the thread identifier

if (hThread==NULL)
        {
        MessageBox(0,"Поток не запустился!","ERROR",MB_OK);
        return 0;
        }
SetThreadPriority(           // установка приоритета потока
  hThread,
  THREAD_PRIORITY_LOWEST
);
return 1;
}

//---------------------------------------------------------------------------

void MyThread()
// функция потока чтения символов из порта
{
FT_STATUS ftStatus;
char out, bb[100], tmp[10], buf[10];
unsigned int lead;
DWORD numout, RxBuf=0, TxBuf=0, EventStat;


while (1)
        {
        ftStatus=FT_GetStatus(Form1->hPort,&RxBuf,&TxBuf, &EventStat);
        if (ftStatus!=FT_OK)
                {
                //MessageBox(0,"Ошибка при просмотре статуса устройства","Error",MB_OK|MB_ICONERROR);
                }

        if (RxBuf!=0 && Form1->mode==0) // чтение только если в приёмном буфере что то есть
                {
                ftStatus=FT_Read(       // чтение из порта
                Form1->hPort,
                &out,
                1,                      // чтение по одному символу
                &numout);

                if (Form1->CheckBox3->Checked==true)    // ASCII
                        Form1->ListBox1->Items->Append(&out);
                else
                if (Form1->CheckBox2->Checked==true) {  // HEX
                        sprintf(tmp,"%x%x", (out>>4)&0xF, out&0xF);
                        Form1->ListBox1->Items->Append(tmp);
                }
                else
                if (Form1->CheckBox4->Checked==true) {  // BIN
                        lead= out;
                        for(int i=0;i<8;i++) {
                                buf[7-i] = ( lead%2 )+'0';
                                lead >>= 1;
                        }
                        buf[8]='\0';
                        bb[0]='\0';
                        for(int i=0;i<8;i++) {
                                sprintf(tmp,"%c", buf[i]); strcat( bb, tmp );
                        }
                        Form1->ListBox1->Items->Append(bb);
                }

                if (Form1->List1Num%20000==0 && (Form1->List1Num)!=0)
                        {
                        Form1->ListBox1->Clear();
                        }

                if (ftStatus!=FT_OK)
                        {
                        MessageBox(0,"Ошибка при чтении","Error",MB_OK|MB_ICONERROR);
                        }
                }
        else
                Sleep(1);
        }
}

//---------------------------------------------------------------------------
void __fastcall TForm1::OnNumCicleChange(TObject *Sender)
{
NumCicle=ComboBox6->Text.ToInt();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N4Click(TObject *Sender)
{
Form1->Close();
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N2Click(TObject *Sender)
{
SearchDevices(DevList,BufPtrs);
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N11Click(TObject *Sender)
{
InitPort(0);
NumDev=0;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N21Click(TObject *Sender)
{
InitPort(1);
NumDev=1;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N31Click(TObject *Sender)
{
InitPort(2);
NumDev=2;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::N41Click(TObject *Sender)
{
InitPort(3);
NumDev=3;
}

//---------------------------------------------------------------------------

void __fastcall TForm1::CheckBox1Click(TObject *Sender)
{
if (CheckBox1->Checked==true)
        ComboBox6->Enabled=true;
else
        ComboBox6->Enabled=false;
}
//---------------------------------------------------------------------------

void __fastcall TForm1::CheckBox2Click(TObject *Sender)
{
char bb[100];

if (CheckBox2->Checked==true) { // Hex
        CheckBox3->Checked=false;
        CheckBox4->Checked=false;
        Form1->Button1->Enabled=true;

        ToUSB_Data=0;
        Memo1->Clear();

//        if(ToUSB_Data!=0) sprintf(bb,"Hex: %x\n", ToUSB_Data);
//        else              sprintf(bb,"Hex:\n");
        sprintf(bb,"Hex:\n");
        Label3->Caption=bb;
        }

}
//---------------------------------------------------------------------------

void __fastcall TForm1::CheckBox3Click(TObject *Sender)
{
char bb[100];

if (CheckBox3->Checked==true) { // ASCII code
        CheckBox2->Checked=false;
        CheckBox4->Checked=false;
        Form1->Button1->Enabled=true;

        ToUSB_Data=0;
        Memo1->Clear();
//        ListBox1->Items->Clear();
//        List1Num=0;

        sprintf(bb,"ASCII:\n");
        Label3->Caption=bb;
        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::CheckBox4Click(TObject *Sender)
{
char bb[100], buf[65], tmp[20];
int l, lead;
unsigned int Data;

if (CheckBox4->Checked==true) { // BIN
        CheckBox2->Checked=false;
        CheckBox3->Checked=false;
        Form1->Button1->Enabled=false;

        ToUSB_Data=0;
        Memo1->Clear();
/*
        if ( ToUSB_Data > 0xFFFF   ) l=32; else
        if ( ToUSB_Data > 0xFF     ) l=16; else l=8;
        Data = ToUSB_Data;

        for(int i=0;i<65;i++)  buf[i]=' ';
        buf[l]='\0';
        for(int i=0;i<l;i++) { buf[l-i-1]= Data%2+'0'; Data >>= 1; }
*/
        sprintf(bb,"Bin: ");
/*
        lead=1;
        for(int i=0;i<l;i++) {
                if (lead && buf[i]=='0') ; else {
                        sprintf(tmp,"%c", buf[i]); strcat( bb, tmp );
                        lead=0;
                        }
                }
        sprintf(tmp,"\n"); strcat( bb, tmp );
*/
        Label3->Caption=bb;
        }
}
//---------------------------------------------------------------------------

void __fastcall TForm1::Memo1Change(TObject *Sender)
//что то ввелось в окно ПОСЫЛКА, изменение ВВЕДЕНО (изменение числа символов)
{
int n, l;
char buf[4096], bb[100], tmp[20];

Memo1->GetTextBuf(buf,4096);
l=(int)Memo1->GetTextLen();

if (CheckBox2->Checked==true) { // Hex
        if ( l > 8 ) {
                l=8;
                buf[8]='\0';
                Memo1->SetTextBuf(buf);
                }

        for(int i=0;i<l;i++) if( isxdigit(buf[i]) ) ; else {
                buf[i]='\0';
                Memo1->SetTextBuf(buf);
                break;
                }
        l=(int)Memo1->GetTextLen();
        if ( l ){
                sscanf(buf,"%x", &n );
                ToUSB_Data=n;
                sprintf(bb,"Hex: %x\n", n);
                }
        }

else
if (CheckBox3->Checked==true) { // ASCII code
        sprintf(bb,"ASCII:");
        for(int i=0;i<l;i++) {
                sprintf(tmp," %x", buf[i]); strcat( bb, tmp );
                }
        }
else
if (CheckBox4->Checked==true) { // BIN
        BinByte=0;
        if ( l > 8 ) {
                l=8;
                buf[8]='\0';
                Memo1->SetTextBuf(buf);
                }
        for(int i=0;i<l;i++)
                if ( buf[i]=='1' ) BinByte |= (1<<(l-i-1));
                else
                if ( buf[i]=='0' ) ;
                else {
                        buf[i]='\0';
                        Memo1->SetTextBuf(buf);
                        break;
                        }


        if ( l==8 ) Form1->Button1->Enabled=true;
        else        Form1->Button1->Enabled=false;


        sprintf(bb,"Bin: ");
        for(int i=0;i<8;i++) {
                sprintf(tmp,"%c", buf[i]); strcat( bb, tmp );
                }
        sprintf(tmp,"\n"); strcat( bb, tmp );
        }

Label3->Caption=bb;
}
//---------------------------------------------------------------------------


void __fastcall TForm1::USBTerminal1Click(TObject *Sender)
{
Application->MessageBox("\
USB Terminal was developed by Scideco\n\
for Dilab_1 board\n\n\
Date 9/10/07  version 3.0","About",MB_OK);
}
//---------------------------------------------------------------------------

