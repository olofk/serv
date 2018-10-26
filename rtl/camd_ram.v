module camd_ram
 #(//camd parameters
   parameter AW = 32,
   parameter DW = 32,
   //Memory parameters
   parameter depth = 256,
   parameter aw    = $clog2(depth),
   parameter memfile = "")
   (input 	   clk_i,
   input 	    rst_i,
   
   input [AW-1:0]   ca_adr_i, //FIXME width = AW-clog2(WB_DW/8)
   input 	    ca_cmd_i,
   input 	    ca_vld_i,
   output 	    ca_rdy_o,

   input [DW-1:0]   dm_dat_i,
   input [DW/8-1:0] dm_msk_i,
   input 	    dm_vld_i,
   output 	    dm_rdy_o,

   output [DW-1:0]  rd_dat_o,
   output reg	    rd_vld_o,
   input 	    rd_rdy_i);

   wire 	    ca_en = ca_vld_i & ca_rdy_o;
   wire 	    dm_en = dm_vld_i & dm_rdy_o;
   wire 	    ram_we = ca_en & dm_en;

   assign ca_rdy_o = 1'b1;
   assign dm_rdy_o = 1'b1;

   wire [aw-1:2]    raddr;
   reg [aw-1:2]     latched_raddr;
   assign raddr = ca_en ? ca_adr_i[aw-1:2] : latched_raddr;
   
   always @(posedge clk_i) begin
      if (ca_en)
        latched_raddr <= ca_adr_i[aw-1:2];
      rd_vld_o <= 1'b0;
      if (ca_en & !ca_cmd_i)
	rd_vld_o <= 1'b1;
   end
   wb_ram_generic
     #(.depth(depth/4),
       .memfile (memfile))
   ram0
     (.clk   (clk_i),
      .we    ({4{ram_we}} & dm_msk_i),
      .din   (dm_dat_i),
      .waddr (ca_adr_i[aw-1:2]),
      .raddr (raddr),
      .dout  (rd_dat_o));

endmodule
