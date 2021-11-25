//Ruiz Mejia Eugenio Alejandro

`timescale 1ns / 1ps
module TB_Lab2Mux();
import Lab2Mux_pkg::*;
parameter  DW_SEL = 2;
op_codes_e_t    in_0[2**DW_SEL];
mem_ctl_st_t	in_1[2**DW_SEL];
op_codes_e_t    out_0;
mem_ctl_st_t	out_1;
logic	[DW_SEL-1:0] select;

Lab2Mux #(.DW_SEL(DW_SEL), .p1(op_codes_e_t)) UUT0(.data_in(in_0), .select(select), .data_out(out_0));
Lab2Mux #(.DW_SEL(DW_SEL), .p1(mem_ctl_st_t)) UUT1(.data_in(in_1), .select(select), .data_out(out_1));

initial begin: TB

	select=0;
	in_0[0]=EXECUTE;
	in_0[1]=FETCH;
	in_0[2]=DECODE;
	in_0[3]=WB;
	
	in_1[0].addr = 8'hAA;
	in_1[0].data = 4'h1;
	in_1[0].op = WR;
	in_1[1].addr = 8'hBB;
	in_1[1].data = 4'h2;
	in_1[1].op = RD; 
	in_1[2].addr = 8'hC1;
	in_1[2].data = 4'h3;
	in_1[2].op = WR;
	in_1[3].addr = 8'h7;
	in_1[3].data = 4'h3;
	in_1[3].op = RD;
     
	repeat (2**DW_SEL)
            #1  select = select+1;
    $stop;
end
endmodule 