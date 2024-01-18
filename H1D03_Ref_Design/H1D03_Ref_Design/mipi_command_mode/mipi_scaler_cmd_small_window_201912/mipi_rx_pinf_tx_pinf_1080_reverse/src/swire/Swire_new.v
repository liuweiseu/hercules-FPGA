// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 09/07/2019 10:39:03   
// Design Name:
// Module Name: Swire
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
module Swire(
	input rst_n,
	input clkrx,
	input clk38M,
/*****************RX***************************/	
	input [23:0] rx_cmd,
	input rx_cmd_valid,
	input [31:0] rx_payload,
	input rx_payload_valid,
	input rx_payload_valid_last,
	
	output swire
	

);



reg [23:0] rx_cmd_d;
reg rx_cmd_valid_d;
reg [31:0] rx_payload_d;
reg rx_payload_valid_d;
reg rx_payload_valid_last_d;
always @(posedge clkrx or negedge rst_n) begin
	if(!rst_n) begin
		rx_cmd_d 				<= 0;
		rx_cmd_valid_d 			<= 0;
		rx_payload_d 			<= 0;
		rx_payload_valid_d 		<= 0;
		rx_payload_valid_last_d <= 0;		
	end else begin
		rx_cmd_d 				<= rx_cmd;
		rx_cmd_valid_d 			<= rx_cmd_valid;
		rx_payload_d 			<= rx_payload;
		rx_payload_valid_d 		<= rx_payload_valid;
		rx_payload_valid_last_d <= rx_payload_valid_last;
	end
end


wire val_det;
assign val_det=(rx_cmd_valid_d&&(rx_cmd_d[5:0] == 6'h39||rx_cmd_d[5:0] == 6'h29));

reg din_val;
always @ (posedge clkrx or negedge rst_n) begin
	if (!rst_n) begin
		din_val<=1'b0;
	end else if(val_det)
		din_val<=1'b1;
	else if(rx_payload_valid_d)
		din_val<=1'b0;
end


reg [15:0] bl_data5;
reg [15:0] bl_data1;
always @(posedge clkrx or negedge rst_n) begin 
	if(!rst_n) begin  
		bl_data5 <= 0;
		bl_data1 <= 0;
	end else begin
		if(din_val&&(rx_payload_d[7:0] == 8'hb5&&(rx_payload_d[23:16] == 8'hcc||rx_payload_d[23:16] == 8'hdc))) begin 
			bl_data5 <= {rx_payload_d[23:16],rx_payload_d[31:24]};
		end	else if(din_val&&(rx_payload_d[7:0] == 8'hb1)) begin	
			bl_data1 <= {rx_payload_d[15:8],rx_payload_d[23:16]};
		end
	end
end


wire s_swire_start;	

delay #(
		.SWIRESTARTDELAY(24'hfffff0)
)
uut_delay
(
	.i_reset_n      ( rst_n      ),
	.i_clk_38m      ( clktx      ),
	.o_swire_start  ( s_swire_start  )
);


wire o_swire;
io_ctrl io_ctrl
(
	.i_reset_n      ( rst_n      ),
	.i_clk_38m      ( clktx      ),
	.i_swire_start  ( s_swire_start  ),
	.i_b1_data      ( bl_data1   ),
	.i_b5_data      ( bl_data5   ),
	.o_swire        ( o_swire    )
);


assign swire = o_swire;


endmodule
