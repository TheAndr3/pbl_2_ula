// Módulo para exibir a base selecionada no display de 7 segmentos
// Implementação puramente estrutural

module base_7seg (
    input  wire [1:0] seletor,  // 00=decimal, 01=hexadecimal, 10=octal
    output wire [6:0] HEX5      // Display de 7 segmentos
);

    // Fios intermediários
    wire [6:0] seg_dec, seg_hex, seg_oct;
    
    // Constantes
    wire gnd, vcc;
    
    // Gerar constantes
    and U_GND (gnd, seletor[0], seletor[0]);
    not U_VCC_NOT (vcc, gnd);

    // Display para decimal (d)
    // Segments: a=0, b=1, c=2, d=3, e=4, f=5, g=6
    // 'd' = a=0, b=1, c=1, d=1, e=1, f=0, g=1
    buf U_DEC_A (seg_dec[0], gnd);
    buf U_DEC_B (seg_dec[1], vcc);
    buf U_DEC_C (seg_dec[2], vcc);
    buf U_DEC_D (seg_dec[3], vcc);
    buf U_DEC_E (seg_dec[4], vcc);
    buf U_DEC_F (seg_dec[5], gnd);
    buf U_DEC_G (seg_dec[6], vcc);

    // Display para hexadecimal (h)
    // 'h' = a=0, b=1, c=1, d=0, e=1, f=1, g=1
    buf U_HEX_A (seg_hex[0], gnd);
    buf U_HEX_B (seg_hex[1], vcc);
    buf U_HEX_C (seg_hex[2], vcc);
    buf U_HEX_D (seg_hex[3], gnd);
    buf U_HEX_E (seg_hex[4], vcc);
    buf U_HEX_F (seg_hex[5], vcc);
    buf U_HEX_G (seg_hex[6], vcc);

    // Display para octal (o)
    // 'o' = a=1, b=1, c=1, d=1, e=1, f=1, g=0
    buf U_OCT_A (seg_oct[0], vcc);
    buf U_OCT_B (seg_oct[1], vcc);
    buf U_OCT_C (seg_oct[2], vcc);
    buf U_OCT_D (seg_oct[3], vcc);
    buf U_OCT_E (seg_oct[4], vcc);
    buf U_OCT_F (seg_oct[5], vcc);
    buf U_OCT_G (seg_oct[6], gnd);

    // Multiplexador para seleção da base
    mux_4_para_1_7bits U_MUX_BASE (
        .D0(seg_dec),           // 00: Decimal
        .D1(seg_hex),           // 01: Hexadecimal
        .D2(seg_oct),           // 10: Octal
        .D3(7'b0000000),        // 11: Não usado
        .S(seletor),
        .Y(HEX5)
    );

endmodule
