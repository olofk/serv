`default_nettype none
module serv_ctrl
  (
   input 	 clk,
   input 	 i_en,
   input 	 i_pc_en,
   input 	 i_cnt_done,
   input 	 i_jump,
   input 	 i_offset,
   input 	 i_rs1,
   input 	 i_jalr,
   input 	 i_auipc,
   input 	 i_trap,
   input 	 i_csr_pc,
   output 	 o_rd,
   output 	 o_bad_pc,
   output reg 	 o_misalign = 1'b0,
   output [31:0] o_ibus_adr,
   output reg 	 o_ibus_cyc = 1'b0,
   input 	 i_ibus_ack);

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
   assign o_rd  = i_auipc ? pc_plus_offset_aligned : pc_plus_4;

   assign offset_a = i_jalr ? i_rs1 : pc;

   ser_add ser_add_pc_plus_offset
     (
      .clk (clk),
      .a   (offset_a),
      .b   (i_offset),
      .clr (i_cnt_done),
      .q   (pc_plus_offset),
      .o_v ());

   wire       pc_plus_offset_aligned = pc_plus_offset & en_pc_r;


   reg        en_r  = 1'b0;
   reg        en_2r = 1'b0;
   reg        en_3r = 1'b0;
   reg 	      en_pc_r = 1'b1;
   reg 	      en_pc_2r = 1'b0;
   reg 	      en_pc_3r = 1'b0;

   always @(posedge clk) begin
      en_r <= i_en;
      en_2r <= en_r;
      en_3r <= en_2r;
      en_pc_r <= i_pc_en;
      en_pc_2r <= en_pc_r;
      en_pc_3r <= en_pc_2r;

      if (en_r & !en_2r)
	o_misalign <= pc_plus_offset;
      if (en_pc_r & !i_pc_en)
        o_ibus_cyc <= 1'b1;
      else if (o_ibus_cyc & i_ibus_ack)
        o_ibus_cyc <= 1'b0;
   end

endmodule
