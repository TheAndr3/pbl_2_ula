// Arquivo: mux_8_para_1_8bits.v
module mux_8_para_1_8bits (
    input  wire [7:0] D0, D1, D2, D3, D4, D5, D6, D7,
    input  wire [2:0] S,
    output wire [7:0] Y
);

	wire gnd = 1'b0;

    // Instancia um MUX de 8 para 1 para cada um dos 4 bits
    mux_8_para_1 MUX_BIT0 (
        .D0(D0[0]), .D1(D1[0]), .D2(D2[0]), .D3(D3[0]),
        .D4(D4[0]), .D5(D5[0]), .D6(D6[0]), .D7(D7[0]),
        .S(S), .Y(Y[0])
    );
    mux_8_para_1 MUX_BIT1 (
        .D0(D0[1]), .D1(D1[1]), .D2(D2[1]), .D3(D3[1]),
        .D4(D4[1]), .D5(D5[1]), .D6(D6[1]), .D7(D7[1]),
        .S(S), .Y(Y[1])
    );
    mux_8_para_1 MUX_BIT2 (
        .D0(D0[2]), .D1(D1[2]), .D2(D2[2]), .D3(D3[2]),
        .D4(D4[2]), .D5(D5[2]), .D6(D6[2]), .D7(D7[2]),
        .S(S), .Y(Y[2])
    );
    mux_8_para_1 MUX_BIT3 (
        .D0(D0[3]), .D1(D1[3]), .D2(D2[3]), .D3(D3[3]),
        .D4(D4[3]), .D5(D5[3]), .D6(D6[3]), .D7(D7[3]),
        .S(S), .Y(Y[3])
    );
	 mux_8_para_1 MUX_BIT4 (
        .D0(D0[4]), .D1(D1[4]), .D2(D2[4]), .D3(D3[4]),
        .D4(D4[4]), .D5(D5[4]), .D6(D6[4]), .D7(D7[4]),
        .S(S), .Y(Y[4])
    );
	 mux_8_para_1 MUX_BIT5 (
        .D0(D0[5]), .D1(D1[5]), .D2(D2[5]), .D3(D3[5]),
        .D4(D4[5]), .D5(D5[5]), .D6(D6[5]), .D7(D7[5]),
        .S(S), .Y(Y[5])
    );
	 mux_8_para_1 MUX_BIT6 (
        .D0(D0[6]), .D1(D1[6]), .D2(D2[6]), .D3(D3[6]),
        .D4(D4[6]), .D5(D5[6]), .D6(D6[6]), .D7(D7[6]),
        .S(S), .Y(Y[6])
    );
	 mux_8_para_1 MUX_BIT7 (
        .D0(D0[7]), .D1(D1[7]), .D2(D2[7]), .D3(D3[7]),
        .D4(D4[7]), .D5(D5[7]), .D6(D6[7]), .D7(D7[7]),
        .S(S), .Y(Y[7])
    );

endmodule