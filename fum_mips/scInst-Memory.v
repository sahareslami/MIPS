//memory unit
module IMemBank(input memread, input [7:0] address, output reg [31:0] readdata);
 
  reg [31:0] mem_array [63:0];
  
  integer i;
  initial begin
   mem_array[0] = 32'b 00100000000000001111111111111111;
   mem_array[1] = 32'b 00100000000000100001111101000000;
   mem_array[2] = 32'b 00000000000000000001100000100000;
   mem_array[3] = 32'b 00101000011001000000000000001010;
   mem_array[4] = 32'b 00010000100000000000000000001011;
   mem_array[5] = 32'b 00000001111000110011000000100000;
   mem_array[6] = 32'b 10001100110001110000000000000000;
   mem_array[7] = 32'b 00000000111000100100000000101010;
   mem_array[8] = 32'b 00010001000000000000000000000010;
   mem_array[9] = 32'b 00000000000001110001000000100000;
   mem_array[10] = 32'b 00001000000000000000000000001110;
   mem_array[11] = 32'b 00000000001001110100000000101010;
   mem_array[12] = 32'b 00010001000000000000000000000001;
   mem_array[13] = 32'b 00000000000001110000100000100000;
   mem_array[14] = 32'b 00100000011000110000000000000001;
   mem_array[15] = 32'b 00001000000000000000000000000011;
   mem_array[16] = 32'b 10101100000000010000000000010100;
   mem_array[17] = 32'b 10101100000000100000000000011000;

  end
 
  always@(memread, address, mem_array[address])
  begin
    if(memread)begin
      readdata=mem_array[address];
    end
  end

endmodule

module testBenchIMem;
  reg memread;              /* rw=RegWrite */
  reg [7:0] adr;  /* adr=address */
  wire [31:0] rd; /* rd=readdata */
  
  memBank u0(memread, adr, rd);
  
  initial begin
    memread=1'b0;
    adr=16'd0;
    
    #5
    memread=1'b1;
    adr=16'd0;
  end
  
  initial repeat(127)#4 adr=adr+1;
  
endmodule;
