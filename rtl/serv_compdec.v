// Copyright lowRISC contributors.
// Copyright 2018 ETH Zurich and University of Bologna, see also CREDITS.md.
// Licensed under the Apache License, Version 2.0, see LICENSE for details.
// SPDX-License-Identifier: Apache-2.0

/**
 * Compressed instruction decoder
 *
 * Decodes RISC-V compressed instructions into their RV32 equivalent.
 */

module serv_compdec 
#(parameter COMPRESSED=0)
(
  input  wire [31:0] i_instr,
  input wire i_ack,
  output wire [31:0] o_instr,
  output wire o_iscomp
);

  localparam OPCODE_LOAD     = 7'h03;
  localparam OPCODE_OP_IMM   = 7'h13;
  localparam OPCODE_STORE    = 7'h23;
  localparam OPCODE_OP       = 7'h33;
  localparam OPCODE_LUI      = 7'h37;
  localparam OPCODE_BRANCH   = 7'h63;
  localparam OPCODE_JALR     = 7'h67;
  localparam OPCODE_JAL      = 7'h6f;

  generate 
    if(COMPRESSED) begin  
      reg  [31:0] comp_instr;
      reg  illegal_instr;
      ////////////////////////
      // Compressed decoder //
      ////////////////////////

      always @ (*) begin
        // By default, forward incoming instruction, mark it as legal.
        comp_instr         = i_instr;
        illegal_instr = 1'b0;

        // Check if incoming instruction is compressed.
        case (i_instr[1:0])
          // C0
          2'b00: begin
            case (i_instr[15:13])
              3'b000: begin
                // c.addi4spn -> addi rd', x2, imm
                comp_instr = {2'b0, i_instr[10:7], i_instr[12:11], i_instr[5],
                          i_instr[6], 2'b00, 5'h02, 3'b000, 2'b01, i_instr[4:2], {OPCODE_OP_IMM}};
                if (i_instr[12:5] == 8'b0)  illegal_instr = 1'b1;
              end

              3'b010: begin
                // c.lw -> lw rd', imm(rs1')
                comp_instr = {5'b0, i_instr[5], i_instr[12:10], i_instr[6],
                          2'b00, 2'b01, i_instr[9:7], 3'b010, 2'b01, i_instr[4:2], {OPCODE_LOAD}};
              end

              3'b110: begin
                // c.sw -> sw rs2', imm(rs1')
                comp_instr = {5'b0, i_instr[5], i_instr[12], 2'b01, i_instr[4:2],
                          2'b01, i_instr[9:7], 3'b010, i_instr[11:10], i_instr[6],
                          2'b00, {OPCODE_STORE}};
              end

              3'b001,
              3'b011,
              3'b100,
              3'b101,
              3'b111: begin
                illegal_instr = 1'b1;
              end

              default: begin
                illegal_instr = 1'b1;
              end
            endcase
          end

          // C1
          //
          // Register address checks for RV32E are performed in the regular instruction decoder.
          // If this check fails, an illegal instruction exception is triggered and the controller
          // writes the actual faulting instruction to mtval.
          2'b01: begin
            case (i_instr[15:13])
              3'b000: begin
                // c.addi -> addi rd, rd, nzimm
                // c.nop
                comp_instr = {{6 {i_instr[12]}}, i_instr[12], i_instr[6:2],
                          i_instr[11:7], 3'b0, i_instr[11:7], {OPCODE_OP_IMM}};
              end

              3'b001, 3'b101: begin
                // 001: c.jal -> jal x1, imm
                // 101: c.j   -> jal x0, imm
                comp_instr = {i_instr[12], i_instr[8], i_instr[10:9], i_instr[6],
                          i_instr[7], i_instr[2], i_instr[11], i_instr[5:3],
                          {9 {i_instr[12]}}, 4'b0, ~i_instr[15], {OPCODE_JAL}};
              end

              3'b010: begin
                // c.li -> addi rd, x0, nzimm
                // (c.li hints are translated into an addi hint)
                comp_instr = {{6 {i_instr[12]}}, i_instr[12], i_instr[6:2], 5'b0,
                          3'b0, i_instr[11:7], {OPCODE_OP_IMM}};
              end

              3'b011: begin
                // c.lui -> lui rd, imm
                // (c.lui hints are translated into a lui hint)
                comp_instr = {{15 {i_instr[12]}}, i_instr[6:2], i_instr[11:7], {OPCODE_LUI}};

                if (i_instr[11:7] == 5'h02) begin
                  // c.addi16sp -> addi x2, x2, nzimm
                  comp_instr = {{3 {i_instr[12]}}, i_instr[4:3], i_instr[5], i_instr[2],
                            i_instr[6], 4'b0, 5'h02, 3'b000, 5'h02, {OPCODE_OP_IMM}};
                end

                if ({i_instr[12], i_instr[6:2]} == 6'b0) illegal_instr = 1'b1;
              end

              3'b100: begin
                case (i_instr[11:10])
                  2'b00,
                  2'b01: begin
                    // 00: c.srli -> srli rd, rd, shamt
                    // 01: c.srai -> srai rd, rd, shamt
                    // (c.srli/c.srai hints are translated into a srli/srai hint)
                    comp_instr = {1'b0, i_instr[10], 5'b0, i_instr[6:2], 2'b01, i_instr[9:7],
                              3'b101, 2'b01, i_instr[9:7], {OPCODE_OP_IMM}};
                    if (i_instr[12] == 1'b1)  illegal_instr = 1'b1;
                  end

                  2'b10: begin
                    // c.andi -> andi rd, rd, imm
                    comp_instr = {{6 {i_instr[12]}}, i_instr[12], i_instr[6:2], 2'b01, i_instr[9:7],
                              3'b111, 2'b01, i_instr[9:7], {OPCODE_OP_IMM}};
                  end

                  2'b11: begin
                    case ({i_instr[12], i_instr[6:5]})
                      3'b000: begin
                        // c.sub -> sub rd', rd', rs2'
                        comp_instr = {2'b01, 5'b0, 2'b01, i_instr[4:2], 2'b01, i_instr[9:7],
                                  3'b000, 2'b01, i_instr[9:7], {OPCODE_OP}};
                      end

                      3'b001: begin
                        // c.xor -> xor rd', rd', rs2'
                        comp_instr = {7'b0, 2'b01, i_instr[4:2], 2'b01, i_instr[9:7], 3'b100,
                                  2'b01, i_instr[9:7], {OPCODE_OP}};
                      end

                      3'b010: begin
                        // c.or  -> or  rd', rd', rs2'
                        comp_instr = {7'b0, 2'b01, i_instr[4:2], 2'b01, i_instr[9:7], 3'b110,
                                  2'b01, i_instr[9:7], {OPCODE_OP}};
                      end

                      3'b011: begin
                        // c.and -> and rd', rd', rs2'
                        comp_instr = {7'b0, 2'b01, i_instr[4:2], 2'b01, i_instr[9:7], 3'b111,
                                  2'b01, i_instr[9:7], {OPCODE_OP}};
                      end

                      3'b100,
                      3'b101,
                      3'b110,
                      3'b111: begin
                        // 100: c.subw
                        // 101: c.addw
                        illegal_instr = 1'b1;
                      end

                      default: begin
                        illegal_instr = 1'b1;
                      end
                    endcase
                  end

                  default: begin
                    illegal_instr = 1'b1;
                  end
                endcase
              end

              3'b110, 3'b111: begin
                // 0: c.beqz -> beq rs1', x0, imm
                // 1: c.bnez -> bne rs1', x0, imm
                comp_instr = {{4 {i_instr[12]}}, i_instr[6:5], i_instr[2], 5'b0, 2'b01,
                          i_instr[9:7], 2'b00, i_instr[13], i_instr[11:10], i_instr[4:3],
                          i_instr[12], {OPCODE_BRANCH}};
              end

              default: begin
                illegal_instr = 1'b1;
              end
            endcase
          end

          // C2
          //
          // Register address checks for RV32E are performed in the regular instruction decoder.
          // If this check fails, an illegal instruction exception is triggered and the controller
          // writes the actual faulting instruction to mtval.
          2'b10: begin
            case (i_instr[15:13])
              3'b000: begin
                // c.slli -> slli rd, rd, shamt
                // (c.ssli hints are translated into a slli hint)
                comp_instr = {7'b0, i_instr[6:2], i_instr[11:7], 3'b001, i_instr[11:7], {OPCODE_OP_IMM}};
                if (i_instr[12] == 1'b1)  illegal_instr = 1'b1; // reserved for custom extensions
              end

              3'b010: begin
                // c.lwsp -> lw rd, imm(x2)
                comp_instr = {4'b0, i_instr[3:2], i_instr[12], i_instr[6:4], 2'b00, 5'h02,
                          3'b010, i_instr[11:7], OPCODE_LOAD};
                if (i_instr[11:7] == 5'b0)  illegal_instr = 1'b1;
              end

              3'b100: begin
                if (i_instr[12] == 1'b0) begin
                  if (i_instr[6:2] != 5'b0) begin
                    // c.mv -> add rd/rs1, x0, rs2
                    // (c.mv hints are translated into an add hint)
                    comp_instr = {7'b0, i_instr[6:2], 5'b0, 3'b0, i_instr[11:7], {OPCODE_OP}};
                  end else begin
                    // c.jr -> jalr x0, rd/rs1, 0
                    comp_instr = {12'b0, i_instr[11:7], 3'b0, 5'b0, {OPCODE_JALR}};
                    if (i_instr[11:7] == 5'b0)  illegal_instr = 1'b1;
                  end
                end else begin
                  if (i_instr[6:2] != 5'b0) begin
                    // c.add -> add rd, rd, rs2
                    // (c.add hints are translated into an add hint)
                    comp_instr = {7'b0, i_instr[6:2], i_instr[11:7], 3'b0, i_instr[11:7], {OPCODE_OP}};
                  end else begin
                    if (i_instr[11:7] == 5'b0) begin
                      // c.ebreak -> ebreak
                      comp_instr = {32'h00_10_00_73};
                    end else begin
                      // c.jalr -> jalr x1, rs1, 0
                      comp_instr = {12'b0, i_instr[11:7], 3'b000, 5'b00001, {OPCODE_JALR}};
                    end
                  end
                end
              end

              3'b110: begin
                // c.swsp -> sw rs2, imm(x2)
                comp_instr = {4'b0, i_instr[8:7], i_instr[12], i_instr[6:2], 5'h02, 3'b010,
                          i_instr[11:9], 2'b00, {OPCODE_STORE}};
              end

              3'b001,
              3'b011,
              3'b101,
              3'b111: begin
                illegal_instr = 1'b1;
              end

              default: begin
                illegal_instr = 1'b1;
              end
            endcase
          end

          // Incoming instruction is not compressed.
          2'b11:;

          default: begin
            illegal_instr = 1'b1;
          end
        endcase
      end
      reg comp1; 
      always @(negedge i_ack) begin
        if(i_instr[1:0]==2'b11)
          comp1 = 0;
        else
          comp1 = 1;    
      end

      assign o_instr = illegal_instr ? i_instr : comp_instr;
      assign o_iscomp = comp1;

    end else begin
      assign o_instr =  i_instr;
      assign o_iscomp = 1'b0;
    end
  endgenerate



endmodule