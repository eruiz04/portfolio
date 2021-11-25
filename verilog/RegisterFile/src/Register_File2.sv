//This will be the top module for the register file project

module Register_File2 #(parameter N = 32)(
input clk, reset,

input Reg_Write_i, //Write enable
//input [4:0] Write_Register_i, //rd
input [N-1:0] Write_Register_i, //rd
input [4:0] Read_Register_1_i, //rs 
input [4:0] Read_Register_2_i, //rt
input [N-1:0] Write_Data_i, //R[rd]

output [N-1:0] Read_Data_1_o, //R[rs]
output [N-1:0] Read_Data_2_o, //R[rt]
//output [N-1:0] Registers0,Registers1,Registers2,
output [N-1:0] Registers [N-1:0]
);

wire [N-1:0] OneHot;

initial begin
		Registers[0] <= 32'h00000000;
		Registers[1] <= 32'h00000000;
		Registers[2] <= 32'h00000000;
		Registers[3] <= 32'h00000000;
		Registers[4] <= 32'h00000000;
		Registers[5] <= 32'h00000000;
		Registers[6] <= 32'h00000000;
		Registers[7] <= 32'h00000000;
		Registers[8] <= 32'h00000000;
		Registers[9] <= 32'h00000000;
		Registers[10] <= 32'h00000000;
		Registers[11] <= 32'h00000000;
		Registers[12] <= 32'h00000000;
		Registers[13] <= 32'h00000000;
		Registers[14] <= 32'h00000000;
		Registers[15] <= 32'h00000000;
		Registers[16] <= 32'h00000000;
		Registers[17] <= 32'h00000000;
		Registers[18] <= 32'h00000000;
		Registers[19] <= 32'h00000000;
		Registers[20] <= 32'h00000000;
		Registers[21] <= 32'h00000000;
		Registers[22] <= 32'h00000000;
		Registers[23] <= 32'h00000000;
		Registers[24] <= 32'h00000000;
		Registers[25] <= 32'h00000000;
		Registers[26] <= 32'h00000000;
		Registers[27] <= 32'h00000000;
		Registers[28] <= 32'h00000000;
		Registers[29] <= 32'h00000000; // this value should point to the top of data memory, dont forget byte addressing
		Registers[31] <= 32'b0;
	end


onehot PriorityDecoder (.din(Write_Register_i),.dout(OneHot));


register #(.SIZE(N)) S0 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[0]), .clock_enable(Reg_Write_i & OneHot[0]));
register #(.SIZE(N)) S1 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[1]), .clock_enable(Reg_Write_i & OneHot[1]));
register #(.SIZE(N)) S2 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[2]), .clock_enable(Reg_Write_i & OneHot[2]));
register #(.SIZE(N)) S3 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[3]), .clock_enable(Reg_Write_i & OneHot[3]));
register #(.SIZE(N)) S4 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[4]), .clock_enable(Reg_Write_i & OneHot[4]));
register #(.SIZE(N)) S5 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[5]), .clock_enable(Reg_Write_i & OneHot[5]));
register #(.SIZE(N)) S6 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[6]), .clock_enable(Reg_Write_i & OneHot[6]));
register #(.SIZE(N)) S7 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[7]), .clock_enable(Reg_Write_i & OneHot[7]));
register #(.SIZE(N)) S8 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[8]), .clock_enable(Reg_Write_i & OneHot[8]));
register #(.SIZE(N)) S9 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[9]), .clock_enable(Reg_Write_i & OneHot[9]));
register #(.SIZE(N)) S10 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[10]), .clock_enable(Reg_Write_i & OneHot[10]));
register #(.SIZE(N)) S11 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[11]), .clock_enable(Reg_Write_i & OneHot[11]));
register #(.SIZE(N)) S12 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[12]), .clock_enable(Reg_Write_i & OneHot[12]));
register #(.SIZE(N)) S13 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[13]), .clock_enable(Reg_Write_i & OneHot[13]));
register #(.SIZE(N)) S14 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[14]), .clock_enable(Reg_Write_i & OneHot[14]));
register #(.SIZE(N)) S15 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[15]), .clock_enable(Reg_Write_i & OneHot[15]));
register #(.SIZE(N)) S16 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[16]), .clock_enable(Reg_Write_i & OneHot[16]));
register #(.SIZE(N)) S17 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[17]), .clock_enable(Reg_Write_i & OneHot[17]));
register #(.SIZE(N)) S18 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[18]), .clock_enable(Reg_Write_i & OneHot[18]));
register #(.SIZE(N)) S19 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[19]), .clock_enable(Reg_Write_i & OneHot[19]));
register #(.SIZE(N)) S20 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[20]), .clock_enable(Reg_Write_i & OneHot[20]));
register #(.SIZE(N)) S21 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[21]), .clock_enable(Reg_Write_i & OneHot[21]));
register #(.SIZE(N)) S22 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[22]), .clock_enable(Reg_Write_i & OneHot[22]));
register #(.SIZE(N)) S23 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[23]), .clock_enable(Reg_Write_i & OneHot[23]));
register #(.SIZE(N)) S24 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[24]), .clock_enable(Reg_Write_i & OneHot[24]));
register #(.SIZE(N)) S25 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[25]), .clock_enable(Reg_Write_i & OneHot[25]));
register #(.SIZE(N)) S26 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[26]), .clock_enable(Reg_Write_i & OneHot[26]));
register #(.SIZE(N)) S27 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[27]), .clock_enable(Reg_Write_i & OneHot[27]));
register #(.SIZE(N)) S28 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[28]), .clock_enable(Reg_Write_i & OneHot[28]));
register #(.SIZE(N)) S29 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[29]), .clock_enable(Reg_Write_i & OneHot[29]));
register #(.SIZE(N)) S30 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[30]), .clock_enable(Reg_Write_i & OneHot[30]));
register #(.SIZE(N)) S31 (.clk(clk), .clr(reset), .d(Write_Data_i), .q(Registers[31]), .clock_enable(Reg_Write_i & OneHot[31]));


mux32 #(.WIDTH(N)) RrsMux (.Sel(Read_Register_1_i), .Data_out(Read_Data_1_o), .I0(Registers[0]), .I1(Registers[1]), .I2(Registers[2]), .I3(Registers[3]),
.I4(Registers[4]), .I5(Registers[5]), .I6(Registers[6]), .I7(Registers[7]), .I8(Registers[8]), .I9(Registers[9]), .I10(Registers[10]), .I11(Registers[11]),
.I12(Registers[12]), .I13(Registers[13]), .I14(Registers[14]), .I15(Registers[15]), .I16(Registers[16]), .I17(Registers[17]), .I18(Registers[18]),
.I19(Registers[19]), .I20(Registers[20]), .I21(Registers[21]), .I22(Registers[22]), .I23(Registers[23]), .I24(Registers[24]), .I25(Registers[25]),
.I26(Registers[26]), .I27(Registers[27]), .I28(Registers[28]), .I29(Registers[29]), .I30(Registers[30]), .I31(Registers[31])); 

mux32 #(.WIDTH(N)) RrtMux (.Sel(Read_Register_2_i), .Data_out(Read_Data_2_o), .I0(Registers[0]), .I1(Registers[1]), .I2(Registers[2]), .I3(Registers[3]),
.I4(Registers[4]), .I5(Registers[5]), .I6(Registers[6]), .I7(Registers[7]), .I8(Registers[8]), .I9(Registers[9]), .I10(Registers[10]), .I11(Registers[11]),
.I12(Registers[12]), .I13(Registers[13]), .I14(Registers[14]), .I15(Registers[15]), .I16(Registers[16]), .I17(Registers[17]), .I18(Registers[18]),
.I19(Registers[19]), .I20(Registers[20]), .I21(Registers[21]), .I22(Registers[22]), .I23(Registers[23]), .I24(Registers[24]), .I25(Registers[25]),
.I26(Registers[26]), .I27(Registers[27]), .I28(Registers[28]), .I29(Registers[29]), .I30(Registers[30]), .I31(Registers[31])); 



endmodule 