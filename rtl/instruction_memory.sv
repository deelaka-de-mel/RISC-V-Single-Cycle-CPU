module instruction_memory(
    input logic [31:0] addr,
    output logic [31:0] instruction
);

    logic [31:0] mem [0:1023];

    assign instruction = mem[addr];
endmodule