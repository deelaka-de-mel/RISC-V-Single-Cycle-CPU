module pc (
    input  logic        clk,
    input  logic        rstn,
    input  logic [31:0] next_pc,
    output logic [31:0] pc
);

    always @(posedge clk or negedge rstn) begin
        if (!rstn) pc <= 0;
        else begin
            pc <= next_pc;
        end
    end

endmodule