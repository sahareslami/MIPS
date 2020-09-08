module carrySkipAdder16(input[15:0] a,
                  input[15:0] b,
                  input cin,
                  output[15:0] sum,
                  output cout);
    wire p[2:0];
    wire c[3:0];
    
    
    skip sk0(.a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(c[0]), .p(p[0]));
    skip sk1(.a(a[7:4]), .b(b[7:4]), .cin(c[0]), .cout(c[1]), .p(p[1]));
    skip sk2(.a(a[11:8]), .b(b[11:8]) , .cin(c[1]) , .cout(c[2]) , .p(p[2]));
    skip sk3(.a(a[15:12]), .b(b[15:12]), .cin(c[2]) , .cout(c[3]) , .p(cout));
 

    rippleCarryAdder4 rca0(.A(a[3:0]), .B(b[3:0]), .cin(cin), .cout(c[0]), .S(sum[3:0]));
    rippleCarryAdder4 rca1(.A(a[7:4]), .B(b[7:4]), .cin(p[0]), .cout(c[1]), .S(sum[7:4]));
    rippleCarryAdder4 rca2(.A(a[11:8]), .B(b[11:8]), .cin(p[1]), .cout(c[2]) , .S(sum[11:8]));
    rippleCarryAdder4 rca3(.A(a[15:12]), .B(b[15:12]) , .cin(p[2]) , .cout(c[3]) , .S(sum[15:12]));                 
        
endmodule
            
module rippleCarryAdder4(input[3:0] A,
                        input[3:0] B,
                        input cin,
                        output[3:0] S,
                        output cout);
    wire c[2:0];
    FullAdderr fa0(.A(A[0]) , .B(B[0]) , .cin(cin)  , .cout(c[0]) , .sum(S[0]));
    FullAdderr fa1(.A(A[1]) , .B(B[1]) , .cin(c[0]) , .cout(c[1]) , .sum(S[1]));
    FullAdderr fa2(.A(A[2]) , .B(B[2]) , .cin(c[1]) , .cout(c[2]) , .sum(S[2]));
    FullAdderr fa3(.A(A[3]) , .B(B[3]) , .cin(c[2]) , .cout(cout) , .sum(S[3]));
                        
endmodule

module FullAdderr(input A,
                  input B,
                  input cin,
                  output sum,
                  output cout);
   assign sum = A ^ B ^ cin;
   assign cout = (A & B) | (B & cin) | (A & cin);
endmodule

//sahar nadem va pashiman az module nanevshtan


module skip(input[3:0] a,
            input[3:0] b,
            input cin,
            input cout,
            output p);  
    assign p = ((a[0] ^ b[0]) & (a[1] ^ b[1]) & (a[2] ^ b[2]) & (a[3] ^ b[3]) & cin) | cout;
   
        
endmodule



module tbAdder;
reg[15:0] inp1,inp2;
reg carryin;
wire carryout;
wire[15:0] sum;

initial begin
  inp1 = 0;
  inp2 = 0;
  carryin = 0;
end
always 
begin
  #10 inp1 = 16'd 1024;
  #10 inp2 = 16'd 300;
  #10 inp1 = 16'd 399;
  #10 inp2 = 16'd 11012;
  #10 inp1 = 16'd 1331;
  #10 inp2 = 16'd 1433;
  #10 inp1 = 16'd 6454;
  #10 inp2 = 16'd 1234;
  #10 inp1 = 16'd 1434;
  #10 inp2 = 16'd 444;
  #10 inp1 = 16'd 655;
  #10 inp2 = 16'd 245;
  #10 inp1 = 16'd 1123;
  #10 inp2 = 16'd 443;
  #10 inp1 = 16'd 1342;
  #10 inp2 = 16'd 5813;
  #10 inp1 = 16'd 827;
  #10 inp2 = 16'd 1374;
  #10 inp1 = 16'd 1375;
  #10 inp2 = 16'd 9083;
  #10 inp1 = 16'd 4587;
  #10 inp2 = 16'd 1435;
  #10 inp1 = 16'd 5675;
  #10 inp2 = 16'd 5786;
  #10 inp1 = 16'd 2345;
  #10 inp2 = 16'd 9;
  #10 inp1 = 16'd 1989;
  #10 inp2 = 16'd 3120;
  #10 inp1 = 16'd 3489;
  inp2 = 16'd 3478;
end

carrySkipAdder16 CSA(.a(inp1),.b(inp2) , .cin(carryin) , .sum(sum) , .cout(carryout));
endmodule 



                  