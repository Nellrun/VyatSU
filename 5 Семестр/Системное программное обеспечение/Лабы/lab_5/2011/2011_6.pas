procedure QQQ;
var A,B:integer;
begin
     A:=6;
     B:=5;
     B:=9-B;
end;

procedure YYY;
var C:integer;
begin
     C:=(A-4)+11;
     A:=(A-4)+C+11;
end;

var A,B,C:integer;
begin
    QQQ;
    YYY;
    if B<5 then C:=B-5 
    else C:=0
    A:=(C+3)-(B-5);
end.