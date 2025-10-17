// Módulo para operação AND de 8 bits
// Implementação puramente estrutural

module unidade_and_8bits (
    input  wire [7:0] a,    // Operando A de 8 bits
    input  wire [7:0] b,    // Operando B de 8 bits
    output wire [7:0] s     // Resultado da operação AND
);

    // Instanciação de portas AND para cada bit
    and U_AND0 (s[0], a[0], b[0]);
    and U_AND1 (s[1], a[1], b[1]);
    and U_AND2 (s[2], a[2], b[2]);
    and U_AND3 (s[3], a[3], b[3]);
    and U_AND4 (s[4], a[4], b[4]);
    and U_AND5 (s[5], a[5], b[5]);
    and U_AND6 (s[6], a[6], b[6]);
    and U_AND7 (s[7], a[7], b[7]);

endmodule
