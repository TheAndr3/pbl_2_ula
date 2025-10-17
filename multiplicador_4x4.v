// Módulo multiplicador estrutural de 4x4 bits.
// Versão CORRIGIDA - 100% estrutural, sem drivers múltiplos.

module multiplicador_4x4 (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [7:0] p
);
    // Fios para os 16 produtos parciais (a[i] * b[j])
    wire pp00, pp01, pp02, pp03;
    wire pp10, pp11, pp12, pp13;
    wire pp20, pp21, pp22, pp23;
    wire pp30, pp31, pp32, pp33;

    // Fios para as somas e carrys intermediários da matriz de somadores
    wire s01, c01, s02, c02, s03, c03;
    wire s11, c11, s12, c12, s13, c13;
    wire s21, c21, s22, c22, s23, c23;
    wire s31, c31, s32, c32, s33, c33;
    wire [3:0] c_final;

    // 1. Gerar todos os produtos parciais com portas AND
    and(pp00, a[0], b[0]); and(pp01, a[1], b[0]); and(pp02, a[2], b[0]); and(pp03, a[3], b[0]);
    and(pp10, a[0], b[1]); and(pp11, a[1], b[1]); and(pp12, a[2], b[1]); and(pp13, a[3], b[1]);
    and(pp20, a[0], b[2]); and(pp21, a[1], b[2]); and(pp22, a[2], b[2]); and(pp23, a[3], b[2]);
    and(pp30, a[0], b[3]); and(pp31, a[1], b[3]); and(pp32, a[2], b[3]); and(pp33, a[3], b[3]);

    // 2. Construir a matriz de somadores para somar os produtos parciais

    // O bit 0 do produto é simplesmente o primeiro produto parcial
    assign p[0] = pp00;

    // Linha 0 da matriz de somadores
    half_adder HA0_1 (.a(pp01), .b(pp10), .s(p[1]),  .cout(c01));
    full_adder FA0_2 (.a(pp02), .b(pp11), .cin(c01), .s(s01),   .cout(c02));
    full_adder FA0_3 (.a(pp03), .b(pp12), .cin(c02), .s(s02),   .cout(c03));
    half_adder HA0_4 (.a(c03),  .b(pp13), .s(s03),   .cout(c_final[0]));

    // Linha 1 da matriz
    full_adder FA1_1 (.a(s01), .b(pp20), .cin(1'b0), .s(p[2]),  .cout(c11));
    full_adder FA1_2 (.a(s02), .b(pp21), .cin(c11),  .s(s11),   .cout(c12));
    full_adder FA1_3 (.a(s03), .b(pp22), .cin(c12),  .s(s12),   .cout(c13));
    full_adder FA1_4 (.a(c_final[0]), .b(pp23), .cin(c13), .s(s13), .cout(c_final[1]));

    // Linha 2 da matriz
    full_adder FA2_1 (.a(s11), .b(pp30), .cin(1'b0), .s(p[3]),  .cout(c21));
    full_adder FA2_2 (.a(s12), .b(pp31), .cin(c21),  .s(s21),   .cout(c22));
    full_adder FA2_3 (.a(s13), .b(pp32), .cin(c22),  .s(s22),   .cout(c23));
    full_adder FA2_4 (.a(c_final[1]), .b(pp33), .cin(c23), .s(s23), .cout(c_final[2]));

    // Linha final (últimos bits do produto)
    half_adder HA3_1 (.a(s21), .b(c_final[2]), .s(p[4]), .cout(c31));
    full_adder FA3_2 (.a(s22), .b(c31), .cin(1'b0), .s(p[5]), .cout(c32));
    full_adder FA3_3 (.a(s23), .b(c32), .cin(1'b0), .s(p[6]), .cout(c33));
    assign p[7] = c33;

endmodule