#MAX10_CLK2_50  3.3V
set_location_assignment PIN_27 -to i_clk
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_clk

#LED[0]
set_location_assignment PIN_132 -to q
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to q

#P8 3 ARDUINO_IO1   
set_location_assignment PIN_75 -to uart_txd
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to uart_txd

#KEY[0]
set_location_assignment PIN_121 -to i_rst_n
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to i_rst_n

#  Configuration mode that allows Memory Initialisation
set_global_assignment -name INTERNAL_FLASH_UPDATE_MODE "SINGLE IMAGE WITH ERAM"

# Generate SVF File for openFPGALoader
set_global_assignment -name GENERATE_SVF_FILE ON
# set_global_assignment -name GENERATE_JBC_FILE ON
set_global_assignment -name GENERATE_JAM_FILE ON

