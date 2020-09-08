module Fum_mips(input[31:0] initPc);
  
  reg clk;
  initial clk = 1'b 0;
  initial repeat(1000)#700 clk=~clk;

  //control signals             
  wire regDst , jump , branch , memRead , memWrite , aluSrc , regWrite, isbeq;
  wire[1:0] memtoReg;
  wire[3:0] aluOp; 
  //pc output 
  wire[31:0]  pc;
  
  
  //instruction
  wire[31:0] ins;
  
  
  //register file's output
  wire[31:0] readData1 , readData2;
  
  
  //Alu output
  wire zero;
  wire [31:0] aluOut;
  wire lt,gt;
  
  //data memory out
  wire[31:0] memReadData;
  
  //pc + 4;
  wire[31:0] nfpc;
  

  //adder2 out :  branch addres
  wire[31:0] branchedPc;
  
  
  
  //write reg address mux
  wire[4:0] WrRegAd;
  assign WrRegAd = (regDst == 1'b 0) ? ins[20:16] : ins[15:11];
  
  
//write reg input mux 
  
  wire[31:0] WrRegData;
  assign WrRegData = (memtoReg[1] == 1'b 0)? ((memtoReg[0] == 1'b 1)? lt : aluOut) : memReadData;
  
  //signExtend the immediate
  wire[31:0] signedImm;
  assign signedImm =   {{16{ins[15]}}, ins[15:0]};
  
  //alu src data mux
  wire[31:0] aluSrcData;
  assign aluSrcData = (aluSrc == 1'b 1) ? signedImm : readData2;

  // shifted immediate for branch
  wire[31:0] shiftedImm;
  assign shiftedImm = signedImm ;
  
  
  //is bne or beq mux
  wire whichBranch;
  assign whichBranch = (isbeq == 1'b 1) ? zero : ~zero;
  
  //branch taken or not mux
  wire[31:0] branchedPcOut;
  assign branchedPcOut = ((whichBranch & branch) == 1'b 1)? branchedPc : nfpc;
  
  //is jump or not
  wire[31:0] npc;
  assign npc = (jump == 1'b 0)? branchedPcOut : {nfpc[31:28] , ins[27:0]};
  
  

  PC pcu(.pcin(npc) , .clk(clk) , .pcout(pc) , .initPc(initPc));
  //checked
  IMemBank insBank(.memread(1'b 1) , .address(pc[7:0]) , .readdata(ins));
 //checked
  DMemBank dataBank(.memread(memRead) , .memwrite(memWrite) , .address(aluOut[7:0]) ,
           .writedata(readData2) , .readdata(memReadData));
           
  RegFile registers(.clk(clk) , .readreg1(ins[25:21]) , .readreg2(ins[20:16]) , .writereg(WrRegAd) 
                   , .writedata(WrRegData) , .RegWrite(regWrite) , .readdata1(readData1) , .readdata2(readData2));
  //checked 
  ALU alu0(.data1(readData1) , .data2(aluSrcData) , .aluoperation(aluOp) , .result(aluOut) , .zero(zero) , .lt(lt) , .gt(gt));
  //checked
  Adder adder1(.a(pc) , .b(32'b 1) , .result(nfpc));
  //checked 
  Adder adder2(.a(nfpc) , .b(shiftedImm) , .result(branchedPc));  
  
  controlUnit control(.opcode(ins[31:26]) , .functions(ins[5:0]) ,
                      .RegDst(regDst) , .jump(jump) , .branch(branch) , .memRead(memRead) , 
                      .memtoReg(memtoReg) , .isbeq(isbeq) , .memWrite(memWrite) , .alusrc(aluSrc) ,
                       .RegWrite(regWrite) , .aluop(aluOp));
  
                       
                       
  
 endmodule


module testBenchMips;
  reg clk;
  reg[31:0] pc;
 
 Fum_mips mips(.clk(clk) , .initPc(pc));
 
initial begin
 
  clk = 1'b 0;
  pc = 32'b 0;
 
end
  initial repeat(1000)#700 clk=~clk;
endmodule 
  

          


