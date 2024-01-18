####################################################
# PARSE DESIGN CONFIGURATION
####################################################
set top_design mipi_rx_pinf_tx_pinf_1080
set include_path {"." "src" "ip_core/dwip_v2_1/src" "ip_core/fifo_v2/src"}
set verilog_design_files {"src/emif2apb.v" "src/glue.v" "src/mcu_v1.v" "src/mipi_rx_pinf_tx_pinf_1080.v" "src/mipi_v1.v" "src/packet_asm.v" "src/pll_v1.v" "src/psram_wrap.v" "src/debugware_v2_1.v" "src/mcu_arbiter.v" "src/fifo_pdata.v" "src/fifo_pdata_emb_v1.v" "src/gbuf_v1_1.v" "src/delaybuf_x32.v" "src/delaybuf_v1_1.v" "src/fifo_mipi_tx.v" "src/fifo_mipi_tx_emb_v1.v" "src/fifo_sync.v" "src/mipi_data_process.v" "src/mipi_rx_hsync.v" "src/mipi_rx_vsync.v" "src/mipi_tx_fifo_readen_gen.v" "src/mipi_tx_packet_gen.v" "src/mipi_tx_timing_gen.v" "src/rx_packet_tx_packet_video.v" "src/mipi_byteclk_delay.v" "src/dataReadBack.v" "src/fifo_tx_sync.v" "src/fifo_tx_sync_emb_v1.v" "src/emb1.v" "src/sram_v2.v" "src/sync_delay.v" "src/MIPI_SC_Timing.v" "src/fifo_32_1k.v" "src/hard_fifo_18x10.v" "src/h6_mac.v" "src/enc_scaler_v2.v" "ip_core/dwip_v2_1/src/dwip.v" "ip_core/fifo_v2/src/syn_fifo.v" "ip_core/fifo_v2/src/asyn_fifo.v"}
set bbox_lib "$env(AGATE_ROOT)/data/lib/cst_lib_h6.v"
setmsgtype -ignore {VERI-1012}
setmsgtype -ignore {VERI-1141}
setmsgtype -error {VERI-1466}
setmsgtype -error {VERI-1084}
if {[info exists vhdl_design_files]} {
    source "$env(AGATE_ROOT)/data/syn/cfe/init_vhdl_lib.tcl"
    parse_design -work work -format vhdl -vhdl_2008 -vhdl_sort ${vhdl_design_files} -incdir ${include_path} -v ${bbox_lib} -print_message
}
if {[info exists verilog_design_files]} {
    parse_design -work work -format verilog ${verilog_design_files} -incdir ${include_path} -v ${bbox_lib} -print_message
}
dump_design_info -work work -format "verilog" -dump "C:/Projects/hercules-FPGA/H1D03_Ref_Design/H1D03_Ref_Design/mipi_video_mode/mipi_rx_pinf_tx_pinf_1080_reverse/outputs/mipi_rx_pinf_tx_pinf_1080_design_info.xml" -top "mipi_rx_pinf_tx_pinf_1080"
exit 0