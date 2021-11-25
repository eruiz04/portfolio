module register(clk,clr,d,clock_enable,q);
parameter SIZE = 4;

input clk,clr,clock_enable;
input [SIZE -1 :0] d;
output [SIZE -1 :0] q;
reg [SIZE -1 :0] q;


//Register with active-high clock & asynchronous reset & synchronous clock enable 
	always @ (negedge clr or posedge clk)
begin
	// Reset whenever the reset signal goes low, regardless of the clock
	// or the clock enable
	if (!clr)
	begin
		q <= 0;
	end
	// If not resetting, and the clock signal is enabled on this register,
	// update the register output on the clock's rising edge
	else
	begin
		if (clock_enable)
		begin
			q <= d;
		end
	end
end

endmodule 
