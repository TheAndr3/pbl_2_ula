// Módulo ULA de 8 bits
// Implementação puramente estrutural

module ula_8bits (
    input  wire [7:0] a,           // Operando A de 8 bits
    input  wire [7:0] b,           // Operando B de 8 bits
    input  wire [2:0] operacao,    // Código da operação
    input  wire clk,               // Clock
    input  wire rst,               // Reset
    output wire [7:0] resultado,   // Resultado da operação
    output wire overflow,          // Flag de overflow
    output wire zero,              // Flag de zero
    output wire carry_out,         // Flag de carry out
    output wire erro              // Flag de erro
);

    // Fios intermediários para operações
    wire [7:0] resultado_soma, resultado_sub, resultado_div;
    wire [7:0] resultado_and, resultado_or, resultado_xor, resultado_not;
	 wire [15:0] resultado_mult_16bits; // Fio agora com 16 bits para o produto
    wire [7:0] resultado_final;
    
    // Flags intermediárias
    wire ov_soma, ov_sub, ov_mult, ov_div;
    wire cout_soma, cout_sub, cout_mult, cout_div;
    wire err_div, err_sub;
    wire start_div;
    
    // Constantes
    wire gnd, vcc;
    wire [7:0] gnd_bus;
    
    // Gerar constantes
	 wire n_a;
	 not na00 (n_a, a[0]);
    and U_GND (gnd, n_a, a[0]);
    not U_VCC_NOT (vcc, gnd);
    
    // Atribuir GND ao barramento
    buf U_GND_BUF0 (gnd_bus[0], gnd);
    buf U_GND_BUF1 (gnd_bus[1], gnd);
    buf U_GND_BUF2 (gnd_bus[2], gnd);
    buf U_GND_BUF3 (gnd_bus[3], gnd);
    buf U_GND_BUF4 (gnd_bus[4], gnd);
    buf U_GND_BUF5 (gnd_bus[5], gnd);
    buf U_GND_BUF6 (gnd_bus[6], gnd);
    buf U_GND_BUF7 (gnd_bus[7], gnd);

    // Sinal de start para multiplicação (quando operação = 010)
    wire [2:0] operacao_inv;
    not U_NOT_OP0 (operacao_inv[0], operacao[0]);
    not U_NOT_OP1 (operacao_inv[1], operacao[1]);
    not U_NOT_OP2 (operacao_inv[2], operacao[2]);
    
    //and U_START_MULT (start_mult, operacao[2], operacao_inv[1], operacao[0]);
    
    // Sinal de start para divisão (quando operação = 011)
    and U_START_DIV (start_div, operacao[2], operacao[1], operacao[0]);

    // Instanciação das operações
    
    // Soma (000)
    somador_8bits U_SOMA (
        .a(a), .b(b), .cin(gnd),
        .s(resultado_soma), .cout(cout_soma), .ov(ov_soma)
    );
    
    // Subtração (001)
    subtrator_8bits U_SUB (
        .a(a), .b(b),
        .s(resultado_sub), .cout(cout_sub), .ov(ov_sub), .neg(err_sub)
    );
    
    // Multiplicação (010) - usando multiplicador recursivo
    //multiplicador_recursivo U_MULT (
    //    .multiplicando(a), .multiplicador(b),
    //    .clk(clk), .rst(rst), .start(gnd),
    //    .produto(resultado_mult), .done(), .overflow(ov_mult)
    //);
	 
//	 mutiplicacao_5x4 (
	//	.a(a[4:0]),
	//	.b(b[3:0]),
	//	.s(resultado_mult)
//);

multiplicador_8x8_recursivo U_MULT (
        .a(a), 
        .b(b),
        .p(resultado_mult_16bits)
    );
    
    // Divisão (011) - usando divisor real
    //divisor_real U_DIV (
    //    .dividendo(a), .divisor(b),
    //    .clk(clk), .rst(rst), .start(gnd),
    //    .quociente(resultado_div), .resto(), .done(), .div_zero(err_div), .overflow(ov_div)
    //);

	 divisao_5por4 (
		.a(a[4:0]),
		.b(b[3:0]),
		.s(resultado_div)
);

	//Flag erro para div por 0
	wire nb3, nb2, nb1, nb0, b0;
	not n0not0 (nb3, b[3]);
	not n0not1 (nb2, b[2]);
	not n0not2 (nb1, b[1]);
	not n0not3 (nb0, b[0]);
	and b_zero (err_div, nb3, nb2, nb1, nb0);
	
	
    
    // AND (100)
    unidade_and_8bits U_AND (
        .a(a), .b(b), .s(resultado_and)
    );
    
    // OR (101)
    unidade_or_8bits U_OR (
        .a(a), .b(b), .s(resultado_or)
    );
    
    // XOR (110)
    unidade_xor_8bits U_XOR (
        .a(a), .b(b), .s(resultado_xor)
    );
    
    // NOT (111)
    unidade_not_8bits U_NOT (
        .a(a), .s(resultado_not)
    );
	 
	 or U_OV_MULT (ov_mult, resultado_mult_16bits[15], resultado_mult_16bits[14], resultado_mult_16bits[13],
                   resultado_mult_16bits[12], resultado_mult_16bits[11], resultado_mult_16bits[10],
                   resultado_mult_16bits[9], resultado_mult_16bits[8]);

    // Multiplexador para seleção do resultado
    mux_8_para_1_8bits U_MUX_RESULT (
        .D0(resultado_soma),    // 000: Soma
        .D1(resultado_sub),     // 001: Subtração
        .D2(resultado_mult_16bits),    // 010: Multiplicação
        .D3(resultado_div),     // 011: Divisão
        .D4(resultado_and),     // 100: AND
        .D5(resultado_or),      // 101: OR
        .D6(resultado_xor),     // 110: XOR
        .D7(resultado_not),     // 111: NOT
        .S(operacao),
        .Y(resultado_final)
    );

    // Multiplexador para seleção do carry out
    mux_8_para_1 U_MUX_COUT (
        .D0(cout_soma),         // 000: Soma
        .D1(cout_sub),          // 001: Subtração
        .D2(gnd),               // 010: Multiplicação
        .D3(gnd),               // 011: Divisão
        .D4(gnd),               // 100: AND
        .D5(gnd),               // 101: OR
        .D6(gnd),               // 110: XOR
        .D7(gnd),               // 111: NOT
        .S(operacao),
        .Y(carry_out)
    );

    // Multiplexador para seleção do overflow
    mux_8_para_1 U_MUX_OV (
        .D0(ov_soma),           // 000: Soma
        .D1(ov_sub),            // 001: Subtração
        .D2(ov_mult),           // 010: Multiplicação
        .D3(ov_div),            // 011: Divisão
        .D4(gnd),               // 100: AND
        .D5(gnd),               // 101: OR
        .D6(gnd),               // 110: XOR
        .D7(gnd),               // 111: NOT
        .S(operacao),
        .Y(overflow)
    );

    // Multiplexador para seleção do erro
    mux_8_para_1 U_MUX_ERR (
        .D0(gnd),               // 000: Soma
        .D1(err_sub),           // 001: Subtração
        .D2(gnd),               // 010: Multiplicação
        .D3(err_div),           // 011: Divisão
        .D4(gnd),               // 100: AND
        .D5(gnd),               // 101: OR
        .D6(gnd),               // 110: XOR
        .D7(gnd),               // 111: NOT
        .S(operacao),
        .Y(erro)
    );

    // Detecção de zero
    wire [7:0] not_resultado;
    not U_NOT_RES0 (not_resultado[0], resultado_final[0]);
    not U_NOT_RES1 (not_resultado[1], resultado_final[1]);
    not U_NOT_RES2 (not_resultado[2], resultado_final[2]);
    not U_NOT_RES3 (not_resultado[3], resultado_final[3]);
    not U_NOT_RES4 (not_resultado[4], resultado_final[4]);
    not U_NOT_RES5 (not_resultado[5], resultado_final[5]);
    not U_NOT_RES6 (not_resultado[6], resultado_final[6]);
    not U_NOT_RES7 (not_resultado[7], resultado_final[7]);
    
    and U_ZERO (zero, not_resultado[0], not_resultado[1], not_resultado[2], 
                not_resultado[3], not_resultado[4], not_resultado[5], 
                not_resultado[6], not_resultado[7]);

    // Saída do resultado
    buf U_RESULT0 (resultado[0], resultado_final[0]);
    buf U_RESULT1 (resultado[1], resultado_final[1]);
    buf U_RESULT2 (resultado[2], resultado_final[2]);
    buf U_RESULT3 (resultado[3], resultado_final[3]);
    buf U_RESULT4 (resultado[4], resultado_final[4]);
    buf U_RESULT5 (resultado[5], resultado_final[5]);
    buf U_RESULT6 (resultado[6], resultado_final[6]);
    buf U_RESULT7 (resultado[7], resultado_final[7]);

endmodule
