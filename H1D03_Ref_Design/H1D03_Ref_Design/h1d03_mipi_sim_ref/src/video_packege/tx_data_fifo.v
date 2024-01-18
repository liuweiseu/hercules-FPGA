//
// This is a file generated by FIFO wizard.
// Please do not edit this file!
// Generated time: 02/07/2020 22:24:10
// Version: Fuxi 2019.1 win64
// Wizard name: FIFO 2.0a
//
// ============================================================
// File Name: tx_data_fifo.v
// IP core : fifo
// Device name: H1D03N3W72C7
// ============================================================

module tx_data_fifo(
    wclk,
    rclk,
    rrst_n,
    wrst_n,
    wdata,
    rdata,
    wen,
    ren,
    almost_empty,
    prog_empty,
    rd_data_cnt,
    rempty,
    wfull
);

input wclk;
input rclk;
input rrst_n;
input wrst_n;
input [31:0] wdata;
output [31:0] rdata;
input wen;
input ren;
output almost_empty;
output prog_empty;
output [9:0] rd_data_cnt;
output rempty;
output wfull;

wire clkw;
assign clkw = wclk;
wire clkr;
assign clkr = rclk;
wire cew;
wire cer;
wire [9:0] ar;
wire [9:0] aw;
wire [31:0] dw;
wire [31:0] qr;

tx_data_fifo_emb_v1 u_inst (
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
        .wr_dw (32),
        .rd_dw (32),
        .wr_aw (10),
        .rd_aw (10),
        .wr_depth (1024),
        .rd_depth (1024),
        .fwft_en (1'b1),
        .tDLY (0),
        .gen_prog_full_type (3'b000),
        .gen_prog_empty_type (3'b001),
        .prog_full_const (20),
        .prog_empty_const (512),
        .prog_full_assert_const (30),
        .prog_full_negate_const (20),
        .prog_empty_assert_const (6),
        .prog_empty_negate_const (4),
        .gen_almost_full (1'b0),
        .gen_almost_empty (1'b1),
        .gen_prog_full (1'b0),
        .gen_prog_empty (1'b1),
        .gen_wr_data_cnt (1'b0),
        .gen_rd_data_cnt (1'b1),
        .gen_wr_ack (1'b0),
        .gen_rd_ack (1'b0),
        .gen_wr_overflow (1'b0),
        .gen_rd_underflow (1'b0),
        .need_syn_wr_clr (1'b0),
        .need_syn_rd_clr (1'b0)
)
u_asyn_fifo (
        .wclk (wclk),
        .rclk (rclk),
        .rrst_n (rrst_n),
        .wrst_n (wrst_n),
        .wclr (),
        .rclr (),
        .wdata (wdata),
        .rdata (rdata),
        .wen (wen),
        .ren (ren),
        .almost_full (),
        .almost_empty (almost_empty),
        .prog_full (),
        .prog_empty (prog_empty),
        .wr_data_cnt (),
        .rd_data_cnt (rd_data_cnt),
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
// Module          : tx_data_fifo
// IP core         : fifo
// IP Version      : 2

// AlmostEmpty     : true
// AlmostFull      : false
// EmptyAssert     : 6
// EmptyNegate     : 4
// EmptySingle     : 512
// EmptyType       : 1
// FifoType        : software
// FullAssert      : 30
// FullNegate      : 20
// FullSingle      : 20
// FullType        : 0
// Fwft            : true
// OverFlow        : false
// PeekMode        : false
// ReadAck         : false
// ReadAddrWidth   : 10
// ReadClr         : false
// ReadCnt         : true
// ReadDataWidth   : 32
// Regout          : false
// RegoutEn        : false
// Simulation Files: ../ip_core/fifo_v2/src/syn_fifo.v ../ip_core/fifo_v2/src/asyn_fifo.v
// Synthesis Files : src/syn_fifo.v src/asyn_fifo.v
// UnderFlow       : false
// UseHardWare     : false
// WorkMode        : true
// WriteAck        : false
// WriteAddrWidth  : 10
// WriteClr        : false
// WriteCnt        : false
// WriteDataWidth  : 32
// WriteDrop       : false
