`timescale 1ns / 1ps
module debug_dtm (
    // global control
    input  wire        i_clk,
    input  wire        i_rst,
    // jtag connection
    input  wire        i_trst,
    input  wire        i_tck,
    input  wire        i_tdi,
    output wire        o_tdo,
    input  wire        i_tms,
    // Debug Module Interface (DMI) -- Request
    output wire        o_dmi_req_valid,
    input  wire        i_dmi_req_ready,
    output wire [5:0]  o_dmi_req_address,
    output wire [31:0] o_dmi_req_data,
    output wire [1:0]  o_dmi_req_op,
    // Debug Module Interface (DMI) -- Response
    input  wire        i_dmi_rsp_valid,
    output wire        o_dmi_rsp_ready,
    input  wire [31:0] i_dmi_rsp_data,
    input  wire [1:0]  i_dmi_rsp_op
);

    localparam dmi_idle_cycle    = 3'b000;
    localparam dmi_version       = 4'b0001;
    localparam dmi_address_width = 6'b000110;
    
    localparam IDCODE_VERSION = 4'b0001;
    localparam IDCODE_PARTID  = 16'h0001;
    localparam IDCODE_MANID   = 11'h70d; // Xilinx

    // TAP signal sunchronizer
    reg [2:0] tap_sync_trst_r;
    reg [2:0] tap_sync_tck_r;
    reg [2:0] tap_sync_tdi_r;
    reg [2:0] tap_sync_tms_r;
    
    wire tap_sync_trst;
    wire tap_sync_tck_rising;
    wire tap_sync_tck_falling;
    wire tap_sync_tdi;
    wire tap_sync_tms;
    
    // Update trigger
    wire dr_update_trig_valid;
    wire dr_update_trig_is_update;
    reg  dr_update_trig_is_update_r;
    

    reg r_tdo;
        
    /*===============================
    ========= TAP FSM ===============
    ================================*/
    localparam STATE_test_logic_reset = 4'hF,   // 4'b1111
             STATE_run_test_idle    = 4'hC,     // 4'b1100
             // dr state
             STATE_select_dr_scan   = 4'h7,     // 4'b0111
             STATE_capture_dr       = 4'h6,     // 4'b0110
             STATE_shift_dr         = 4'h2,     // 4'b0010
             STATE_exit1_dr         = 4'h1,     // 4'b0001
             STATE_pause_dr         = 4'h3,     // 4'b0011
             STATE_exit2_dr         = 4'h0,     // 4'b0000
             STATE_update_dr        = 4'h5,     // 4'b0101
             // ir state
             STATE_select_ir_scan   = 4'h4,     // 4'b0100
             STATE_capture_ir       = 4'hE,     // 4'b1110
             STATE_shift_ir         = 4'hA,     // 4'b1010
             STATE_exit1_ir         = 4'h9,     // 4'b1001
             STATE_pause_ir         = 4'hB,     // 4'b1011
             STATE_exit2_ir         = 4'h8,     // 4'b1000
             STATE_update_ir        = 4'hD;     // 4'b1101
    
    // Tap fsm registers
    reg  [3:0] tap_ctrl_state, tap_ctrl_next_state;
    
    // Tap register
    reg  [4:0]  tap_reg_ireg;
    reg         tap_reg_bypass;
    reg  [31:0] tap_reg_idcode;
    reg  [31:0] tap_reg_dtmcs;
    wire [31:0] tap_reg_dtmcs_nxt;
    reg  [39:0] tap_reg_dmi;         // 6-bit address, 32-bit data, 2-bit operation
    wire [39:0] tap_reg_dmi_nxt;     // 6-bit address, 32-bit data, 2-bit operation
    
    always @(posedge i_clk)
        if (i_rst || !tap_sync_trst) tap_ctrl_state <= STATE_test_logic_reset;
        else if (tap_sync_tck_rising) tap_ctrl_state <= tap_ctrl_next_state;
    
    always @(*)
        case (tap_ctrl_state)
            STATE_test_logic_reset: tap_ctrl_next_state = tap_sync_tms? STATE_test_logic_reset  : STATE_run_test_idle;
            STATE_run_test_idle:    tap_ctrl_next_state = tap_sync_tms? STATE_select_dr_scan    : STATE_run_test_idle;
            // DR scan
            STATE_select_dr_scan:   tap_ctrl_next_state = tap_sync_tms? STATE_select_ir_scan    : STATE_capture_dr;
            STATE_capture_dr:       tap_ctrl_next_state = tap_sync_tms? STATE_exit1_dr          : STATE_shift_dr;
            STATE_shift_dr:         tap_ctrl_next_state = tap_sync_tms? STATE_exit1_dr          : STATE_shift_dr;
            STATE_exit1_dr:         tap_ctrl_next_state = tap_sync_tms? STATE_update_dr         : STATE_pause_dr;
            STATE_pause_dr:         tap_ctrl_next_state = tap_sync_tms? STATE_exit2_dr          : STATE_pause_dr;
            STATE_exit2_dr:         tap_ctrl_next_state = tap_sync_tms? STATE_update_dr         : STATE_shift_dr;
            STATE_update_dr:        tap_ctrl_next_state = tap_sync_tms? STATE_select_dr_scan    : STATE_run_test_idle;
            // IR scan
            STATE_select_ir_scan:   tap_ctrl_next_state = tap_sync_tms? STATE_test_logic_reset  : STATE_capture_ir;
            STATE_capture_ir:       tap_ctrl_next_state = tap_sync_tms? STATE_exit1_ir          : STATE_shift_ir;
            STATE_shift_ir:         tap_ctrl_next_state = tap_sync_tms? STATE_exit1_ir          : STATE_shift_ir;
            STATE_exit1_ir:         tap_ctrl_next_state = tap_sync_tms? STATE_update_ir         : STATE_pause_ir;
            STATE_pause_ir:         tap_ctrl_next_state = tap_sync_tms? STATE_exit2_ir          : STATE_pause_ir;
            STATE_exit2_ir:         tap_ctrl_next_state = tap_sync_tms? STATE_update_ir         : STATE_shift_ir;
            STATE_update_ir:        tap_ctrl_next_state = tap_sync_tms? STATE_select_dr_scan    : STATE_run_test_idle;
            default:                tap_ctrl_next_state = STATE_test_logic_reset;
        endcase
          
    /*===============================
    ========== DMI FSM ==============
    ================================*/
    localparam DMI_STATE_Idle       = 0,
              DMI_STATE_read_wait  = 1,
              DMI_STATE_read       = 2,
              DMI_STATE_read_busy  = 3,
              DMI_STATE_write_wait = 4,
              DMI_STATE_write      = 5,
              DMI_STATE_write_busy = 6;    
    
    // DMI fsm register
    reg [2:0] dmi_ctrl_state;
    
    // DMI register
    reg        dmi_hard_reset;
    reg        dmi_reset;
    reg [1:0]  dmi_rsp; // response status
    reg [31:0] dmi_rdata;
    reg [31:0] dmi_wdata;
    reg [5:0]  dmi_addr;
    
    always @(posedge i_clk) begin
        if (i_rst || dmi_hard_reset) dmi_ctrl_state <= DMI_STATE_Idle;
        else
            case (dmi_ctrl_state)
                DMI_STATE_Idle: 
                    if ((dr_update_trig_valid == 1'b1) && (tap_reg_ireg == 5'b10001))
                        if (tap_reg_dmi[1:0] == 2'b01) // read
                            dmi_ctrl_state <= DMI_STATE_read_wait;
                        else if (tap_reg_dmi[1:0] == 2'b10) // write
                            dmi_ctrl_state <= DMI_STATE_write_wait;
                // Read state
                DMI_STATE_read_wait:
                    if (i_dmi_req_ready == 1'b1)
                        dmi_ctrl_state <= DMI_STATE_read;
                DMI_STATE_read: dmi_ctrl_state <= DMI_STATE_read_busy;
                DMI_STATE_read_busy: // pending read access
                    if (i_dmi_rsp_valid)
                        dmi_ctrl_state <= DMI_STATE_Idle;
                // Write state
                DMI_STATE_write_wait:
                    if (i_dmi_req_ready == 1'b1)
                        dmi_ctrl_state <= DMI_STATE_write;
                DMI_STATE_write: dmi_ctrl_state <= DMI_STATE_write_busy;
                DMI_STATE_write_busy: // pending write access
                    if (i_dmi_rsp_valid == 1'b1)
                        dmi_ctrl_state <= DMI_STATE_Idle;
                default: dmi_ctrl_state <= DMI_STATE_Idle;
            endcase
    end
    
    /*================================
    //======== RTL ===================
    ================================*/
    // JTAG synchronize
    always @(posedge i_clk)
        if (i_rst) begin
            tap_sync_trst_r <= 3'b000;
            tap_sync_tck_r  <= 3'b000;
            tap_sync_tdi_r  <= 3'b000;
            tap_sync_tms_r  <= 3'b000;
        end
        else begin
            tap_sync_trst_r <= {tap_sync_trst_r[1:0], i_trst};
            tap_sync_tck_r  <= {tap_sync_tck_r[1:0], i_tck};
            tap_sync_tdi_r  <= {tap_sync_tdi_r[1:0], i_tdi};
            tap_sync_tms_r  <= {tap_sync_tms_r[1:0], i_tms};
        end
    
    // JTAG reset
    assign tap_sync_trst = |tap_sync_trst_r[2:1];
    
    // JTAG clock edge
    assign tap_sync_tck_rising  = tap_sync_tck_r[2:1] == 2'b01;
    assign tap_sync_tck_falling = tap_sync_tck_r[2:1] == 2'b10;
    
    // JTAG test mode select
    assign tap_sync_tms = tap_sync_tms_r[2];
    
    // JTAG data input
    assign tap_sync_tdi = tap_sync_tdi_r[2];
    
    always @(posedge i_clk) begin
        if (i_rst) begin
            tap_reg_ireg <= 5'b00000;
            tap_reg_bypass <= 1'b0;
            tap_reg_idcode <= 32'd0;
            tap_reg_dtmcs <= 32'd0;
            tap_reg_dmi <= 40'd0;
            r_tdo <= 1'b0;
        end
        else begin
            // Serial data input: Instruction register
            if ((tap_ctrl_state == STATE_test_logic_reset) || (tap_ctrl_state == STATE_capture_ir)) // preload phase
                tap_reg_ireg <= 5'b00001; // get id
            else if (tap_ctrl_state == STATE_shift_ir) // access phase
                if (tap_sync_tck_rising == 1'b1)
                    tap_reg_ireg <= {tap_sync_tdi, tap_reg_ireg[4:1]};
                    
            // Serial data input: data register
            if (tap_ctrl_state == STATE_capture_dr) begin // preload phase
                if (tap_reg_ireg == 5'b00001) tap_reg_idcode <= {IDCODE_VERSION, IDCODE_PARTID, IDCODE_MANID, 1'b1};
                if (tap_reg_ireg == 5'b10000) tap_reg_dtmcs  <= tap_reg_dtmcs_nxt;
                if (tap_reg_ireg == 5'b10001) tap_reg_dmi <= tap_reg_dmi_nxt;
                if (!(tap_reg_ireg == 5'b00001) && !(tap_reg_ireg == 5'b10000) && !(tap_reg_ireg == 5'b10001))
                    tap_reg_bypass <= 1'b0;
            end
            else if (tap_ctrl_state == STATE_shift_dr) begin // access phase
                if (tap_sync_tck_rising == 1'b1) begin
                    if (tap_reg_ireg == 5'b00001) tap_reg_idcode <= {tap_sync_tdi, tap_reg_idcode[31:1]};
                    if (tap_reg_ireg == 5'b10000) tap_reg_dtmcs  <= {tap_sync_tdi, tap_reg_dtmcs[31:1]};
                    if (tap_reg_ireg == 5'b10001) tap_reg_dmi    <= {tap_sync_tdi, tap_reg_dmi[39:1]};
                    if (!(tap_reg_ireg == 5'b00001) && !(tap_reg_ireg == 5'b10000) && !(tap_reg_ireg == 5'b10001))
                        tap_reg_bypass <= tap_sync_tdi;
                end                
            end
            
            // Serial data output
            if (tap_sync_tck_falling == 1'b1) // Update TDO
                if (tap_ctrl_state == STATE_shift_ir)
                    r_tdo <= tap_reg_ireg[0];
                else
                    case (tap_reg_ireg)
                        5'b00001: r_tdo <= tap_reg_idcode[0];
                        5'b10000: r_tdo <= tap_reg_dtmcs[0];
                        5'b10001: r_tdo <= tap_reg_dmi[0];
                        default:  r_tdo <= tap_reg_bypass;
                    endcase
        end
    end
    
    // DTM Control and Status Register
    assign tap_reg_dtmcs_nxt[31:18] = 14'd0; // unused
    assign tap_reg_dtmcs_nxt[17]    = 1'b0;  // dmihardreset
    assign tap_reg_dtmcs_nxt[16]    = 1'b0;  // dmireset
    assign tap_reg_dtmcs_nxt[15]    = 1'b0;  // unused
    assign tap_reg_dtmcs_nxt[14:12] = dmi_idle_cycle; // minimum number of idle cycles
    assign tap_reg_dtmcs_nxt[11:10] = tap_reg_dmi_nxt[1:0]; // dmistat
    assign tap_reg_dtmcs_nxt[9:4]   = dmi_address_width; // number of DMI address bits
    assign tap_reg_dtmcs_nxt[3:0]   = dmi_version; // dmi version
    // DMI register read
    assign tap_reg_dmi_nxt[39:34] = dmi_addr;
    assign tap_reg_dmi_nxt[33:2]  = dmi_rdata;
    assign tap_reg_dmi_nxt[1:0]   = (dmi_ctrl_state != DMI_STATE_Idle)? 2'b11: dmi_rsp;
    
    always @(posedge i_clk) begin
        if (i_rst) begin
            dmi_hard_reset <= 1'b1;
            dmi_reset      <= 1'b1;
            dmi_rsp        <= 2'b00;
            dmi_rdata      <= 32'd0;
            dmi_wdata      <= 32'd0;
            dmi_addr       <= 6'd0;
        end
        else begin
            // reset flag
            if ((dr_update_trig_valid == 1'b1) && (tap_reg_ireg == 5'b10000))
                dmi_hard_reset <= tap_reg_dtmcs[17];
            else dmi_hard_reset <= 1'b0;
            
            if ((dr_update_trig_valid == 1'b1) && (tap_reg_ireg == 5'b10000))
                dmi_reset <= tap_reg_dtmcs[16];
            else dmi_reset <= 1'b0;
            
            // response flag
            if (dmi_hard_reset || dmi_reset) dmi_rsp <= 2'b00;
            else if ((dmi_ctrl_state != DMI_STATE_Idle) && 
                     (dr_update_trig_valid == 1'b1)     &&
                     (tap_reg_ireg == 5'b10001))
                dmi_rsp <= 2'b11;
            else if ((dmi_ctrl_state == DMI_STATE_read_busy) || (dmi_ctrl_state == DMI_STATE_write_busy))
                dmi_rsp <= dmi_rsp | i_dmi_rsp_op; 
                
            // DMI read data
            if (dmi_ctrl_state == DMI_STATE_read_busy) dmi_rdata <= i_dmi_rsp_data;
            
            // DMI write data
            if ((dmi_ctrl_state == DMI_STATE_Idle) &&
                (dr_update_trig_valid == 1'b1)     &&
                (tap_reg_ireg == 5'b10001))
                dmi_wdata <= tap_reg_dmi[33:2];
                
            // DMI access address
            if ((dmi_ctrl_state == DMI_STATE_Idle) &&
                (dr_update_trig_valid == 1'b1)     &&
                (tap_reg_ireg == 5'b10001))
                dmi_addr <= tap_reg_dmi[39:34];                                              
        end
    end
     
    // trigger for Update state
    always @(posedge i_clk) begin
        if (i_rst) dr_update_trig_is_update_r <= 1'b0;
        else dr_update_trig_is_update_r <= dr_update_trig_is_update;
    end
        
    assign dr_update_trig_is_update = tap_ctrl_state == STATE_update_dr;
    assign dr_update_trig_valid     = (dr_update_trig_is_update == 1'b1) && (dr_update_trig_is_update_r == 1'b0);

    // JTAG interface
    assign o_tdo = r_tdo;
    
    // DMI interface request
    assign o_dmi_req_valid   = (dmi_ctrl_state == DMI_STATE_read) || (dmi_ctrl_state == DMI_STATE_write);
    assign o_dmi_req_address = dmi_addr;
    assign o_dmi_req_data    = dmi_wdata;
    assign o_dmi_req_op      = tap_reg_dmi[1:0];
    // DMI interface response
    assign o_dmi_rsp_ready   = (dmi_ctrl_state == DMI_STATE_read_busy) || (dmi_ctrl_state == DMI_STATE_write_busy);    
    
endmodule
