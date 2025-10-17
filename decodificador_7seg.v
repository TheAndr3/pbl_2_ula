module decodificador_7seg (
    input wire[3:0] D,
    output wire[6:0] SEG
);

    // Fios para as entradas negadas
    wire nD0, nD1, nD2, nD3;
    not(nD0, D[0]);
    not(nD1, D[1]);
    not(nD2, D[2]);
    not(nD3, D[3]);

    // Fios para identificar cada um dos 16 valores de entrada (de 0 a F)
    wire is_0, is_1, is_2, is_3, is_4, is_5, is_6, is_7;
    wire is_8, is_9, is_A, is_b, is_C, is_d, is_E, is_F;

    // Decodificador 4-para-16: cada fio será '1' para seu respectivo valor
    and(is_0, nD3, nD2, nD1, nD0); // 0000
    and(is_1, nD3, nD2, nD1, D[0]);  // 0001
    and(is_2, nD3, nD2, D[1], nD0);  // 0010
    and(is_3, nD3, nD2, D[1], D[0]);  // 0011
    and(is_4, nD3, D[2], nD1, nD0);  // 0100
    and(is_5, nD3, D[2], nD1, D[0]);  // 0101
    and(is_6, nD3, D[2], D[1], nD0);  // 0110
    and(is_7, nD3, D[2], D[1], D[0]);  // 0111
    and(is_8, D[3], nD2, nD1, nD0);  // 1000
    and(is_9, D[3], nD2, nD1, D[0]);  // 1001
    and(is_A, D[3], nD2, D[1], nD0);  // 1010 -> A
    and(is_b, D[3], nD2, D[1], D[0]);  // 1011 -> b
    and(is_C, D[3], D[2], nD1, nD0);  // 1100 -> C
    and(is_d, D[3], D[2], nD1, D[0]);  // 1101 -> d
    and(is_E, D[3], D[2], D[1], nD0);  // 1110 -> E
    and(is_F, D[3], D[2], D[1], D[0]);  // 1111 -> F

    // Lógica ATIVO BAIXO: A saída é '1' (desligado) para os casos listados
    // A saída será '0' (ligado) para todos os outros casos.
    // SEG[0] = a, SEG[1] = b, ... , SEG[6] = g

    // Segmento 'a' (SEG[0]) desliga para 1, 4, b(11), d(13)
    or(SEG[0], is_1, is_4, is_b, is_d);

    // Segmento 'b' (SEG[1]) desliga para 5, 6
    or(SEG[1], is_5, is_6);
    
    // Segmento 'c' (SEG[2]) desliga para 2
    or(SEG[2], is_2);

    // Segmento 'd' (SEG[3]) desliga para 1, 4, 7, A(10)
    or(SEG[3], is_1, is_4, is_7, is_A);
    
    // Segmento 'e' (SEG[4]) desliga para 1, 3, 4, 5, 7, 9
    or(SEG[4], is_1, is_3, is_4, is_5, is_7, is_9);

    // Segmento 'f' (SEG[5]) desliga para 1, 2, 3, 7, d(13)
    or(SEG[5], is_1, is_2, is_3, is_7, is_d);

    // Segmento 'g' (SEG[6]) desliga para 0, 1, 7, C(12)
    or(SEG[6], is_0, is_1, is_7, is_C);

endmodule