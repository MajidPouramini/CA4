`timescale 1ns / 1ns
module MEM2WB (input clk, rst,
               input writeBackIn, memReadIn, //regWriteIn,
               input [4:0] destRegIn,
               input [31:0] ALUResIn, memDataIn,
               output reg writeBackOut, memReadOut, //regWriteOut,
               output reg [4:0] destRegOut,
               output reg [31:0] ALUResOut, memDataOut);

  always @ (posedge clk) begin
    if (rst) begin
      {writeBackOut, memReadOut, destRegOut, ALUResOut, memDataOut} <= 0;
    end
    else begin
      writeBackOut <= writeBackIn;
      memReadOut <= memReadIn;
      destRegOut <= destRegIn;
      ALUResOut <= ALUResIn;
      memDataOut <= memDataIn;
      //regWriteOut <= regWriteIn;
    end
  end
endmodule