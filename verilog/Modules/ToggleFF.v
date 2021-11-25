// Flip-Flop Tipo T
module ToggleFF(T, Clk, Resetn, Q);
	input T, Clk, Resetn;
	output reg Q;
	
	always @(posedge Clk)
		if (Resetn  == 1'b0)	// synchronous clear
			Q <= 1'b0;
		else if(T)
			Q <= ~Q;
endmodule
