// Módulo MUX 2 para 1 de 1 bit
// Implementação puramente estrutural

module mux_2_para_1 (
    input  wire D0, D1,    // Entradas de 1 bit
    input  wire S,         // Seletor
    output wire Y          // Saída de 1 bit
);

    // Fios intermediários
    wire s_inv;
    wire and0, and1;
    
    // Inversor do seletor
    not U_NOT_S (s_inv, S);
    
    // Lógica de seleção
    // D0 quando S=0
    and U_AND0 (and0, D0, s_inv);
    
    // D1 quando S=1
    and U_AND1 (and1, D1, S);
    
    // OR final
    or U_OR (Y, and0, and1);

endmodule

