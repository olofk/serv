`timescale 1ns / 1ps

module ServCore #(
    parameter AW             = 13,
    parameter USER_WIDTH     = 0,
    parameter ID_WIDTH       = 0,
    parameter memfile        = "",
    parameter memsize        = 8192,
    parameter sim            = 1'b0,
    parameter RESET_STRATEGY = "MINI",
    parameter WITH_CSR       = 1
)(
    input  wire clk,
    input  wire rst,
    input  wire i_timer_irq,

    // WB2AXI AXI SIGNALS FROM BRIDGE TO EXTERNAL
    output wire [AW-1:0]         o_awmaddr,
    output wire                  o_awmvalid,
    input  wire                  i_awmready,
    output wire [ID_WIDTH:0]   o_awm_id,
    output wire [7:0]            o_awm_len,
    output wire [2:0]            o_awm_size,
    output wire [1:0]            o_awm_burst,
    output wire                  o_awm_lock,
    output wire [3:0]            o_awm_cache,
    output wire [2:0]            o_awm_prot,
    output wire [3:0]            o_awm_qos,
    output wire [3:0]            o_awm_region,
    output wire [5:0]            o_awm_atop,
    output wire [USER_WIDTH:0] o_awm_user,

    output wire [AW-1:0]         o_armaddr,
    output wire                  o_armvalid,
    input  wire                  i_armready,
    output wire [ID_WIDTH:0]   o_arm_id,
    output wire [7:0]            o_arm_len,
    output wire [2:0]            o_arm_size,
    output wire [1:0]            o_arm_burst,
    output wire                  o_arm_lock,
    output wire [3:0]            o_arm_cache,
    output wire [2:0]            o_arm_prot,
    output wire [3:0]            o_arm_qos,
    output wire [3:0]            o_arm_region,
    output wire [USER_WIDTH:0] o_arm_user,

    output wire [31:0]           o_wmdata,
    output wire [3:0]            o_wmstrb,
    output wire                  o_wmvalid,
    input  wire                  i_wmready,
    output wire                  o_wm_last,
    output wire [USER_WIDTH:0] o_wm_user,

    input  wire [1:0]            i_bmresp,
    input  wire                  i_bmvalid,
    output wire                  o_bmready,
    input  wire [ID_WIDTH:0]   i_bm_id,
    input  wire [USER_WIDTH:0] i_bm_user,

    input  wire [31:0]           i_rmdata,
    input  wire [1:0]            i_rmresp,
    input  wire                  i_rmlast,
    input  wire                  i_rmvalid,
    output wire                  o_rmready,
    input  wire [ID_WIDTH:0]   i_rm_id,
    input  wire [USER_WIDTH:0] i_rm_user,

    // AXI2WB SIGNALS FROM AXI TO SERVING
    input  wire [AW-1:0] i_awaddr,
    input  wire          i_awvalid,
    output wire          o_awready,
    input  wire [ID_WIDTH:0]    i_awid,
    input  wire [7:0]           i_awlen,
    input  wire [2:0]           i_awsize,
    input  wire [1:0]           i_awburst,
    input  wire                 i_awlock,
    input  wire [3:0]           i_awcache,
    input  wire [2:0]           i_awprot,
    input  wire [3:0]           i_awqos,
    input  wire [3:0]            i_awregion,
    input  wire [USER_WIDTH:0]  i_awuser,
    input wire [5:0]            i_awtop, 
    
    input  wire [AW-1:0] i_araddr,
    input  wire          i_arvalid,
    output wire          o_arready,
    input  wire [ID_WIDTH:0]    i_arid,
    input  wire [7:0]           i_arlen,
    input  wire [2:0]           i_arsize,
    input  wire [1:0]           i_arburst,
    input  wire                 i_arlock,
    input  wire [3:0]           i_arcache,
    input  wire [2:0]           i_arprot,
    input  wire [3:0]           i_arqos,
    input  wire [3:0]           i_arregion,
    input  wire [USER_WIDTH:0]  i_aruser

    
    input  wire [31:0]   i_wdata,
    input  wire [3:0]    i_wstrb,
    input  wire          i_wvalid,
    output wire          o_wready,
    input  wire                 i_wlast,
    input  wire [USER_WIDTH:0]  i_wuser,
    
    output wire [1:0]    o_bresp,
    output wire          o_bvalid,
    input  wire          i_bready,
    output wire [ID_WIDTH:0]     o_bid,
    output wire [USER_WIDTH:0]   o_buser,
    
    output wire [31:0]   o_rdata,
    output wire [1:0]    o_rresp,
    output wire          o_rlast,
    output wire          o_rvalid,
    input  wire          i_rready,
    output wire [ID_WIDTH:0]     o_rid,
    output wire [USER_WIDTH:0]   o_ruser    
);

    // Internal Wishbone interface (SERV <-> Bridge)
    wire [AW-1:2] i_swb_adr;
    wire [31:0]   i_swb_dat;
    wire [3:0]    i_swb_sel;
    wire         i_swb_we;
    wire         i_swb_stb;
    wire [31:0]  o_swb_rdt;
    wire         o_swb_ack;

    // External Wishbone interface (Bridge <-> SERV)
    wire [AW-1:2] o_mwb_adr;
    wire [31:0]   o_mwb_dat;
    wire [3:0]    o_mwb_sel;
    wire         o_mwb_we;
    wire         o_mwb_stb;
    wire [31:0]   i_mwb_rdt;
    wire          i_mwb_ack;

    // Bridge <-> SERV mux control
    wire sel_wadr, sel_wdata, sel_radr, sel_rdata, sel_wen;

       // Tie off unused AXI signals
    assign o_bid=1'b0;
    assign o_buser=1'b0;

    assign o_rid=1'b0;
    assign o_ruser=1'b0;
    
    assign o_awm_id     = 1'b0;
    assign o_awm_len    = 8'b0;
    assign o_awm_size   = 3'b0;
    assign o_awm_burst  = 2'b0;
    assign o_awm_lock   = 1'b0;
    assign o_awm_cache  = 4'b0;
    assign o_awm_prot   = 3'b0;
    assign o_awm_qos    = 4'b0;
    assign o_awm_region = 4'b0;
    assign o_awm_atop   = 6'b0;
    assign o_awm_user   = 1'b0;

    assign o_wm_last    = 1'b0;
    assign o_wm_user    = 1'b0;
    
    assign o_arm_id     = 1'b0;
    assign o_arm_len    = 8'b0;
    assign o_arm_size   = 3'b0;
    assign o_arm_burst  = 2'b0;
    assign o_arm_lock   = 1'b0;
    assign o_arm_cache  = 4'b0;
    assign o_arm_prot   = 3'b0;
    assign o_arm_qos    = 4'b0;
    assign o_arm_region = 4'b0;
    assign o_arm_user   = 1'b0;

    // Instantiate SERV-based SoC
    serving #(
        .memfile(memfile),
        .memsize(memsize),
        .sim(sim),
        .RESET_STRATEGY(RESET_STRATEGY),
        .WITH_CSR(WITH_CSR)
    ) serving (
        .i_clk(clk),
        .i_rst(rst),
        .i_timer_irq(i_timer_irq),

        // Master WB (SERV → Bridge)
        .o_wb_addr(), // optional full address
        .o_wb_adr(i_swb_adr),
        .o_wb_dat(i_swb_dat),
        .o_wb_sel(i_swb_sel),
        .o_wb_we(i_swb_we),
        .o_wb_stb(i_swb_stb),
        .i_wb_rdt(o_swb_rdt),
        .i_wb_ack(o_swb_ack),

        // Slave WB (Bridge → SERV)
        .adr_brg(o_mwb_adr),
        .data_brg(o_mwb_dat),
        .stb_brg(o_mwb_stb),
        .wen_brg(o_mwb_we),
        .sel_brg(o_mwb_sel),
        .rdt_brg(i_mwb_rdt),
        .ack_brg(i_mwb_ack),

        // mux selection signals from bridge
        .sel_wadr(sel_wadr),
        .sel_wdata(sel_wdata),
        .sel_radr(sel_radr),
        .sel_rdata(sel_rdata),
        .sel_wen(sel_wen)
    );

    // Instantiate AXI-Wishbone bridge
    complete_bridge #(.AW(AW)) bridge (
        .i_clk(clk),
        .i_rst(rst),

        // Wishbone slave (SERV master → Bridge)
        .i_swb_adr(i_swb_adr),
        .i_swb_dat(i_swb_dat),
        .i_swb_sel(i_swb_sel),
        .i_swb_we(i_swb_we),
        .i_swb_stb(i_swb_stb),
        .o_swb_rdt(o_swb_rdt),
        .o_swb_ack(o_swb_ack),

        // Wishbone master (Bridge → SERV slave)
        .o_mwb_adr(o_mwb_adr),
        .o_mwb_dat(o_mwb_dat),
        .o_mwb_sel(o_mwb_sel),
        .o_mwb_we(o_mwb_we),
        .o_mwb_stb(o_mwb_stb),
        .i_mwb_rdt(i_mwb_rdt),
        .i_mwb_ack(i_mwb_ack),

        // AXI slave (external → bridge)
        .i_awaddr(i_awaddr),
        .i_awvalid(i_awvalid),
        .o_awready(o_awready),
        .i_araddr(i_araddr),
        .i_arvalid(i_arvalid),
        .o_arready(o_arready),
        .i_wdata(i_wdata),
        .i_wstrb(i_wstrb),
        .i_wvalid(i_wvalid),
        .o_wready(o_wready),
        .o_bresp(o_bresp),
        .o_bvalid(o_bvalid),
        .i_bready(i_bready),
        .o_rdata(o_rdata),
        .o_rresp(o_rresp),
        .o_rlast(o_rlast),
        .o_rvalid(o_rvalid),
        .i_rready(i_rready),

        // AXI master (bridge → external)
        .o_awmaddr(o_awmaddr),
        .o_awmvalid(o_awmvalid),
        .i_awmready(i_awmready),
        .o_armaddr(o_armaddr),
        .o_armvalid(o_armvalid),
        .i_armready(i_armready),
        .o_wmdata(o_wmdata),
        .o_wmstrb(o_wmstrb),
        .o_wmvalid(o_wmvalid),
        .i_wmready(i_wmready),
        .i_bmresp(i_bmresp),
        .i_bmvalid(i_bmvalid),
        .o_bmready(o_bmready),
        .i_rmdata(i_rmdata),
        .i_rmresp(i_rmresp),
        .i_rmlast(i_rmlast),
        .i_rmvalid(i_rmvalid),
        .o_rmready(o_rmready),

        // mux selection outputs
        .sel_wadr(sel_wadr),
        .sel_wdata(sel_wdata),
        .sel_radr(sel_radr),
        .sel_rdata(sel_rdata),
        .sel_wen(sel_wen)
    );

endmodule

 

   
