// Módulo conversor de Binário de 8 bits para BCD de 3 dígitos (C, D, U)
// Versão final puramente estrutural, atualizada conforme LE_bcd.txt.

module bin_to_bcd_8bit_v2 (
    input  wire [7:0] S,              // Entrada binária de 8 bits
    output wire [3:0] centena_out,    // Saída para o dígito da centena
    output wire [3:0] dezena_out,     // Saída para o dígito da dezena
    output wire [3:0] unidade_out     // Saída para o dígito da unidade
);

    // --- Fios Intermediários e Inversores ---
    wire nS0, nS1, nS2, nS3, nS4, nS5, nS6, nS7;
    wire gnd; // Fio para a constante '0' (terra)

    not U_NOT0 (nS0, S[0]);
    not U_NOT1 (nS1, S[1]);
    not U_NOT2 (nS2, S[2]);
    not U_NOT3 (nS3, S[3]);
    not U_NOT4 (nS4, S[4]);
    not U_NOT5 (nS5, S[5]);
    not U_NOT6 (nS6, S[6]);
    not U_NOT7 (nS7, S[7]);
    
    // Geração estrutural da constante '0' (GND)
    and U_GND (gnd, S[0], nS0);
    
    // =================================================================
    // Lógica para a CENTENA (Baseado em LE_bcd.txt)
    // =================================================================
    
    // --- Lógica para C3 e C2 ---
    // C3 = 0; C2 = 0;
    or U_C3 (centena_out[3], gnd, gnd);
    or U_C2 (centena_out[2], gnd, gnd);

    // --- Lógica para C1 ---
    // C1 = S7 S6 S5 + S7 S6 S4 + S7 S6 S3
    wire C1_term1, C1_term2, C1_term3;
    and C1_AND1 (C1_term1, S[7], S[6], S[5]);
    and C1_AND2 (C1_term2, S[7], S[6], S[4]);
    and C1_AND3 (C1_term3, S[7], S[6], S[3]);
    or  C1_OR   (centena_out[1], C1_term1, C1_term2, C1_term3);

    // --- Lógica para C0 ---
    // C0 = S7 S6' + S7' S6 S5 S4 + S7' S6 S5 S3 + S7 S5' S4' S3' + S7' S6 S5 S2
    wire C0_term1, C0_term2, C0_term3, C0_term4, C0_term5;
    and C0_AND1 (C0_term1, S[7], nS6);
    and C0_AND2 (C0_term2, nS7, S[6], S[5], S[4]);
    and C0_AND3 (C0_term3, nS7, S[6], S[5], S[3]);
    and C0_AND4 (C0_term4, S[7], nS5, nS4, nS3);
    and C0_AND5 (C0_term5, nS7, S[6], S[5], S[2]);
    or  C0_OR   (centena_out[0], C0_term1, C0_term2, C0_term3, C0_term4, C0_term5);

    // =================================================================
    // Lógica para a DEZENA (Baseado em LE_bcd.txt)
    // =================================================================
    
    // --- Lógica para D3 ---
    wire D3_term1, D3_term2, D3_term3, D3_term4, D3_term5;
    and D3_AND1 (D3_term1, nS7, S[6], nS5, S[4]);
    and D3_AND2 (D3_term2, S[7], nS6, S[5], S[4], S[3]);
    and D3_AND3 (D3_term3, S[7], S[6], nS5, nS4, nS3);
    and D3_AND4 (D3_term4, S[7], nS6, S[5], S[4], S[2]);
    and D3_AND5 (D3_term5, nS7, S[6], S[5], nS4, nS3, nS2);
    or  D3_OR   (dezena_out[3], D3_term1, D3_term2, D3_term3, D3_term4, D3_term5);
    
    // --- Lógica para D2 ---
    wire D2_term1, D2_term2, D2_term3, D2_term4, D2_term5, D2_term6, D2_term7, D2_term8;
    and D2_AND1 (D2_term1, S[7], S[6], S[5], S[4]);
    and D2_AND2 (D2_term2, nS7, nS6, S[5], S[4]);
    and D2_AND3 (D2_term3, S[7], nS6, nS5, S[4]);
    and D2_AND4 (D2_term4, S[7], nS6, S[5], nS4);
    and D2_AND5 (D2_term5, nS7, S[6], nS5, nS4);
    and D2_AND6 (D2_term6, nS6, S[5], nS4, S[3]);
    and D2_AND7 (D2_term7, S[7], nS6, nS4, S[3], S[2]);
    and D2_AND8 (D2_term8, nS6, S[5], S[4], nS3, nS2);
    or  D2_OR   (dezena_out[2], D2_term1, D2_term2, D2_term3, D2_term4, D2_term5, D2_term6, D2_term7, D2_term8);
    
    // --- Lógica para D1 ---
    wire D1_term1, D1_term2, D1_term3, D1_term4, D1_term5, D1_term6, D1_term7, D1_term8, D1_term9, D1_term10, D1_term11;
    and D1_AND1  (D1_term1, S[7], S[5], nS4);
    and D1_AND2  (D1_term2, nS7, S[6], nS5, nS4);
    and D1_AND3  (D1_term3, S[7], nS6, nS4, nS3);
    and D1_AND4  (D1_term4, nS6, S[5], nS4, nS3);
    and D1_AND5  (D1_term5, S[7], nS6, nS4, nS2);
    and D1_AND6  (D1_term6, nS7, S[6], S[5], S[4], S[3]);
    and D1_AND7  (D1_term7, nS7, nS6, nS5, S[4], S[3]);
    and D1_AND8  (D1_term8, nS7, nS6, nS5, S[4], S[2]);
    and D1_AND9  (D1_term9, S[7], nS6, S[5], nS3, nS2);
    and D1_AND10 (D1_term10, S[7], S[6], nS5, S[4], S[3], S[2]);
    and D1_AND11 (D1_term11, nS7, S[5], S[4], S[3], S[2]);
    or  D1_OR    (dezena_out[1], D1_term1, D1_term2, D1_term3, D1_term4, D1_term5, D1_term6, D1_term7, D1_term8, D1_term9, D1_term10, D1_term11);
    
    // --- Lógica para D0 ---
    wire D0_term1, D0_term2, D0_term3, D0_term4, D0_term5, D0_term6, D0_term7, D0_term8, D0_term9, D0_term10, D0_term11, D0_term12, D0_term13, D0_term14, D0_term15, D0_term16, D0_term17, D0_term18, D0_term19, D0_term20, D0_term21, D0_term22, D0_term23, D0_term24, D0_term25, D0_term26, D0_term27, D0_term28, D0_term29, D0_term30, D0_term31;
    and D0_AND1  (D0_term1, S[7],nS6,nS5,S[4],S[3]);
    and D0_AND2  (D0_term2, S[7],S[6],S[5],nS4,S[3]);
    and D0_AND3  (D0_term3, nS7,S[6],nS5,nS4,S[3]);
    and D0_AND4  (D0_term4, S[7],S[6],nS5,nS4,nS3);
    and D0_AND5  (D0_term5, S[7],S[6],S[5],S[3],S[2]);
    and D0_AND6  (D0_term6, nS7,S[6],nS5,S[3],S[2]);
    and D0_AND7  (D0_term7, S[7],S[5],nS4,S[3],S[2]);
    and D0_AND8  (D0_term8, nS7,nS5,nS4,S[3],S[2]);
    and D0_AND9  (D0_term9, S[7],S[6],nS5,nS3,S[2]);
    and D0_AND10 (D0_term10, S[7],nS5,nS4,nS3,S[2]);
    and D0_AND11 (D0_term11, S[7],nS6,nS5,S[3],nS2);
    and D0_AND12 (D0_term12, S[7],nS5,S[4],S[3],nS2);
    and D0_AND13 (D0_term13, nS7,nS6,S[5],S[4],S[3],nS2);
    and D0_AND14 (D0_term14, S[7],nS6,S[5],S[4],nS3,nS2);
    and D0_AND15 (D0_term15, nS7,nS6,nS5,S[4],nS3,nS2);
    and D0_AND16 (D0_term16, nS7,nS6,S[5],nS4,nS3);
    and D0_AND17 (D0_term17, nS7,S[5],S[4],nS3,S[2]);
    and D0_AND18 (D0_term18, nS7,S[6],S[5],nS3,nS2);
    and D0_AND19 (D0_term19, S[7],nS6,nS5,S[4],S[2],S[1]);
    and D0_AND20 (D0_term20, S[7],nS6,S[4],S[3],S[2],S[1]);
    and D0_AND21 (D0_term21, nS6,nS5,S[4],S[3],S[2],S[1]);
    and D0_AND22 (D0_term22, S[6],S[5],nS4,S[3],S[2],S[1]);
    and D0_AND23 (D0_term23, S[7],S[6],nS4,nS3,S[2],S[1]);
    and D0_AND24 (D0_term24, S[6],nS5,nS4,nS3,S[2],S[1]);
    and D0_AND25 (D0_term25, S[7],S[6],nS5,S[4],nS2,S[1]);
    and D0_AND26 (D0_term26, S[7],nS6,nS5,nS4,nS2,S[1]);
    and D0_AND27 (D0_term27, S[7],S[6],S[4],S[3],nS2,S[1]);
    and D0_AND28 (D0_term28, S[6],nS5,S[4],S[3],nS2,S[1]);
    and D0_AND29 (D0_term29, S[7],nS6,nS4,S[3],nS2,S[1]);
    and D0_AND30 (D0_term30, nS6,nS5,nS4,S[3],nS2,S[1]);
    and D0_AND31 (D0_term31, nS6,S[5],S[4],nS3,nS2,S[1]);
    or D0_OR (dezena_out[0], D0_term1, D0_term2, D0_term3, D0_term4, D0_term5, D0_term6, D0_term7, D0_term8, D0_term9, D0_term10, D0_term11, D0_term12, D0_term13, D0_term14, D0_term15, D0_term16, D0_term17, D0_term18, D0_term19, D0_term20, D0_term21, D0_term22, D0_term23, D0_term24, D0_term25, D0_term26, D0_term27, D0_term28, D0_term29, D0_term30, D0_term31);
        
    // =================================================================
    // Lógica para a UNIDADE (Baseado em LE_bcd.txt)
    // =================================================================
    
    // --- Lógica para U3 ---
    wire U3_term1, U3_term2, U3_term3, U3_term4, U3_term5, U3_term6, U3_term7, U3_term8, U3_term9, U3_term10, U3_term11, U3_term12, U3_term13, U3_term14, U3_term15, U3_term16, U3_term17, U3_term18, U3_term19, U3_term20, U3_term21, U3_term22, U3_term23, U3_term24;
    and U3_AND1 (U3_term1, S[7], nS6, nS5, S[4], S[3], S[2], S[1]);
    and U3_AND2 (U3_term2, S[7], S[6], S[5], nS4, S[3], S[2], S[1]);
    and U3_AND3 (U3_term3, nS7, S[6], nS5, nS4, S[3], S[2], S[1]);
    and U3_AND4 (U3_term4, nS7, S[6], S[5], S[4], nS3, S[2], S[1]);
    and U3_AND5 (U3_term5, nS7, nS6, S[5], nS4, nS3, S[2], S[1]);
    and U3_AND6 (U3_term6, S[7], S[6], nS5, nS4, nS3, S[2], S[1]);
    and U3_AND7 (U3_term7, nS7, nS6, S[5], S[4], S[3], nS2, S[1]);
    and U3_AND8 (U3_term8, S[7], S[6], nS5, S[4], S[3], nS2, S[1]);
    and U3_AND9 (U3_term9, S[7], nS6, nS5, nS4, S[3], nS2, S[1]);
    and U3_AND10(U3_term10, S[7], nS6, S[5], S[4], nS3, nS2, S[1]);
    and U3_AND11(U3_term11, nS7, nS6, nS5, S[4], nS3, nS2, S[1]);
    and U3_AND12(U3_term12, nS7, S[6], S[5], nS4, nS3, nS2, S[1]);
    and U3_AND13(U3_term13, S[7], nS6, S[5], S[4], S[3], S[2], nS1);
    and U3_AND14(U3_term14, nS7, nS6, nS5, S[4], S[3], S[2], nS1);
    and U3_AND15(U3_term15, nS7, S[6], S[5], nS4, S[3], S[2], nS1);
    and U3_AND16(U3_term16, S[7], nS6, nS5, S[4], nS3, S[2], nS1);
    and U3_AND17(U3_term17, S[7], S[6], S[5], nS4, nS3, S[2], nS1);
    and U3_AND18(U3_term18, nS7, S[6], nS5, nS4, nS3, S[2], nS1);
    and U3_AND19(U3_term19, S[7], S[6], S[5], S[4], S[3], nS2, nS1);
    and U3_AND20(U3_term20, nS7, S[6], nS5, S[4], S[3], nS2, nS1);
    and U3_AND21(U3_term21, S[7], nS6, S[5], nS4, S[3], nS2, nS1);
    and U3_AND22(U3_term22, nS7, nS6, nS5, nS4, S[3], nS2, nS1);
    and U3_AND23(U3_term23, nS7, nS6, S[5], S[4], nS3, nS2, nS1);
    and U3_AND24(U3_term24, S[7], S[6], nS5, S[4], nS3, nS2, nS1);
    or  U3_OR (unidade_out[3], U3_term1, U3_term2, U3_term3, U3_term4, U3_term5, U3_term6, U3_term7, U3_term8, U3_term9, U3_term10, U3_term11, U3_term12, U3_term13, U3_term14, U3_term15, U3_term16, U3_term17, U3_term18, U3_term19, U3_term20, U3_term21, U3_term22, U3_term23, U3_term24);

    // --- Lógica para U2 ---
    wire U2_term1, U2_term2, U2_term3, U2_term4, U2_term5, U2_term6, U2_term7, U2_term8, U2_term9, U2_term10, U2_term11, U2_term12, U2_term13, U2_term14, U2_term15, U2_term16, U2_term17, U2_term18, U2_term19, U2_term20, U2_term21, U2_term22, U2_term23, U2_term24, U2_term25, U2_term26, U2_term27, U2_term28, U2_term29, U2_term30, U2_term31, U2_term32, U2_term33, U2_term34;
    and U2_AND1 (U2_term1, S[7],S[6],nS5,nS4,S[3],S[2]);
    and U2_AND2 (U2_term2, S[7],S[6],nS5,nS4,S[2],nS1);
    and U2_AND3 (U2_term3, S[7],S[6],nS4,S[3],S[2],nS1);
    and U2_AND4 (U2_term4, S[6],nS5,nS4,S[3],S[2],nS1);
    and U2_AND5 (U2_term5, nS7,nS6,S[5],S[4],nS3,S[2],S[1]);
    and U2_AND6 (U2_term6, nS7,S[6],S[5],S[4],nS3,nS2,S[1]);
    and U2_AND7 (U2_term7, nS7,nS6,S[5],nS4,nS3,nS2,S[1]);
    and U2_AND8 (U2_term8, S[7],nS6,nS5,S[4],S[3],S[2],nS1);
    and U2_AND9 (U2_term9, S[7],S[6],nS5,S[4],S[3],nS2,nS1);
    and U2_AND10(U2_term10, S[7],nS6,nS5,nS4,S[3],nS2,nS1);
    and U2_AND11(U2_term11, S[7],S[6],S[5],S[4],nS3,S[2]);
    and U2_AND12(U2_term12, nS7,S[6],nS5,S[4],nS3,S[2]);
    and U2_AND13(U2_term13, S[7],nS6,S[5],nS4,nS3,S[2]);
    and U2_AND14(U2_term14, nS7,nS6,nS5,nS4,nS3,S[2]);
    and U2_AND15(U2_term15, nS7,nS6,nS5,S[4],S[3],nS2);
    and U2_AND16(U2_term16, S[7],nS6,nS5,S[4],nS3,nS2);
    and U2_AND17(U2_term17, S[7],S[6],S[5],nS4,nS3,nS2);
    and U2_AND18(U2_term18, nS7,S[6],nS5,nS4,nS3,nS2);
    and U2_AND19(U2_term19, nS7,S[6],nS5,S[4],S[2],S[1]);
    and U2_AND20(U2_term20, nS7,nS6,nS5,nS4,S[2],S[1]);
    and U2_AND21(U2_term21, S[6],S[5],S[4],S[3],S[2],S[1]);
    and U2_AND22(U2_term22, nS6,S[5],nS4,S[3],S[2],S[1]);
    and U2_AND23(U2_term23, S[6],nS5,S[4],nS3,S[2],S[1]);
    and U2_AND24(U2_term24, nS6,nS5,nS4,nS3,S[2],S[1]);
    and U2_AND25(U2_term25, nS7,S[6],nS5,nS4,nS2,S[1]);
    and U2_AND26(U2_term26, S[7],nS6,S[4],S[3],nS2,S[1]);
    and U2_AND27(U2_term27, S[6],S[5],nS4,S[3],nS2,S[1]);
    and U2_AND28(U2_term28, S[6],nS5,nS4,nS3,nS2,S[1]);
    and U2_AND29(U2_term29, nS7,S[6],S[5],S[4],nS2,nS1);
    and U2_AND30(U2_term30, nS7,nS6,S[5],nS4,nS2,nS1);
    // Termos adicionados para U2
    and U2_AND31(U2_term31, nS7, S[6], S[5], nS4, nS2, nS1);
    and U2_AND32(U2_term32, nS6, S[5], S[4], S[3], nS2, nS1);
    and U2_AND33(U2_term33, S[7], nS6, S[4], nS3, nS2, nS1);
    and U2_AND34(U2_term34, nS6, nS5, S[4], nS3, nS2, nS1);
    or U2_OR(unidade_out[2], U2_term1, U2_term2, U2_term3, U2_term4, U2_term5, U2_term6, U2_term7, U2_term8, U2_term9, U2_term10, U2_term11, U2_term12, U2_term13, U2_term14, U2_term15, U2_term16, U2_term17, U2_term18, U2_term19, U2_term20, U2_term21, U2_term22, U2_term23, U2_term24, U2_term25, U2_term26, U2_term27, U2_term28, U2_term29, U2_term30, U2_term31, U2_term32, U2_term33, U2_term34);

    // --- Lógica para U1 ---
    wire U1_term1, U1_term2, U1_term3, U1_term4, U1_term5, U1_term6, U1_term7, U1_term8, U1_term9, U1_term10, U1_term11, U1_term12, U1_term13, U1_term14, U1_term15, U1_term16, U1_term17, U1_term18, U1_term19, U1_term20, U1_term21, U1_term22, U1_term23, U1_term24, U1_term25, U1_term26, U1_term27, U1_term28, U1_term29, U1_term30, U1_term31, U1_term32, U1_term33, U1_term34;
    and U1_AND1 (U1_term1, S[7],S[6],nS5,nS4,S[3],S[1]);
    and U1_AND2 (U1_term2, S[7],S[6],nS5,S[3],S[2],S[1]);
    and U1_AND3 (U1_term3, S[7],nS5,nS4,S[3],S[2],S[1]);
    and U1_AND4 (U1_term4, S[7],nS6,nS5,S[4],S[3],nS1);
    and U1_AND5 (U1_term5, S[7],S[6],S[5],nS4,S[3],nS1);
    and U1_AND6 (U1_term6, nS7,S[6],nS5,nS4,S[3],nS1);
    and U1_AND7 (U1_term7, S[7],S[6],nS5,nS4,nS3,nS1);
    and U1_AND8 (U1_term8, S[7],S[6],S[5],S[3],S[2],nS1);
    and U1_AND9 (U1_term9, nS7,S[6],nS5,S[3],S[2],nS1);
    and U1_AND10(U1_term10, S[7],S[5],nS4,S[3],S[2],nS1);
    and U1_AND11(U1_term11, nS7,nS5,nS4,S[3],S[2],nS1);
    and U1_AND12(U1_term12, S[7],S[6],nS5,nS3,S[2],nS1);
    and U1_AND13(U1_term13, S[7],nS5,nS4,nS3,S[2],nS1);
    and U1_AND14(U1_term14, S[7],nS6,nS5,S[3],nS2,nS1);
    and U1_AND15(U1_term15, S[7],nS5,S[4],S[3],nS2,nS1);
    and U1_AND16(U1_term16, nS7,S[6],S[5],nS4,nS3,S[2],S[1]);
    and U1_AND17(U1_term17, S[7],nS6,S[5],S[4],S[3],nS2,S[1]);
    and U1_AND18(U1_term18, nS7,nS6,nS5,S[4],S[3],nS2,S[1]);
    and U1_AND19(U1_term19, S[7],nS6,nS5,S[4],nS3,nS2,S[1]);
    and U1_AND20(U1_term20, nS7,nS6,S[5],S[4],S[3],nS2,nS1);
    and U1_AND21(U1_term21, S[7],nS6,S[5],S[4],nS3,nS2,nS1);
    and U1_AND22(U1_term22, nS7,nS6,nS5,S[4],nS3,nS2,nS1);
    and U1_AND23(U1_term23, nS7,nS6,S[5],nS4,S[3],S[1]);
    and U1_AND24(U1_term24, S[7],nS6,S[5],nS4,nS3,S[1]);
    and U1_AND25(U1_term25, nS7,nS6,nS5,nS4,nS3,S[1]);
    and U1_AND26(U1_term26, nS7,S[5],S[4],S[3],S[2],S[1]);
    and U1_AND27(U1_term27, S[7],S[5],S[4],nS3,S[2],S[1]);
    and U1_AND28(U1_term28, nS7,nS5,S[4],nS3,S[2],S[1]);
    and U1_AND29(U1_term29, nS7,S[6],S[5],S[3],nS2,S[1]);
    and U1_AND30(U1_term30, S[7],S[6],S[5],nS3,nS2,S[1]);
    and U1_AND31(U1_term31, nS7,S[6],nS5,nS3,nS2,S[1]);
    // Termos adicionados para U1
    and U1_AND32(U1_term32, nS7, nS6, S[5], nS4, nS3, nS1);
    and U1_AND33(U1_term33, nS7, S[5], S[4], nS3, S[2], nS1);
    and U1_AND34(U1_term34, nS7, S[6], S[5], nS3, nS2, nS1);
    or U1_OR(unidade_out[1], U1_term1, U1_term2, U1_term3, U1_term4, U1_term5, U1_term6, U1_term7, U1_term8, U1_term9, U1_term10, U1_term11, U1_term12, U1_term13, U1_term14, U1_term15, U1_term16, U1_term17, U1_term18, U1_term19, U1_term20, U1_term21, U1_term22, U1_term23, U1_term24, U1_term25, U1_term26, U1_term27, U1_term28, U1_term29, U1_term30, U1_term31, U1_term32, U1_term33, U1_term34);
    
    // --- Lógica para U0 ---
    // U0 = S[0]
    or U_U0 (unidade_out[0], S[0], gnd);

endmodule
