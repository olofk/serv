`default_nettype none
module serv_ctrl
  (
   input wire 	      clk,
   input wire 	      i_rst,
   input wire 	      i_en,
   input wire 	      i_pc_en,
   input wire 	      i_cnt_done,
   input wire 	      i_jump,
   input wire 	      i_offset,
   input wire 	      i_rs1,
   input wire 	      i_jalr,
   input wire 	      i_auipc,
   input wire 	      i_lui,
   input wire 	      i_trap,
   input wire 	      i_csr_pc,
   output wire 	      o_rd,
   output wire 	      o_bad_pc,
   output reg 	      o_misalign = 1'b0,
   output wire [31:0] o_ibus_adr,
   output reg 	      o_ibus_cyc,
   input wire 	      i_ibus_ack);

   parameter RESET_PC = 32'd8;

   wire       pc_plus_4;
   wire       pc_plus_offset;

   wire       plus_4;

   wire       pc;

   wire       new_pc;

   wire       offset_a;

   assign plus_4        = en_pc_2r & !en_pc_3r;

   assign o_ibus_adr[0] = pc;
   assign o_bad_pc = pc_plus_offset_aligned;

   ser_add ser_add_pc_plus_4
     (
      .clk (clk),
      .rst (i_rst),
      .a   (pc),
      .b   (plus_4),
      .clr (i_cnt_done),
      .q   (pc_plus_4),
      .o_v ());

   shift_reg
     #(
       .LEN  (32),
       .INIT (RESET_PC))
   pc_reg
     (
      .clk (clk),
      .i_en (i_pc_en),
      .i_d  (new_pc),
      .o_q  (pc),
      .o_par (o_ibus_adr[31:1])
      );

   assign new_pc = i_trap ? (i_csr_pc & en_pc_r) : i_jump ? pc_plus_offset_aligned : pc_plus_4;
   assign o_rd  = i_lui ? i_offset : i_auipc ? pc_plus_offset_aligned : pc_plus_4;

   assign offset_a = i_jalr ? i_rs1 : pc;

   ser_add ser_add_pc_plus_offset
     (
      .clk (clk),
      .rst (i_rst),
      .a   (offset_a),
      .b   (i_offset),
      .clr (!i_en | (i_cnt_done & !i_pc_en)),
      .q   (pc_plus_offset),
      .o_v ());

   wire       pc_plus_offset_aligned = pc_plus_offset & en_pc_r;


   reg        en_r;
   reg        en_2r;
   reg 	      en_pc_r;
   reg 	      en_pc_2r;
   reg 	      en_pc_3r;

   always @(posedge clk) begin
      en_r <= i_en;
      en_2r <= en_r;
      en_pc_r <= i_pc_en;
      en_pc_2r <= en_pc_r;
      en_pc_3r <= en_pc_2r;

      if (en_r & !en_2r)
	o_misalign <= pc_plus_offset;
      if (en_pc_r & !i_pc_en)
        o_ibus_cyc <= 1'b1;
      else if (o_ibus_cyc & i_ibus_ack)
        o_ibus_cyc <= 1'b0;
      if (i_rst) begin
	 en_r  <= 1'b0;
	 en_2r <= 1'b0;
	 en_pc_r <= 1'b1;
	 en_pc_2r <= 1'b0;
	 en_pc_3r <= 1'b0;
	 o_ibus_cyc <= 1'b0;
      end
   end

endmodule
