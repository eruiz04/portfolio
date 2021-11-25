/*
Eugenio Alejandro Ruiz Mejia
Iteso
Intel bootcamp presilicio
Finite State Machine Implementation
12-11-2021
*/
module FSMwrapper(
input [1:0] KEY,
input [9:0] SW,
output [9:0] LEDR
);

FSM Tema7M3(.reset(SW[0]), .clk(KEY[0]), .w(SW[1]), .z(LEDR[9]), .Y(LEDR[3:0]));

endmodule
