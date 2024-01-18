//
// This is a file generated by FIFO wizard.
// Please do not edit this file!
// Generated time: 11/22/2019 13:56:51
// Version: Fuxi 2018a.0 win64
// Wizard name: FIFO 2.0a
//
// ============================================================
// File Name: fifo_psram_lbuf.v
// IP core : fifo
// Device name: H1D03N0L144C7
// ============================================================

module fifo_psram_lbuf(
    dout,
    din,
    writeclk,
    readclk,
    writeen,
    readen,
    reset,
    full,
    empty,
    almostempty
);

output [17:0] dout;
input [35:0] din;
input writeclk;
input readclk;
input writeen;
input readen;
input reset;
output full;
output empty;
output almostempty;

FIFO18K #(
        .almostemptyth (10'b0000111100),
        .almostfullth (9'b000000010),
        .writewidth (36),
        .readwidth (18),
        .outreg (1'b0),
        .peek (1'b0),
        .readclk_inv (1'b0),
        .writeclk_inv (1'b0),
        .use_parity (1'b1)
)
u_inst (
        .dout (dout[15:0]),
        .doutp (dout[17:16]),
        .din (din[31:0]),
        .dinp (din[35:32]),
        .writeclk (writeclk),
        .readclk (readclk),
        .writeen (~writeen),
        .readen (~readen),
        .reset (~reset),
        .full (full),
        .empty (empty),
        .almostempty (almostempty),
        .writesave (0),
        .writedrop (0),
        .eccindberr (0),
        .eccinsberr (0)
);

endmodule

// ============================================================
//                  fifo Setting
//
// Warning: This part is read by Fuxi, please don't modify it.
// ============================================================
// Device          : H1D03N0L144C7
// Module          : fifo_psram_lbuf
// IP core         : fifo
// IP Version      : 2

// AlmostEmpty     : true
// AlmostFull      : false
// EmptyAssert     : 6
// EmptyNegate     : 4
// EmptySingle     : 60
// EmptyType       : 1
// FifoType        : hardware
// FullAssert      : 3
// FullNegate      : 2
// FullSingle      : 2
// FullType        : 0
// Fwft            : false
// OverFlow        : false
// PeekMode        : false
// ReadAck         : false
// ReadAddrWidth   : 10
// ReadClr         : false
// ReadCnt         : false
// ReadDataWidth   : 18
// Regout          : false
// RegoutEn        : false
// Simulation Files: 
// Synthesis Files : 
// UnderFlow       : false
// UseHardWare     : true
// WorkMode        : true
// WriteAck        : false
// WriteAddrWidth  : 9
// WriteClr        : false
// WriteCnt        : false
// WriteDataWidth  : 36
// WriteDrop       : false