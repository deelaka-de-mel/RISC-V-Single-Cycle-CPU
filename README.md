# RISC-V Single-Cycle CPU

A 32-bit RISC-V single-cycle CPU designed and implemented in SystemVerilog from the ground up.

The purpose of this project is to understand the fundamentals of processor design by implementing and testing each CPU component individually before integrating them into a complete processor.

## Project Overview

This project implements a simplified RISC-V processor using a single-cycle datapath. Each instruction completes its fetch, decode, execute, memory access, and writeback operations within a single clock cycle.

The processor is being developed as a modular design consisting of:

* Program Counter
* Instruction Memory
* Register File
* Immediate Generator
* ALU
* ALU Control
* Control Unit
* Data Memory
* Branch Comparator
* Next-PC Logic
* Writeback Logic

## Instruction Set

The initial implementation supports the following RISC-V instruction groups:

| Type   | Instructions                       | Opcode    |
| ------ | ---------------------------------- | --------- |
| R-Type | ADD, SUB, AND, OR, XOR, SLT, SLTU  | `0110011` |
| I-Type | ADDI, ANDI, ORI, XORI, SLTI, SLTIU | `0010011` |
| Load   | LW                                 | `0000011` |
| Store  | SW                                 | `0100011` |
| Branch | BEQ, BNE, BLT, BGE, BLTU, BGEU     | `1100011` |
| Jump   | JAL                                | `1101111` |
| Jump   | JALR                               | `1100111` |

Additional instructions may be added as the project develops.

## Modules

### Program Counter

The program counter stores the address of the current instruction and updates to the next PC value on each clock cycle.

### Instruction Memory

A read-only memory containing the program instructions. Instructions are 32 bits wide and are accessed using byte addresses.

Programs can be loaded into memory using `$readmemh`.

### Register File

The register file contains 32 registers, each 32 bits wide.

It has:

* Two read ports
* One write port
* Synchronous writes
* Combinational reads

Register `x0` is hardwired to zero, as specified by the RISC-V ISA.

### Immediate Generator

The immediate generator extracts and reconstructs immediate values from the instruction and sign-extends them to 32 bits.

It supports:

* I-type immediates
* S-type immediates
* B-type immediates
* J-type immediates

For example, an I-type immediate is generated from:

```systemverilog
{{20{instruction[31]}}, instruction[31:20]}
```

### ALU

The ALU performs the arithmetic and logical operations required by the supported instructions.

Current operations include:

* ADD
* SUB
* AND
* OR
* XOR
* SLT
* SLTU

### ALU Control

The ALU Control block determines the specific ALU operation using the instruction's `funct3`, `funct7`, and higher-level `ALUOp` control signals.

### Control Unit

The Control Unit decodes the instruction opcode and generates the control signals required by the datapath.

Examples include:

* `RegWrite`
* `MemRead`
* `MemWrite`
* `MemToReg`
* `Branch`
* `Jump`
* `ALUSrc`
* `ALUOp`

### Data Memory

Data memory is used by load and store instructions.

The initial implementation focuses on word accesses such as `LW` and `SW`.

### Branch and Next-PC Logic

The next-PC logic determines whether the processor should:

* Continue to `PC + 4`
* Branch to `PC + immediate`
* Jump to a JAL target
* Jump to a JALR target

Branch comparisons are handled separately from the main ALU.

## RISC-V Instruction Formats

The processor works with the standard 32-bit RISC-V instruction formats.

### R-Type

```text
funct7 | rs2 | rs1 | funct3 | rd | opcode
```

### I-Type

```text
immediate | rs1 | funct3 | rd | opcode
```

### S-Type

```text
imm[11:5] | rs2 | rs1 | funct3 | imm[4:0] | opcode
```

### B-Type

```text
imm[12|10:5] | rs2 | rs1 | funct3 | imm[4:1|11] | opcode
```

### J-Type

```text
imm[20|10:1|11|19:12] | rd | opcode
```

## Verification

Each module is tested individually before being integrated into the complete CPU.

Testbenches are used to verify:

* Normal operation
* Reset behavior
* Register reads and writes
* `x0` behavior
* Immediate generation
* ALU operations
* Memory operations
* Branch conditions
* Jump instructions
* Instruction sequencing

Simulation waveforms are used to investigate timing and logic errors during development.

## Tools

* SystemVerilog
* Quartus
* RARS

RARS is used to assemble and test RISC-V programs and generate machine-code instructions that can be loaded into the instruction memory.

## Project Status

**Work in Progress**

### Completed

* [x] Program Counter
* [x] Instruction Memory
* [x] Register File
* [x] Immediate Generator

### In Progress

* [ ] ALU
* [ ] ALU Control
* [ ] Control Unit
* [ ] Data Memory
* [ ] Branch Comparator
* [ ] Next-PC Logic
* [ ] Writeback Logic
* [ ] CPU Integration
* [ ] Full CPU Verification

<!--### Future Work

* [ ] LUI
* [ ] AUIPC
* [ ] Additional load/store instructions
* [ ] More extensive verification
* [ ] FPGA implementation-->

## Learning Objectives

This project is primarily focused on developing a first-principles understanding of CPU and RTL design.

The main areas I'm working with are:

* RISC-V instruction set architecture
* CPU datapath design
* Instruction decoding
* Register files
* ALU design
* Control logic
* Immediate generation
* Branch and jump logic
* Memory interfaces
* SystemVerilog RTL
* Hardware verification
* Simulation and waveform debugging

## Author

**Deelaka Jerome de Mel**

BSc (Hons) Electronic & Telecommunication Engineering
University of Moratuwa, Sri Lanka
