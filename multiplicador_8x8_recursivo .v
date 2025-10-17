module multiplicador_8x8_recursivo (
    input  wire [7:0] a,
    input  wire [7:0] b,
    output wire [15:0] p
);

    // Divisão das entradas de 8 bits em partes de 4 bits (High e Low)
    wire [3:0] a1 = a[7:4];
    wire [3:0] a0 = a[3:0];
    wire [3:0] b1 = b[7:4];
    wire [3:0] b0 = b[3:0];

    // Fios para os resultados das 4 multiplicações de 4x4
    wire [7:0] p_a1b1, p_a1b0, p_a0b1, p_a0b0;

    // 1. Instanciar 4 multiplicadores 4x4
    multiplicador_4x4 U_MULT_A1B1 (.a(a1), .b(b1), .p(p_a1b1));
    multiplicador_4x4 U_MULT_A1B0 (.a(a1), .b(b0), .p(p_a1b0));
    multiplicador_4x4 U_MULT_A0B1 (.a(a0), .b(b1), .p(p_a0b1));
    multiplicador_4x4 U_MULT_A0B0 (.a(a0), .b(b0), .p(p_a0b0));

    // Fios para os termos intermediários e somas
    wire [8:0] sum_mid;
    wire [15:0] term0, term1, term2;
    wire [15:0] sum1;
    wire cout1, cout2; // Carrys não utilizados, mas disponíveis

    // 2. Somar os termos do meio (p_a1b0 + p_a0b1)
    somador_8bits ADD_MID (
        .a(p_a1b0), 
        .b(p_a0b1), 
        .cin(1'b0), 
        .s(sum_mid[7:0]), 
        .cout(sum_mid[8])
    );
    
    // 3. Montar os termos com os deslocamentos (shifts) corretos para a soma final
    // termo0 = p_a0b0
    // termo1 = (p_a1b0 + p_a0b1) << 4
    // termo2 = p_a1b1 << 8
    assign term0 = {8'b0, p_a0b0};
    assign term1 = {sum_mid[8], sum_mid[7:0], 4'b0};
    assign term2 = {p_a1b1, 8'b0};

    // 4. Somar os termos para obter o resultado final usando somadores de 16 bits
    somador_16bits ADD_FINAL1 (
        .a(term0), 
        .b(term1), 
        .cin(1'b0), 
        .s(sum1), 
        .cout(cout1)
    );
    
    somador_16bits ADD_FINAL2 (
        .a(sum1), 
        .b(term2), 
        .cin(1'b0), 
        .s(p), 
        .cout(cout2)
    );

endmodule