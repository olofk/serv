`default_nettype none
module serv_ctrl
  (
   input         clk,
   input         i_go,
   input         i_instr,
   input         i_jal,
   input         i_reg11,
   input         i_reg2012,
   output        o_reg2012_en,
   output        o_rd,
   output        o_rd_valid, 
   output [31:0] o_pc_data,
   output reg    o_pc_valid = 1'b1,
   input         i_pc_ready);

   parameter RESET_PC = 32'd8;
   
   localparam [2:0]
     NULL    = 3'd0,
     INSTR   = 3'd1,
     REG11   = 3'd2,
     REG2012 = 3'd3,
     SIGNBIT = 3'd4;

   wire        offset;
   
   reg         signbit = 1'd0;
   
   reg [5:0] cnt = 5'd0;

   reg        new_pc_sel = 1'b0;
   wire       pc_plus_4;
   wire       pc_plus_offset;
   reg        pc_plus_offset_clr = 1'b0;
   
   wire       plus_4;
   wire       pc_plus_4_clr;
   reg        running = 1'b0;

   wire       new_pc;
   
   reg [2:0] offset_source;
   
   assign pc_plus_4_clr = (cnt == 0);
   assign plus_4        = (cnt == 2);

   ser_add ser_add_pc_plus_4
     (
      .clk   (clk),
      .a     (plus_4),
      .b     (o_pc_data[0]),
      .clear (pc_plus_4_clr),
      .q     (pc_plus_4));

   shift_reg
     #(
       .LEN  (32),
       .INIT (RESET_PC))
   pc_reg
     (
      .clk (clk),
      .i_en (running),
      .i_d  (new_pc),
      .o_q  (o_pc_data[0]),
      .o_par (o_pc_data[31:1])
      );

   assign new_pc = new_pc_sel ? pc_plus_offset : pc_plus_4;

   assign o_rd = pc_plus_4;
   assign o_rd_valid = running & i_jal;
   
   always @(cnt, i_jal, running) begin
      offset_source = NULL;
      new_pc_sel = 1'b0;
      if (i_jal) begin
         new_pc_sel = 1'b1;
         if (cnt < 10)
           offset_source = INSTR;
         else if (cnt < 11)
           offset_source = REG11;
         else if (cnt < 20)
           offset_source = REG2012;
         else
           offset_source = SIGNBIT;
      end
   end

   wire o_reg11_en = (offset_source == REG11);
   wire o_reg2012_en = (offset_source == REG2012);

   assign offset = (offset_source == INSTR)   ? i_instr :
                   (offset_source == REG11)   ? i_reg11 :
                   (offset_source == REG2012) ? i_reg2012 :
                   (offset_source == SIGNBIT) ? signbit :
                   1'b0;

   ser_add ser_add_pc_plus_offset
     (
      .clk   (clk),
      .a     (o_pc_data[0]), //FIXME Need a mux before this
      .b     (offset),
      .clear (pc_plus_offset_clr),
      .q     (pc_plus_offset));

   reg  done = 1'b0;
   
   always @(posedge clk) begin
      cnt <= 6'd0;
      done <= 1'b0;
      
      if (i_go)
         running <= 1'b1;
      else if (cnt == 32) begin
         running <= 1'b0;
         done <= 1'b1;
      end
      
      if (running) begin
         cnt <= cnt + 1;
      end

      if (done)
        o_pc_valid <= 1'b1;
      if (o_pc_valid & i_pc_ready)
        o_pc_valid <= 1'b0;
   end
   
endmodule
   
