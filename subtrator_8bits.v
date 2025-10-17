// Módulo subtrator de 8 bits
// Implementação puramente estrutural usando complemento de 2

module subtrator_8bits (
    input  wire [7:0] a,        // Operando A
    input  wire [7:0] b,        // Operando B
    output wire [7:0] s,        // Diferença
    output wire cout,           // Carry out
    output wire ov,             // Overflow
    output wire neg             // Flag de resultado negativo
);

    // Complemento de 2 de B
    wire [7:0] b_comp2;
    wire [7:0] b_not;
    wire [7:0] b_plus_1;
    
    // Inverter B
    not U_NOT_B0 (b_not[0], b[0]);
    not U_NOT_B1 (b_not[1], b[1]);
    not U_NOT_B2 (b_not[2], b[2]);
    not U_NOT_B3 (b_not[3], b[3]);
    not U_NOT_B4 (b_not[4], b[4]);
    not U_NOT_B5 (b_not[5], b[5]);
    not U_NOT_B6 (b_not[6], b[6]);
    not U_NOT_B7 (b_not[7], b[7]);
    
    // Somar 1 ao B invertido
    somador_8bits U_ADD_1 (
        .a(b_not), .b(8'b00000001), .cin(1'b0),
        .s(b_comp2), .cout(), .ov()
    );
    
    // Somar A com complemento de 2 de B
    somador_8bits U_SUB (
        .a(a), .b(b_comp2), .cin(1'b0),
        .s(s), .cout(cout), .ov(ov)
    );
    
    // Flag de resultado negativo (bit mais significativo do resultado)
    buf U_NEG (neg, s[7]);

endmodule
