// Módulo Meio-Somador (Half Adder) Estrutural

module half_adder (
    input  wire a,
    input  wire b,
    output wire s,
    output wire cout
);
    xor(s, a, b);
    and(cout, a, b);
endmodule