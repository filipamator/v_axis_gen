onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib v_axi4s_vid_out_0_opt

do {wave.do}

view wave
view structure
view signals

do {v_axi4s_vid_out_0.udo}

run -all

quit -force
