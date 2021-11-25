module mux4to1
   #(parameter WIDTH=4)
   (input [WIDTH-1:0] I0,I1,I2,I3,
    input [1:0] Sel,
    output [WIDTH-1:0] Data_out);
	 
	 
//PARTE DECLARATORIA: Nets y variables
    wire [WIDTH-1:0] I [4];
//PARTE OPERATORIA
    assign I[0]=I0;
    assign I[1]=I1;
    assign I[2]=I2;
    assign I[3]=I3;
    assign Data_out =I[Sel];
   endmodule 