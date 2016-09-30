//---------------------------------------------------------------------------

#ifndef D2xxH
#define D2xxH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <Mask.hpp>
#include <ExtCtrls.hpp>
#include "FTD2XX.h"
#include <Menus.hpp>
#include <ActnList.hpp>
//---------------------------------------------------------------------------
class TForm1 : public TForm
{
__published:	// IDE-managed Components
        TMemo *Memo1;
        TLabel *Label1;
        TLabel *Label2;
        TButton *Button1;
        TButton *Button2;
        TButton *Button3;
        TCheckBox *CheckBox1;
        TComboBox *ComboBox6;
        TMainMenu *MainMenu1;
        TMenuItem *N1;
        TMenuItem *N2;
        TMenuItem *N3;
        TMenuItem *N4;
        TMenuItem *N11;
        TMenuItem *N21;
        TMenuItem *N31;
        TMenuItem *N41;
        TListBox *ListBox1;
        TLabel *Label11;
        TCheckBox *CheckBox2;
        TCheckBox *CheckBox3;
        TCheckBox *CheckBox4;
        TLabel *Label3;
        TMenuItem *Help1;
        TMenuItem *USBTerminal1;

        void __fastcall CreateForm(TObject *Sender);
        void __fastcall Button1Click(TObject *Sender);
        void __fastcall OnClose(TObject *Sender, TCloseAction &Action);
        void __fastcall Button2Click(TObject *Sender);
        void __fastcall Button3Click(TObject *Sender);
        void __fastcall Memo1Change(TObject *Sender);
        void __fastcall OnNumCicleChange(TObject *Sender);
        void __fastcall N4Click(TObject *Sender);
        void __fastcall N2Click(TObject *Sender);
        void __fastcall N11Click(TObject *Sender);
        void __fastcall N21Click(TObject *Sender);
        void __fastcall N31Click(TObject *Sender);
        void __fastcall N41Click(TObject *Sender);
        void __fastcall CheckBox1Click(TObject *Sender);
        void __fastcall CheckBox2Click(TObject *Sender);
        void __fastcall CheckBox3Click(TObject *Sender);
        void __fastcall CheckBox4Click(TObject *Sender);
        void __fastcall USBTerminal1Click(TObject *Sender);

private:	// User declarations
public:		// User declarations
        __fastcall TForm1(TComponent* Owner);
        int InitPort(int nDev);
        int ThreadStart();

        int List1Num, WriteFlag, NumDev,NumCicle;
        HANDLE hThread;
        DWORD ThExitCode;
        FT_HANDLE hPort;
        int mode;
//        int SendChar(char Letter);
};
//---------------------------------------------------------------------------
extern PACKAGE TForm1 *Form1;
//---------------------------------------------------------------------------
#endif
