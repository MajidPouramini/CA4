`timescale 1ns / 1ns
module EXE2MEM (input clk, rst,
                input writeBackIn, memReadIn, memWriteIn, //regWriteIn,
                input [4:0] destRegIn, RdIn,
                input [31:0] ALUResIn, writeDataIn,
                output reg writeBackOut, memReadOut, memWriteOut, //regWriteOut,
                output reg [4:0] destRegOut, RdOut,
                output reg [31:0] ALUResOut, writeDataOut);

  always @ (posedge clk) begin
    if (rst) begin
      {writeBackOut, memReadOut, memWriteOut, destRegOut, RdOut, ALUResOut, ALUResOut, writeDataOut} <= 0;
    end
    else begin
      writeBackOut <= writeBackIn;
      memReadOut <= memReadIn;
      memWriteOut <= memWriteIn;
      ALUResOut <= ALUResIn;
      destRegOut <= destRegIn;
      RdOut <= RdIn;
      writeDataOut <= writeDataIn;
      //regWriteOut <= regWriteIn;
    end
  end
endmodule