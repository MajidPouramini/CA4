`timescale 1ns/1ns
module mux3_32bit (input [1:0] sel,
                   input [31:0] a, b, c, 
                   output [31:0] out);                 
  assign out = (sel == 2'b00) ? a :
               (sel == 2'b01) ? b :
               (sel == 2'b10) ? c :
               32'bx;
endmodule

module mux2_32bit(input sel, 
                  input [31:0] a, b, 
                  output [31:0] out);
                  
  assign out = ~sel ? a : b;
endmodule

module mux2_5bit (input sel,
                  input [4:0] a, b,
                  output [4:0] out);
  assign out = ~sel ? a : b;
endmodule

module inOrZero (input sel, aIn, bIn, cIn, dIn, eIn,
                 input [2:0] ALUOp,
                 output aOut, bOut, cOut, dOut, eOut,
                 output [2:0] ALUOpOut);           
  assign {aOut, bOut, cOut, dOut, eOut, ALUOpOut} = sel ? 0 : {aIn, bIn, cIn, dIn, eIn, ALUOp};
endmodule