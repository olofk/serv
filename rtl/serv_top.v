`default_nettype none

`define RISCV_FORMAL_NRET 1
`define RISCV_FORMAL_XLEN 32
`define RISCV_FORMAL_ILEN 32
//`define RISCV_FORMAL_COMPRESSED
`define RISCV_FORMAL_ALIGNED_MEM

module serv_top
  (
   input             clk,
`ifdef RISCV_FORMAL
   output reg        rvfi_valid = 1'b0,
   output reg [63:0] rvfi_order = 64'd0,
   output reg [31:0] rvfi_insn = 32'd0,
   output reg        rvfi_trap = 1'b0,
   output reg        rvfi_halt = 1'b0,
   output reg        rvfi_intr = 1'b0,
   output reg [1:0]  rvfi_mode = 2'b11,
   output reg [4:0]  rvfi_rs1_addr,
   output reg [4:0]  rvfi_rs2_addr,
   output reg [31:0] rvfi_rs1_rdata,
   output reg [31:0] rvfi_rs2_rdata,
   output reg [4:0]  rvfi_rd_addr,
   output reg [31:0] rvfi_rd_wdata,
   output reg [31:0] rvfi_pc_rdata,
   output reg [31:0] rvfi_pc_wdata,
   output reg [31:0] rvfi_mem_addr,
   output reg [3:0]  rvfi_mem_rmask,
   output reg [3:0]  rvfi_mem_wmask,
   output reg [31:0] rvfi_mem_rdata,
   output reg [31:0] rvfi_mem_wdata,
`endif 
   output [31:0]     o_i_ca_adr, 
   output            o_i_ca_vld,
   input             i_i_ca_rdy,
   input [31:0]      i_i_rd_dat,
   input             i_i_rd_vld,
   output            o_i_rd_rdy,
   output            o_d_ca_cmd,
   output [31:0]     o_d_ca_adr,
   output            o_d_ca_vld,
   input             i_d_ca_rdy,
   output [31:0]     o_d_dm_dat,
   output [3:0]      o_d_dm_msk,
   output            o_d_dm_vld,
   input             i_d_dm_rdy,
   input [31:0]      i_d_rd_dat,
   input             i_d_rd_vld,
   output            o_d_rd_rdy);

`include "serv_params.vh"

   wire [4:0]    rd_addr;
   wire [4:0]    rs1_addr;
   wire [4:0]    rs2_addr;
   
   wire [1:0]    rd_source;
   wire          ctrl_rd;
   wire          alu_rd;
   wire          mem_rd;
   wire          rd;

   wire          ctrl_en;
   wire          jump;
   wire          jalr;
   wire          auipc;
   wire          offset;
   wire          offset_source;
   wire          imm;

   wire [2:0]    funct3;

   wire          alu_en;
   wire          alu_init;
   wire          alu_sub;
   wire          alu_cmp_sel;
   wire          alu_cmp_neg;
   wire          alu_cmp;
   wire          alu_shamt_en;
   wire [1:0]    alu_rd_sel;
   
   wire          rs1;
   wire          rs2;
   wire          rs_en;
   wire          rd_en;

   wire          op_b_source;
   wire          op_b;

   wire          mem_en;
   
   wire          mem_cmd;
   wire          mem_dat_valid;
   
   wire          mem_init;
   wire          mem_busy;
   
   parameter RESET_PC = 32'd8;

   serv_decode decode
     (
      .clk (clk),
      .i_i_rd_dat     (i_i_rd_dat),
      .i_i_rd_vld     (i_i_rd_vld),
      .o_i_rd_rdy     (o_i_rd_rdy),
      .o_ctrl_en      (ctrl_en),
      .o_ctrl_jump    (jump),
      .o_ctrl_jalr    (jalr),
      .o_ctrl_auipc   (auipc),
      .o_funct3       (funct3),
      .o_alu_en       (alu_en),
      .o_alu_init     (alu_init),
      .o_alu_sub      (alu_sub),
      .o_alu_cmp_sel  (alu_cmp_sel),
      .o_alu_cmp_neg  (alu_cmp_neg),
      .i_alu_cmp      (alu_cmp),
      .o_alu_shamt_en (alu_shamt_en),
      .o_alu_rd_sel   (alu_rd_sel),
      .o_rf_rd_en     (rd_en),
      .o_rf_rd_addr   (rd_addr),
      .o_rf_rs_en     (rs_en),
      .o_rf_rs1_addr  (rs1_addr),
      .o_rf_rs2_addr  (rs2_addr),
      .o_mem_en       (mem_en),
      .o_mem_cmd      (mem_cmd),
      .o_mem_init     (mem_init),
      .o_mem_dat_valid (mem_dat_valid),
      .i_mem_busy     (mem_busy),
      .o_imm          (imm),
      .o_offset_source (offset_source),
      .o_op_b_source  (op_b_source),
      .o_rd_source    (rd_source));

   serv_ctrl
     #(.RESET_PC (RESET_PC))
   ctrl
     (
      .clk        (clk),
      .i_en       (ctrl_en),
      .i_jump     (jump),
      .i_offset   (offset),
      .i_rs1      (rs1),
      .i_jalr     (jalr),
      .i_auipc    (auipc),
      .o_rd       (ctrl_rd),
      .o_i_ca_adr (o_i_ca_adr),
      .o_i_ca_vld (o_i_ca_vld),
      .i_i_ca_rdy (i_i_ca_rdy));

   assign offset = (offset_source == OFFSET_SOURCE_IMM) ? imm :
                   (offset_source == OFFSET_SOURCE_RS1) ? rs1 : 1'bx;

   assign rd = (rd_source == RD_SOURCE_CTRL) ? ctrl_rd :
               (rd_source == RD_SOURCE_ALU)  ? alu_rd  :
               (rd_source == RD_SOURCE_IMM)  ? imm     :
               (rd_source == RD_SOURCE_MEM)  ? mem_rd  : 1'bx;
   

   assign op_b = (op_b_source == OP_B_SOURCE_IMM) ? imm :
                 (op_b_source == OP_B_SOURCE_RS2) ? rs2 :
                 1'bx;
   
   serv_alu alu
     (
      .clk        (clk),
      .i_en       (alu_en),
      .i_rs1      (rs1),
      .i_op_b     (op_b),
      .i_init     (alu_init),
      .i_sub      (alu_sub),
      .i_cmp_sel  (alu_cmp_sel),
      .i_cmp_neg  (alu_cmp_neg),
      .o_cmp      (alu_cmp),
      .i_shamt_en (alu_shamt_en),
      .i_rd_sel   (alu_rd_sel),
      .o_rd       (alu_rd));

   serv_regfile regfile
     (
      .i_clk      (clk),
      .i_rd_en    (rd_en),
      .i_rd_addr  (rd_addr),
      .i_rd       (rd),
      .i_rs1_addr (rs1_addr),
      .i_rs2_addr (rs2_addr),
      .i_rs_en    (rs_en),
      .o_rs1      (rs1),
      .o_rs2      (rs2));
   
   serv_mem_if mem_if
     (
      .i_clk (clk),
      .i_en  (mem_en),
      .i_init (mem_init),
      .i_dat_valid (mem_dat_valid),
      .i_cmd (mem_cmd),
      .i_funct3 (funct3),
      .i_rs1    (rs1),
      .i_rs2    (rs2),
      .i_imm    (imm),
      .o_rd     (mem_rd),
      .o_busy   (mem_busy),
      //External interface
      .o_d_ca_cmd (o_d_ca_cmd),
      .o_d_ca_adr (o_d_ca_adr),
      .o_d_ca_vld (o_d_ca_vld),
      .i_d_ca_rdy (i_d_ca_rdy),
      .o_d_dm_dat (o_d_dm_dat),
      .o_d_dm_msk (o_d_dm_msk),
      .o_d_dm_vld (o_d_dm_vld),
      .i_d_dm_rdy (i_d_dm_rdy),
      .i_d_rd_dat (i_d_rd_dat),
      .i_d_rd_vld (i_d_rd_vld),
      .o_d_rd_rdy (o_d_rd_rdy));

`ifdef RISCV_FORMAL
   reg [31:0]    rs1_fv, rs2_fv, rd_fv;
   reg [31:0]    pc = RESET_PC;
   reg           ctrl_en_r = 1'b0;
   
   always @(posedge clk) begin
      ctrl_en_r <= ctrl_en;
      if (rs_en) begin
         rs1_fv <= {rs1,rs1_fv[31:1]};
         rs2_fv <= {rs2,rs2_fv[31:1]};
      end
      if (rd_en) begin
         rd_fv <= {rd,rd_fv[31:1]};
      end
      rvfi_valid <= 1'b0;
      if (ctrl_en_r & !ctrl_en) begin
         pc <= o_i_ca_adr;
         rvfi_valid <= 1'b1;
         rvfi_order <= rvfi_order + 1;
         rvfi_insn  <= i_i_rd_dat;
         rvfi_trap <= 1'b0;
         rvfi_halt <= 1'b0;
         rvfi_intr <= 1'b0;
         rvfi_mode <= 2'd3;
         rvfi_rs1_addr <= rs1_addr;
         rvfi_rs2_addr <= rs2_addr;
         rvfi_rs1_rdata <= rs1_fv;
         rvfi_rs2_rdata <= rs2_fv;
         rvfi_rd_addr <= rd_addr;
         rvfi_rd_wdata <= rd_fv;
         rvfi_pc_rdata <= pc;
         rvfi_pc_wdata <= o_i_ca_adr;
         rvfi_mem_addr <= o_d_ca_adr;
         rvfi_mem_rmask <= 4'bxxxx;
         rvfi_mem_wmask <= o_d_dm_msk;
         rvfi_mem_rdata <= i_d_rd_dat;
         rvfi_mem_wdata <= o_d_dm_dat;
      end
   end
`endif   
      
endmodule
