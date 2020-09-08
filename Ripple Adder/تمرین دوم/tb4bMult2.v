module tbmult;
reg [3:0] inp1, inp2;
wire [7:0] result;

initial
begin
	inp1 = 0;
	inp2 = 0;
end

always
begin
	#10 inp1 = 1;
	#10 inp2 = 0;
	#10 inp1 = 10;
	#10 inp2 = 20;
	#10 inp1 = 12;
	#10 inp2 = 13;
	
	
end

multiply4bits mult4 (result, inp1, inp2);

endmodule;
