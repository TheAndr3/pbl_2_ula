// Arquivo: mux_8_para_1.v
module mux_8_para_1 (
    input  wire D0, D1, D2, D3, D4, D5, D6, D7,
    input  wire [2:0] S,
    output wire Y
);

    wire not_S0, not_S1, not_S2;
    wire term0, term1, term2, term3, term4, term5, term6, term7;

    // Inversores para os sinais de seleção
    not U_NOT_S0 (not_S0, S[0]);
    not U_NOT_S1 (not_S1, S[1]);
    not U_NOT_S2 (not_S2, S[2]);

    // Lógica AND para cada termo de entrada (mintermos)
    and U_AND0 (term0, D0, not_S2, not_S1, not_S0); // Seletor 000
    and U_AND1 (term1, D1, not_S2, not_S1, S[0]);   // Seletor 001
    and U_AND2 (term2, D2, not_S2, S[1],   not_S0); // Seletor 010
    and U_AND3 (term3, D3, not_S2, S[1],   S[0]);   // Seletor 011
    and U_AND4 (term4, D4, S[2],   not_S1, not_S0); // Seletor 100
    and U_AND5 (term5, D5, S[2],   not_S1, S[0]);   // Seletor 101
    and U_AND6 (term6, D6, S[2],   S[1],   not_S0); // Seletor 110
    and U_AND7 (term7, D7, S[2],   S[1],   S[0]);   // Seletor 111

    // Porta OR final para combinar os termos
    or U_OR_Y (Y, term0, term1, term2, term3, term4, term5, term6, term7);

endmodule
