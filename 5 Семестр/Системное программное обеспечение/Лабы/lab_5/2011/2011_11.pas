procedure AAA;
var A,B:real;
begin
   A:=3;
   B:=A+1;
   B:=15;
   A:=A+1;
end;
procedure BBB;
var A,C:integer;
begin
   A:=8;
end;
var A,B,C:integer;
begin
   A:=C+1;
   if A=5 then BBB
   else AAA;
end.