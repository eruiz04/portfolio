// Coder1:          Eugenio Alejandro Ruiz Mejía
// Coder2:          Gustavo Alejandro Solorio Ramos
// Coder3:          Enrique Zetina Martínez
// Date:            15 Noviembre 2021
// Name:            Lab3_FlipFlopD.sv
// Description:     Module to test a N register Flip-Flop D with DW size.
`timescale 1ns / 1ps

`include "Lab3_macro_def.def"
module Lab3_FlipFlopD_2();
////////////////////////////////////////////////
//  Parameter definitions
////////////////////////////////////////////////
    parameter 		N = 10;				//Number of FF_D registesrs
	parameter 		DW= 3;				//Width of each registers
////////////////////////////////////////////////
//  Logic declarations
////////////////////////////////////////////////
    logic        	clock = 1'b0;		//Clock signal
	logic         	reset = 1'b1;		//Reset signal
    logic 	[DW:0]  register [N];		//FF_D registesrs where register N = q, register N-1 = d
//Generate registers for FF_D
    generate
        for (genvar i = 1; i < N; ++i) begin: FF_D_macro
            `FF_D(register[i], register[i-1], clock, reset,"negedge")
        end
    endgenerate
//Show the selected report
initial `DISP_REP("INFO");							//Display Report Preferences
// Generates the clock signal each 10 time units
 always #10 clock = ~clock;
// Reset sequence
 always #100 reset = ~reset; 
    initial begin

	repeat (N) begin
            register[0] = $random();		//Saves a random value in register[0] every posedg clock signal
            @(posedge clock) #1;
        end
        $finish();
    end 
endmodule: Lab3_FlipFlopD_2