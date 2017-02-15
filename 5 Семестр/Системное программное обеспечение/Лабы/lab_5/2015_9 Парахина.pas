procedure ONE;
var A,B,C:integer;
begin
    A:=4;
	B:=A+10;
	C:=B+8;
end;

procedure TWO;
var D,E,F:integer;
begin
	F:=5;
    D:=(E+4)*F;
    F:=(E+4);
    end;

var K,L:integer;
begin
    K:=10;
    If K>11 then ONE
    Else TWO;
    L:=K-1;
end.
