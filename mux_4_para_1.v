// Módulo MUX 4 para 1 de 1 bit
// Implementação puramente estrutural

module mux_4_para_1 (
    input  wire D0, D1, D2, D3,    // Entradas de 1 bit
    input  wire [1:0] S,           // Seletor de 2 bits
    output wire Y                  // Saída de 1 bit
);

    // Fios intermediários
    wire s0_inv, s1_inv;
    wire and0, and1, and2, and3;
    
    // Inversores do seletor
    not U_NOT_S0 (s0_inv, S[0]);
    not U_NOT_S1 (s1_inv, S[1]);
    
    // Lógica de seleção
    // D0 quando S=00
    wire and0_temp1, and0_temp2;
    and U_AND0_1 (and0_temp1, s1_inv, s0_inv);
    and U_AND0_2 (and0, and0_temp1, D0);
    
    // D1 quando S=01
    wire and1_temp1, and1_temp2;
    and U_AND1_1 (and1_temp1, s1_inv, S[0]);
    and U_AND1_2 (and1, and1_temp1, D1);
    
    // D2 quando S=10
    wire and2_temp1, and2_temp2;
    and U_AND2_1 (and2_temp1, S[1], s0_inv);
    and U_AND2_2 (and2, and2_temp1, D2);
    
    // D3 quando S=11
    wire and3_temp1, and3_temp2;
    and U_AND3_1 (and3_temp1, S[1], S[0]);
    and U_AND3_2 (and3, and3_temp1, D3);
    
    // OR final
    wire or_temp1, or_temp2;
    or U_OR1 (or_temp1, and0, and1);
    or U_OR2 (or_temp2, and2, and3);
    or U_OR_FINAL (Y, or_temp1, or_temp2);

endmodule

