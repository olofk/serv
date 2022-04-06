`default_nettype none

module serv_top
  #(parameter WITH_CSR = 1,
    parameter PRE_REGISTER = 1,
    parameter RESET_STRATEGY = "MINI",
    parameter RESET_PC = 32'd0,
    parameter [0:0] MDU = 1'b0,
    parameter COMPRESSED=0)
   (
   input wire 		      clk,
   input wire 		      i_rst,
   input wire 		      i_timer_irq,
`ifdef RISCV_FORMAL
   output reg 		      rvfi_valid = 1'b0,
   output reg [63:0] 	      rvfi_order = 64'd0,
   output reg [31:0] 	      rvfi_insn = 32'd0,
   output reg 		      rvfi_trap = 1'b0,
   output reg 		      rvfi_halt = 1'b0,
   output reg 		      rvfi_intr = 1'b0,
   output reg [1:0] 	      rvfi_mode = 2'b11,
   output reg [1:0] 	      rvfi_ixl = 2'b01,
   output reg [4:0] 	      rvfi_rs1_addr,
   output reg [4:0] 	      rvfi_rs2_addr,
   output reg [31:0] 	      rvfi_rs1_rdata,
   output reg [31:0] 	      rvfi_rs2_rdata,
   output reg [4:0] 	      rvfi_rd_addr,
   output reg [31:0] 	      rvfi_rd_wdata,
   output reg [31:0] 	      rvfi_pc_rdata,
   output reg [31:0] 	      rvfi_pc_wdata,
   output reg [31:0] 	      rvfi_mem_addr,
   output reg [3:0] 	      rvfi_mem_rmask,
   output reg [3:0] 	      rvfi_mem_wmask,
   output reg [31:0] 	      rvfi_mem_rdata,
   output reg [31:0] 	      rvfi_mem_wdata,
`endif
   //RF Interface
   output wire 		      o_rf_rreq,
   output wire 		      o_rf_wreq,
   input wire 		      i_rf_ready,
   output wire [4+WITH_CSR:0] o_wreg0,
   output wire [4+WITH_CSR:0] o_wreg1,
   output wire 		      o_wen0,
   output wire 		      o_wen1,
   output wire 		      o_wdata0,
   output wire 		      o_wdata1,
   output wire [4+WITH_CSR:0] o_rreg0,
   output wire [4+WITH_CSR:0] o_rreg1,
   input wire 		      i_rdata0,
   input wire 		      i_rdata1,

   output wire [31:0] 	      o_ibus_adr,
   output wire 		      o_ibus_cyc,
   input wire [31:0] 	      i_ibus_rdt,
   input wire 		      i_ibus_ack,
   output wire [31:0] 	      o_dbus_adr,
   output wire [31:0] 	      o_dbus_dat,
   output wire [3:0] 	      o_dbus_sel,
   output wire 		      o_dbus_we ,
   output wire 		      o_dbus_cyc,
   input wire [31:0] 	      i_dbus_rdt,
   input wire 		      i_dbus_ack,
   //Extension
   output wire [ 2:0] o_ext_funct3,
   input  wire        i_ext_ready,
   input wire  [31:0] i_ext_rd,
   output wire [31:0] o_ext_rs1,
   output wire [31:0] o_ext_rs2,
   //MDU
   output wire        o_mdu_valid);

   wire [4:0]    rd_addr;
   wire [4:0]    rs1_addr;
   wire [4:0]    rs2_addr;

   wire [3:0] 	 immdec_ctrl;
   wire [3:0] 	immdec_en;

   wire          sh_right;
   wire 	 bne_or_bge;
   wire 	 cond_branch;
   wire 	 two_stage_op;
   wire 	 e_op;
   wire 	 ebreak;
   wire 	 branch_op;
   wire 	 shift_op;
   wire 	 slt_or_branch;
   wire 	 rd_op;
   wire   mdu_op;

   wire 	 rd_alu_en;
   wire 	 rd_csr_en;
   wire 	 rd_mem_en;
   wire          ctrl_rd;
   wire          alu_rd;
   wire          mem_rd;
   wire          csr_rd;
   wire 	 mtval_pc;

   wire          ctrl_pc_en;
   wire          jump;
   wire          jal_or_jalr;
   wire          utype;
   wire 	 mret;
   wire          imm;
   wire 	 trap;
   wire 	 pc_rel;

   wire          init;
   wire          cnt_en;
   wire 	 cnt0to3;
   wire 	 cnt12to31;
   wire          cnt0;
   wire          cnt1;
   wire          cnt2;
   wire          cnt3;
   wire          cnt7;

   wire 	 cnt_done;

   wire 	 bufreg_en;
   wire          bufreg_sh_signed;
   wire 	 bufreg_rs1_en;
   wire 	 bufreg_imm_en;
   wire 	 bufreg_clr_lsb;
   wire 	 bufreg_q;
   wire 	 bufreg2_q;
   wire [31:0] dbus_rdt;
   wire        dbus_ack;

   wire          alu_sub;
   wire [1:0] 	 alu_bool_op;
   wire          alu_cmp_eq;
   wire          alu_cmp_sig;
   wire          alu_cmp;
   wire [2:0]    alu_rd_sel;

   wire          rs1;
   wire          rs2;
   wire          rd_en;

   wire          op_b;
   wire          op_b_sel;

   wire          mem_signed;
   wire          mem_word;
   wire          mem_half;
   wire [1:0] 	 mem_bytecnt;
   wire 	 sh_done;
   wire 	 sh_done_r;
   wire 	 byte_valid;

   wire 	 mem_misalign;

   wire 	 bad_pc;

   wire 	 csr_mstatus_en;
   wire 	 csr_mie_en;
   wire 	 csr_mcause_en;
   wire [1:0]	 csr_source;
   wire 	 csr_imm;
   wire 	 csr_d_sel;
   wire 	 csr_en;
   wire [1:0] 	 csr_addr;
   wire 	 csr_pc;
   wire 	 csr_imm_en;
   wire 	 csr_in;
   wire 	 rf_csr_out;
   wire 	 dbus_en;

   wire 	 new_irq;

   wire [1:0]   lsb;

  wire [31:0] i_wb_rdt;
  wire iscomp;

  serv_compdec 
    #(.COMPRESSED(COMPRESSED))
    compdec
    (.i_instr(i_ibus_rdt),
    .i_ack(i_ibus_ack),
    .o_instr(i_wb_rdt),
    .o_iscomp(iscomp));

   serv_state
     #(.RESET_STRATEGY (RESET_STRATEGY),
       .WITH_CSR (WITH_CSR),
       .MDU(MDU),
       .COMPRESSED(COMPRESSED))
   state
     (
      .i_clk (clk),
      .i_rst          (i_rst),
      //State
      .i_new_irq      (new_irq),
      .i_alu_cmp      (alu_cmp),
      .o_init         (init),
      .o_cnt_en       (cnt_en),
      .o_cnt0to3      (cnt0to3),
      .o_cnt12to31    (cnt12to31),
      .o_cnt0         (cnt0),
      .o_cnt1         (cnt1),
      .o_cnt2         (cnt2),
      .o_cnt3         (cnt3),
      .o_cnt7         (cnt7),
      .o_cnt_done     (cnt_done),
      .o_bufreg_en    (bufreg_en),
      .o_ctrl_pc_en   (ctrl_pc_en),
      .o_ctrl_jump    (jump),
      .o_ctrl_trap    (trap),
      .i_ctrl_misalign(lsb[1]),
      .i_sh_done      (sh_done),
      .i_sh_done_r    (sh_done_r),
      .o_mem_bytecnt  (mem_bytecnt),
      .i_mem_misalign (mem_misalign),
      //Control
      .i_bne_or_bge   (bne_or_bge),
      .i_cond_branch  (cond_branch),
      .i_dbus_en      (dbus_en),
      .i_two_stage_op (two_stage_op),
      .i_branch_op    (branch_op),
      .i_shift_op     (shift_op),
      .i_sh_right     (sh_right),
      .i_slt_or_branch (slt_or_branch),
      .i_e_op         (e_op),
      .i_rd_op        (rd_op),
      //MDU
      .i_mdu_op       (mdu_op),
      .o_mdu_valid    (o_mdu_valid),
      //Extension
      .i_mdu_ready    (i_ext_ready),
      //External
      .o_dbus_cyc     (o_dbus_cyc),
      .i_dbus_ack     (i_dbus_ack),
      .o_ibus_cyc     (o_ibus_cyc),
      .i_ibus_ack     (i_ibus_ack),
      //RF Interface
      .o_rf_rreq      (o_rf_rreq),
      .o_rf_wreq      (o_rf_wreq),
      .i_rf_ready     (i_rf_ready),
      .o_rf_rd_en     (rd_en));

   serv_decode
     #(.PRE_REGISTER (PRE_REGISTER),
       .MDU(MDU))
   decode
     (
      .clk (clk),
      //Input
      .i_wb_rdt           (i_wb_rdt[31:2]),
      .i_wb_en            (i_ibus_ack),
      //To state
      .o_bne_or_bge       (bne_or_bge),
      .o_cond_branch      (cond_branch),
      .o_dbus_en          (dbus_en),
      .o_e_op             (e_op),
      .o_ebreak           (ebreak),
      .o_branch_op        (branch_op),
      .o_shift_op         (shift_op),
      .o_slt_or_branch    (slt_or_branch),
      .o_rd_op            (rd_op),
      .o_sh_right         (sh_right),
      .o_mdu_op           (mdu_op),
      .o_two_stage_op     (two_stage_op),
      //Extension
      .o_ext_funct3       (o_ext_funct3),

      //To bufreg
      .o_bufreg_rs1_en    (bufreg_rs1_en),
      .o_bufreg_imm_en    (bufreg_imm_en),
      .o_bufreg_clr_lsb   (bufreg_clr_lsb),
      .o_bufreg_sh_signed (bufreg_sh_signed),
      //To bufreg2
      .o_op_b_source      (op_b_sel),
      //To ctrl
      .o_ctrl_jal_or_jalr (jal_or_jalr),
      .o_ctrl_utype       (utype),
      .o_ctrl_pc_rel      (pc_rel),
      .o_ctrl_mret        (mret),
      //To alu
      .o_alu_sub          (alu_sub),
      .o_alu_bool_op      (alu_bool_op),
      .o_alu_cmp_eq       (alu_cmp_eq),
      .o_alu_cmp_sig      (alu_cmp_sig),
      .o_alu_rd_sel       (alu_rd_sel),
      //To mem IF
      .o_mem_cmd          (o_dbus_we),
      .o_mem_signed       (mem_signed),
      .o_mem_word         (mem_word),
      .o_mem_half         (mem_half),
      //To CSR
      .o_csr_en           (csr_en),
      .o_csr_addr         (csr_addr),
      .o_csr_mstatus_en   (csr_mstatus_en),
      .o_csr_mie_en       (csr_mie_en),
      .o_csr_mcause_en    (csr_mcause_en),
      .o_csr_source       (csr_source),
      .o_csr_d_sel        (csr_d_sel),
      .o_csr_imm_en       (csr_imm_en),
      .o_mtval_pc         (mtval_pc      ),
      //To top
      .o_immdec_ctrl      (immdec_ctrl),
      .o_immdec_en        (immdec_en),
      //To RF IF
      .o_rd_mem_en        (rd_mem_en),
      .o_rd_csr_en        (rd_csr_en),
      .o_rd_alu_en        (rd_alu_en));

   serv_immdec immdec
     (
      .i_clk        (clk),
      //State
      .i_cnt_en     (cnt_en),
      .i_cnt_done   (cnt_done),
      //Control
      .i_immdec_en        (immdec_en),
      .i_csr_imm_en (csr_imm_en),
      .i_ctrl       (immdec_ctrl),
      .o_rd_addr    (rd_addr),
      .o_rs1_addr   (rs1_addr),
      .o_rs2_addr   (rs2_addr),
      //Data
      .o_csr_imm    (csr_imm),
      .o_imm        (imm),
      //External
      .i_wb_en      (i_ibus_ack),
      .i_wb_rdt     (i_wb_rdt[31:7]));

   serv_bufreg
      #(.MDU(MDU))
   bufreg
     (
      .i_clk    (clk),
      //State
      .i_cnt0   (cnt0),
      .i_cnt1   (cnt1),
      .i_en     (bufreg_en),
      .i_init   (init),
      .i_mdu_op (mdu_op),
      .o_lsb    (lsb),
      //Control
      .i_sh_signed (bufreg_sh_signed),
      .i_rs1_en    (bufreg_rs1_en),
      .i_imm_en    (bufreg_imm_en),
      .i_clr_lsb   (bufreg_clr_lsb),
      //Data
      .i_rs1    (rs1),
      .i_imm    (imm),
      .o_q      (bufreg_q),
      //External
      .o_dbus_adr (o_dbus_adr),
      .o_ext_rs1  (o_ext_rs1));

   serv_bufreg2 bufreg2
     (
      .i_clk        (clk),
      //State
      .i_en         (cnt_en),
      .i_init       (init),
      .i_cnt_done   (cnt_done),
      .i_lsb        (lsb),
      .i_byte_valid (byte_valid),
      .o_sh_done    (sh_done),
      .o_sh_done_r  (sh_done_r),
      //Control
      .i_op_b_sel   (op_b_sel),
      .i_shift_op   (shift_op),
      //Data
      .i_rs2        (rs2),
      .i_imm        (imm),
      .o_op_b       (op_b),
      .o_q          (bufreg2_q),
      //External
      .o_dat        (o_dbus_dat),
      .i_load       (dbus_ack),
      .i_dat        (dbus_rdt));

   serv_ctrl
     #(.RESET_PC (RESET_PC),
       .RESET_STRATEGY (RESET_STRATEGY),
       .WITH_CSR (WITH_CSR))
   ctrl
     (
      .clk        (clk),
      .i_rst      (i_rst),
      //State
      .i_pc_en    (ctrl_pc_en),
      .i_cnt12to31 (cnt12to31),
      .i_cnt0     (cnt0),
      .i_cnt1     (cnt1),
      .i_cnt2     (cnt2),
      //Control
      .i_jump     (jump),
      .i_jal_or_jalr (jal_or_jalr),
      .i_utype    (utype),
      .i_pc_rel   (pc_rel),
      .i_trap     (trap | mret),
      .i_iscomp    (iscomp),
      //Data
      .i_imm      (imm),
      .i_buf      (bufreg_q),
      .i_csr_pc   (csr_pc),
      .o_rd       (ctrl_rd),
      .o_bad_pc   (bad_pc),
      //External
      .o_ibus_adr (o_ibus_adr));

   serv_alu alu
     (
      .clk        (clk),
      //State
      .i_en       (cnt_en),
      .i_cnt0     (cnt0),
      .o_cmp      (alu_cmp),
      //Control
      .i_sub      (alu_sub),
      .i_bool_op  (alu_bool_op),
      .i_cmp_eq   (alu_cmp_eq),
      .i_cmp_sig  (alu_cmp_sig),
      .i_rd_sel   (alu_rd_sel),
      //Data
      .i_rs1      (rs1),
      .i_op_b     (op_b),
      .i_buf      (bufreg_q),
      .o_rd       (alu_rd));

   serv_rf_if
     #(.WITH_CSR (WITH_CSR))
   rf_if
     (//RF interface
      .i_cnt_en    (cnt_en),
      .o_wreg0     (o_wreg0),
      .o_wreg1     (o_wreg1),
      .o_wen0      (o_wen0),
      .o_wen1      (o_wen1),
      .o_wdata0    (o_wdata0),
      .o_wdata1    (o_wdata1),
      .o_rreg0     (o_rreg0),
      .o_rreg1     (o_rreg1),
      .i_rdata0    (i_rdata0),
      .i_rdata1    (i_rdata1),

      //Trap interface
      .i_trap      (trap),
      .i_mret      (mret),
      .i_mepc      (o_ibus_adr[0]),
      .i_mtval_pc  (mtval_pc),
      .i_bufreg_q  (bufreg_q),
      .i_bad_pc    (bad_pc),
      .o_csr_pc    (csr_pc),
      //CSR write port
      .i_csr_en    (csr_en),
      .i_csr_addr  (csr_addr),
      .i_csr       (csr_in),
      //RD write port
      .i_rd_wen    (rd_en),
      .i_rd_waddr  (rd_addr),
      .i_ctrl_rd   (ctrl_rd),
      .i_alu_rd    (alu_rd),
      .i_rd_alu_en (rd_alu_en),
      .i_csr_rd    (csr_rd),
      .i_rd_csr_en (rd_csr_en),
      .i_mem_rd    (mem_rd),
      .i_rd_mem_en (rd_mem_en),

      //RS1 read port
      .i_rs1_raddr (rs1_addr),
      .o_rs1       (rs1),
      //RS2 read port
      .i_rs2_raddr (rs2_addr),
      .o_rs2       (rs2),

      //CSR read port
      .o_csr       (rf_csr_out));

   serv_mem_if
     #(.WITH_CSR (WITH_CSR))
   mem_if
     (
      .i_clk        (clk),
      //State
      .i_bytecnt    (mem_bytecnt),
      .i_lsb        (lsb),
      .o_byte_valid (byte_valid),
      .o_misalign   (mem_misalign),
      //Control
      .i_mdu_op     (mdu_op),
      .i_signed     (mem_signed),
      .i_word       (mem_word),
      .i_half       (mem_half),
      //Data
      .i_bufreg2_q  (bufreg2_q),
      .o_rd         (mem_rd),
      //External interface
      .o_wb_sel     (o_dbus_sel));

   generate
      if (WITH_CSR) begin
	 serv_csr
	   #(.RESET_STRATEGY (RESET_STRATEGY))
	 csr
	   (
	    .i_clk        (clk),
	    .i_rst        (i_rst),
	    //State
	    .i_init       (init),
	    .i_en         (cnt_en),
	    .i_cnt0to3    (cnt0to3),
	    .i_cnt3       (cnt3),
	    .i_cnt7       (cnt7),
	    .i_cnt_done   (cnt_done),
	    .i_mem_op     (!mtval_pc),
	    .i_mtip       (i_timer_irq),
	    .i_trap       (trap),
	    .o_new_irq    (new_irq),
	    //Control
	    .i_e_op       (e_op),
	    .i_ebreak     (ebreak),
	    .i_mem_cmd    (o_dbus_we),
	    .i_mstatus_en (csr_mstatus_en),
	    .i_mie_en     (csr_mie_en    ),
	    .i_mcause_en  (csr_mcause_en ),
	    .i_csr_source (csr_source),
	    .i_mret       (mret),
	    .i_csr_d_sel  (csr_d_sel),
	    //Data
	    .i_rf_csr_out (rf_csr_out),
	    .o_csr_in     (csr_in),
	    .i_csr_imm    (csr_imm),
	    .i_rs1        (rs1),
	    .o_q          (csr_rd));
      end else begin
	 assign csr_in = 1'b0;
	 assign csr_rd = 1'b0;
	 assign new_irq = 1'b0;
      end
   endgenerate


`ifdef RISCV_FORMAL
   reg [31:0] 	 pc = RESET_PC;

   wire rs_en = two_stage_op ? init : ctrl_pc_en;

   always @(posedge clk) begin
      /* End of instruction */
      rvfi_valid <= cnt_done & ctrl_pc_en & !i_rst;
      rvfi_order <= rvfi_order + {63'd0,rvfi_valid};

      /* Get instruction word when it's fetched from ibus */
      if (o_ibus_cyc & i_ibus_ack)
	rvfi_insn <= i_wb_rdt;

      /* Store data written to rd */
      if (o_wen0)
        rvfi_rd_wdata <= {o_wdata0,rvfi_rd_wdata[31:1]};

      if (cnt_done & ctrl_pc_en) begin
         rvfi_pc_rdata <= pc;
	 if (!(rd_en & (|rd_addr))) begin
	   rvfi_rd_addr <= 5'd0;
	   rvfi_rd_wdata <= 32'd0;
	 end
      end
      rvfi_trap <= trap;
      if (rvfi_valid) begin
         rvfi_trap <= 1'b0;
         pc <= rvfi_pc_wdata;
      end

      /* Not used */
      rvfi_halt <= 1'b0;
      rvfi_intr <= 1'b0;
      rvfi_mode <= 2'd3;
      rvfi_ixl = 2'd1;

      /* RS1 not valid during J, U instructions (immdec_en[1]) */
      /* RS2 not valid during I, J, U instructions (immdec_en[2]) */
      if (i_rf_ready) begin
	 rvfi_rs1_addr <= !immdec_en[1] ? rs1_addr : 5'd0;
         rvfi_rs2_addr <= !immdec_en[2] /*rs2_valid*/ ? rs2_addr : 5'd0;
	 rvfi_rd_addr  <= rd_addr;
      end
      if (rs_en) begin
         rvfi_rs1_rdata <= {!immdec_en[1] & rs1,rvfi_rs1_rdata[31:1]};
         rvfi_rs2_rdata <= {!immdec_en[2] & rs2,rvfi_rs2_rdata[31:1]};
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
   /* verilator lint_off COMBDLY */
   always @(o_ibus_adr)
     rvfi_pc_wdata <= o_ibus_adr;
   /* verilator lint_on COMBDLY */


`endif

generate
  if (MDU) begin
    assign dbus_rdt = i_ext_ready ? i_ext_rd:i_dbus_rdt;
    assign dbus_ack = i_dbus_ack | i_ext_ready;
  end else begin
    assign dbus_rdt = i_dbus_rdt;
    assign dbus_ack = i_dbus_ack;
  end
  assign o_ext_rs2 = o_dbus_dat;
endgenerate

endmodule
`default_nettype wire
