// Módulo para operação NOT de 8 bits
// Implementação puramente estrutural usando portas NOT

module unidade_not_8bits (
    input  wire [7:0] a,    // Operando de entrada de 8 bits
    output wire [7:0] s     // Resultado da operação NOT
);

    // Instanciação de portas NOT para cada bit
    not U_NOT0 (s[0], a[0]);
    not U_NOT1 (s[1], a[1]);
    not U_NOT2 (s[2], a[2]);
    not U_NOT3 (s[3], a[3]);
    not U_NOT4 (s[4], a[4]);
    not U_NOT5 (s[5], a[5]);
    not U_NOT6 (s[6], a[6]);
    not U_NOT7 (s[7], a[7]);

endmodule
