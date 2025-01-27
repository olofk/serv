#include <fcntl.h>
#include <cstdint>
#include <csignal>
#include <iostream>
#include <fstream>
#include <memory>
#include <ctime>
#include <string>

#include "verilated_vcd_c.h"
#include "Vdecoder_sim.h"

void INThandler(int signal) {
  std::cout << "\nCaught ctrl-c\n";
  std::exit(0);
}

void test_instruction(Vdecoder_sim *top, const std::string& instr_name, uint32_t instr);
void cycle(Vdecoder_sim *top);

int main(int argc, char** argv, char** env) {
  Verilated::commandArgs(argc, argv);

  Vdecoder_sim *top = new Vdecoder_sim;
  std::signal(SIGINT, INThandler);

  top->wb_clk = 0;
  top->wb_rdt = 0;
  top->wb_en = 0;

  std::cout << "Testing decoder\n";
  test_instruction(top, "jalr", 0x0000006F);
  test_instruction(top, "mret", 0x30200073);
  test_instruction(top, "ebreak", 0x00100073);
  test_instruction(top, "wfi", 0x10500073);
  test_instruction(top, "add", 0x00000033);
  test_instruction(top, "addi", 0x00000013);
  test_instruction(top, "sub", 0x40000033);
  test_instruction(top, "and", 0x00007033);
  test_instruction(top, "andi", 0x00007013);
  test_instruction(top, "or", 0x00006033);
  test_instruction(top, "ori", 0x00006013);
  test_instruction(top, "xor", 0x00004033);
  test_instruction(top, "xori", 0x00004013);
  test_instruction(top, "sll", 0x00001033);
  test_instruction(top, "slli", 0x00001013);
  test_instruction(top, "srl", 0x00005033);
  test_instruction(top, "srli", 0x00005013);
  test_instruction(top, "sra", 0x40005033);
  test_instruction(top, "srai", 0x40005013);
  test_instruction(top, "lui", 0x00000037);
  test_instruction(top, "auipc", 0x00000017);
  test_instruction(top, "lw", 0x00002003);
  test_instruction(top, "lh", 0x00001003);
  test_instruction(top, "lhu", 0x00005003);
  test_instruction(top, "lb", 0x00000003);
  test_instruction(top, "lbu", 0x00004003);
  test_instruction(top, "sw", 0x00002023);
  test_instruction(top, "sh", 0x00001023);
  test_instruction(top, "sb", 0x00000023);
  test_instruction(top, "jal", 0x0000006F);
  test_instruction(top, "jalr", 0x00000067);
  test_instruction(top, "beq", 0x00000063);
  test_instruction(top, "bne", 0x00001063);
  test_instruction(top, "blt", 0x00004063);
  test_instruction(top, "bge", 0x00005063);
  test_instruction(top, "bltu", 0x00006063);
  test_instruction(top, "bgeu", 0x00007063);
  test_instruction(top, "slt", 0x00002033);
  test_instruction(top, "slti", 0x00002013);
  test_instruction(top, "sltu", 0x00003033);
  test_instruction(top, "sltiu", 0x00003013);
  test_instruction(top, "ecall", 0x00000073);
  test_instruction(top, "ebreak", 0x00100073);
  test_instruction(top, "fence", 0x0000000F);
  test_instruction(top, "fence.i", 0x0000100F);
  
  test_instruction(top, "csrrw", 0x00001073);
  test_instruction(top, "csrrs", 0x00002073);
  test_instruction(top, "csrrc", 0x00003073);
  test_instruction(top, "csrrwi", 0x00005073);
  test_instruction(top, "csrrsi", 0x00006073);
  test_instruction(top, "csrrci", 0x00007073);
  return 0;
}

void cycle(Vdecoder_sim *top) {
  top->eval();
  top->wb_clk = 0;
  top->eval();
  top->wb_clk = 1;
  top->eval();
}

void test_instruction(Vdecoder_sim *top, const std::string& instr_name, uint32_t instr) {
  std::ofstream outfile(instr_name + ".txt");

  std::cout << "Testing " << instr_name << "\n";
  outfile << "Testing " << instr_name << "\n";

  top->wb_rdt = instr >> 2;
  top->wb_en = 1;
  cycle(top);

  outfile << "jal_or_jalr: " << std::to_string(top->jal_or_jalr) << std::endl;
  outfile << "ebreak: " << std::to_string(top->ebreak) << std::endl;
  outfile << "mret: " << std::to_string(top->mret) << std::endl;
  outfile << "wfi: " << std::to_string(top->wfi) << std::endl;
  outfile << "sh_right: " << std::to_string(top->sh_right) << std::endl;
  outfile << "bne_or_bge: " << std::to_string(top->bne_or_bge) << std::endl;
  outfile << "cond_branch: " << std::to_string(top->cond_branch) << std::endl;
  outfile << "e_op: " << std::to_string(top->e_op) << std::endl;
  outfile << "branch_op: " << std::to_string(top->branch_op) << std::endl;
  outfile << "shift_op: " << std::to_string(top->shift_op) << std::endl;
  outfile << "slt_or_branch: " << std::to_string(top->slt_or_branch) << std::endl;
  outfile << "rd_op: " << std::to_string(top->rd_op) << std::endl;
  outfile << "two_stage_op: " << std::to_string(top->two_stage_op) << std::endl;
  outfile << "dbus_en: " << std::to_string(top->dbus_en) << std::endl;
  outfile << "mdu_op: " << std::to_string(top->mdu_op) << std::endl;
  outfile << "ext_funct3: " << std::to_string(top->ext_funct3) << std::endl;
  outfile << "bufreg_rs1_en: " << std::to_string(top->bufreg_rs1_en) << std::endl;
  outfile << "bufreg_imm_en: " << std::to_string(top->bufreg_imm_en) << std::endl;
  outfile << "bufreg_clr_lsb: " << std::to_string(top->bufreg_clr_lsb) << std::endl;
  outfile << "bufreg_sh_signed: " << std::to_string(top->bufreg_sh_signed) << std::endl;
  outfile << "ctrl_utype: " << std::to_string(top->ctrl_utype) << std::endl;
  outfile << "ctrl_pc_rel: " << std::to_string(top->ctrl_pc_rel) << std::endl;
  outfile << "alu_sub: " << std::to_string(top->alu_sub) << std::endl;
  outfile << "alu_bool_op: " << std::to_string(top->alu_bool_op) << std::endl;
  outfile << "alu_cmp_eq: " << std::to_string(top->alu_cmp_eq) << std::endl;
  outfile << "alu_cmp_sig: " << std::to_string(top->alu_cmp_sig) << std::endl;
  outfile << "alu_rd_sel: " << std::to_string(top->alu_rd_sel) << std::endl;
  outfile << "mem_signed: " << std::to_string(top->mem_signed) << std::endl;
  outfile << "mem_word: " << std::to_string(top->mem_word) << std::endl;
  outfile << "mem_half: " << std::to_string(top->mem_half) << std::endl;
  outfile << "mem_cmd: " << std::to_string(top->mem_cmd) << std::endl;
  outfile << "csr_en: " << std::to_string(top->csr_en) << std::endl;
  outfile << "csr_addr: " << std::to_string(top->csr_addr) << std::endl;
  outfile << "csr_mstatus_en: " << std::to_string(top->csr_mstatus_en) << std::endl;
  outfile << "csr_mie_en: " << std::to_string(top->csr_mie_en) << std::endl;
  outfile << "csr_mcause_en: " << std::to_string(top->csr_mcause_en) << std::endl;
  outfile << "csr_source: " << std::to_string(top->csr_source) << std::endl;
  outfile << "csr_d_sel: " << std::to_string(top->csr_d_sel) << std::endl;
  outfile << "csr_imm_en: " << std::to_string(top->csr_imm_en) << std::endl;
  outfile << "mtval_pc: " << std::to_string(top->mtval_pc) << std::endl;
  outfile << "immdec_ctrl: " << std::to_string(top->immdec_ctrl) << std::endl;
  outfile << "immdec_en: " << std::to_string(top->immdec_en) << std::endl;
  outfile << "op_b_source: " << std::to_string(top->op_b_source) << std::endl;
  outfile << "rd_mem_en: " << std::to_string(top->rd_mem_en) << std::endl;
  outfile << "rd_csr_en: " << std::to_string(top->rd_csr_en) << std::endl;
  outfile << "rd_alu_en: " << std::to_string(top->rd_alu_en) << std::endl;

  assert(!(top->wfi && instr_name != "wfi"));

  top->wb_en = 0;
  cycle(top);
  outfile.close();
}
