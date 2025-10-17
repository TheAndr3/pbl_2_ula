module divisao_5por4 (
	input wire [4:0] a,
	input wire [3:0] b,
	output wire [4:0] s
);
	wire [4:0] s_div_result; 
	wire b_is_zero;          
	wire not_b_is_zero;      

	wire gnd = 1'b0;
	
	//Entradas negadas
	wire nA0, nA1, nA2, nA3, nA4, nB0, nB1, nB2, nB3;
	
	not n_A0 (nA0, a[0]);
	not n_A1 (nA1, a[1]);
	not n_A2 (nA2, a[2]);
	not n_A3 (nA3, a[3]);
	not n_A4 (nA4, a[4]);
	not n_B0 (nB0, b[0]);
	not n_B1 (nB1, b[1]);
	not n_B2 (nB2, b[2]);
	not n_B3 (nB3, b[3]);

	//s0
	wire na4a3a1a0nb2_and, na4a3a2b3nb2_and, na4a3a0nb2nb1_and, na4a0nb3nb2nb1_and, na4a3a1nb2nb0_and, na4a1nb3nb2nb0_and;
	wire na4a3a2nb1nb0_and, na4a2nb3nb1nb0_and, na4a3nb2nb1nb0_and, na4a3a2a1a0b3_and, na4na2a1a0nb3nb2_and, na4a3na2a1nb3b1_and;
	wire na4a3na2nb3b2b1_and, na4a3a2a1b3nb1_and, na4a3a2a0b3nb1_and, na4na3a2a0nb3nb1_and, na4a3a1b3nb2nb1_and, na4a3a2a1b3nb0_and ;
	wire na4na3a2a1nb3nb0_and, a4na3na2na1na0b3b2_and, na4na3a2a1a0nb3b2_and, a4na3na2na1na0b3b1_and, na4na3a2a1nb3b2nb1_and;
	wire a4na3na2na1na0b3b0_and, na4a3na2na1nb3b2b0_and, na4a3na1nb3b2b1b0_and, a4na3na2na1na0nb2b1b0_and, na4na3a2na1nb3nb2b1b0_and;
	wire a4na3na2na1na0b2nb1b0_and, na4a2a1a0nb3nb1_and, na4a3na2a0nb3b1b0_and;
	
	and d1 (na4a3a1a0nb2_and, nA4, a[3], a[1], a[0], nB2);
	and d2 (na4a3a2b3nb2_and, nA4, a[3], a[2], b[3], nB2);
	and d3 (na4a3a0nb2nb1_and, nA4, a[3], a[0], nB2, nB1);
	and d4 (na4a0nb3nb2nb1_and, nA4, a[0], nB3, nB2, nB1);
	and d5 (na4a3a1nb2nb0_and, nA4, a[3], a[1], nB2, nB0);
	and d6 (na4a1nb3nb2nb0_and, nA4, a[1], nB3, nB2, nB0);
	and d7 (na4a3a2nb1nb0_and, nA4, a[3], a[2], nB1, nB0);
	and d8 (na4a2nb3nb1nb0_and, nA4, a[2], nB3, nB1, nB0);
	and d9 (na4a3nb2nb1nb0_and, nA4, a[3], nB2, nB1, nB0);
	and d10 (na4a3a2a1a0b3_and, nA4, a[3], a[2], a[1], a[0], b[3]);
	and d11 (na4na2a1a0nb3nb2_and, nA4, nA2, a[1], a[0], nB3, nB2);
	and d12 (na4a3na2a1nb3b1_and, nA4, a[3], nA2, a[1], nB3, b[1]);
	and d13 (na4a3na2nb3b2b1_and, nA4, a[3], nA2, nB3, b[2], b[1]);
	and d14 (na4a3a2a1b3nb1_and, nA4, a[3], a[2], a[1], b[3], nB1);
	and d15 (na4a3a2a0b3nb1_and, nA4, a[3], a[2], a[0], b[3], nB1);
	and d16 (na4na3a2a0nb3nb1_and, nA4, nA3, a[2], a[0], nB3, nB1);
	and d17 (na4a3a1b3nb2nb1_and, nA4, a[3], a[1], b[3], nB2, nB1);
	and d18 (na4a3a2a1b3nb0_and, nA4, a[3], a[2], a[1], b[3], nB0);
	and d19 (na4na3a2a1nb3nb0_and, nA4, nA3, a[2], a[1], nB3, nB0);
	and d20 (a4na3na2na1na0b3b2_and, a[4], nA3, nA2, nA1, nA0, b[3], b[2]);
	and d21 (na4na3a2a1a0nb3b2_and, nA4, nA3, a[2], a[1], a[0], nB3, b[2]);
	and d22 (a4na3na2na1na0b3b1_and, a[4], nA3, nA2, nA1, nA0, b[3], b[1]);
	and d23 (na4na3a2a1nb3b2nb1_and, nA4, nA3, a[2], a[1], nB3, b[2], nB1);
	and d24 (a4na3na2na1na0b3b0_and, a[4], nA3, nA2, nA1, nA0, b[3], b[0]);
	and d25 (na4a3na2na1nb3b2b0_and, nA4, a[3], nA2, nA1, nB3, b[2], b[0]);
	and d26 (na4a3na1nb3b2b1b0_and, nA4, a[3], nA1, nB3, b[2], b[1], b[0]);
	and d27 (a4na3na2na1na0nb2b1b0_and, a[4], nA3, nA2, nA1, nA0, nB2, b[1], b[0]);
	and d28 (na4na3a2na1nb3nb2b1b0_and, nA4, nA3, a[2], nA1, nB3, nB1, b[1], b[0]);
	and d29 (a4na3na2na1na0b2nb1b0_and, a[4], nA3, nA2, nA1, nA0, b[2], nB1, b[0]);
	and d30 (na4a2a1a0nb3nb1_and, nA4, a[2], a[1], a[0], nB3, nB1);
	and d31 (na4a3na2a0nb3b1b0_and, nA4, a[3], nA2, a[0], nB3, b[1], b[0]);

	or d0s0 (s_div_result[0], na4a3a1a0nb2_and, na4a3a2b3nb2_and, na4a3a0nb2nb1_and, na4a0nb3nb2nb1_and, na4a3a1nb2nb0_and, na4a1nb3nb2nb0_and,
	na4a3a2nb1nb0_and, na4a2nb3nb1nb0_and, na4a3nb2nb1nb0_and, na4a3a2a1a0b3_and, na4na2a1a0nb3nb2_and, na4a3na2a1nb3b1_and,
	na4a3na2nb3b2b1_and, na4a3a2a1b3nb1_and, na4a3a2a0b3nb1_and, na4na3a2a0nb3nb1_and, na4a3a1b3nb2nb1_and, na4a3a2a1b3nb0_and,
	na4na3a2a1nb3nb0_and, a4na3na2na1na0b3b2_and, na4na3a2a1a0nb3b2_and, a4na3na2na1na0b3b1_and, na4na3a2a1nb3b2nb1_and,
	a4na3na2na1na0b3b0_and, na4a3na2na1nb3b2b0_and, na4a3na1nb3b2b1b0_and, a4na3na2na1na0nb2b1b0_and, na4na3a2na1nb3nb2b1b0_and,
	a4na3na2na1na0b2nb1b0_and, na4a2a1a0nb3nb1_and, na4a3na2a0nb3b1b0_and);

	//s1
	wire na4a3a1nb3nb1_and, na4a1nb3nb2nb1_and, na4a3a2nb3nb0_and, na4a2nb3nb2nb0_and, na4a3a2a1nb3b2_and, na4na3a2a1nb3nb2_and;
	wire na4a3a2nb3b2nb1_and, na4a3na2nb3nb2b1b0_and, a4na3na2na1na0nb3b2b1_and, a4na3na2na1na0nb3b2b0_and, a4na3na2na1na0nb2nb1nb0_and;

	and d32 (na4a3a1nb3nb1_and, nA4, a[3], a[1], nB3, nB1);
	and d33 (na4a1nb3nb2nb1_and, nA4, a[1], nB3, nB2, nB1);
	and d34 (na4a3a2nb3nb0_and, nA4, a[3], a[2], nB3, nB0);
	and d35 (na4a2nb3nb2nb0_and, nA4, a[2], nB3, nB2, nB0);
	and d36 (na4a3a2a1nb3b2_and, nA4, a[3], a[2], a[1], nB3, b[2]);
	and d37 (na4na3a2a1nb3nb2_and, nA4, nA3, a[2], a[1], nB3, nB2);
	and d38 (na4a3a2nb3b2nb1_and, nA4, a[3], a[2], nB3, b[2], nB1);
	and d39 (na4a3na2nb3nb2b1b0_and, nA4, a[3], nA2, nB3, nB2, b[1], b[0]);
	and d40 (a4na3na2na1na0nb3b2b1_and, a[4], nA3, nA2, nA1, nA0, nB3, b[2], b[1]);
	and d41 (a4na3na2na1na0nb3b2b0_and, a[4], nA3, nA2, nA1, nA0, nB3, b[2], b[0]);
	and d42 (a4na3na2na1na0nb2nb1nb0_and, a[4], nA3, nA2, nA1, nA0, nB2, nB1, nB0);
	
	or d1s1 (s_div_result[1], na4a3a1nb3nb1_and, na4a1nb3nb2nb1_and, na4a3a2nb3nb0_and, na4a2nb3nb2nb0_and, na4a3a2a1nb3b2_and, na4na3a2a1nb3nb2_and,
	na4a3a2nb3b2nb1_and, na4a3na2nb3nb2b1b0_and, a4na3na2na1na0nb3b2b1_and, a4na3na2na1na0nb3b2b0_and, a4na3na2na1na0nb2nb1nb0_and);
	
	//s2
	wire na4a3a2nb3nb2_and, na4a2nb3nb2nb1_and, na4a3nb3nb2nb0_and, a4na3na2na1na0nb3nb1nb0_and;
	wire a4na3na2na1na0nb3nb2b1b0_and;

	and d43 (na4a3a2nb3nb2_and, nA4, a[3], a[2], nB3, nB2);
	and d44 (na4a2nb3nb2nb1_and, nA4, a[2], nB3, nB2, nB1);
	and d45 (na4a3nb3nb2nb0_and, nA4, a[3], nB3, nB2, nB0);
	and d46 (a4na3na2na1na0nb3nb1nb0_and, a[4], nA3, nA2, nA1, nA0, nB3, nB1, nB0);
	and d47 (a4na3na2na1na0nb3nb2b1b0_and, a[4], nA3, nA2, nA1, nA0, nB3, nB2, b[1], b[0]);
	
	or d2s2 (s_div_result[2], na4a3a2nb3nb2_and, na4a2nb3nb2nb1_and, na4a3nb3nb2nb0_and, a4na3na2na1na0nb3nb1nb0_and,
	a4na3na2na1na0nb3nb2b1b0_and);

	//s3
	wire na4a3nb3nb2nb1_and, a4na3na2na1na0nb3nb2nb0_and;
	
	and d48 (na4a3nb3nb2nb1_and, nA4, a[3], nB3, nB2, nB1);
	and d49 (a4na3na2na1na0nb3nb2nb0_and, a[4], nA3, nA2, nA1, nA0, nB3, nB2, nB0);
	
	or d3s3 (s_div_result[3], na4a3nb3nb2nb1_and, a4na3na2na1na0nb3nb2nb0_and);

	//s4
	and d4s4 (s_div_result[4], a[4], nA3, nA2, nA1, nA0, nB3, nB2, nB1);

	// --- Lógica de Proteção Contra Divisão por Zero ---

	nor U_B_IS_ZERO_NOR (b_is_zero, b[0], b[1], b[2], b[3]);
	
	not U_NOT_B_IS_ZERO (not_b_is_zero, b_is_zero);

	and U_S0_OUT (s[0], s_div_result[0], not_b_is_zero);
	and U_S1_OUT (s[1], s_div_result[1], not_b_is_zero);
	and U_S2_OUT (s[2], s_div_result[2], not_b_is_zero);
	and U_S3_OUT (s[3], s_div_result[3], not_b_is_zero);
	and U_S4_OUT (s[4], s_div_result[4], not_b_is_zero);

endmodule