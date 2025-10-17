// Registrador de 8 bits com enable
// Implementação puramente estrutural

module registrador_8bits (
    input  wire [7:0] D,        // Entrada de dados
    input  wire clk,             // Clock
    input  wire rst,             // Reset (ativo baixo)
    input  wire enable,          // Enable
    output wire [7:0] Q          // Saída
);

    // Fios intermediários para implementar enable
    wire [7:0] D_gated;
    
    // Lógica de enable: se enable=0, mantém valor atual (Q), se enable=1, carrega novo valor (D)
    // D_gated = (enable AND D) OR (NOT enable AND Q)
    wire [7:0] enable_and_D, not_enable_and_Q, not_enable;
    
    // Inversor para enable
    not U_NOT_ENABLE (not_enable[0], enable);
    buf U_NOT_ENABLE1 (not_enable[1], not_enable[0]);
    buf U_NOT_ENABLE2 (not_enable[2], not_enable[0]);
    buf U_NOT_ENABLE3 (not_enable[3], not_enable[0]);
    buf U_NOT_ENABLE4 (not_enable[4], not_enable[0]);
    buf U_NOT_ENABLE5 (not_enable[5], not_enable[0]);
    buf U_NOT_ENABLE6 (not_enable[6], not_enable[0]);
    buf U_NOT_ENABLE7 (not_enable[7], not_enable[0]);
    
    // enable AND D
    and U_EN_D0 (enable_and_D[0], enable, D[0]);
    and U_EN_D1 (enable_and_D[1], enable, D[1]);
    and U_EN_D2 (enable_and_D[2], enable, D[2]);
    and U_EN_D3 (enable_and_D[3], enable, D[3]);
    and U_EN_D4 (enable_and_D[4], enable, D[4]);
    and U_EN_D5 (enable_and_D[5], enable, D[5]);
    and U_EN_D6 (enable_and_D[6], enable, D[6]);
    and U_EN_D7 (enable_and_D[7], enable, D[7]);
    
    // NOT enable AND Q (mantém valor atual quando enable=0)
    and U_NOT_EN_Q0 (not_enable_and_Q[0], not_enable[0], Q[0]);
    and U_NOT_EN_Q1 (not_enable_and_Q[1], not_enable[1], Q[1]);
    and U_NOT_EN_Q2 (not_enable_and_Q[2], not_enable[2], Q[2]);
    and U_NOT_EN_Q3 (not_enable_and_Q[3], not_enable[3], Q[3]);
    and U_NOT_EN_Q4 (not_enable_and_Q[4], not_enable[4], Q[4]);
    and U_NOT_EN_Q5 (not_enable_and_Q[5], not_enable[5], Q[5]);
    and U_NOT_EN_Q6 (not_enable_and_Q[6], not_enable[6], Q[6]);
    and U_NOT_EN_Q7 (not_enable_and_Q[7], not_enable[7], Q[7]);
    
    // D_gated = enable_and_D OR not_enable_and_Q
    or U_D_GATED0 (D_gated[0], enable_and_D[0], not_enable_and_Q[0]);
    or U_D_GATED1 (D_gated[1], enable_and_D[1], not_enable_and_Q[1]);
    or U_D_GATED2 (D_gated[2], enable_and_D[2], not_enable_and_Q[2]);
    or U_D_GATED3 (D_gated[3], enable_and_D[3], not_enable_and_Q[3]);
    or U_D_GATED4 (D_gated[4], enable_and_D[4], not_enable_and_Q[4]);
    or U_D_GATED5 (D_gated[5], enable_and_D[5], not_enable_and_Q[5]);
    or U_D_GATED6 (D_gated[6], enable_and_D[6], not_enable_and_Q[6]);
    or U_D_GATED7 (D_gated[7], enable_and_D[7], not_enable_and_Q[7]);

    // Instanciar 8 flip-flops D com entrada gated
    flip_flop_d U_FF0 (
        .D(D_gated[0]),
        .clk(clk),
        .rst(rst),
        .Q(Q[0])
    );
    
    flip_flop_d U_FF1 (
        .D(D_gated[1]),
        .clk(clk),
        .rst(rst),
        .Q(Q[1])
    );
    
    flip_flop_d U_FF2 (
        .D(D_gated[2]),
        .clk(clk),
        .rst(rst),
        .Q(Q[2])
    );
    
    flip_flop_d U_FF3 (
        .D(D_gated[3]),
        .clk(clk),
        .rst(rst),
        .Q(Q[3])
    );
    
    flip_flop_d U_FF4 (
        .D(D_gated[4]),
        .clk(clk),
        .rst(rst),
        .Q(Q[4])
    );
    
    flip_flop_d U_FF5 (
        .D(D_gated[5]),
        .clk(clk),
        .rst(rst),
        .Q(Q[5])
    );
    
    flip_flop_d U_FF6 (
        .D(D_gated[6]),
        .clk(clk),
        .rst(rst),
        .Q(Q[6])
    );
    
    flip_flop_d U_FF7 (
        .D(D_gated[7]),
        .clk(clk),
        .rst(rst),
        .Q(Q[7])
    );

endmodule