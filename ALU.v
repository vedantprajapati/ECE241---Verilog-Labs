module ALU(input [3:0]A_or_B, input [4:0]op_num, input [1:0]op_select, output reg [4:0]ALUout);
 
 //00 is add, 01 is subtract, 10 is times 2, 11 is divided by 2)
	always @(*)
	begin
		case(op_select[1:0])
			2'b00: ALUout=A_or_B+op_num;
			2'b01: ALUout=A_or_B-op_num;
			2'b10: ALUout=A_or_B*2;
			2'b11: ALUout=A_or_B/2;
			default: ALUout=5'b00000;
		endcase
	end
endmodule
