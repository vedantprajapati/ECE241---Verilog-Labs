//Vedant Prajapati Lab5part1
//8 bit counter with synchronous active low reset

//counter module
module counter8bit(clock,resetn,enable,Q);
	parameter n=8;
	input clock, resetn, enable;
	output reg [n-1:0]Q;
	//always block determines output for each of the T flip flops
	always @(negedge resetn, posedge clock)
		begin
		if (!resetn)
			Q<=0;
		else if(enable)
			Q<=Q+1;
		end
endmodule

//hex display
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

//module for
module lab5part1(SW, KEY, LEDR, HEX0, HEX1);
	input [1:0]SW;
	input	[0:0]KEY;
	output [7:0]LEDR;
	output [6:0]HEX0, HEX1;
	wire [7:0]w1;
	counter8bit #(8) u1(.clock(KEY[0]), .resetn(SW[0]), .enable(SW[1]), .Q(w1));
	assign LEDR[7:0]=w1;
	reg [3:0] zero = 4'b0000;
	
	segdisplay hex0(
		.in(w1[3:0]),
		.hex(HEX0)
	);

	
	segdisplay hex1(
		.in(w1[7:4]),
		.hex(HEX1)
	);
	
	
	
endmodule
	