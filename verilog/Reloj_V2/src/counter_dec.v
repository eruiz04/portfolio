/* Two Digits Decimal Counter 
Tabla de Verdad (- significa don't care):

Reset	Clock	Enable	Count
	0	  -	-				0
	1	  ^	0			Count
	1	  ^	1			Count + 1 (decade)
*/
// REQUERIMIENTOS
// decade counter
// 8 bits
// synchronous, positive edge
// asynchronous reset, active low
// synchronous enable, active high
// decade counter mode 1 = 2x4 bits

//the purpose of this module is to count up to decades
//If it reaches a value of 60, then it resets itself via the parameter MAXCOUNT

module counter_dec (input Clk, Reset, Enable,
                output reg [7:0] CurrentCount,
					 output RCO);

					 parameter MAXCOUNT =8'h59;
					 
  always @ (posedge Clk or negedge Reset)
    begin
      if (!Reset)
        //Count <= 2'h00;
		  CurrentCount <= 0;
      else
        if (Enable)
		  //Here we evaluate the least significant bits (units)
          if (CurrentCount[3:0] != MAXCOUNT[3:0])
            CurrentCount[3:0] <= CurrentCount[3:0] + 4'b0001;
          else
            begin
              CurrentCount[3:0] <= 4'b0000;
				  //Here we evaluate the most significant bits (decades)
              if (CurrentCount[7:4] != MAXCOUNT[7:4]) 
                CurrentCount[7:4] <= CurrentCount[7:4] + 4'b0001;
              else
               CurrentCount[7:4] <= 4'b0000;
            end
    end
	 assign RCO = (CurrentCount == MAXCOUNT) ? 1'b1 : 1'b0 ; 
	 //if the current count is equal to the maximum count, then RCO takes a value of 1 
endmodule
