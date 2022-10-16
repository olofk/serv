set_property -dict {PACKAGE_PIN E3  IOSTANDARD LVCMOS33 } [get_ports i_clk];

set_property -dict {PACKAGE_PIN C2  IOSTANDARD LVCMOS33 } [get_ports i_rst_n];

set_property -dict {PACKAGE_PIN D10  IOSTANDARD LVCMOS33 } [get_ports q]

#set_property -dict {PACKAGE_PIN H5  IOSTANDARD LVCMOS33 } [get_ports q]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_clk];
