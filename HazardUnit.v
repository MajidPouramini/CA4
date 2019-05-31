`timescale 1ns / 1ns
module hazardUnit (input memRead, 
                   input [4:0] rt, rs, EXERt,
                   output reg IFIDWrite, PCWrite, setZero);
                
always @ (*) begin
  if (memRead & ((rt == EXERt) || (rs == EXERt))) begin
      IFIDWrite <= 0;
      PCWrite <= 0;
      setZero <= 1;
  end
  else begin
    PCWrite <= 1;
    IFIDWrite <= 1;
    setZero <= 0;
  end
end

endmodule