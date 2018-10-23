`default_nettype none
module serv_top
  (
   input         clk,
   input [31:0]  i_i_data,
   input         i_i_valid,
   output reg    o_i_ready = 1'b1,
   output [31:0] o_pc_data,
   output        o_pc_valid,
   input         i_pc_ready);

   reg [31:0] cur_instr = 32'd0;
   reg        instr;
   wire       imm_31_12;
   wire       imm_11_0;
   wire       field_rd;
   wire       field_rs1;
   wire       field_rs2;
   wire       funct3;
   wire       funct7;
   reg        decode_go = 1'b0;
   wire       ctrl_go;
   wire       alu_go;
   wire       rs_en;
   wire       rs1;
   wire       rs2;
   wire       rd;

   wire       ctrl_rd;
   wire       ctrl_rd_valid;
   
   wire       alu_rd;
   wire       alu_rd_valid;

   wire       funct3_valid;
   
   wire       jal;
   wire       opimm;

   serv_decode decode
     (
      .clk         (clk),
      .i_instr     (cur_instr[0]),
      .i_go        (decode_go),
      .o_funct7    (funct7),
      .o_funct3    (funct3_valid),
      .o_field_rs1 (field_rs1),
      .o_field_rs2 (field_rs2),
      .o_rd        (field_rd),
      .o_imm_11_0  (imm_11_0),
      .o_imm_31_12 (imm_31_12),
      .o_jal       (jal),
      .o_opimm     (opimm),
      .o_alu_go    (alu_go),
      .o_ctrl_go   (ctrl_go));

   wire       reg_2012_en_decode;
   wire       reg_2012_en_ctrl;
   wire       reg_2012_data;
   
   wire       reg_2012_en = reg_2012_en_decode | reg_2012_en_ctrl;
   
   shift_reg
     #(
       .LEN  (9))
   reg_2012
     (
      .clk (clk),
      .i_en (reg_2012_en),
      .i_d  (cur_instr[0]),
      .o_q  (reg_2012_data));

   serv_alu alu
     (
      .clk (clk),
      .i_go (alu_go),
      .i_d  (cur_instr[0]),
      .i_funct3_valid (funct3_valid),
      .i_rs1 (rs1),
      .o_rs_en (rs_en),
      .o_rd (alu_rd),
      .o_rd_valid (alu_rd_valid));

   serv_ctrl ctrl
     (
      .clk (clk),
      .i_go (ctrl_go),
      .i_instr (cur_instr[0]),
      .i_jal (jal),
      .i_reg11 (1'b0), //FIXME
      .i_reg2012 (reg_2012_data),
      .o_reg2012_en (reg_2012_en_ctrl),
      .o_rd       (ctrl_rd),
      .o_rd_valid (ctrl_rd_valid),
      .o_pc_data (o_pc_data),
      .o_pc_valid (o_pc_valid),
      .i_pc_ready (i_pc_ready));

   serv_regfile regfile
     (
      .clk         (clk),
      .i_d         (cur_instr[0]),
      .i_field_rs1 (field_rs1),
      .i_field_rs2 (field_rs2),
      .i_field_rd  (field_rd),
      .i_rs_en     (rs_en),
      .o_rs1       (rs1),
      .o_rs2       (rs2),
      .i_rd        ((ctrl_rd & ctrl_rd_valid) | (alu_rd & alu_rd_valid)),
      .i_rd_valid  (ctrl_rd_valid | alu_rd_valid));

   always @(posedge clk) begin
      decode_go <= 1'b0;
      cur_instr <= {1'b0, cur_instr[31:1]};

      if (o_pc_valid)
        o_i_ready <= 1'b1;
      
      if (i_i_valid & o_i_ready) begin
         cur_instr <= i_i_data;
         o_i_ready <= 1'b0;
         decode_go <= 1'b1;
      end
   end // always @ (posedge clk)
      
endmodule
