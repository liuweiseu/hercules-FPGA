// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 09/18/2019 14:13:28   
// Design Name:
// Module Name: wd_set
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
module wd_set(
	input rst_n,
	input clkrx,
/*****************RX***************************/	
	input [23:0] rx_cmd,
	input rx_cmd_valid,
	input [31:0] rx_payload,
	input rx_payload_valid,
	input rx_payload_valid_last,
	
/***************************************************/	
	input busy,

	output reg wd_rdy,
	output [7:0] wd_2a_dats_l,
	output [7:0] wd_2a_dats_h,
	output [7:0] wd_2a_date_l,
	output [7:0] wd_2a_date_h,
	output [7:0] wd_2b_dats_l,
	output [7:0] wd_2b_dats_h,
	output [7:0] wd_2b_date_l,
	output [7:0] wd_2b_date_h

);




reg [23:0] rx_cmd_d;
reg rx_cmd_valid_d;
reg [31:0] rx_payload_d;
reg rx_payload_valid_d;
reg rx_payload_valid_last_d;
reg rx_payload_valid_last_dd;
always @(posedge clkrx or negedge rst_n) begin
	if(!rst_n) begin
		rx_cmd_d 				<= 0;
		rx_cmd_valid_d 			<= 0;
		rx_payload_d 			<= 0;
		rx_payload_valid_d 		<= 0;
		rx_payload_valid_last_d <= 0;	
		rx_payload_valid_last_dd <= 0;	
	end else begin
		rx_cmd_d 				<= rx_cmd;
		rx_cmd_valid_d 			<= rx_cmd_valid;
		rx_payload_d 			<= rx_payload;
		rx_payload_valid_d 		<= rx_payload_valid;
		rx_payload_valid_last_d <= rx_payload_valid_last;
		rx_payload_valid_last_dd <= rx_payload_valid_last_d;
	end
end	


wire busy_f;
reg busy_d;
reg busy_dd;
reg busy_ddd;
always @(posedge clkrx or negedge rst_n) begin
	if(!rst_n) begin
		busy_d 			<= 0;
		busy_dd 		<= 0;
		busy_ddd 		<= 0;
	end else begin
		busy_d 			<= busy;
		busy_dd 		<= busy_d;
		busy_ddd 		<= busy_dd;
	end
end


assign busy_f = busy_ddd&(!busy_dd);



wire rx_payload_valid_last_f;
assign rx_payload_valid_last_f = rx_payload_valid_last_dd&(!rx_payload_valid_last_d);






wire val_det;
assign val_det=(rx_cmd_valid_d&&(rx_cmd_d[5:0] == 6'h39|rx_cmd_d[5:0] == 6'h29)&&(rx_cmd_d[23:8] == 16'h0005));

reg din_val;
always @ (posedge clkrx or negedge rst_n) begin
	if (!rst_n) begin
		din_val<=1'b0;
	end else if(val_det)
		din_val<=1'b1;
	else if(rx_payload_valid_last_d)
		din_val<=1'b0;
end



reg [127:0] wd_buf;

always @ (posedge clkrx or negedge rst_n) begin
	if (!rst_n) begin
		wd_buf <= 0;
	end else if(din_val&rx_payload_valid_d)
		wd_buf <= {rx_payload_d,wd_buf[127:32]};
end	 


assign wd_2a_dats_h = busy_dd?wd_2a_dats_h:wd_buf[15:8];
assign wd_2a_dats_l = busy_dd?wd_2a_dats_l:wd_buf[23:16];
assign wd_2a_date_h = busy_dd?wd_2a_date_h:wd_buf[31:24];
assign wd_2a_date_l = busy_dd?wd_2a_date_l:wd_buf[39:32];
assign wd_2b_dats_h = busy_dd?wd_2b_dats_h:wd_buf[79:72];
assign wd_2b_dats_l = busy_dd?wd_2b_dats_l:wd_buf[87:80];
assign wd_2b_date_h = busy_dd?wd_2b_date_h:wd_buf[95:88];
assign wd_2b_date_l = busy_dd?wd_2b_date_l:wd_buf[103:96];


/*************************************************/

reg wd_2a_s;
reg wd_2b_s;
reg cmd_s; 


always @(posedge clkrx or negedge rst_n) begin 
	if(!rst_n) begin  
		cmd_s <= 1'b0;
	end else begin
		if(val_det) begin 
			cmd_s <= 1'b1;
		end	else if(rx_payload_valid_d) begin	
			cmd_s <= 1'b0;
		end
	end
end



always @(posedge clkrx or negedge rst_n) begin 
	if(!rst_n) begin 
		wd_2a_s <= 1'b0;
	end else begin
		if((rx_payload_valid_d&&(rx_payload_d[7:0]==8'h2a))&cmd_s) begin
			wd_2a_s <= 1'b1;
		end else if(busy_f) begin
			wd_2a_s <= 1'b0;
		end
	end
end


always @(posedge clkrx or negedge rst_n) begin 
	if(!rst_n) begin 
		wd_2b_s <= 1'b0;
	end else begin
		if((rx_payload_valid_d&&(rx_payload_d[7:0]==8'h2b))&cmd_s) begin
			wd_2b_s <= 1'b1;
		end else if(busy_f) begin
			wd_2b_s <= 1'b0;
		end
	end
end


always @(posedge clkrx or negedge rst_n) begin 
	if(!rst_n) begin 
		wd_rdy <= 1'b0;
	end else begin
		if((wd_2a_s&wd_2b_s&rx_payload_valid_last_f)) begin
			wd_rdy <= 1'b1;
		end else if(busy_f) begin
			wd_rdy <= 1'b0;
		end
	end
end


endmodule
