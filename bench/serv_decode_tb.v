`default_nettype none
module serv_decode_tb;
   reg clk = 1'b1;

   reg [31:0] i_rd_dat = 32'd0;
   reg        i_rd_vld = 1'b0;
   wire       i_rd_rdy;

   wire       ctrl_en;
   wire       ctrl_jump;
   wire [4:0] rd_addr;
   wire [4:0] rs1_addr;
   wire [4:0] rs2_addr;
   wire       imm;
   wire       offset_source;
   wire [1:0] rd_source;

   reg [31:0] tb_imm;
   
   always #5 clk <= !clk;

   vlog_tb_utils vtu();
   
   serv_decode decode
     (
      .clk (clk),
      .i_i_rd_dat     (i_rd_dat),
      .i_i_rd_vld     (i_rd_vld),
      .o_i_rd_rdy     (i_rd_rdy),
      .o_ctrl_en      (ctrl_en),
      .o_ctrl_jump    (ctrl_jump),
      .o_rf_rd_addr   (rd_addr),
      .o_rf_rs1_addr  (rs1_addr),
      .o_rf_rs2_addr  (rs2_addr),
      .o_imm          (imm),
      .o_offset_source (offset_source),
      .o_rd_source    (rd_source));

   initial begin
      @(posedge clk);
      i_rd_dat <= 32'h3d80006f;
      i_rd_vld <= 1'b1;
      @(posedge clk);
      @(posedge i_rd_rdy);
      @(posedge clk);
      $display("imm = %08x", tb_imm);
      
      $finish;
   end
   always @(posedge clk) begin
      if (ctrl_en)
        tb_imm <= {imm, tb_imm[31:1]};
   end

endmodule
