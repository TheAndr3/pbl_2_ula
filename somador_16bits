module somador_16bits (
    input  wire [15:0] a,        // Operando A
    input  wire [15:0] b,        // Operando B
    input  wire        cin,      // Carry in
    output wire [15:0] s,        // Soma
    output wire        cout,     // Carry out
    output wire        ov        // Overflow
);

    // Fios intermediários para os carrys de cada estágio
    wire [15:0] c;

    // Instanciação dos 16 full adders
    full_adder U_FA0  (.a(a[0]),  .b(b[0]),  .cin(cin),   .s(s[0]),  .cout(c[0]));
    full_adder U_FA1  (.a(a[1]),  .b(b[1]),  .cin(c[0]),  .s(s[1]),  .cout(c[1]));
    full_adder U_FA2  (.a(a[2]),  .b(b[2]),  .cin(c[1]),  .s(s[2]),  .cout(c[2]));
    full_adder U_FA3  (.a(a[3]),  .b(b[3]),  .cin(c[2]),  .s(s[3]),  .cout(c[3]));
    full_adder U_FA4  (.a(a[4]),  .b(b[4]),  .cin(c[3]),  .s(s[4]),  .cout(c[4]));
    full_adder U_FA5  (.a(a[5]),  .b(b[5]),  .cin(c[4]),  .s(s[5]),  .cout(c[5]));
    full_adder U_FA6  (.a(a[6]),  .b(b[6]),  .cin(c[5]),  .s(s[6]),  .cout(c[6]));
    full_adder U_FA7  (.a(a[7]),  .b(b[7]),  .cin(c[6]),  .s(s[7]),  .cout(c[7]));
    full_adder U_FA8  (.a(a[8]),  .b(b[8]),  .cin(c[7]),  .s(s[8]),  .cout(c[8]));
    full_adder U_FA9  (.a(a[9]),  .b(b[9]),  .cin(c[8]),  .s(s[9]),  .cout(c[9]));
    full_adder U_FA10 (.a(a[10]), .b(b[10]), .cin(c[9]),  .s(s[10]), .cout(c[10]));
    full_adder U_FA11 (.a(a[11]), .b(b[11]), .cin(c[10]), .s(s[11]), .cout(c[11]));
    full_adder U_FA12 (.a(a[12]), .b(b[12]), .cin(c[11]), .s(s[12]), .cout(c[12]));
    full_adder U_FA13 (.a(a[13]), .b(b[13]), .cin(c[12]), .s(s[13]), .cout(c[13]));
    full_adder U_FA14 (.a(a[14]), .b(b[14]), .cin(c[13]), .s(s[14]), .cout(c[14]));
    full_adder U_FA15 (.a(a[15]), .b(b[15]), .cin(c[14]), .s(s[15]), .cout(c[15]));

    // Saída do carry out final
    buf U_COUT (cout, c[15]);

    // Detecção de overflow (XOR entre o carry para o último bit e o carry de saída)
    xor U_OV (ov, c[15], c[14]);

endmodule
