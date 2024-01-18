set_option dev H1D03N3W72C7
set_option v "src/emif2apb.v" "src/glue.v" "src/mcu_v1.v" "src/mipi_rx_pinf_tx_pinf_1080.v" "src/mipi_v1.v" "src/packet_asm.v" "src/pll_v1.v" "src/psram_wrap.v" "src/debugware_v2_1.v" "src/mcu_arbiter.v" "src/fifo_pdata.v" "src/fifo_pdata_emb_v1.v" "src/gbuf_v1_1.v" "src/delaybuf_x32.v" "src/delaybuf_v1_1.v" "src/fifo_mipi_tx.v" "src/fifo_mipi_tx_emb_v1.v" "src/fifo_sync.v" "src/mipi_data_process.v" "src/mipi_rx_hsync.v" "src/mipi_rx_vsync.v" "src/mipi_tx_fifo_readen_gen.v" "src/mipi_tx_packet_gen.v" "src/mipi_tx_timing_gen.v" "src/rx_packet_tx_packet_video.v" "src/mipi_byteclk_delay.v" "src/dataReadBack.v" "src/fifo_tx_sync.v" "src/fifo_tx_sync_emb_v1.v" "src/emb1.v" "src/sram_v2.v" "src/sync_delay.v" "src/MIPI_SC_Timing.v" "src/fifo_32_1k.v" "src/hard_fifo_18x10.v" "src/h6_mac.v" "src/enc_scaler_v2.v" "ip_core/dwip_v2_1/src/dwip.v" "ip_core/fifo_v2/src/syn_fifo.v" "ip_core/fifo_v2/src/asyn_fifo.v"
set_option top mipi_rx_pinf_tx_pinf_1080
set_option vo outputs/mipi_rx_pinf_tx_pinf_1080.amv
set_option whitebox true
set_option isyn true
set_option fca false
set_option keep_latch true
set_option keep_floating true
set_option rename_luts 0
set_option optimize_primitives false
set_option shift_register_inference false
set_option shift_register_merge false
set_option fast_io false
set_option aoc outputs/mipi_rx_pinf_tx_pinf_1080_ast.aoc
set_option min_ce_fanout 4
set_option carry_opt true
set_option magic true
set_option mode fast
set_option use_dsp auto
set_option use_naming_rule true
set_option cfe scripts/cfe.tcl
set_option reg_opt false
set_option memory_threshold 1024
set_option min_adder_width 6
set_option remove_identical_inst true
set_option disioc false
set_option extract_multiport_rams true
set_option max_fanout 100000
set_option reg_retime false
set_option min_shared_inputs 6
set_option debug false
set_option debug_formal false

source "$env(AGATE_ROOT)/data/syn/cst_flow.tcl"