module serv_ctrl
#(
    parameter RESET_PC = 32'd0
)
  (
   input wire 	     clk,
   input wire 	     i_rst,
   //State
   input wire 	     i_pc_en,
   input wire 	     i_cnt12to31,
   input wire 	     i_cnt0,
   input wire        i_cnt1,
   input wire 	     i_cnt2,
   input wire        i_cnt3,
   //Control
   input wire 	     i_jump,
   input wire 	     i_jal_or_jalr,
   input wire 	     i_utype,
   input wire 	     i_pc_rel,
   input wire 	     i_trap,
   input wire        i_ebreak,
   input wire        i_halt,
   input wire        i_iscomp,
   //Data
   input wire 	     i_imm,
   input wire 	     i_buf,
   input wire 	     i_csr_pc,
   output wire 	     o_rd,
   output wire 	     o_bad_pc,
   //External
   output reg [31:0] o_ibus_adr,
   output wire       o_ibus_nxtadr
);

   wire       pc_plus_4;
   wire       pc_plus_4_cy;
   reg 	      pc_plus_4_cy_r;
   wire       pc_plus_offset;
   wire       pc_plus_offset_cy;
   reg 	      pc_plus_offset_cy_r;
   wire       pc_plus_offset_aligned;
   wire       plus_4;
   
   wire       pc_plus_8;
   wire       pc_plus_8_cy;
   reg 	      pc_plus_8_cy_r;
   wire       plus_8;

   wire       pc = o_ibus_adr[0];

   wire       new_pc;
   wire       new_nxtpc;

   wire       offset_a;
   wire       offset_b;
   
   reg [31:0] r_ibus_nxtadr;
   
//   reg [31:0] r_ibus_nxtadr;
  /*  If i_iscomp=1: increment pc by 2 else increment pc by 4  */

   assign plus_4   = i_iscomp ? i_cnt1 : i_cnt2;
   assign plus_8   = i_cnt3;
   
   assign o_bad_pc = pc_plus_offset_aligned;

   assign {pc_plus_4_cy,pc_plus_4} = pc+plus_4+pc_plus_4_cy_r;
   assign {pc_plus_8_cy, pc_plus_8} = pc+plus_8+pc_plus_8_cy_r;

   assign new_pc = i_trap ? (i_csr_pc & !i_cnt0) : 
                   i_jump ? pc_plus_offset_aligned : pc_plus_4;
   assign new_nxtpc = pc_plus_8;
   
   assign o_rd   = (i_utype & pc_plus_offset_aligned) | (pc_plus_4 & i_jal_or_jalr);

   assign offset_a = i_pc_rel & pc;
   assign offset_b = i_utype ? (i_imm & i_cnt12to31): i_buf;
   assign {pc_plus_offset_cy,pc_plus_offset} = offset_a+offset_b+pc_plus_offset_cy_r;

   assign pc_plus_offset_aligned = pc_plus_offset & !i_cnt0;

   always @(posedge clk) begin
      pc_plus_4_cy_r <= i_pc_en & pc_plus_4_cy;
      pc_plus_offset_cy_r <= i_pc_en & pc_plus_offset_cy;

      pc_plus_8_cy_r <= i_pc_en & pc_plus_8_cy;
      
      if (i_rst) o_ibus_adr          <= RESET_PC;
      else if (i_pc_en) o_ibus_adr <= {new_pc, o_ibus_adr[31:1]};
      
      if (i_rst) r_ibus_nxtadr          <= RESET_PC;
      else if (i_pc_en) r_ibus_nxtadr <= {new_nxtpc, r_ibus_nxtadr[31:1]};
//      if (i_rst) o_ibus_nxtadr <= 1'b0;
//      else if (i_pc_en) o_ibus_nxtadr <= o_ibus_adr[0];
    
   end
   
   assign o_ibus_nxtadr = i_halt? o_ibus_adr[0]: r_ibus_nxtadr[0];
   
endmodule
