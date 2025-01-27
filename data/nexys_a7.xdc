## 100 MHz Clock Signal (period 10)
set_property -dict { PACKAGE_PIN E3   IOSTANDARD LVCMOS33 } [get_ports { i_clk }];
create_clock -add -name sys_clk_pin -period 10 -waveform {0 5} [get_ports { i_clk }];

## External interrupt (to BTNL)
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports {ext_irq}];

## LEDs (LED0)
set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { q }];

## UART
set_property -dict { PACKAGE_PIN D4   IOSTANDARD LVCMOS33 } [get_ports { o_uart_tx }];

set_property -dict { PACKAGE_PIN C12   IOSTANDARD LVCMOS33 } [get_ports { i_rst }]; # ACTIVE LOW !!!

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

## DEBUG (JA1)
#set_property -dict { PACKAGE_PIN C17   IOSTANDARD LVCMOS33 } [get_ports { debug_wb_clk }];      #JA1
#set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { q }];                 #JA2
#set_property -dict { PACKAGE_PIN E18   IOSTANDARD LVCMOS33 } [get_ports { debug_sleep_req }];   #JA3
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { debug_wakeup_req }];  #JA4
