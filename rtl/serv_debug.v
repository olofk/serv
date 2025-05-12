/*
 * serv_debug.v : SERV module for introspecting CPU/RF state during simulations
 *
 * SPDX-FileCopyrightText: 2024 Olof Kindgren <olof@award-winning.me>
 * SPDX-License-Identifier: ISC
 */
module serv_debug
  #(parameter W = 1,
    parameter RESET_PC = 0,
    //Internally calculated. Do not touch
    parameter B=W-1)
   (
`ifdef RISCV_FORMAL
    output reg	      rvfi_valid = 1'b0,
    output reg [63:0]  rvfi_order = 64'd0,
    output reg [31:0]  rvfi_insn = 32'd0,
    output reg	      rvfi_trap = 1'b0,
    output reg	      rvfi_halt = 1'b0,  // Not used
    output reg	      rvfi_intr = 1'b0,  // Not used
    output reg [1:0]   rvfi_mode = 2'b11, // Not used
    output reg [1:0]   rvfi_ixl = 2'b01,  // Not used
    output reg [4:0]   rvfi_rs1_addr,
    output reg [4:0]   rvfi_rs2_addr,
    output reg [31:0]  rvfi_rs1_rdata,
    output reg [31:0]  rvfi_rs2_rdata,
    output reg [4:0]   rvfi_rd_addr,
    output wire [31:0] rvfi_rd_wdata,
    output reg [31:0]  rvfi_pc_rdata,
    output wire [31:0]  rvfi_pc_wdata,
    output reg [31:0]  rvfi_mem_addr,
    output reg [3:0]   rvfi_mem_rmask,
    output reg [3:0]   rvfi_mem_wmask,
    output reg [31:0]  rvfi_mem_rdata,
    output reg [31:0]  rvfi_mem_wdata,
    input wire [31:0]  i_dbus_adr,
    input wire [31:0]  i_dbus_dat,
    input wire [3:0]   i_dbus_sel,
    input wire	      i_dbus_we,
    input wire [31:0]  i_dbus_rdt,
    input wire	      i_dbus_ack,
    input wire	      i_ctrl_pc_en,
    input wire	[B:0]      rs1,
    input wire [B:0]	      rs2,
    input wire [4:0]   rs1_addr,
    input wire [4:0]   rs2_addr,
    input wire [3:0]   immdec_en,
    input wire	      rd_en,
    input wire	      trap,
    input wire	      i_rf_ready,
    input wire	      i_ibus_cyc,
    input wire	      two_stage_op,
    input wire	      init,
    input wire [31:0]  i_ibus_adr,
`endif
    input wire	      i_clk,
    input wire	      i_rst,
    input wire [31:0] i_ibus_rdt,
    input wire	      i_ibus_ack,
    input wire [4:0]  i_rd_addr,
    input wire	      i_cnt_en,
    input wire [B:0]  i_csr_in,
    input wire	      i_csr_mstatus_en,
    input wire	      i_csr_mie_en,
    input wire	      i_csr_mcause_en,
    input wire	      i_csr_en,
    input wire [1:0]  i_csr_addr,
    input wire	      i_wen0,
    input wire [B:0]  i_wdata0,
    input wire	      i_cnt_done);

   reg		      update_rd = 1'b0;
   reg		      update_mscratch;
   reg		      update_mtvec;
   reg		      update_mepc;
   reg		      update_mtval;
   reg		      update_mstatus;
   reg		      update_mie;
   reg		      update_mcause;

   reg [31:0]	      dbg_rd = 32'hxxxxxxxx;
   reg [31:0]	      dbg_csr = 32'hxxxxxxxx;
   reg [31:0]	      dbg_mstatus  = 32'hxxxxxxxx;
   reg [31:0]	      dbg_mie      = 32'hxxxxxxxx;
   reg [31:0]	      dbg_mcause   = 32'hxxxxxxxx;
   reg [31:0]	      dbg_mscratch = 32'hxxxxxxxx;
   reg [31:0]	      dbg_mtvec    = 32'hxxxxxxxx;
   reg [31:0]	      dbg_mepc     = 32'hxxxxxxxx;
   reg [31:0]	      dbg_mtval    = 32'hxxxxxxxx;
   reg [31:0]	      x1  = 32'hxxxxxxxx;
   reg [31:0]	      x2  = 32'hxxxxxxxx;
   reg [31:0]	      x3  = 32'hxxxxxxxx;
   reg [31:0]	      x4  = 32'hxxxxxxxx;
   reg [31:0]	      x5  = 32'hxxxxxxxx;
   reg [31:0]	      x6  = 32'hxxxxxxxx;
   reg [31:0]	      x7  = 32'hxxxxxxxx;
   reg [31:0]	      x8  = 32'hxxxxxxxx;
   reg [31:0]	      x9  = 32'hxxxxxxxx;
   reg [31:0]	      x10 = 32'hxxxxxxxx;
   reg [31:0]	      x11 = 32'hxxxxxxxx;
   reg [31:0]	      x12 = 32'hxxxxxxxx;
   reg [31:0]	      x13 = 32'hxxxxxxxx;
   reg [31:0]	      x14 = 32'hxxxxxxxx;
   reg [31:0]	      x15 = 32'hxxxxxxxx;
   reg [31:0]	      x16 = 32'hxxxxxxxx;
   reg [31:0]	      x17 = 32'hxxxxxxxx;
   reg [31:0]	      x18 = 32'hxxxxxxxx;
   reg [31:0]	      x19 = 32'hxxxxxxxx;
   reg [31:0]	      x20 = 32'hxxxxxxxx;
   reg [31:0]	      x21 = 32'hxxxxxxxx;
   reg [31:0]	      x22 = 32'hxxxxxxxx;
   reg [31:0]	      x23 = 32'hxxxxxxxx;
   reg [31:0]	      x24 = 32'hxxxxxxxx;
   reg [31:0]	      x25 = 32'hxxxxxxxx;
   reg [31:0]	      x26 = 32'hxxxxxxxx;
   reg [31:0]	      x27 = 32'hxxxxxxxx;
   reg [31:0]	      x28 = 32'hxxxxxxxx;
   reg [31:0]	      x29 = 32'hxxxxxxxx;
   reg [31:0]	      x30 = 32'hxxxxxxxx;
   reg [31:0]	      x31 = 32'hxxxxxxxx;

   always @(posedge i_clk) begin
      update_rd <= i_cnt_done & i_wen0;

      if (i_wen0)
        dbg_rd <= {i_wdata0,dbg_rd[31:W]};

      //End of instruction that writes to RF
      if (update_rd) begin
	 case (i_rd_addr)
	   5'd1  : x1  <= dbg_rd;
	   5'd2  : x2  <= dbg_rd;
	   5'd3  : x3  <= dbg_rd;
	   5'd4  : x4  <= dbg_rd;
	   5'd5  : x5  <= dbg_rd;
	   5'd6  : x6  <= dbg_rd;
	   5'd7  : x7  <= dbg_rd;
	   5'd8  : x8  <= dbg_rd;
	   5'd9  : x9  <= dbg_rd;
	   5'd10 : x10 <= dbg_rd;
	   5'd11 : x11 <= dbg_rd;
	   5'd12 : x12 <= dbg_rd;
	   5'd13 : x13 <= dbg_rd;
	   5'd14 : x14 <= dbg_rd;
	   5'd15 : x15 <= dbg_rd;
	   5'd16 : x16 <= dbg_rd;
	   5'd17 : x17 <= dbg_rd;
	   5'd18 : x18 <= dbg_rd;
	   5'd19 : x19 <= dbg_rd;
	   5'd20 : x20 <= dbg_rd;
	   5'd21 : x21 <= dbg_rd;
	   5'd22 : x22 <= dbg_rd;
	   5'd23 : x23 <= dbg_rd;
	   5'd24 : x24 <= dbg_rd;
	   5'd25 : x25 <= dbg_rd;
	   5'd26 : x26 <= dbg_rd;
	   5'd27 : x27 <= dbg_rd;
	   5'd28 : x28 <= dbg_rd;
	   5'd29 : x29 <= dbg_rd;
	   5'd30 : x30 <= dbg_rd;
	   5'd31 : x31 <= dbg_rd;
	   default : ;
	 endcase
      end

      update_mscratch <= i_cnt_done & i_csr_en & (i_csr_addr == 2'b00);
      update_mtvec    <= i_cnt_done & i_csr_en & (i_csr_addr == 2'b01);
      update_mepc     <= i_cnt_done & i_csr_en & (i_csr_addr == 2'b10);
      update_mtval    <= i_cnt_done & i_csr_en & (i_csr_addr == 2'b11);
      update_mstatus  <= i_cnt_done & i_csr_mstatus_en;
      update_mie      <= i_cnt_done & i_csr_mie_en;
      update_mcause   <= i_cnt_done & i_csr_mcause_en;

      if (i_cnt_en)
	dbg_csr <= {i_csr_in, dbg_csr[31:W]};

      if (update_mscratch) dbg_mscratch <= dbg_csr;
      if (update_mtvec)    dbg_mtvec    <= dbg_csr;
      if (update_mepc )    dbg_mepc     <= dbg_csr;
      if (update_mtval)    dbg_mtval    <= dbg_csr;
      if (update_mstatus)  dbg_mstatus  <= dbg_csr;
      if (update_mie)      dbg_mie      <= dbg_csr;
      if (update_mcause)   dbg_mcause   <= dbg_csr;
   end

   reg LUI, AUIPC, JAL, JALR, BEQ, BNE, BLT, BGE, BLTU, BGEU, LB, LH, LW, LBU, LHU, SB, SH, SW, ADDI, SLTI, SLTIU, XORI, ORI, ANDI,SLLI, SRLI, SRAI, ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND, FENCE, ECALL, EBREAK, WFI;
   reg CSRRW, CSRRS, CSRRC, CSRRWI, CSRRSI, CSRRCI;
   reg OTHER;

   always @(posedge i_clk) begin
      if (i_ibus_ack) begin
	 LUI    <= 1'b0;
	 AUIPC  <= 1'b0;
	 JAL    <= 1'b0;
	 JALR   <= 1'b0;
	 BEQ    <= 1'b0;
	 BNE    <= 1'b0;
	 BLT    <= 1'b0;
	 BGE    <= 1'b0;
	 BLTU   <= 1'b0;
	 BGEU   <= 1'b0;
	 LB     <= 1'b0;
	 LH     <= 1'b0;
	 LW     <= 1'b0;
	 LBU    <= 1'b0;
	 LHU    <= 1'b0;
	 SB     <= 1'b0;
	 SH     <= 1'b0;
	 SW     <= 1'b0;
	 ADDI   <= 1'b0;
	 SLTI   <= 1'b0;
	 SLTIU  <= 1'b0;
	 XORI   <= 1'b0;
	 ORI    <= 1'b0;
	 ANDI   <= 1'b0;
	 SLLI   <= 1'b0;
	 SRLI   <= 1'b0;
	 SRAI   <= 1'b0;
	 ADD    <= 1'b0;
	 SUB    <= 1'b0;
	 SLL    <= 1'b0;
	 SLT    <= 1'b0;
	 SLTU   <= 1'b0;
	 XOR    <= 1'b0;
	 SRL    <= 1'b0;
	 SRA    <= 1'b0;
	 OR     <= 1'b0;
	 AND    <= 1'b0;
	 FENCE  <= 1'b0;
	 ECALL  <= 1'b0;
	 EBREAK <= 1'b0;
	 WFI    <= 1'b0;
	 CSRRW  <= 1'b0;
	 CSRRS  <= 1'b0;
	 CSRRC  <= 1'b0;
	 CSRRWI <= 1'b0;
	 CSRRSI <= 1'b0;
	 CSRRCI <= 1'b0;
	 OTHER  <= 1'b0;

	 casez(i_ibus_rdt)
	   //  3322222_22222 11111_111 11
	   //  1098765_43210 98765_432 10987_65432_10
	   32'b???????_?????_?????_???_?????_01101_11 : LUI    <= 1'b1;
	   32'b???????_?????_?????_???_?????_00101_11 : AUIPC  <= 1'b1;
	   32'b???????_?????_?????_???_?????_11011_11 : JAL    <= 1'b1;
	   32'b???????_?????_?????_000_?????_11001_11 : JALR   <= 1'b1;
	   32'b???????_?????_?????_000_?????_11000_11 : BEQ    <= 1'b1;
	   32'b???????_?????_?????_001_?????_11000_11 : BNE    <= 1'b1;
	   32'b???????_?????_?????_100_?????_11000_11 : BLT    <= 1'b1;
	   32'b???????_?????_?????_101_?????_11000_11 : BGE    <= 1'b1;
	   32'b???????_?????_?????_110_?????_11000_11 : BLTU   <= 1'b1;
	   32'b???????_?????_?????_111_?????_11000_11 : BGEU   <= 1'b1;
	   32'b???????_?????_?????_000_?????_00000_11 : LB     <= 1'b1;
	   32'b???????_?????_?????_001_?????_00000_11 : LH     <= 1'b1;
	   32'b???????_?????_?????_010_?????_00000_11 : LW     <= 1'b1;
	   32'b???????_?????_?????_100_?????_00000_11 : LBU    <= 1'b1;
	   32'b???????_?????_?????_101_?????_00000_11 : LHU    <= 1'b1;
	   32'b???????_?????_?????_000_?????_01000_11 : SB     <= 1'b1;
	   32'b???????_?????_?????_001_?????_01000_11 : SH     <= 1'b1;
	   32'b???????_?????_?????_010_?????_01000_11 : SW     <= 1'b1;
	   32'b???????_?????_?????_000_?????_00100_11 : ADDI   <= 1'b1;
	   32'b???????_?????_?????_010_?????_00100_11 : SLTI   <= 1'b1;
	   32'b???????_?????_?????_011_?????_00100_11 : SLTIU  <= 1'b1;
	   32'b???????_?????_?????_100_?????_00100_11 : XORI   <= 1'b1;
	   32'b???????_?????_?????_110_?????_00100_11 : ORI    <= 1'b1;
	   32'b???????_?????_?????_111_?????_00100_11 : ANDI   <= 1'b1;
	   32'b0000000_?????_?????_001_?????_00100_11 : SLLI   <= 1'b1;
	   32'b0000000_?????_?????_101_?????_00100_11 : SRLI   <= 1'b1;
	   32'b0100000_?????_?????_101_?????_00100_11 : SRAI   <= 1'b1;
	   32'b0000000_?????_?????_000_?????_01100_11 : ADD    <= 1'b1;
	   32'b0100000_?????_?????_000_?????_01100_11 : SUB    <= 1'b1;
	   32'b0000000_?????_?????_001_?????_01100_11 : SLL    <= 1'b1;
	   32'b0000000_?????_?????_010_?????_01100_11 : SLT    <= 1'b1;
	   32'b0000000_?????_?????_011_?????_01100_11 : SLTU   <= 1'b1;
	   32'b???????_?????_?????_100_?????_01100_11 : XOR    <= 1'b1;
	   32'b0000000_?????_?????_101_?????_01100_11 : SRL    <= 1'b1;
	   32'b0100000_?????_?????_101_?????_01100_11 : SRA    <= 1'b1;
	   32'b???????_?????_?????_110_?????_01100_11 : OR     <= 1'b1;
	   32'b???????_?????_?????_111_?????_01100_11 : AND    <= 1'b1;
	   32'b???????_?????_?????_000_?????_00011_11 : FENCE  <= 1'b1;
	   32'b0000000_00000_00000_000_00000_11100_11 : ECALL  <= 1'b1;
	   32'b0000000_00001_00000_000_00000_11100_11 : EBREAK <= 1'b1;
	   32'b0001000_00010_00000_000_00000_11100_11 : WFI    <= 1'b1;
	   32'b???????_?????_?????_001_?????_11100_11 : CSRRW  <= 1'b1;
	   32'b???????_?????_?????_010_?????_11100_11 : CSRRS  <= 1'b1;
	   32'b???????_?????_?????_011_?????_11100_11 : CSRRC  <= 1'b1;
	   32'b???????_?????_?????_101_?????_11100_11 : CSRRWI <= 1'b1;
	   32'b???????_?????_?????_110_?????_11100_11 : CSRRSI <= 1'b1;
	   32'b???????_?????_?????_111_?????_11100_11 : CSRRCI <= 1'b1;
 	   default : OTHER <= 1'b1;
	 endcase
      end
   end

`ifdef RISCV_FORMAL
   reg [31:0] 	 pc = RESET_PC;

   wire rs_en = two_stage_op ? init : i_ctrl_pc_en;

   assign rvfi_rd_wdata = update_rd ? dbg_rd : 32'd0;

   always @(posedge i_clk) begin
      /* End of instruction */
      rvfi_valid <= i_cnt_done & i_ctrl_pc_en & !i_rst;
      rvfi_order <= rvfi_order + {63'd0,rvfi_valid};

      /* Get instruction word when it's fetched from ibus */
      if (i_ibus_cyc & i_ibus_ack)
	rvfi_insn <= i_ibus_rdt;


      if (i_cnt_done & i_ctrl_pc_en) begin
         rvfi_pc_rdata <= pc;
	 if (!(rd_en & (|i_rd_addr))) begin
	   rvfi_rd_addr <= 5'd0;
	 end
      end
      rvfi_trap <= trap;
      if (rvfi_valid) begin
         rvfi_trap <= 1'b0;
         pc <= rvfi_pc_wdata;
      end

      /* RS1 not valid during J, U instructions (immdec_en[1]) */
      /* RS2 not valid during I, J, U instructions (immdec_en[2]) */
      if (i_rf_ready) begin
	 rvfi_rs1_addr <= !immdec_en[1] ? rs1_addr : 5'd0;
         rvfi_rs2_addr <= !immdec_en[2] /*rs2_valid*/ ? rs2_addr : 5'd0;
	 rvfi_rd_addr  <= i_rd_addr;
      end
      if (rs_en) begin
         rvfi_rs1_rdata <= {(!immdec_en[1] ? rs1 : {W{1'b0}}),rvfi_rs1_rdata[31:W]};
         rvfi_rs2_rdata <= {(!immdec_en[2] ? rs2 : {W{1'b0}}),rvfi_rs2_rdata[31:W]};
      end

      if (i_dbus_ack) begin
         rvfi_mem_addr  <= i_dbus_adr;
         rvfi_mem_rmask <= i_dbus_we ? 4'b0000 : i_dbus_sel;
         rvfi_mem_wmask <= i_dbus_we ? i_dbus_sel : 4'b0000;
         rvfi_mem_rdata <= i_dbus_rdt;
         rvfi_mem_wdata <= i_dbus_dat;
      end
      if (i_ibus_ack) begin
         rvfi_mem_rmask <= 4'b0000;
         rvfi_mem_wmask <= 4'b0000;
      end
   end

   assign rvfi_pc_wdata = i_ibus_adr;

`endif

endmodule
