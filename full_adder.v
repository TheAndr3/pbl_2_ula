module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire s,
    output wire cout
);

    // s = (~a & ~b & cin) | (~a & b & ~cin) | (a & ~b & ~cin) | (a & b & cin);
    wire term_s1;	 
	 xor (term_s1, b, cin);
    xor  U8_or_s   (s, term_s1, a);

    // cout = (b & cin) | (a & cin) | (a & b);
    wire term_c1, term_c2, term_c3;	 
    and U9_and_c1  (term_c1, b, cin);
    and U10_and_c2 (term_c2, a, cin);
    and U11_and_c3 (term_c3, a, b);
    or  U12_or_c   (cout, term_c1, term_c2, term_c3);

endmodule