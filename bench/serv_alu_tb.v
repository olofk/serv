`default_nettype none
module serv_alu_tb;
   reg clk = 1'b1;

   reg go;
   reg instr;
   reg jal;

   wire [31:0] pc_data;
   wire        pc_valid;
   reg         pc_ready = 1'b1;

   wire        rd;
   wire        rd_valid;
   
   wire done;

   reg  reg11;
   reg [8:0] reg2012;
   
   wire reg2012_en;

   always #5 clk <= !clk;

   vlog_tb_utils vtu();
   
   serv_ctrl dut
     (
      .clk (clk),
      .i_go (go),
      .i_instr (instr),
      .i_jal (jal),
      .i_reg11 (reg11),
      .i_reg2012 (reg2012[0]),
      .o_reg2012_en (reg2012_en),
      .o_rd         (rd),
      .o_rd_valid   (rd_valid),
      .o_pc_data (pc_data),
      .o_pc_valid (pc_valid),
      .i_pc_ready (pc_ready));

   reg [31:0] instruction;
   integer    idx;
   
   initial begin
      instruction = 32'h3d80006f;
      reg11 = instruction[20];
      reg2012 = {instruction[31],instruction[19:12]};
      for (idx=0;idx < 31;idx=idx+1) begin
         go <= (idx == 19); //Check this
         instr <= instruction[idx];
         jal <= (idx > 7);
         if (reg2012_en) reg2012 <= (reg2012 >> 1);
         @(posedge clk);
      end
      while (!done)
        @(posedge clk);
   end // initial begin

   reg [31:0] rd_word;
   
   always @(posedge clk) begin
      if (rd_valid)
        rd_word = {rd, rd_word[31:1]};
      if (pc_valid & pc_ready) begin
         $display("New PC is %08x", pc_data);
         $display("RD is %08x", rd_word);
      end
   end
endmodule
