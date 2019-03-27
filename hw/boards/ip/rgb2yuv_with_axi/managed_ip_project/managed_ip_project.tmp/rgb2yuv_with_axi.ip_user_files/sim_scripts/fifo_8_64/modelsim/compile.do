vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm
vlib msim/fifo_generator_v13_1_0

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm
vmap fifo_generator_v13_1_0 msim/fifo_generator_v13_1_0

vlog -work xil_defaultlib -64 -incr -sv \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work fifo_generator_v13_1_0 -64 -incr \
"../../../ipstatic/fifo_generator_v13_1_0/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_0 -64 -93 \
"../../../ipstatic/fifo_generator_v13_1_0/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_0 -64 -incr \
"../../../ipstatic/fifo_generator_v13_1_0/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../../../../rtl/src/fifo_8_64/sim/fifo_8_64.v" \

vlog -work xil_defaultlib "glbl.v"

