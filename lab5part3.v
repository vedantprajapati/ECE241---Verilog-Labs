//SW[2:0]	letter input
//KEY[1]		start input
//KEY[0]		async reset input

//LEDR[0]	morse output

module lab5part3(input CLOCK_50, input[9:0] SW, input[3:0] KEY, output[9:0] LEDR);
	
	morseEncoder encoder(.rate(32'b00000010111110101111000001111111), .clock(CLOCK_50), .resetn(KEY[0]), .sel(SW[2:0]), .morse_out(LEDR[0]), .start(KEY[1]));
	
endmodule

module morseEncoder(input clock, resetn, start, input[31:0] rate, input[2:0] sel, output morse_out);
	wire[15:0] morseCode;
	wire rotate;
	wire[15:0] regOut;

	//morse LUT
	morseLUT mLut(.s(sel), .q(morseCode));
	
	//rate divider
	rateDivider32bit rateDiv(.s(rate), .enable(1'b1), .resetn(resetn), .clock(clock), .pulse(rotate));
	
	//shift register
	shift16bitRegister sreg(.data(morseCode), .aresetn(resetn), .parallelLoadn(start), .rotateLeft(rotate), .clock(clock), .reg_out(regOut));

	assign morse_out = regOut[15];
endmodule

//morse representation LUT
module morseLUT(input[2:0] s, output reg[15:0] q);
	always@(*)
		case(s)//16'b0000000000000000
			3'b000: q = {16'b1010000000000000};//i
			3'b001: q = {16'b1011101110111000};//j
			3'b010: q = {16'b1110101110000000};//k
			3'b011: q = {16'b1011101010000000};//l
			3'b100: q = {16'b1110111000000000};//m
			3'b101: q = {16'b1110111000000000};//n
			3'b110: q = {16'b1110111011100000};//o
			3'b111: q = {16'b1011101110100000};//p
		endcase
endmodule

//1hz: s=32'b00000010111110101111000001111111
//rate divider
module rateDivider32bit(input[31:0] s, input enable, resetn, clock, output pulse);
	reg[31:0] count;
	
	always @(posedge clock)
	begin
		if((resetn == 1'b0) | (count == 32'b0))
			count <= s;
		else if (enable == 1'b1)
			count <= count - 1;
	end
	
	assign pulse = (count == 32'b0) ? 1 : 0;
endmodule

//shift register
module shift16bitRegister(input[15:0] data, input aresetn, parallelLoadn, rotateLeft, clock, output[15:0] reg_out);

	// shift flip flop units [15:0]
	shiftFlipFlop u15(.shift(rotateLeft), .d(data[15]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[14]), .q(reg_out[15]));
	shiftFlipFlop u14(.shift(rotateLeft), .d(data[14]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[13]), .q(reg_out[14]));
	shiftFlipFlop u13(.shift(rotateLeft), .d(data[13]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[12]), .q(reg_out[13]));
	shiftFlipFlop u12(.shift(rotateLeft), .d(data[12]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[11]), .q(reg_out[12]));
	shiftFlipFlop u11(.shift(rotateLeft), .d(data[11]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[10]), .q(reg_out[11]));
	shiftFlipFlop u10(.shift(rotateLeft), .d(data[10]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[9]), .q(reg_out[10]));
	shiftFlipFlop u9(.shift(rotateLeft), .d(data[9]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[8]), .q(reg_out[9]));
	shiftFlipFlop u8(.shift(rotateLeft), .d(data[8]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[7]), .q(reg_out[8]));
	shiftFlipFlop u7(.shift(rotateLeft), .d(data[7]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[6]), .q(reg_out[7]));
	shiftFlipFlop u6(.shift(rotateLeft), .d(data[6]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[5]), .q(reg_out[6]));
	shiftFlipFlop u5(.shift(rotateLeft), .d(data[5]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[4]), .q(reg_out[5]));
	shiftFlipFlop u4(.shift(rotateLeft), .d(data[4]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[3]), .q(reg_out[4]));
	shiftFlipFlop u3(.shift(rotateLeft), .d(data[3]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[2]), .q(reg_out[3]));
	shiftFlipFlop u2(.shift(rotateLeft), .d(data[2]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[1]), .q(reg_out[2]));
	shiftFlipFlop u1(.shift(rotateLeft), .d(data[1]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(reg_out[0]), .q(reg_out[1]));
	shiftFlipFlop u0(.shift(rotateLeft), .d(data[0]), .aresetn(aresetn), .loadn(parallelLoadn), .clock(clock), .right(1'b0), .q(reg_out[0]));
endmodule

//shift flip flop
module shiftFlipFlop(input shift, d, loadn, clock, aresetn, right, output reg q);
	//load value into flip flop
	always @(posedge clock, negedge aresetn)
		if(aresetn == 1'b0)
			q <= 1'b0;
		else if (loadn == 1'b0)
			q <= d;
		else if (shift == 1'b1)
			q <= right;
endmodule