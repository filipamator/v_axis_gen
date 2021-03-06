vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/axi_lite_ipif_v3_0_4
vlib modelsim_lib/msim/v_tc_v6_1_12
vlib modelsim_lib/msim/v_vid_in_axi4s_v4_0_7
vlib modelsim_lib/msim/v_axi4s_vid_out_v4_0_8

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm
vmap axi_lite_ipif_v3_0_4 modelsim_lib/msim/axi_lite_ipif_v3_0_4
vmap v_tc_v6_1_12 modelsim_lib/msim/v_tc_v6_1_12
vmap v_vid_in_axi4s_v4_0_7 modelsim_lib/msim/v_vid_in_axi4s_v4_0_7
vmap v_axi4s_vid_out_v4_0_8 modelsim_lib/msim/v_axi4s_vid_out_v4_0_8

vlog -work xil_defaultlib -64 -incr -sv \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"C:/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93 \
"../../../ipstatic/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work v_tc_v6_1_12 -64 -93 \
"../../../ipstatic/hdl/v_tc_v6_1_vh_rfs.vhd" \

vlog -work v_vid_in_axi4s_v4_0_7 -64 -incr \
"../../../ipstatic/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \

vlog -work v_axi4s_vid_out_v4_0_8 -64 -incr \
"../../../ipstatic/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 -incr \
"../../../../v_axis_gen.srcs/sources_1/ip/v_axi4s_vid_out_0/sim/v_axi4s_vid_out_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

