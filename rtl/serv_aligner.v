module serv_aligner 
   (
    input wire clk,
    input wire rst,
    // serv_top
    input  wire [31:0]  i_ibus_adr,
    input  wire         i_ibus_cyc,
    output wire [31:0]  o_ibus_rdt,
    output wire         o_ibus_ack,
    // serv_rf_top
    output wire [31:0]  o_wb_ibus_adr,
    output wire         o_wb_ibus_cyc,
    input  wire [31:0]  i_wb_ibus_rdt,
    input  wire         i_wb_ibus_ack);

    wire [31:0] concat_ibus_rdt;
    wire        misal_sel;
    wire        en_ack;
    
    reg [15:0]  lower_hw;    
    reg         misal_ack ; 

    assign o_wb_ibus_adr = misal_sel ? (i_ibus_adr+32'd4) : i_ibus_adr;
    assign o_wb_ibus_cyc = i_ibus_cyc;
    assign o_ibus_ack = i_wb_ibus_ack & en_ack;
    assign o_ibus_rdt = misal_sel ? concat_ibus_rdt : i_wb_ibus_rdt;
            
    always @(posedge clk) begin
        if(i_wb_ibus_ack)begin
            lower_hw <= i_wb_ibus_rdt[31:16];
        end
    end

    assign concat_ibus_rdt = {i_wb_ibus_rdt[15:0],lower_hw};
    
    assign en_ack   = !(i_ibus_adr[1] & !misal_ack);
    assign misal_sel  = misal_ack; 

    always @(posedge clk ) begin
        if(rst)
            misal_ack <= 0;
        else if(i_wb_ibus_ack & i_ibus_adr[1])
            misal_ack <= ~misal_ack;
    end

endmodule
