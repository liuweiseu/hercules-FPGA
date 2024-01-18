
module fifo_pwr_quarter(
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

output [3:0] dout;
input [7:0] din;
input writeclk;
input readclk;
input writeen;
input readen;
input reset;
output full;
output empty;
output almostempty;

FIFO18K #(
        .almostemptyth (11'b00000111100),
        // .almostemptyth (11'd64),
        .almostfullth (10'b0000000010),
        .writewidth (9),
        .readwidth (4),
        .outreg (1'b0),
        .peek (1'b0),
        .readclk_inv (1'b0),
        .writeclk_inv (1'b0),
        .use_parity (1'b1)
)
u_inst (
        .dout (dout[3:0]),
        .doutp (),
        .din (din[7:0]),
        .dinp (),
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
// Module          : fifo_pwr_half
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
// ReadAddrWidth   : 11
// ReadClr         : false
// ReadCnt         : false
// ReadDataWidth   : 9
// Regout          : false
// RegoutEn        : false
// Simulation Files: 
// Synthesis Files : 
// UnderFlow       : false
// UseHardWare     : true
// WorkMode        : true
// WriteAck        : false
// WriteAddrWidth  : 10
// WriteClr        : false
// WriteCnt        : false
// WriteDataWidth  : 18
// WriteDrop       : false
