`default_nettype none

`define RISCV_FORMAL_NRET 1
`define RISCV_FORMAL_XLEN 32
`define RISCV_FORMAL_ILEN 32
//`define RISCV_FORMAL_COMPRESSED
`define RISCV_FORMAL_ALIGNED_MEM

module serv_top
  (
   input wire 	      clk,
   input wire 	      i_rst,
`ifdef RISCV_FORMAL
   output reg 	      rvfi_valid = 1'b0,
   output reg [63:0]  rvfi_order = 64'd0,
   output reg [31:0]  rvfi_insn = 32'd0,
   output reg 	      rvfi_trap = 1'b0,
   output reg 	      rvfi_halt = 1'b0,
   output reg 	      rvfi_intr = 1'b0,
   output reg [1:0]   rvfi_mode = 2'b11,
   output reg [4:0]   rvfi_rs1_addr,
   output reg [4:0]   rvfi_rs2_addr,
   output reg [31:0]  rvfi_rs1_rdata,
   output reg [31:0]  rvfi_rs2_rdata,
   output reg [4:0]   rvfi_rd_addr,
   output reg [31:0]  rvfi_rd_wdata,
   output reg [31:0]  rvfi_pc_rdata,
   output reg [31:0]  rvfi_pc_wdata,
   output reg [31:0]  rvfi_mem_addr,
   output reg [3:0]   rvfi_mem_rmask,
   output reg [3:0]   rvfi_mem_wmask,
   output reg [31:0]  rvfi_mem_rdata,
   output reg [31:0]  rvfi_mem_wdata,
`endif
   output wire [31:0] o_ibus_adr,
   output wire 	      o_ibus_cyc,
   input wire [31:0]  i_ibus_rdt,
   input wire 	      i_ibus_ack,
   output wire [31:0] o_dbus_adr,
   output wire [31:0] o_dbus_dat,
   output wire [3:0]  o_dbus_sel,
   output wire 	      o_dbus_we ,
   output wire 	      o_dbus_cyc,
   input wire [31:0]  i_dbus_rdt,
   input wire 	      i_dbus_ack);

`include "serv_params.vh"

   wire [4:0]    rd_addr;
   wire [4:0]    rs1_addr;
   wire [4:0]    rs2_addr;

   wire [1:0]    rd_source;
   wire          ctrl_rd;
   wire          alu_rd;
   wire          mem_rd;
   wire          csr_rd;
   wire          rd;

   wire          ctrl_en;
   wire          ctrl_pc_en;
   wire 	 ctrl_misalign;
   wire          jump;
   wire          jalr;
   wire          auipc;
   wire 	 mret;
   wire          imm;
   wire 	 trap;

   wire 	 cnt_done;
   wire [2:0]    funct3;

   wire          alu_en;
   wire          alu_init;
   wire          alu_sub;
   wire          alu_cmp_sel;
   wire          alu_cmp_neg;
   wire          alu_cmp_uns;
   wire          alu_cmp;
   wire          alu_shamt_en;
   wire          alu_sh_signed;
   wire          alu_sh_right;
   wire [2:0]    alu_rd_sel;

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
   wire 	 mem_misalign;

   wire 	 bad_pc;

   wire 	 csr_en;
   wire [2:0] 	 csr_sel;
   wire [1:0]	 csr_source;
   wire 	 csr_imm;
   wire 	 csr_d_sel;

   wire [3:0] 	 mcause;

   parameter RESET_PC = 32'd8;

   wire 	 lui;

   serv_decode decode
     (
      .clk (clk),
      .i_rst          (i_rst),
      .i_wb_rdt       (i_ibus_rdt),
      .i_wb_en        (o_ibus_cyc & i_ibus_ack),
      .o_cnt_done     (cnt_done),
      .o_ibus_active  (),
      .o_ctrl_en      (ctrl_en),
      .o_ctrl_pc_en   (ctrl_pc_en),
      .o_ctrl_jump    (jump),
      .o_ctrl_jalr    (jalr),
      .o_ctrl_auipc   (auipc),
      .o_ctrl_lui     (lui),
      .o_ctrl_trap    (trap),
      .o_ctrl_mret    (mret),
      .i_ctrl_misalign(ctrl_misalign),
      .o_funct3       (funct3),
      .o_alu_en       (alu_en),
      .o_alu_init     (alu_init),
      .o_alu_sub      (alu_sub),
      .o_alu_cmp_sel  (alu_cmp_sel),
      .o_alu_cmp_neg  (alu_cmp_neg),
      .o_alu_cmp_uns  (alu_cmp_uns),
      .i_alu_cmp      (alu_cmp),
      .o_alu_shamt_en (alu_shamt_en),
      .o_alu_sh_signed (alu_sh_signed),
      .o_alu_sh_right (alu_sh_right),
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
      .i_mem_dbus_ack (i_dbus_ack),
      .i_mem_misalign (mem_misalign),
      .o_csr_en       (csr_en),
      .o_csr_sel      (csr_sel),
      .o_csr_source   (csr_source),
      .o_csr_mcause   (mcause),
      .o_csr_imm      (csr_imm),
      .o_csr_d_sel    (csr_d_sel),
      .o_imm          (imm),
      .o_op_b_source  (op_b_source),
      .o_rd_source    (rd_source));

   serv_ctrl
     #(.RESET_PC (RESET_PC))
   ctrl
     (
      .clk        (clk),
      .i_rst      (i_rst),
      .i_en       (ctrl_en),
      .i_pc_en    (ctrl_pc_en),
      .i_cnt_done (cnt_done),
      .i_jump     (jump),
      .i_offset   (imm),
      .i_rs1      (rs1),
      .i_jalr     (jalr),
      .i_auipc    (auipc),
      .i_lui      (lui),
      .i_trap     (trap | mret),
      .i_csr_pc   (csr_rd),
      .o_rd       (ctrl_rd),
      .o_bad_pc   (bad_pc),
      .o_misalign (ctrl_misalign),
      .o_ibus_adr (o_ibus_adr),
      .o_ibus_cyc (o_ibus_cyc),
      .i_ibus_ack (i_ibus_ack));

   assign rd = (rd_source == RD_SOURCE_CTRL) ? ctrl_rd :
               (rd_source == RD_SOURCE_ALU)  ? alu_rd  :
               (rd_source == RD_SOURCE_MEM)  ? mem_rd  : csr_rd;

   assign op_b = (op_b_source == OP_B_SOURCE_IMM) ? imm : rs2;

   serv_alu alu
     (
      .clk        (clk),
      .i_rst      (i_rst),
      .i_en       (alu_en),
      .i_rs1      (rs1),
      .i_op_b     (op_b),
      .i_init     (alu_init),
      .i_sub      (alu_sub),
      .i_cmp_sel  (alu_cmp_sel),
      .i_cmp_neg  (alu_cmp_neg),
      .i_cmp_uns  (alu_cmp_uns),
      .o_cmp      (alu_cmp),
      .i_shamt_en (alu_shamt_en),
      .i_sh_right (alu_sh_right),
      .i_sh_signed (alu_sh_signed),
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
      .i_clk    (clk),
      .i_rst    (i_rst),
      .i_en     (mem_en),
      .i_init   (mem_init),
      .i_dat_valid (mem_dat_valid),
      .i_cmd    (mem_cmd),
      .i_funct3 (funct3),
      .i_rs1    (rs1),
      .i_rs2    (rs2),
      .i_imm    (imm),
      .o_rd     (mem_rd),
      .o_misalign (mem_misalign),
      .i_trap   (trap),
      //External interface
      .o_wb_adr   (o_dbus_adr),
      .o_wb_dat   (o_dbus_dat),
      .o_wb_sel   (o_dbus_sel),
      .o_wb_we    (o_dbus_we ),
      .o_wb_cyc   (o_dbus_cyc),
      .i_wb_rdt   (i_dbus_rdt),
      .i_wb_ack   (i_dbus_ack));

   serv_csr csr
     (
      .i_clk        (clk),
      .i_en         (csr_en),
      .i_csr_sel    (csr_sel),
      .i_csr_source (csr_source),
      .i_trap       (trap),
      .i_pc         (o_ibus_adr[0]),
      .i_mtval      (mem_misalign ? o_dbus_adr[0] : bad_pc),
      .i_mcause     (mcause),
      .i_d          (csr_d_sel ? csr_imm : rs1),
      .o_q          (csr_rd));

`ifdef RISCV_FORMAL
   reg [31:0]    rs1_fv, rs2_fv, rd_fv;
   reg [31:0]    pc = RESET_PC;
   reg           ctrl_pc_en_r = 1'b0;

   always @(posedge clk) begin
      ctrl_pc_en_r <= ctrl_pc_en;
      if (rs_en) begin
         rs1_fv <= {rs1,rs1_fv[31:1]};
         rs2_fv <= {rs2,rs2_fv[31:1]};
      end
      if (rd_en) begin
         rd_fv <= {rd,rd_fv[31:1]};
      end
      rvfi_valid <= 1'b0;
      if (ctrl_pc_en_r & !ctrl_pc_en) begin
         pc <= o_ibus_adr;
         rvfi_valid <= 1'b1;
         rvfi_order <= rvfi_order + 1;
         rvfi_insn  <= i_ibus_rdt;
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
         rvfi_pc_wdata <= o_ibus_adr;
         rvfi_mem_addr <= o_dbus_adr;
         rvfi_mem_rmask <= 4'bxxxx;
         rvfi_mem_wmask <= o_dbus_sel;
         rvfi_mem_rdata <= i_dbus_rdt;
         rvfi_mem_wdata <= o_dbus_dat;
      end
   end
`endif

endmodule
