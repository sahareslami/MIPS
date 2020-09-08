
`timescale 1 ns/100 ps

module tb;
reg clk,rst;
reg [7:0] inp1;
reg [7:0] inp2;
wire [16:0] prod;
reg start;
wire rdy;

initial
begin
	clk = 0;
	rst = 1;
	#10 inp1 = 10;
	    inp2 = 11;
	#22 rst = 0;
	#1  start = 1;
	@(posedge rdy);
	start = 0;
	#10;
	rst = 1;
	#10 inp1 = 14;
	    inp2 = 13;
	#22 rst = 0;
	start = 1;
	@(posedge rdy);
	start = 0;
	#100;
	rst = 1;
	#10 inp1 = 24;
	    inp2 = 34;
	#22 rst = 0;
	start = 1;
	@(posedge rdy);
	start = 0;
	#100;
	rst = 1;
	#10 inp1 = 76;
	    inp2 = 98;
	#22 rst = 0;
	start = 1;
	@(posedge rdy);
	start = 0;
	#100;
	rst = 1;
	#10 inp1 = 101;
	    inp2 = 102;
	#22 rst = 0;
	start = 1;
	
end


always 
begin
	#3 clk = ~clk;
end

multiply U1 (rst, start, prod, inp1, inp2, clk, rdy);

endmodule;
