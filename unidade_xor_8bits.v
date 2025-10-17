// Módulo para operação XOR de 8 bits
// Implementação puramente estrutural

module unidade_xor_8bits (
    input  wire [7:0] a,    // Operando A de 8 bits
    input  wire [7:0] b,    // Operando B de 8 bits
    output wire [7:0] s     // Resultado da operação XOR
);

    // Instanciação de portas XOR para cada bit
    xor U_XOR0 (s[0], a[0], b[0]);
    xor U_XOR1 (s[1], a[1], b[1]);
    xor U_XOR2 (s[2], a[2], b[2]);
    xor U_XOR3 (s[3], a[3], b[3]);
    xor U_XOR4 (s[4], a[4], b[4]);
    xor U_XOR5 (s[5], a[5], b[5]);
    xor U_XOR6 (s[6], a[6], b[6]);
    xor U_XOR7 (s[7], a[7], b[7]);

endmodule
