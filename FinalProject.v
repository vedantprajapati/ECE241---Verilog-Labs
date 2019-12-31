/*
module vgatop(
		CLOCK_50,						//	On Board 50 MHz
		// Your inputs and outputs here
		a, 
		b,
		c,
		op,
		enable,
		resetkey,
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B   						//	VGA Blue[9:0]
	);

	input			CLOCK_50;				//	50 MHz
	input [3:0]a;
	input [3:0]b;
	input [4:0]c;
	input [1:0]op;
	input enable;
	input resetkey;
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] coloura, colourb,colourc,colourd,colour;
	wire [7:0] x;
	wire [6:0] y;
	
	wire [7:0]inxa;
	wire [6:0]inya;
	wire [2:0]inca;

	wire [7:0]inxb;
	wire [6:0]inyb;
	wire [2:0]incb;

	wire [7:0]inxc;
	wire [6:0]inyc;
	wire [2:0]incc;

	wire [7:0]inxop;
	wire [6:0]inyop;
	wire [2:0]incop;

	wire [5:0]address;
	
	wire [3:0]a;
	wire [3:0]b;
	wire [2:0]c;
	wire [3:0]op;
	
	// Create an Instance of a VGA controller - there can be only one!
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.	
	
	//VGA ADAPTER-------------------------------
	vga_adapter VGA(
			.resetn(KEY[1]),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(enable),
			/* Signals for the DAC to drive the monitor. 
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 3;
		defparam VGA.BACKGROUND_IMAGE = "hello.mif";
	
	// Put your code here. Your code should produce signals x,y,colour and writeEn
	
	// for the VGA controller, in addition to any other functionality your design may require.
	
	// translate the inputs and add it to 
	displaynum firstnum(.x(inxa),.y(inya),.shiftx(42),.shifty(27),.clk(CLOCK_50));
	displaynum secondnum(.x(inxb),.y(inyb),.shiftx(117),.shifty(27),.clk(CLOCK_50));
	displaynum thirdnuma(.x(inxc),.y(inyc),.shiftx(40),.shifty(68),.clk(CLOCK_50));
	displaynum thirdnumb(.x(inxc),.y(inyc),.shiftx(122),.shifty(68),.clk(CLOCK_50));
	displaynum operatora(.x(inxop),.y(inyop),.shiftx(7),.shifty(68),.clk(CLOCK_50));
	displaynum operatorb(.x(inxop),.y(inyop),.shiftx(90),.shifty(68),.clk(CLOCK_50));

	wire [2:0]a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16;
	wire [2:0]b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16;
	wire [2:0]c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17;
	wire [2:0]d1,d2,d3,d4;

	
	
	vga_address_translator move(.x(x),.y(y), .mem_address(address));

	zero plot0a(.address(address),.clock(CLOCK_50),.q(a1));
	one plot1a(.address(address),.clock(CLOCK_50),.q(a2));
	two plot2a(.address(address),.clock(CLOCK_50),.q(a3));
	three plot3a(.address(address),.clock(CLOCK_50),.q(a4));
	four plot4a(.address(address),.clock(CLOCK_50),.q(a5));
	five plot5a(.address(address),.clock(CLOCK_50),.q(a6));
	six plot6a(.address(address),.clock(CLOCK_50),.q(a7));
	seven plot7a(.address(address),.clock(CLOCK_50),.q(a8));
	eight plot8a(.address(address),.clock(CLOCK_50),.q(a9));
	nine plot9a(.address(address),.clock(CLOCK_50),.q(a10));
	tena plot10a(.address(address),.clock(CLOCK_50),.q(a11));
	elevenb plot11a(.address(address),.clock(CLOCK_50),.q(a12));
	twelvec plot12a(.address(address),.clock(CLOCK_50),.q(a13));
	thirteend plot13a(.address(address),.clock(CLOCK_50),.q(a14));
	fourteene plot14a(.address(address),.clock(CLOCK_50),.q(a15));
	fifteenf plot15a(.address(address),.clock(CLOCK_50),.q(a16));

	zero plot0b(.address(address),.clock(CLOCK_50),.q(b1));
	one plot1b(.address(address),.clock(CLOCK_50),.q(b2));
	two plot2b(.address(address),.clock(CLOCK_50),.q(b3));
	three plot3b(.address(address),.clock(CLOCK_50),.q(b4));
	four plot4b(.address(address),.clock(CLOCK_50),.q(b5));
	five plot5b(.address(address),.clock(CLOCK_50),.q(b6));
	six plot6b(.address(address),.clock(CLOCK_50),.q(b7));
	seven plot7b(.address(address),.clock(CLOCK_50),.q(b8));
	eight plot8b(.address(address),.clock(CLOCK_50),.q(b9));
	nine plot9b(.address(address),.clock(CLOCK_50),.q(b10));
	tena plot10b(.address(address),.clock(CLOCK_50),.q(b11));
	elevenb plot11b(.address(address),.clock(CLOCK_50),.q(b12));
	twelvec plot12b(.address(address),.clock(CLOCK_50),.q(b13));
	thirteend plot13b(.address(address),.clock(CLOCK_50),.q(b14));
	fourteene plot14b(.address(address),.clock(CLOCK_50),.q(b15));
	fifteenf plot15b(.address(address),.clock(CLOCK_50),.q(b16));

	zero plot0c(.address(address),.clock(CLOCK_50),.q(c1));
	one plot1c(.address(address),.clock(CLOCK_50),.q(c2));
	two plot2c(.address(address),.clock(CLOCK_50),.q(c3));
	three plot3c(.address(address),.clock(CLOCK_50),.q(c4));
	four plot4c(.address(address),.clock(CLOCK_50),.q(c5));
	five plot5c(.address(address),.clock(CLOCK_50),.q(c6));
	six plot6c(.address(address),.clock(CLOCK_50),.q(c7));
	seven plot7c(.address(address),.clock(CLOCK_50),.q(c8));
	eight plot8c(.address(address),.clock(CLOCK_50),.q(c9));
	nine plot9c(.address(address),.clock(CLOCK_50),.q(c10));
	tena plot10c(.address(address),.clock(CLOCK_50),.q(c11));
	elevenb plot11c(.address(address),.clock(CLOCK_50),.q(c12));
	twelvec plot12c(.address(address),.clock(CLOCK_50),.q(c13));
	thirteend plot13c(.address(address),.clock(CLOCK_50),.q(c14));
	fourteene plot14c(.address(address),.clock(CLOCK_50),.q(c15));
	fifteenf plot15c(.address(address),.clock(CLOCK_50),.q(c16));
	
	add plotadd(.address(address),.clock(CLOCK_50),.q(d1));
	sub plotsub(.address(address),.clock(CLOCK_50),.q(d2));
	multiply plotmultiply(.address(address),.clock(CLOCK_50),.q(d3));
	div plotdiv(.address(address),.clock(CLOCK_50),.q(d4));

	fourbitmux numadisplaya(a,
	a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,
	coloura);
	
	fourbitmux numadisplayb(b,
	b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15,b16,
	colourb);

	fivebitmux numdisplayc(c,
	c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,
	colourc);

	
	twobitmux opdisplay(op,
	d1,d2,d3,d4,
	colourd);

	vgastate states(a,b,c,op,inxa,inya,inca,inxb,inyb,incb,inxc,inyc,incc,inxop,inyop,incop,x,y,colour,enable);
	
endmodule
*/

module displaynum (x, y,reset,shiftx,shifty, clk);

	input clk;
	output reg [7:0]x;
	output reg [6:0]y;
	input reset;
	input [7:0]shiftx;
	input [6:0]shifty;
	
	always @(posedge clk)
		begin 
			if (~reset)
				begin
				x<=0;
				y<=0;
				end
			else if (x<8)
				begin
					x<=x+1+shiftx;
					y<=y+shifty;
				end
			else if (x==8)
				begin
					x<=0+shiftx;
					y<=y+1+shifty;
				if (y==8);
					begin
						y<=0+shifty;
						x<=x+shiftx;
					end
				end
		
		end
	
endmodule
//write an fsm for the draw states
//create variables for each draw state (6 states)
//use conditionals to change values on always block instead of mux
//google generate blocks
//
//4, 4 , 5, 2, col = 3 bit
		
module fourbitmux(input [3:0]sel,
	input [2:0]a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15,a16,
	output reg[2:0]colour);
	
	always @(*)
	begin
		case(sel)
			4'd0: colour = a1;
			4'd1: colour = a2;
			4'd2: colour = a3;
			4'd3: colour = a4;
			4'd4: colour = a5;
			4'd5: colour = a6;
			4'd6: colour = a7;
			4'd7: colour = a8;
			4'd8: colour = a9;
			4'd9: colour = a10;
			4'd10: colour = a11;
			4'd11: colour = a12;
			4'd12: colour = a13;
			4'd13: colour = a14;
			4'd14: colour = a15;
			4'd15: colour = a16;
			default: colour = 0;
	endcase 
	end
endmodule

module fivebitmux(input [4:0]sel,
	input [2:0]c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,
	output reg[2:0]colour);
	
	always @(*)
	begin
		case(sel)
			5'd0: colour = c1;
			5'd1: colour = c2;
			5'd2: colour = c3;
			5'd3: colour = c4;
			5'd4: colour = c5;
			5'd5: colour = c6;
			5'd6: colour = c7;
			5'd7: colour = c8;
			5'd8: colour = c9;
			5'd9: colour = c10;
			5'd10: colour = c11;
			5'd11: colour = c12;
			5'd12: colour = c13;
			5'd13: colour = c14;
			5'd14: colour = c15;
			5'd15: colour = c16;
			5'd16: colour = c17;
			default: colour = 0;
	endcase 
	end
endmodule

module twobitmux(input [1:0]sel,
	input [2:0] d1,d2,d3,d4,
	output reg colour);
	always @(*)
		begin
		case(sel)
			2'd0: colour = d1;
			2'd1: colour = d2;
			2'd2: colour = d3;
			2'd3: colour = d4;
			default: colour =0;
		endcase
	end
endmodule

module vgastate(a,b,c,op,inxa,inya,inca,inxb,inyb,incb,inxc,inyc,incc,inxop,inyop,incop,x,y,colour,enable);
	input [3:0]a;
	input [3:0]b;
	input [3:0]c;
	input [3:0]op;
	input [3:0]inxa;
	input [3:0]inya;
	input [2:0]inca;
	input [3:0]inxb;
	input [3:0]inyb;
	input [2:0]incb;
	input [3:0]inxc;
	input [3:0]inyc;
	input [2:0]incc;
	input [3:0]inxop;
	input [3:0]inyop;
	input [2:0]incop;
	output reg[3:0]x;
	output reg[3:0]y;
	output reg[3:0]colour;
	input enable;
	
	reg [3:0] cs,ns;
	localparam A = 3'b000, B=3'b001, C=3'b010, D= 3'b011,E=3'b100;
	always@(*)
	begin:state_table
		case (cs)/*
			E: begin
					if (enable==1)
						ns=A;
					else ns=E;
				end*/
			A: begin
					if (inya<8)
						begin
						x <= inxa;
						y <= inya;
						colour <= inca;
						ns = A;
						end
					else ns = B;
				end
			B: begin
					if (inyb<8)
						begin
						x <= inxb;
						y <= inyb;
						colour <= incb;
						ns = B;
						end
					else ns = C;
				end
			C: begin
					if (inyc<8)
						begin
						x <= inxc;
						y <= inyc;
						colour <= incc;
						ns = C;
						end
					else ns = D;
				end
			D: begin
					if (inyop<8)
						begin
						x <= inxop;
						y <= inyop;
						colour <= incop;
						ns = D;
						end
					else ns = A;
				end		
			
	endcase
	end
endmodule

		
		