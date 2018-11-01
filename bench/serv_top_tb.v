`default_nettype none
module serv_top_tb;
   reg clk = 1'b1;

   wire [31:0] i_ca_adr;
   wire        i_ca_vld;
   wire        i_ca_rdy;
   wire [31:0] i_rd_dat;
   wire        i_rd_vld;
   wire        i_rd_rdy;

   wire        d_ca_cmd;
   wire [31:0] d_ca_adr;
   wire        d_ca_vld;
   wire        d_ca_rdy;
   wire [31:0] d_dm_dat;
   wire [3:0]  d_dm_msk;
   wire        d_dm_vld;
   wire        d_dm_rdy;
   wire [31:0] d_rd_dat;
   wire        d_rd_vld;
   wire        d_rd_rdy;

   reg [1023:0] firmware_file;

   reg [31:0] pc;
   reg [31:0] instruction;

   always #5 clk <= !clk;

   camd_ram
     #(.memfile ("firmware.hex"),
       .depth (16384*4))
   i_mem
     (.clk_i    (clk),
      .rst_i    (1'b0),
      .ca_adr_i (i_ca_adr),
      .ca_cmd_i (1'b0/*i_ca_cmd*/),
      .ca_vld_i (i_ca_vld),
      .ca_rdy_o (i_ca_rdy),
      .dm_dat_i (/*i_dm_dat*/),
      .dm_msk_i (/*i_dm_msk*/),
      .dm_vld_i (/*i_dm_vld*/),
      .dm_rdy_o (/*i_dm_rdy*/),
      .rd_dat_o (i_rd_dat),
      .rd_vld_o (i_rd_vld),
      .rd_rdy_i (i_rd_rdy));

   camd_ram
     #(.memfile ("firmware.hex"),
       .depth (16384*4))
   d_mem
     (.clk_i    (clk),
      .rst_i    (1'b0),
      .ca_adr_i (d_ca_adr),
      .ca_cmd_i (d_ca_cmd),
      .ca_vld_i (d_ca_vld),
      .ca_rdy_o (d_ca_rdy),
      .dm_dat_i (d_dm_dat),
      .dm_msk_i (d_dm_msk),
      .dm_vld_i (d_dm_vld),
      .dm_rdy_o (d_dm_rdy),
      .rd_dat_o (d_rd_dat),
      .rd_vld_o (d_rd_vld),
      .rd_rdy_i (d_rd_rdy));

   reg        catch_write = 1'b0;

   reg        dbg = 1'b0;

   wire       d_ca_en = d_ca_vld & d_ca_rdy;
   wire       d_dm_en = d_dm_vld & d_dm_rdy;
   
   always @(posedge clk) begin
      dbg <= 1'b0;
      
      if (d_ca_en & d_ca_cmd & (d_ca_adr == 32'h10000000))
        catch_write <= 1'b1;
      if (((d_ca_en & d_ca_cmd & (d_ca_adr == 32'h10000000)) |catch_write) & d_dm_en & d_dm_msk[0]) begin
         dbg <= 1'b1;
         $write("%c", d_dm_dat[7:0]);
         $fflush();
         catch_write <= 1'b0;
      end
   end
   vlog_tb_utils vtu();

   serv_top
     #(.RESET_PC (32'd8))
   dut
     (
      .clk      (clk),
      .o_i_ca_adr (i_ca_adr),
      .o_i_ca_vld (i_ca_vld),
      .i_i_ca_rdy (i_ca_rdy),
      .i_i_rd_dat (i_rd_dat),
      .i_i_rd_vld (i_rd_vld),
      .o_i_rd_rdy (i_rd_rdy),
      .o_d_ca_cmd (d_ca_cmd),
      .o_d_ca_adr (d_ca_adr),
      .o_d_ca_vld (d_ca_vld),
      .i_d_ca_rdy (d_ca_rdy),
      .o_d_dm_dat (d_dm_dat),
      .o_d_dm_msk (d_dm_msk),
      .o_d_dm_vld (d_dm_vld),
      .i_d_dm_rdy (d_dm_rdy),
      .i_d_rd_dat (d_rd_dat),
      .i_d_rd_vld (d_rd_vld),
      .o_d_rd_rdy (d_rd_rdy));

endmodule
