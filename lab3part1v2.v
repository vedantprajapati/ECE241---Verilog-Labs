//Vedant Prajapati
//6:1 Multiplexor
//6 different inputs give have 3 selector switches that return one of the outputs

module lab3part1v2(input [9:0]SW, output [0:0]LEDR);
	reg Out;
	always @(*) // declare always block
	begin // declare the output signal for the always block
		case (SW[9:7])
			3'b000: Out = SW[0];
			3'b001: Out = SW[1];
			3'b010: Out = SW[2];
			3'b011: Out = SW[3]; 
			3'b100: Out = SW[4];
			3'b101: Out = SW[5];	
			default: Out = SW[0];
		endcase
	end
	assign LEDR[0] = Out;
endmodule

