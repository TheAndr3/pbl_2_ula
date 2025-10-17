// Módulo MUX 4 para 1 de 4 bits
// Implementação puramente estrutural

module mux_4_para_1_4bits (
    input  wire [3:0] D0, D1, D2, D3,  // Entradas de 4 bits
    input  wire [1:0] S,               // Seletor de 2 bits
    output wire [3:0] Y                // Saída de 4 bits
);

    // Instancia um MUX 4 para 1 para cada bit
    mux_4_para_1 MUX_BIT0 (
        .D0(D0[0]), .D1(D1[0]), .D2(D2[0]), .D3(D3[0]),
        .S(S), .Y(Y[0])
    );
    
    mux_4_para_1 MUX_BIT1 (
        .D0(D0[1]), .D1(D1[1]), .D2(D2[1]), .D3(D3[1]),
        .S(S), .Y(Y[1])
    );
    
    mux_4_para_1 MUX_BIT2 (
        .D0(D0[2]), .D1(D1[2]), .D2(D2[2]), .D3(D3[2]),
        .S(S), .Y(Y[2])
    );
    
    mux_4_para_1 MUX_BIT3 (
        .D0(D0[3]), .D1(D1[3]), .D2(D2[3]), .D3(D3[3]),
        .S(S), .Y(Y[3])
    );

endmodule
