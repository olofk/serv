`default_nettype none
module serv_alu
  (
   input  clk,
   input  i_d,
   input  i_go,
   input  i_funct3_valid,
   input  i_rs1,
   output o_rs_en,
   output o_rd,
   output o_rd_valid);

   localparam [2:0]
     ADDI  = 3'b000,
     SLTI  = 3'b010,
     SLTIU = 3'b011,
     XORI  = 3'b100,
     ORI   = 3'b110,
     ANDI  = 3'b111;

   wire [2:0] funct3;

   shift_reg #(3) shift_reg_funct3
     (
      .clk (clk),
      .i_d (i_d),
      .i_en (i_funct3_valid),
      .o_q  (funct3[0]),
      .o_par (funct3[2:1]));

   wire       op_b;
   wire       result_add;
   
   assign op_b = i_d; //FIXME mux for rs2

   assign o_rs_en = running;
   
   ser_add ser_add
     (
      .clk   (clk),
      .a     (i_rs1),
      .b     (op_b),
      .clear (i_go),
      .q     (result_add));

   assign o_rd = (funct3 == ADDI) ? result_add : 1'b0;
   assign o_rd_valid = (cnt > 0);
   
   reg [5:0]  cnt = 6'd0;
   reg        done;
   reg        running = 1'd0;
   
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
   end
endmodule   
   
