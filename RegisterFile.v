`timescale 1ns / 1ns
module registerFile (input clk, rst, regWrite,
                     input [4:0] readReg1, readReg2, writeReg,
                     input [31:0] writeData,
                     output [31:0] readData1, readData2);
                    
  reg [31:0] registers [0:31];
  integer i;
  
  always @ (negedge clk, posedge rst) begin
    if (rst) begin
      for (i = 0; i < 32; i = i + 1) begin
        registers[i] <= 0;
      end  
      registers[1] <= 32'b00000000000000000000000000000001;
      registers[2] <= 32'b00000000000000000000000000000010;
      //registers[3] <= 32'b00000000000000000000000000000010;    
    end
    else if (regWrite) 
      registers[writeReg] <= writeData;
    registers[0] <= 0;
  end

  assign readData1 = registers[readReg1];
  assign readData2 = registers[readReg2];

endmodule