// Módulo para operação OR de 8 bits
// Implementação puramente estrutural

module unidade_or_8bits (
    input  wire [7:0] a,    // Operando A de 8 bits
    input  wire [7:0] b,    // Operando B de 8 bits
    output wire [7:0] s     // Resultado da operação OR
);

    // Instanciação de portas OR para cada bit
    or U_OR0 (s[0], a[0], b[0]);
    or U_OR1 (s[1], a[1], b[1]);
    or U_OR2 (s[2], a[2], b[2]);
    or U_OR3 (s[3], a[3], b[3]);
    or U_OR4 (s[4], a[4], b[4]);
    or U_OR5 (s[5], a[5], b[5]);
    or U_OR6 (s[6], a[6], b[6]);
    or U_OR7 (s[7], a[7], b[7]);

endmodule
