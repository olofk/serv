set_property -dict { PACKAGE_PIN R2  IOSTANDARD SSTL135  } [get_ports i_clk];   #IO_L12P_T1_MRCC_34 Sch=ddr3_clk[200]
set_property -dict { PACKAGE_PIN C18 IOSTANDARD LVCMOS33 } [get_ports i_rst_n]; #IO_L11N_T1_SRCC_15

set_property -dict { PACKAGE_PIN R12 IOSTANDARD LVCMOS33 } [get_ports q];       #IO_25_14 Sch=uart_rxd_out
#set_property -dict { PACKAGE_PIN E18 IOSTANDARD LVCMOS33 } [get_ports q];       #IO_L16N_T2_A27_15 Sch=led[2]

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]

create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_clk];
