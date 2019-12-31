
  
module lab5part2(SW, HEX0, CLOCK_50);
	input [9:0] SW;
	input CLOCK_50;
	output [6:0] HEX0;
	reg resetn;
	reg [1:0] Sel;
	wire [3:0] Q;
	wire enable;
	wire [25:0] upperBound, counter;

	always @(*)
	begin
		resetn= SW[9];
		Sel = SW[1:0];
	end
	
	frequency f(Sel, upperBound);
	rateDivider r(CLOCK_50, upperBound, enable,counter);
	fourbitcounter c(enable, CLOCK_50, resetn, Q);

	segdisplay hex0(.in(Q), .hex(HEX0));


endmodule

module frequency(input [1:0] SW, output reg [25:0] upperBound);
	always @(*)
		case(SW[1:0])//determine the upper bound so that the frequency can be divided for the counter and slowed down
			2'b00: upperBound= 26'b00000000000000000000000001; //0 ->50Mhz
			2'b01: upperBound= 26'b000101111101011110000011111; //12499999 -> 2Hz
			2'b10: upperBound = 26'b001011111010111100000111111; //24999999 -> 1Hz
			2'b11: upperBound= 26'b010111110101111000001111111; //49999999 -> 0.5Hz
		endcase
endmodule

module rateDivider(input clock, input [25:0] upperBound, output reg enable, output reg [25:0] counter);
	//reg [26:0] initializeCounter = 26'b0;
	always @(posedge clock)
	begin
		if (counter === 26'bx)
		begin
			counter <= 26'b0;
		end 
		else if (counter == upperBound)
		begin
			enable= 1'b1;
			counter <= 26'b0;
		end
		else
		begin
			enable = 1'b0;
			counter <= counter + 1 ;
		end
	end
		
endmodule 

module fourbitcounter(input enable, clock, resetn, output reg [3:0] q);
	always @(posedge clock) // triggered every time clock rises
	begin
		if (resetn == 1'b1) // when reset is on
		begin
			q <= 0; // q is set to 0
		end
		else if (enable == 1'b1) // increment q only when Enable is 1
		begin
			q <= q + 1; // increment q
		end
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
