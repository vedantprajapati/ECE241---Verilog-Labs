module register(input d, input reset, input clk, input enable, output reg q);
	always @(posedge clk)
	begin
		if(reset == 1)
			q <= 0;
		if(enable == 1)
			q <= d;
		end
endmodule

module store_A_B(input [3:0]A_B, input reset, input clk, input enable, output [3:0]q);
	register r1(A_B[3],reset,clk,enable,q[3]);
	register r2(A_B[2],reset,clk,enable,q[2]);
	register r3(A_B[1],reset,clk,enable,q[1]);
	register r4(A_B[0],reset,clk,enable,q[0]);
endmodule

module store_op_select(input [1:0]op_select, input reset, input clk, input enable, output [1:0]q);
	register r1(op_select[1],reset,clk,enable,q[1]);
	register r2(op_select[0],reset,clk,enable,q[0]);
endmodule

module store_op_num(input [4:0]op_num, input reset, input clk, input enable, output [4:0]q);
	register r1(op_num[4],reset,clk,enable,q[4]);
	register r2(op_num[3],reset,clk,enable,q[3]);
	register r3(op_num[2],reset,clk,enable,q[2]);
	register r4(op_num[1],reset,clk,enable,q[1]);
	register r5(op_num[0],reset,clk,enable,q[0]);
endmodule

module counter(input reset, input clk, input enable, output reg [4:0]q);
	always @(posedge clk)
	begin
		if(reset == 1)
			q <= 0;
		if(enable == 1)
			q <= q+1;
		end
endmodule

module mux2to1(x, y, s, m);
    input x; //select 0
    input y; //select 1
    input s; //select signal
    output reg m; //output
  
   always @(*)
	begin
		case(s)
			1'b0: m=x;
			1'b1: m=y;
		endcase
	end 
	 
endmodule

module fulladder(input a,b,c_in,output s, c_out);//Not needed
	assign s=c_in^b^a;
	assign c_out=(a&b)|(c_in&a)|(c_in&b);
endmodule

module adder(input [3:0]A_or_B, input [4:0]addnum, output [4:0]result);//Not needed
	wire w1, w2, w3, w4;
	wire dne;//There shouldn't been anything in this wire, just a placeholder
	fulladder u1(A_or_B[0],addnum[0],0,result[0],w1);
	fulladder u2(A_or_B[1],addnum[1],w1,result[1],w2);
	fulladder u3(A_or_B[2],addnum[2],w2,result[2],w3);
	fulladder u4(A_or_B[3],addnum[3],w3,result[3],w4);
	fulladder u5(0,addnum[4],w4,result[4],dne);
endmodule

///STILL HAVE TO DO SUBTRACTION
