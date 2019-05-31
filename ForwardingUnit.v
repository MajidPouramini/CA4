`timescale 1ns / 1ns
module forwardingUnit (input MEMWriteBack, WBWriteBack,
                       input [4:0] MEMDest, WBDest, EXERt, EXERs,
                       output reg [1:0] forwardingA, forwardingB);

  always @ (*) begin
    {forwardingA, forwardingB} <= 0;
    
    if (MEMWriteBack && EXERt == MEMDest) forwardingA <= 2'b01;
    else if (WBWriteBack && EXERt == WBDest) forwardingA <= 2'b10;

    if (MEMWriteBack && EXERs == MEMDest) forwardingB <= 2'b01;
    else if (WBWriteBack && EXERs == WBDest) forwardingB <= 2'b10;
  end
endmodule