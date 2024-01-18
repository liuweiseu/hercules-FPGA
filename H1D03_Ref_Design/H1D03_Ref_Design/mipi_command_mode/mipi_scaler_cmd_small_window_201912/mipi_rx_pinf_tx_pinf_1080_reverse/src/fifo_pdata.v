//
// This is a file generated by FIFO wizard.
// Please do not edit this file!
// Generated time: 07/25/2019 15:58:02
// Version: Fuxi 2019.1 win64
// Wizard name: FIFO 2.0a
//
// ============================================================
// File Name: fifo_pdata.v
// IP core : fifo
// Device name: H1D03N3W72C7
// ============================================================

module fifo_pdata(
    wclk,
    rclk,
    rrst_n,
    wrst_n,
    wdata,
    rdata,
    wen,
    ren,
    wclr,
    rclr,
    prog_full,
    prog_empty,
    rempty,
    wfull
);

input wclk;
input rclk;
input rrst_n;
input wrst_n;
input [7:0] wdata;
output [31:0] rdata;
input wen;
input ren;
input wclr;
input rclr;
output prog_full;
output prog_empty;
output rempty;
output wfull;

wire clkw;
assign clkw = wclk;
wire clkr;
assign clkr = rclk;
wire cew;
wire cer;
wire [9:0] ar;
wire [11:0] aw;
wire [7:0] dw;
wire [31:0] qr;

fifo_pdata_emb_v1 u_inst (
        .ar (ar),
        .aw (aw),
        .clkr (clkr),
        .clkw (clkw),
        .cer (cer),
        .cew (cew),
        .dw (dw),
        .qr (qr),
        .rstnr (rrst_n)
);

cme_ip_asyn_fifo_v2 #(
        .wr_dw (8),
        .rd_dw (32),
        .wr_aw (12),
        .rd_aw (10),
        .wr_depth (4096),
        .rd_depth (1024),
        .fwft_en (1'b1),
        .tDLY (0),
        .gen_prog_full_type (3'b001),
        .gen_prog_empty_type (3'b001),
        .prog_full_const (8),
        .prog_empty_const (2),
        .prog_full_assert_const (12),
        .prog_full_negate_const (8),
        .prog_empty_assert_const (3),
        .prog_empty_negate_const (2),
        .gen_almost_full (1'b0),
        .gen_almost_empty (1'b0),
        .gen_prog_full (1'b1),
        .gen_prog_empty (1'b1),
        .gen_wr_data_cnt (1'b0),
        .gen_rd_data_cnt (1'b0),
        .gen_wr_ack (1'b0),
        .gen_rd_ack (1'b0),
        .gen_wr_overflow (1'b0),
        .gen_rd_underflow (1'b0),
        .need_syn_wr_clr (1'b1),
        .need_syn_rd_clr (1'b1)
)
u_asyn_fifo (
        .wclk (wclk),
        .rclk (rclk),
        .rrst_n (rrst_n),
        .wrst_n (wrst_n),
        .wclr (wclr),
        .rclr (rclr),
        .wdata (wdata),
        .rdata (rdata),
        .wen (wen),
        .ren (ren),
        .almost_full (),
        .almost_empty (),
        .prog_full (prog_full),
        .prog_empty (prog_empty),
        .wr_data_cnt (),
        .rd_data_cnt (),
        .rempty (rempty),
        .wfull (wfull),
        .prog_full_thresh (),
        .prog_empty_thresh (),
        .prog_full_assert (),
        .prog_full_negate (),
        .prog_empty_assert (),
        .prog_empty_negate (),
        .wr_ack (),
        .rd_ack (),
        .overflow (),
        .underflow (),
        .mem_waddr (aw),
        .mem_wdata (dw),
        .mem_cew (cew),
        .mem_cer (cer),
        .mem_raddr (ar),
        .mem_rdata (qr)
);

endmodule

// ============================================================
//                  fifo Setting
//
// Warning: This part is read by Fuxi, please don't modify it.
// ============================================================
// Device          : H1D03N3W72C7
// Module          : fifo_pdata
// IP core         : fifo
// IP Version      : 2

// AlmostEmpty     : false
// AlmostFull      : false
// EmptyAssert     : 3
// EmptyNegate     : 2
// EmptySingle     : 2
// EmptyType       : 1
// FifoType        : software
// FullAssert      : 12
// FullNegate      : 8
// FullSingle      : 8
// FullType        : 1
// Fwft            : true
// OverFlow        : false
// PeekMode        : false
// ReadAck         : false
// ReadAddrWidth   : 10
// ReadClr         : true
// ReadCnt         : false
// ReadDataWidth   : 32
// Regout          : false
// RegoutEn        : false
// Simulation Files: ../ip_core/fifo_v2/src/syn_fifo.v ../ip_core/fifo_v2/src/asyn_fifo.v
// Synthesis Files : src/syn_fifo.v src/asyn_fifo.v
// UnderFlow       : false
// UseHardWare     : false
// WorkMode        : true
// WriteAck        : false
// WriteAddrWidth  : 12
// WriteClr        : true
// WriteCnt        : false
// WriteDataWidth  : 8
// WriteDrop       : false