module riscv(input logic clk, reset,
				 input logic [31:0] ReadData,
				 output logic MemWrite,
				 output logic [31:0] DataAdr, WriteData);

logic [6:0] op;
logic [2:0] funct3;
logic Zero, funct7b5;
logic RegWrite, IRWrite, AdrSrc, PCWrite;
logic [1:0] ResultSrc, ALUSrcA, ALUSrcB, ImmSrc;
logic [2:0] ALUControl;

controller c(.clk(clk),
				 .reset(reset),
				 .op(op),
				 .funct3(funct3),
				 .funct7b5(funct7b5), 
				 .zero(Zero), 
				 .immsrc(ImmSrc), 
				 .alusrca(ALUSrcA),
				 .alusrcb(ALUSrcB), 
				 .resultsrc(ResultSrc),  
				 .adrsrc(AdrSrc), 
				 .alucontrol(ALUControl), 
				 .irwrite(IRWrite),
				 .pcwrite(PCWrite),  
				 .regwrite(RegWrite), 
				 .memwrite(MemWrite));
				 
datapath dp (.clk(clk), 
				 .reset(reset),
				 .PCWrite(PCWrite), 
				 .AdrSrc(AdrSrc), 
				 .IRWrite(IRWrite),
				 .RegWrite(RegWrite),
				 .ResultSrc(ResultSrc), 
				 .ALUControl(ALUControl),
				 .ALUSrcA(ALUSrcA), 
				 .ALUSrcB(ALUSrcB), 
				 .ImmSrc(ImmSrc), 
				 .ReadData(ReadData),
				 .op(op), 
				 .funct3(funct3), 
				 .funct7b5(funct7b5), 
				 .Zero(Zero),
				 .DataAdr(DataAdr), 
				 .WriteData(WriteData));
				 
endmodule

