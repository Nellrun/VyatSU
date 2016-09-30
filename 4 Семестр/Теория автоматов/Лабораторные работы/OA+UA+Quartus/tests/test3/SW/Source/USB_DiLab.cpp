//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
USERES("USB_DiLab.res");
USEFORM("D2xx.cpp", Form1);
USELIB("Ftd2xx.lib");
USEUNIT("Func.cpp");
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
        try
        {
                 Application->Initialize();
                 Application->Title = "USB DiLab 1 Board ";
                 Application->CreateForm(__classid(TForm1), &Form1);
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
