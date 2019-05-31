`timescale 1ns / 1ns
module dataMemory (input clk, rst, memRead, memWrite,
                   input [31:0] address, writeData,  
                   output [31:0] readData);
                                
  reg [31:0] memory [0:99];
  integer i;
  
  always @ (negedge clk, posedge rst) begin
    if (rst) begin
      for (i = 0; i < 100; i = i + 1) begin
        memory[i] <= 0;
      end 
      memory[3] <= 32'b00000000000000000000000000000111;    
    end   
    else if (memWrite)
      memory[address] <= writeData;
  end
  assign readData = memory[address];
endmodule