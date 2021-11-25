//Eugenio Alejandro Ruiz Mejia
//Digital Design
//Iteso
//Presilicon Bootcamp


//The purpose of this module is to count up to the clock frequency
//Once this happens, it outputs a '1' to be counted by another module
//It can be reset to 0 with the corresponding signal

module Counter1s_RCO
	(
		input mclk, reset,		//Master clock and reset input
		output RCO  // Ripple Carry Output
  	);

  localparam CUENTA= 50000000; // 50MHz, Clock Freq
  integer conteo;

  always@ (negedge reset, posedge mclk)
	begin
	   if (reset == 1'b0 ) conteo <= 0;
	   else
				if (conteo == CUENTA) conteo <=0; //
				else conteo <= conteo + 1;
		end
		
	// Ripple Carry Output
	assign RCO = (conteo == CUENTA) ? 1'b1 : 1'b0 ; //
	
endmodule 