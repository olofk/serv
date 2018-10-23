module serv_decode
  (
   input  clk,
   input  i_go,
   input  i_instr,
   output o_imm_31_12,
   output o_imm_11_0,
   output o_rd,
   output o_field_rs2,
   output o_field_rs1,
   output o_funct3,
   output o_funct7,
   output o_jal,
   output o_opimm,
   output o_alu_go,
   output o_ctrl_go);

   localparam [4:0]
     OP_OPIMM = 5'b00100,
     OP_JAL   = 5'b11011;

   
   reg [8:0] barrel [0:31];
   reg [4:0] cnt = 5'd0;
   reg       running = 1'b0;

   wire      opcode_valid;
   wire      halt;
   

   wire [8:0]     cur = barrel[cnt];
   
   assign o_imm_31_12 = cur[8];
   assign o_imm_11_0  = cur[7];
   assign o_rd        = cur[6];
   assign o_field_rs2 = cur[5] & (1'b0);
   assign o_field_rs1 = cur[4] & (1'b0);
   assign o_funct3    = cur[3];
   assign o_funct7    = cur[2];
   assign opcode_valid = cur[1];
   assign halt        = cur[0];

   initial begin
      $readmemb("decode.mem", barrel);
   end

   reg [4:0] opcode = 5'd0;
   
   assign o_jal = (opcode == OP_JAL);
   assign o_ctrl_go = (cnt == 19);
   assign o_opimm = (opcode == OP_OPIMM);
   assign o_alu_go = o_opimm & (cnt == 19);

//   shift_reg #(5) shift_reg_opcode
     
   always @(posedge clk) begin
      if (opcode_valid)
        opcode <= {opcode[3:0], i_instr};
      cnt <= cnt + (i_go | running);
      if (i_go)
        running <= 1'd1;
      else if (halt) begin
         running <= 1'd0;
         cnt <= 1'b0;
      end
   end

endmodule
