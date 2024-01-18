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
module te_gen #(
parameter T1= 32'd1511377,
parameter T2=32'd11814,
parameter T3=32'd2914569  
)
(
	input rstn,
	input clk,	
	
	output reg te
);



reg [31:0] te_cnt;
reg te_start;



always @(posedge clk or negedge rstn) begin
	if(!rstn) begin
		te_start <= 1'b0;
	end else begin
		if(te_cnt == T1)
			te_start <= 1'b1;
	end
end



always @(posedge clk or negedge rstn) begin
	if(!rstn) begin
		te_cnt <= 23'd0;
	end else begin
		if(te_start) begin
			if(te_cnt < T1+T2+T3)
				te_cnt <= te_cnt + 23'd1;
			else
				te_cnt <= T1;
		end else begin
			te_cnt <= te_cnt + 23'd1;
		end
	end
end


always @(posedge clk or negedge rstn) begin
	if(!rstn) begin
		te <= 1'b0;
	end else begin
		if(te_cnt == T1)
			te <= 1'b1;
		else if(te_cnt == T1+T2)
			te <= 1'b0;
	end
end

endmodule
