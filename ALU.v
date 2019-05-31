`timescale 1ns / 1ns
module alu (input [2:0] op,
            input [31:0] a, b,  
            output [31:0] res);
           
  assign res = (op == 3'b000) ? a + b :
               (op == 3'b001) ? a - b :
               (op == 3'b010) ? a & b :
               (op == 3'b011) ? a | b :
               (op == 3'b100) ? a < b :
               32'bx;
endmodule