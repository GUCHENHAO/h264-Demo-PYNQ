onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L unisims_ver -L unimacro_ver -L secureip -L fifo_generator_v13_1_0 -L xil_defaultlib -lib xil_defaultlib xil_defaultlib.fifo_64_32 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {fifo_64_32.udo}

run -all

quit -force
