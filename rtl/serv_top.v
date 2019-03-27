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
   input wire 	      i_timer_irq,
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

   wire 	 rd_alu_en;
   wire 	 rd_mem_en;
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
   wire          jal_or_jalr;
   wire          utype;
   wire 	 mret;
   wire          imm;
   wire 	 trap;

   wire [4:0] 	 cnt;
   wire [3:0] 	 cnt_r;

   wire 	 cnt_done;
   wire [2:0]    funct3;

   wire 	 bufreg_hold;
   wire 	 bufreg_imm_en;
   wire 	 bufreg_loop;

   wire          alu_en;
   wire          alu_init;
   wire          alu_sub;
   wire [1:0] 	 alu_bool_op;
   wire          alu_cmp_sel;
   wire          alu_cmp_neg;
   wire          alu_cmp_uns;
   wire          alu_cmp;
   wire          alu_shamt_en;
   wire          alu_sh_signed;
   wire          alu_sh_right;
   wire 	 alu_sh_done;
   wire [1:0]    alu_rd_sel;

   wire 	 rf_ready;
   wire          rs1;
   wire          rs2;
   wire 	 rs_en;
   wire          rd_en;

   wire          op_b_source;
   wire          op_b;

   wire          mem_en;

   wire          mem_cmd;
   wire [1:0] 	 mem_bytecnt;

   wire          mem_init;
   wire 	 mem_misalign;

   wire 	 bad_pc;
   wire 	 bad_adr;

   wire 	 csr_mstatus_en;
   wire 	 csr_mie_en;
   wire 	 csr_mtvec_en;
   wire 	 csr_mip_en;
   wire 	 csr_mscratch_en;
   wire 	 csr_mepc_en;
   wire 	 csr_mcause_en;
   wire 	 csr_mtval_en;
   wire [1:0]	 csr_source;
   wire 	 csr_imm;
   wire 	 csr_d_sel;

   wire [3:0] 	 mcause;

   parameter RESET_PC = 32'd8;

   wire 	 lui;

   wire 	 timer_irq_en;

   serv_decode decode
     (
      .clk (clk),
      .i_rst          (i_rst),
      .i_mtip         (i_timer_irq),
      .i_timer_irq_en (timer_irq_en),
      .i_wb_rdt       (i_ibus_rdt),
      .i_wb_en        (o_ibus_cyc & i_ibus_ack),
      .i_rf_ready     (rf_ready | i_dbus_ack),
      .o_cnt          (cnt),
      .o_cnt_r        (cnt_r),
      .o_cnt_done     (cnt_done),
      .o_bufreg_hold  (bufreg_hold),
      .o_bufreg_imm_en (bufreg_imm_en),
      .o_bufreg_loop   (bufreg_loop),
      .o_ctrl_en      (ctrl_en),
      .o_ctrl_pc_en   (ctrl_pc_en),
      .o_ctrl_jump    (jump),
      .o_ctrl_jalr    (jalr),
      .o_ctrl_jal_or_jalr    (jal_or_jalr),
      .o_ctrl_utype   (utype),
      .o_ctrl_lui     (lui),
      .o_ctrl_trap    (trap),
      .o_ctrl_mret    (mret),
      .i_ctrl_misalign(ctrl_misalign),
      .o_funct3       (funct3),
      .o_alu_en       (alu_en),
      .o_alu_init     (alu_init),
      .o_alu_sub      (alu_sub),
      .o_alu_bool_op  (alu_bool_op),
      .o_alu_cmp_sel  (alu_cmp_sel),
      .o_alu_cmp_neg  (alu_cmp_neg),
      .o_alu_cmp_uns  (alu_cmp_uns),
      .i_alu_cmp      (alu_cmp),
      .o_alu_shamt_en (alu_shamt_en),
      .o_alu_sh_signed (alu_sh_signed),
      .o_alu_sh_right (alu_sh_right),
      .i_alu_sh_done  (alu_sh_done),
      .o_alu_rd_sel   (alu_rd_sel),
      .o_rf_rs_en     (rs_en),
      .o_rf_rd_en     (rd_en),
      .o_rf_rd_addr   (rd_addr),
      .o_rf_rs1_addr  (rs1_addr),
      .o_rf_rs2_addr  (rs2_addr),
      .o_mem_en       (mem_en),
      .o_mem_cmd      (mem_cmd),
      .o_mem_init     (mem_init),
      .o_mem_bytecnt  (mem_bytecnt),
      .i_mem_misalign (mem_misalign),
      .o_csr_mstatus_en  (csr_mstatus_en),
      .o_csr_mie_en      (csr_mie_en),
      .o_csr_mtvec_en    (csr_mtvec_en),
      .o_csr_mip_en      (csr_mip_en),
      .o_csr_mscratch_en (csr_mscratch_en),
      .o_csr_mepc_en     (csr_mepc_en),
      .o_csr_mcause_en   (csr_mcause_en),
      .o_csr_mtval_en    (csr_mtval_en),
      .o_csr_source   (csr_source),
      .o_csr_mcause   (mcause),
      .o_csr_imm      (csr_imm),
      .o_csr_d_sel    (csr_d_sel),
      .o_imm          (imm),
      .o_op_b_source  (op_b_source),
      .o_rd_alu_en    (rd_alu_en),
      .o_rd_mem_en    (rd_mem_en));

   wire [1:0] 	 lsb;
   wire [31:0] 	 bufreg_out;
   assign o_dbus_adr = {bufreg_out[31:2], 2'b00};

   serv_bufreg bufreg
     (
      .i_clk    (clk),
      .i_rst    (i_rst),
      .i_cnt    (cnt),
      .i_cnt_r  (cnt_r),
      .i_en     (!(bufreg_hold | o_dbus_cyc)),
      .i_clr    (!mem_en),
      .i_loop   (bufreg_loop),
      .i_rs1    (rs1),
      .i_rs1_en (1'b1),
      .i_imm    (imm),
      .i_imm_en (bufreg_imm_en),
      .o_lsb    (lsb),
      .o_reg    (bufreg_out),
      .o_q      (bad_adr));

   serv_ctrl
     #(.RESET_PC (RESET_PC))
   ctrl
     (
      .clk        (clk),
      .i_rst      (i_rst),
      .i_en       (ctrl_en),
      .i_pc_en    (ctrl_pc_en),
      .i_cnt      (cnt),
      .i_cnt_r    (cnt_r),
      .i_cnt_done (cnt_done),
      .i_jump     (jump),
      .i_offset   (imm),
      .i_rs1      (rs1),
      .i_jalr     (jalr),
      .i_jal_or_jalr     (jal_or_jalr),
      .i_utype    (utype),
      .i_lui      (lui),
      .i_trap     (trap | mret),
      .i_csr_pc   (csr_rd),
      .o_rd       (ctrl_rd),
      .o_bad_pc   (bad_pc),
      .o_misalign (ctrl_misalign),
      .o_ibus_adr (o_ibus_adr),
      .o_ibus_cyc (o_ibus_cyc),
      .i_ibus_ack (i_ibus_ack));

   assign rd = (ctrl_rd ) |
	       (rd_alu_en  & alu_rd ) |
	       (csr_rd ) |
	       (rd_mem_en  & mem_rd);

   assign op_b = (op_b_source == OP_B_SOURCE_IMM) ? imm : rs2;

   serv_alu alu
     (
      .clk        (clk),
      .i_rst      (i_rst),
      .i_en       (alu_en),
      .i_rs1      (rs1),
      .i_op_b     (op_b),
      .i_buf      (bad_adr), //FIXME
      .i_init     (alu_init),
      .i_cnt_done (cnt_done),
      .i_sub      (alu_sub),
      .i_bool_op  (alu_bool_op),
      .i_cmp_sel  (alu_cmp_sel),
      .i_cmp_neg  (alu_cmp_neg),
      .i_cmp_uns  (alu_cmp_uns),
      .o_cmp      (alu_cmp),
      .i_shamt_en (alu_shamt_en),
      .i_sh_right (alu_sh_right),
      .i_sh_signed (alu_sh_signed),
      .o_sh_done  (alu_sh_done),
      .i_rd_sel   (alu_rd_sel),
      .o_rd       (alu_rd));

   serv_regfile regfile
     (
      .i_clk      (clk),
      .i_rst      (i_rst),
      .i_go       (i_ibus_ack),
      .o_ready    (rf_ready),
      .i_rd_en    (rd_en),
      .i_rd_addr  (rd_addr),
      .i_rd       (rd),
      .i_rs1_addr (rs1_addr),
      .i_rs2_addr (rs2_addr),
      .o_rs1      (rs1),
      .o_rs2      (rs2));

   serv_mem_if mem_if
     (
      .i_clk    (clk),
      .i_rst    (i_rst),
      .i_en     (mem_en),
      .i_init   (mem_init),
      .i_cmd    (mem_cmd),
      .i_bytecnt (mem_bytecnt),
      .i_funct3 (funct3),
      .i_rs2    (rs2),
      .o_rd     (mem_rd),
      .i_lsb      (lsb),
      .o_misalign (mem_misalign),
      .i_trap   (trap),
      //External interface
      .o_wb_dat   (o_dbus_dat),
      .o_wb_sel   (o_dbus_sel),
      .o_wb_we    (o_dbus_we ),
      .o_wb_cyc   (o_dbus_cyc),
      .i_wb_rdt   (i_dbus_rdt),
      .i_wb_ack   (i_dbus_ack));

   serv_csr csr
     (
      .i_clk        (clk),
      .i_cnt        (cnt),
      .i_cnt_r      (cnt_r),
      .i_mtip       (i_timer_irq),
      .o_timer_irq_en ( timer_irq_en),
      .i_mstatus_en (csr_mstatus_en),
      .i_mie_en     (csr_mie_en    ),
      .i_mtvec_en   (csr_mtvec_en  ),
      .i_mip_en     (csr_mip_en    ),
      .i_mscratch_en (csr_mscratch_en),
      .i_mepc_en    (csr_mepc_en   ),
      .i_mcause_en  (csr_mcause_en ),
      .i_mtval_en   (csr_mtval_en  ),
      .i_csr_source (csr_source),
      .i_trap       (trap),
      .i_pc         (o_ibus_adr[0]),
      .i_mtval      (mem_misalign ? bad_adr : bad_pc),
      .i_mcause     (mcause),
      .i_d          (csr_d_sel ? csr_imm : rs1),
      .o_q          (csr_rd));

`ifdef RISCV_FORMAL
   reg [31:0] 	 pc = RESET_PC;

   always @(posedge clk) begin
      rvfi_valid <= cnt_done & ctrl_pc_en;
      rvfi_order <= rvfi_order + rvfi_valid;
      if (o_ibus_cyc & i_ibus_ack)
	rvfi_insn <= i_ibus_rdt;
      if (rd_en)
        rvfi_rd_wdata <= {rd,rvfi_rd_wdata[31:1]};
      if (cnt_done & ctrl_pc_en) begin
         rvfi_pc_rdata <= pc;
	 if (!rd_en)
	   rvfi_rd_addr <= 5'd0;
	 if (!rd_en | !(|rd_addr))
	   rvfi_rd_wdata <= 32'd0;
      end
      rvfi_trap <= trap;
      if (rvfi_valid) begin
         rvfi_trap <= 1'b0;
         pc <= rvfi_pc_wdata;
      end

      rvfi_halt <= 1'b0;
      rvfi_intr <= 1'b0;
      rvfi_mode <= 2'd3;
      if (rf_ready) begin
	 rvfi_rs1_addr <= rs1_addr;
         rvfi_rs2_addr <= rs2_addr;
	 rvfi_rd_addr  <= rd_addr;
      end
      if (rs_en) begin
         rvfi_rs1_rdata <= {rs1,rvfi_rs1_rdata[31:1]};
         rvfi_rs2_rdata <= {rs2,rvfi_rs2_rdata[31:1]};
      end

      if (i_dbus_ack) begin
         rvfi_mem_addr <= o_dbus_adr;
         rvfi_mem_rmask <= o_dbus_we ? 4'b0000 : o_dbus_sel;
         rvfi_mem_wmask <= o_dbus_we ? o_dbus_sel : 4'b0000;
         rvfi_mem_rdata <= i_dbus_rdt;
         rvfi_mem_wdata <= o_dbus_dat;
      end
      if (i_ibus_ack) begin
         rvfi_mem_rmask <= 4'b0000;
         rvfi_mem_wmask <= 4'b0000;
      end
   end
   always @(o_ibus_adr)
     rvfi_pc_wdata <= o_ibus_adr;

`endif

endmodule
