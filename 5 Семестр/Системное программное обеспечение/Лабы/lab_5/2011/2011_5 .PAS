procedure FFF;
var K,M:integer;
begin
    K:=12;
    M:=(K+7)-(K-1);
end;
procedure BBB;
var K,B:integer;
begin
    B:=10;
    K:=B-6;
end;
var B,K:integer;
begin
    B:=K-3;
    K:=K-3;
    if K>2 then B:=K-1
    else FFF;
     BBB;
end.
