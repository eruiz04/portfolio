//Eugenio Alejandro Ruiz Mejia
//Digital Design
//Iteso
//Presilicon Bootcamp
//Digital Clock
//12-Nov-2021


module reloj_wrapper (
	input   MAX10_CLK1_50, //FPGA clock
	input  [1:0] SW, //Switches
	output [0:6] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, //displays
	output [9:0]		LEDR	//Leds
	);
	
	localparam WIDTH = 8;      //8 bit wide variables
	localparam SECONDS = 8'h59; //Max count for seconds
	localparam MINUTES = 8'h59; //Max count for minutes
	localparam HOURS   = 8'h23; //Max count for hours
	wire Clock = MAX10_CLK1_50 ;	//FPGA Clock
	wire Resetn = SW[0]; 
	wire Master_En = SW[1];
	wire En_Sec, En_Min, En_Hrs;
	wire [WIDTH-1:0] Sec, Min, Hrs;
   wire RCO_s, RCO_m, RCO_h,RCO_d;
	// Counter Instantiation
	 
	assign En_Sec = RCO_s & Master_En ;	//if RCO_s and master enable are 1, then the seconds count in active
   assign En_Min = RCO_s & RCO_m & Master_En; //if RCO_s, RCO_m and master enable are 1, then the minutes count in active
   assign En_Hrs = RCO_s & RCO_m & RCO_h & Master_En; //if RCO_s, RCO_m and RCO_h and master enable are 1, then the hours count in active
	
	//modules instances
	Counter1s_RCO Clk_1s_RCO ( .mclk(Clock), .reset(Resetn), .RCO(RCO_s) );  // RCO generation for Enable other counters
	counter_dec # (.MAXCOUNT(SECONDS)) Seconds (.Clk(Clock), .Reset(Resetn), .Enable(En_Sec), .CurrentCount(Sec), .RCO(RCO_m)  );
	counter_dec # (.MAXCOUNT(MINUTES)) Minutes (.Clk(Clock), .Reset(Resetn), .Enable(En_Min), .CurrentCount(Min), .RCO(RCO_h)  );
	counter_dec # (.MAXCOUNT(HOURS))   Hours (.Clk(Clock), .Reset(Resetn), .Enable(En_Hrs), .CurrentCount(Hrs), .RCO(RCO_d)  );
	
	// drive the displays
	hex7seg digit1_Sec (Sec[3:0], HEX0);
	hex7seg digit0_Sec (Sec[7:4], HEX1);
	hex7seg digit1_Min (Min[3:0], HEX2);
	hex7seg digit0_Min (Min[7:4], HEX3);
	hex7seg digit1_Hrs (Hrs[3:0], HEX4);
	hex7seg digit0_Hrs (Hrs[7:4], HEX5);
	// drive the LEDs
	assign LEDR ={Sec,Resetn,RCO_d};  //Display Count, Enable (RCO) and Reset 
endmodule