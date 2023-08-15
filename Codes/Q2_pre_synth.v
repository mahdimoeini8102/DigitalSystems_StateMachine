`timescale 1ns/1ns

module mealy10010(input clk, rst, j, output w);
	reg [2:0] ns, ps;
	parameter 	A = 3'b000,
				B = 3'b001, 
				C = 3'b010, 
				D = 3'b011, 
				E = 3'b100;
	always @(ps, j) begin
		ns = A;
		case(ps)
			A: ns = j ? B : A;
			B: ns = j ? B : C;
			C: ns = j ? B : D;
			D: ns = j ? E : A;
			E: ns = j ? B : C;
		endcase
	end
	assign w = (ps == E) ? j : 1'b0;
	always @(posedge clk, posedge rst) if (rst) ps <= A; else ps <= ns;
endmodule

module TB ();
	reg j = 1, clk = 0, rst = 1; //First Initialize
	wire W;
	mealy10010 my_ic(clk, rst, j, W);
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