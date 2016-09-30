//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop

#include "D2xx.h"
#include "Func.h"
#include <stdio.h>
#include <math.h>
#include <sys/types.h>
#include <sys/timeb.h>
#include <string.h>

//---------------------------------------------------------------------------
#pragma package(smart_init)

//***************** поиск присоединённых устройств
int SearchDevices(TMenuItem ** DevList, char ** BufPtrs)
{
FT_STATUS ftStatus;
DWORD numDev;

if (Form1->hPort!=NULL)
        {FT_Close(Form1->hPort); Form1->hPort=NULL;}
EnDis(false);

// -- удаление из списка старых устройств
for (int i=0;i<4;i++)
        {
        (DevList[i])->Enabled=false;
        }
(DevList[0])->Caption="Device 1";
(DevList[1])->Caption="Device 2";
(DevList[2])->Caption="Device 3";
(DevList[3])->Caption="Device 4";

ftStatus = FT_ListDevices(BufPtrs,&numDev,FT_LIST_ALL|FT_OPEN_BY_DESCRIPTION);        // поиск устройств по описанию
if (FT_SUCCESS(ftStatus))
        {
        if (numDev>4)
                {return 0;  }
        for (int i=0;i<(int)numDev;i++)
                {
                (DevList[i])->Caption=BufPtrs[i];
                (DevList[i])->Enabled=true;
                }
        }
else
        {
        return 0;
        }

return 1;
}
//---------------------------------------------------------------------------
//************ доступность некоторых элементов в зависимости, открыть порт или нет
int EnDis(bool tmp)
{
Form1->Button1->Enabled=tmp;
Form1->CheckBox1->Enabled=tmp;
Form1->Label11->Enabled=tmp;

Form1->CheckBox2->Enabled=tmp;
Form1->CheckBox3->Enabled=tmp;
Form1->CheckBox4->Enabled=tmp;
return 1;
}

//---------------------------------------------------------------------------
//----------- запись в порт
int WritePort(char * mes, int len, int zikl,long *Time)
{
DWORD numin,dwRx=0,dwTx=0,dwEvent;
FT_STATUS ftStatus;
int err=1, i=0;

LARGE_INTEGER PerformanceCount1,PerformanceCount2, freq;
LONGLONG res;
double T, period;

QueryPerformanceFrequency(&freq);
T=(double)1/(freq.QuadPart);

QueryPerformanceCounter(&PerformanceCount1);
while (i<zikl)
{
ftStatus=FT_GetStatus(Form1->hPort,&dwRx,&dwTx,&dwEvent);
if (ftStatus!=FT_OK)
        {
        // ошибка
        }

if ((4096-dwTx)>=(DWORD)len)       // запись, если в выходном буфере есть место
        {
                ftStatus=FT_Write(
                Form1->hPort,
                mes,
                len,
                &numin);
                if (ftStatus==FT_OK)
                        {
                        // всё нормально
                        }
                else
                        {//ошибка при посылке
                        err=0;        // ставим флаг о том, что произошла ошибка
                        }
        i++;
        }
}
QueryPerformanceCounter(&PerformanceCount2);
res=PerformanceCount2.QuadPart-PerformanceCount1.QuadPart;
period=T*(res-5);
*Time=(long)(period*1000000); //подсчёт времени записи в выходной буфер

return err;
}
//---------------------------------------------------------------------------

