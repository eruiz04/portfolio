`timescale 1ns / 1ps
module tb_Lab1();

import Lab1_pkg::*;
//`include "my_code.svh"

datawidth_t     in_a, in_b,Data_out;
logic				 sel;

Lab1 uut(
.in_a         (in_a         ) ,
.in_b         (in_b         ) ,
.Data_out     (Data_out     ) ,
.sel			  (sel)

);

//integer idx;

initial begin
        
        in_a = 0;
        in_b = 0;
		  sel = 0;

        repeat (100)
            #1  {sel,in_a,in_b} ={sel,in_a,in_b}+1;

        #100
    $stop;
end

endmodule 