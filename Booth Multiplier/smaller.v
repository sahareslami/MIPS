`timescale 1 ns/100 ps



module smaller(input clk,
              input reset,
              input start,
              input[7:0] multiplier,
              input[7:0] multiplicand,
              output reg[16:0] product,
              output reg done);
    parameter S0 = 2'b 00, S1 = 2'b 01,S2 = 2'b 10 , S3 = 2'b 11;
    reg[3:0] counter;
    reg[1:0] state;
    always@(posedge clk,reset)begin
            if(reset)begin 
              done = 0;
              state = S0;
            end
          else begin
            case(state)
              S0:
                  if(start)begin
                    product = {9'b 0,multiplier};
                    counter = 4'b 1000;
                    done = 1'b 0;
                    state = S1;
                  end 
            S1:
                if(counter != 4'b 0)begin
                  if(product[0] == 1'b 1)begin
                       //product = product + multiplicand_copy;
                       product[16:8] = product[15:8] + multiplicand;
                  end
                  state = S2;
                end
              else
                  state = S3;
            S2:begin
                  product = product >> 1;
                  counter = counter - 1;
                  state = S1;  
                end     
            S3:
                done = 1;    
          endcase
        end          
    end
      
      
endmodule




module tbsmaller;
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
	#10 inp1 = 255;
	    inp2 = 250;
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

smaller U1 (.reset(rst) , .start(start) , .product(prod) , .multiplicand(inp1) , .multiplier(inp2) , .clk(clk), .done(rdy));

endmodule

