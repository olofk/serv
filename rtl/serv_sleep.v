`default_nettype none
module serv_sleep
   (
    input wire  i_clk,
    input wire  i_rst,
    input wire  i_timer_irq,
    input wire  i_external_irq,
    input wire  i_cnt0,
    input wire  i_wfi,
    input wire  i_init,
    input wire  i_mtie,
    input wire  i_meie,

    output wire o_sleep_req,
    output wire o_wakeup_req);

   assign o_sleep_req = i_wfi & i_cnt0 & i_init;
   assign o_wakeup_req = (i_timer_irq & i_mtie) | (i_external_irq & i_meie);

endmodule
