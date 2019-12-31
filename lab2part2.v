
//and gate
module v7408(input pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13, output pin3,pin6,pin8,pin11 );
		
	assign pin3 = pin1&pin2;
	assign pin6 = pin4&pin5;
	assign pin8 = pin9&pin10;
	assign pin11 = pin12&pin13;
		
endmodule

//or gate
module v7432(input pin1,pin2,pin4,pin5,pin9,pin10,pin12,pin13, output pin3,pin6,pin8,pin11 );
	
	assign pin3 = pin1|pin2;
	assign pin6 = pin4|pin5;
	assign pin8 = pin9|pin10;
	assign pin11 = pin12|pin13;

endmodule 

//not gate
module v7404(input pin1,pin3,pin5,pin9,pin11,pin13, output pin2,pin4,pin6,pin8,pin10,pin12);
		
	assign pin2 = ~pin1;
	assign pin4 = ~pin3;
	assign pin6 = ~pin5;
	assign pin8 = ~pin9;
	assign pin10 = ~pin11;
	assign pin12 = ~pin13;
endmodule 


 

module Lab2part2(SW,LEDR);

	input [9:0]SW;
	output [9:0]LEDR;
	
	wire w1,w2,w3;
	
	//Selector to NOT
	v7404 U0(.pin1(SW[9]), .pin2(w1));
	
	//X and S to AND
	v7408 U1(.pin1(SW[0]),.pin2(w1),.pin3(w2));
	
	//Y and S to AND
	v7408 U2(.pin4(SW[1]),.pin5(SW[9]),.pin6(w3));
	
	//xs +xy
	v7432 U3(.pin1(w2),.pin2(w3),.pin3(LEDR[0]));
	
endmodule





