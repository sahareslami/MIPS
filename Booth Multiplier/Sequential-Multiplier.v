`timescale 1 ns/100 ps

module multiply(reset, start, product, multiplier, multiplicand, clk, done);

input clk;
input start;
input reset;
input [7:0] multiplier, multiplicand;
output reg [16:0] product;
output reg  done;

reg [7:0] multiplier_copy;
reg [16:0] multiplicand_copy;
reg [2:0] state;
reg [4:0] counter;


parameter S0=3'b000 , S1=3'b001 , S2=3'b010 , S3=3'b011 , S4=3'b100, S5=3'b101 ;

always @ (posedge clk, reset)begin

if (reset) begin
 state=S0;
 done = 0;
end
else if (clk) begin
case (state)
  
  S0:begin
  	if (start)
		counter=8;
		state=S1;
		multiplier_copy = multiplier;
		multiplicand_copy = {9'd0, multiplicand};
		product = 0;
		done = 0;
	end
  S1: if (counter != 0) begin
  	if (multiplier_copy[0]==1)
  		product = product + multiplicand_copy;
  	state=S2;
  	end
      else 
      	state=S5;
      
  S2: begin
	multiplier_copy = multiplier_copy >> 1;
	state = S3;
	end
  S3: begin
	multiplicand_copy = multiplicand_copy << 1;
	state=S4;
	end
  S4: begin
  	counter = counter - 1;
  	state=S1;
  	end
  S5:
  	done = 1;
endcase
end

end
endmodule