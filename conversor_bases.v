// Módulo para conversão de bases (hexadecimal, decimal, octal)
// Implementação puramente estrutural

module conversor_bases (
    input  wire [7:0] valor_binario,    // Valor binário de entrada
    input  wire [1:0] base_selecionada, // 00=decimal, 01=hexadecimal, 10=octal
    output wire [6:0] HEX0,             // Display unidade
    output wire [6:0] HEX1,             // Display dezena
    output wire [6:0] HEX2             // Display centena
    //output wire [6:0] HEX3,             // Display milhar (para hex)
    //output wire [6:0] HEX4              // Display adicional (desligado)
);

    // Fios intermediários para conversões
    wire [3:0] digito_unidade, digito_dezena, digito_centena, digito_milhar;
    wire [3:0] hex_unidade, hex_dezena;
    wire [3:0] mux_unidade_out, mux_dezena_out, mux_centena_out;
    
    // Constantes
    wire gnd, vcc;
    wire [3:0] gnd_bus;
    
    // Gerar constantes
    and U_GND (gnd, valor_binario[0], valor_binario[0]);
    not U_VCC_NOT (vcc, gnd);
    
    // Atribuir GND ao barramento
    buf U_GND_BUF0 (gnd_bus[0], gnd);
    buf U_GND_BUF1 (gnd_bus[1], gnd);
    buf U_GND_BUF2 (gnd_bus[2], gnd);
    buf U_GND_BUF3 (gnd_bus[3], gnd);

    // Conversão para decimal (BCD)
    bin_to_bcd_8bit_v3 U_BCD (
        .S(valor_binario),
        .centena_out(digito_centena),
        .dezena_out(digito_dezena),
        .unidade_out(digito_unidade)
    );

    // Conversão para hexadecimal
    // HEX: valor_binario[7:4] = dezena, valor_binario[3:0] = unidade
    buf U_HEX_DEZENA0 (hex_dezena[0], valor_binario[4]);
    buf U_HEX_DEZENA1 (hex_dezena[1], valor_binario[5]);
    buf U_HEX_DEZENA2 (hex_dezena[2], valor_binario[6]);
    buf U_HEX_DEZENA3 (hex_dezena[3], valor_binario[7]);
    
    buf U_HEX_UNIDADE0 (hex_unidade[0], valor_binario[0]);
    buf U_HEX_UNIDADE1 (hex_unidade[1], valor_binario[1]);
    buf U_HEX_UNIDADE2 (hex_unidade[2], valor_binario[2]);
    buf U_HEX_UNIDADE3 (hex_unidade[3], valor_binario[3]);

    // Conversão para octal
    // OCT: valor_binario[7:6] = centena, valor_binario[5:3] = dezena, valor_binario[2:0] = unidade
    wire [3:0] oct_centena, oct_dezena, oct_unidade;
    
    // Centena octal (2 bits)
    buf U_OCT_C0 (oct_centena[0], valor_binario[6]);
    buf U_OCT_C1 (oct_centena[1], valor_binario[7]);
    buf U_OCT_C2 (oct_centena[2], gnd);
    buf U_OCT_C3 (oct_centena[3], gnd);
    
    // Dezena octal (3 bits)
    buf U_OCT_D0 (oct_dezena[0], valor_binario[3]);
    buf U_OCT_D1 (oct_dezena[1], valor_binario[4]);
    buf U_OCT_D2 (oct_dezena[2], valor_binario[5]);
    buf U_OCT_D3 (oct_dezena[3], gnd);
    
    // Unidade octal (3 bits)
    buf U_OCT_U0 (oct_unidade[0], valor_binario[0]);
    buf U_OCT_U1 (oct_unidade[1], valor_binario[1]);
    buf U_OCT_U2 (oct_unidade[2], valor_binario[2]);
    buf U_OCT_U3 (oct_unidade[3], gnd);

    // Multiplexadores para seleção da base
    // MUX para unidade
    mux_4_para_1_4bits U_MUX_UNIDADE (
        .D0(digito_unidade),    // Decimal
        .D1(hex_unidade),       // Hexadecimal
        .D2(oct_unidade),       // Octal
        .D3(gnd_bus),           // Não usado
        .S(base_selecionada),
        .Y(mux_unidade_out)
    );

    // MUX para dezena
    mux_4_para_1_4bits U_MUX_DEZENA (
        .D0(digito_dezena),     // Decimal
        .D1(hex_dezena),        // Hexadecimal
        .D2(oct_dezena),        // Octal
        .D3(gnd_bus),           // Não usado
        .S(base_selecionada),
        .Y(mux_dezena_out)
    );

    // MUX para centena
    mux_4_para_1_4bits U_MUX_CENTENA (
        .D0(digito_centena),    // Decimal
        .D1(gnd_bus),           // Hexadecimal (não usa centena)
        .D2(oct_centena),       // Octal
        .D3(gnd_bus),           // Não usado
        .S(base_selecionada),
        .Y(mux_centena_out)
    );

    // Decodificadores para displays de 7 segmentos
    decodificador_7seg U_DECOD_UNIDADE (.D(mux_unidade_out), .SEG(HEX0));
    decodificador_7seg U_DECOD_DEZENA (.D(mux_dezena_out), .SEG(HEX1));
    decodificador_7seg U_DECOD_CENTENA (.D(mux_centena_out), .SEG(HEX2));
    
    // HEX3 e HEX4 sempre desligados (todos os segmentos em 1 para display de 7 segmentos)
    //buf U_HEX3_SEG0 (HEX3[0], vcc);
    //buf U_HEX3_SEG1 (HEX3[1], vcc);
    //buf U_HEX3_SEG2 (HEX3[2], vcc);
    //buf U_HEX3_SEG3 (HEX3[3], vcc);
    //buf U_HEX3_SEG4 (HEX3[4], vcc);
    //buf U_HEX3_SEG5 (HEX3[5], vcc);
    //buf U_HEX3_SEG6 (HEX3[6], vcc);
    
    //buf U_HEX4_SEG0 (HEX4[0], vcc);
    //buf U_HEX4_SEG1 (HEX4[1], vcc);
    //buf U_HEX4_SEG2 (HEX4[2], vcc);
    //buf U_HEX4_SEG3 (HEX4[3], vcc);
    //buf U_HEX4_SEG4 (HEX4[4], vcc);
    //buf U_HEX4_SEG5 (HEX4[5], vcc);
    //buf U_HEX4_SEG6 (HEX4[6], vcc);

endmodule
