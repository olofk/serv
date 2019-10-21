# Main system clock (12 Mhz)
create_clock -name "clk" -period 83.333ns [get_ports {i_clk}]

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty
