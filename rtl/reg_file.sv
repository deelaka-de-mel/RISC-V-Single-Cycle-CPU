module reg_file(
    input logic clk,
    input logic wr_en,
    input logic [4:0] rd_addr,
    input logic [4:0] rs1_addr,
    input logic [4:0] rs2_addr,

    input logic [31:0] wr_data,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data

);  
    logic [31:0] regs [0:31];

    always_comb begin
        rs1_data = regs[rs1_addr];
        rs2_data = regs[rs2_addr];
        
    end

    always @(posedge clk) begin
        if (wr_en && rd_addr) begin
            regs[rd_addr] <= wr_data;
        end
    end



endmodule