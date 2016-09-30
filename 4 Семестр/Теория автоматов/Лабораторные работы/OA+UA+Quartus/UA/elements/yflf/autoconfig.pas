unit autoconfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label2: TLabel;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure stgr;
    procedure autosize(sgrid:TStringGrid; column: integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  clock:array of string[10];
  clkcount:byte;

implementation
  uses SDIMAIN;
{$R *.dfm}

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
const Digit: Set of Char=['0' .. '9'];
begin
    if not (Key in Digit) then begin
 Key:=#0; beep; end;
end;

procedure TForm2.Edit2KeyPress(Sender: TObject; var Key: Char);
const Digit: Set of Char=['0' .. '9','x',';'];
      digiton: set of char=['0'..'9'];
var p:string;
begin
       p:=edit2.Text;
       if (p<>'') and (p[length(p)]='x') then begin
          if (not (key in digiton)) and (key<>#8) then key:=#0; end
       else
      if (not (Key in Digit)) and (key<>#8) then begin
 Key:=#0; beep; end;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
     close;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var i,t:integer; p,st:ansistring;  sg:TStringGrid;
begin
     p:=edit2.Text;
     if edit1.Text='0' then begin
     MessageDlg('Введите кол-во тактов',mtWarning,[mbOK],0);
     exit; end
     else
     if edit2.Text='' then begin
     MessageDlg('Укажите входные сигналы',mtWarning,[mbOK],0);
     exit; end
     else
     if p[length(p)]<>';' then begin
     MessageDlg('Поставьте в конце строки ";" для завершения',mtWarning,[mbOK],0);
     exit; end
     else
     begin
           if (findcomponent('sg1') is TStringGrid) then
           (findcomponent('sg1') as TStringGrid).Destroy;
           bitbtn1.Enabled:=false; bitbtn2.Enabled:=false;
           SDIAppForm.BitBtn2.Enabled:=false;
           SDIAppForm.Edit1.Enabled:=false;
           clkcount:=strtoint(edit1.Text);
           setlength(clock,clkcount);
           t:=1; st:=edit2.Text;
           for i:=0 to clkcount-1 do begin
              p:='';
              while st[t]<>';' do begin
                  p:=p+st[t];
                  inc(t);
              end;
              clock[i]:=p; inc(t);
           end;
     end;
SDIAppForm.statusbar.SimpleText:='Пожалуйста, подождите...';
screen.Cursor:=crAppStart;
SDIAppForm.statusbar.Color:=clRed;
SDIAppForm.auto;
SDIAppForm.loading;
stgr;
end;

procedure TForm2.stgr;
var sg:TStringGrid; i,j,t,dc:integer; sgstr,sgstr2,sgs:string;
begin
     sg:=TStringgrid.Create(self);
     sg.Parent:=Form2;
     sg.Name:='sg1';
     sg.Height:=200;
     sg.Width:=form2.Width-20;
     form2.Height:=form2.Height+210;
     sg.Top:=144;
     sg.Left:=8;
     sg.ColCount:=6;
     sg.RowCount:=2;
     sg.Options:=SG.Options+[goRowSelect];
     sg.Cells[0,0]:='Tакт';
     sg.FixedCols:=0;
     sg.FixedRows:=1;
     sg.Cells[1,0]:='X';
     sg.Cells[2,0]:='Y';
     sg.Cells[5,0]:='A';
     sg.Cells[3,0]:='Вх ЭП';
     sg.Cells[4,0]:='Вых ЭП';
     for i:=0 to clkcount-1 do begin
         clk:=i+1;
         SDIAppForm.readdiag;
         sg.RowCount:=sg.RowCount+1;
         sg.Cells[0,i+1]:=inttostr(i+1);
         sg.Cells[1,i+1]:=clock[i];
         sgstr:='';
         for j:=0 to ycount-1 do
            if (SDIAppForm.findcomponent('Led'+inttostr(j)+'z') as Tlabel).Font.Color=clRed then
                    sgstr:=sgstr+'y'+inttostr(j);
         sg.Cells[2,i+1]:=sgstr;
         sgstr:='';  sgstr2:='';
         for j:=0 to length(el)-1 do begin
            if pos('ct',el[j].name)>0 then begin
              for t:=0 to strtoint(size) do
                  if (SDIAppForm.findcomponent('out'+inttostr(t)) as Tlabel).Font.Color=clRed then
                      sgstr:=sgstr+'out'+inttostr(t);
              for t:=0 to length(el[j].inp)-1 do
                  if (SDIAppForm.findcomponent('ct'+inttostr(t)) as TLabel).Font.Color=clRed then
                      sgstr2:=sgstr2+'ct'+inttostr(t);
            end
            else
            if pos('rg',el[j].name)>0 then begin
              for t:=0 to length(el[j].inp)-1 do
              if (SDIAppForm.findcomponent('rg'+inttostr(t)) as TLabel).Font.Color=clRed then
                      sgstr2:=sgstr2+'rg'+inttostr(t);
            end
            else
            if pos('out',el[j].outp[0].outs)>0 then begin
                sgs:=el[j].outp[0].outs;
                delete(sgs,pos('(',sgs),1); delete(sgs,pos(')',sgs),1);
                if (SDIAppForm.findcomponent(sgs) as Tlabel).Font.Color=clRed then
                      sgstr:=sgstr+sgs;
                sgs:=el[j].inp[0].ins;
                delete(sgs,pos('(',sgs),1); delete(sgs,pos(')',sgs),1);
                if (SDIAppForm.findcomponent(sgs) is Tlabel) and
                ((SDIAppForm.findcomponent(sgs) as Tlabel).Font.Color=clRed) then
                      sgstr2:=sgstr2+sgs
                else if el[j].lab.Font.Color=clRed then sgstr2:=sgstr2+sgs;
            end;
            if pos('dc',el[j].name)>0 then dc:=j;
         end;
         sg.Cells[4,i+1]:=sgstr; sg.Cells[3,i+1]:=sgstr2;
         sgstr:=''; sgstr2:='';
         for t:=0 to length(el[dc].outp)-1 do
              if (SDIAppForm.findcomponent('a'+inttostr(t)) as Tlabel).Font.Color=clRed then
                    sgstr:=sgstr+'a'+inttostr(t);
         sg.Cells[5,i+1]:=sgstr;
         for t:=1 to sg.ColCount-1 do autosize(sg,t);
     end;
SDIAppForm.BitBtn2.Enabled:=true;
bitbtn1.Enabled:=true; bitbtn2.Enabled:=true;  SDIAppForm.Edit1.Enabled:=true;
end;

procedure TForm2.autosize(sgrid: TStringGrid; column: integer);
var temp,max,i: integer;
begin  
  max := 0;   
  for i := 0 to (sGrid.RowCount - 1) do
    begin  
      temp := sGrid.Canvas.TextWidth(sgrid.cells[column, i]);
      if temp > max then max := temp;   
    end;   
  sGrid.ColWidths[column] := Max + sGrid.GridLineWidth + 3;   
end;  

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if (findcomponent('sg1') is TStringgrid) then
        (findcomponent('sg1') as TStringgrid).Destroy;
     form2.Height:=176;
end;

end.
