module rateDivider(CLOCK_50, reset, enable, sec_counter);
	parameter width = 26;
	parameter ratio = 1;
	input CLOCK_50, reset;
	
 
	reg [width-1:0] count;
	input enable;
	output reg [4:0]sec_counter;

	always@(posedge CLOCK_50)
		if (reset == 0)
		begin
			count <= 49999999;
			sec_counter <= 5'b0;
			end
		else if(count == 0 && enable == 1)
		begin
			count <= 49999999;
			sec_counter <= sec_counter + 1;
			end
		else if(count != 0 && enable == 1)
		begin 
		count <= count - ratio;
		end
		
endmodule
