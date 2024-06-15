## Clock signal
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports i_clk];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_clk];

## Reset
set_property -dict {PACKAGE_PIN P6  IOSTANDARD LVCMOS33 } [get_ports i_rst_n];

## LED
## set_property -dict { PACKAGE_PIN L14 IOSTANDARD LVCMOS33 } [get_ports q];

## USB Serial output
set_property -dict { PACKAGE_PIN P16 IOSTANDARD LVCMOS33 } [get_ports q]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

