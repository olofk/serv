`default_nettype none
module serv_mem_if
  (
   input 	 i_clk,
   input 	 i_en,
   input 	 i_init,
   input 	 i_dat_valid,
   input 	 i_cmd,
   input [2:0] 	 i_funct3,
   input 	 i_rs1,
   input 	 i_rs2,
   input 	 i_imm,
   output 	 o_rd,
   output reg 	 o_busy = 1'b0,
   output 	 o_misalign,
   input         i_trap,
   //External interface
   output [31:0] o_wb_adr,
   output [31:0] o_wb_dat,
   output [3:0]  o_wb_sel,
   output 	 o_wb_we ,
   output reg 	 o_wb_cyc = 1'b0,
   output 	 o_wb_stb,
   input [31:0]  i_wb_rdt,
   input 	 i_wb_ack);

   wire          wb_en = o_wb_cyc & i_wb_ack;
   assign o_wb_stb = o_wb_cyc;
   reg           init_r;
   reg           en_r;
   reg           en_2r;
   wire          adr;
   reg [31:0]    dat = 32'd0;
   reg           signbit = 1'b0;

   ser_add ser_add_rs1_plus_imm
     (
      .clk (i_clk),
      .a   (i_rs1),
      .b   (i_imm),
      .clr (!i_en),
      .q   (adr),
      .o_v ());

   shift_reg #(32) shift_reg_adr
     (
      .clk   (i_clk),
      .i_en  (i_init | (i_en & i_trap)),
      .i_d   (adr),
      .o_q   (o_wb_adr[0]),
      .o_par (o_wb_adr[31:1])
      );

   wire is_signed = ~i_funct3[2];
   assign o_rd = i_dat_valid ? dat[0] : signbit & is_signed;

   wire is_word = i_funct3[1];
   wire is_half = i_funct3[0];
   wire is_byte = !(|i_funct3[1:0]);

   assign o_misalign = (|misalign);


   wire       upper_half = bytepos[1];

   assign o_wb_dat = dat;
   assign o_wb_sel = (is_word ? 4'b1111 :
                      is_half ? {{2{upper_half}}, ~{2{upper_half}}} :
                      4'd1 << bytepos);
   assign o_wb_we = i_cmd;
   reg [1:0]  bytepos;
   reg [4:0]  cnt = 5'd0;
   reg        dat_en;

   always @(i_funct3, cnt, bytepos)
     casez(i_funct3[1:0])
       2'b1? : dat_en = 1'b1;
       2'b01 : dat_en = bytepos[1] ? (cnt<16) : 1'b1;
       2'b00 : dat_en = (bytepos == 2'd3) ? (cnt <8) :
                        (bytepos == 2'd2) ? (cnt < 16) :
                        (bytepos == 2'd1) ? (cnt < 24) : 1'b1;
     endcase

   reg 	      init_2r = 1'b0;
   reg [1:0]  misalign = 2'b00;

   always @(posedge i_clk) begin
      if (i_init & !init_r)
	misalign[0] <= (!is_byte & adr);
      if (init_r & !init_2r)
	misalign[1] <= (is_word & adr);
      if (i_trap)
	misalign <= 2'b00;

      if (i_en & !en_r)
        bytepos[0] <= adr;
      if (en_r & !en_2r)
        bytepos[1] <= adr;

      if (i_dat_valid)
        signbit <= dat[0];

      if (i_en & i_init)
        o_busy <= 1'b1;
      else if (wb_en | i_trap)
        o_busy <= 1'b0;

      if (wb_en & !o_wb_we) begin
         dat[31:16] <= i_wb_rdt[31:16];
         dat[15:8]  <= (is_half & upper_half) ? i_wb_rdt[31:24] : i_wb_rdt[15:8];
         dat[7:0]   <= (is_byte & (bytepos == 2'b11)) ? i_wb_rdt[31:24] :
                       (is_byte & (bytepos == 2'b10)) ? i_wb_rdt[23:16] :
                       (is_half & upper_half)         ? i_wb_rdt[23:16] :
                       (is_byte & (bytepos == 2'b01)) ? i_wb_rdt[15:8] :
                       i_wb_rdt[7:0];
      end

      en_r <= i_en;
      en_2r <= en_r;
      init_r <= i_init;
      init_2r <= init_r;
      if (wb_en)
        o_wb_cyc <= 1'b0;
      else if (init_r & !i_init & !i_trap) begin //Optimize?
         o_wb_cyc <= 1'b1;
      end

      if (i_en & dat_en)
        dat <= {i_rs2,dat[31:1]};
   end
endmodule
