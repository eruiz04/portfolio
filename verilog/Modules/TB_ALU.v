module TB_ALU ();
  parameter				width = 4;
  parameter				sel_width = 5;
  wire	[width -1: 0] 	y;
  reg		[width -1: 0] 	a;
  reg		[width -1: 0] 	b;
  reg					c_in;
  reg		[sel_width -1: 0]	select;
  reg		  			error;
  reg		[width -1: 0]	expected_value;
  integer				Num_Errors;
  ALU M0 (y, a, b, c_in, select);

initial #0 error = 0;
// ***********************************  Test Arithmetic Functions
initial  $display (" t    sel c_in  a   b  ");
initial #0 $display ($realtime,, "%b  %b  %b %b  Esperado = %b Obtenido = %b error = %b", select, c_in, a, b, expected_value, y, error);
initial Num_Errors = 0;

initial fork  // Bloques paralelos fork-join
// Transfer a to y
#100 a = {(width/2){2'b10}};	// Concatenacion
#100 b = {(width/2){2'b01}};
#100 c_in = 0;
#100 select = 0;
#105 expected_value =  a;   // Inducir errores
#110 begin error = | (expected_value ^ y); Num_Errors = Num_Errors + error; end 	// Forma 1
//#110 capture_error;		  // Forma 2, ver la tarea capture_error al final
#111 $display ($realtime,, "%b  %b  %b %b  Esperado = %b Obtenido = %b error = %b", select, c_in, a, b, expected_value, y, error);
//#111 disp;                 // Ver la tarea disp al final

// Inc a 
#150 error = 0;
#150 a = {(width/2){2'b10}};
#150 b = {(width/2){2'b01}};
#150 c_in = 1;
#150 select = 0;
#155 expected_value = a + 1;
#160 capture_error;
#161 disp;

// Add: a + b
#200 a = {(width/2){2'b10}};
#200 b = {(width/2){2'b01}};
#200 c_in = 0;
#200 select = 1;
#205 expected_value = a + b;
#210 capture_error;
#211 disp;

// Add with carry: a + b + 1 
#250 error = 0;
#250 a = {(width/2){2'b10}};
#250 b = {(width/2){2'b01}};
#250 c_in = 1;
#250 select = 1;
#255 expected_value = a + b+ 1;
#260 capture_error;
#261 disp;

// Add: a + (C´1 of b)
#300 a = {(width/2){2'b10}};
#300 b = {(width/2){2'b01}};
#300 c_in = 0;
#300 select = 2;
#305 expected_value = a + ~b;
#310 capture_error;
#311 disp;

// Subtract: a - b (C´2) 
#350 error = 0;
#350 a = {(width/2){2'b10}};
#350 b = {(width/2){2'b01}};
#350 c_in = 1;
#350 select = 2;
#355 expected_value = a + (~b) + 1;
#360 capture_error;
#361 disp;

// Dec a
#400 a = {(width/2){2'b10}};
#400 b = {(width/2){2'b01}};
#400 c_in = 0;
#400 select = 3;
#405 expected_value = a -1;
#410 capture_error;
#411 disp;

// Transfer b to y 
#450 error = 0;
#450 a = {(width/2){2'b10}};
#450 b = {(width/2){2'b01}};
#450 c_in = 1;
#450 select = 3;
#455 expected_value = b;
#460 capture_error;
#461 disp;

// *********************************** Test Logic Functions
// Bitwise AND
#500 a = {(width/2){2'b10}};
#500 b = {(width/2){2'b01}};
#500 c_in = 0;
#500 select = 4;
#505 expected_value = a & b;
#510 capture_error;
#511 disp;

// Bitwise OR 
#550 error = 0;
#550 a = {(width/2){2'b10}};
#550 b = {(width/2){2'b01}};
#550 c_in = 0;
#550 select = 5;
#555 expected_value = a | b;
#560 capture_error;
#561 disp;

// Bitwise XOR
#600 a = {(width/2){2'b10}};
#600 b = {(width/2){2'b01}};
#600 c_in = 0;
#600 select = 6;
#605 expected_value = a ^ b;
#610 capture_error;
#611 disp;

// Bitwise Complement 
#650 error = 0;
#650 a = {(width/2){2'b10}};
#650 b = {(width/2){2'b01}};
#650 c_in = 0;
#650 select = 7;
#655 expected_value = ~a;
#660 capture_error;
#661 disp;

// *********************************** Test Shift Functions
// Shift Left A 
#750 error = 0;
#750 a = {(width/2){2'b10}};
#750 b = {(width/2){2'b01}};
#750 c_in = 0;
#750 select = 8;
#755 expected_value = a << 1;
#770 capture_error;
#771 disp;

// Shift Right A 
#850 error = 0;
#850 a = {(width/2){2'b10}};
#850 b = {(width/2){2'b01}};
#850 c_in = 0;
#850 select = 16;
#855 expected_value = a >> 1;
#880 capture_error;
#881 disp;

// Load 0s
#950 error = 0;
#950 a = {(width/2){2'b10}};
#950 b = {(width/2){2'b01}};
#950 c_in = 0;
#950 select = 24;
#955 expected_value = 0; 
#990 capture_error;
#991 disp;

join

task capture_error;
   begin
   error = | (expected_value ^ y); Num_Errors = Num_Errors + error;   
   end
endtask

task disp;
   begin
   	$display ($realtime,, "%b  %b  %b %b  Esperado = %b obtenido = %b error = %b", select, c_in, a, b, expected_value, y, error);
   end
endtask

initial begin
  #1500 $display ("Number of Errors: %d", Num_Errors);
  $finish;
end
endmodule




