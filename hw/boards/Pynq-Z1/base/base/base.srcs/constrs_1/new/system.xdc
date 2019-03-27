## Switches
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports {sws_2bits_tri_i[0]}]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33} [get_ports {sws_2bits_tri_i[1]}]

##Buttons
set_property -dict {PACKAGE_PIN D19 IOSTANDARD LVCMOS33} [get_ports {btns_4bits_tri_i[0]}]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD LVCMOS33} [get_ports {btns_4bits_tri_i[1]}]
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports {btns_4bits_tri_i[2]}]
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS33} [get_ports {btns_4bits_tri_i[3]}]

##LEDs
set_property -dict {PACKAGE_PIN R14 IOSTANDARD LVCMOS33} [get_ports {leds_4bits_tri_o[0]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {leds_4bits_tri_o[1]}]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {leds_4bits_tri_o[2]}]
set_property -dict {PACKAGE_PIN M14 IOSTANDARD LVCMOS33} [get_ports {leds_4bits_tri_o[3]}]

##RGBLEDs
set_property -dict {PACKAGE_PIN L15 IOSTANDARD LVCMOS33} [get_ports {rgbleds_6bits_tri_o[0]}]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {rgbleds_6bits_tri_o[1]}]
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {rgbleds_6bits_tri_o[2]}]
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {rgbleds_6bits_tri_o[3]}]
set_property -dict {PACKAGE_PIN L14 IOSTANDARD LVCMOS33} [get_ports {rgbleds_6bits_tri_o[4]}]
set_property -dict {PACKAGE_PIN M15 IOSTANDARD LVCMOS33} [get_ports {rgbleds_6bits_tri_o[5]}]

## Audio signals
## MIC
#set_property -dict {PACKAGE_PIN F17 IOSTANDARD LVCMOS33} [get_ports {pdm_m_clk[0]}]
#set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports pdm_m_data_i]
### Mono Audio out
#set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {pwm_audio_o[0]}]
#set_property -dict {PACKAGE_PIN T17 IOSTANDARD LVCMOS33} [get_ports {pdm_audio_shutdown[0]}]

#HDMI Signals
create_clock -period 8.334 -waveform {0.000 4.167} [get_ports hdmi_in_clk_p]
create_clock -period 6.900 -name output_video -waveform {0.000 3.450} [get_pins system_i/video/hdmi_out/frontend/axi_dynclk/PXL_CLK_O]

# Following pins are for HDMI RX on Rev B board
set_property -dict {PACKAGE_PIN P19 IOSTANDARD TMDS_33} [get_ports hdmi_in_clk_n]
set_property -dict {PACKAGE_PIN N18 IOSTANDARD TMDS_33} [get_ports hdmi_in_clk_p]
set_property -dict {PACKAGE_PIN W20 IOSTANDARD TMDS_33} [get_ports {hdmi_in_data_n[0]}]
set_property -dict {PACKAGE_PIN V20 IOSTANDARD TMDS_33} [get_ports {hdmi_in_data_p[0]}]
set_property -dict {PACKAGE_PIN U20 IOSTANDARD TMDS_33} [get_ports {hdmi_in_data_n[1]}]
set_property -dict {PACKAGE_PIN T20 IOSTANDARD TMDS_33} [get_ports {hdmi_in_data_p[1]}]
set_property -dict {PACKAGE_PIN P20 IOSTANDARD TMDS_33} [get_ports {hdmi_in_data_n[2]}]
set_property -dict {PACKAGE_PIN N20 IOSTANDARD TMDS_33} [get_ports {hdmi_in_data_p[2]}]
set_property -dict {PACKAGE_PIN T19 IOSTANDARD LVCMOS33} [get_ports {hdmi_in_hpd[0]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports hdmi_in_ddc_scl_io]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports hdmi_in_ddc_sda_io]

# Following pins are for HDMI TX on Rev B board
set_property -dict {PACKAGE_PIN L17 IOSTANDARD TMDS_33} [get_ports hdmi_out_clk_n]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD TMDS_33} [get_ports hdmi_out_clk_p]
set_property -dict {PACKAGE_PIN K18 IOSTANDARD TMDS_33} [get_ports {hdmi_out_data_n[0]}]
set_property -dict {PACKAGE_PIN K17 IOSTANDARD TMDS_33} [get_ports {hdmi_out_data_p[0]}]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD TMDS_33} [get_ports {hdmi_out_data_n[1]}]
set_property -dict {PACKAGE_PIN K19 IOSTANDARD TMDS_33} [get_ports {hdmi_out_data_p[1]}]
set_property -dict {PACKAGE_PIN H18 IOSTANDARD TMDS_33} [get_ports {hdmi_out_data_n[2]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD TMDS_33} [get_ports {hdmi_out_data_p[2]}]
set_property -dict {PACKAGE_PIN R19 IOSTANDARD LVCMOS33} [get_ports {hdmi_out_hpd[0]}]
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports hdmi_out_ddc_scl_io]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports hdmi_out_ddc_sda_io]

###pmod Header JA
#set_property -dict {PACKAGE_PIN Y19 IOSTANDARD LVCMOS33} [get_ports {pmodJA[1]}]
#set_property -dict {PACKAGE_PIN Y18 IOSTANDARD LVCMOS33} [get_ports {pmodJA[0]}]
#set_property -dict {PACKAGE_PIN Y17 IOSTANDARD LVCMOS33} [get_ports {pmodJA[3]}]
#set_property -dict {PACKAGE_PIN Y16 IOSTANDARD LVCMOS33} [get_ports {pmodJA[2]}]
#set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {pmodJA[5]}]
#set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {pmodJA[4]}]
#set_property -dict {PACKAGE_PIN W19 IOSTANDARD LVCMOS33} [get_ports {pmodJA[7]}]
#set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {pmodJA[6]}]
#set_property PULLUP true [get_ports {pmodJA[2]}]
#set_property PULLUP true [get_ports {pmodJA[3]}]
#set_property PULLUP true [get_ports {pmodJA[6]}]
#set_property PULLUP true [get_ports {pmodJA[7]}]

###pmod Header JB
#set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports {pmodJB[1]}]
#set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports {pmodJB[0]}]
#set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {pmodJB[3]}]
#set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {pmodJB[2]}]
#set_property -dict {PACKAGE_PIN W16 IOSTANDARD LVCMOS33} [get_ports {pmodJB[5]}]
#set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {pmodJB[4]}]
#set_property -dict {PACKAGE_PIN W13 IOSTANDARD LVCMOS33} [get_ports {pmodJB[7]}]
#set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {pmodJB[6]}]
#set_property PULLUP true [get_ports {pmodJB[2]}]
#set_property PULLUP true [get_ports {pmodJB[3]}]
#set_property PULLUP true [get_ports {pmodJB[6]}]
#set_property PULLUP true [get_ports {pmodJB[7]}]

###Arduino shield digital io
#set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d1_d0_tri_io[0]}]
#set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d1_d0_tri_io[1]}]
#set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[0]}]
#set_property -dict {PACKAGE_PIN V13 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[1]}]
#set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[2]}]
#set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[3]}]
#set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[4]}]
#set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[5]}]
#set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[6]}]
#set_property -dict {PACKAGE_PIN V18 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[7]}]
#set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[8]}]
#set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[9]}]
#set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[10]}]
#set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_d13_d2_tri_io[11]}]
###Arduino shield dedicated I2C
#set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS33} [get_ports iic_sw_shield_scl_io]
#set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports iic_sw_shield_sda_io]
###Arduino shield dedicated SPI
#set_property -dict {PACKAGE_PIN W15 IOSTANDARD LVCMOS33} [get_ports spi_sw_shield_io1_io]
#set_property -dict {PACKAGE_PIN T12 IOSTANDARD LVCMOS33} [get_ports spi_sw_shield_io0_io]
#set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports spi_sw_shield_sck_io]
#set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports spi_sw_shield_ss_io]
## Arduino Analog Channels 0 to 5
#set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports Vaux1_v_n]
#set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports Vaux1_v_p]
#set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports Vaux9_v_n]
#set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports Vaux9_v_p]
#set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports Vaux6_v_n]
#set_property -dict {PACKAGE_PIN K14 IOSTANDARD LVCMOS33} [get_ports Vaux6_v_p]
#set_property -dict {PACKAGE_PIN J16 IOSTANDARD LVCMOS33} [get_ports Vaux15_v_n]
#set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports Vaux15_v_p]
#set_property -dict {PACKAGE_PIN H20 IOSTANDARD LVCMOS33} [get_ports Vaux5_v_n]
#set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS33} [get_ports Vaux5_v_p]
#set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports Vaux13_v_n]
#set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS33} [get_ports Vaux13_v_p]

## a5..a0 as digital io for gpio_shield_sw_a5_a0_tri_io[5:0]
#set_property -dict {PACKAGE_PIN U10 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_a5_a0_tri_io[5]}]
#set_property -dict {PACKAGE_PIN T5 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_a5_a0_tri_io[4]}]
#set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_a5_a0_tri_io[3]}]
#set_property -dict {PACKAGE_PIN W11 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_a5_a0_tri_io[2]}]
#set_property -dict {PACKAGE_PIN Y12 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_a5_a0_tri_io[1]}]
#set_property -dict {PACKAGE_PIN Y11 IOSTANDARD LVCMOS33} [get_ports {gpio_shield_sw_a5_a0_tri_io[0]}]
###Arduino shield shared I2C related pullup
#set_property PULLUP true [get_ports {gpio_shield_sw_a5_a0_tri_io[5]}]
#set_property PULLUP true [get_ports {gpio_shield_sw_a5_a0_tri_io[4]}]

### ChipKit GPIO signals top inner header pins
#set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[0] }]; #IO_L19N_T3_VREF_13 Sch=ck_io[26]
#set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[1] }]; #IO_L6N_T0_VREF_13 Sch=ck_io[27]
#set_property -dict { PACKAGE_PIN V6    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[2] }]; #IO_L22P_T3_13 Sch=ck_io[28]
#set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[3] }]; #IO_L11P_T1_SRCC_13 Sch=ck_io[29]
#set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[4] }]; #IO_L11N_T1_SRCC_13 Sch=ck_io[30]
#set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[5] }]; #IO_L17N_T2_13 Sch=ck_io[31]
#set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[6] }]; #IO_L15P_T2_DQS_13 Sch=ck_io[32]
#set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[7] }]; #IO_L21N_T3_DQS_13 Sch=ck_io[33]
#set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[8] }]; #IO_L16P_T2_13 Sch=ck_io[34]
#set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[9] }]; #IO_L22N_T3_13 Sch=ck_io[35]
#set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[10] }]; #IO_L13N_T2_MRCC_13 Sch=ck_io[36]
#set_property -dict { PACKAGE_PIN Y7    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[11] }]; #IO_L13P_T2_MRCC_13 Sch=ck_io[37]
#set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[12] }]; #IO_L15N_T2_DQS_13 Sch=ck_io[38]
#set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[13] }]; #IO_L14N_T2_SRCC_13 Sch=ck_io[39]
#set_property -dict { PACKAGE_PIN W9    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[14] }]; #IO_L16N_T2_13 Sch=ck_io[40]
#set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { ck_gpio_tri_io[15] }]; #IO_L14P_T2_SRCC_13 Sch=ck_io[41]

### ChipKit analog differential signals bottom inner header pins
#set_property -dict { PACKAGE_PIN F19   IOSTANDARD LVCMOS33 } [get_ports Vaux12_v_p]; #IO_L15P_T2_DQS_AD12P_35 Sch=ad_p[12]
#set_property -dict { PACKAGE_PIN F20   IOSTANDARD LVCMOS33 } [get_ports Vaux12_v_n]; #IO_L15N_T2_DQS_AD12N_35 Sch=ad_n[12]
#set_property -dict { PACKAGE_PIN C20   IOSTANDARD LVCMOS33 } [get_ports Vaux0_v_p]; #IO_L1P_T0_AD0P_35 Sch=ad_p[0]
#set_property -dict { PACKAGE_PIN B20   IOSTANDARD LVCMOS33 } [get_ports Vaux0_v_n]; #IO_L1N_T0_AD0N_35 Sch=ad_n[0]
#set_property -dict { PACKAGE_PIN B19   IOSTANDARD LVCMOS33 } [get_ports Vaux8_v_p]; #IO_L2P_T0_AD8P_35 Sch=ad_p[8]
#set_property -dict { PACKAGE_PIN A20   IOSTANDARD LVCMOS33 } [get_ports Vaux8_v_n]; #IO_L2N_T0_AD8N_35 Sch=ad_n[8]

#create_debug_core u_ila_0 ila
#set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
#set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
#set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
#set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
#set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
#set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
#set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
#set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
#set_property port_width 1 [get_debug_ports u_ila_0/clk]
#connect_debug_port u_ila_0/clk [get_nets [list system_i/processing_system7_0/inst/FCLK_CLK3]]
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
#set_property port_width 64 [get_debug_ports u_ila_0/probe0]
#connect_debug_port u_ila_0/probe0 [get_nets [list {system_i/h264enc_with_axi_0/rdata[0]} {system_i/h264enc_with_axi_0/rdata[1]} {system_i/h264enc_with_axi_0/rdata[2]} {system_i/h264enc_with_axi_0/rdata[3]} {system_i/h264enc_with_axi_0/rdata[4]} {system_i/h264enc_with_axi_0/rdata[5]} {system_i/h264enc_with_axi_0/rdata[6]} {system_i/h264enc_with_axi_0/rdata[7]} {system_i/h264enc_with_axi_0/rdata[8]} {system_i/h264enc_with_axi_0/rdata[9]} {system_i/h264enc_with_axi_0/rdata[10]} {system_i/h264enc_with_axi_0/rdata[11]} {system_i/h264enc_with_axi_0/rdata[12]} {system_i/h264enc_with_axi_0/rdata[13]} {system_i/h264enc_with_axi_0/rdata[14]} {system_i/h264enc_with_axi_0/rdata[15]} {system_i/h264enc_with_axi_0/rdata[16]} {system_i/h264enc_with_axi_0/rdata[17]} {system_i/h264enc_with_axi_0/rdata[18]} {system_i/h264enc_with_axi_0/rdata[19]} {system_i/h264enc_with_axi_0/rdata[20]} {system_i/h264enc_with_axi_0/rdata[21]} {system_i/h264enc_with_axi_0/rdata[22]} {system_i/h264enc_with_axi_0/rdata[23]} {system_i/h264enc_with_axi_0/rdata[24]} {system_i/h264enc_with_axi_0/rdata[25]} {system_i/h264enc_with_axi_0/rdata[26]} {system_i/h264enc_with_axi_0/rdata[27]} {system_i/h264enc_with_axi_0/rdata[28]} {system_i/h264enc_with_axi_0/rdata[29]} {system_i/h264enc_with_axi_0/rdata[30]} {system_i/h264enc_with_axi_0/rdata[31]} {system_i/h264enc_with_axi_0/rdata[32]} {system_i/h264enc_with_axi_0/rdata[33]} {system_i/h264enc_with_axi_0/rdata[34]} {system_i/h264enc_with_axi_0/rdata[35]} {system_i/h264enc_with_axi_0/rdata[36]} {system_i/h264enc_with_axi_0/rdata[37]} {system_i/h264enc_with_axi_0/rdata[38]} {system_i/h264enc_with_axi_0/rdata[39]} {system_i/h264enc_with_axi_0/rdata[40]} {system_i/h264enc_with_axi_0/rdata[41]} {system_i/h264enc_with_axi_0/rdata[42]} {system_i/h264enc_with_axi_0/rdata[43]} {system_i/h264enc_with_axi_0/rdata[44]} {system_i/h264enc_with_axi_0/rdata[45]} {system_i/h264enc_with_axi_0/rdata[46]} {system_i/h264enc_with_axi_0/rdata[47]} {system_i/h264enc_with_axi_0/rdata[48]} {system_i/h264enc_with_axi_0/rdata[49]} {system_i/h264enc_with_axi_0/rdata[50]} {system_i/h264enc_with_axi_0/rdata[51]} {system_i/h264enc_with_axi_0/rdata[52]} {system_i/h264enc_with_axi_0/rdata[53]} {system_i/h264enc_with_axi_0/rdata[54]} {system_i/h264enc_with_axi_0/rdata[55]} {system_i/h264enc_with_axi_0/rdata[56]} {system_i/h264enc_with_axi_0/rdata[57]} {system_i/h264enc_with_axi_0/rdata[58]} {system_i/h264enc_with_axi_0/rdata[59]} {system_i/h264enc_with_axi_0/rdata[60]} {system_i/h264enc_with_axi_0/rdata[61]} {system_i/h264enc_with_axi_0/rdata[62]} {system_i/h264enc_with_axi_0/rdata[63]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
#set_property port_width 8 [get_debug_ports u_ila_0/probe1]
#connect_debug_port u_ila_0/probe1 [get_nets [list {system_i/h264enc_with_axi_0/wdata[0]} {system_i/h264enc_with_axi_0/wdata[1]} {system_i/h264enc_with_axi_0/wdata[2]} {system_i/h264enc_with_axi_0/wdata[3]} {system_i/h264enc_with_axi_0/wdata[4]} {system_i/h264enc_with_axi_0/wdata[5]} {system_i/h264enc_with_axi_0/wdata[6]} {system_i/h264enc_with_axi_0/wdata[7]}]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
#set_property port_width 1 [get_debug_ports u_ila_0/probe2]
#connect_debug_port u_ila_0/probe2 [get_nets [list system_i/h264enc_with_axi_0/rvalid]]
#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
#set_property port_width 1 [get_debug_ports u_ila_0/probe3]
#connect_debug_port u_ila_0/probe3 [get_nets [list system_i/h264enc_with_axi_0/winc]]
#set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
#set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
#set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
#connect_debug_port dbg_hub/clk [get_nets clk]