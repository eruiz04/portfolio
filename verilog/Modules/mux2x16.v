module mux2x16(a,b,e,s);
    input [3:0] a; // probar con 16 bits
    input [3:0] b;
    input  e;
    output [3:0] s;

    assign s = e ? a : b;

endmodule
