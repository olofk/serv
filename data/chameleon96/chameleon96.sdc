# Main system clock (100 Mhz)
create_clock -name "clk" -period 10.000ns [get_pins -compatibility_mode u0|clocks_resets|h2f_user0_clk]

# Automatically constrain PLL and other generated clocks
derive_pll_clocks -create_base_clocks

# Automatically calculate clock uncertainty to jitter and other effects.
derive_clock_uncertainty
