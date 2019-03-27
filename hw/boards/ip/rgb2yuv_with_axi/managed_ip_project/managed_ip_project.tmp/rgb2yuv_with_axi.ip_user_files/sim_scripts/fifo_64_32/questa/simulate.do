onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_64_32_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_64_32.udo}

run -all

quit -force
