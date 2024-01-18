// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 07/01/2019 18:24:35   
// Design Name:
// Module Name: mipi_byteclk_delay
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
module mipi_byteclk_delay(
	I,
	O
);

input  I;
output O;

parameter DLY_LEVEL = 6;

wire [DLY_LEVEL:0] byteclk_dly_wire;

assign byteclk_dly_wire[DLY_LEVEL] = I;
assign O = byteclk_dly_wire[0];

generate
	genvar i;
	for(i = DLY_LEVEL-1; i >= 0; i=i-1) begin
		DELAY_BUF u_mipi_clkdly (
				.in (byteclk_dly_wire[i+1]),
				.out (byteclk_dly_wire[i])
		);
	end
endgenerate

endmodule
