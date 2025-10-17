module contador_push_2bits (
    input  wire push_debounced,      // Sinal de entrada do botão (ex: KEY0)
    input  wire clk,             // Clock principal do sistema (ex: MAX10_CLK1_50)
    input  wire rst_n,           // Reset geral, ativo baixo
    output wire [1:0] count      // Saída do contador de 2 bits
);

    // --- Constantes ---
    wire notrst, gnd;
    not N0 (notrst, rst_n);
    and AND1 (gnd, rst_n, notrst);

    // --- Etapa 2: Detector de Borda de Subida ---
    // Gera um pulso de um ciclo de clock quando 'push_debounced' vai de 0 para 1.
    wire push_prev;
    wire not_push_prev;
    wire enable_pulse;

    // Armazena o valor anterior do sinal já filtrado
    flip_flop_d U_EDGE_DETECT_FF (
        .D(push_debounced),
        .clk(clk),
        .rst(rst_n),
        .Q(push_prev)
    );

    // Lógica da borda de subida: enable_pulse = push_debounced AND (NOT push_prev)
    not U_NOT_PREV (not_push_prev, push_prev);
    and U_AND_EDGE (enable_pulse, push_debounced, not_push_prev);


    // --- Etapa 3: Lógica Combinacional do Contador Síncrono ---
    wire [1:0] count_reg;      // Valor atual (saída dos FFs do contador)
    wire [1:0] count_next;
    wire cout;

    full_adder AD01 (.a(count_reg[0]),
        .b(enable_pulse),
        .cin(gnd),
        .s(count_next[0]),
        .cout(cout)
    );
    full_adder AD02 (.a(count_reg[1]),
        .b(cout),
        .cin(gnd),
        .s(count_next[1]),
        .cout()
    );

    // --- Etapa 4: Registradores de Estado do Contador ---
    flip_flop_d U_REG_COUNT0 (
        .D(count_next[0]),
        .clk(clk),
        .rst(rst_n),
        .Q(count_reg[0])
    );
    flip_flop_d U_REG_COUNT1 (
        .D(count_next[1]),
        .clk(clk),
        .rst(rst_n),
        .Q(count_reg[1])
    );

    // --- Saída Final ---
    // Removemos o 'assign' e usamos buffers para manter a natureza estrutural.
    buf BUF_OUT0 (count[0], count_reg[0]);
    buf BUF_OUT1 (count[1], count_reg[1]);

endmodule