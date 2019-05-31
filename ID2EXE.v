`timescale 1ns / 1ns
module ID2EXE (input clk, rst,
               input /*regWriteIn,*/ memReadIn, memWriteIn, writeBackIn, ALUSrcIn, regDstIn,
               input [2:0] aluOpIn,
               input [4:0] destRegIn, src1RegIn, src2RegIn,
               input [31:0] readData1In, readData2In, SEIn,
               output reg memReadOut, memWriteOut, writeBackOut, ALUSrcOut, regDstOut, //regWriteOut,
               output reg [2:0] aluOpOut,
               output reg [4:0] destRegOut, src1RegOut, src2RegOut,
               output reg [31:0] readData1Out, readData2Out, SEOut);
               
  always @ (posedge clk) begin
    if (rst) begin
      {memReadOut, memWriteOut, writeBackOut, aluOpOut, destRegOut,
       readData1Out, readData2Out, src1RegOut, src2RegOut} <= 0;
    end
    else begin
      memReadOut <= memReadIn;
      memWriteOut <= memWriteIn;
      writeBackOut <= writeBackIn;
      aluOpOut <= aluOpIn;
      destRegOut <= destRegIn;
      readData1Out <= readData1In;
      readData2Out <= readData2In;
      SEOut <= SEIn;
      ALUSrcOut <= ALUSrcIn;
      regDstOut <= regDstIn;
      src1RegOut <= src1RegIn;
      src2RegOut <= src2RegIn;
      //regWriteOut <= regWriteIn;
    end
  end
endmodule