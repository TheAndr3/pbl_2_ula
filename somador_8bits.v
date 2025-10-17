module somador_8bits (
    input  wire [7:0] a,        // Operando A
    input  wire [7:0] b,        // Operando B
    input  wire cin,            // Carry in
    output wire [7:0] s,        // Soma
    output wire cout,           // Carry out
    output wire ov              // Overflow
);

    // Fios intermediários para carry
    wire c0, c1, c2, c3, c4, c5, c6, c7;

    // Instanciação dos full adders
    full_adder U_FA0 (.a(a[0]), .b(b[0]), .cin(cin),  .s(s[0]), .cout(c0));
    full_adder U_FA1 (.a(a[1]), .b(b[1]), .cin(c0),   .s(s[1]), .cout(c1));
    full_adder U_FA2 (.a(a[2]), .b(b[2]), .cin(c1),   .s(s[2]), .cout(c2));
    full_adder U_FA3 (.a(a[3]), .b(b[3]), .cin(c2),   .s(s[3]), .cout(c3));
    full_adder U_FA4 (.a(a[4]), .b(b[4]), .cin(c3),   .s(s[4]), .cout(c4));
    full_adder U_FA5 (.a(a[5]), .b(b[5]), .cin(c4),   .s(s[5]), .cout(c5));
    full_adder U_FA6 (.a(a[6]), .b(b[6]), .cin(c5),   .s(s[6]), .cout(c6));
    full_adder U_FA7 (.a(a[7]), .b(b[7]), .cin(c6),   .s(s[7]), .cout(c7));

    // Carry out final
    buf U_COUT (cout, c7);

    // Detecção de overflow (XOR entre carry out e carry in do último bit)
    wire ov_temp;
    xor U_OV (ov_temp, c7, c6);
    buf U_OVERFLOW (ov, ov_temp);

endmodule
