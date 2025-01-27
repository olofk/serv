## 100 MHz Clock Signal (period 10)
set_property -dict { PACKAGE_PIN E3   IOSTANDARD LVCMOS33 } [get_ports { i_clk }];
create_clock -add -name sys_clk_pin -period 10 -waveform {0 5} [get_ports { i_clk }];

## External interrupt (to BTNL)
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports {ext_irq}];

## LEDs
set_property -dict { PACKAGE_PIN T8   IOSTANDARD LVCMOS33 } [get_ports { q }];

## UART
set_property -dict { PACKAGE_PIN D4   IOSTANDARD LVCMOS33 } [get_ports { o_uart_tx }];

set_property -dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS33 } [get_ports { i_rst }]; # ACTIVE LOW !!!

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
