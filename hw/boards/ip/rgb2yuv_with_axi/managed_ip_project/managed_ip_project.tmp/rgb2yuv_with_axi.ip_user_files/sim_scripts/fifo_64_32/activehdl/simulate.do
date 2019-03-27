onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+fifo_64_32 -L unisims_ver -L unimacro_ver -L secureip -L fifo_generator_v13_1_0 -L xil_defaultlib -O5 xil_defaultlib.fifo_64_32 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {fifo_64_32.udo}

run -all

endsim

quit -force
