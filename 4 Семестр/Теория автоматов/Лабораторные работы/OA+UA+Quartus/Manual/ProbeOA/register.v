module Register (DI,C,R, DO);
parameter n=9;
input [n-1:0] DI;
input C,R;
output [n-1:0] DO;
reg [n-1:0] DO;


always @(posedge C or posedge R)
begin
if (R==1)
	DO=0;
else DO=DI;
end
endmodule
