procedure CCC;
var K,M:integer;
begin
    K:=10;
    M:=M+5;
end;
procedure DDD;
var K,B:integer;
begin
    B:=10;
    K:=B+6;
end;
var B,C:integer;
begin
    B:=K+5;
    if K>2 then B:=(K+5)-(K+4)
    else CCC;
    DDD;
end.
