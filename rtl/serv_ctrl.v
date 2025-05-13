`default_nettype none
module serv_ctrl
  #(parameter RESET_STRATEGY = "MINI",
    parameter RESET_PC = 32'd0,
    parameter WITH_CSR = 1,
    parameter W = 1,
    parameter B = W-1
  )
  (
   input wire 	     clk,
   input wire 	     i_rst,
   //State
   input wire 	     i_pc_en,
   input wire 	     i_cnt12to15,
   input wire 	     i_cnt16to31,
   input wire 	     i_cnt0,
   input wire        i_cnt1,
   input wire 	     i_cnt2,
   //Control
   input wire 	     i_jump,
   input wire 	     i_jal_or_jalr,
   input wire 	     i_utype,
   input wire 	     i_pc_rel,
   input wire 	     i_trap,
   input wire        i_iscomp,
   //Data
   input wire [B:0] i_imm,
   input wire [B:0] i_buf,
   input wire [B:0] i_csr_pc,
   output wire [B:0] o_rd,
   output wire [B:0] o_bad_pc,
   //External
   output reg [31:0] o_ibus_adr);

   wire [B:0] pc_plus_4;
   wire       pc_plus_4_cy;
   reg 	      pc_plus_4_cy_r;
   wire [B:0] pc_plus_4_cy_r_w;
   wire [B:0] pc_plus_offset;
   wire       pc_plus_offset_cy;
   reg	      pc_plus_offset_cy_r;
   wire [B:0] pc_plus_offset_cy_r_w;
   wire [B:0] pc_plus_offset_aligned;
   wire [B:0] plus_4;

   wire [B:0] pc = o_ibus_adr[B:0];

   wire [B:0] new_pc;

   wire [B:0] offset_a;
   wire [B:0] offset_b;

  /*  If i_iscomp=1: increment pc by 2 else increment pc by 4  */

   generate
      if (W == 1) begin : gen_plus_4_w_eq_1
	 assign plus_4 = i_iscomp ? i_cnt1 : i_cnt2;
      end else if (W >= 4) begin : gen_plus_4_w_ge_4
	 assign plus_4 = (i_cnt0 | i_cnt1) ? (i_iscomp ? 2 : 4) : 0;
      end
   endgenerate

   assign o_bad_pc = pc_plus_offset_aligned;

   assign {pc_plus_4_cy,pc_plus_4} = pc+plus_4+pc_plus_4_cy_r_w;

   generate
      if (|WITH_CSR) begin : gen_csr
	 if (W == 1) begin : gen_new_pc_w_eq_1
	    assign new_pc = i_trap ? (i_csr_pc & !(i_cnt0 || i_cnt1)) : i_jump ? pc_plus_offset_aligned : pc_plus_4;
         end else if (W == 4) begin : gen_new_pc_w_eq_4
	    assign new_pc = i_trap ? (i_csr_pc & ((i_cnt0 || i_cnt1) ? 4'b1100 : 4'b1111)) : i_jump ? pc_plus_offset_aligned : pc_plus_4;
         end else if (W == 8) begin : gen_new_pc_w_eq_8
	    assign new_pc = i_trap ? (i_csr_pc & ((i_cnt0 || i_cnt1) ? 8'b11111100 : 8'b11111111)) : i_jump ? pc_plus_offset_aligned : pc_plus_4;
	 end
      end else begin : gen_no_csr
	 assign new_pc = i_jump ? pc_plus_offset_aligned : pc_plus_4;
      end
   endgenerate
   assign o_rd  = ({W{i_utype}} & pc_plus_offset_aligned) | (pc_plus_4 & {W{i_jal_or_jalr}});

   assign offset_a = {W{i_pc_rel}} & pc;
   generate
      if (W == 8) begin : gen_offset_w_eq_8
	 assign offset_b = i_utype ? (i_imm & {{4{i_cnt12to15 | i_cnt16to31}}, {4{i_cnt16to31}}}) : i_buf;
      end else begin : gen_offset_w_lt_8
	 assign offset_b = i_utype ? (i_imm & {W{i_cnt12to15 | i_cnt16to31}}) : i_buf;
      end
   endgenerate

   assign {pc_plus_offset_cy,pc_plus_offset} = offset_a+offset_b+pc_plus_offset_cy_r_w;

   generate
   if (W>1) begin : gen_w_gt_1
	 assign pc_plus_offset_aligned[B:1] = pc_plus_offset[B:1];
	 assign pc_plus_offset_cy_r_w[B:1] = {B{1'b0}};
	 assign pc_plus_4_cy_r_w[B:1] = {B{1'b0}};
   end
   endgenerate

   assign pc_plus_offset_aligned[0] = pc_plus_offset[0] & !i_cnt0;
   assign pc_plus_offset_cy_r_w[0] = pc_plus_offset_cy_r;
   assign pc_plus_4_cy_r_w[0] = pc_plus_4_cy_r;

   initial if (RESET_STRATEGY == "NONE") o_ibus_adr = RESET_PC;

   always @(posedge clk) begin
      pc_plus_4_cy_r <= i_pc_en & pc_plus_4_cy;
      pc_plus_offset_cy_r <= i_pc_en & pc_plus_offset_cy;

      if (RESET_STRATEGY == "NONE") begin
	 if (i_pc_en)
	   o_ibus_adr <= {new_pc, o_ibus_adr[31:W]};
      end else begin
	 if (i_pc_en | i_rst)
	   o_ibus_adr <= i_rst ? RESET_PC : {new_pc, o_ibus_adr[31:W]};
      end
   end
endmodule
