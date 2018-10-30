`default_nettype none
module serv_ctrl
  (
   input         clk,
   input         i_en,
   input         i_jump,
   input         i_offset,
   input         i_auipc,
   output        o_rd,
   output [31:0] o_i_ca_adr,
   output reg    o_i_ca_vld = 1'b0,
   input         i_i_ca_rdy);

   parameter RESET_PC = 32'd8;
   
   wire       pc_plus_4;
   wire       pc_plus_offset;
   
   wire       plus_4;

   wire       pc;
   
   wire       new_pc;
   
   assign plus_4        = en_2r & !en_3r;

   assign o_i_ca_adr[0] = pc;
   
   ser_add ser_add_pc_plus_4
     (
      .clk (clk),
      .a   (pc),
      .b   (plus_4),
      .clr (!i_en),
      .q   (pc_plus_4));

   shift_reg
     #(
       .LEN  (32),
       .INIT (RESET_PC))
   pc_reg
     (
      .clk (clk),
      .i_en (i_en),
      .i_d  (new_pc),
      .o_q  (pc),
      .o_par (o_i_ca_adr[31:1])
      );

   assign new_pc = i_jump ? pc_plus_offset : pc_plus_4;
   assign o_rd  = i_auipc ? pc_plus_offset : pc_plus_4;
   
   ser_add ser_add_pc_plus_offset
     (
      .clk (clk),
      .a   (pc),
      .b   (i_offset),
      .clr (!i_en),
      .q   (pc_plus_offset));

   reg        en_r  = 1'b1;
   reg        en_2r = 1'b0;
   reg        en_3r = 1'b0;
   
   always @(posedge clk) begin
      en_r <= i_en;
      en_2r <= en_r;
      en_3r <= en_2r;

      if (en_r & !i_en)
        o_i_ca_vld <= 1'b1;
      else if (o_i_ca_vld & i_i_ca_rdy)
        o_i_ca_vld <= 1'b0;
   end
   
endmodule
   
