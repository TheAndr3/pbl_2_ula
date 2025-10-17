module flag_ov (
	output ledr6
);

	wire gnd = 1'b0, aux;
	
	not fo0 (aux, gnd);
	not fo1 (ledr6, aux);

endmodule