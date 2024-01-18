####################################################
# PARSE DESIGN CONFIGURATION
####################################################
set top_design mipi_rx_pinf_tx_pinf_1080
set include_path {"." "src" "src/scc2v" "ip_core/dwip_v2_1/src" "ip_core/fifo_v2/src"}
set verilog_design_files {"src/emif2apb.v" "src/glue.v" "src/mcu_v1.v" "src/mipi_rx_pinf_tx_pinf_1080.v" "src/mipi_v1.v" "src/packet_asm.v" "src/pll_v1.v" "src/psram_wrap.v" "src/debugware_v2_1.v" "src/mcu_arbiter.v" "src/fifo_pdata_emb_v1.v" "src/sram_v2.v" "src/delaybuf.v" "src/por_v1_1.v" "src/te_gen.v" "src/delaybuf_v1_1.v" "src/fifo_32_1k.v" "src/hard_fifo_18x10.v" "src/fifo_pdata_hard.v" "src/pattern_gen.v" "src/fifo_psram_io_rd.v" "src/fifo_psram_io_rd_emb_v1.v" "src/fifo_psram_lbuf.v" "src/fifo_psram_lbuf_emb_v1.v" "src/fifo_psram_lbuf_rd.v" "src/fifo_psram_lbuf_rd_emb_v1.v" "src/ddr_io.v" "src/clkctrlswitch_0.v" "src/clkctrlswitch_6.v" "src/ddrio_lvds.v" "src/clkctrlswitch_5.v" "src/pattern_gen_test.v" "src/ddrio_v1.v" "src/rx_packet_cmd_mode_dpi.v" "src/fifo_pwr_half.v" "src/fifo_pram_wr_top.v" "src/fifo_pwr_quarter.v" "src/fifo_pram_wr_top_quarter.v" "src/fifo_mcu_wr_ram.v" "src/fifo_mcu_wr_ram_emb_v1.v" "src/fifo_mcu_rd_ram.v" "src/fifo_mcu_rd_ram_emb_v1.v" "src/gbuf_v1_1.v" "src/fifo_mipi_rx.v" "src/clkctrlswitch_2.v" "src/clkctrlswitch_3.v" "src/clkctrlswitch_1.v" "src/spiInterface_v1.v" "src/dataReadBack.v" "src/h6_mac.v" "src/mac_psram.v" "src/sdpram.v" "src/psram_io_ddr.v" "src/dataReadBack_fifo.v" "src/h1mac_v2.v" "src/tsc_fifo_v2.v" "src/tsc_fifo_v2_emb_v1.v" "src/enc_sc_down_top_all_ok.v" "src/scc2v/fifo_32s_1k.v" "src/scc2v/hard_fifos_18x10.v" "src/enc_psram_fb_top_all.v" "src/emb1.v" "ip_core/dwip_v2_1/src/dwip.v" "ip_core/fifo_v2/src/syn_fifo.v" "ip_core/fifo_v2/src/asyn_fifo.v"}
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
dump_design_info -work work -format "verilog" -dump "C:/Projects/hercules-FPGA/H1D03_Ref_Design/H1D03_Ref_Design/mipi_command_to_video_pSRAM/mipi_command_to_video_pSRAM/mipi_rx_pinf_tx_pinf_1080_reverse64/outputs/mipi_rx_pinf_tx_pinf_1080_design_info.xml" -top "mipi_rx_pinf_tx_pinf_1080"
exit 0