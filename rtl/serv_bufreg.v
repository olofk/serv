module serv_bufreg
  (
   input wire         i_clk,
   //State
   input wire         i_cnt0,
   input wire         i_cnt1,
   input wire         i_en,
   input wire         i_init,
   output reg [1:0]   o_lsb,
   //Control
   input wire         i_rs1_en,
   input wire         i_imm_en,
   input wire         i_clr_lsb,
   input wire         i_sh_signed,
   //Data
   input wire         i_rs1,
   input wire         i_imm,
   output wire        o_q,
   //External
   output wire [31:0] o_dbus_adr);

   wire               c, q;
   reg                c_r;
   reg [31:2]         data;

   wire               clr_lsb = i_cnt0 & i_clr_lsb;

   assign {c,q} = {1'b0,(i_rs1 & i_rs1_en)} + {1'b0,(i_imm & i_imm_en & !clr_lsb)} + c_r;

   always @(posedge i_clk) begin
      //Make sure carry is cleared before loading new data
      c_r <= c & i_en;

      if (i_en)
        data <= {i_init ? q : (data[31] & i_sh_signed), data[31:3]};

      if (i_init ? (i_cnt0 | i_cnt1) : i_en)
        o_lsb <= {i_init ? q : data[2],o_lsb[1]};

   end

   assign o_q = o_lsb[0] & i_en;
   assign o_dbus_adr = {data, 2'b00};

endmodule
