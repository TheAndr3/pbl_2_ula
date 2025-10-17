// Módulo MUX 4 para 1 de 8 bits
// Implementação puramente estrutural

module mux_4_para_1_8bits (
    input  wire [7:0] D0, D1, D2, D3,  // Entradas de 8 bits
    input  wire [1:0] S,               // Seletor de 2 bits
    output wire [7:0] Y                // Saída de 8 bits
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
    
    mux_4_para_1 MUX_BIT4 (
        .D0(D0[4]), .D1(D1[4]), .D2(D2[4]), .D3(D3[4]),
        .S(S), .Y(Y[4])
    );
    
    mux_4_para_1 MUX_BIT5 (
        .D0(D0[5]), .D1(D1[5]), .D2(D2[5]), .D3(D3[5]),
        .S(S), .Y(Y[5])
    );
    
    mux_4_para_1 MUX_BIT6 (
        .D0(D0[6]), .D1(D1[6]), .D2(D2[6]), .D3(D3[6]),
        .S(S), .Y(Y[6])
    );
    
    mux_4_para_1 MUX_BIT7 (
        .D0(D0[7]), .D1(D1[7]), .D2(D2[7]), .D3(D3[7]),
        .S(S), .Y(Y[7])
    );

endmodule

