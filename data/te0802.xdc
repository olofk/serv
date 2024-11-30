## Clock signal
set_property -dict { PACKAGE_PIN J3 IOSTANDARD LVCMOS18 } [get_ports i_clk];
create_clock -add -name sys_clk_pin -period 40.00 [get_ports i_clk];

## LED 0
set_property -dict { PACKAGE_PIN P1 IOSTANDARD LVCMOS18 } [get_ports o_led_0];

# PMOD A, Connector J5
# Connector pin, Package pin, PMOD type 4 UART
# 1, F8, CTS 
# 2, F7, TXD
# 3, E6, RXD
# 4, E5, RTS
# 5, GND
# 6, VCC
# 7, G6, 
# 8, G5, 
# 9, C8, 
# 10, C7, 
# 11, GND
# 12, VCC
set_property -dict { PACKAGE_PIN F7 IOSTANDARD LVCMOS33 } [get_ports o_uart_tx] 
