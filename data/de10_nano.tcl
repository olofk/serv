set_location_assignment PIN_V11 -to i_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_clk

set_location_assignment PIN_W15 -to q
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to q

# GPIO0 Pin 1
set_location_assignment PIN_Y15 -to uart_txd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart_txd

#KEY[0]
set_location_assignment PIN_AH17 -to i_rst_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_rst_n
