`timescale 1 ns/100 ps



module faster(input clk,
               input reset,
               input start,
               input[7:0] multiplicand,
               input[7:0] multiplier,
               output reg[16:0] product,
               output reg done);
               
               
    parameter S0 = 2'b 00;
    parameter S1 = 2'b 01;
    parameter S2 = 2'b 10;
    parameter S3 = 2'b 11;
    reg[7:0] multiplier_copy;
    reg[16:0] multiplicand_copy;
    reg[1:0] state;
    reg[3:0] counter;
    
    
    always@(posedge clk , reset)begin
      if(reset) begin
        state = S0;
        done = 1'b 0;
      end
      else if(clk) begin
        case(state)
          S0:begin
            if(start)begin
              counter = 8;
              state = S1;
              multiplier_copy = multiplier;
              multiplicand_copy = {9'b 0, multiplicand};
              product = 0;
              done = 0;
              end
            end 
          S1: 
              if(counter != 0)begin
                 if(multiplier_copy[0] == 1) 
                     product = multiplicand_copy + product;
                state = S2;
              end
              else
                state = S3;
          S2:begin
              multiplicand_copy = multiplicand_copy << 1;
              multiplier_copy = multiplier_copy >> 1;
              counter = counter - 1;
              state = S1;
            end
          S3:
              done = 1'b 1;  
       endcase       
      end
    end
endmodule








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
	#10 inp1 = 2'b 10;
	    inp2 = 2'b 11;
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

faster #(.S0(2'b 00), .S1(2'b 01), .S2(2'b 10) , .S3(2'b 11)) U1 (.clk(clk) , .reset(rst) , .start(start), .multiplier(inp1) , .multiplicand(inp2) , .product(prod) , .done(rdy));
//multiply U1l (rst, start, prod, inp1, inp2, clk, rdy);
endmodule



