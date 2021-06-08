set_location_assignment PIN_AF14 -to i_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_clk

set_location_assignment PIN_AA14 -to i_rst_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_rst_n

set_location_assignment PIN_V16 -to q
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to q

set_location_assignment PIN_AC18 -to uart_txd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart*
