#
# Clock / Reset
#
set_location_assignment PIN_M2 -to i_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_clk
set_location_assignment PIN_N6 -to i_rst
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_clk

#UART/GPIO
set_location_assignment PIN_M6 -to q
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to q

set_location_assignment PIN_T7 -to uart_txd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart*
