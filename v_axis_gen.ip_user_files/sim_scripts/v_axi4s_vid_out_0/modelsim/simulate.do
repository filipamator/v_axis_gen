onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L axi_lite_ipif_v3_0_4 -L v_tc_v6_1_12 -L v_vid_in_axi4s_v4_0_7 -L v_axi4s_vid_out_v4_0_8 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.v_axi4s_vid_out_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {v_axi4s_vid_out_0.udo}

run -all

quit -force
