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

module fifo_pram_wr_top_quarter(
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


fifo_pwr_quarter u0_hardfifo(
    .dout(rdata[3:0]),
    .din({wdata[19:16],wdata[3:0]}),
    .writeclk(wclk),
    .readclk(rclk),
    .writeen(wen),
    .readen(ren),
    .reset(reset),
    .full(full0),
    .empty(empty0),
    .almostempty(almost_empty0)
);

fifo_pwr_quarter u1_hardfifo(
    .dout(rdata[7:4]),
    .din({wdata[23:20],wdata[7:4]}),
    .writeclk(wclk),
    .readclk(rclk),
    .writeen(wen),
    .readen(ren),
    .reset(reset),
    .full(),
    .empty(),
    .almostempty()
);

fifo_pwr_quarter u2_hardfifo(
    .dout(rdata[11:8]),
    .din({wdata[27:24],wdata[11:8]}),
    .writeclk(wclk),
    .readclk(rclk),
    .writeen(wen),
    .readen(ren),
    .reset(reset),
    .full(),
    .empty(),
    .almostempty()
);

fifo_pwr_quarter u3_hardfifo(
    .dout(rdata[15:12]),
    .din({wdata[31:28],wdata[15:12]}),
    .writeclk(wclk),
    .readclk(rclk),
    .writeen(wen),
    .readen(ren),
    .reset(reset),
    .full(),
    .empty(),
    .almostempty()
);

endmodule
