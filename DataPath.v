module dataPath(input clk, rst, memRead, memWrite, ALUSrc, regDst, writeBack, flush,/*IDRegWrite, (DEL)*/
                input [2:0] ALUOp,
                input [1:0] PCSrc,
                output equal,
                output [5:0] opcode, func);  
                
wire [31:0] PCIn, PCOut, PCPlus4, instOut, /*IF*/
            branchPC, jumpPC, IDPC, IDInst, SEOut, readData1Out, readData2Out, /*ID*/
            EXEReadData1, EXEReadData2, branchShifterOut, EXESEOut, aIn, bIn0, bIn, ALURes, /*EXE*/
            MEMALURes, MEMWriteData, memData, /*MEM*/
            WBMemData, WBALURes, WBData; /*WB*/
      
wire [27:0] jumpShifterOut; /*ID*/
           
wire [2:0] EXEALUOp, IDALUOp;
            
wire [4:0] MEMRd, /*ID*/
           EXERt, EXERd, EXERs, EXEDest,/*EXE*/
           MEMDest, /*MEM*/
           WBDest; /*WB*/
           
wire [1:0] forwardingA, forwardingB; /*EXE*/
           
wire PCWrite, IF2IDWrite, /*IF*/
     IDWriteBack, IDMemRead, IDMemWrite, IDALUSrc, IDRegDst, setZero,/*ID*/
     EXEMemRead, EXEWriteBack, /*EXERegWrite,*/ /*EXE*/
     MEMMemRead, MEMMemWrite, MEMWriteBack /*<- MEMRegWrite*/, /*MEM*/
     mtor, WBWriteBack /*,WBRegWrite*/; /*WB*/
            
reg [31:0] ZERO = 32'b00000000000000000000000000000000;          
reg [31:0] ONE = 32'b00000000000000000000000000000001;
reg [31:0] FOUR = 32'b00000000000000000000000000000100;
                
register PC (clk, rst, PCWrite, PCIn, PCOut);
instructionMemory istmem (rst, PCOut, instOut);
adder addr0 (FOUR, PCOut, PCPlus4);
mux3_32bit mux0 (PCSrc, PCPlus4, branchPC, jumpPC, PCIn);

IF2ID if2id (clk, rst, flush, IF2IDWrite, PCPlus4, instOut, IDPC, IDInst); //IF2ID

shifter26to28 sh0 (IDInst [25:0], jumpShifterOut);
assign jumpPC = (jumpShifterOut != 28'bx) ? {IDPC [31:28], jumpShifterOut} : 32'bx;
signExtend se (IDInst [15:0], SEOut);
shifter32to32 shl (SEOut, branchShifterOut);
adder addr1 (IDPC, branchShifterOut, branchPC);
registerFile rf (clk, rst, WBWriteBack /*<- WBRegWrite*/, IDInst [25:21], IDInst[20:16], WBDest, WBData, readData1Out, readData2Out);
comparator compr (readData1Out, readData2Out, equal);
hazardUnit hz (EXEMemRead, IDInst [20:16], IDInst [15:11] , EXERt, IF2IDWrite, PCWrite, setZero);
inOrZero ioz (setZero, writeBack, memRead, memWrite, ALUSrc, regDst, ALUOp, IDWriteBack/*<- writeBackOut*/, IDMemRead, IDMemWrite, IDALUSrc, IDRegDst, IDALUOp); 

ID2EXE id2exe (clk, rst /*,IDRegWrite*/, IDMemRead, IDMemWrite, IDWriteBack, IDALUSrc, IDRegDst, IDALUOp, IDInst [15:11], 
               IDInst [20:16], IDInst [25:21], readData1Out, readData2Out, SEOut, 
               EXEMemRead, EXEMemWrite, EXEWriteBack, EXEALUSrc, EXERegDst, /*EXERegWrite,*/
               EXEALUOp, EXERd, EXERt, EXERs, EXEReadData1, EXEReadData2, EXESEOut); //ID2EXE
               
alu Alu (EXEALUOp, aIn, bIn, ALURes);
mux3_32bit mux2 (forwardingA, EXEReadData1, MEMALURes, WBData, aIn);
mux3_32bit mux3 (forwardingB, EXEReadData2, MEMALURes, WBData, bIn0);
mux2_32bit mux4 (EXEALUSrc, bIn0, EXESEOut, bIn);
mux2_5bit mux5 (EXERegDst, EXERt,  EXERd, EXEDest);
forwardingUnit fwu(MEMWriteBack, WBWriteBack, MEMDest, WBDest, EXERt, EXERs, forwardingA, forwardingB);

EXE2MEM exe2mem (clk, rst, EXEWriteBack, EXEMemRead, EXEMemWrite, /*EXERegWrite,*/
                 EXEDest, EXERd, 
                 ALURes, bIn0, 
                 MEMWriteBack, MEMMemRead, MEMMemWrite, /*MEMRegWrite,*/
                 MEMDest, MEMRd,
                 MEMALURes, MEMWriteData); //EXE2MEM
                 
dataMemory dm (clk, rst, MEMMemRead, MEMMemWrite, MEMALURes, MEMWriteData, memData);

MEM2WB mem2wb (clk, rst, MEMWriteBack, MEMMemRead, /*MEMRegWrite,*/
               MEMDest, 
               MEMALURes, memData, 
               WBWriteBack, mtor, /*WBRegWrite,*/
               WBDest, 
               WBALURes, WBMemData); //MEM2WB

mux2_32bit mux6 (mtor, WBALURes, WBMemData, WBData);

assign opcode = IDInst[31:26];
assign func = IDInst[5:0];

endmodule