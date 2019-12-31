//Top level
module FinalProject(input CLOCK_50,input[2:0]KEY,input [9:0]SW, output [6:0]HEX3, output [6:0]HEX5, output [9:0]LEDR,
		output VGA_CLK,   						//	VGA Clock
		output VGA_HS,							//	VGA H_SYNC
		output VGA_VS,							//	VGA V_SYNC
		output VGA_BLANK_N,						//	VGA BLANK
		output VGA_SYNC_N,						//	VGA SYNC
		output [7:0]VGA_R,   						//	VGA Red[9:0]
		output [7:0]VGA_G,	 						//	VGA Green[9:0]
		output [7:0]VGA_B   						//	VGA Blue[9:0]
		);

	wire timeover;
	wire correct,check_done,RNG_enable,STORE_enable,CHECK_enable,COUNTER_enable,TIMER_enable,DISPLAY_enable;
	wire [3:0] A_stored,B_stored;
	FSM F1(CLOCK_50,~KEY[0],~KEY[1],~KEY[2],correct,
			 timeover,check_done,RNG_enable,STORE_enable,CHECK_enable,COUNTER_enable,TIMER_enable,A_stored,
			 B_stored,op_num_stored,op_select_stored,A_stored_to_VGA,B_stored_to_VGA,op_num_stored_to_VGA,
		    op_select_stored_to_VGA,DISPLAY_enable);
	datapath D1(CLOCK_50,RNG_enable,STORE_enable,~KEY[1],CHECK_enable,COUNTER_enable,TIMER_enable,
					SW[9:5],SW[4:0],correct,check_done,timeover,A_stored,B_stored,LEDR[1:0],LEDR[9:5]);
	segdisplay S1(A_stored,HEX5);
	segdisplay S2(B_stored,HEX3);
	


	// Create the colour, x, y and writeEn wires that are inputs to the controller.
	wire [2:0] coloura, colourb,colourc,colourd,colour;
	wire [7:0] x;
	wire [6:0] y;
	wire [3:0] a,b;
	wire [4:0] c;
	wire [1:0] op;
	
	assign a=A_stored_to_VGA;
	assign b=B_stored_to_VGA;
	assign c=op_num_stored_to_VGA;
	assign op=op_select_stored_to_VGA;
	wire [7:0]inxa;
	wire [6:0]inya;

	wire [7:0]inxb;
	wire [6:0]inyb;

	wire [7:0]inxc;
	wire [6:0]inyc;

	wire [7:0]inxop;
	wire [6:0]inyop;

	wire [5:0]address;
	

	
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
			/* Signals for the DAC to drive the monitor. */
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
	displaynum firstnum(.x(inxa),.y(inya),.reset(KEY[1]),.shiftx(42),.shifty(27),.clk(CLOCK_50));
	displaynum secondnum(.x(inxb),.y(inyb),.reset(KEY[1]),.shiftx(117),.shifty(27),.clk(CLOCK_50));
	displaynum thirdnuma(.x(inxc),.y(inyc),.reset(KEY[1]),.shiftx(40),.shifty(68),.clk(CLOCK_50));
	displaynum thirdnumb(.x(inxc),.y(inyc),.reset(KEY[1]),.shiftx(122),.shifty(68),.clk(CLOCK_50));
	displaynum operatora(.x(inxop),.y(inyop),.reset(KEY[1]),.shiftx(7),.shifty(68),.clk(CLOCK_50));
	displaynum operatorb(.x(inxop),.y(inyop),.reset(KEY[1]),.shiftx(90),.shifty(68),.clk(CLOCK_50));

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

	vgastate states(a,b,c,op,inxa,inya,coloura,inxb,inyb,colourb,inxc,inyc,colourc,inxop,inyop,colourd,x,y,colour,enable);
	
	
	
endmodule



//Can implement an input seed value given by the user
//Might have to assume the user will input seed that is enough to be workable(ie. atleast 2 1s for the first 5 and last 5 bits)
//If can't assume might have to build a safety net
module LFSR4bit_A(input clk,input resetn,input enable,output reg [3:0] data);

reg [3:0] tempdata;

always @(*) 
begin
  tempdata[3] = data[3]^data[0];
  tempdata[2] = data[2]^tempdata[3];
  tempdata[1] = data[1]^tempdata[2];
  tempdata[0] = data[0]^tempdata[1];
end

always @(posedge clk)
	begin
		if(resetn == 1)
			data <= 4'b1001;
		else if(enable == 1)
			data <= tempdata;
	end
endmodule

module LFSR4bit_B(input clk,input resetn,input enable,output reg [3:0] data);

reg [3:0] tempdata;

always @(*) 
begin
  tempdata[3] = data[3]^data[0];
  tempdata[2] = data[2]^tempdata[3];
  tempdata[1] = data[1]^tempdata[2];
  tempdata[0] = data[0]^tempdata[1];
end

always @(posedge clk)
	begin
		if(resetn == 1)
			data <= 4'b0101;
		else if(enable == 1)
			data <= tempdata;
	end
endmodule

//Dynamic input for seed of A and B
//Can rework implementation so that both A and B takes the same seed
module LFSR4bit_A_dyn(input clk,input resetn,input enable,input [3:0]SW,output reg [3:0] data);

reg [3:0] tempdata;

always @(*) 
begin
  tempdata[3] = data[3]^data[0];
  tempdata[2] = data[2]^tempdata[3];
  tempdata[1] = data[1]^tempdata[2];
  tempdata[0] = data[0]^tempdata[1];
end

always @(posedge clk)
	begin
		if(resetn == 1)
			data <= SW;
		else if(enable == 1)
			data <= tempdata;
	end
endmodule

module LFSR4bit_B_dyn(input clk,input resetn,input [8:5]SW,input enable,output reg [3:0] data);

reg [3:0] tempdata;

always @(*) 
begin
  tempdata[3] = data[3]^data[0];
  tempdata[2] = data[2]^tempdata[3];
  tempdata[1] = data[1]^tempdata[2];
  tempdata[0] = data[0]^tempdata[1];
end

always @(posedge clk)
	begin
		if(resetn == 1)
			data <= SW;
		else if(enable == 1)
			data <= tempdata;
	end
endmodule


//max number can add to is 16 ((15)4'b1111 + (16)5'b10000 = (31)5'b11111)
//Minor problem with this module is that the frequency at which it displays 5'b10000 is higher than normal which makes sense
module LFSR_operation_number(input clk,input reset,input enable,output reg [4:0] data);

reg [4:0] tempdata;
reg [4:0] temp2data;

always @(*) 
begin
  tempdata[4] = temp2data[4]^temp2data[1];
  tempdata[3] = temp2data[3]^temp2data[0];
  tempdata[2] = temp2data[2]^tempdata[3];
  tempdata[1] = temp2data[1]^tempdata[2];
  tempdata[0] = temp2data[0]^tempdata[1];
end

always @(posedge clk)
	begin
		if(reset==1)
		begin
			data <= 5'b00101;
			temp2data <= 5'b00101;
		end
		else if(enable == 1)
			if(tempdata>5'b10000)
			begin
				data <= tempdata - 5'b10000;
				temp2data <= tempdata;
			end
			else if(tempdata <= 5'b10000)
			begin
				data <= tempdata;
				temp2data <= tempdata;
			end
	end
endmodule

//Can also use user input seed here
//Use the 2 bit output as mux select for the operation in the alu
//Disable LFSR_operator_select before preceding with ALU
module LFSR_operator_select(input clk, input resetn, input enable, output reg [1:0] data);

reg [1:0] tempdata;

always @(*) 
begin
  tempdata[1] = data[1]^tempdata[0];
  tempdata[0] = data[0]^data[1];
end

always @(posedge clk)
	begin
		if(resetn == 1)
			data <= 2'b01;
		else if(enable == 1)
			data <= tempdata;
	end
endmodule

