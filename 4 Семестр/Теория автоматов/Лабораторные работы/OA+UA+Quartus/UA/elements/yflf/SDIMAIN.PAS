unit SDIMAIN;

interface

uses Windows, Classes, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, StdActns,
  ActnList, ToolWin, strUtils, SysUtils, Grids, Messages, ShellApi;

type
inputs=record  //входы элементов
ins:string[20];
size:integer;
end;
//--------------------
outputs=record  //выходы элементов
outs:string[20]; //названия выходов
size:integer; //координаты Label
end;
//----------------------
elem=record   //элементы схемы
img:Timage;  //изображение
lab:TLabel; //отображение значения импульса
name:string[20]; //наименование элемента
count:byte; //какой по счету в схеме элемент из числа себе подобных
inp:array of inputs; //входы
outp:array of outputs; //выходы
id:integer; //идентификатор элемента в схеме 
end;
//---------------
  TSDIAppForm = class(TForm)
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    HelpAbout1: TAction;
    StatusBar: TStatusBar;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileOpenItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    Edit1: TMenuItem;
    PasteItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    Shape1: TShape;
    Image1: TImage;
    Shape2: TShape;
    Panel1: TPanel;
    Label5: TLabel;
    Shape3: TShape;
    Label6: TLabel;
    Shape4: TShape;
    SW0: TLabel;
    Shape5: TShape;
    SW0z: TLabel;
    SW1: TLabel;
    SW2: TLabel;
    SW3: TLabel;
    SW4: TLabel;
    SW5: TLabel;
    SW6: TLabel;
    SW7: TLabel;
    SW1z: TLabel;
    Shape6: TShape;
    SW2z: TLabel;
    Shape7: TShape;
    SW3z: TLabel;
    Shape8: TShape;
    SW4z: TLabel;
    Shape9: TShape;
    SW5z: TLabel;
    Shape10: TShape;
    SW6z: TLabel;
    Shape11: TShape;
    SW7z: TLabel;
    Shsw7: TShape;
    N2: TMenuItem;
    N3: TMenuItem;
    Led0: TLabel;
    Led1: TLabel;
    Led2: TLabel;
    Led3: TLabel;
    Led4: TLabel;
    Led5: TLabel;
    Led6: TLabel;
    Led7: TLabel;
    Shape14: TShape;
    Shape13: TShape;
    Shape15: TShape;
    Led0z: TLabel;
    Led1z: TLabel;
    Led2z: TLabel;
    Shape16: TShape;
    Led3z: TLabel;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Led4z: TLabel;
    Led5z: TLabel;
    Led6z: TLabel;
    Shape20: TShape;
    Led7z: TLabel;
    Shled7: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    Shape25: TShape;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button6: TButton;
    ScrollBox1: TScrollBox;
    Action1: TAction;
    Button5: TButton;
    BitBtn1: TBitBtn;
    PaintBox1: TPaintBox;
    BitBtn2: TBitBtn;
    Shape12: TShape;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    N5: TMenuItem;
    Quartus1: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    Label1: TLabel;
    function Findj(s: string): hWnd;
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FileSave1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Find(Sender: TObject);
    procedure drawimg(name:string; x,y,index,ins:integer);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ChangeLabel(Sender:TObject);
    procedure Button6Click(Sender: TObject);
    procedure readdiag;
    procedure elemmemo(ch:char; sum,c,l0,l1:real; fd:TStringList; kol:string; var ii:integer);
    procedure Button5Click(Sender: TObject);
    function otstup(elemname,iname:string; prior:integer): integer;
    procedure FileCopy(const SourceFileName, TargetFileName: string);
    procedure BitBtn1Click(Sender: TObject);
    procedure drawlines(inames:string; elind:integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure auto;
    procedure pict(id,idy,idx:integer; n:string);
    procedure BitBtn2Click(Sender: TObject);
    procedure ClockWork(fi:TStringlist);
    procedure loading;
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure menucom(ch,param:integer);
    procedure N8Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Quartus1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
  private
    procedure WMHotKey(var Message: TMessage); message WM_HOTKEY;
  public
    { Public declarations }
  end;

var
  SDIAppForm: TSDIAppForm;
  startcl:TColor;
  n,curr,ind,isize,osize,cur,cu:integer;
  cou,xcount,ycount,imm,mclk:byte;
  clk:real; level:array[0..1] of real;
  miss:array of integer;
  el:array of Elem;
  elements,fs,ff,con,command:TStrings;
  fn,fn2,fn3,xpos,ypos,pic,size,proj:string;
  prev:TPoint;

implementation

uses about, autoconfig;

{$R *.dfm}
procedure TSDIAppForm.WMHotKey(var Message: TMessage);   
begin
if button2.Enabled then button2click(SDIAppForm);
end;

function TSDIAppForm.Findj(s: string): hWnd; //поиск дескриптора окна по неполному тексту заголовка окна
var
 Wnd:hWnd;
 buff:array[0..127] of Char;
begin
 Findj:=0;
 Wnd:=GetWindow(Handle, gw_HWndFirst);
 while Wnd<>0 do
 begin
   if (Wnd<>application.Handle) and IsWindowVisible(Wnd) and
     (GetWindow(Wnd,gw_Owner)=0) and
     (GetWindowText(Wnd,buff,sizeof(buff))<>0) then
   begin
     GetWindowText(Wnd,buff,sizeof(buff));
     if pos(s,StrPas(buff))>0 then
     begin
       Findj:=Wnd;
       Break;
     end;
   end;
   Wnd:=GetWindow(Wnd,gw_hWndNext);
 end;
end;

procedure TSDIAppForm.FileNew1Execute(Sender: TObject);
begin
  { Do nothing }
end;

procedure TSDIAppForm.FileOpen1Execute(Sender: TObject);
var str,p:ansistring;
    t,i,j:integer;
    la,la1:TLabel;
    sh:TShape;
begin
  if OpenDialog.Execute then
  begin
  clk:=0; //очищаем поле от элементов предыдущего проекта
    for i:=xcount-1 downto 8 do begin //оставляем кол-во SW по умолчанию
    (findcomponent('SW'+inttostr(i)) as TLabel).Destroy;
    (findcomponent('SW'+inttostr(i)+'z') as TLabel).Destroy;
    (findcomponent('Shsw'+inttostr(i)) as TShape).Destroy;
    shape1.Height:=shape1.Height-24;
    end;
    for i:=ycount-1 downto 8 do begin //оставляем кол-во Led по умолчанию
    (findcomponent('Led'+inttostr(i)) as TLabel).Destroy;
    (findcomponent('Led'+inttostr(i)+'z') as TLabel).Destroy;
    (findcomponent('Shled'+inttostr(i)) as TShape).Destroy;
    shape14.Height:=shape14.Height-24;
    end;
    for i:=0 to length(el)-1 do  begin  //удаляем элементы
       el[i].img.Destroy;
       for j:=0 to length(el[i].inp)-1 do //удаляем входы элементов
        if (pos('k(',el[i].inp[j].ins)>0) or (pos('s(',el[i].inp[j].ins)>0) or
        (pos('ct(',el[i].Inp[j].ins)>0) or (pos('rg(',el[i].Inp[j].ins)>0)then
        begin
          str:=el[i].inp[j].ins;
          delete(str,pos('(',str),1); 
          delete(str,pos(')',str),1);
          if (findcomponent(str) is TLabel) then //находим и удаляем Label с таким именем
          (findcomponent(str) as TLabel).Destroy; end
        else el[i].lab.Destroy;
       for j:=0 to length(el[i].outp)-1 do  //аналогично с выходами
        if (pos('FF',el[i].name)>0) or (pos('dc',el[i].name)>0) or
        (pos('rg',el[i].name)>0) then begin
           str:=el[i].outp[j].outs;
          delete(str,pos('(',str),1);
          delete(str,pos(')',str),1);
          if (findcomponent(str) is TLabel) then
          (findcomponent(str) as TLabel).Destroy; end
        else
        if pos('ct',el[i].name)>0 then begin
           for t:=0 to strtoint(size) do
           if (findcomponent('out'+inttostr(t)) is TLabel) then
          (findcomponent('out'+inttostr(t)) as TLabel).Destroy; end;
    end;
    prev.X:=image1.Left+image1.Width; prev.Y:=image1.Top+20;
    fn:=opendialog.filename; //сохраняем путь к файлу
    groupbox2.Enabled:=true; bitbtn2.Enabled:=true;
    button4.Enabled:=true;  Quartus1.Enabled:=true; 
    button6.Enabled:=true;  N7.Enabled:=true;  Edit1.Enabled:=true;
    button3.Enabled:=true;  N6.Enabled:=true;
    proj:=fn; delete(proj,length(proj)-2,3); proj:=proj+'qpf';
    pic:=fn;  delete(pic,length(pic)-2,3);   pic:=pic+'jpg';
    if fileexists(pic) then  //для открытия изображения схемы
         button5.Enabled:=true
    else begin
        delete(pic,length(pic)-2,3); pic:=pic+'bmp';
        if fileexists(pic) then button5.Enabled:=true
        else button5.Enabled:=false;
    end;
    fn2:=fn; delete(fn2,length(fn2)-2,3); fn2:=fn2+'vhd';
    fn3:=fn; delete(fn3,length(fn3)-2,3); fn3:=fn3+'vwf';
  if (curr>0) and (n>1) then begin curr:=0; n:=1; el:=nil; end;
  find(sender);   //просмотр файла, поиск элементов
  imm:=5; cou:=0;  
  for i:=0 to length(el)-1 do drawlines(el[i].name,i); //прорисовка линий
  SDIAppForm.Visible:=false; SDIAppForm.Visible:=true;
  imm:=5; cou:=0; t:=7; p:='';
  str:=xpos;  //нашли кол-во входных сигналов
  repeat
        p:=p+str[pos('VECTOR(',str)+t];
        inc(t);
  until str[pos('VECTOR(',str)+t]=' ';
  xcount:=strtoint(p)+1;
  t:=7; p:='';
  str:=ypos; //нашли кол-во выходных сигналов
  repeat
        p:=p+str[pos('VECTOR(',str)+t];
        inc(t);
  until str[pos('VECTOR(',str)+t]=' ';
  ycount:=strtoint(p)+1;
  for i:=8 to xcount-1 do begin  //создание дополнит вх сигналов
      la1:=TLabel.Create(SDIAppForm);
      la1.Parent:=ScrollBox1;
      la1.Name:='SW'+inttostr(i);
      la1.Top:=(findcomponent('SW'+inttostr(i-1)) as TLabel).Top+(findcomponent('SW'+inttostr(i-1)) as TLabel).Height+8;
      la1.Left:=(findcomponent('SW'+inttostr(i-1)) as TLabel).Left;
      la1.Caption:='sw'+inttostr(i)+'(x'+inttostr(i)+')';
      la:=TLabel.Create(SDIAppForm);
      la.Parent:=ScrollBox1;
      la.Name:='SW'+inttostr(i)+'z';
      la.Top:=(findcomponent('SW'+inttostr(i-1)+'z') as TLabel).Top+(findcomponent('SW'+inttostr(i-1)+'z') as TLabel).Height+8;
      la.Left:=(findcomponent('SW'+inttostr(i-1)+'z') as TLabel).Left;
      la.Caption:='0';
      la.OnClick:=ChangeLabel;
      sh:=TShape.Create(SDIAppForm);
      sh.Parent:=ScrollBox1;
      sh.Brush.Color:=clBlack;
      sh.Height:=3;
      sh.Width:=20;
      sh.Left:=(findcomponent('Shsw'+inttostr(i-1)) as TShape).Left;
      sh.Top:=la.Top+la.Height;
      sh.name:='Shsw'+inttostr(i);
      shape1.Height:=shape1.Height+24;
      end;
    for i:=8 to ycount-1 do begin //создание дополнит вых сигналов
      la1:=TLabel.Create(SDIAppForm);
      la1.Parent:=ScrollBox1;
      la1.Name:='Led'+inttostr(i);
      la1.Top:=(findcomponent('Led'+inttostr(i-1)) as TLabel).Top+24;
      la1.Left:=(findcomponent('Led'+inttostr(i-1)) as TLabel).Left;
      la1.Caption:='Led'+inttostr(i)+'(y'+inttostr(i)+')';
      la:=TLabel.Create(SDIAppForm);
      la.Parent:=ScrollBox1;
      la.Name:='Led'+inttostr(i)+'z';
      la.Top:=(findcomponent('Led'+inttostr(i-1)+'z') as TLabel).Top+24;
      la.Left:=(findcomponent('Led'+inttostr(i-1)+'z') as TLabel).Left;
      la.Caption:='0';
      sh:=TShape.Create(SDIAppForm);
      sh.Parent:=ScrollBox1;
      sh.Brush.Color:=clBlack;
      sh.Height:=3; sh.Width:=20;
      sh.Left:=(findcomponent('Shled'+inttostr(i-1)) as TShape).Left;
      sh.Top:=la.Top+la.Height;
      sh.name:='Shled'+inttostr(i);
      shape14.Height:=shape14.Height+24;
      end;
    end;
end;

procedure TSDIAppForm.FileSave1Execute(Sender: TObject);
begin
  SaveDialog.Execute;
end;

procedure TSDIAppForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TSDIAppForm.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

procedure TSDIAppForm.Find(Sender: TObject);
var hay,h:ansistring;
    i,j,m,k,t:integer;
    nstr,io:string;
    cd:string[1];
    coord:array[1..2] of integer;
begin
ff:=TStringlist.Create; fs:=TStringlist.Create;
ff.LoadFromFile(fn2);   fs.LoadFromFile(fn);
for i:=20 to fs.Count-1 do
begin
      h:=fs.Strings[i-1]; //предыдущая строка
      hay:=fs.Strings[i]; //текущая строка
      j:=0;
      while j<elements.Count do
      begin
          if pos('(text "'+elements.Names[j],hay)<>0 then
          begin  //ищем имя элемента в списке существующих и, если найден, то запоминаем его имя
              nstr:=copy(hay,pos('(text "'+elements.Names[j],hay)+7,length(elements.Names[j]));
              if pos('(rect ',h)<>0 then  //координаты
              begin
                    m:=6;
                    for k:=1 to 2 do begin   //заносим в массив координаты точек
                      io:='';
                      cd:=copy(h,pos('(rect ',h)+m,1);
                      while cd<>' ' do
                      begin
                            io:=io+cd;
                            inc(m);
                            cd:=copy(h,pos('(rect ',h)+m,1); //значения из поля (rect
                      end;
                      coord[k]:=strtoint(io);  //запомнили координаты лев верх точки
                      inc(m);
                    end;
              end;
              if pos('(text "UAinst',fs.Strings[i+1])<>0 then  //запоминаем идентификатор элемента в схеме
              begin
                    io:='';
                    if fs.Strings[i+1][pos('(text "UAinst',fs.Strings[i+1])+13]='"' then k:=0
                    else begin
                              t:=13;  //читаем символы после слова inst
                              while fs.Strings[i+1][pos('(text "UAinst',fs.Strings[i+1])+t]<>'"' do
                              begin
                                    io:=io+fs.Strings[i+1][pos('(text "UAinst',fs.Strings[i+1])+t];
                                    inc(t);
                              end;
                              k:=strtoint(io);  //запомнили идентификатор элемента в схеме
                         end;
              drawimg(nstr,coord[1],coord[2],j,k); //создание экземпляра объекта
              end;
              j:=elements.Count; //заканчиваем сравнение со списком, переход к след строке
          end
          else inc(j);
      end;
end;
end;

procedure TSDIAppForm.FormClose(Sender:TObject; var Action:TCloseAction);
begin
 el:=nil; elements.Free; ff.Free; fs.Free; //очищаем память
end;

procedure TSDIAppForm.FormCreate(Sender: TObject);
var i:integer;
begin
DoubleBuffered:=true; startcl:=paintbox1.Color;
button5.Enabled:=false;  N7.Enabled:=false;       N6.Enabled:=false;
button4.Enabled:=false;  button6.Enabled:=false;  button3.Enabled:=false;
button2.Enabled:=false;  bitbtn2.Enabled:=false;  Quartus1.Enabled:=false;
N4.Enabled:=false;       groupbox2.Enabled:=false; Edit1.Enabled:=false;
Application.HelpFile:=ExtractFilePath(Application.ExeName) + 'Руководство пользователя.hlp';
xpos:=''; ypos:='';
curr:=0; n:=1; xcount:=8; ycount:=8;
for i:=0 to 7 do
(findcomponent('SW'+inttostr(i)) as TLabel).OnClick:=ChangeLabel;
elements:=TStringlist.Create;
elements.Add(Format('%s=%s',['TFF',ExtractFilepath(paramstr(0))+'Pict\Trig16.bmp']));
elements.Add(Format('%s=%s',['JKFF',ExtractFilepath(paramstr(0))+'Pict\Trig12.bmp']));
elements.Add(Format('%s=%s',['DFF',ExtractFilepath(paramstr(0))+'Pict\Trig8.bmp']));
elements.Add(Format('%s=%s',['SRFF',ExtractFilepath(paramstr(0))+'Pict\Trig4.bmp']));
elements.Add(Format('%s=%s',['dc2',ExtractFilepath(paramstr(0))+'Pict\DC2.bmp']));
elements.Add(Format('%s=%s',['dc3',ExtractFilepath(paramstr(0))+'Pict\DC3.bmp']));
elements.Add(Format('%s=%s',['dc4',ExtractFilepath(paramstr(0))+'Pict\DC4.bmp']));
elements.Add(Format('%s=%s',['74198',ExtractFilepath(paramstr(0))+'Pict\rg8.bmp']));
elements.Add(Format('%s=%s',['ct4pm',ExtractFilepath(paramstr(0))+'Pict\CT4pm.bmp']));
elements.Add(Format('%s=%s',['ct4',ExtractFilepath(paramstr(0))+'Pict\CT4p.bmp']));
elements.Add(Format('%s=%s',['ct3pm',ExtractFilepath(paramstr(0))+'Pict\CT3pm.bmp']));
elements.Add(Format('%s=%s',['ct3',ExtractFilepath(paramstr(0))+'Pict\CT3p.bmp']));
elements.Add(Format('%s=%s',['stff',ExtractFilepath(paramstr(0))+'Pict\Trig14.bmp']));
elements.Add(Format('%s=%s',['rstff',ExtractFilepath(paramstr(0))+'Pict\Trig13.bmp']));
elements.Add(Format('%s=%s',['rtff',ExtractFilepath(paramstr(0))+'Pict\Trig15.bmp']));
elements.Add(Format('%s=%s',['sdff',ExtractFilepath(paramstr(0))+'Pict\Trig6.bmp']));
elements.Add(Format('%s=%s',['rsdff',ExtractFilepath(paramstr(0))+'Pict\Trig5.bmp']));
elements.Add(Format('%s=%s',['rdff',ExtractFilepath(paramstr(0))+'Pict\Trig7.bmp']));
end;

procedure TSDIAppForm.drawimg(name: string; x,y,index,ins:integer);
label lset,linc;
var l,t,line,li,b,co,pr:integer;
    int,i,fl,dc,k,ct,rg:byte;
    st,str:ansistring;
    p,pnam,num:string[30];
    la:TLabel; achtung:boolean;
procedure dcrg;
var lli:integer;
begin
  for lli:=0 to length(el[curr].outp)-1 do begin
                 la:=TLabel.Create(SDIAppForm);
                  la.Parent:=ScrollBox1;
                  la.Top:=el[curr].outp[lli].size;
                  la.Left:=el[curr].img.Left+el[curr].img.Width+5;
                  str:=el[curr].outp[lli].outs;
                  delete(str,pos('(',str),1);
                  delete(str,pos(')',str),1);
                  la.Name:=str;
                  la.Caption:=el[curr].outp[lli].outs;
                  end;
end;
begin
setlength(el,n); isize:=1; osize:=1; cur:=0; cu:=0;
el[curr].img:=Timage.Create(SDIAppForm);
el[curr].img.Parent:=ScrollBox1;
pict(curr,y,x,name);
el[curr].lab:=TLabel.Create(SDIAppForm);
el[curr].lab.Parent:=ScrollBox1;
if elements.Names[index]='74198' then el[curr].name:='rg'
else el[curr].name:=elements.Names[index]; //тип элемента
fl:=pos('FF',el[curr].name); dc:=pos('dc',el[curr].name);
ct:=pos('ct',el[curr].name); rg:=pos('rg',el[curr].name);
el[curr].id:=ins;  //идентификатор
cou:=0;
if curr>0 then
    for i:=0 to n-2 do if el[i].name=el[curr].name then inc(cou); 
el[curr].count:=cou;   //какой по счету элемент в группе себе подобных
el[curr].lab.Transparent:=true;
el[curr].lab.Font.Size:=8;
if fl>0 then begin
  el[curr].lab.Left:=el[curr].img.Left-10;
  el[curr].lab.Top:=el[curr].img.Top+5;
end
else begin
  el[curr].lab.Left:=el[curr].img.Left+el[curr].img.width+5;
  el[curr].lab.Top:=el[curr].img.Top;  //значение на выходе
end;
l:=17;
while l<ff.Count do begin  //поиск имен входов и выходов
      st:=ff.Strings[l];
      if (pos('IF (RISING_EDGE',st)<>0) and (pos('FF',el[curr].name)<>0) then begin
         inc(l); st:=ff.Strings[l];
         if (pos('<=',st)<>0) and
         (pos('('+inttostr(el[curr].count)+')',st)<>0) and
         (pos('('+inttostr(el[curr].count)+')',st)<pos('<=',st)) then begin
            t:=pos(' <=',st)-1; p:='';
            while (st[t]<>' ') and (t>0) do begin
                  p:=p+st[t];
                  dec(t);
            end;
            setlength(el[curr].outp,osize);   //создаем массив выходов для триггеров
            el[curr].outp[cu].outs:=trim(ReverseString(p));
            el[curr].outp[cu].size:=1;
            inc(cu); inc(osize);
            t:=3; p:='';
            while st[pos('<= ',st)+t]<>';' do begin
                  p:=p+st[pos('<= ',st)+t];
                  inc(t);
            end;
            setlength(el[curr].inp,isize);   //создаем массив входов для триггеров
            el[curr].inp[cur].ins:=p;
            el[curr].inp[cur].size:=1;
            inc(cur); inc(isize);
         end
         else
         if (pos('END IF;',ff.Strings[l+1])<>0) and (pos('<=',ff.Strings[l+2])<>0) and
            (pos('('+inttostr(el[curr].count)+')',ff.Strings[l+2])<>0) then begin
                  t:=pos('<=',ff.Strings[l+2])-2; p:='';
                  while (ff.Strings[l+2][t]<>' ') and (t>0) do begin
                        p:=p+ff.Strings[l+2][t];
                        dec(t);
                  end;
                  setlength(el[curr].outp,osize);   //создаем массив выходов
                  el[curr].outp[cu].outs:=trim(ReverseString(p));
                  el[curr].outp[cu].size:=1;
                  inc(cu); inc(osize);
                  if pos(') :=',ff.strings[l])<>0 then begin
                      str:=ff.strings[l];
                      delete(str,pos('('+inttostr(el[curr].count)+')',str),3);
                      delete(str,pos('('+inttostr(el[curr].count)+')',str),3);
                      if pos('('+inttostr(el[curr].count)+')',str)>pos(':=',str) then
                        while pos('('+inttostr(el[curr].count)+')',str)>0 do begin
                          t:=pos('('+inttostr(el[curr].count)+')',str)-1; p:='';
                          p:=p+str[t];
                        setlength(el[curr].inp,isize);   //создаем массив входов
                        el[curr].inp[cur].ins:=p+'('+inttostr(el[curr].count)+')';
                        el[curr].inp[cur].size:=1;
                        inc(cur); inc(isize);
                        delete(str,posex('('+inttostr(el[curr].count)+')',str),3);
                        delete(str,posex('('+inttostr(el[curr].count)+')',str),3);
                        end;
                  end;
         end;
      end
      else begin
      if ins=0 then int:=pos('b2v_UAinst :',st)
      else int:=pos('b2v_UAinst'+inttostr(ins)+' :',st);
      if int<>0 then
      begin line:=l;
            inc(line);
            if pos('clock =>',ff.Strings[line])<>0 then inc(line);
            while pos('=> ',ff.Strings[line])<>0 do
            begin
                  if (pos('data',ff.Strings[line])<>0) or {(pos('updown',ff.Strings[line])<>0) or
                  (pos('sclr',ff.Strings[line])<>0) or (pos('cnt_en',ff.Strings[line])<>0)}
                  (pos(' ct',ff.Strings[line])<>0) or
                  (pos(' rg',ff.Strings[line])<>0) {or (pos('S',ff.Strings[line])<>0) or
                  (pos('sload',ff.Strings[line])<>0)} then
                  begin   //входы
                        t:=3; p:='';
                        repeat
                          p:=p+ff.Strings[line][pos('=> ',ff.Strings[line])+t];
                          inc(t);
                        until (ff.Strings[line][pos('=> ',ff.Strings[line])+t]=',') or
                        ((ff.Strings[line][pos('=> ',ff.Strings[line])+t]=')') and
                        (ff.Strings[line][pos('=> ',ff.Strings[line])+t+1]=';'));
                           //создаем массив входов
                        if pos('DOWNTO',p)>0 then begin
                            t:=1; pnam:='';
                            while p[t]<>'(' do begin
                                  pnam:=pnam+p[t];
                                  inc(t);
                            end;
                            pr:=0;
                            for k:=strtoint(p[pos(')',p)-1]) to strtoint(p[pos('(',p)+1]) do begin
                                setlength(el[curr].inp,isize);
                                el[curr].inp[cur].ins:=pnam+'('+inttostr(k)+')';
                                el[curr].inp[cur].size:=el[curr].img.Top-5+otstup(el[curr].name,ff.Strings[line],pr);
                                pr:=otstup(el[curr].name,ff.Strings[line],pr);
                                inc(cur); inc(isize); end;
                        end
                        else begin
                        setlength(el[curr].inp,isize);
                        el[curr].inp[cur].ins:=p;
                        el[curr].inp[cur].size:=el[curr].img.Top-5+otstup(el[curr].name,ff.Strings[line],0);
                        inc(cur); inc(isize); end;
                  end
                  else
                  if (pos('q ',ff.Strings[line])>0) or (pos('eq',ff.Strings[line])>0) or
                  (pos('result',ff.Strings[line])>0) or (pos('Q',ff.Strings[line])>0) then begin //выходы
                        t:=3; p:='';
                        if pos('eq',ff.Strings[line])>0 then achtung:=true
                        else achtung:=false;
                        repeat
                            p:=p+ff.Strings[line][pos('=> ',ff.Strings[line])+t];
                            inc(t);
                        until (ff.Strings[line][pos('=> ',ff.Strings[line])+t]=',') or
                        ((ff.Strings[line][pos('=> ',ff.Strings[line])+t]=')') and
                        (ff.Strings[line][pos('=> ',ff.Strings[line])+t+1]=';'));
                        if achtung then begin
                            if pos('a(',p)<>0 then goto lset
                            else goto linc;
                        end;
lset:                   setlength(el[curr].outp,osize);   //создаем массив выходов
                        el[curr].outp[cu].outs:=p;
                        if pos('(',el[curr].outp[cu].outs)<>0 then
                            el[curr].outp[cu].size:=el[curr].img.Top-5+otstup(el[curr].name,ff.Strings[line],0);
                        inc(cu); inc(osize);
                  end;
linc:             inc(line);
            end;
            l:=ff.Count; //для данного типа элемента работа закончена, можно выйти из цикла
      end
      else inc(l); end;
end;
line:=0;
while line<ff.Count do begin
        st:=ff.Strings[line];
        if (pos('xpin',st)>0) and (pos('STD_LOGIC',st)>0) then xpos:=st
        else
        if (pos('ypin',st)>0) and (pos('STD_LOGIC',st)>0) then ypos:=st
        else
        if (pos('outpin',st)>0) and (pos('STD_LOGIC',st)>0) then begin
            for b:=0 to length(el[curr].outp)-1 do
            if pos('out',el[curr].outp[b].outs)>0 then begin
              t:=8; p:='';
              while st[pos('_VECTOR(',st)+t]<>' ' do begin
                               p:=p+st[pos('_VECTOR(',st)+t];
                               inc(t);
              end;
              size:=p;
              break;
            end;
        end;
        if pos('ARCHITECTURE',st)>0 then line:=ff.Count;
inc(line);
end;
p:='';
if fl>0 then begin
    if length(el[curr].inp)=1 then p:='0'
    else
         for li:=0 to length(el[curr].inp)-1 do
         if (pos('k',el[curr].inp[li].ins)=0) and (pos('r',el[curr].inp[li].ins)=0) then begin
              p:='0';
              str:=el[curr].inp[li].ins;
              delete(str,pos('(',str),1); delete(str,pos(')',str),1);
              el[curr].lab.Name:=str;
              el[curr].lab.Hint:=str+'|'+str; el[curr].lab.ShowHint:=true; end
         else begin
                     la:=TLabel.Create(SDIAppForm);
                     la.Parent:=ScrollBox1;
                     la.Top:=el[curr].lab.Top+el[curr].lab.Height+5;
                     la.Left:=el[curr].lab.Left;
                     str:=el[curr].inp[1].ins;
                     delete(str,pos('(',str),1); delete(str,pos(')',str),1);
                     la.Name:=str; la.Caption:='0';
                     la.ShowHint:=true; la.Hint:=str+'|'+str;
         end;
    la:=TLabel.Create(SDIAppForm);
    la.Parent:=ScrollBox1;
    la.Top:=el[curr].lab.Top;
    la.Left:=el[curr].img.Left+el[curr].img.Width+5;
    str:=el[curr].outp[0].outs;
    delete(str,pos('(',str),1);
    delete(str,pos(')',str),1);
    la.Name:=str;
    la.Caption:='0';
    la.ShowHint:=true;
    la.Hint:=str+'|'+str;
end;
if dc>0 then dcrg;
if rg>0 then begin dcrg;
                  for li:=0 to length(el[curr].inp)-1 do
                  if pos('rg(',el[curr].inp[li].ins)>0 then begin
                  la:=TLabel.Create(SDIAppForm);
                  la.Parent:=ScrollBox1;
                  la.Top:=el[curr].inp[li].size;
                  la.Left:=el[curr].img.Left-10;
                  str:=el[curr].inp[li].ins;
                  delete(str,pos('(',str),1);
                  delete(str,pos(')',str),1);
                  la.Name:=str;
                  la.Caption:='0';
                  la.ShowHint:=true;
                  la.Hint:=str+'|'+str;
                  end;
end;
if ct>0 then begin
             for li:=0 to length(el[curr].inp)-1 do
             if pos('ct(',el[curr].inp[li].ins)>0 then begin
                  la:=TLabel.Create(SDIAppForm);
                  la.Parent:=ScrollBox1;
                  la.Top:=el[curr].inp[li].size;
                  la.Left:=el[curr].img.Left-10;
                  str:=el[curr].inp[li].ins;
                  delete(str,pos('(',str),1);
                  delete(str,pos(')',str),1);
                  la.Name:=str;
                  la.Caption:='0';
                  la.ShowHint:=true;
                  la.Hint:=str+'|'+str;
                  end;
             pr:=0;
              for li:=0 to strtoint(size) do begin
                  la:=TLabel.Create(SDIAppForm);
                  la.Parent:=ScrollBox1;
                  la.Top:=el[curr].img.Top-5+otstup(el[curr].name,'out',pr);
                  pr:=otstup(el[curr].name,'out',pr);
                  la.Left:=el[curr].img.Left+el[curr].img.Width;
                  la.Name:='out'+inttostr(li);
                  la.Caption:='0';
                  la.ShowHint:=true;
                  la.Hint:=la.Name+'|'+la.Name;
                  end;
end
else begin el[curr].lab.Caption:=p; el[curr].lab.ShowHint:=true;
      el[curr].lab.Hint:=el[curr].inp[0].ins+'|'+el[curr].inp[0].ins; end;
inc(n); inc(curr);
end;


procedure TSDIAppForm.Button2Click(Sender: TObject);
var i,j,t,missed:integer;
f:TStringList;
fl:real;
st,p:string;
begin
 clk:=clk+1;  missed:=0;
 f:=TStringList.Create;
if fileexists(fn3) then f.LoadFromFile(fn3)
else begin
          MessageDlg('Файл ' + fN+' не существует',mtError, [mbOk], 0); exit;
end;
button2.Enabled:=false; edit1.Enabled:=false;
CLockwork(f);
for j:=0 to xcount-1 do
    if (findcomponent('SW'+inttostr(j)+'z') as TLabel).Caption='1' then begin
        i:=10;
        while i<f.Count do begin
            st:=f.Strings[i];
            if pos('TRANSITION_LIST("xpin['+inttostr(j)+']")',st)>0 then begin
                inc(i,5); st:=f.Strings[i]; //переход на строку уровней
                fl:=0;
                while pos('}',st)=0 do begin  //пока не обработаны все строки показаний
                        p:='';
                        for t:=pos('FOR ',st)+4 to length(st)-1 do p:=p+st[t]; //сохр длительность сигнала
                        p:=stringreplace(p,'.',',',[rfReplaceAll]);
                        fl:=fl+strtofloat(p);  //складываем
                        inc(i);
                        st:=f.Strings[i]; //переход на след строку
                end; //while
                fl:=fl-strtofloat(p);
                if f.Strings[i-1][pos('LEVEL ',f.Strings[i-1])+6]='0' then
                begin
                    if pos('FOR 1000.0',f.Strings[i-1])>0 then begin
                      if (clk=1) and (pos('rg',el[0].name)=0) then p:=floattostr(level[0]-1.0)
                      else
                      if (clk=1) and (pos('rg',el[0].name)>0) then begin
                          clk:=clk+1;
                          p:=floattostr(clk*(level[0]+level[1])-level[1]-1.0); end
                      else p:=floattostr(clk*(level[0]+level[1])-level[1]-1.0);
                      fl:=fl+strtofloat(p);
                      if frac(level[0]-1.0)=0.0 then p:=p+'.0'
                      else p:=stringreplace(p,',','.',[rfReplaceAll]);
                      st:='LEVEL 0 FOR '+p+';';
                      for t:=1 to pos('LEVEL',f.Strings[i-1])-1 do st:=' '+st;
                      f.Strings[i-1]:=st;
                    end //if
                    else begin
                      p:=floattostr(level[1]*0.5+level[0]-1.0+miss[j]*(level[0]+level[1]));
                      fl:=fl+level[1]*0.5+level[0]-1.0+miss[j]*(level[0]+level[1]);
                      if frac(level[1]*0.5+level[0]-1.0+miss[j]*(level[0]+level[1]))=0.0 then p:=p+'.0'
                      else p:=stringreplace(p,',','.',[rfReplaceAll]);
                      st:='LEVEL 0 FOR '+p+';';
                      for t:=1 to pos('LEVEL',f.Strings[i-1])-1 do st:=' '+st;
                      f.Strings[i-1]:=st;
                    end; //else
                    p:=floattostr(1.0+level[1]*0.5);
                    fl:=fl+1.0+level[1]*0.5;
                    if frac(1.0+level[1]*0.5)=0.0 then p:=p+'.0'
                    else p:=stringreplace(p,',','.',[rfReplaceAll]);
                    st:='LEVEL 1 FOR '+p+';';
                    for t:=1 to pos('LEVEL',f.Strings[i-1])-1 do st:=' '+st;
                    f.Insert(i,st);
                    inc(i);
                    p:=floattostr(1000.0-fl);
                    if frac(1000.0-fl)=0.0 then p:=p+'.0'
                    else p:=stringreplace(p,',','.',[rfReplaceAll]);
                    st:='LEVEL 0 FOR '+p+';';
                    for t:=1 to pos('LEVEL',f.Strings[i-1])-1 do st:=' '+st;
                    f.Insert(i,st);
                end  //if
                else begin
                      p:=floattostr(1000.0-fl);
                      if frac(1000.0-fl)=0.0 then p:=p+'.0';
                      p:=stringreplace(p,',','.',[rfReplaceAll]);
                      st:='LEVEL 0 FOR '+p+';';
                      for t:=1 to pos('LEVEL',f.Strings[i-1])-1 do st:=' '+st;
                      f.Insert(i,st);
                end; //else
           i:=f.Count;
           f.SaveToFile(fn3);
           end; //if
           inc(i);
    end;//while
    miss[j]:=0;
    mclk:=0;
end //if
else begin inc(missed);  inc(miss[j]);
    if missed=xcount then inc(mclk);
end;
f.free;
statusbar.SimpleText:='Пожалуйста, подождите...';
screen.Cursor:=crAppStart;
statusbar.Color:=clRed;
menucom(10,1);
statusbar.SimpleText:='';
screen.Cursor:=crDefault;
statusbar.Color:=clBtnFace;
readdiag;
button2.Enabled:=true; edit1.Enabled:=true;
end;

procedure TSDIAppForm.Button3Click(Sender: TObject);
var i,ji:integer; p,fn3_:ansistring;
begin
if length(miss)>0 then miss:=nil;
setlength(miss,xcount);
clk:=0; mclk:=0; 
for i:=0 to xcount-1 do miss[i]:=0;
for i:=0 to xcount-1 do
    if (findcomponent('SW'+inttostr(i)+'z') as TLabel).Caption='1' then begin
         (findcomponent('SW'+inttostr(i)+'z') as TLabel).Caption:='0';
         (findcomponent('SW'+inttostr(i)+'z') as TLabel).Font.Color:=clBlack;
         (findcomponent('SW'+inttostr(i)) as TLabel).Font.Color:=clBlack;
    end;
for i:=0 to ycount-1 do
    if (findcomponent('Led'+inttostr(i)+'z') as TLabel).Caption='1' then begin
         (findcomponent('Led'+inttostr(i)+'z') as TLabel).Caption:='0';
         (findcomponent('Led'+inttostr(i)+'z') as TLabel).Font.Color:=clBlack;
         (findcomponent('Led'+inttostr(i)) as TLabel).Font.Color:=clBlack;
    end;
for i:=0 to length(el)-1 do begin
    if (pos('dc',el[i].name)>0) or (pos('rg',el[i].name)>0) then begin
    for ji:=0 to length(el[i].outp)-1 do
        if (findcomponent('a'+inttostr(ji)) as TLabel).Font.Color=clRed then
            (findcomponent('a'+inttostr(ji)) as TLabel).Font.Color:=clBlack;
    (findcomponent('a0') as TLabel).Font.Color:=clRed;
    end
    else
    if  pos('rg',el[i].name)>0 then begin
        for ji:=0 to length(el[i].inp)-1 do
            if (findcomponent('rg'+inttostr(ji)) as TLabel).Caption='1' then begin
            (findcomponent('rg'+inttostr(ji)) as TLabel).Font.Color:=clBlack;
            (findcomponent('rg'+inttostr(ji)) as TLabel).Caption:='0'; end;
    end
    else
    if pos('FF',el[i].name)>0 then begin
            p:=el[i].outp[0].outs;
            delete(p,pos('(',p),1);
            delete(p,pos(')',p),1);
            if (findcomponent(p) as TLabel).Caption='1' then begin
            (findcomponent(p) as TLabel).Font.Color:=clBlack;
            (findcomponent(p) as TLabel).Caption:='0'; end;
        for ji:=0 to length(el[i].inp)-1 do
            if (pos('r',el[i].inp[ji].ins)>0) or (pos('k',el[i].inp[ji].ins)>0) then
            begin
                 p:=el[i].inp[ji].ins; delete(p,pos('(',p),1); delete(p,pos(')',p),1);
                 if (findcomponent(p) as TLabel).Caption='1' then begin
            (findcomponent(p) as TLabel).Font.Color:=clBlack;
            (findcomponent(p) as TLabel).Caption:='0'; end;
            end
            else if el[i].lab.Caption='1' then begin
                 el[i].lab.Font.Color:=clBlack;
                 el[i].lab.Caption:='0';
            end;
    end
    else
    if pos('ct',el[i].name)>0 then begin
          for ji:=0 to length(el[i].outp)-1 do
            if (findcomponent('out'+inttostr(ji)) as TLabel).Caption='1' then begin
            (findcomponent('out'+inttostr(ji)) as TLabel).Font.Color:=clBlack;
            (findcomponent('out'+inttostr(ji)) as TLabel).Caption:='0'; end;
          for ji:=0 to length(el[i].inp)-1 do
            if (findcomponent('ct'+inttostr(ji)) as TLabel).Caption='1' then begin
            (findcomponent('ct'+inttostr(ji)) as TLabel).Font.Color:=clBlack;
            (findcomponent('ct'+inttostr(ji)) as TLabel).Caption:='0'; end;
    end
    else
    if el[i].lab.Caption='1' then begin el[i].lab.Font.Color:=clBlack;
    el[i].lab.Caption:='0'; end; end;
fn3_:=fn3;
delete(fn3_,length(fn3_)-3,4);
fn3_:=fn3_+'_.vwf';
FileCopy(fn3_ ,fn3);
end;

procedure TSDIAppForm.Button4Click(Sender: TObject);
var TheWindowHandle : THandle;
begin
   TheWindowHandle := Findj('Quartus II');
   if TheWindowHandle = 0 then begin
      ShellExecute(Handle,'Open','quartus.exe',PChar(proj),nil,SW_SHOWNORMAL);
   end
   else  menucom(0,0);
end;

procedure TSDIAppForm.ChangeLabel(Sender: TObject);
var  h,hj:string;  i:Integer;
procedure cap(Sender:TObject); //изменение значений входных сигналов
begin
     if (findcomponent('SW'+h+'z') as TLabel).Caption='0' then begin
                (findcomponent('SW'+h+'z') as TLabel).Caption:='1';
               with (Sender as TLabel) do Font.Color:=clRed;
                (findcomponent('SW'+h+'z') as TLabel).Font.Color:=clRed;
                end
         else begin
              (findcomponent('SW'+h+'z') as TLabel).Caption:='0';
              with (Sender as TLabel) do Font.Color:=clBlack;
              (findcomponent('SW'+h+'z') as TLabel).Font.Color:=clBlack;
         end;
end;
begin
      with (sender as TLabel) do
      begin
      hj:=Name;
      if pos('SW',Name)>0 then begin h:=''; //нашли заголовок вх сигнала
         for i:=3 to length(hj) do
         case hj[i] of      //ищем его номер
         '0'..'9': h:=h+hj[i];
         end;
         cap(Sender); //меняем значение на противоположное
      end;
      end;
end;

procedure TSDIAppForm.Button6Click(Sender: TObject);
begin
menucom(9,1);
end;

procedure TSDIAppForm.readdiag; //читаем файл диаграммы
label label1,label2,label3, label4, label5;
var f:TStringList;  i,t,stind,rip:Integer; st,p,pn:string;  fl:real;
begin
     f:=TStringList.Create;
     f.LoadFromFile(fn3);
     i:=0;
     while i<f.Count do begin
         st:=f.Strings[i];
         if pos('TRANSITION_LIST("ypin[',st)>0 then begin
             t:=pos('"ypin[',st)+6; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i]; rip:=0;
label3:      while (fl<=clk*(level[0]+level[1])) and (pos('}',st)=0) do begin
                if pos('LEVEL',st)>0 then begin
                    pn:='';
                    for t:=pos('FOR ',st)+4 to length(st)-1 do pn:=pn+st[t];
                    pn:=stringreplace(pn,'.',',',[rfReplaceAll]);
                    fl:=fl+strtofloat(pn);
                    if rip>0 then dec(rip);
                end
                else if pos('REPEAT',st)>0 then begin
                      stind:=i+1;
                      pn:='';
                      for t:=pos('= ',st)+2 to length(st)-1 do pn:=pn+st[t];
                      rip:=strtoint(pn);
                end;
                inc(i);
                st:=f.Strings[i];
             end;
             if (fl<=clk*(level[0]+level[1])) and (pos('LEVEL',f.Strings[i+1])>0) then
                begin
                if rip>0 then i:=stind else if rip=0 then inc(i);
                st:=f.Strings[i]; goto label3;
             end;
             dec(i); st:=f.Strings[i];
             if pos('LEVEL 1 FOR',st)>0 then begin
                if (findcomponent('Led'+p+'z') as TLabel).Caption='0' then begin
                 (findcomponent('Led'+p+'z') as TLabel).Caption:='1';
                 (findcomponent('Led'+p+'z') as TLabel).Font.Color:=clRed;
                 (findcomponent('Led'+p) as TLabel).Font.Color:=clRed;
                end;
             end
             else if pos('LEVEL 0 FOR',st)>0 then
                if (findcomponent('Led'+p+'z') as TLabel).Caption='1' then begin
                 (findcomponent('Led'+p+'z') as TLabel).Caption:='0';
                 (findcomponent('Led'+p+'z') as TLabel).Font.Color:=clBlack;
                 (findcomponent('Led'+p) as TLabel).Font.Color:=clBlack;
                end;
         end;
         if pos('TRANSITION_LIST("outpin[',st)>0 then begin
             t:=pos('"outpin[',st)+8; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i];  rip:=0;
label2:      while (fl<=clk*(level[0]+level[1])) and (pos('}',st)=0) do begin
                if pos('LEVEL',st)>0 then begin
                    pn:='';
                    for t:=pos('FOR ',st)+4 to length(st)-1 do pn:=pn+st[t];
                    pn:=stringreplace(pn,'.',',',[rfReplaceAll]);
                    fl:=fl+strtofloat(pn);
                    if rip>0 then dec(rip);
                end
                else if pos('REPEAT',st)>0 then begin
                      stind:=i+1;
                      pn:='';
                      for t:=pos('= ',st)+2 to length(st)-1 do pn:=pn+st[t];
                      rip:=strtoint(pn);
                end;
                inc(i);
                st:=f.Strings[i];
             end;
             if (fl<=clk*(level[0]+level[1])) and (pos('LEVEL',f.Strings[i+1])>0) then
                begin
                if rip>0 then i:=stind else if rip=0 then inc(i);
                st:=f.Strings[i]; goto label2;
             end;
             dec(i); st:=f.Strings[i];
             if pos('LEVEL 1 FOR',st)>0 then begin
                if (findcomponent('out'+p) as TLabel).Caption='0' then begin
                 (findcomponent('out'+p) as TLabel).Caption:='1';
                 (findcomponent('out'+p) as TLabel).Font.Color:=clRed;
                end;
             end
             else if pos('LEVEL 0 FOR',st)>0 then
                if (findcomponent('out'+p) as TLabel).Caption='1' then begin
                 (findcomponent('out'+p) as TLabel).Caption:='0';
                 (findcomponent('out'+p) as TLabel).Font.Color:=clBlack;
                end;
         end;
         if pos('TRANSITION_LIST("apin[',st)>0 then begin
             t:=pos('"apin[',st)+6; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i]; rip:=0;
label1:      while (fl<=clk*(level[0]+level[1])) and (pos('}',st)=0) do begin
                if pos('LEVEL',st)>0 then begin
                    pn:='';
                    for t:=pos('FOR ',st)+4 to length(st)-1 do pn:=pn+st[t];
                    pn:=stringreplace(pn,'.',',',[rfReplaceAll]);
                    fl:=fl+strtofloat(pn);
                    if rip>0 then dec(rip);
                end
                else if pos('REPEAT',st)>0 then begin
                      stind:=i+1;
                      pn:='';
                      for t:=pos('= ',st)+2 to length(st)-1 do pn:=pn+st[t];
                      rip:=strtoint(pn);
                end;
                inc(i);
                st:=f.Strings[i];
             end;
             if (fl<=clk*(level[0]+level[1])) and (pos('LEVEL',f.Strings[i+1])>0) then
                begin
                if rip>0 then i:=stind else if rip=0 then inc(i);
                st:=f.Strings[i]; goto label1;
             end;
             dec(i); st:=f.Strings[i];
             if pos('LEVEL 1 FOR',st)>0 then begin
                if findcomponent('a'+p) is TLabel then
                 (findcomponent('a'+p) as TLabel).Font.Color:=clRed;
             end
             else if pos('LEVEL 0 FOR',st)>0 then
                if findcomponent('a'+p) is TLabel then
                 (findcomponent('a'+p) as TLabel).Font.Color:=clBlack;
         end;
          if (pos('TRANSITION_LIST("dpin[',st)>0) then begin
              t:=pos('"dpin[',st)+6; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i];
             elemmemo('d',fl,clk,level[0],level[1],f,p,i);
         end;
         if (pos('TRANSITION_LIST("spin[',st)>0) then begin
              t:=pos('"spin[',st)+6; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i];
             elemmemo('s',fl,clk,level[0],level[1],f,p,i);
         end
         else if (pos('TRANSITION_LIST("tpin[',st)>0) then begin
              t:=pos('"tpin[',st)+6; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i];
             elemmemo('t',fl,clk,level[0],level[1],f,p,i);
         end
         else if (pos('TRANSITION_LIST("jpin[',st)>0) then begin
              t:=pos('"jpin[',st)+6; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i];
             elemmemo('j',fl,clk,level[0],level[1],f,p,i);
         end
         else if (pos('TRANSITION_LIST("kpin[',st)>0) then begin
              t:=pos('"kpin[',st)+6; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i];
             elemmemo('k',fl,clk,level[0],level[1],f,p,i);
         end
         else if (pos('TRANSITION_LIST("rpin[',st)>0) then begin
              t:=pos('"rpin[',st)+6; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i];
             elemmemo('r',fl,clk,level[0],level[1],f,p,i);
         end
         else if (pos('TRANSITION_LIST("ctpin[',st)>0) then begin
              t:=pos('"ctpin[',st)+7; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i];
             rip:=0;
label4:      while (fl<=clk*(level[0]+level[1])) and (pos('}',st)=0) do begin
                if pos('LEVEL',st)>0 then begin
                    pn:='';
                    for t:=pos('FOR ',st)+4 to length(st)-1 do pn:=pn+st[t];
                    pn:=stringreplace(pn,'.',',',[rfReplaceAll]);
                    fl:=fl+strtofloat(pn);
                    if rip>0 then dec(rip);
                end
                else if pos('REPEAT',st)>0 then begin
                      stind:=i+1;
                      pn:='';
                      for t:=pos('= ',st)+2 to length(st)-1 do pn:=pn+st[t];
                      rip:=strtoint(pn);
                end;
                inc(i);
                st:=f.Strings[i];
             end;
             if (fl<=clk*(level[0]+level[1])) and (pos('LEVEL',f.Strings[i+1])>0) then
                begin
                if rip>0 then i:=stind else if rip=0 then inc(i);
                st:=f.Strings[i]; goto label4;
             end;
             dec(i); st:=f.Strings[i];
             if pos('LEVEL 1 FOR',st)>0 then begin
                if (findcomponent('ct'+p) as TLabel).Caption='0' then begin
                 (findcomponent('ct'+p) as TLabel).Font.Color:=clRed;
                 (findcomponent('ct'+p) as TLabel).Caption:='1';
                 end;
             end
             else if pos('LEVEL 0 FOR',st)>0 then
                if (findcomponent('ct'+p) as TLabel).Caption='1' then begin
                 (findcomponent('ct'+p) as TLabel).Font.Color:=clBlack;
                 (findcomponent('ct'+p) as TLabel).Caption:='0';
                 end;
         end
          //=========
         else if (pos('TRANSITION_LIST("rgpin[',st)>0) then begin
              t:=pos('"rgpin[',st)+7; p:='';
             while st[t]<>']' do begin p:=p+st[t]; inc(t); end;
             fl:=0;
             inc(i,5); st:=f.Strings[i];
             rip:=0;
label5:      while (fl<=clk*(level[0]+level[1])) and (pos('}',st)=0) do begin
                if pos('LEVEL',st)>0 then begin
                    pn:='';
                    for t:=pos('FOR ',st)+4 to length(st)-1 do pn:=pn+st[t];
                    pn:=stringreplace(pn,'.',',',[rfReplaceAll]);
                    fl:=fl+strtofloat(pn);
                    if rip>0 then dec(rip);
                end
                else if pos('REPEAT',st)>0 then begin
                      stind:=i+1;
                      pn:='';
                      for t:=pos('= ',st)+2 to length(st)-1 do pn:=pn+st[t];
                      rip:=strtoint(pn);
                end;
                inc(i);
                st:=f.Strings[i];
             end;
             if (fl<=clk*(level[0]+level[1])) and (pos('LEVEL',f.Strings[i+1])>0) then
                begin
                if rip>0 then i:=stind else if rip=0 then inc(i);
                st:=f.Strings[i]; goto label5;
             end;
             dec(i); st:=f.Strings[i];
             if pos('LEVEL 1 FOR',st)>0 then begin
                if (findcomponent('rg'+p) as TLabel).Caption='0' then begin
                 (findcomponent('rg'+p) as TLabel).Font.Color:=clRed;
                 (findcomponent('rg'+p) as TLabel).Caption:='1';
                 end;
             end
             else if pos('LEVEL 0 FOR',st)>0 then
                if (findcomponent('rg'+p) as TLabel).Caption='1' then begin
                 (findcomponent('rg'+p) as TLabel).Font.Color:=clBlack;
                 (findcomponent('rg'+p) as TLabel).Caption:='0';
                 end;
         end;
         inc(i);
     end;
end;

procedure TSDIAppForm.elemmemo(ch: char; sum,c,l0,l1:real; fd:TStringList; kol:string; var ii:integer);
label ll1;
var ss,fstr,dlit:string; tt,rp,findex:integer;
begin
     case ch of
     'd': ss:='DFF';
     's','r': ss:='SRFF';
     'j','k': ss:='JKFF';
     't': ss:='TFF';
     end;
     fstr:=fd.strings[ii]; rp:=0;
ll1:     while (sum<c*(l0+l1)) and (pos('}',fstr)=0) do begin
                if pos('LEVEL',fstr)>0 then begin
                dlit:='';
                for tt:=pos('FOR ',fstr)+4 to length(fstr)-1 do dlit:=dlit+fstr[tt];
                dlit:=stringreplace(dlit,'.',',',[rfReplaceAll]);
                sum:=sum+strtofloat(dlit);
                if rp>0 then dec(rp);
                end
                else if pos('REPEAT',fstr)>0 then begin
                      findex:=ii+1;
                      dlit:='';
                      for tt:=pos('= ',fstr)+2 to length(fstr)-1 do dlit:=dlit+fstr[tt];
                      rp:=strtoint(dlit);
                end;
                inc(ii);
                fstr:=fd.Strings[ii];
     end;
     if (sum<=c*(l0+l1)) and (pos('LEVEL',fd.Strings[ii+1])>0) then
                begin
                if rp>0 then ii:=findex else if rp=0 then inc(ii);
                fstr:=fd.Strings[ii]; goto ll1;
     end;
     dec(ii); fstr:=fd.Strings[ii];
     if pos('LEVEL 1 FOR',fstr)>0 then begin
        for tt:=0 to length(el)-1 do
            if (el[tt].name=ss) and (el[tt].count=strtoint(kol)) then
              if (ch='d') or (ch='s') or (ch='j') or (ch='t') then begin
                if el[tt].lab.Caption='0' then begin
                          el[tt].lab.Caption:='1';
                          el[tt].lab.Font.Color:=clRed; break;
                end;
              end
              else if (ch='k') or (ch='r') then begin
                      if (findcomponent(ch+kol) as TLabel).Caption='0' then begin
                              (findcomponent(ch+kol) as TLabel).Caption:='1';
                              (findcomponent(ch+kol) as TLabel).Font.Color:=clRed;
                      end;
                   end;
     end
     else if pos('LEVEL 0 FOR',fstr)>0 then begin
          for tt:=0 to length(el)-1 do
                  if (el[tt].name=ss) and (el[tt].count=strtoint(kol)) then
                    if (ch='d') or (ch='s') or (ch='j') or (ch='t') then begin
                        if el[tt].lab.Caption='1' then begin
                          el[tt].lab.Caption:='0';
                          el[tt].lab.Font.Color:=clBlack; break;
                        end;
                    end
                    else if (ch='k') or (ch='r') then begin
                      if (findcomponent(ch+kol) as TLabel).Caption='1' then begin
                              (findcomponent(ch+kol) as TLabel).Caption:='0';
                              (findcomponent(ch+kol) as TLabel).Font.Color:=clBlack;
                      end;
                    end;
          end;
end;

procedure TSDIAppForm.Button5Click(Sender: TObject);
begin
     ShellExecute(0,'Open',pchar(pic),nil,nil,1);
end;

function TSDIAppForm.otstup(elemname,iname: string; prior:integer): integer;
var t:integer; pp:string[5];
begin
if pos('ct',elemname)>0 then begin
     if pos('sclr',iname)>0 then result:=0
     else
     if pos('cnt_en',iname)>0 then begin
        if pos('pm',elemname)>0 then result:=round(40*1.3)
        else result:=round(25*1.3);
     end
     else
     //========
     if pos('updown',iname)>0 then result:=round(25*1.3)
     else
     //=========
     if pos('load',iname)>0 then begin
        if pos('pm',elemname)>0 then result:=round(134*1.3)
        else result:=round(40*1.3);
     end
     else
     if (pos('data',iname)>0) or (iname='out') then begin
        if prior=0 then result:=round(54*1.3)
        else result:=round(prior+20*1.3); end;
end
else
if pos('rg',elemname)>0 then begin
    if pos('Q',iname)>0 then begin
       pp:=iname[pos('Q',iname)+1];
       case pp[1] of
       'A': result:=0;
       'B': result:=round(24*1.3);
       'C': result:=round(44*1.3);
       'D': result:=round(63*1.3);
       'E': result:=round(81*1.3);
       'F': result:=round(100*1.3);
       'G': result:=round(120*1.3);
       'H': result:=round(138*1.3);
       end; end
    else begin
    if pos('A ',iname)>0 then result:=round(54*1.3)
    else if pos('B ',iname)>0 then result:=round(65*1.3)
    else if pos('C ',iname)>0 then result:=round(75*1.3)
    else if pos('D ',iname)>0 then result:=round(87*1.3)
    else if pos('E ',iname)>0 then result:=round(100*1.3)
    else if pos('F ',iname)>0 then result:=round(112*1.3)
    else if pos('G ',iname)>0 then result:=round(125*1.3)
    else if pos('H ',iname)>0 then result:=round(136*1.3)
    else if pos('S0',iname)>0 then result:=round(25*1.3)
    else if pos('S1',iname)>0 then result:=round(40*1.3);
    end;
end
else
if pos('dc',elemname)>0 then begin
    if pos('eq',iname)>0 then begin
       t:=pos('eq',iname)+2; pp:='';
        while iname[t]<>' ' do begin
          pp:=pp+iname[t];
          inc(t);
       end;
       case strtoint(pp) of
       0: result:=0;
       1: begin
          if pos('4',elemname)>0 then result:=round(16*1.3)
          else if (pos('3',elemname)>0) or (pos('2',elemname)>0) then result:=round(24*1.3);
          end;
       2: begin
          if pos('4',elemname)>0 then result:=round(29*1.3)
          else if (pos('3',elemname)>0) or (pos('2',elemname)>0) then result:=round(44*1.3);
          end;
       3: begin
          if pos('4',elemname)>0 then result:=round(42*1.3)
          else if (pos('3',elemname)>0) or (pos('2',elemname)>0) then result:=round(63*1.3);
          end;
       4: begin
          if pos('4',elemname)>0 then result:=round(55*1.3)
          else if pos('3',elemname)>0 then result:=round(81*1.3);
          end;
       5: begin
          if pos('4',elemname)>0 then result:=round(67*1.3)
          else if pos('3',elemname)>0 then result:=round(100*1.3);
          end;
       6: begin
          if pos('4',elemname)>0 then result:=round(81*1.3)
          else if pos('3',elemname)>0 then result:=round(120*1.3);
          end;
       7: begin
          if pos('4',elemname)>0 then result:=round(94*1.3)
          else if pos('3',elemname)>0 then result:=round(138*1.3);
          end;
       8: result:=round(107*1.3);
       9: result:=round(119*1.3);
       10:result:=round(132*1.3);
       11:result:=round(146*1.3);
       12: result:=round(160*1.3);
       13:result:=round(173*1.3);
       14:result:=round(186*1.3);
       15: result:=round(198*1.3);
       end; //case
    end
    else if pos('out',iname)>0 then
         case prior of
         0: if pos('2',elemname)>0 then result:=round(32*1.3)
            else result:=round(55*1.3); 
         1: if pos('2',elemname)>0 then result:=round(52*1.3)
            else result:=round(73*1.3);
         2: result:=round(93*1.3);
         3: result:=round(112*1.3);
         end;
end
else result:=0;

end;

procedure TSDIAppForm.FileCopy(const SourceFileName, TargetFileName: string);
var S,T:TFileStream;
begin
  S:=TFileStream.Create(sourcefilename,fmOpenRead);
  try
    T:=TFileStream.Create(targetfilename,fmOpenWrite or fmCreate);
    try
      T.CopyFrom(S,S.Size);
      FileSetDate(T.Handle,FileGetDate(S.Handle));
    finally
      T.Free;
    end;
  finally
    S.Free;
  end;
end;

procedure TSDIAppForm.BitBtn1Click(Sender: TObject);
var TheWindowHandle:HWND;
begin
      TheWindowHandle := Findj('Quartus II');
   if TheWindowHandle = 0 then 
      ShellExecute(Handle, nil, 'cmd.exe', '/k quartus.exe', nil, SW_HIDE);
end;

procedure TSDIAppForm.drawlines(inames:string; elind:integer);
label labb;
var posDC,posFF,posCT,posRG,li,im,j,kl,kt:integer; endl,beg:TPoint;  p:string[10];

procedure risuem(px,py:integer);
begin
    if py=endl.Y then begin
                 with paintbox1.Canvas do begin
                    moveto(pX,pY);
                    lineTo(endl.X,endl.Y);
                 end;
             end
             else
             begin with paintbox1.Canvas do begin
                    moveto(pX,pY);
                 lineTo(endl.X-im,pY);
                 lineTo(endl.X-im,endl.Y);
                 lineTo(endl.X,endl.Y);
                 end;
                 inc(im,5);
             end;
end;

procedure rgct(n:string);
var lli:integer; pstr:string;
begin
     im:=5;
     if length(el[elind].lab.Caption)=0 then
     for lli:=0 to length(el[elind].inp)-1 do  begin
        pstr:=el[elind].inp[lli].ins;
        delete(pstr,length(pstr),1);
        delete(pstr,1,pos('(',pstr));
        endl.y:=(findcomponent(n+pstr) as TLabel).top+(findcomponent(n+pstr) as TLabel).height div 2;
        endl.X:=(findcomponent(n+pstr) as TLabel).left;
        risuem(prev.X,prev.Y);
        prev.Y:=prev.y+20;
     end;
end;

begin
    posDC:=pos('dc',inames);
    posFF:=pos('FF',inames);
    posCT:=pos('ct',inames);
    posRG:=pos('rg',inames);
    paintbox1.Canvas.pen.Color:=clBlack;
    paintbox1.Canvas.pen.Style:=psSolid;
    paintbox1.Canvas.Pen.Width:=2;
    if posRG>0 then begin
                          rgct('rg');
                          goto labb;
    end
    else if posCT>0 then
    begin rgct('ct');
           for li:=0 to strtoint(size) do begin
               beg.y:=(findcomponent('out'+inttostr(li)) as TLabel).Top+(findcomponent('out'+inttostr(li)) as TLabel).height div 2;
               beg.X:=(findcomponent('out'+inttostr(li)) as TLabel).left+(findcomponent('out'+inttostr(li)) as TLabel).Width;
               for j:=0 to length(el)-1 do
                   if pos('dc',el[j].name)>0 then begin
                      kl:=el[j].img.Left;
                      kt:=el[j].img.Top;
                      p:=el[j].name; break; end;     
               endl.Y:=otstup(p,'out',li)+kt;
               endl.X:=kl;
               risuem(beg.X,beg.Y);
           end;
    end
    else
    if posFF>0 then
    begin  im:=imm;
           case inames[1] of
           'S','J': begin
           for li:=0 to length(el[elind].inp)-1 do  begin
             p:=el[elind].inp[li].ins;
             delete(p,pos('(',p),1); delete(p,pos(')',p),1);
             endl.y:=(findcomponent(p) as TLabel).top+(findcomponent(p) as TLabel).height div 2;
             endl.X:=(findcomponent(p) as TLabel).left-3;
             risuem(prev.X,prev.Y);
             imm:=im;
             prev.Y:=prev.y+20;
           end;
           p:=el[elind].outp[0].outs;
           delete(p,pos('(',p),1); delete(p,pos(')',p),1);
           beg.y:=(findcomponent(p) as TLabel).Top+(findcomponent(p) as TLabel).height div 2;
           beg.X:=(findcomponent(p) as TLabel).left+(findcomponent(p) as TLabel).Width;
           dec(im,5);
           for j:=0 to length(el)-1 do
                   if pos('dc',el[j].name)>0 then begin
                      kl:=el[j].img.Left; kt:=el[j].img.Top;
                      p:=el[j].name; break; end;
           endl.Y:=otstup(p,'out',cou)+kt; inc(cou);
           endl.X:=kl;
           risuem(beg.X,beg.Y);
           end;
           'D','T':begin 
               endl.X:=el[elind].lab.Left-3;
               endl.Y:=el[elind].lab.Top+el[elind].lab.Height div 2;
               risuem(prev.X,prev.Y);
               imm:=im;
               prev.Y:=prev.y+20;
               p:=el[elind].outp[0].outs;
               delete(p,pos('(',p),1); delete(p,pos(')',p),1);
               beg.y:=(findcomponent(p) as TLabel).Top+(findcomponent(p) as TLabel).height div 2;
               beg.X:=(findcomponent(p) as TLabel).left+(findcomponent(p) as TLabel).Width;
              for j:=0 to length(el)-1 do
                   if pos('dc',el[j].name)>0 then begin
                      kl:=el[j].img.Left;
                      kt:=el[j].img.Top;
                      p:=el[j].name; break; end;
              endl.Y:=otstup(p,'out',cou)+kt; inc(cou);
              endl.X:=kl;
              dec(im,5);
              risuem(beg.X,beg.Y);
              imm:=im;
           end;
          
    end;
    end
    else begin
    if posDC>0 then begin
            if length(el[elind].lab.Caption)=0 then
labb:       for li:=0 to length(el[elind].outp)-1 do  begin
             p:=el[elind].outp[li].outs;
             delete(p,length(p),1);
             delete(p,1,pos('(',p));
             beg.X:=(findcomponent('a'+p) as TLabel).left+(findcomponent('a'+p) as TLabel).Width;
             beg.Y:=(findcomponent('a'+p) as TLabel).top+(findcomponent('a'+p) as TLabel).height div 2;
             endl.y:=beg.Y;
             endl.X:=shape12.Left;
             if beg.Y>(shape12.Top+shape12.Height) then
                shape12.Height:=beg.Y-shape12.Top+5;
            risuem(beg.X,beg.Y);
           end;
    end; end;
end;

procedure TSDIAppForm.PaintBox1Paint(Sender: TObject);
var   li:integer;
begin
prev.X:=image1.Left+image1.Width; prev.Y:=image1.Top+20;
imm:=5; cou:=0;
for li:=0 to length(el)-1 do drawlines(el[li].name,li);
end;

procedure TSDIAppForm.auto;
var i,j,r,t,missed:integer;  f:TStringlist;  st,p:ansistring; fl:real;
begin
f:=TStringList.Create;
f.LoadFromFile(fn3);
ClockWork(f);
for j:=0 to clkcount-1 do
  for i:=0 to xcount-1 do
    if pos('x'+inttostr(i),clock[j])>0 then begin
        r:=10;
        while r<f.Count-1 do begin
             st:=f.Strings[r];
             if pos('TRANSITION_LIST("xpin['+inttostr(i)+']")',st)>0 then begin
                inc(r,5); st:=f.Strings[r]; //переход на строку уровней
                fl:=0;
                while pos('}',st)=0 do begin  //пока не обработаны все строки показаний
                        p:='';
                        for t:=pos('FOR ',st)+4 to length(st)-1 do p:=p+st[t]; //сохр длительность сигнала
                        p:=stringreplace(p,'.',',',[rfReplaceAll]);
                        fl:=fl+strtofloat(p);  //складываем
                        inc(r);
                        st:=f.Strings[r];
                end;  //while
                fl:=fl-strtofloat(p);
                if f.Strings[r-1][pos('LEVEL ',f.Strings[r-1])+6]='0' then
                begin
                    if pos('FOR 1000.0',f.Strings[r-1])>0 then begin
                      if (j=0) and (pos('rg',el[0].name)=0) then p:=floattostr(level[0]-1.0)
                      else
                      p:=floattostr((j+1)*(level[0]+level[1])-level[1]-1.0);
                      fl:=fl+strtofloat(p);
                      if frac(level[0]-1.0)=0.0 then p:=p+'.0'
                      else p:=stringreplace(p,',','.',[rfReplaceAll]);
                      st:='LEVEL 0 FOR '+p+';';
                      for t:=1 to pos('LEVEL',f.Strings[r-1])-1 do st:=' '+st;
                      f.Strings[r-1]:=st;
                      end //then
                    else begin
                      p:=floattostr(level[1]*0.5+level[0]-1.0+miss[i]*(level[0]+level[1]));
                      fl:=fl+level[1]*0.5+level[0]-1.0+miss[i]*(level[0]+level[1]);
                      if frac(level[1]*0.5+level[0]-1.0+miss[i]*(level[0]+level[1]))=0.0 then p:=p+'.0'
                      else p:=stringreplace(p,',','.',[rfReplaceAll]);
                      st:='LEVEL 0 FOR '+p+';';
                      for t:=1 to pos('LEVEL',f.Strings[r-1])-1 do st:=' '+st;
                      f.Strings[r-1]:=st;
                    end; //if
                      p:=floattostr(1.0+level[1]*0.5);
                      fl:=fl+1.0+level[1]*0.5;
                      if frac(1.0+level[1]*0.5)=0.0 then p:=p+'.0'
                      else p:=stringreplace(p,',','.',[rfReplaceAll]);
                      st:='LEVEL 1 FOR '+p+';';
                      for t:=1 to pos('LEVEL',f.Strings[r-1])-1 do st:=' '+st;
                      f.Insert(r,st);
                      inc(r);
                      p:=floattostr(1000.0-fl);
                      if frac(1000.0-fl)=0.0 then p:=p+'.0'
                      else p:=stringreplace(p,',','.',[rfReplaceAll]);
                      st:='LEVEL 0 FOR '+p+';';
                      for t:=1 to pos('LEVEL',f.Strings[r-1])-1 do st:=' '+st;
                      f.Insert(r,st);
                end //then
                else begin
                      p:=floattostr(1000.0-fl);
                      if frac(1000.0-fl)=0.0 then p:=p+'.0';
                      p:=stringreplace(p,',','.',[rfReplaceAll]);
                      st:='LEVEL 0 FOR '+p+';';
                      for t:=1 to pos('LEVEL',f.Strings[r-1])-1 do st:=' '+st;
                      f.Insert(r,st);
                end; //if
           r:=f.Count;
           f.SaveToFile(fn3);
           end;  //if
           inc(r);
        end; //while
        miss[i]:=0;
        mclk:=0;
    end//if
    else begin inc(missed); inc(miss[i]);
          if missed=xcount then inc(mclk);
    end;
f.free;
end;

procedure TSDIAppForm.BitBtn2Click(Sender: TObject);
begin
form2.Show;
end;

procedure TSDIAppForm.ClockWork(fi:TStringlist);
var i,j,t:integer; p,st:ansistring; fl:real;
begin
i:=10;//сохраняем длительность стробирующего сигнала
while i<fi.Count do begin
            st:=fi.Strings[i];
            if pos('TRANSITION_LIST("clk")',st)>0 then begin  
                inc(i,8);
                for j:=1 to 2 do begin
                  st:=fi.Strings[i];
                  if pos('LEVEL',st)>0 then begin
                    p:=''; t:=pos('FOR ',st)+4;
                    while st[t]<>';' do begin
                        p:=p+st[t]; inc(t); end;
                    p:=stringreplace(p,'.',',',[rfReplaceAll]);
                    fl:=strtofloat(p);
                    if st[pos('LEVEL ',st)+6]='0' then level[0]:=fl
                    else level[1]:=fl;
                  end;  //if
                  inc(i);
                end;//for
                i:=fi.Count;
            end;//if
            inc(i);
end;//while
end;

procedure TSDIAppForm.loading;
var h:HWnd;
begin
menucom(10,1);
statusbar.SimpleText:='';screen.Cursor:=crDefault;statusbar.Color:=clBtnFace;
SDIAppForm.readdiag;
button2.Enabled:=true;
h:=findwindow('TForm2','Автоматический режим'); setforegroundwindow(h);
end;

procedure TSDIAppForm.N2Click(Sender: TObject);
begin
      n3.Checked:=false;
     n2.Checked:=true;
     bitbtn2.Enabled:=true;
     button2.Enabled:=false;
     n9.Enabled:=false;
     n10.Enabled:=true;
end;

procedure TSDIAppForm.N3Click(Sender: TObject);
begin
     n2.Checked:=false;
     n3.Checked:=true;
     n9.Enabled:=true;
     n10.Enabled:=false;
     button2.Enabled:=true;
     bitbtn2.Enabled:=false;
     if form2.Visible then form2.Close;
end;

procedure TSDIAppForm.RadioButton1Click(Sender: TObject);
begin
      radiobutton1.Checked:=true;
      bitbtn2.Enabled:=true;
      radiobutton2.Checked:=false;
      button2.Enabled:=false;
end;

procedure TSDIAppForm.RadioButton2Click(Sender: TObject);
begin
      radiobutton2.Checked:=true;
      button2.Enabled:=true;
      radiobutton1.Checked:=false;
      bitbtn2.Enabled:=false;
end;

procedure TSDIAppForm.menucom(ch,param: integer);
Var  txt: array[0..255] of Char;
names:string;
Hnd,HndC,HndControl,Stat,HndBtn,h :HWnd;
HndMen,HndSMen:HMenu;
idMen,i:integer;
begin
  Hnd:=Findj('Quartus II'); //нашли главное окно quartus II
  if Hnd<>0 then begin
    HndMen:=GetMenu(Hnd); //нашли меню
    case param of
    0: begin
     for i:=0 to 2 do begin
          GetMenuString(HndMen,i,txt,50,mf_ByPosition);
          names:=txt; if pos('ile',names)>0 then break; end;
    HndSMen:=GetSubMenu(HndMen,i); idMen:=GetMenuItemID(HndSMen,5);
    if idMen<>0 then PostMessage(Hnd,WM_COMMAND,idMen,0);
      repeat hndc:=findwindow(PChar(#32770),'Open Project');
             sleep(500);
      until hndc>0;
      HndControl:=findwindowex(hndc,0,PChar('ComboBoxEx32'),nil);
      stat:=Findwindowex(hndcontrol,0,PChar('ComboBox'),nil);
      h:=Findwindowex(stat,0,PChar('Edit'),nil);
      SendMessage(H,WM_SETTEXT ,0,lparam(LPCTSTR(proj))) ;
      HndBtn:=findwindowex(hndc,0,PChar('Button'),PChar('&Открыть'));
      SendMessage(HndBtn, BM_CLICK, 0, 0);
    end;
    1: begin
    for i:=4 to 9 do begin
    GetMenuString(HndMen,i,txt,50,mf_ByPosition); //ищем подменю по наименованию
    names:=txt;
    if pos('rocessing',names)>0 then break;
    end;
    HndSMen:=GetSubMenu(HndMen,i); //нашли подменю
    idMen:=GetMenuItemID(HndSMen,ch); //нашли пункт меню
    if idMen<>0 then
      PostMessage(Hnd,WM_COMMAND,idMen,0);  //посылаем нажатие
      repeat
        hndc:=findwindow(PChar(#32770),'Quartus II'); //ищем окно завершения операции
        sleep(1000);
        application.ProcessMessages;  //даем поработать другим
      until hndc>0;
      HndControl:=findwindowex(hndc,0,PChar('Static'),nil); //ищем дочернее окно
      Stat:=findwindowex(hndc,hndcontrol,PChar('Static'),nil);
      GetWindowText(Stat,txt,100); //читаем заголовок дочернего окна
      names:=txt;
      h:=FindWindow('TSDIAppForm','Упрявляющий автомат');
      setforegroundwindow(h);
      if pos('NOT',names)=0 then begin  //если все отлично
                  HndBtn:=findwindowex(hndc,0,'Button',nil); 
                  SendMessage(HndBtn, BM_CLICK, 0, 0); //жмем на кнопку ОК
      end
      else
          case ch of
            9:MessageDlg('Ошибка. Проверьте схему.',mtError, [mbOK],0);
            10:MessageDlg('Ошибка. Проверьте схему или запустите Generate Functional Simulation Netlist.',mtError, [mbOK],0);
          end;
      end;
    end;
  end;
end;

procedure TSDIAppForm.N8Click(Sender: TObject);
begin
     Application.HelpCommand(HELP_FINDER, 0);
end;

procedure TSDIAppForm.FormActivate(Sender: TObject);
begin
      RegisterHotKey(Handle,1234,mod_control,vk_space);
end;

procedure TSDIAppForm.FormDestroy(Sender: TObject);
begin
     UnregisterHotKey(Handle,1234)
end;

procedure TSDIAppForm.N5Click(Sender: TObject);
begin
BitBtn1Click(Sender);
end;

procedure TSDIAppForm.Quartus1Click(Sender: TObject);
begin
Button4Click(Sender);
end;

procedure TSDIAppForm.N4Click(Sender: TObject);
begin
Button5Click(Sender);
end;

procedure TSDIAppForm.N6Click(Sender: TObject);
begin
Button3Click(Sender);
end;

procedure TSDIAppForm.N7Click(Sender: TObject);
begin
menucom(9,1);
end;

procedure TSDIAppForm.N10Click(Sender: TObject);
begin
form2.Show;
end;


procedure TSDIAppForm.pict(id, idy, idx: integer; n: string);
begin
el[id].img.Picture.Bitmap.LoadFromFile(elements.Values[n]);  //рисуем элемент
el[id].img.Top:=30+idy; el[id].img.Left:=10+idx;
el[id].img.Width:=round(el[id].img.Picture.Width*1.3);
el[id].img.Height:=round(el[id].img.Picture.Height*1.3);
el[id].img.Stretch:=true;
el[id].img.Transparent:=true;
end;

end.
