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

    // AXI2WB AXI SIGNALS FROM BRIDGE TO EXTERNAL
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
    input  wire [USER_WIDTH:0] i_rm_user
);

    // Internal Wishbone signals (SERV <-> BRIDGE)
    wire [AW-1:2] i_swb_adr;
    wire [31:0]   i_swb_dat;
    wire [3:0]    i_swb_sel;
    wire         i_swb_we;
    wire         i_swb_stb;
    wire [31:0]  o_swb_rdt;
    wire         o_swb_ack;

    // Tie off unused AXI signals
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
        .o_wb_adr(i_swb_adr),
        .o_wb_dat(i_swb_dat),
        .o_wb_sel(i_swb_sel),
        .o_wb_we(i_swb_we),
        .o_wb_stb(i_swb_stb),
        .i_wb_rdt(o_swb_rdt),
        .i_wb_ack(o_swb_ack)
    );

    // Instantiate AXI-Wishbone bridge
    complete_bridge #(.AW(AW)) uut (
        .i_clk(clk),
        .i_rst(rst),
        .i_swb_adr(i_swb_adr),
        .i_swb_dat(i_swb_dat),
        .i_swb_sel(i_swb_sel),
        .i_swb_we(i_swb_we),
        .i_swb_stb(i_swb_stb),
        .o_swb_rdt(o_swb_rdt),
        .o_swb_ack(o_swb_ack),
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
        .o_rmready(o_rmready)
    );

endmodule

