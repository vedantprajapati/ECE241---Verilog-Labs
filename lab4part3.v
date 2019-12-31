`timescale 1ns / 1ns

module lab4part3 (SW, KEY, LEDR);
    input [9:0] SW;
    input [3:0] KEY;
    output [7:0] LEDR;

    shiftRegister top(
        .Clk(KEY[0]),
        .reset(SW[9]),
        .loadn(KEY[1]),
        .loadLeft(KEY[2]),
        .rotateRight(KEY[3]),
        .D(SW[7:0]),
        .Q(LEDR[7:0])
    );

endmodule

module shiftRegister(Clk, reset, loadn, loadLeft,rotateRight, D, Q); //loadn = parallel load n,loadleft= rotateright
    input Clk, reset, loadn, loadLeft, rotateRight;
    input [7:0] D;
    output reg [7:0] Q;

    always@(posedge Clk)
			begin
			if (reset)
				begin
				Q <= {8{1'b0}};//if the program is reset then q =00000000
				end
				
         else
				begin
				
				if (loadn) //if loadn is true
					begin
					
					if (loadLeft)   //if loadleft is true
						begin
						
						if (~rotateRight)   //if load left while moving left value to right is true
							begin
								Q[0] <= Q[1];
								Q[1] <= Q[2];
								Q[2] <= Q[3];
								Q[3] <= Q[4];
								Q[4] <= Q[5];
								Q[5] <= Q[6];
								Q[6] <= Q[7];
								Q[7] <= Q[0];
							end
						else    //else dont carry over the q7 value to be q1
							begin
								Q[0] <= Q[1];
								Q[1] <= Q[2];
								Q[2] <= Q[3];
								Q[3] <= Q[4];
								Q[4] <= Q[5];
								Q[5] <= Q[6];
								Q[6] <= Q[7];
								Q[7] <= 1'b0;
							end
						end
						
					else    //other way around
						begin
							Q[7] <= Q[6];
							Q[6] <= Q[5];
							Q[5] <= Q[4];
							Q[4] <= Q[3];
							Q[3] <= Q[2];
							Q[2] <= Q[1];
							Q[1] <= Q[0];
							Q[0] <= Q[7];
						end
					end
					
				else
					begin
                Q <= D; //load the value of n (set the value) to be d  
					end
				end 
			end
endmodule