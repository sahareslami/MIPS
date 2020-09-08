module controlUnit(input[5:0] opcode,
                  input[5:0] functions,
                  output reg RegDst,
                  output reg jump,
                  output reg branch,
                  output reg memRead, 
                  output reg [1:0] memtoReg,
                  output reg isbeq,
                  output reg memWrite,
                  output reg alusrc,
                  output reg RegWrite,
                  output reg[3:0] aluop);
    always@(opcode , functions)begin
      //R type
      if(opcode == 6'b 0)begin
        RegDst = 1;
        alusrc = 0;
        RegWrite = 1;
        memtoReg = 2'b 00;
        memRead = 0;
        memWrite = 0;
        branch = 0;
        jump = 0;
        isbeq = 1'b x;
        //ADD
        if(functions == 6'b 100000)
          aluop = 4'b 0000;
        //SUb
     	 else if(functions == 6'b 100010)
          aluop = 4'b 0001;
        //And
       else  if(functions == 6'b 100100)
          aluop = 4'b 0010;
        //Or
       else if(functions == 6'b 100101)
            aluop = 4'b 0011;
        //slt 
       else if(functions == 6'b 101010)
           memtoReg[0] = 1'b 1;
    end
    //jump
    else if(opcode == 6'b 000010)begin
      RegDst = 0;
      alusrc = 0;
      memtoReg = 0;
      RegWrite = 0;
      memRead = 0;
      memWrite = 0;
      branch = 0;
      jump = 1;
      aluop = 4'b x;
      isbeq = 1'b 0;
    end
  //I type
  else if(opcode == 6'b 001000 || opcode == 6'b 001100 || opcode  == 001101 || opcode == 6'b 001010)begin
    RegDst = 0;
    alusrc = 1;
    memtoReg = 2'b 00;
    RegWrite = 1;
    memRead = 0;
    memWrite = 0;
    branch = 0;
    jump = 0;
    isbeq = 1'b x;
    
    //ADDi
    if(opcode == 6'b 001000)
        aluop = 4'b 0000;
    //Andi
    else if(opcode == 6'b 001100)
       aluop = 4'b 0010;
    //Ori
    else if(opcode == 6'b 001101)
       aluop = 4'b 0011;
    //slti
    else if(opcode == 6'b 001010)
       memtoReg[0] = 1'b 1;
  end 
  //lw
else if(opcode == 6'b 100011)begin
    RegDst = 0;
    alusrc = 1;
    memtoReg = 2'b 10;
    RegWrite = 1;
    memRead = 1;
    memWrite= 0;
    branch = 0;
    jump = 0;
    isbeq = 1'b x;
    aluop = 4 'b 0000;
  end
  
  
  //sw
else if(opcode == 6'b 101011)begin
    RegDst = 0;
    alusrc = 1;
    memtoReg = 2'b x;
    RegWrite = 0;
    memRead= 0;
    memWrite = 1;
    branch = 0;
    jump = 0;
    aluop = 4'b 0000;
    isbeq = 1'b x;
  end
  
  //beq
else if(opcode == 6'b 000100)begin
    RegDst = 0;
    alusrc = 0;
    memtoReg = 2'b x;
    branch = 1;
    RegWrite = 0;
    memRead = 0;
    memWrite= 0 ;
    jump = 0;
    isbeq = 1;
    aluop = 4'b x; 
  end
  
  //bne
else if(opcode == 6'b 000101)begin
    RegDst = 0;
    alusrc = 0;
    memtoReg = 2'b x;
    branch = 1;
    RegWrite = 0;
    memRead = 0;
    memWrite= 0 ;
    jump = 0;
    isbeq = 0;
    aluop = 4'b x; 
  end
end
      
endmodule 
  
                
                  