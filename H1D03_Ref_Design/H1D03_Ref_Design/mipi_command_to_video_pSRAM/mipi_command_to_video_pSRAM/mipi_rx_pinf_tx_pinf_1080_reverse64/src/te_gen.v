// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 07/14/2019 22:32:05   
// Design Name:
// Module Name: te_gen
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
module te_gen 
(
	input rstn,
	input clk,	
	output reg te
);



reg [22:0] te_cnt;
wire te_finish;
wire te_g0;
wire te_g1;

always @(posedge clk or negedge rstn) begin
	if(!rstn) begin
		te_cnt <= 23'b0;
	end 
	else if(te_finish)
		te_cnt <= 23'b0;
	else begin
		te_cnt<=te_cnt+1'b1;
	end
end

assign te_finish=(te_cnt==23'd1334333); //80M clk * 1280000 = 16.6ms
assign te_g0=(te_cnt==23'd100);
assign te_g1=(te_cnt==23'd300);



always @(posedge clk or negedge rstn) begin
	if(!rstn) begin
		te <= 1'b0;
	end else begin
		if(te_g0)
			te <= 1'b1;
		else if(te_g1)
			te <= 1'b0;
	end
end

endmodule
