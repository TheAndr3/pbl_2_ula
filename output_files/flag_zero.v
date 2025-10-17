module flag_zero(
	input [6:0] HEX0,
	input [6:0] HEX1,
	output ledr9
);
	wire nHEX06, nHEX16;
	wire hex0_and, hex1_and;
	
	not nH06 (nHEX06, HEX0[6]);
	not nH16 (nHEX16, HEX1[6]);
	
	nand fz0 (hex0_and, HEX0[0], HEX0[1], HEX0[2], HEX0[3], HEX0[4], HEX0[5], nHEX06);
	nand fz1 (hex1_and, HEX1[0], HEX1[1], HEX1[2], HEX1[3], HEX1[4], HEX1[5], nHEX16);
	and fz (ledr9, hex0_and, hex1_and);

endmodule