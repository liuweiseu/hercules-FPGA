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


module delaybuf_x9(
	I,
	O
);

input [8:0] I;
output [8:0] O;

generate
	genvar i;
	for(i = 0; i < 9; i=i+1) begin
		DELAY_BUF u_delaybuf (
				.in (I[i]),
				.out (O[i])
		);
	end
endgenerate

endmodule

module delaybuf_x15(
	I,
	O
);

input [14:0] I;
output [14:0] O;

generate
	genvar i;
	for(i = 0; i < 15; i=i+1) begin
		DELAY_BUF u_delaybuf (
				.in (I[i]),
				.out (O[i])
		);
	end
endgenerate

endmodule
