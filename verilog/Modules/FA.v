module FA (sum, c_out, a, b, c_in);
  output 			sum, c_out;
  input 			a, b, c_in;
  wire 			w1, w2, w3;

  HA 	M1 (w1, w2, a, b);
  HA	M2 (sum, w3, w1, c_in);
  or	 		M3 (c_out, w2, w3);
endmodule
