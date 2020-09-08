
module FA(input a,
          input b,
          input cin,
          output sum,
          output cout);
          assign sum = a ^ b ^ cin;
          assign cout = (a & b) | (a & cin) | (cin & b);
endmodule



module BWmul4bits(input[3:0] a,
                  input[3:0] b,
                  output[7:0] p);
      
      wire s[6:0];
      wire c[11:0];
      assign p[0] = a[0]&b[0];
      
      //baugh wooley adder is same as unsigned multiplier for bits under n - 1
      //p[1] = a[0]*b[1] + a[1] * b[0]
      
      FA HA1(.a(a[0]&b[1]),.b(a[1]&b[0]) , .cin(1 'b 0) , .sum(p[1]) , .cout(c[0]));
      
      //p[2] = a[1]*b[1] + b[2] * a[0] + b[0] * a[2] + c[1]
      
      FA FA1(.a(a[1]&b[1]) ,.b(a[0]&b[2]), .cin(c[0]) , .sum(s[0]) , .cout(c[1]));
      FA HA2(.a(a[2]&b[0]) ,.b(s[0]) ,.cin(1'b 0) ,.sum(p[2]), .cout(c[2]));
      
      // p[3] = ~(a[0] * b[3]) + a[1] * b[2] + a[2] * b[1] + ~a[3] * b[0] + c[1] + c[2];
      FA FA2(.a(~(a[0]&b[3])) , .b(b[2]&a[1]) , .cin(c[1]) , .sum(s[1]) , .cout(c[3]));
      FA FA3(.a(a[2]&b[1]) , .b(s[1]) , .cin(c[2]) , .sum(s[3]) , .cout(c[4]));
      FA HA3(.a(~(a[3]&b[0])) , .b(s[3]) , .cin(1'b 0) , .sum(p[3]) , .cout(c[5]));
      
      //p[4] = ~(b[3]*a[1]) + a[2]*b[2] + ~(a[3]*b[1]) + 1 + c[3] + c[4] + c[5];
      FA FA4(.a(~(b[3]&a[1])) , .b(a[2]&b[2]) , .cin(c[3]) , .sum(s[4]) , .cout(c[6]));
      FA FA5(.a(~(a[3]&b[1])) , .b(s[4]) , .cin(c[4]) , .sum(s[5]) , .cout(c[7]));
      FA FA6(.a(1'b 1) , .b(s[5]) , .cin(c[5]) , .sum(p[4]) , .cout(c[8]));
      
      
      //p[5] = ~(a[3]*b[1]) + ~(a[1]*b[3]) + c[8] + c[7] + c[6];
      FA FA7(.a(~(a[3]&b[2])) , .b(~(a[2]&b[3])) , .cin(c[6]) , .sum(s[6]) , .cout(c[9]));
      FA FA8(.a(c[7]) , .b(s[6]) , .cin(c[8]) , .sum(p[5]) , .cout(c[10]));
      
      //p[6] = a[3]*b[3] + c[10] + c[9]
      FA FA10(.a(a[3]&b[3]) , .b(c[10]) , .cin(c[9]) , .sum(p[6]) , .cout(c[11]));
      
      
      //p[7] = c[11] + 1
      FA HA4(.a(c[11]) , .b(1'b 1) , .cin(1'b 0) , .sum(p[7]) , .cout(cout));
                  
endmodule;

module tbBWmultiplier;
reg[3:0] inp1,inp2;
wire[7:0] product;


initial 
begin
  inp1 = 0;
  inp2 = 0;
end


always
begin
    #10 inp1 = 4'b 1001;
    #10 inp2 = 4'b 0011;
    #10 inp1 = 4'b 0001;
    #10 inp2 = 4'b 0101;
    #10 inp1 = 4'b 1101;
    #10 inp2 = 4'b 1111;
    #10 inp1 = 4'b 0010;
    #10 inp2 = 4'b 1010;
    #10 inp1 = 4'b 1100;
    #10 inp2 = 4'b 1010;
    #10 inp1 = 4'b 1011;
    #10 inp2 = 4'b 0100;
    #10 inp1 = 4'b 1100;
    #10 inp2 = 4'b 0100;
    #10 inp1 = 4'b 0111;
    #10 inp2 = 4'b 0000;
    #10 inp1 = 4'b 0010;
    #10 inp2 = 4'b 0010;
    #10 inp1 = 4'b 1011;
    #10 inp2 = 4'b 0001;
    #10 inp1 = 4'b 1111;
    #10 inp2 = 4'b 1111;
    #10 inp1 = 4'b 1001;
    inp2 = 4'b 1000; 
    end
    BWmul4bits BWM(.a(inp1) , .b(inp2) , .p(product));
endmodule 
