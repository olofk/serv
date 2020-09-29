set_location_assignment PIN_R8 -to i_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_clk

set_location_assignment PIN_A15 -to q
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to q

set_location_assignment PIN_D11 -to uart_txd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart_txd

set_location_assignment PIN_J15 -to i_rst_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_rst_n
