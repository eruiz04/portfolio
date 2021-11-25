module ALU_MAX10(SW,LEDR);

input [9:0] SW;
output [9:0] LEDR;


//input signed [1:0] a,b;



wire [1:0] a;
wire [1:0] b;
wire select; 
wire c_in;
wire [3:0] result;

//module ALU (y, a, b, c_in, select);	
assign a = SW[9:8];
assign b = SW[7:6];
assign c_in = SW[0];
assign select = SW[5:1];
assign LEDR[9:0] = result;


ALU MAX10(result,a,b,c_in,select);



endmodule 