module Adder(input[31:0] a,
            input[31:0] b,
            output reg[31:0] result);
    always@(a , b) 
        result = a + b;  
endmodule