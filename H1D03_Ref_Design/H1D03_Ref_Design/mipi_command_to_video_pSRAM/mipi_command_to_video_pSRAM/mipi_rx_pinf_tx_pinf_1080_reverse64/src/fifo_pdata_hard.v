//
// This is a file generated by FIFO wizard.
// Please do not edit this file!
// Generated time: 12/12/2019 13:49:47
// Version: Fuxi fuxi win64
// Wizard name: FIFO 2.0a
//
// ============================================================
// File Name: fifo_pdata.v
// IP core : fifo
// Device name: H1D03N0L144C7
// ============================================================

module fifo_pdata(
    dout,
    din,
    writeclk,
    readclk,
    writeen,
    readen,
    reset,
    full,
    empty
);

output [35:0] dout;
input [8:0] din;
input writeclk;
input readclk;
input writeen;
input readen;
input reset;
output full;
output empty;

FIFO9K #(
        .almostemptyth (1'b0),
        .almostfullth (3'b000),
        .writewidth (9),
        .readwidth (36),
        .outreg (1'b0),
        .peek (1'b0),
        .readclk_inv (1'b0),
        .writeclk_inv (1'b0),
        .use_parity (1'b1)
)
u_inst (
        .dout (dout[31:0]),
        .doutp (dout[35:32]),
        .din (din[7:0]),
        .dinp (din[8:8]),
        .writeclk (writeclk),
        .readclk (readclk),
        .writeen (~writeen),
        .readen (~readen),
        .reset (~reset),
        .full (full),
        .empty (empty),
        .writesave (0),
        .writedrop (0)
);

endmodule

// ============================================================
//                  fifo Setting
//
// Warning: This part is read by Fuxi, please don't modify it.
// ============================================================
// Device          : H1D03N0L144C7
// Module          : fifo_pdata
// IP core         : fifo
// IP Version      : 2

// AlmostEmpty     : false
// AlmostFull      : false
// EmptyAssert     : 0
// EmptyNegate     : -1
// EmptySingle     : 0
// EmptyType       : 1
// FifoType        : hardware
// FullAssert      : 0
// FullNegate      : -4
// FullSingle      : 0
// FullType        : 1
// Fwft            : false
// OverFlow        : false
// PeekMode        : false
// ReadAck         : false
// ReadAddrWidth   : 1
// ReadClr         : false
// ReadCnt         : false
// ReadDataWidth   : 36
// Regout          : false
// RegoutEn        : false
// Simulation Files: 
// Synthesis Files : 
// UnderFlow       : false
// UseHardWare     : true
// WorkMode        : true
// WriteAck        : false
// WriteAddrWidth  : 3
// WriteClr        : false
// WriteCnt        : false
// WriteDataWidth  : 9
// WriteDrop       : false
