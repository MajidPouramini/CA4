`timescale 1ns/1ns

module IF2ID (input clk, rst, flush, ld,
              input [31:0] PCIn, instIn, 
              output reg [31:0] PCOut, instOut);

  always @ (posedge clk) begin
    if (rst) begin
      PCOut <= 0;
      instOut <= 0;
    end
    else begin
      if (flush) begin
        instOut <= 0;
        PCOut <= 0;
      end
      else begin
        if (ld) begin
          instOut <= instIn;
          PCOut <= PCIn;
        end
      end
    end
  end
endmodule