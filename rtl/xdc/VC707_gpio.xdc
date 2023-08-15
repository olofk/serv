#################################################################################
## VC707 with XM105 (FMC1 + FMC2) Constraints File
## Author: Binh Kieu-Do-Nguyen
#################################################################################

#################################################################################
## CLOCKS
#################################################################################
# SYSCLK 200MHz
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVDS} [get_ports SYSCLK_P];
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVDS} [get_ports SYSCLK_N];
create_clock -period 5.000 -name sys_clk_pin -waveform {0.000 2.500} -add [get_ports SYSCLK_P];
create_clock -period 5.000 -name sys_clk_pin -waveform {0.000 2.500} -add [get_ports SYSCLK_N];

# User Clock
#set_property -dict {PACKAGE_PIN AK34 IOSTANDARD LVDS} [get_ports USER_CLOCK_P];
#set_property -dict {PACKAGE_PIN AL34 IOSTANDARD LVDS} [get_ports USER_CLOCK_N];

# User SMA Clock
#set_property -dict {PACKAGE_PIN AJ32 IOSTANDARD LVCMOS18} [get_ports USER_SMA_CLOCK_P];
#set_property -dict {PACKAGE_PIN AK32 IOSTANDARD LVCMOS18} [get_ports USER_SMA_CLOCK_N];

# GTX SMA Clock
#set_property PACKAGE_PIN AK7 [get_ports SMA_MGT_REFCLK_N];
#set_property PACKAGE_PIN AK8 [get_ports SMA_MGT_REFCLK_P];
#set_property PACKAGE_PIN AP4 [get_ports SMA_MGT_TX_P];
#set_property PACKAGE_PIN AN6 [get_ports SMA_MGT_RX_P];
#set_property PACKAGE_PIN AP3 [get_ports SMA_MGT_TX_N];
#set_property PACKAGE_PIN AN5 [get_ports SMA_MGT_RX_N];

# Si5324 Jitter Attenuated Clock
#set_property -dict {PACKAGE_PIN AW32 IOSTANDARD LVCMOS18} [get_ports REC_CLOCK_C_P];
#set_property -dict {PACKAGE_PIN AW33 IOSTANDARD LVCMOS18} [get_ports REC_CLOCK_C_N];
#set_property -dict {PACKAGE_PIN AU34 IOSTANDARD LVCMOS18} [get_ports SI5324_INT_ALM_LS];
#set_property -dict {PACKAGE_PIN AT36 IOSTANDARD LVCMOS18} [get_ports SI5324_RST_LS];

#################################################################################
#									          
#	#####	##   ##    ####   ####						  
#	##	    ### ###   ##        ##
#	#####	## # ##   ##        ##
#	##	    ##   ##   ##        ##
#	##	    ##   ##    ####   ######   
#
#################################################################################

#################################################################################
## J1 LA00 - LA19
#################################################################################
#set_property -dict {PACKAGE_PIN K39 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[0]];  # LA00_CC_P
#set_property -dict {PACKAGE_PIN K40 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[1]];  # LA00_CC_N
#set_property -dict {PACKAGE_PIN J40 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[2]];  # LA01_CC_P
#set_property -dict {PACKAGE_PIN J41 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[3]];  # LA01_CC_N
#set_property -dict {PACKAGE_PIN P41 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[4]];  # LA02_P
#set_property -dict {PACKAGE_PIN N41 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[5]];  # LA02_N
#set_property -dict {PACKAGE_PIN M42 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[6]];  # LA03_P
#set_property -dict {PACKAGE_PIN L42 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[7]];  # LA03_N
#set_property -dict {PACKAGE_PIN H40 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[8]];  # LA04_P
#set_property -dict {PACKAGE_PIN H41 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[9]];  # LA04_N
#set_property -dict {PACKAGE_PIN M41 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[10]]; # LA05_P
#set_property -dict {PACKAGE_PIN L41 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[11]]; # LA05_N
#set_property -dict {PACKAGE_PIN K42 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[12]]; # LA06_P
#set_property -dict {PACKAGE_PIN J42 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[13]]; # LA06_N
#set_property -dict {PACKAGE_PIN G41 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[14]]; # LA07_P
#set_property -dict {PACKAGE_PIN G42 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[15]]; # LA07_N
#set_property -dict {PACKAGE_PIN M37 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[16]]; # LA08_P
#set_property -dict {PACKAGE_PIN M38 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[17]]; # LA08_N
#set_property -dict {PACKAGE_PIN R42 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[18]]; # LA09_P
#set_property -dict {PACKAGE_PIN P42 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[19]]; # LA09_N
#set_property -dict {PACKAGE_PIN N38 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[20]]; # LA10_P
#set_property -dict {PACKAGE_PIN M39 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[21]]; # LA10_N
#set_property -dict {PACKAGE_PIN F40 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[22]]; # LA11_P
#set_property -dict {PACKAGE_PIN F41 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[23]]; # LA11_N
#set_property -dict {PACKAGE_PIN R40 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[24]]; # LA12_P
#set_property -dict {PACKAGE_PIN P40 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[25]]; # LA12_N
#set_property -dict {PACKAGE_PIN H39 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[26]]; # LA13_P
#set_property -dict {PACKAGE_PIN G39 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[27]]; # LA13_N
#set_property -dict {PACKAGE_PIN N39 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[28]]; # LA14_P
#set_property -dict {PACKAGE_PIN N40 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[29]]; # LA14_N
#set_property -dict {PACKAGE_PIN M36 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[30]]; # LA15_P
#set_property -dict {PACKAGE_PIN L37 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[31]]; # LA15_N
#set_property -dict {PACKAGE_PIN K37 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[32]]; # LA16_P
#set_property -dict {PACKAGE_PIN K38 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[33]]; # LA16_N
#set_property -dict {PACKAGE_PIN L31 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[34]]; # LA17_CC_P
#set_property -dict {PACKAGE_PIN K32 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[35]]; # LA17_CC_N
#set_property -dict {PACKAGE_PIN M32 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[36]]; # LA18_CC_P
#set_property -dict {PACKAGE_PIN L32 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[37]]; # LA18_CC_N
#set_property -dict {PACKAGE_PIN W30 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[38]]; # LA19_P
#set_property -dict {PACKAGE_PIN W31 IOSTANDARD LVCMOS18} [get_ports FMC1_J1[39]]; # LA19_N

#################################################################################
## J2 HB00 - HB19
#################################################################################
#set_property -dict {PACKAGE_PIN J25 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[0]];  # HB00_CC_P
#set_property -dict {PACKAGE_PIN J26 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[1]];  # HB00_CC_N
#set_property -dict {PACKAGE_PIN H28 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[2]];  # HB01_P
#set_property -dict {PACKAGE_PIN H29 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[3]];  # HB01_N
#set_property -dict {PACKAGE_PIN K28 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[4]];  # HB02_P
#set_property -dict {PACKAGE_PIN J28 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[5]];  # HB02_N
#set_property -dict {PACKAGE_PIN G28 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[6]];  # HB03_P
#set_property -dict {PACKAGE_PIN G29 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[7]];  # HB03_N
#set_property -dict {PACKAGE_PIN H24 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[8]];  # HB04_P
#set_property -dict {PACKAGE_PIN G24 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[9]];  # HB04_N
#set_property -dict {PACKAGE_PIN K27 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[10]]; # HB05_P
#set_property -dict {PACKAGE_PIN J27 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[11]]; # HB05_N
#set_property -dict {PACKAGE_PIN K23 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[12]]; # HB06_CC_P
#set_property -dict {PACKAGE_PIN J23 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[13]]; # HB06_CC_N
#set_property -dict {PACKAGE_PIN G26 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[14]]; # HB07_P
#set_property -dict {PACKAGE_PIN G27 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[15]]; # HB07_N
#set_property -dict {PACKAGE_PIN H25 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[16]]; # HB08_P
#set_property -dict {PACKAGE_PIN H26 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[17]]; # HB08_N
#set_property -dict {PACKAGE_PIN H23 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[18]]; # HB09_P
#set_property -dict {PACKAGE_PIN G23 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[19]]; # HB09_N
#set_property -dict {PACKAGE_PIN M22 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[20]]; # HB10_P
#set_property -dict {PACKAGE_PIN L22 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[21]]; # HB10_N
#set_property -dict {PACKAGE_PIN K22 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[22]]; # HB11_P
#set_property -dict {PACKAGE_PIN J22 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[23]]; # HB11_N
#set_property -dict {PACKAGE_PIN K24 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[24]]; # HB12_P
#set_property -dict {PACKAGE_PIN K25 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[25]]; # HB12_N
#set_property -dict {PACKAGE_PIN P25 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[26]]; # HB13_P
#set_property -dict {PACKAGE_PIN P26 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[27]]; # HB13_N
#set_property -dict {PACKAGE_PIN J21 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[28]]; # HB14_P
#set_property -dict {PACKAGE_PIN H21 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[29]]; # HB14_N
#set_property -dict {PACKAGE_PIN M21 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[30]]; # HB15_P
#set_property -dict {PACKAGE_PIN L21 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[31]]; # HB15_N
#set_property -dict {PACKAGE_PIN N25 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[32]]; # HB16_P
#set_property -dict {PACKAGE_PIN N26 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[33]]; # HB16_N
#set_property -dict {PACKAGE_PIN M24 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[34]]; # HB17_CC_P
#set_property -dict {PACKAGE_PIN L24 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[35]]; # HB17_CC_N
#set_property -dict {PACKAGE_PIN G21 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[36]]; # HB18_P
#set_property -dict {PACKAGE_PIN G22 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[37]]; # HB18_N
#set_property -dict {PACKAGE_PIN L25 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[38]]; # HB19_P
#set_property -dict {PACKAGE_PIN L26 IOSTANDARD LVCMOS18} [get_ports FMC1_J2[39]]; # HB19_N

#################################################################################
## J3 HA00 - HA19
#################################################################################
#set_property -dict {PACKAGE_PIN E34 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[0]];  # HA00_CC _P 
#set_property -dict {PACKAGE_PIN E35 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[1]];  # HA00_CC _N
#set_property -dict {PACKAGE_PIN D35 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[2]];  # HA01_CC _P
#set_property -dict {PACKAGE_PIN D36 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[3]];  # HA01_CC _N
#set_property -dict {PACKAGE_PIN E33 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[4]];  # HA02_P
#set_property -dict {PACKAGE_PIN D33 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[5]];  # HA02_N
#set_property -dict {PACKAGE_PIN H33 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[6]];  # HA03_P
#set_property -dict {PACKAGE_PIN G33 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[7]];  # HA03_N
#set_property -dict {PACKAGE_PIN F34 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[8]];  # HA04_P
#set_property -dict {PACKAGE_PIN F35 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[9]];  # HA04_N
#set_property -dict {PACKAGE_PIN G32 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[10]]; # HA05_P
#set_property -dict {PACKAGE_PIN F32 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[11]]; # HA05_N
#set_property -dict {PACKAGE_PIN G36 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[12]]; # HA06_P
#set_property -dict {PACKAGE_PIN G37 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[13]]; # HA06_N
#set_property -dict {PACKAGE_PIN C38 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[14]]; # HA07_P
#set_property -dict {PACKAGE_PIN C39 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[15]]; # HA07_N
#set_property -dict {PACKAGE_PIN J36 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[16]]; # HA08_P
#set_property -dict {PACKAGE_PIN H36 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[17]]; # HA08_N
#set_property -dict {PACKAGE_PIN E32 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[18]]; # HA09_P
#set_property -dict {PACKAGE_PIN D32 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[19]]; # HA09_N
#set_property -dict {PACKAGE_PIN H38 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[20]]; # HA10_P
#set_property -dict {PACKAGE_PIN G38 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[21]]; # HA10_N
#set_property -dict {PACKAGE_PIN J37 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[22]]; # HA11_P
#set_property -dict {PACKAGE_PIN J38 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[23]]; # HA11_N
#set_property -dict {PACKAGE_PIN B37 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[24]]; # HA12_P
#set_property -dict {PACKAGE_PIN B38 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[25]]; # HA12_N
#set_property -dict {PACKAGE_PIN B36 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[26]]; # HA13_P
#set_property -dict {PACKAGE_PIN A37 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[27]]; # HA13_N
#set_property -dict {PACKAGE_PIN E37 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[28]]; # HA14_P
#set_property -dict {PACKAGE_PIN E38 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[29]]; # HA14_N
#set_property -dict {PACKAGE_PIN C33 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[30]]; # HA15_P
#set_property -dict {PACKAGE_PIN C34 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[31]]; # HA15_N
#set_property -dict {PACKAGE_PIN B39 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[32]]; # HA16_P
#set_property -dict {PACKAGE_PIN A39 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[33]]; # HA16_N
#set_property -dict {PACKAGE_PIN C35 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[34]]; # HA17_CC _P
#set_property -dict {PACKAGE_PIN C36 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[35]]; # HA17_CC _N
#set_property -dict {PACKAGE_PIN F39 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[36]]; # HA18_P
#set_property -dict {PACKAGE_PIN E39 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[37]]; # HA18_N
#set_property -dict {PACKAGE_PIN B32 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[38]]; # HA19_P
#set_property -dict {PACKAGE_PIN B33 IOSTANDARD LVCMOS18} [get_ports FMC1_J3[39]]; # HA19_N

#################################################################################
## J5 FMC-JTAG
#################################################################################
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # 3.3 
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # GND
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # No connection
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_TCK]; # 
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # No connection
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_TDO]; # 
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_TDI]; # 
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # No connection
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_TMS]; # 

#################################################################################
## J15 - User leds
#################################################################################
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ] # VADJ (2.5)
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ] # Ground
set_property -dict {PACKAGE_PIN V29 IOSTANDARD LVCMOS18} [get_ports q];  # LA32_P
#set_property -dict {PACKAGE_PIN U29 IOSTANDARD LVCMOS18} [get_ports {FMC1_J15[1]}];  # LA32_N
#set_property -dict {PACKAGE_PIN U31 IOSTANDARD LVCMOS18} [get_ports {FMC1_J15[2]}];  # LA33_P
#set_property -dict {PACKAGE_PIN T31 IOSTANDARD LVCMOS18} [get_ports {FMC1_J15[3]}];  # LA33_N

#################################################################################
## J16 PMOD LA28 - LA31
#################################################################################
# Set 3.3V                      Set 2.5V
#   - Connect J6.1 to J6.3        - Connect J6.3 to J6.5
#   - Connect J6.2 to J6.4        - Connect J6.4 to J6.6

#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ] # Power (Set by J6)
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ] # Ground
#set_property -dict {PACKAGE_PIN L29 IOSTANDARD LVCMOS18} [get_ports {FMC1_J16[0]}];  # LA28_P
#set_property -dict {PACKAGE_PIN L30 IOSTANDARD LVCMOS18} [get_ports {FMC1_J16[1]}];  # LA28_N
#set_property -dict {PACKAGE_PIN T29 IOSTANDARD LVCMOS18} [get_ports {FMC1_J16[2]}];  # LA29_P
#set_property -dict {PACKAGE_PIN T30 IOSTANDARD LVCMOS18} [get_ports {FMC1_J16[3]}];  # LA29_N
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]  # Power (Set by J6)
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]  # Ground
#set_property -dict {PACKAGE_PIN V30 IOSTANDARD LVCMOS18} [get_ports {FMC1_J16[4]}];  # LA30_P
#set_property -dict {PACKAGE_PIN V31 IOSTANDARD LVCMOS18} [get_ports {FMC1_J16[5]}];  # LA30_N
#set_property -dict {PACKAGE_PIN M28 IOSTANDARD LVCMOS18} [get_ports {FMC1_J16[6]}];  # LA31_P
#set_property -dict {PACKAGE_PIN M29 IOSTANDARD LVCMOS18} [get_ports {FMC1_J16[7]}];  # LA31_N

#################################################################################
## J18 (Setting for FMC PG_M2C
#################################################################################

#################################################################################
## J19 (Do not connect with FMC - used by Mictor P1
#################################################################################

# 3.3
# GND
#               No connection
# MICTOR_TCK
#               No connection
# MICTOR_TDO
# MICTOR_TDI
#               No connection
# MICTOR_TMS

#################################################################################
## J20 LA20 - LA27
#################################################################################
#set_property -dict {PACKAGE_PIN Y29 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[0]];  # LA20_P
#set_property -dict {PACKAGE_PIN Y30 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[1]];  # LA20_N
#set_property -dict {PACKAGE_PIN N28 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[2]];  # LA21_P
#set_property -dict {PACKAGE_PIN N29 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[3]];  # LA21_N
#set_property -dict {PACKAGE_PIN R28 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[4]];  # LA22_P
#set_property -dict {PACKAGE_PIN P28 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[5]];  # LA22_N
#set_property -dict {PACKAGE_PIN P30 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[6]];  # LA23_P
#set_property -dict {PACKAGE_PIN N31 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[7]];  # LA23_N
set_property -dict {PACKAGE_PIN R30 IOSTANDARD LVCMOS18} [get_ports i_jtag_trst];  # LA24_P
set_property -dict {PACKAGE_PIN P31 IOSTANDARD LVCMOS18} [get_ports i_jtag_tdi];  # LA24_N
set_property -dict {PACKAGE_PIN K29 IOSTANDARD LVCMOS18} [get_ports i_jtag_tms]; # LA25_P
set_property -dict {PACKAGE_PIN K30 IOSTANDARD LVCMOS18} [get_ports i_jtag_tck]; # LA25_N
set_property -dict {PACKAGE_PIN J30 IOSTANDARD LVCMOS18} [get_ports o_jtag_tdo]; # LA26_P
#set_property -dict {PACKAGE_PIN H30 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[13]]; # LA26_N
#set_property -dict {PACKAGE_PIN J31 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[14]]; # LA27_P
#set_property -dict {PACKAGE_PIN H31 IOSTANDARD LVCMOS18} [get_ports FMC1_J20[15]]; # LA27_N
#set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVDS} [get_ports SYSCLK_P];
#set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVDS} [get_ports SYSCLK_N];
#create_clock -period 5.000 -name sys_clk_pin -waveform {0.000 2.500} -add [get_ports SYSCLK_P];
#create_clock -period 5.000 -name sys_clk_pin -waveform {0.000 2.500} -add [get_ports SYSCLK_N];
#################################################################################
## J23
#################################################################################
#set_property -dict {PACKAGE_PIN P21 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[0]];  # HB20_P  
#set_property -dict {PACKAGE_PIN N21 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[1]];  # HB20_N
#set_property -dict {PACKAGE_PIN B34 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[2]];  # HA20_P
#set_property -dict {PACKAGE_PIN A34 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[3]];  # HA20_N
#set_property -dict {PACKAGE_PIN D37 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[4]];  # HA21_P
#set_property -dict {PACKAGE_PIN D38 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[5]];  # HA21_N
#set_property -dict {PACKAGE_PIN P22 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[6]];  # HB21_P
#set_property -dict {PACKAGE_PIN P23 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[7]];  # HB21_N
#set_property -dict {PACKAGE_PIN F36 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[8]];  # HA22_P
#set_property -dict {PACKAGE_PIN F37 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[9]];  # HA22_N
#set_property -dict {PACKAGE_PIN A35 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[10]]; # HA23_P
#set_property -dict {PACKAGE_PIN A36 IOSTANDARD LVCMOS18} [get_ports FMC1_J23[11]]; # HA23_N

#################################################################################
## P1
#################################################################################
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR_TDO]  
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR_TCK];  
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR_TMS];  
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR_TDI];  
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN M38 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[0]];  # LA08_N
#set_property -dict {PACKAGE_PIN M37 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[1]];  # LA08_P
#set_property -dict {PACKAGE_PIN G42 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[2]];  # LA07_N
#set_property -dict {PACKAGE_PIN G41 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[3]];  # LA07_P
#set_property -dict {PACKAGE_PIN J42 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[4]];  # LA06_N
#set_property -dict {PACKAGE_PIN K42 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[5]];  # LA06_P
#set_property -dict {PACKAGE_PIN L41 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[6]];  # LA05_N
#set_property -dict {PACKAGE_PIN M41 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[7]];  # LA05_P
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
#set_property -dict {PACKAGE_PIN K39 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[8]]  # LA00_CC _P
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # VADJ (2.5)
##set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
#set_property -dict {PACKAGE_PIN J41 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[9]];  # LA01_CC _N
#set_property -dict {PACKAGE_PIN J40 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[10]]; # LA01_CC _P
#set_property -dict {PACKAGE_PIN P42 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[11]]; # LA09_N
#set_property -dict {PACKAGE_PIN R42 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[12]]; # LA09_P
#set_property -dict {PACKAGE_PIN H41 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[13]]; # LA04_N
#set_property -dict {PACKAGE_PIN H40 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[14]]; # LA04_P
#set_property -dict {PACKAGE_PIN L42 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[15]]; # LA03_N
#set_property -dict {PACKAGE_PIN M42 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[16]]; # LA03_P
#set_property -dict {PACKAGE_PIN N41 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[17]]; # LA02_N
#set_property -dict {PACKAGE_PIN P41 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[18]]; # LA02_P
#set_property -dict {PACKAGE_PIN M39 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[19]]; # LA10_N
#set_property -dict {PACKAGE_PIN N38 IOSTANDARD LVCMOS18} [get_ports FMC1_MICTOR[20]]; # LA10_P
 
#################################################################################
## Clocks
#################################################################################
# Si570 IIC LVDS clock (10-810 MHz default: 156.250)
#set_property -dict {PACKAGE_PIN L39 IOSTANDARD LVCMOS18} [get_ports FMC1_Si570[0]];  # CLK0_M2C_P
#set_property -dict {PACKAGE_PIN L40 IOSTANDARD LVCMOS18} [get_ports FMC1_Si570[1]];  # CLK0_M2C_N
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_Si570_SCL]; #
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC1_Si570_SDA]; # 
#set_property -dict {PACKAGE_PIN N30 IOSTANDARD LVCMOS18} [get_ports FMC1_SMA[0]];    # CLK1_M2C_P
#set_property -dict {PACKAGE_PIN M31 IOSTANDARD LVCMOS18} [get_ports FMC1_SMA[1]];    # CLK1_M2C_N


#################################################################################
## EEPROM
#################################################################################

#################################################################################
#									          
#	#####	##   ##    ####   #####						  
#	##	    ### ###   ##          ##
#	#####	## # ##   ##         ##
#	##	    ##   ##   ##       ##
#	##	    ##   ##    ####   ######   
#
#################################################################################

#################################################################################
## J1 LA00 - LA19
#################################################################################
#set_property -dict {PACKAGE_PIN AD40 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[0]];  # LA00_CC_P
#set_property -dict {PACKAGE_PIN AD41 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[1]];  # LA00_CC_N
#set_property -dict {PACKAGE_PIN AF41 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[2]];  # LA01_CC_P
#set_property -dict {PACKAGE_PIN AG41 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[3]];  # LA01_CC_N
#set_property -dict {PACKAGE_PIN AK39 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[4]];  # LA02_P
#set_property -dict {PACKAGE_PIN AL39 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[5]];  # LA02_N
#set_property -dict {PACKAGE_PIN AJ42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[6]];  # LA03_P
#set_property -dict {PACKAGE_PIN AK42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[7]];  # LA03_N
#set_property -dict {PACKAGE_PIN AL41 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[8]];  # LA04_P
#set_property -dict {PACKAGE_PIN AL42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[9]];  # LA04_N
#set_property -dict {PACKAGE_PIN AF42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[10]]; # LA05_P
#set_property -dict {PACKAGE_PIN AG42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[11]]; # LA05_N
#set_property -dict {PACKAGE_PIN AD38 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[12]]; # LA06_P
#set_property -dict {PACKAGE_PIN AE38 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[13]]; # LA06_N
#set_property -dict {PACKAGE_PIN AC40 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[14]]; # LA07_P
#set_property -dict {PACKAGE_PIN AC41 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[15]]; # LA07_N
#set_property -dict {PACKAGE_PIN AD42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[16]]; # LA08_P
#set_property -dict {PACKAGE_PIN AE42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[17]]; # LA08_N
#set_property -dict {PACKAGE_PIN AJ38 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[18]]; # LA09_P
#set_property -dict {PACKAGE_PIN AK38 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[19]]; # LA09_N
#set_property -dict {PACKAGE_PIN AB41 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[20]]; # LA10_P
#set_property -dict {PACKAGE_PIN AB42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[21]]; # LA10_N
#set_property -dict {PACKAGE_PIN Y42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[22]]; # LA11_P
#set_property -dict {PACKAGE_PIN AA42 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[23]]; # LA11_N
#set_property -dict {PACKAGE_PIN Y39 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[24]]; # LA12_P
#set_property -dict {PACKAGE_PIN AA39 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[25]]; # LA12_N
#set_property -dict {PACKAGE_PIN W40 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[26]]; # LA13_P
#set_property -dict {PACKAGE_PIN Y40 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[27]]; # LA13_N
#set_property -dict {PACKAGE_PIN AB38 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[28]]; # LA14_P
#set_property -dict {PACKAGE_PIN AB39 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[29]]; # LA14_N
#set_property -dict {PACKAGE_PIN AC38 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[30]]; # LA15_P
#set_property -dict {PACKAGE_PIN AC39 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[31]]; # LA15_N
#set_property -dict {PACKAGE_PIN AJ40 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[32]]; # LA16_P
#set_property -dict {PACKAGE_PIN AJ41 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[33]]; # LA16_N
#set_property -dict {PACKAGE_PIN U37 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[34]]; # LA17_CC_P
#set_property -dict {PACKAGE_PIN U38 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[35]]; # LA17_CC_N
#set_property -dict {PACKAGE_PIN U36 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[36]]; # LA18_CC_P
#set_property -dict {PACKAGE_PIN T37 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[37]]; # LA18_CC_N
#set_property -dict {PACKAGE_PIN U32 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[38]]; # LA19_P
#set_property -dict {PACKAGE_PIN U33 IOSTANDARD LVCMOS18} [get_ports FMC2_J1[39]]; # LA19_N

#################################################################################
## J2 HB00 - HB19 (FMC2 has not HB lane
#################################################################################


#################################################################################
## J3 HA00 - HA19
#################################################################################
#set_property -dict {PACKAGE_PIN AB33 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[0]];  # HA00_CC _P 
#set_property -dict {PACKAGE_PIN AC33 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[1]];  # HA00_CC _N
#set_property -dict {PACKAGE_PIN AD32 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[2]];  # HA01_CC _P
#set_property -dict {PACKAGE_PIN AD33 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[3]];  # HA01_CC _N
#set_property -dict {PACKAGE_PIN AC30 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[4]];  # HA02_P
#set_property -dict {PACKAGE_PIN AD30 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[5]];  # HA02_N
#set_property -dict {PACKAGE_PIN AA29 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[6]];  # HA03_P
#set_property -dict {PACKAGE_PIN AA30 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[7]];  # HA03_N
#set_property -dict {PACKAGE_PIN AB29 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[8]];  # HA04_P
#set_property -dict {PACKAGE_PIN AC29 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[9]];  # HA04_N
#set_property -dict {PACKAGE_PIN Y32 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[10]];  # HA05_P
#set_property -dict {PACKAGE_PIN Y33 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[11]];  # HA05_N
#set_property -dict {PACKAGE_PIN AB31 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[12]]; # HA06_P
#set_property -dict {PACKAGE_PIN AB32 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[13]]; # HA06_N
#set_property -dict {PACKAGE_PIN AC31 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[14]]; # HA07_P
#set_property -dict {PACKAGE_PIN AD31 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[15]]; # HA07_N
#set_property -dict {PACKAGE_PIN AA31 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[16]]; # HA08_P
#set_property -dict {PACKAGE_PIN AA32 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[17]]; # HA08_N
#set_property -dict {PACKAGE_PIN AE29 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[18]]; # HA09_P
#set_property -dict {PACKAGE_PIN AE30 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[19]]; # HA09_N
#set_property -dict {PACKAGE_PIN AF31 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[20]]; # HA10_P
#set_property -dict {PACKAGE_PIN AF32 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[21]]; # HA10_N
#set_property -dict {PACKAGE_PIN AE34 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[22]]; # HA11_P
#set_property -dict {PACKAGE_PIN AE35 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[23]]; # HA11_N
#set_property -dict {PACKAGE_PIN AF34 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[24]]; # HA12_P
#set_property -dict {PACKAGE_PIN AG34 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[25]]; # HA12_N
#set_property -dict {PACKAGE_PIN AE32 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[26]]; # HA13_P
#set_property -dict {PACKAGE_PIN AE33 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[27]]; # HA13_N
#set_property -dict {PACKAGE_PIN AF35 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[28]]; # HA14_P
#set_property -dict {PACKAGE_PIN AF36 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[29]]; # HA14_N
#set_property -dict {PACKAGE_PIN AE37 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[30]]; # HA15_P
#set_property -dict {PACKAGE_PIN AF37 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[31]]; # HA15_N
#set_property -dict {PACKAGE_PIN AG36 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[32]]; # HA16_P
#set_property -dict {PACKAGE_PIN AH36 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[33]]; # HA16_N
#set_property -dict {PACKAGE_PIN AC34 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[34]]; # HA17_CC _P
#set_property -dict {PACKAGE_PIN AD35 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[35]]; # HA17_CC _N
#set_property -dict {PACKAGE_PIN AB36 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[36]]; # HA18_P
#set_property -dict {PACKAGE_PIN AB37 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[37]]; # HA18_N
#set_property -dict {PACKAGE_PIN AC35 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[38]]; # HA19_P
#set_property -dict {PACKAGE_PIN AC36 IOSTANDARD LVCMOS18} [get_ports FMC2_J3[39]]; # HA19_N

#################################################################################
## J5 FMC-JTAG
#################################################################################
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # 3.3 
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # GND
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_TCK]; # 
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_TDO]; # 
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_TDI]; # 
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];  # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_TMS]; # 

#################################################################################
## J15 - User leds
#################################################################################
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ] # VADJ (2.5)
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ] # Ground
#set_property -dict {PACKAGE_PIN P37 IOSTANDARD LVCMOS18} [get_ports {FMC2_J15[0]}];  # LA32_P
#set_property -dict {PACKAGE_PIN P38 IOSTANDARD LVCMOS18} [get_ports {FMC2_J15[1]}];  # LA32_N
#set_property -dict {PACKAGE_PIN T36 IOSTANDARD LVCMOS18} [get_ports {FMC2_J15[2]}];  # LA33_P
#set_property -dict {PACKAGE_PIN R37 IOSTANDARD LVCMOS18} [get_ports {FMC2_J15[3]}];  # LA33_N

#################################################################################
## J16 PMOD LA28 - LA31
#################################################################################
# Set 3.3V                      Set 2.5V
#   - Connect J6.1 to J6.3        - Connect J6.3 to J6.5
#   - Connect J6.2 to J6.4        - Connect J6.4 to J6.6

#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ] # Power (Set by J6)
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ] # Ground
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]  # Power (Set by J6)
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]  # Ground

#set_property -dict {PACKAGE_PIN V35 IOSTANDARD LVCMOS18} [get_ports {FMC2_J16[0]}];  # LA28_P
#set_property -dict {PACKAGE_PIN V36 IOSTANDARD LVCMOS18} [get_ports {FMC2_J16[1]}];  # LA28_N
#set_property -dict {PACKAGE_PIN W36 IOSTANDARD LVCMOS18} [get_ports {FMC2_J16[2]}];  # LA29_P
#set_property -dict {PACKAGE_PIN W37 IOSTANDARD LVCMOS18} [get_ports {FMC2_J16[3]}];  # LA29_N
#set_property -dict {PACKAGE_PIN T32 IOSTANDARD LVCMOS18} [get_ports {FMC2_J16[4]}];  # LA30_P
#set_property -dict {PACKAGE_PIN R32 IOSTANDARD LVCMOS18} [get_ports {FMC2_J16[5]}];  # LA30_N
#set_property -dict {PACKAGE_PIN V39 IOSTANDARD LVCMOS18} [get_ports {FMC2_J16[6]}];  # LA31_P
#set_property -dict {PACKAGE_PIN V40 IOSTANDARD LVCMOS18} [get_ports {FMC2_J16[7]}];  # LA31_N

#################################################################################
## J18 (Setting for FMC PG_M2C
#################################################################################

#################################################################################
## J19 (Do not connect with FMC - used by Mictor P1
#################################################################################

# 3.3
# GND
#               No connection
# MICTOR_TCK
#               No connection
# MICTOR_TDO
# MICTOR_TDI
#               No connection
# MICTOR_TMS

#################################################################################
## J20 LA20 - LA27
#################################################################################
#set_property -dict {PACKAGE_PIN V33 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[0]];  # LA20_P
#set_property -dict {PACKAGE_PIN V34 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[1]];  # LA20_N
#set_property -dict {PACKAGE_PIN P35 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[2]];  # LA21_P
#set_property -dict {PACKAGE_PIN P36 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[3]];  # LA21_N
#set_property -dict {PACKAGE_PIN W32 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[4]];  # LA22_P
#set_property -dict {PACKAGE_PIN W33 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[5]];  # LA22_N
#set_property -dict {PACKAGE_PIN R38 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[6]];  # LA23_P
#set_property -dict {PACKAGE_PIN R39 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[7]];  # LA23_N
#set_property -dict {PACKAGE_PIN U34 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[8]];  # LA24_P
#set_property -dict {PACKAGE_PIN T35 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[9]];  # LA24_N
#set_property -dict {PACKAGE_PIN R33 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[10]]; # LA25_P
#set_property -dict {PACKAGE_PIN R34 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[11]]; # LA25_N
#set_property -dict {PACKAGE_PIN N33 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[12]]; # LA26_P
#set_property -dict {PACKAGE_PIN N34 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[13]]; # LA26_N
#set_property -dict {PACKAGE_PIN P32 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[14]]; # LA27_P
#set_property -dict {PACKAGE_PIN P33 IOSTANDARD LVCMOS18} [get_ports FMC2_J20[15]]; # LA27_N

#################################################################################
## J23
#################################################################################
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_J23[0]];  # HB20_P  (FMC2 has not HB lane)
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_J23[1]];  # HB20_N  (FMC2 has not HB lane)
#set_property -dict {PACKAGE_PIN AD36 IOSTANDARD LVCMOS18} [get_ports FMC2_J23[2]];  # HA20_P
#set_property -dict {PACKAGE_PIN AD37 IOSTANDARD LVCMOS18} [get_ports FMC2_J23[3]];  # HA20_N
#set_property -dict {PACKAGE_PIN AA34 IOSTANDARD LVCMOS18} [get_ports FMC2_J23[4]];  # HA21_P
#set_property -dict {PACKAGE_PIN AA35 IOSTANDARD LVCMOS18} [get_ports FMC2_J23[5]];  # HA21_N
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_J23[6]];  # HB21_P (FMC2 has not HB lane)
# set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_J23[7]];  # HB21_N (FMC2 has not HB lane)
#set_property -dict {PACKAGE_PIN Y35 IOSTANDARD LVCMOS18} [get_ports FMC2_J23[8]];  # HA22_P
#set_property -dict {PACKAGE_PIN AA36 IOSTANDARD LVCMOS18} [get_ports FMC2_J23[9]];  # HA22_N
#set_property -dict {PACKAGE_PIN Y37 IOSTANDARD LVCMOS18} [get_ports FMC2_J23[10]]; # HA23_P
#set_property -dict {PACKAGE_PIN AA37 IOSTANDARD LVCMOS18} [get_ports FMC2_J23[11]]; # HA23_N

#################################################################################
## P1
#################################################################################
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR_TDO]  
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR_TCK];  
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR_TMS];  
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR_TDI];  
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ];          # No connection
#set_property -dict {PACKAGE_PIN AE42 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[0]];  # LA08_N
#set_property -dict {PACKAGE_PIN AD42 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[1]];  # LA08_P
#set_property -dict {PACKAGE_PIN AC41 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[2]];  # LA07_N
#set_property -dict {PACKAGE_PIN AC40 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[3]];  # LA07_P
#set_property -dict {PACKAGE_PIN AE38 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[4]];  # LA06_N
#set_property -dict {PACKAGE_PIN AD38 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[5]];  # LA06_P
#set_property -dict {PACKAGE_PIN AG42 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[6]];  # LA05_N
#set_property -dict {PACKAGE_PIN AF42 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[7]];  # LA05_P
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
#set_property -dict {PACKAGE_PIN AD40 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[8]]  # LA00_CC _P
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # VADJ (2.5)
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports ]          # No connection
#set_property -dict {PACKAGE_PIN AG41 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[9]];  # LA01_CC _N
#set_property -dict {PACKAGE_PIN AF41 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[10]]; # LA01_CC _P
#set_property -dict {PACKAGE_PIN AK38 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[11]]; # LA09_N
#set_property -dict {PACKAGE_PIN AJ38 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[12]]; # LA09_P
#set_property -dict {PACKAGE_PIN AL42 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[13]]; # LA04_N
#set_property -dict {PACKAGE_PIN AL41 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[14]]; # LA04_P
#set_property -dict {PACKAGE_PIN AK42 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[15]]; # LA03_N
#set_property -dict {PACKAGE_PIN AJ42 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[16]]; # LA03_P
#set_property -dict {PACKAGE_PIN AL39 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[17]]; # LA02_N
#set_property -dict {PACKAGE_PIN AK39 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[18]]; # LA02_P
#set_property -dict {PACKAGE_PIN AB42 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[19]]; # LA10_N
#set_property -dict {PACKAGE_PIN AB41 IOSTANDARD LVCMOS18} [get_ports FMC2_MICTOR[20]]; # LA10_P
 
#################################################################################
## Clocks
#################################################################################
# Si570 IIC LVDS clock (10-810 MHz default: 156.250)
#set_property -dict {PACKAGE_PIN AF39 IOSTANDARD LVCMOS18} [get_ports FMC2_Si570[0]];  # CLK0_M2C_P
#set_property -dict {PACKAGE_PIN AF40 IOSTANDARD LVCMOS18} [get_ports FMC2_Si570[1]];  # CLK0_M2C_N
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_Si570_SCL]; #
#set_property -dict {PACKAGE_PIN IOSTANDARD LVCMOS18} [get_ports FMC2_Si570_SDA]; # 
#set_property -dict {PACKAGE_PIN U39 IOSTANDARD LVCMOS18} [get_ports FMC2_SMA[0]];    # CLK1_M2C_P
#set_property -dict {PACKAGE_PIN T39 IOSTANDARD LVCMOS18} [get_ports FMC2_SMA[1]];    # CLK1_M2C_N


#################################################################################
## EEPROM
#################################################################################

#set_property CONTROL.TRIGGER_POSITION 512 [get_hw_ilas ila_0]
