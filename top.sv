module top(input logic clk, reset,
			  output logic [31:0] WriteData,DataAdr,
			  output logic MemWrite);

logic [31:0] ReadData;

riscv rv(.clk(clk),
			.reset(reset),
			.ReadData(ReadData),
			.MemWrite(MemWrite),
			.DataAdr(DataAdr),
			.WriteData(WriteData));
			
mem memory(.clk(clk),
			  .we(MemWrite),
			  .a(DataAdr),
			  .wd(WriteData),
			  .rd(ReadData));
			  
endmodule