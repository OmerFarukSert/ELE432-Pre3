module datapath(input logic clk, reset,
					 input logic PCWrite, AdrSrc, IRWrite, RegWrite,
					 input logic [1:0] ResultSrc, ALUSrcA, ALUSrcB, ImmSrc,
					 input logic [2:0] ALUControl,
					 input logic [31:0] ReadData,
					 output logic funct7b5, Zero,
					 output logic [6:0] op,
					 output logic [2:0] funct3,
					 output logic [31:0] DataAdr, WriteData);

//signals
logic [31:0] pc, OldPC, Instr, Data, ImmExt, a, Rd1, Rd2;
logic [31:0] SrcA, SrcB, ALUResult, ALUOut, Result;

assign op = Instr[6:0];
assign funct3 = Instr[14:12];
assign funct7b5 = Instr[30]; 

flopenr #(32) pcnext(.clk(clk), .reset(reset), .en(PCWrite), .d(Result), .q(pc));

mux2 #(32) adrmux(.d0(pc), .d1(Result), .s(AdrSrc), .y(DataAdr));

flopenr #(32) irnext(.clk(clk), .reset(reset), .en(IRWrite), .d(ReadData), .q(Instr));

flopenr #(32) oldpcnext(.clk(clk), .reset(reset), .en(IRWrite), .d(pc), .q(OldPC));

flopr #(32) datanext(.clk(clk), .reset(reset), .d(ReadData), .q(Data));

regfile	rf(.clk(clk), .we3(RegWrite), .a1(Instr[19:15]), .a2(Instr[24:20]), .a3(Instr[11:7]), .wd3(Result), .rd1(Rd1), .rd2(Rd2));

extend	ext(.instr(Instr[31:7]), .immsrc(ImmSrc), .immnext(ImmExt));

flopr #(32) areg(.clk(clk), .reset(reset), .d(Rd1), .q(a));
flopr #(32) breg(.clk(clk), .reset(reset), .d(Rd2), .q(WriteData));

mux3 #(32) amux(.d0(pc), .d1(OldPC), .d2(a), .s(ALUSrcA), .y(SrcA));	
mux3 #(32) bmux(.d0(WriteData), .d1(ImmExt), .d2(32'd4), .s(ALUSrcB), .y(SrcB));

alu	srcalu(.SrcA(SrcA), .SrcB(SrcB), .ALUControl(ALUControl), .ALUResult(ALUResult), .Zero(Zero));

flopr #(32) alunext(.clk(clk), .reset(reset), .d(ALUResult), .q(ALUOut));

mux3 #(32) resultmux(.d0(ALUOut), .d1(Data), .d2(ALUResult), .s(ResultSrc), .y(Result));

endmodule				 