/*
Eugenio Alejandro Ruiz Mejia
Iteso
Intel bootcamp presilicio
Finite State Machine Implementation
12-11-2021
*/
module FSM(

input reset, clk,w,
output reg z, 
output reg [3:0] Y 
);



	reg [3:0] change;
	reg [3:0] State;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			z <= 1'b0;
			change <= 4'b0101;
		end
		else begin
			if ((change == 4'b0000)|(change == 4'b1111))
				z <= 1'b1;
			else
				z <= 1'b0;
			change[3:0] <= { change[2:0] , w };
		end
	end

	localparam A=0, B=1, C=2, D=3, E=4, F=5, G=6, H=7, I=8;
	always @ (State) begin
		case(State)
			A: Y = 4'b0000;
			B: Y = 4'b0001;
			C: Y = 4'b0010;
			D: Y = 4'b0011;
			E: Y = 4'b0100;
			F: Y = 4'b0101;
			G: Y = 4'b0110;
			H: Y = 4'b0111;
			I: Y = 4'b1000;
			default: Y = 0;
		endcase
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			State = A;
		end
		else begin
			case(State)
				A:
					if (w)
						State = F;
					else
						State = B;
				B: 
					if (w)
						State = F;
					else
						State = C;
				C:
					if (w)
						State = F;
					else
						State = D;
				D:
					if (w)
						State = F;
					else
						State = E;
				E:
					if (w)
						State = F;
					else
						State = E;
				F:
					if (w)
						State = G;
					else
						State = B;
				G:
					if (w)
						State = H;
					else
						State = B;
				H:
					if (w)
						State = I;
					else
						State = B;
				I:
					if (w)
						State = I;
					else
						State = B;
			endcase
		end
	end
	
endmodule 