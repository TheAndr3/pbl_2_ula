// Adicionamos a entrada "cin_inicial"
module subtrator_5x4bits_v2 (
    input  wire [4:0] a,
    input  wire [3:0] b,
    input  wire modo_sub,       // 0=Soma, 1=Subtração
    input  wire cin_inicial,    // Carry-in externo
    output wire [4:0] s,
    output wire cout,
    output wire ov 
);

    // Fio para o operando B modificado (será 'B' para soma, 'NOT B' para subtração)
    wire [4:0] b_modificado;
    wire c1, c2, c3, c4;
	 wire gnd = 1'b0;
	

    // 1. Inversor Controlável para o operando B (usando portas XOR)
    xor XOR0 (b_modificado[0], b[0], modo_sub);
    xor XOR1 (b_modificado[1], b[1], modo_sub);
    xor XOR2 (b_modificado[2], b[2], modo_sub);
    xor XOR3 (b_modificado[3], b[3], modo_sub);
	 xor XOR4 (b_modificado[4], gnd, modo_sub);
    
    // 2. Somador de 4 bits (Ripple-Carry Adder)
    // A entrada de carry do primeiro somador agora usa "cin_inicial"
    full_adder fa0 ( .a(a[0]), .b(b_modificado[0]), .cin(cin_inicial), .s(s[0]), .cout(c1) );
    full_adder fa1 ( .a(a[1]), .b(b_modificado[1]), .cin(c1),           .s(s[1]), .cout(c2) );
    full_adder fa2 ( .a(a[2]), .b(b_modificado[2]), .cin(c2),           .s(s[2]), .cout(c3) );
    full_adder fa3 ( .a(a[3]), .b(b_modificado[3]), .cin(c3),           .s(s[3]), .cout(c4) );
	 full_adder fa4 ( .a(a[4]), .b(b_modificado[4]), .cin(c3),           .s(s[4]), .cout(cout) );
	 
	 

endmodule