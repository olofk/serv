/* serving.v : Top-level for the serving SoC
 *
 * ISC License
 *
 * Copyright (C) 2020 Olof Kindgren <olof.kindgren@gmail.com>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

`default_nettype none
module serving
  #(        parameter memfile = "",
            parameter memsize = 1024,
            parameter sim = 1'b0,
            parameter RESET_STRATEGY = "NONE",
            parameter WITH_CSR = 1)
  (
   input wire 	      i_clk,
   input wire 	      i_rst,
   input wire 	      i_timer_irq,
   // SIGNALS TO BRIDGE //wishbone master interface
    output wire [12:2] o_wb_addr,
    //output wire [31:0] o_wb_adr,
   output wire [31:0] o_wb_dat,
   output wire [3:0]  o_wb_sel,
   output wire 	      o_wb_we ,
   output wire 	      o_wb_stb,
   input wire [31:0]  i_wb_rdt,
   input wire 	      i_wb_ack,
   // SIGNALS FROM BRIDGE //wishbone slave interfcae
   input wire [12:2]  adr_brg,
   input wire [31:0]  data_brg,
   input wire         stb_brg,
   input wire         wen_brg,
   input  wire [3:0]  sel_brg,
   output reg [31:0] rdt_brg,
   output wire        ack_brg,
    // MUX SELECTION
    input wire sel_wadr,
    input wire sel_wdata,
    input wire sel_radr,
    input wire sel_rdata,
    input wire sel_wen    
   );
      reg [1:0] bsel;
      reg [3:0]rsel;
//      parameter memfile = "";
//      parameter memsize = 1024;
//      parameter sim = 1'b0;
//      parameter RESET_STRATEGY = "NONE";
//      parameter WITH_CSR = 1;
      localparam regs = 32+WITH_CSR*4;
   
      localparam rf_width = 8;
   
      wire [31:0]     wb_mem_adr;
      wire [31:0]     wb_mem_dat;
      wire [3:0]     wb_mem_sel;
      wire     wb_mem_we;
      wire     wb_mem_stb;
      wire [31:0]     wb_mem_rdt;
      wire     wb_mem_ack;
   
      wire [6+WITH_CSR:0] rf_waddr;
      wire [rf_width-1:0] rf_wdata;
      wire            rf_wen;
      wire [6+WITH_CSR:0] rf_raddr;
      wire [rf_width-1:0] rf_rdata;
      wire               rf_ren;
   
      wire [$clog2(memsize)-1:0] sram_waddr;
      wire [rf_width-1:0] sram_wdata;
      wire sram_wen;
      wire [$clog2(memsize)-1:0] sram_raddr;
      wire [rf_width-1:0] sram_rdata;
      wire    sram_ren;
      
      localparam w = 12;
      wire [w:0] wadr_if;    // Write address from interface
      wire [w:0] wadr;       // Final write address (either external or from interface)
      wire [7:0] wdata_if;    // Write data from interface
      wire [7:0] wdata;       // Final write data (either external or from interface)
      wire [w:0] radr_if;
      wire wen_if;            // Write enable from interface
      wire wen;               // Final write enable
      wire [w:0] radr;
      wire [7:0] o_rdata_dout;
      wire [7:0] rdata_din;
      wire [7:0] rdata;
      
      
      // ------ DATA SLICING ---------- //
      
   wire intermediate;
   wire [31:0] o_wb_adr;
   //reg [31:0] wdata_ext;      // Changed to 32 bits for clarity
   reg [7:0]  byte_to_write;
   reg        done_w, done_r;
   reg [31:0] data_read;
   reg ack_reg,wait_for_rdata;
   reg [w:0] rd_addr, wr_addr;
   reg [w:0] base_rd_addr;
   
   
  assign o_wb_addr = o_wb_adr[12:2];
  always @(posedge i_clk) begin
       if (i_rst) begin
           bsel <= 2'b00;
           rsel <= 4'b0000;
           done_w <= 1'b0;
           done_r <= 1'b0;
           ack_reg <= 1'b0;
           wait_for_rdata <= 1'b0;
       end else begin
           // Defaults
           done_w <= 1'b0;
           done_r <= 1'b0;
           ack_reg <= 1'b0;
   
           // ------------- WRITE LOGIC ---------------
           if (wen_brg && stb_brg) begin
         
               case (sel_brg)
                   4'b1000: begin
                       byte_to_write <= data_brg[7:0];
                       wr_addr <= adr_brg;
                       done_w <= 1'b1;
                       ack_reg <= 1'b1;
                   end
                   4'b0100: begin
                       byte_to_write <= data_brg[15:8];
                       wr_addr <= adr_brg;
                       done_w <= 1'b1;
                       ack_reg <= 1'b1;
                   end
                   4'b0010: begin
                       byte_to_write <= data_brg[23:16];
                       wr_addr <= adr_brg;
                       done_w <= 1'b1;
                       ack_reg <= 1'b1;
                   end
                   4'b0001: begin
                       byte_to_write <= data_brg[31:24];
                       wr_addr <= adr_brg;
                       done_w <= 1'b1;
                       ack_reg <= 1'b1;
                   end
                   4'b1111: begin
                   case(bsel) 
                   2'd0: begin byte_to_write <=data_brg[7:0];   bsel<=2'd1;   wr_addr<=adr_brg; end
                   2'd1: begin byte_to_write <=data_brg[15:8]; bsel<=2'd2;  wr_addr<=wr_addr+1; end
                   2'd2: begin byte_to_write <=data_brg[23:16]; bsel<=2'd3;  wr_addr<=wr_addr+1; end
                   2'd3: begin byte_to_write <=data_brg[31:24]; bsel<=2'd0;  wr_addr<=wr_addr+1; done_w <= 1'b1; ack_reg <=1'b1; end
                   endcase       
                   end
               endcase
           end
   
           // ------------- READ LOGIC ---------------
           else if (!wen_brg && stb_brg) begin
               case (sel_brg)
                   4'b1000: begin
                       rd_addr <= adr_brg;
                       data_read[7:0] <= rdata;
                       done_r <= 1'b1;
                       ack_reg <= 1'b1;
                   end
                   4'b0100: begin
                       rd_addr <= adr_brg;
                       data_read[15:8] <= rdata;
                       done_r <= 1'b1;
                       ack_reg <= 1'b1;
                   end
                   4'b0010: begin
                       rd_addr <= adr_brg;
                       data_read[23:16] <= rdata;
                       done_r <= 1'b1;
                       ack_reg <= 1'b1;
                   end
                   4'b0001: begin
                       rd_addr <= adr_brg;
                       data_read[31:24] <= rdata;
                       done_r <= 1'b1;
                       ack_reg <= 1'b1;
                   end
                  4'b1111: begin
                     case (rsel)
                       4'd0: begin
                         rd_addr <= adr_brg;
                         rsel <= 4'd1;
                       end
                   
                       4'd1: begin
                         rsel <= 4'd2; 
                       end
                   
                       4'd2: begin
                         data_read[7:0] <= rdata;
                         rd_addr <= rd_addr + 1;
                         rsel <= 4'd3;
                       end
                   
                       4'd3: begin
                         rsel <= 4'd4;
                       end
                   
                       4'd4: begin
                         data_read[15:8] <= rdata;
                         rd_addr <= rd_addr + 1;
                         rsel <= 4'd5;
                       end
                   
                       4'd5: begin
                         rsel <= 4'd6;
                       end
                   
                       4'd6: begin
                         data_read[23:16] <= rdata;
                         rd_addr <= rd_addr + 1;
                         rsel <= 4'd7;
                       end
                   
                       4'd7: begin
                         rsel <= 4'd8;
                       end
                       4'd8: begin
                         data_read[31:24] <= rdata;
                         rsel <= 4'd9;
                       end
                       
                       4'd9: begin
                         rdt_brg <= data_read;  
                         ack_reg <= 1'b1;
                         done_r <= 1'b1;
                         rsel <= 4'd0;
                       end
                     endcase
                   end
           endcase  
           end
       end
   end
 
   
      assign wadr  = sel_wadr   ?  wr_addr  : wadr_if;
      assign wdata = sel_wdata  ?  byte_to_write : wdata_if;
      assign radr = sel_radr ? rd_addr : radr_if;

     // bridge ack 
      assign ack_brg = ack_reg;
      
      
      assign rdata    = sel_rdata ? 0 : rdata_din; //0 to return rdt to brg
      assign o_rdata_dout = sel_rdata ? rdata_din : 0;  //1 to return rdt to interface
      //assign rdt_brg = data_read;
      
      assign intermediate = stb_brg ? wen_brg:1'b0;
      assign wen = sel_wen ? intermediate : wen_if;
      
     // assign ack_brg = done;
      serving_ram
        #(.memfile (memfile),
          .depth   (memsize))
      ram
        (// Wishbone interface
         .i_clk (i_clk),
         .i_rst(i_rst),
         .i_waddr  (wadr),
         .i_wdata  (wdata),
         .i_wen    (wen),
         .i_raddr  (radr),
         .o_rdata  (rdata_din)
        // .i_ren    (rf_ren)
         );
        // .ack      (ack_brg));
   
      servile_rf_mem_if
        #(.depth   (memsize),
          .rf_regs (regs))
      rf_mem_if
        (// Wishbone interface
         .i_clk (i_clk),
         .i_rst (i_rst),
   
         .i_waddr  (rf_waddr),
         .i_wdata  (rf_wdata),
         .i_wen    (rf_wen),
         .i_raddr  (rf_raddr),
         .o_rdata  (rf_rdata),
         .i_ren    (rf_ren),
   
         .o_sram_waddr (wadr_if),
         .o_sram_wdata (wdata_if),
         .o_sram_wen   (wen_if),
         .o_sram_raddr (radr_if),
         .i_sram_rdata (o_rdata_dout),
         .o_sram_ren   (sram_ren),
   
         .i_wb_adr (wb_mem_adr[$clog2(memsize)-1:2]),
         .i_wb_stb (wb_mem_stb),
         .i_wb_we  (wb_mem_we) ,
         .i_wb_sel (wb_mem_sel),
         .i_wb_dat (wb_mem_dat),
         .o_wb_rdt (wb_mem_rdt),
         .o_wb_ack (wb_mem_ack));
   
      servile
        #(.reset_pc (32'h0000_0000),
          .reset_strategy (RESET_STRATEGY),
          .sim (sim),
          .rf_width(rf_width),
          .with_csr (WITH_CSR))
      servile
        (
         .i_clk       (i_clk),
         .i_rst       (i_rst),
         .i_timer_irq (i_timer_irq),
         //Memory interface
         .o_wb_mem_adr   (wb_mem_adr),
         .o_wb_mem_dat   (wb_mem_dat),
         .o_wb_mem_sel   (wb_mem_sel),
         .o_wb_mem_we    (wb_mem_we),
         .o_wb_mem_stb   (wb_mem_stb),
         .i_wb_mem_rdt   (wb_mem_rdt),
         .i_wb_mem_ack   (wb_mem_ack),
   
         //Extension interface
         .o_wb_ext_adr   (o_wb_adr),
         .o_wb_ext_dat   (o_wb_dat),
         .o_wb_ext_sel   (o_wb_sel),
         .o_wb_ext_we    (o_wb_we),
         .o_wb_ext_stb   (o_wb_stb),
         .i_wb_ext_rdt   (i_wb_rdt),
         .i_wb_ext_ack   (i_wb_ack),
   
         //RF IF
         .o_rf_waddr  (rf_waddr),
         .o_rf_wdata  (rf_wdata),
         .o_rf_wen    (rf_wen),
         .o_rf_raddr  (rf_raddr),
         .o_rf_ren    (rf_ren),
         .i_rf_rdata  (rf_rdata));
   
   
   endmodule
