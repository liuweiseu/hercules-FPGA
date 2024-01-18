// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 08/29/2019 15:52:48   
// Design Name:
// Module Name: fifo_32_1k
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// ============================================================

`define USE_HARD_FIFO

module fifo_32_1k #(
	parameter ALMOSTEMPTYTH = 10'd810
)
(
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
output rempty;
output wfull;


`ifdef USE_HARD_FIFO
wire reset;
wire full0, full1, empty0, empty1, almost_empty0, almost_empty1;

assign full = full0 | full1;
assign rempty = empty0 & empty1;
assign almost_empty = empty0 & empty1;
assign prog_empty = almost_empty0 & almost_empty1;

assign reset = ~wrst_n;


hard_fifo_18x10 #(
	.ALMOSTEMPTYTH(ALMOSTEMPTYTH)
)
u0_hardfifo(
    .dout(rdata[15:0]),
    .din(wdata[15:0]),
    .writeclk(wclk),
    .readclk(rclk),
    .writeen(wen),
    .readen(ren),
    .reset(reset),
    .full(full0),
    .empty(empty0),
    .almostempty(almost_empty0),
    .regce(1'b1)
);


hard_fifo_18x10 #(
	.ALMOSTEMPTYTH(ALMOSTEMPTYTH)
) 
u1_hardfifo(
    .dout(rdata[31:16]),
    .din(wdata[31:16]),
    .writeclk(wclk),
    .readclk(rclk),
    .writeen(wen),
    .readen(ren),
    .reset(reset),
    .full(full1),
    .empty(empty1),
    .almostempty(almost_empty1),
    .regce(1'b1)
);
`else
fifo_mipi_tx u0_softfifo(
    .wclk(wclk),
    .rclk(rclk),
    .rrst_n(rrst_n),
    .wrst_n(wrst_n),
    .wdata(wdata),
    .rdata(rdata),
    .wen(wen),
    .ren(ren),
    .almost_empty(almost_empty),
    .prog_empty(prog_empty),
    .rempty(rempty),
    .wfull(wfull)
);
`endif

endmodule
