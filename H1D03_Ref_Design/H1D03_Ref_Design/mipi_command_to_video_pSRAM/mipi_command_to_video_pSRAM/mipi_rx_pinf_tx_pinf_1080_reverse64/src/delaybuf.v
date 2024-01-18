// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 07/01/2019 17:23:38   
// Design Name:
// Module Name: delaybuf_x32
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
module delaybuf_x32(
	I,
	O
);

input [31:0] I;
output [31:0] O;

generate
	genvar i;
	for(i = 0; i < 32; i=i+1) begin
		DELAY_BUF u_delaybuf (
				.in (I[i]),
				.out (O[i])
		);
	end
endgenerate

endmodule


module delaybuf_x16(
	I,
	O
);

input [15:0] I;
output [15:0] O;

generate
	genvar i;
	for(i = 0; i < 16; i=i+1) begin
		DELAY_BUF u_delaybuf (
				.in (I[i]),
				.out (O[i])
		);
	end
endgenerate

endmodule

module delaybuf_x8(
	I,
	O
);

input [7:0] I;
output [7:0] O;

generate
	genvar i;
	for(i = 0; i < 8; i=i+1) begin
		DELAY_BUF u_delaybuf (
				.in (I[i]),
				.out (O[i])
		);
	end
endgenerate

endmodule

module delaybuf_x6(
	I,
	O
);

input [5:0] I;
output [5:0] O;

generate
	genvar i;
	for(i = 0; i < 6; i=i+1) begin
		DELAY_BUF u_delaybuf (
				.in (I[i]),
				.out (O[i])
		);
	end
endgenerate

endmodule

module delaybuf_x1(
	I,
	O
);

input I;
output O;


		DELAY_BUF u_delaybuf (
				.in (I),
				.out (O)
		);
		
	


endmodule



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




