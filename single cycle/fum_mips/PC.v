module PC(input[31:0] pcin,
          input clk,
          input[31:0] initPc,
          output reg[31:0] pcout);
      initial pcout = initPc;
      always@(posedge clk)
          pcout <= pcin;     
endmodule


module TestBenchPc;
  reg[31:0] pcin;
  reg clk;
  wire pcout;
  
  PC pec(.pcin(pcin) , .clk(clk) , .pcout(pcout));

  initial begin
       clk=1'b0;
       #5
       pcin = 32'b 1001;
  end
  
  initial repeat(1000)#2 clk=~clk;
  initial repeat(15)#4 pcin = pcin +4'b 1010;
endmodule
     
