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

module fifo_pram_wr_top(
	wclk,
    rclk,
	reset,
    wdata,
    rdata,
    wen,
    ren,
    prog_empty,
    rempty,
    wfull
);

input wclk;
input rclk;
input reset;
input [31:0] wdata;
output [15:0] rdata;
input wen;
input ren;
output prog_empty;
output rempty;
output wfull;



wire full0, full1, empty0, empty1, almost_empty0, almost_empty1;

assign wfull = full0 ;
assign rempty = empty0 ;
assign prog_empty = almost_empty0 ;


fifo_pwr_half u0_hardfifo(
    .dout(rdata[7:0]),
    .din({2'b0,wdata[23:16],wdata[7:0]}),
    .writeclk(wclk),
    .readclk(rclk),
    .writeen(wen),
    .readen(ren),
    .reset(reset),
    .full(full0),
    .empty(empty0),
    .almostempty(almost_empty0)
);

fifo_pwr_half u1_hardfifo(
    .dout(rdata[15:8]),
    .din({2'b0,wdata[31:24],wdata[15:8]}),
    .writeclk(wclk),
    .readclk(rclk),
    .writeen(wen),
    .readen(ren),
    .reset(reset),
    .full(full1),
    .empty(empty1),
    .almostempty(almost_empty1)
);

endmodule
