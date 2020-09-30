## Clock signal
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]
set_property PACKAGE_PIN P3 [get_ports sys_clk_n]
set_property PACKAGE_PIN R3 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_n]

create_clock -period 5.000 -name clk_p [get_nets sys_clk_p]

## UART TX
set_property PACKAGE_PIN U19 [get_ports q]
set_property IOSTANDARD LVCMOS18 [get_ports q]
