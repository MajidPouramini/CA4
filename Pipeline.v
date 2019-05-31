`timescale 1ns / 1ns
module pipeline(input clk, rst);
  
  wire memRead, memWrite, ALUSrc, regDst, writeBack, /*mtor (DEL),*/ flush, equal /*,regWrite (DEL)*/;
  wire [1:0] PCSrc;
  wire [2:0] ALUOp;
  wire [5:0] opcode, func;
  
  dataPath DP(clk, rst, memRead, memWrite, ALUSrc, regDst, writeBack, flush,/*regWrite (DEL),*/ ALUOp, PCSrc, equal, opcode, func);
  controller CNTRL(equal, opcode, func, memRead, memWrite, ALUSrc, regDst, writeBack, /*mtor (DEL),*/ flush, /*regWrite (DEL),*/ PCSrc, ALUOp);
  
endmodule