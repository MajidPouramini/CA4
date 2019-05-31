`timescale 1ns / 1ns
module comparator (input [31:0] a, b, 
                   output equal);
                   
  assign equal = (a == b) ? 1'b1 : 1'b0;
endmodule