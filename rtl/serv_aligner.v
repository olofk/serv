module serv_aligner (
    input clk,rst,
    // serv_rf_top
    input wire [31:0] i_ibus_adr,
    input wire i_ibus_cyc,
    output wire [31:0] o_ibus_rdt,
    output wire o_ibus_ack,
    // servant_arbiter
    output wire [31:0] o_wb_ibus_adr,
    output wire o_wb_ibus_cyc,
    input wire [31:0] i_wb_ibus_rdt,
    input wire i_wb_ibus_ack
);

    wire [31:0] concat_ibus_rdt;
    reg addr_sel, en_ack, rdt_sel, en_reg;
    reg [15:0] lower_hw;
    
    // Datapath
    assign o_wb_ibus_adr = addr_sel ? (i_ibus_adr+32'd4) : i_ibus_adr;
    assign o_wb_ibus_cyc = i_ibus_cyc;

    assign o_ibus_ack = i_wb_ibus_ack & en_ack;
    assign o_ibus_rdt = rdt_sel ? concat_ibus_rdt : i_wb_ibus_rdt;
    
    always @(posedge clk) begin
        if(en_reg)begin
            lower_hw <= i_wb_ibus_rdt[31:16];
        end
    end

    assign concat_ibus_rdt = {i_wb_ibus_rdt[15:0],lower_hw};


    // Controller --> Moore State Machine
    // State parameters
    parameter idle = 2'b00;
    parameter fetch_al = 2'b01;
    parameter fetch_misal1 = 2'b10;
    parameter fetch_misal_ack = 2'b11;

    // State register
    reg [1:0] cs,ns;
    always @(posedge clk ) begin
        if(rst)
            cs <= idle;
        else    
            cs <= ns;
    end
    //Output logic
    always @(*) begin
        case (cs)
            idle:  begin
                    rdt_sel = 1'b0;
                    en_ack = 1'b1;
                    addr_sel = 1'b0;
                    en_reg = 1'b0;
                end
            fetch_al: begin
                    rdt_sel = 1'b0;
                    en_ack = 1'b1;
                    addr_sel = 1'b0;
                    en_reg = 1'b0;
                end
            fetch_misal1: begin
                    rdt_sel = 1'b1;
                    en_ack = 1'b0;
                    addr_sel = 1'b1;
                    en_reg = 1'b1;
                end
            fetch_misal_ack: begin
                    rdt_sel = 1'b1;
                    en_ack = 1'b1;
                    addr_sel = 1'b1;
                    en_reg = 1'b0;
                end
        endcase
    end

    // Next state Logic
    always @(* ) begin
        case (cs)
            idle:            ns = i_ibus_adr[1]&i_ibus_cyc ? fetch_misal1 : fetch_al;
            fetch_al:        ns = i_ibus_adr[1]&i_ibus_cyc ? fetch_misal1 : idle;
            fetch_misal1:    ns = fetch_misal_ack;
            fetch_misal_ack:    ns = i_wb_ibus_ack ? idle : fetch_misal_ack;
        endcase
    end

endmodule