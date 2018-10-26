`default_nettype none
module serv_ctrl_tb;
   reg clk = 1'b1;

   reg go;
   wire en;
   wire jump;
   
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
   
   serv_decode decode
     (
      .clk (clk),
      .i_go (go),
      .i_instr        (instruction),
      .o_ctrl_jump    (jump),
      .o_ctrl_en      (en),
      .o_imm          (offset),
      .o_rd_from_ctrl ());

   serv_ctrl
     #(.RESET_PC (32'h464))
   dut
     (
      .clk        (clk),
      .i_en       (en),
      .i_jump     (jump),
      .i_offset   (offset),
      .o_rd       (rd),
      .o_i_dat    (pc_data),
      .o_pc_valid (pc_valid),
      .i_pc_ready (pc_ready));

   reg [31:0] instruction;
   integer    idx;

   reg [20:0] offset;
   
   initial begin
      instruction = 32'h3d80006f;
      //instruction = 32'h0080706f;
      offset = {instruction[31],
                instruction[19:12],
                instruction[20],
                instruction[30:21],1'b0};
      
      $display("Reconstructured offset %08x", offset);
      en <= 1'b1;
      for (idx=0;idx < 31;idx=idx+1) begin
         go <= (idx == 20); //Check this
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
