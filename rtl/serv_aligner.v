module serv_aligner 
   (input wire clk,
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

    localparam fetch_align = 2'b00;
    localparam fetch_misal = 2'b01;
    localparam fetch_ack   = 2'b10;

    wire [31:0] concat_ibus_rdt;

    reg         addr_sel;
    reg         en_ack;
    reg         rdt_sel;
    reg         en_reg;
    reg [15:0]  lower_hw;      

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
    // State register
    reg [1:0] fsm_cs,fsm_ns;
    always @(posedge clk ) begin
        if(rst)
            fsm_cs <= fetch_align;
        else    
            fsm_cs <= fsm_ns;
    end
    //Output logic
    always @(*) begin
        case (fsm_cs)
            fetch_align:  begin
                rdt_sel = 1'b0;
                en_ack = 1'b1;
                addr_sel = 1'b0;
                en_reg = 1'b0;
                end
            fetch_misal: begin
                rdt_sel = 1'b1;
                en_ack = 1'b0;
                addr_sel = 1'b1;
                en_reg = 1'b1;
                end
            fetch_ack: begin
                rdt_sel = 1'b1;
                en_ack = 1'b1;
                addr_sel = 1'b1;
                en_reg = 1'b0;
                end    
            default:;
        endcase
    end

    // Next state Logic
    always @(* ) begin
        case (fsm_cs)
            fetch_align     :    fsm_ns = i_ibus_adr[1]&i_ibus_cyc ? fetch_misal : fetch_align;
            fetch_misal     :    fsm_ns = fetch_ack;
            fetch_ack       :    fsm_ns = i_wb_ibus_ack ? fetch_align : fetch_ack;
            default         :    ;
        endcase
    end 
    
endmodule


        