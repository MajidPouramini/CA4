`timescale 1ns / 1ns
module controller (input equal,
                   input [5:0] opcode, func, 
                   output memRead, memWrite, ALUSrc, regDst, writeBack, /*mtor,*/ flush,
                   //output regWrite,
                   output [1:0] PCSrc, 
                   output [2:0] ALUOp);
  
  //assign regWrite = ((opcode == 6'b100011) || (opcode == 6'b000000)) ? 1'b1 :
                   //1'b0; (DEL)
  
  assign memRead = (opcode == 6'b100011) ? 1'b1 :
                   1'b0;
  
  assign memWrite = (opcode == 6'b101011) ? 1'b1 :
                    1'b0;
  
  assign ALUSrc = (opcode == 6'b100011) ? 1'b1 :
                  (opcode == 6'b101011) ? 1'b1 :
                  1'b0;
  
  assign regDst = (opcode == 6'b000000) ? 1'b1 : 
                  1'b0;
  
  assign writeBack = (opcode == 6'b100011) ? 1'b1 :
                     (opcode == 6'b000000) ? 1'b1 : 
                     1'b0;
  
  assign PCSrc = (opcode == 6'b000010) ? 2'b10 :
                 (opcode == 6'b000100 & equal == 1'b1) ? 2'b01 :
                 (opcode == 6'b000101 & equal == 1'b0) ? 2'b01 :
                 2'b00;
                 
  assign flush = (opcode == 6'b000100 & equal == 1'b1) ? 1'b1 :
                 (opcode == 6'b000101 & equal == 1'b0) ? 1'b1 :
                 1'b0;
  
  assign ALUOp = (opcode == 6'b100011) ? 3'b000 :
                 (opcode == 6'b101011) ? 3'b000 :
                 ((opcode == 6'b000000) & (func == 6'b100000)) ? 3'b000:
                 ((opcode == 6'b000000) & (func == 6'b100010)) ? 3'b001:
                 ((opcode == 6'b000000) & (func == 6'b101010)) ? 3'b100:
                 ((opcode == 6'b000000) & (func == 6'b100100)) ? 3'b010:
                 ((opcode == 6'b000000) & (func == 6'b100101)) ? 3'b011: 
                 3'b111;
  
  //assign fwA = is always 0
  
  //assign fwB = is always 0
  
  //assign mtor = (opcode == 6'b100011) ? 1'b1 : 
                //1'b0; (DEL)
  
endmodule
                   
  /*reg [3:0] ps, ns;
  parameter IF =            4'b0000,
            topStackOut =   4'b0001, 
            popping1 =      4'b0010, 
            pushing1 =      4'b0011, 
            loadingA =      4'b0100, 
            loadingB =      4'b0101, 
            jumping =       4'b0110, 
            zeroJumping =   4'b0111, 
            readingMemory = 4'b1000, 
            popping2 =      4'b1001,
            aluOperating =  4'b1010,
            pushing2 =      4'b1011,
            notting =       4'b1100,
            writingMemory = 4'b1101;
            
  always@(posedge clk)
    ps <= ns;
    
  always@(ps, opcode) begin
  ns = IF;
    case(ps)
      IF:                ns = topStackOut;          
      topStackOut:       ns = (opcode == 3'b000 || opcode == 3'b001 || opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b101) ? popping1 :
                              (opcode == 3'b100) ? readingMemory :
                              (opcode == 3'b110) ? jumping :
                              (opcode == 3'b111) ? zeroJumping :
                              4'bx;                 
      readingMemory:     ns = pushing1;
      pushing1:          ns = IF;
      popping1:          ns = loadingA;
      loadingA:          ns = (opcode == 3'b011) ? notting :
                              (opcode == 3'b101) ? writingMemory : popping2;
      popping2:          ns = loadingB;
      loadingB:          ns = aluOperating;
      aluOperating:      ns = pushing2;
      pushing2:          ns = IF;
      notting:           ns = pushing2;
      writingMemory:     ns = IF;
      jumping:           ns = IF;
      zeroJumping:       ns = IF;
      default:           ns = IF;
    endcase
  end
  
  always@(ps) begin
    {memRead, memWrite, ALUSrc, regDst, writeBack, PCSrc, ALUOp} <= 0;
    case(ps)
      IF:             begin iOrD = 0; srcA = 1; srcB = 1; aluOp = 2'b0; pcSrc = 0; pcWrite = 1; memRead = 1; irWrite = 1; end
      topStackOut:    begin tos = 1; end
      readingMemory:  begin iOrD = 1; memRead = 1; end
      pushing1:       begin mToS = 1; push = 1; end
      popping1:       begin pop = 1; end
      loadingA:       begin ldA = 1; end
      popping2:       begin pop = 1; end
      loadingB:       begin ldB = 1; end
      aluOperating:   begin aluOp = opcode[1:0]; end
      pushing2:       begin push = 1; end
      notting:        begin aluOp = 2'b11; end
      writingMemory:  begin iOrD = 1; memWrite = 1; end
      jumping:        begin pcSrc = 1; pcWrite = 1; end
      zeroJumping:    begin pcWriteCond = 1; pcSrc = 1; end 
    endcase
  end
  
endmodule
*/
