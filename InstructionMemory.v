`timescale 1ns / 1ns
module instructionMemory (input rst,
                          input [31:0] address, 
                          output [31:0] instruction);
                          
  reg [31:0] memory [0:99];
  
  always @ (*) begin
    if (rst) begin
      memory[0] <= 32'b00000000001000100001100000100000; // add r3, r1, r2
      memory[4] <= 32'b10001100010010110000000000000001; // lw r11, r2, 1
      memory[8] <= 32'b10101100010000110000000000000001; // sw r3, r1, 1
    end
  end
  
  assign instruction = memory[address];
  
endmodule