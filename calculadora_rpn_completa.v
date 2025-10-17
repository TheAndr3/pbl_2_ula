
// Módulo principal da calculadora RPN com sistema de clock real
// Implementação puramente estrutural

module calculadora_rpn_completa (
    // Entradas físicas da placa
    input  wire [9:0] SW,           // Chaves da placa
    input  wire [1:0] KEY,          // Botões da placa
    input  wire CLOCK_50,           // Clock da placa (50MHz)
    
    // Saídas físicas da placa
    output wire [6:0] HEX0,         // Display unidade
    output wire [6:0] HEX1,         // Display dezena
    output wire [6:0] HEX2,         // Display centena
    //output wire [6:0] HEX3,         // Display milhar
    //output wire [6:0] HEX4,         // Display operação
    output wire [6:0] HEX5,         // Display base
    output wire [9:0] LEDR          // LEDs indicadores
);

    // Mapeamento de entradas
    wire [7:0] entrada_numero = SW[7:0];        // Entrada de número de 8 bits
    wire [1:0] base_exibicao = SW[9:8];         // Base de exibição (00=dec, 01=hex, 10=oct)
    wire push_pilha;
	 not n00 (push_pilha, KEY[0]);                   // KEY[0] para dar push na pilha
    wire executar_operacao;
	 not n01 (executar_operacao, KEY[1]);            // KEY[1] para executar operação
    
    // Sinais de controle e saída do sistema RPN
    wire entrada_numero_a, entrada_numero_b, entrada_operacao;
    wire [1:0] contador_entrada;
    wire [2:0] codigo_operacao_interno;
    wire [7:0] valor_exibicao;
    wire [7:0] resultado_ula;
    wire overflow, zero, carry_out, erro;
    
    // Constantes e reset
    wire gnd, rst;
    
    // Gerar constantes
	 wire n_ent0;
	 not not0n (n_ent0, entrada_numero[0]);
    and U_GND (gnd, entrada_numero[0],n_ent0);
    
    // Reset (ativo baixo)
    not U_RST (rst, gnd);

    // Sistema RPN completo
    sistema_rpn_completo U_SISTEMA_RPN (
        .entrada_numero(entrada_numero),
        .push_pilha(push_pilha),
        .executar_operacao(executar_operacao),
        .clk(CLOCK_50),
        .rst(rst),
        .valor_exibicao(valor_exibicao),
        .estado_contador(contador_entrada),
        .entrada_numero_a(entrada_numero_a),
        .entrada_numero_b(entrada_numero_b),
        .entrada_operacao(entrada_operacao),
        .codigo_operacao(codigo_operacao_interno),
        .resultado_ula(resultado_ula),
        .overflow(overflow),
        .zero(zero),
        .carry_out(carry_out),
        .erro(erro)
    );

    // Conversor de bases
    conversor_bases U_CONVERSOR (
        .valor_binario(valor_exibicao),
        .base_selecionada(base_exibicao),
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2)
        //.HEX3(HEX3),
        //.HEX4(HEX4)
    );
	 


    // Display da base
    base_7seg U_BASE_DISPLAY (
        .seletor(base_exibicao),
        .HEX5(HEX5)
    );

    // LEDs indicadores
    //buf U_LED0 (LEDR[0], contador_entrada[0]);  // Bit menos significativo do contador
    //buf U_LED1 (LEDR[1], contador_entrada[1]);  // Bit mais significativo do contador
    buf U_LED2 (LEDR[2], zero);                 // Flag Zero
    buf U_LED3 (LEDR[3], overflow);             // Flag Overflow
    buf U_LED4 (LEDR[4], carry_out);            // Flag Carry Out
    buf U_LED5 (LEDR[5], erro);                 // Flag Erro
	 wire n_count0, n_count1;
	 not N00 (n_count0, contador_entrada[0]);
	 not N01 (n_count1, contador_entrada[1]);
    and U_LED6 (LEDR[6], n_count0, n_count1);     // Indica estágio A (contador 00)
    and U_LED7 (LEDR[7], contador_entrada[0], n_count1);     // Indica estágio B (contador 01)
    and U_LED8 (LEDR[8], n_count0, contador_entrada[1]);     // Indica estágio Operação (contador 10)
    and U_LED9 (LEDR[9], contador_entrada[1], contador_entrada[0]);    // Indica estágio Executar (contador 11)

endmodule
