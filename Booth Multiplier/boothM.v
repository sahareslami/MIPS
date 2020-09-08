`timescale 1 ns/100 ps



module multiply3 (input reset,
              input start,
              output reg[16:0] product,
              input[7:0] multiplier,
              input[7:0] multiplicand,
              input clk,
              output reg done);
              
    parameter S0 = 2'b 00,S1 = 2'b 01, S2 = 2'b 10 , S3 = 2'b 11;
    reg[1:0] state;
    reg[3:0] counter;
    wire[7:0] multiplicand_neg = (2 ** 8)  - multiplicand;
    
    
    always@(posedge clk,reset)begin
      if(reset)begin
        done = 0;
        state = S0;
      end
    else begin
      case(state)
        S0:
          if(start)begin
            counter = 8;
            product = {8'b 0 , multiplier , 1'b 0};
            state = S1;
            done = 0;
         end
        S1:begin
        if(counter != 0)begin
           if(product[1:0] == 2'b 01)
            product[16:9] =   product[16:9] + multiplicand;
           if(product[1:0] == 2'b 10)
             product[16:9] =  product[16:9] + multiplicand_neg;
           state = S2;
         end
       else begin
             if(product[16] == 1'b 1)
			         product = {1'b 1,product[16:1]};
	          	else
			         product = product >> 1;

        state = S3;
      end
	end
      S2:begin
          if(product[16] == 1'b 1)
			product = {1'b 1,product[16:1]};
		else
			product = product >> 1;
          state = S1;
          counter = counter - 1;
      end
      S3:begin
       
          done = 1;
      end
    endcase      
  end
end
endmodule








module tbbm;
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
	#10 inp1 = -10;
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

boothM U1 (.reset(rst), .start(start) , .product(prod) , .multiplier(inp1) , .multiplicand(inp2) , .clk(clk) , .done(rdy));

endmodule
