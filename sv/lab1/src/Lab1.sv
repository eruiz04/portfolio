
//Ruiz Mejia Eugenio Alejandro
//2 to 1 multiplexer

`ifndef LAB1_SV
    `define LAB1_SV
module Lab1
import Lab1_pkg::*;
(
input datawidth_t in_a,in_b,
input sel,
output datawidth_t Data_out
);
	//PARTE DECLARATORIA: Nets y variables
	datawidth_t I [2];
	//PARTE OPERATORIA
	assign I[0]=in_a;
	assign I[1]=in_b;
	assign Data_out =I[sel];
	
endmodule 
`endif