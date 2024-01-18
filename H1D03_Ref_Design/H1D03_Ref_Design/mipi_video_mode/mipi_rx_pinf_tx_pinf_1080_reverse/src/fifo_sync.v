//
// This is a file generated by FIFO wizard.
// Please do not edit this file!
// Generated time: 07/29/2019 10:46:27
// Version: Fuxi 2019.1 win64
// Wizard name: FIFO 2.0a
//
// ============================================================
// File Name: fifo_sync.v
// IP core : fifo
// Device name: H1D03N3W72C7
// ============================================================

module fifo_sync(
    dout,
    din,
    writeclk,
    readclk,
    writeen,
    readen,
    reset,
    full,
    empty,
    overflow,
    underflow
);

output [3:0] dout;
input [3:0] din;
input writeclk;
input readclk;
input writeen;
input readen;
input reset;
output full;
output empty;
output overflow;
output underflow;

FIFO5K #(
        .almostemptyth (1'b0),
        .almostfullth (1'b0),
        .writewidth (4),
        .readwidth (4),
        .outreg (1'b0),
        .peek (1'b0),
        .readclk_inv (1'b0),
        .writeclk_inv (1'b0)
)
u_inst (
        .dout (dout),
        .din (din),
        .writeclk (writeclk),
        .readclk (readclk),
        .writeen (~writeen),
        .readen (~readen),
        .reset (~reset),
        .full (full),
        .empty (empty),
        .overflow (overflow),
        .underflow (underflow),
        .writesave (0),
        .writedrop (0)
);

endmodule

// ============================================================
//                  fifo Setting
//
// Warning: This part is read by Fuxi, please don't modify it.
// ============================================================
// Device          : H1D03N3W72C7
// Module          : fifo_sync
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
// FullNegate      : -1
// FullSingle      : 0
// FullType        : 1
// Fwft            : false
// OverFlow        : true
// PeekMode        : false
// ReadAck         : false
// ReadAddrWidth   : 1
// ReadClr         : false
// ReadCnt         : false
// ReadDataWidth   : 4
// Regout          : false
// RegoutEn        : false
// Simulation Files: 
// Synthesis Files : 
// UnderFlow       : true
// UseHardWare     : true
// WorkMode        : true
// WriteAck        : false
// WriteAddrWidth  : 1
// WriteClr        : false
// WriteCnt        : false
// WriteDataWidth  : 4
// WriteDrop       : false