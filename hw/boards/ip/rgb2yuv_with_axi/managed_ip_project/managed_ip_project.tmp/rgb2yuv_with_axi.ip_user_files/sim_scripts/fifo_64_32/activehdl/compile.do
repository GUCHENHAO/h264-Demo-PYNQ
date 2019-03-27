vlib work
vlib activehdl

vlib activehdl/fifo_generator_v13_1_0
vlib activehdl/xil_defaultlib

vmap fifo_generator_v13_1_0 activehdl/fifo_generator_v13_1_0
vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work fifo_generator_v13_1_0 -v2k5 \
"../../../ipstatic/fifo_generator_v13_1_0/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_0 -93 \
"../../../ipstatic/fifo_generator_v13_1_0/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_0 -v2k5 \
"../../../ipstatic/fifo_generator_v13_1_0/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work xil_defaultlib -v2k5 \
"../../../../../../rtl/src/fifo_64_32/sim/fifo_64_32.v" \


vlog -work xil_defaultlib "glbl.v"

