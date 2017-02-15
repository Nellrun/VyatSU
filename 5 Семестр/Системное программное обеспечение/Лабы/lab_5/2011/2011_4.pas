procedure first;
var X,Z:integer;
begin
    X:=2;
    Z:=X+12;
end;
procedure second;
var A,B:integer;
begin
    A:=23;
    B:=(A+12)-(10-A)+46;	
end;
var A,B,C:integer;
begin
    first;
    second;
   C:=B+5;
    A:=12;
    B:=A+2;
    C:=B+5;
    C:=C-(A+10);
    if C<7 then C:=B+A else A:=B+C;
    B:=A+2;
end.
