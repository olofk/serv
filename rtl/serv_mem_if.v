`default_nettype none
module serv_mem_if
  (
   input wire 	      i_clk,
   input wire 	      i_rst,
   input wire 	      i_en,
   input wire 	      i_init,
   input wire 	      i_cmd,
   input wire [1:0]   i_bytecnt,
   input wire [2:0]   i_funct3,
   input wire 	      i_rs1,
   input wire 	      i_rs2,
   input wire 	      i_imm,
   output wire 	      o_rd,
   output reg 	      o_misalign,
   input wire 	      i_trap,
   output wire 	      o_adr,
   //External interface
   output wire [31:0] o_wb_adr,
   output wire [31:0] o_wb_dat,
   output wire [3:0]  o_wb_sel,
   output wire 	      o_wb_we ,
   output reg 	      o_wb_cyc,
   input wire [31:0]  i_wb_rdt,
   input wire 	      i_wb_ack);

   wire          wb_en = o_wb_cyc & i_wb_ack;
   reg           init_r;
   reg 		 init_2r;
   wire          adr;
   reg           signbit = 1'b0;

   reg [7:0] 	 dat0;
   reg [7:0] 	 dat1;
   reg [7:0] 	 dat2;
   reg [7:0] 	 dat3;
   wire 	 dat0_en;
   wire 	 dat1_en;
   wire 	 dat2_en;
   wire 	 dat3_en;

   assign o_adr = adr;

   ser_add ser_add_rs1_plus_imm
     (
      .clk (i_clk),
      .rst (i_rst),
      .a   (i_rs1),
      .b   (i_imm),
      .clr (!i_en),
      .q   (adr),
      .o_v ());

   assign o_wb_adr[1:0] = 2'b00;

   shift_reg #(30) shift_reg_adr
     (
      .clk   (i_clk),
      .i_rst (i_rst),
      .i_en  (i_init | i_trap),
      .i_d   (adr),
      .o_q   (o_wb_adr[2]),
      .o_par (o_wb_adr[31:3])
      );

   wire 	 dat_cur = (dat_sel == 3) ? dat3[0] :
		 (dat_sel == 2) ? dat2[0] :
		 (dat_sel == 1) ? dat1[0] : dat0[0];

   wire is_signed = ~i_funct3[2];
   assign o_rd = dat_valid ? dat_cur : signbit & is_signed;

   wire dat_valid = is_word | (i_bytecnt == 2'b00) | (is_half & !i_bytecnt[1]);

   wire is_word = i_funct3[1];
   wire is_half = i_funct3[0];
   wire is_byte = !(|i_funct3[1:0]);



   wire       upper_half = bytepos[1];
/*
   assign o_wb_sel = (is_word ? 4'b1111 :
		      is_half ? {{2{upper_half}}, ~{2{upper_half}}} :
		      4'd1 << bytepos);
*/
   assign o_wb_sel[3] = is_word | (is_half & bytepos[1]) | (bytepos == 2'b11);
   assign o_wb_sel[2] = (bytepos == 2'b10) | is_word;
   assign o_wb_sel[1] = ((is_word | is_half) & !bytepos[1]) | (bytepos == 2'b01);
   assign o_wb_sel[0] = (bytepos == 2'b00);

   assign o_wb_we = i_cmd;
   reg [1:0]  bytepos;


   wire       wbyte0 = (i_bytecnt == 2'b00);
   wire       wbyte1 = ((i_bytecnt == 2'b01) & !bytepos[0]);
   wire       wbyte2 = ((i_bytecnt == 2'b10) & !bytepos[1]);
   wire       wbyte3 = ((i_bytecnt == 2'b11) & !bytepos[1]);

   assign dat0_en = i_en & (i_init ? wbyte0 : (dat_sel == 2'd0));
   assign dat1_en = i_en & (i_init ? (wbyte0 | wbyte1) : (dat_sel == 2'd1));
   assign dat2_en = i_en & (i_init ? (wbyte0 | wbyte2) : (dat_sel == 2'd2));
   assign dat3_en = i_en & (i_init ? (wbyte0 | wbyte1 | wbyte3) : (dat_sel == 2'd3));

   assign o_wb_dat = {dat3,dat2,dat1,dat0};

   wire [1:0] dat_sel = i_bytecnt[1] ? i_bytecnt : (i_bytecnt | bytepos);

   always @(posedge i_clk) begin
      if (dat0_en)
	dat0 <= {i_rs2, dat0[7:1]};
      if (dat1_en)
	dat1 <= {i_rs2, dat1[7:1]};
      if (dat2_en)
	dat2 <= {i_rs2, dat2[7:1]};
      if (dat3_en)
	dat3 <= {i_rs2, dat3[7:1]};

      if (wb_en)
	{dat3,dat2,dat1,dat0} <= i_wb_rdt;

      if (i_init & !init_r)
        bytepos[0] <= adr;
      if (init_r & !init_2r)
        bytepos[1] <= adr;

      o_misalign <= i_en & ((bytepos[0] & !is_byte) | (bytepos[1] & is_word));
      if (dat_valid)
        signbit <= dat_cur;

      init_r <= i_init;
      init_2r <= init_r;
      if (wb_en)
        o_wb_cyc <= 1'b0;
      else if (init_r & !i_init & !i_trap) begin //Optimize?
         o_wb_cyc <= 1'b1;
      end
      if (i_rst) begin
	 o_wb_cyc <= 1'b0;
	 init_r <= 1'b0;
	 init_2r <= 1'b0;
      end
   end
endmodule
