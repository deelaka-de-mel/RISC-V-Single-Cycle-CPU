module immediate_generator(
    input  logic [31:0] instruction,
    output logic [31:0] imm
);

    typedef enum logic [6:0] {
        STORE  = 7'b0100011,
        JALR   = 7'b1100111,
        JAL    = 7'b1101111,
        LOAD   = 7'b0000011,
        OP_IMM = 7'b0010011,
        BRANCH = 7'b1100011
    } opcode_t;

    opcode_t opcode;

    assign opcode = instruction[6:0];

    always_comb begin
        case (opcode)

            LOAD:
                imm = {{20{instruction[31]}},
                       instruction[31:20]};

            JALR:
                imm = {{20{instruction[31]}},
                       instruction[31:20]};

            OP_IMM:
                imm = {{20{instruction[31]}},
                       instruction[31:20]};

            STORE:
                imm = {{20{instruction[31]}},
                       instruction[31:25],
                       instruction[11:7]};

            JAL:
                imm = {{11{instruction[31]}},
                       instruction[31],
                       instruction[19:12],
                       instruction[20],
                       instruction[30:21],
                       1'b0};

            BRANCH:
                imm = {{19{instruction[31]}},
                       instruction[31],
                       instruction[7],
                       instruction[30:25],
                       instruction[11:8],
                       1'b0};

            default:
                imm = 32'b0;

        endcase
    end

endmodule