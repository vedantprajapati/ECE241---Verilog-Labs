//ALU MODULE
module ALU (input [3:0] A,input [3:0] B,input [0:0] carry, input register, input [3:0] key, output [7:0] ALUout);

	reg [7:0] out; //setting the output for the always to the size of the ALUout
	wire carryout;
	wire [3:0] Sum;
	wire [3:0] sumA, sumB;

	adder4bit adder(.A(A), .B(B), .in(carry), .S(Sum), .out(carryout)); 
	addbits U7( .inA(A), .inB(B), .outSumA(sumB), .outSumB(sumA));

	always @(posedge key[0])
	begin
		case(~(key[3:1])) //the board inverts the press of the buttons so we have to invert it to allow use
			3'd0: out = {3'b000, carryout, Sum};//if case 1, use ripple adder
			3'd1: out =  A + B; //if case 2, use the verlog + operator 
			3'd2: out = {~(A^B),~(A&B)}; //if case 3, XNORB the first 4 bits of ALU and ANAND B the rest
			3'd3: out = (A||B)?8'b0001111:8'd0; //if at least one of the bits in inputs are 1
			3'd4: out = ( sumA == 4'b0001 & sumB == 4'b0010 ) ? 8'b11110000 : 8'b00000000; //if exactly 1 bit of the A switches is 1 and 2 bits of the B switches are 1
			3'd5: out = {A, ~B}; // display A switches in the most significant bits first and then the complementing B switches in 4 least significant
			3'd6: //case 6 -> register storage
					begin
						if(register== 1'b0)
							out <= 8'b00000000;
						else
							out <= out;
					end
			default: out = 8'd0; //else do nothing
		endcase
	end
	
	assign ALUout = out;

endmodule



//module to add the bits to get their individual sums
module addbits(input [3:0]inA, inB, output [3:0] outSumA, outSumB);
	
	assign outSumA = inA[3] + inA[2] + inA[1] + inA[0];
	
	assign outSumB = inB[3] + inB[2] + inB[1] + inB[0];
	
endmodule



//main toplevel module
module lab4part2(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input [9:0] SW;
	input [3:0] KEY;
	output [7:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	reg [3:0] zero = 4'b0000;
	
	wire [3:0] w1, w2;
	
		ALU U1(
		.A(SW[7:4]),
		.B(SW[3:0]),
		.carry(SW[8]),
		.register(SW[9]),
		.key(KEY),
		.ALUout(LEDR[7:0])
	);
	
	assign {w1[3:0], w2[3:0]} = LEDR;	
	
	segdisplay hex0(
		.in(SW[3:0]),
		.hex(HEX0)
	);
	
	segdisplay hex1(
		.in(zero),
		.hex(HEX1)
	);
	
	segdisplay hex2(
		.in(SW[7:4]),
		.hex(HEX2)
	);
	
	segdisplay hex3(
		.in(zero),
		.hex(HEX3)
	);
	
	segdisplay hex4(
		.in(w2),
		.hex(HEX4)
	);
	
	segdisplay hex5(
		.in(w1),
		.hex(HEX5)
	);
	

endmodule



//module for each fullAdder;code for one adder module
module fullAdder (input a, b, in, output s, out);
	assign s = in^a^b;//^ is the XOR operator
	assign out = (a&b)| (in&a)| (in&b);//outputs the value for carry if one of these 3 conditions are met

endmodule

//module for the entire 4 bit adder
module adder4bit(input [3:0]A,input [3:0]B, input in, output [3:0]S, output out);
	
	wire w1, w2, w3;
	
	fullAdder add1(.a(A[0]), .b(B[0]), .in(in), .s(S[0]), .out(w1));
	fullAdder add2(.a(A[1]), .b(B[1]), .in(w1), .s(S[1]), .out(w2));
	fullAdder add3(.a(A[2]), .b(B[2]), .in(w2), .s(S[2]), .out(w3));
	fullAdder add4(.a(A[3]), .b(B[3]), .in(w3), .s(S[3]), .out(out));

endmodule
 
//7 segment display cases from truth table
module segdisplay(input[3:0] in, output reg [6:0] hex);
	always @(*)
	begin
		case(in)
			4'h0: hex = 7'b1000000;
			4'h1: hex = 7'b1111001;
			4'h2: hex = 7'b0100100;
			4'h3: hex = 7'b0110000;
			4'h4: hex = 7'b0011001;
			4'h5: hex = 7'b0010010;
			4'h6: hex = 7'b0000010;
			4'h7: hex = 7'b1111000;
			4'h8: hex = 7'b0000000;
			4'h9: hex = 7'b0010000;
			4'hA: hex = 7'b0001000;
			4'hB: hex = 7'b0000011;
			4'hC: hex = 7'b1000110;
			4'hD: hex = 7'b0100001;
			4'hE: hex = 7'b0000110;
			4'hF: hex = 7'b0001110;
			default: hex = 7'b1000000;
		endcase
	end
endmodule