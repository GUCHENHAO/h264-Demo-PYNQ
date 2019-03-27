vlib work
vlib msim

vlib msim/fifo_generator_v13_1_0
vlib msim/xil_defaultlib

vmap fifo_generator_v13_1_0 msim/fifo_generator_v13_1_0
vmap xil_defaultlib msim/xil_defaultlib

vlog -work fifo_generator_v13_1_0 -64 \
"../../../ipstatic/fifo_generator_v13_1_0/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_1_0 -64 \
"../../../ipstatic/fifo_generator_v13_1_0/hdl/fifo_generator_v13_1_rfs.vhd" \

vlog -work fifo_generator_v13_1_0 -64 \
"../../../ipstatic/fifo_generator_v13_1_0/hdl/fifo_generator_v13_1_rfs.v" \

vlog -work xil_defaultlib -64 \
"../../../../../../rtl/src/fifo_64_32/sim/fifo_64_32.v" \


vlog -work xil_defaultlib "glbl.v"

