`timescale 1ns / 1ns
module shifter32to32 (input [31:0] in, output [31:0] out);
  assign out = (in != 32'bx) ? {in [30:0], 2'b00} : 32'bx;
endmodule


module shifter26to28 (input [25:0] in, output [27:0] out);
  assign out = (in != 26'bx) ? {in, 2'b00} : 28'bx;
endmodule