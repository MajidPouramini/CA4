`timescale 1ns / 1ns
module TB ();
  reg clk = 1'b0;
  reg rst = 1'b0;
  pipeline MA(clk, rst);
  
  always #100 clk = ~clk;
  
  initial begin
    #50
    rst = 1'b1;
    #100
    rst = 1'b0;
    #10000
    $stop;
  end
endmodule