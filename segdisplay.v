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