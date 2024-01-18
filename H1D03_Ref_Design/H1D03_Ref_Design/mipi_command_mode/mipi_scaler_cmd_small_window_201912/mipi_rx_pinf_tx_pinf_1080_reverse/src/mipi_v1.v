//
// This is a file generated by MIPI wizard.
// Please do not edit this file!
// Generated time: 09/17/2019 10:32:30
// Version: Fuxi 2019.1 win64
// Wizard name: MIPI 1.0a
//
// ============================================================
// File Name: mipi_v1.v
// IP core : mipi
// Device name: H1D03N3W72C7
// ============================================================

module mipi_v1(
    mipi1_TxEscClk,
    mipi1_RxEscClk,
    mipi1_reset_n,
    mipi1_reset_esc_n,
    mipi1_PD_DPHY,
    mipi1_tx_dphy_rdy,
    mipi1_pclk_reset_n,
    mipi1_pclk,
    mipi1_paddr,
    mipi1_pwrite,
    mipi1_psel,
    mipi1_penable,
    mipi1_pwdata,
    mipi1_prdata,
    mipi1_pready,
    mipi1_host_tx_cmd_vc,
    mipi1_host_tx_cmd_data_type,
    mipi1_host_tx_cmd_byte_count,
    mipi1_host_tx_cmd_req,
    mipi1_host_tx_payload,
    mipi1_host_tx_hs_mode,
    mipi1_host_tx_ulps_enable,
    mipi1_host_dphy_turnaround,
    mipi1_host_trigger_req,
    mipi1_host_trigger_send,
    mipi1_host_tx_cmd_ack,
    mipi1_host_tx_payload_en,
    mipi1_host_tx_payload_en_last,
    mipi1_host_tx_active,
    mipi1_host_tx_ulps_active,
    mipi1_host_dphy_direction,
    mipi1_host_trigger_ack,
    mipi1_host_rx_payload,
    mipi1_host_rx_payload_valid,
    mipi1_host_rx_payload_valid_last,
    mipi1_host_rx_cmd_valid,
    mipi1_host_rx_cmd_vc,
    mipi1_host_rx_cmd_data_type,
    mipi1_host_rx_cmd_byte_count,
    mipi1_host_ecc_one_bit_err,
    mipi1_host_ecc_two_bit_err,
    mipi1_host_ecc_one_bit_err_pos,
    mipi1_host_ecc_err,
    mipi1_host_ecc_err_pos,
    mipi1_host_crc_err,
    mipi1_host_hs_tx_timeout,
    mipi1_host_lp_rx_timeout,
    mipi1_host_bta_timeout,
    mipi1_clk,
    mipi2_TxEscClk,
    mipi2_RxEscClk,
    mipi2_reset_n,
    mipi2_reset_esc_n,
    mipi2_PD_DPHY,
    mipi2_tx_dphy_rdy,
    mipi2_pclk_reset_n,
    mipi2_pclk,
    mipi2_paddr,
    mipi2_pwrite,
    mipi2_psel,
    mipi2_penable,
    mipi2_pwdata,
    mipi2_prdata,
    mipi2_pready,
    mipi2_clk_periph,
    mipi2_periph_te_enable,
    mipi2_periph_te_event_in,
    mipi2_periph_te_fail,
    mipi2_periph_tx_payload,
    mipi2_periph_tx_cmd_vc,
    mipi2_periph_tx_cmd_data_type,
    mipi2_periph_tx_cmd_byte_count,
    mipi2_periph_tx_cmd_req,
    mipi2_periph_trigger_req,
    mipi2_periph_trigger_send,
    mipi2_RxSyncHS,
    mipi2_RxActiveHS,
    mipi2_periph_rx_cmd,
    mipi2_periph_rx_cmd_valid,
    mipi2_periph_rx_payload,
    mipi2_periph_rx_payload_valid,
    mipi2_periph_rx_payload_valid_last,
    mipi2_periph_rx_trigger,
    mipi2_periph_rx_trigger_valid,
    mipi2_periph_ecc_one_bit_err,
    mipi2_periph_ecc_two_bit_err,
    mipi2_periph_ecc_one_bit_err_pos,
    mipi2_periph_ecc_err,
    mipi2_periph_ecc_err_pos,
    mipi2_periph_crc_err,
    mipi2_periph_te_rdy,
    mipi2_periph_te_ack,
    mipi2_periph_rx_ulps_active,
    mipi2_periph_rx_ulps_mark_active,
    mipi2_periph_tx_payload_en,
    mipi2_periph_tx_payload_en_last,
    mipi2_periph_tx_cmd_ack,
    mipi2_periph_tx_timeout_error,
    mipi2_periph_trigger_ack,
    mipi2_periph_dphy_direction,
    mipi2_hs_rx_timeout,
    mipi2_lp_tx_timeout,
    mipi2_periph_bta_timeout,
    mipi2_RxByteClkHS,
    CLKREF,
    PD_PLL,
    LOCK
);

input mipi1_TxEscClk;
input mipi1_RxEscClk;
input mipi1_reset_n;
input mipi1_reset_esc_n;
input mipi1_PD_DPHY;
output mipi1_tx_dphy_rdy;
input mipi1_pclk_reset_n;
input mipi1_pclk;
input [17:0] mipi1_paddr;
input mipi1_pwrite;
input mipi1_psel;
input mipi1_penable;
input [31:0] mipi1_pwdata;
output [31:0] mipi1_prdata;
output mipi1_pready;
input [1:0] mipi1_host_tx_cmd_vc;
input [5:0] mipi1_host_tx_cmd_data_type;
input [15:0] mipi1_host_tx_cmd_byte_count;
input mipi1_host_tx_cmd_req;
input [31:0] mipi1_host_tx_payload;
input mipi1_host_tx_hs_mode;
input [4:0] mipi1_host_tx_ulps_enable;
input mipi1_host_dphy_turnaround;
input mipi1_host_trigger_req;
input [1:0] mipi1_host_trigger_send;
output mipi1_host_tx_cmd_ack;
output mipi1_host_tx_payload_en;
output mipi1_host_tx_payload_en_last;
output mipi1_host_tx_active;
output [4:0] mipi1_host_tx_ulps_active;
output mipi1_host_dphy_direction;
output mipi1_host_trigger_ack;
output [31:0] mipi1_host_rx_payload;
output mipi1_host_rx_payload_valid;
output mipi1_host_rx_payload_valid_last;
output mipi1_host_rx_cmd_valid;
output [1:0] mipi1_host_rx_cmd_vc;
output [5:0] mipi1_host_rx_cmd_data_type;
output [15:0] mipi1_host_rx_cmd_byte_count;
output mipi1_host_ecc_one_bit_err;
output mipi1_host_ecc_two_bit_err;
output [4:0] mipi1_host_ecc_one_bit_err_pos;
output mipi1_host_ecc_err;
output [2:0] mipi1_host_ecc_err_pos;
output mipi1_host_crc_err;
output mipi1_host_hs_tx_timeout;
output mipi1_host_lp_rx_timeout;
output mipi1_host_bta_timeout;
output mipi1_clk;
input mipi2_TxEscClk;
input mipi2_RxEscClk;
input mipi2_reset_n;
input mipi2_reset_esc_n;
input mipi2_PD_DPHY;
output mipi2_tx_dphy_rdy;
input mipi2_pclk_reset_n;
input mipi2_pclk;
input [17:0] mipi2_paddr;
input mipi2_pwrite;
input mipi2_psel;
input mipi2_penable;
input [31:0] mipi2_pwdata;
output [31:0] mipi2_prdata;
output mipi2_pready;
input mipi2_clk_periph;
input mipi2_periph_te_enable;
input mipi2_periph_te_event_in;
input mipi2_periph_te_fail;
input [31:0] mipi2_periph_tx_payload;
input [1:0] mipi2_periph_tx_cmd_vc;
input [5:0] mipi2_periph_tx_cmd_data_type;
input [15:0] mipi2_periph_tx_cmd_byte_count;
input mipi2_periph_tx_cmd_req;
input mipi2_periph_trigger_req;
input [1:0] mipi2_periph_trigger_send;
output mipi2_RxSyncHS;
output mipi2_RxActiveHS;
output [23:0] mipi2_periph_rx_cmd;
output mipi2_periph_rx_cmd_valid;
output [31:0] mipi2_periph_rx_payload;
output mipi2_periph_rx_payload_valid;
output mipi2_periph_rx_payload_valid_last;
output [3:0] mipi2_periph_rx_trigger;
output mipi2_periph_rx_trigger_valid;
output mipi2_periph_ecc_one_bit_err;
output mipi2_periph_ecc_two_bit_err;
output [4:0] mipi2_periph_ecc_one_bit_err_pos;
output mipi2_periph_ecc_err;
output [2:0] mipi2_periph_ecc_err_pos;
output mipi2_periph_crc_err;
output mipi2_periph_te_rdy;
output mipi2_periph_te_ack;
output [4:0] mipi2_periph_rx_ulps_active;
output [4:0] mipi2_periph_rx_ulps_mark_active;
output mipi2_periph_tx_payload_en;
output mipi2_periph_tx_payload_en_last;
output mipi2_periph_tx_cmd_ack;
output mipi2_periph_tx_timeout_error;
output mipi2_periph_trigger_ack;
output mipi2_periph_dphy_direction;
output mipi2_hs_rx_timeout;
output mipi2_lp_tx_timeout;
output mipi2_periph_bta_timeout;
output mipi2_RxByteClkHS;
input CLKREF;
input PD_PLL;
output LOCK;

wire [7:0] mipi1_CM;
wire [4:0] mipi1_CN;
wire [1:0] mipi1_CO;
wire mipi1_BITCLK;
wire mipi2_BITCLK;
MIPI_PLL #(
        .TST (4'b1001),
        .BYPASS_PLL (1'b0)
)
u_mipi_pll (
        .CLKREF (CLKREF),
        .PD_PLL (PD_PLL),
        .LOCK (LOCK),
        .CM (mipi1_CM),
        .CN (mipi1_CN),
        .CO (mipi1_CO),
        .CLKOUT1 (mipi1_BITCLK),
        .CLKOUT2 (mipi2_BITCLK)
);
 
MIPI_TOP #(
        .DELAY_BUF_NUM (5'b00000),
        .CLK_DLY (5'b11101),
        .mipi_sel ("0"),
        .HSEL (1'b1),
        .DSI_CSI (1'b1),
        .RCAL_SEL (1'b0),
        .RX_RCAL_OVRD (2'b00),
        .TX_RCAL_OVRD (1'b0)
)
u_mipi1 (
        .CM (mipi1_CM),
        .CN (mipi1_CN),
        .CO (mipi1_CO),
        .LOCK (LOCK),
        .TxEscClk (mipi1_TxEscClk),
        .RxEscClk (mipi1_RxEscClk),
        .reset_n (mipi1_reset_n),
        .reset_esc_n (mipi1_reset_esc_n),
        .BITCLK (mipi1_BITCLK),
        .PD_DPHY (mipi1_PD_DPHY),
        .tx_dphy_rdy (mipi1_tx_dphy_rdy),
        .enable_raw_dsi_port (1'b1),
        .pclk_reset_n (mipi1_pclk_reset_n),
        .pclk (mipi1_pclk),
        .paddr (mipi1_paddr),
        .pwrite (mipi1_pwrite),
        .psel (mipi1_psel),
        .penable (mipi1_penable),
        .pwdata (mipi1_pwdata),
        .prdata (mipi1_prdata),
        .pready (mipi1_pready),
        .port_sel (2'b01),
        .host_tx_cmd_vc (mipi1_host_tx_cmd_vc),
        .host_tx_cmd_data_type (mipi1_host_tx_cmd_data_type),
        .host_tx_cmd_byte_count (mipi1_host_tx_cmd_byte_count),
        .host_tx_cmd_req (mipi1_host_tx_cmd_req),
        .host_tx_payload (mipi1_host_tx_payload),
        .host_tx_hs_mode (mipi1_host_tx_hs_mode),
        .host_tx_ulps_enable (mipi1_host_tx_ulps_enable),
        .host_dphy_turnaround (mipi1_host_dphy_turnaround),
        .host_trigger_req (mipi1_host_trigger_req),
        .host_trigger_send (mipi1_host_trigger_send),
        .host_tx_cmd_ack (mipi1_host_tx_cmd_ack),
        .host_tx_payload_en (mipi1_host_tx_payload_en),
        .host_tx_payload_en_last (mipi1_host_tx_payload_en_last),
        .host_tx_active (mipi1_host_tx_active),
        .host_tx_ulps_active (mipi1_host_tx_ulps_active),
        .host_dphy_direction (mipi1_host_dphy_direction),
        .host_trigger_ack (mipi1_host_trigger_ack),
        .host_rx_payload (mipi1_host_rx_payload),
        .host_rx_payload_valid (mipi1_host_rx_payload_valid),
        .host_rx_payload_valid_last (mipi1_host_rx_payload_valid_last),
        .host_rx_cmd_valid (mipi1_host_rx_cmd_valid),
        .host_rx_cmd_vc (mipi1_host_rx_cmd_vc),
        .host_rx_cmd_data_type (mipi1_host_rx_cmd_data_type),
        .host_rx_cmd_byte_count (mipi1_host_rx_cmd_byte_count),
        .host_ecc_one_bit_err (mipi1_host_ecc_one_bit_err),
        .host_ecc_two_bit_err (mipi1_host_ecc_two_bit_err),
        .host_ecc_one_bit_err_pos (mipi1_host_ecc_one_bit_err_pos),
        .host_ecc_err (mipi1_host_ecc_err),
        .host_ecc_err_pos (mipi1_host_ecc_err_pos),
        .host_crc_err (mipi1_host_crc_err),
        .host_hs_tx_timeout (mipi1_host_hs_tx_timeout),
        .host_lp_rx_timeout (mipi1_host_lp_rx_timeout),
        .host_bta_timeout (mipi1_host_bta_timeout),
        .clk (mipi1_clk),
        .enable_dpi_port (1'b0),
        .ENP_DESER (1'b0),
        .TEST_ENBL (1'b0),
        .AUTO_PD_EN (1'b0)
);

MIPI_TOP #(
        .DELAY_BUF_NUM (5'b00000),
        .CLK_DLY (5'b00000),
        .mipi_sel ("1"),
        .HSEL (1'b1),
        .DSI_CSI (1'b1),
        .RCAL_SEL (1'b0),
        .RX_RCAL_OVRD (2'b00),
        .TX_RCAL_OVRD (1'b0)
)
u_mipi2 (
        .TxEscClk (mipi2_TxEscClk),
        .RxEscClk (mipi2_RxEscClk),
        .reset_n (mipi2_reset_n),
        .reset_esc_n (mipi2_reset_esc_n),
        .BITCLK (mipi2_BITCLK),
        .PD_DPHY (mipi2_PD_DPHY),
        .tx_dphy_rdy (mipi2_tx_dphy_rdy),
        .enable_raw_dsi_port (1'b1),
        .pclk_reset_n (mipi2_pclk_reset_n),
        .pclk (mipi2_pclk),
        .paddr (mipi2_paddr),
        .pwrite (mipi2_pwrite),
        .psel (mipi2_psel),
        .penable (mipi2_penable),
        .pwdata (mipi2_pwdata),
        .prdata (mipi2_prdata),
        .pready (mipi2_pready),
        .port_sel (2'b10),
        .clk_periph (mipi2_clk_periph),
        .periph_te_enable (mipi2_periph_te_enable),
        .periph_te_event_in (mipi2_periph_te_event_in),
        .periph_te_fail (mipi2_periph_te_fail),
        .periph_tx_payload (mipi2_periph_tx_payload),
        .periph_tx_cmd_vc (mipi2_periph_tx_cmd_vc),
        .periph_tx_cmd_data_type (mipi2_periph_tx_cmd_data_type),
        .periph_tx_cmd_byte_count (mipi2_periph_tx_cmd_byte_count),
        .periph_tx_cmd_req (mipi2_periph_tx_cmd_req),
        .periph_trigger_req (mipi2_periph_trigger_req),
        .periph_trigger_send (mipi2_periph_trigger_send),
        .RxSyncHS (mipi2_RxSyncHS),
        .RxActiveHS (mipi2_RxActiveHS),
        .periph_rx_cmd (mipi2_periph_rx_cmd),
        .periph_rx_cmd_valid (mipi2_periph_rx_cmd_valid),
        .periph_rx_payload (mipi2_periph_rx_payload),
        .periph_rx_payload_valid (mipi2_periph_rx_payload_valid),
        .periph_rx_payload_valid_last (mipi2_periph_rx_payload_valid_last),
        .periph_rx_trigger (mipi2_periph_rx_trigger),
        .periph_rx_trigger_valid (mipi2_periph_rx_trigger_valid),
        .periph_ecc_one_bit_err (mipi2_periph_ecc_one_bit_err),
        .periph_ecc_two_bit_err (mipi2_periph_ecc_two_bit_err),
        .periph_ecc_one_bit_err_pos (mipi2_periph_ecc_one_bit_err_pos),
        .periph_ecc_err (mipi2_periph_ecc_err),
        .periph_ecc_err_pos (mipi2_periph_ecc_err_pos),
        .periph_crc_err (mipi2_periph_crc_err),
        .periph_te_rdy (mipi2_periph_te_rdy),
        .periph_te_ack (mipi2_periph_te_ack),
        .periph_rx_ulps_active (mipi2_periph_rx_ulps_active),
        .periph_rx_ulps_mark_active (mipi2_periph_rx_ulps_mark_active),
        .periph_tx_payload_en (mipi2_periph_tx_payload_en),
        .periph_tx_payload_en_last (mipi2_periph_tx_payload_en_last),
        .periph_tx_cmd_ack (mipi2_periph_tx_cmd_ack),
        .periph_tx_timeout_error (mipi2_periph_tx_timeout_error),
        .periph_trigger_ack (mipi2_periph_trigger_ack),
        .periph_dphy_direction (mipi2_periph_dphy_direction),
        .hs_rx_timeout (mipi2_hs_rx_timeout),
        .lp_tx_timeout (mipi2_lp_tx_timeout),
        .periph_bta_timeout (mipi2_periph_bta_timeout),
        .RxByteClkHS (mipi2_RxByteClkHS),
        .enable_dpi_port (1'b0),
        .ENP_DESER (1'b0),
        .TEST_ENBL (1'b0),
        .AUTO_PD_EN (1'b0)
);

endmodule

// ============================================================
//                  mipi Setting
//
// Warning: This part is read by Fuxi, please don't modify it.
// ============================================================
// Device          : H1D03N3W72C7
// Module          : mipi_v1
// IP core         : mipi
// IP Version      : 1

// MIPI 1 Clock Delay Index: 14
// MIPI 1 Clock Invert: true
// MIPI 1 Clock Rate: 1100
// MIPI 1 DPI Selectd: false
// MIPI 1 Insert Buf Count: 0
// MIPI 1 Lane0    : false
// MIPI 1 Lane1    : false
// MIPI 1 Lane2    : false
// MIPI 1 Lane3    : false
// MIPI 1 Mode     : Host
// MIPI 1 Speed    : 1.5 Gbps
// MIPI 1 Using Advanced Mode: true
// MIPI 2 Clock Delay Index: 0
// MIPI 2 Clock Invert: false
// MIPI 2 Clock Rate: 800
// MIPI 2 DPI Selectd: false
// MIPI 2 Insert Buf Count: 0
// MIPI 2 Lane0    : false
// MIPI 2 Lane1    : false
// MIPI 2 Lane2    : false
// MIPI 2 Lane3    : false
// MIPI 2 Mode     : Peripheral
// MIPI 2 Speed    : 1.5 Gbps
// MIPI 2 Using Advanced Mode: false
// MIPI Top1 Select: true
// MIPI Top2 Select: true
// Simulation Files: 
// Synthesis Files : 
