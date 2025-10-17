module flip_flop_d (
    input  wire D,
    input  wire clk,
    input  wire rst, // Reset ativo baixo
    output reg  Q,
	 output wire Qn
    // A saída Qn pode ser criada com um simple 'assign Qn = ~Q;' fora do always
);

    always @(posedge clk or negedge rst) begin
        if (!rst) // Se o reset (ativo baixo) estiver em 0
            Q <= 1'b0;
        else
            Q <= D;
    end
	 
	 not D0 (Qn, Q);

endmodule
