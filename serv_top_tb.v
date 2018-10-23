module serv_top_tb;
   reg clk = 1'b1;
   always #5 clk <= !clk;

   vlog_tb_utils vtu();
   
   reg [1023:0] firmware_file;
   reg [31:0] memory [0:16383];

   reg [31:0] i_data;
   reg        i_valid = 1'b0;
   wire       i_ready;

   wire [31:0] pc_data;
   wire        pc_valid;
   reg         pc_ready = 1'b0;
   

   initial begin
      firmware_file = "firmware.hex";
      $readmemh(firmware_file, memory);
   end

   always @(posedge clk) begin
      pc_ready <= 1'b1; //Fuck knows
      
      if (i_valid & i_ready)
        i_valid <= 1'b0;
      if (pc_valid & pc_ready) begin
         i_data <= memory[pc_data>>2];
         i_valid <= 1'b1;
         pc_ready <= 1'b0;
      end
   end
      
   serv_top dut
     (.clk (clk),
      .i_i_data (i_data),
      .i_i_valid (i_valid),
      .o_i_ready (i_ready),
      .o_pc_data (pc_data),
      .o_pc_valid (pc_valid),
      .i_pc_ready (pc_ready));
   
endmodule
