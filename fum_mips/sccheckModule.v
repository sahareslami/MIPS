module checkModule;
  reg[31:0] pcin;
  reg clk;

  PC pec(.pcin(pcin) , .clk(clk) , .pcout(pcout));

    initial begin
       clk=1'b0;
       #5
       pcin = 32'b 1001;
     end
    initial repeat(1000)#2 clk=~clk;
     endmodule
     