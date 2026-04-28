module alu(input logic [31:0] 	SrcA, SrcB,
			  input logic [2:0] 		ALUControl,
			  output logic [31:0] 	ALUResult,
			  output logic 			Zero);
			  
	always_comb
		case(ALUControl)
			3'b000: ALUResult = SrcA + SrcB; //add
			3'b001: ALUResult = SrcA - SrcB; //sub
			3'b010: ALUResult = SrcA & SrcB; //and
			3'b011: ALUResult = SrcA |	SrcB; //or
			3'b100: ALUResult = SrcA ^ SrcB; //xor
			3'b101: ALUResult = SrcA < SrcB ? 32'b1 : 32'b0; //slt
			default: ALUResult = 32'bx;
		endcase
	
	assign Zero = (ALUResult == 32'b0);
endmodule