//Vedant Prajapati
//4 bit ripple-carry adder
//Oct. 4, 2019


module fullAdder (input a, b, Cin, output s, Cout);//code for one adder module

	assign s = Cin^a^b;//^ is the XOR operator
	assign Cout = (a&b)| (Cin&a)| (Cin&b);//outputs the value for carry if one of these 3 conditions are met
	
endmodule


module adder4bit(input [3:0]A,input [3:0]B, input Cin, output [3:0]S, output Cout);
	
	wire w1, w2, w3;
	
	fullAdder add1(.a(A[0]), .b(B[0]), .Cin(Cin), .s(S[0]), .Cout(w1));
	fullAdder add2(.a(A[1]), .b(B[1]), .Cin(w1), .s(S[1]), .Cout(w2));
	fullAdder add3(.a(A[2]), .b(B[2]), .Cin(w2), .s(S[2]), .Cout(w3));
	fullAdder add4(.a(A[3]), .b(B[3]), .Cin(w3), .s(S[3]), .Cout(Cout));

endmodule

module lab3part2(input [8:0]SW,output [4:0]LEDR);
	
	adder4bit ripple(.A(SW[7:4]),.B(SW[3:0]),.Cin(SW[8]),.S(LEDR[3:0]),.Cout(LEDR[4]));
	
endmodule
	