unit Osnov;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Spin;

type
  tsistem1=array[1..4] of string[50];
  tsistem3=array[1..3] of string[30];
  tsistem4=array[1..2] of string[30];
  tlagr1=array[1..7] of string[5];
  tlagr2=array[1..7] of string[9];
  tnewt1=array[1..16] of string[6];
  tnewt2=array[1..16] of string[9];
  tnaimk=array[1..11] of string[7];
  tintegr=array[1..4] of string[30];
  tpredel=array[1..3] of string[14];
  TForm1 = class(TForm)
    TabControl1: TTabControl;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

procedure zadan;
procedure trebprog;
procedure trebotch;
procedure lab1zagr(var inter:string;var uravn:string);
procedure lab2zagr(var sistem1:tsistem1;var sistem2:tsistem1;var sistem3:tsistem3;var sistem4:tsistem4);
procedure lab3zagr(var lagran1:tlagr1;var lagran2:tlagr2;var lagran:string;var newton1:tnewt1;var newton2:tnewt2;var newton:string;var naimkvadr1:tnaimk;var naimkvadr2:tnaimk);
procedure lab4zagr(var metod:integer;var integ:tintegr;var predel:tpredel;var uslov:string);

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
combobox1.ItemIndex:=0;
zadan
end;

procedure TForm1.Label2Click(Sender: TObject);
begin
zadan
end;

procedure zadan;
var interval:string;
    uravnen:string;
    i:integer;
    sis1,sis2:tsistem1;
    sis3:tsistem3;
    sis4:tsistem4;
    lagr1:tlagr1;
    lagr2:tlagr2;
    lagr:string;
    newt1:tnewt1;
    newt2:tnewt2;
    newt:string;
    naimk1:tnaimk;
    naimk2:tnaimk;
    sdv:string[40];
    m:integer;
    int:tintegr;
    pred:tpredel;
    us:string;
begin
with form1 do begin
label2.font.color:=clblue;
label3.font.color:=clWindowText;
label4.font.color:=clWindowText;
memo1.clear;
case tabcontrol1.tabindex of
0: begin
   Memo1.Lines.Append('1. Построить график функции f(x) и отделить один из корней уравнения: f(x).');
   Memo1.Lines.Append('2. Сузить интервал изоляции корня, если необходимо, проверив условие: M<=2m.');
   Memo1.Lines.Append('3. Уточнить корень с погрешностью e<=0,00001 двумя численными методами: комбинированным методом и методом итераций.');
   Memo1.Lines.Append('4. Проверить полученное значение корня, используя систему Mathcad.');
   Memo1.Lines.Append('');
   Memo1.Lines.Append('Вариант '+combobox1.text);
   lab1zagr(interval,uravnen);
   Memo1.Lines.Append('Уравнение: '+uravnen);
   Memo1.Lines.Append('Интервал: '+interval);
   end;
1: begin
   sdv:='                                       ';
   lab2zagr(sis1,sis2,sis3,sis4);
   Memo1.Lines.Append('Вариант '+combobox1.text);
   Memo1.Lines.Append('');
   Memo1.Lines.Append('1. Решить систему линейных уравнений 4-го порядка методом Гаусса с точностью е=0,001.');
   Memo1.Lines.Append('Уравнения системы:');
   Memo1.Lines.Append('');
   Memo1.Lines.Append(sdv+sis1[1]);
   Memo1.Lines.Append(sdv+sis1[2]);
   Memo1.Lines.Append(sdv+sis1[3]);
   Memo1.Lines.Append(sdv+sis1[4]);
   Memo1.Lines.Append('');
   Memo1.Lines.Append('2. Решить систему линейных уравнений 4-го порядка с точностью е=0,0001:');
   if odd(combobox1.ItemIndex) then
   Memo1.Lines.Append(' - методом простой итерации.') else
   Memo1.Lines.Append(' - методом Зейделя.');
   Memo1.Lines.Append('Уравнения системы:');
   Memo1.Lines.Append('');
   Memo1.Lines.Append(sdv+sis2[1]);
   Memo1.Lines.Append(sdv+sis2[2]);
   Memo1.Lines.Append(sdv+sis2[3]);
   Memo1.Lines.Append(sdv+sis2[4]);
   Memo1.Lines.Append('');
   Memo1.Lines.Append('3. Решить систему линейных уравнений 3-го порядка методом обратной матрицы с точностью е=0,001.');
   Memo1.Lines.Append('Уравнения системы:');
   Memo1.Lines.Append('');
   Memo1.Lines.Append(sdv+sis3[1]);
   Memo1.Lines.Append(sdv+sis3[2]);
   Memo1.Lines.Append(sdv+sis3[3]);
   Memo1.Lines.Append('');
   Memo1.Lines.Append('4. Решить систему нелинейных уравнений 2-го порядка методом Ньютона с точностью е=0,001.');
   Memo1.Lines.Append('Уравнения системы:');
   Memo1.Lines.Append('');
   Memo1.Lines.Append(sdv+sis4[1]);
   Memo1.Lines.Append(sdv+sis4[2]);
   Memo1.Lines.Append('');
   Memo1.Lines.Append('5. Проверить результаты с помощью системы Mathcad.');
   Memo1.Lines[0]:=('Вариант '+combobox1.text);
   end;
2: begin
   lab3zagr(lagr1,lagr2,lagr,newt1,newt2,newt,naimk1,naimk2);
   Memo1.Lines.Append('Вариант '+combobox1.text);
   Memo1.Lines.Append('');
   Memo1.Lines.Append('1. По таблице с неравноотстоящими значениями аргумента выполнить интерполяцию, используя формулу Лагранжа. Точность E<=0,000001.');
   Memo1.Lines.Append('Задание:');
   Memo1.Lines.Append('');
   Memo1.Lines.Append(lagr);
   Memo1.Lines.Append('');
   for i:=1 to 7 do
   Memo1.Lines.Append(lagr1[i]+'    '+lagr2[i]);
   Memo1.Lines.Append('');
   Memo1.Lines.Append('2. По таблице с равноотстоящими значениями аргумента вычислить значения функции для заданных значений аргументов, используя первую и вторую интерполяционные формулы Ньютона. Точность E<=0.000001.');
   Memo1.Lines.Append('Задание:');
   Memo1.Lines.Append('');
   Memo1.Lines.Append(newt);
   Memo1.Lines.Append('');
   i:=1;
   while newt1[i]<>'' do begin
   Memo1.Lines.Append(newt1[i]+'    '+newt2[i]);
   i:=i+1
   end;
   Memo1.Lines.Append('');
   Memo1.Lines.Append('3. По заданным экспериментальным точкам выбрать вид эмпирической зависимости и выполнить среднеквадратичное приближение функции, применив метод наименьших квадратов для оценки параметров выбранной зависимости.');
   Memo1.Lines.Append('Задание:');
   Memo1.Lines.Append('');
   i:=1;
   while naimk1[i]<>'' do begin
   Memo1.Lines.Append(naimk1[i]+'    '+naimk2[i]);
   i:=i+1
   end;
   Memo1.Lines.Append('');
   Memo1.Lines.Append('4. Проверить результаты с помощью системы Mathcad.');
   Memo1.Lines[0]:=('Вариант '+combobox1.text);
   end;
3: begin
   lab4zagr(m,int,pred,us);
   Memo1.Lines.Append('Вариант '+combobox1.text);
   Memo1.Lines.Append('');
   Memo1.Lines.Append('1. Вычислить определённый интеграл с точностью до 0,0001. Выбрать значение n, обеспечивающее заданную точность, из формулы остаточного члена.');
   Memo1.Lines.Append('Задание:');
   Memo1.Lines.Append('Определённый интеграл от функции:  '+int[1]);
   Memo1.Lines.Append('Пределы интегрирования: '+pred[1]);
   if odd(combobox1.ItemIndex) then
   Memo1.Lines.Append('Использовать формулу трапеций.') else
   Memo1.Lines.Append('Использовать формулу Симпсона.');
   Memo1.Lines.Append('');
   Memo1.Lines.Append('2. Вычислить определённый интеграл с точностью до 0,0001 по другой квадратурной формуле:');
   Memo1.Lines.Append('Задание:');
   Memo1.Lines.Append('Определённый интеграл от функции:  '+int[2]);
   Memo1.Lines.Append('Пределы интегрирования: '+pred[2]);
   if odd(combobox1.ItemIndex) then
   Memo1.Lines.Append('Использовать формулу Симпсона.') else
   Memo1.Lines.Append('Использовать формулу трапеций.');
   if odd(combobox1.ItemIndex) then
   Memo1.Lines.Append('В качестве начального шага взять число, близкое к Е^(1/m), где m=4. Для приближённой оценки погрешности применить принцип Рунге.') else
   Memo1.Lines.Append('В качестве начального шага взять число, близкое к Е^(1/m), где m=2. Для приближённой оценки погрешности применить принцип Рунге.');
   Memo1.Lines.Append('');
   Memo1.Lines.Append('3. Вычислить определённый интеграл по квадратурной формуле Гаусса. Для оценки погрешности взять различное количество узлов:');
   if odd(combobox1.ItemIndex) then
   Memo1.Lines.Append('n1=4; n2=7.') else
   Memo1.Lines.Append('n1=5; n2=8.');
   if odd(combobox1.ItemIndex) then Begin
   Memo1.Lines.Append('Квадратурная формула Гаусса с 4 узлами:');
   Memo1.Lines.Append('x1=-x4=-0,86114        A1=A4=0,34785');
   Memo1.Lines.Append('x2=-x3=-0,33998        A2=A3=0,65215');
   Memo1.Lines.Append('Квадратурная формула Гаусса с 7 узлами:');
   Memo1.Lines.Append('x1=-x7=-0,949107912    A1=A7=0,129484966');
   Memo1.Lines.Append('x2=-x6=-0,741531186    A2=A6=0,279705391');
   Memo1.Lines.Append('x3=-x5=-0,405845151    A3=A5=0,381830051');
   Memo1.Lines.Append('x4=0                                    A4=0,417959184');
   end else begin
   Memo1.Lines.Append('Квадратурная формула Гаусса с 5 узлами:');
   Memo1.Lines.Append('x1=-x5=-0,90618        A1=A5=0,23698');
   Memo1.Lines.Append('x2=-x4=-0,538469       A2=A4=0,47863');
   Memo1.Lines.Append('x3=0                                 A3=0,56889');
   Memo1.Lines.Append('Квадратурная формула Гаусса с 8 узлами:');
   Memo1.Lines.Append('x1=-x8=-0,96028986     A1=A8=0,10122854');
   Memo1.Lines.Append('x2=-x7=-0,79666648     A2=A7=0,22238103');
   Memo1.Lines.Append('x3=-x6=-0,52553242     A3=A6=0,31370664');
   Memo1.Lines.Append('x4=-x5=-0,18343464     A4=A5=0,36268378');
   end;
   Memo1.Lines.Append('');
   Memo1.Lines.Append('Задание:');
   Memo1.Lines.Append('Определённый интеграл от функции:  '+int[3]);
   Memo1.Lines.Append('Пределы интегрирования: '+pred[3]);
   Memo1.Lines.Append('');
   Memo1.Lines.Append('4. Определить значения всех интегралов, обратившись к встроенным функциям Mathcad.');
   Memo1.Lines.Append('');
   Memo1.Lines.Append('5. Решить обыкновенное дифференциальное уравнение. Решение представить в табличной и графической формах. Для оценки погрешности выполнить расчёт с шагом h и с шагом h/2.');
   Memo1.Lines.Append('Задание:');
   case m of
   1:Memo1.Lines.Append('По формуле 2-го порядка точности решить дифференциальное уравнение');
   2:Memo1.Lines.Append('По формуле 4-го порядка точности решить дифференциальное уравнение методом Рунге-Кутта:');
   3:Memo1.Lines.Append('По формуле 4-го порядка точности решить дифференциальное уравнение методом Адамса:');
   end;
   Memo1.Lines.Append(int[4]);
   Memo1.Lines.Append(us);
   Memo1.Lines[0]:=('Вариант '+combobox1.text);
   end;
end;

end
end;

procedure trebprog;
begin
with form1 do begin
label2.font.color:=clWindowText;
label3.font.color:=clblue;
label4.font.color:=clWindowText;
memo1.clear;
case tabcontrol1.tabindex of
0: begin
   Memo1.Lines.Append('- программа может быть написана на любом языке высокого уровня;');
   Memo1.Lines.Append('- программа должна быть универсальной, т.е. пригодной для решения любого нелинейного уравнения заданным методом;');
   Memo1.Lines.Append('- программа должна содержать необходимые комментарии.');
   end;
1: begin
   Memo1.Lines.Append('- программа может быть написана на любом языке высокого уровня;');
   Memo1.Lines.Append('- в методе Гауса "прямой ход" схемы отобразить в расчётной таблице;');
   Memo1.Lines.Append('- все програмные модули сопроводить необходимыми комментариями.');
   end;
2: begin
   Memo1.Lines.Append('- программа может быть написана на любом языке высокого уровня;');
   Memo1.Lines.Append('- программа должна формировать исходные и необходимые расчётные таблицы и графики;');
   Memo1.Lines.Append('- все програмные модули сопровождать необходимыми комментариями.');
   end;
3: begin
   Memo1.Lines.Append('- программа может быть написана на любом языке высокого уровня;');
   Memo1.Lines.Append('- программа должна формировать все необходимые таблицы и графики;');
   Memo1.Lines.Append('- програмные модули должны сопровождаться необходимым комментариями.');
   end;
end;

end
end;


procedure TForm1.Label3Click(Sender: TObject);
begin
trebprog;
end;

procedure trebotch;
begin
with form1 do begin
label2.font.color:=clWindowText;
label3.font.color:=clWindowText;
label4.font.color:=clblue;
memo1.clear;
case tabcontrol1.tabindex of
0: begin
   Memo1.Lines.Append('- отчет должен содержать теоретическую и практическую часть, включающую описание метода, его особенности и ограничения, графические иллюстрации и расчетные формулы;');
   Memo1.Lines.Append('- график заданной функции на суженном интервале изоляции корня с проверкой условия M<=2m;');
   Memo1.Lines.Append('- обоснование выбора расчётных формул для комбинированного метода с фиксацией неподвижного конца интервала изоляции корня;');
   Memo1.Lines.Append('- расчётную таблицу для уточнения корня комбинированным методом;');
   Memo1.Lines.Append('- последовательность преобразования исходного уравнения к каноническому виду для метода итераций с проверкой условия сходимости итерационного процесса;');
   Memo1.Lines.Append('- график сходимости итерационного процесса для канонического уравнения;');
   Memo1.Lines.Append('- таблицу последовательных приближённых значений корня полученных методом итераций;');
   Memo1.Lines.Append('- листинг разработанной программы;');
   Memo1.Lines.Append('- результат проверки корня в системе Mathcad.');
   Memo1.Lines.Append('');
   Memo1.Lines.Append('Отчет должен быть представлен преподавателю и защищён на следующем лабораторном занятии.');
   end;
1: begin
   Memo1.Lines.Append('- отчет должен содержать четыре раздела (по числу методов и заданий);');
   Memo1.Lines.Append('- каждый раздел включает теоретическую часть с изложением основ метода, его особенностей, условий сходимости - для итерационных методов, оценок погрешности, должны быть приведены основные расчётные формулы;');
   Memo1.Lines.Append('- практическая часть каждого раздела должна содержать расчётные таблицы, оценку погрешности, проверку условий сходимости - для итерационных методов, листинг разработанной программы;');
   Memo1.Lines.Append('- результаты решения каждой системы уравнений должны быть проверены с помощью системы Mathcad;');
   Memo1.Lines.Append('');
   Memo1.Lines.Append('Отчет должен быть представлен преподавателю и защищён на следующем лабораторном занятии.');
   end;
2: begin
   Memo1.Lines.Append('- отчет должен содержать три раздела: 1) интерполяция по Лагранжу; 2) интерполяция по Ньютону; 3) среднеквадратичное приближение функции;');
   Memo1.Lines.Append('- в теоретической части 1 раздела - привести расчетные формулы с необходимыми пояснениями, формулу для оценки погрешности интерполирования; практическая часть должна содержать исходную таблицу, расчётную таблицу и результат расчёта с оценкой погрешности');
   Memo1.Lines.Append(' и проверкой в системе Mathcad;');
   Memo1.Lines.Append('- в теоретической части 2 раздела - привести расчётные формулы Ньютона для интерполяции и экстраполяции в начале и в конце таблицы, дать формулы для оценки погрешности; в практической части привести исходную таблицу,');
   Memo1.Lines.Append('дополнив её таблицей конечных разностей, и результаты расчёта с оценкой погрешности, проверив их в системе Mathcad;');
   Memo1.Lines.Append('- в разделе 3 обосновать выбор эмпирической зависимости и, используя метод наименьших квадратов, определить параметры выбранной зависимости; привести график эмпирической зависимости, проходящий через поле экспериментальных данных;');
   Memo1.Lines.Append('- в приложении к отчёту дать листинг разработанных програм.');
   Memo1.Lines.Append('');
   Memo1.Lines.Append('Отчет должен быть представлен преподавателю и защищён на следующем лабораторном занятии.');
   end;
3: begin
   Memo1.Lines.Append('- отчет должен содержать два раздела: численное интегрирование; решение дифференциальных уравнений;');
   Memo1.Lines.Append('- в теоретической части каждого раздела должны быть приведены расчётные формулы, формулы для оценки погрешности, графики, поясняющие суть методов;');
   Memo1.Lines.Append('- в практической части каждого раздела необходимо привести: графики подинтегральных функций в заданных пределах с вычисленным значением');
   Memo1.Lines.Append('интеграла (при численном интегрировании), расчетную таблицу и график интегральной кривой (при решении дифференциального уравнения);');
   Memo1.Lines.Append('- в приложении к отчёту дать листинг разработанных програм.');
   Memo1.Lines.Append('');
   Memo1.Lines.Append('Отчет должен быть представлен преподавателю и защищён на следующем лабораторном занятии.');
   end;

end;

end
end;


procedure TForm1.Label4Click(Sender: TObject);
begin
trebotch
end;

procedure lab1zagr;
var
int:string[15];
ur:string[30];
f:text;
i:integer;
begin
inter:='';uravn:='';
{$I-}
assign(f,'.\lab\lab1.txt');
reset(f);
{$I+}
if ioresult<>0 then
Application.MessageBox('Файл Lab1.txt не найден!','Open Error',
MB_OK) else begin
repeat
readln(f,i,int,ur);
until (i=form1.combobox1.ItemIndex+1) or eof(f);
close(f);
if (i<>form1.combobox1.ItemIndex+1) then begin
Application.MessageBox('В файле нет нужного варианта!','Error',
MB_OK);
inter:='нет данных';uravn:='нет данных';
end else begin
inter:=int;uravn:=ur;
end
end;
end;

procedure lab2zagr;
var
sis1,sis2:tsistem1;
sis3:tsistem3;
sis4:tsistem4;
f:text;
i:integer;
begin
sis1[1]:='';sis1[2]:='';sis1[3]:='';sis1[4]:='';
sis2[1]:='';sis2[2]:='';sis2[3]:='';sis2[4]:='';
sis3[1]:='';sis3[2]:='';sis3[3]:='';
sis2[1]:='';sis2[2]:='';
{$I-}
assign(f,'.\lab\lab2.txt');
reset(f);
{$I+}
if ioresult<>0 then
Application.MessageBox('Файл Lab2.txt не найден!','Open Error',
MB_OK) else begin
repeat
readln(f,i,sis1[1],sis1[2],sis1[3],sis1[4]);
readln(f,sis2[1],sis2[2],sis2[3],sis2[4]);
readln(f,sis3[1],sis3[2],sis3[3]);
readln(f,sis4[1],sis4[2]);
until (i=form1.combobox1.ItemIndex+1) or eof(f);
close(f);
if (i<>form1.combobox1.ItemIndex+1) then begin
Application.MessageBox('В файле нет нужного варианта!','Error',
MB_OK);
sistem1[1]:='нет данных';
sistem2[1]:='нет данных';
sistem3[1]:='нет данных';
sistem4[1]:='нет данных';
end else begin
sistem1:=sis1;
sistem2:=sis2;
sistem3:=sis3;
sistem4:=sis4;
end
end;
end;

procedure lab3zagr;
var
lagr1:tlagr1;
lagr2:tlagr2;
lagr:string[10];
newt1:tnewt1;
newt2:tnewt2;
newt:string[60];
naimk1:tnaimk;
naimk2:tnaimk;
f:text;
i,k,s,l,b:integer;
begin
for i:=1 to 7 do begin
lagr1[i]:='';lagr2[i]:='' end;
lagr:='';
for i:=1 to 15 do begin
newt1[i]:='';newt2[i]:='' end;
newt:='';
for i:=1 to 10 do begin
naimk1[i]:='';naimk2[i]:='' end;
{$I-}
assign(f,'.\lab\lab3.txt');
reset(f);
{$I+}
if ioresult<>0 then
Application.MessageBox('Файл Lab3.txt не найден!','Open Error',
MB_OK) else begin
repeat
read(f,k);
read(f,l);
read(f,s);
read(f,b);
for i:=1 to l do
read(f,lagr1[i]);
for i:=1 to l do
read(f,lagr2[i]);
readln(f,lagr);
for i:=1 to s do
read(f,newt1[i]);
for i:=1 to s do
read(f,newt2[i]);
readln(f,newt);
for i:=1 to b do
read(f,naimk1[i]);
for i:=1 to b-1 do
read(f,naimk2[i]);
readln(f,naimk2[b]);
until (k=form1.combobox1.ItemIndex+1) or eof(f);
close(f);
if (k<>form1.combobox1.ItemIndex+1) then begin
Application.MessageBox('В файле нет нужного варианта!','Error',
MB_OK);
lagr:='нет данных';
newt:='нет данных';
naimk1[1]:='нет';
naimk2[1]:='данных';
end else begin
for i:=1 to l do begin
lagran1[i]:=lagr1[i];lagran2[i]:=lagr2[i] end;
lagran:=lagr;
for i:=1 to s do begin
newton1[i]:=newt1[i];newton2[i]:=newt2[i] end;
newton:=newt;
for i:=1 to b do begin
naimkvadr1[i]:=naimk1[i];naimkvadr2[i]:=naimk2[i] end;
end
end
end;

procedure lab4zagr;
var
int:tintegr;
pred:tpredel;
us:string[70];
f:text;
i,j,m:integer;
begin
for i:=1 to 4 do
int[i]:='';
for i:=1 to 3 do
pred[i]:='';
us:='';
{$I-}
assign(f,'.\lab\lab4.txt');
reset(f);
{$I+}
if ioresult<>0 then
Application.MessageBox('Файл Lab4.txt не найден!','Open Error',
MB_OK) else begin
repeat
read(f,i,m);
for j:=1 to 3 do
read(f,int[j],pred[j]);
read(f,int[4],us);
until (i=form1.combobox1.ItemIndex+1) or eof(f);
close(f);
if (i<>form1.combobox1.ItemIndex+1) then begin
Application.MessageBox('В файле нет нужного варианта!','Error',
MB_OK);
for i:=1 to 4 do
int[i]:='нет данных';
end else begin
metod:=m;
predel:=pred;
uslov:=us;
end;
integ:=int;
end;
end;


procedure TForm1.ComboBox1Change(Sender: TObject);
begin
if label2.font.color=clblue then zadan
end;

procedure TForm1.TabControl1Change(Sender: TObject);
begin
case tabcontrol1.tabindex of
0:label5.caption:='Численные методы решения нелинейных уравнений.';
1:label5.caption:='Методы решения систем уравнений.';
2:label5.caption:='Методы приближения функций.';
3:label5.caption:='Численное интегрирование и решение обыкновенных дифференциальных уравнений.';
end;
if label2.font.color=clblue then zadan else
if label3.font.color=clblue then trebprog else
trebotch
end;

end.
