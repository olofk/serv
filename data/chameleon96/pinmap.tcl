#
# Clock / Reset
#
# set_location_assignment PIN_xxxx -to i_clk
# No direct clock. Using internal HPS clock

#
# GPIO
#
# LED  Y19 Yellow WIFI, Y20 Blue Bluetooth
set_location_assignment PIN_Y19 -to q
set_instance_assignment -name IO_STANDARD "2.5 V" -to q

# FPGA_1V8_HPS_EXP_UART1_TXD_PIN_W14      Pin 5  Low speed connector  (WHITE C96 USB/serial cable)    Pin 1 GND
set_location_assignment PIN_W14 -to uart_txd
set_instance_assignment -name IO_STANDARD "1.8 V" -to uart_txd

# No reset button wired to FPGA
# set_location_assignment PIN_xxx -to i_rst_n

