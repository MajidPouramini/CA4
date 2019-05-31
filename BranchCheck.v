`timescale 1ns / 1ns
module branchCheck (input equal, input [5:0] opc, output reg flush, output reg [1:0] PCSrc);
  always @(*) begin
    if(opc == 6'b000100 & equal == 1'b1) begin
      PCSrc <= 2'b01;
      flush <= 1'b1;
    end
    else if(opc == 6'b000101 & equal == 1'b0) begin
      PCSrc <= 2'b01;
      flush <= 1'b1;
    end
  end
  
endmodule