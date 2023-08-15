`timescale 1ns/1ns

module TB ();
	reg j = 1, clk = 0, rst = 1; //First Initialize
	wire W1, W2;
	wire out;
	assign out = (W1 & ~W2) | (~W1 & W2);
	moore10010 my_ic1(clk, rst, j, W1);
	mealy10010 my_ic2(clk, rst, j, W2);
	always #20 clk = ~clk;
	initial begin
		#40 rst = 0;
		#40 j = 1;
		#40 j = 0;
		#40 j = 0;
		#40 j = 1;
		#40 j = 0;
		#40 j = 0;
		#40 j = 1;
		#40 j = 0;
		#40 j = 1;
		#100 $stop;
	end
endmodule
