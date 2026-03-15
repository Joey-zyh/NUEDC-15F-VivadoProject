vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xilinx_vip
vlib questa_lib/msim/xpm
vlib questa_lib/msim/xil_defaultlib

vmap xilinx_vip questa_lib/msim/xilinx_vip
vmap xpm questa_lib/msim/xpm
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xilinx_vip  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/include" \
"D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../ipstatic" "+incdir+D:/XilinxVivado/2025.1/Vivado/data/rsb/busdef" "+incdir+D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/include" \
"D:/XilinxVivado/2025.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/XilinxVivado/2025.1/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"D:/XilinxVivado/2025.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../ipstatic" "+incdir+D:/XilinxVivado/2025.1/Vivado/data/rsb/busdef" "+incdir+D:/XilinxVivado/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../project.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_clk_wiz.v" \
"../../../../project.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

