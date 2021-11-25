//Ruiz Mejia Eugenio Alejandro

module Lab2Mux # (parameter DW_SEL = 2, parameter type p1  = int) (data_in, select, data_out);
input p1 data_in [2**DW_SEL];
input [DW_SEL-1:0] select;
output p1 data_out;
assign data_out = data_in[select];
endmodule