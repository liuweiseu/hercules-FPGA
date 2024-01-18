// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 12/02/2019 16:30:17   
// Design Name:
// Module Name: rx_packet_tx_packet_video_mode
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
module rx_packet_tx_packet_video_mode(
	input rst_n,
	input clkrx,
	input clktx,
	input RxByteClkHS,   //DPHY CLK淇″彿
/*****************RX***************************/	
	input RxActiveHS,
	input [23:0] rx_cmd,
	input rx_cmd_valid,
	input [31:0] rx_payload,
	input rx_payload_valid,
	input rx_payload_valid_last,
	
/*********************TX****************************/	
	input host_tx_cmd_ack,
	input host_tx_active,
	input host_tx_payload_en,
	input host_tx_payload_en_last,
	
	output host_tx_cmd_req,
	output [1:0] host_tx_cmd_vc,
	output [5:0] host_tx_cmd_data_type,
	output [15:0] host_tx_cmd_byte_count,
	output host_tx_hs_mode,
    output [31:0] host_tx_payload,


/********************TEST****************************/ 
	output [7:0] test
	
);


parameter RX_X_RESOLUTION = 12'd1080;
parameter RX_Y_RESOLUTION = 12'd1920;
parameter TX_X_RESOLUTION = 12'd1080;
parameter TX_Y_RESOLUTION = 12'd1920;	 






reg RxActiveHS_d;
reg [23:0] rx_cmd_d;
reg rx_cmd_valid_d;
reg [31:0] rx_payload_d;
reg rx_payload_valid_d;
reg rx_payload_valid_last_d;



wire [31:0] tx_fifo_wdata;
wire [31:0] tx_fifo_rdata;
wire tx_fifo_wen;
wire tx_fifo_ren;
wire tx_fifo_prog_empty;
wire [9:0] tx_fifo_rd_data_cnt;
wire tx_fifo_rempty;
wire tx_fifo_wfull;

wire is_rx_hsync_start;
wire is_rx_vsync_start;
reg rx_hsync;
reg rx_vsync; 
wire rx_decode_hsync;
wire rx_decode_vsync;


reg video_start;
wire val_det;
reg din_val;


/****************************************/
wire sync_rempty;
wire sync_wfull;
wire [3:0] sync_rdata;

reg fifo_sync_readen;
reg fifo_sync_readen_d;
reg tx_vsync_fo;
reg tx_hsync_fo;


wire tx_vsync;
wire tx_hsync;

reg data_3Eh_valid;
reg data_3Eh_valid_d;
wire data_3Eh_valid_p;
reg first_2c;
reg frame_start;




always @(posedge clkrx or negedge rst_n) begin
	if(!rst_n) begin
		RxActiveHS_d 			<= 0;
		rx_cmd_d 				<= 0;
		rx_cmd_valid_d 			<= 0;
		rx_payload_d 			<= 0;
		rx_payload_valid_d 		<= 0;
		rx_payload_valid_last_d <= 0;		
	end else begin
		RxActiveHS_d 			<= RxActiveHS;
		rx_cmd_d 				<= rx_cmd;
		rx_cmd_valid_d 			<= rx_cmd_valid;
		rx_payload_d 			<= rx_payload;
		rx_payload_valid_d 		<= rx_payload_valid;
		rx_payload_valid_last_d <= rx_payload_valid_last;
	end
end




/*************************************************************/
/*************************************************************/
always @ ( posedge clkrx or negedge rst_n ) begin
	if (!rst_n)
		video_start <= 0;
	else if (rx_cmd_valid_d&&rx_cmd_d[5:0] == 6'h01)
		video_start <= 1;
end


assign val_det=(rx_cmd_valid_d&&(rx_cmd_d[5:0] == 6'h3e)&&(rx_cmd_d[23:8] == RX_X_RESOLUTION*3))&video_start;


always @ (posedge clkrx or negedge rst_n) begin
	if (!rst_n) begin
		din_val<=1'b0;
	end else if(val_det)
		din_val<=1'b1;
	else if(rx_payload_valid_last_d)
		din_val<=1'b0;
end





/******************************************************************/
assign tx_fifo_wen = din_val&rx_payload_valid_d;
assign tx_fifo_wdata = rx_payload_d;





/*****************************************************************/

tx_data_fifo uut_tx_data_fifo(
	.wclk(clkrx),
	.rclk(clktx),
	.rrst_n(rst_n),
	.wrst_n(rst_n),
	.wdata(tx_fifo_wdata),
	.rdata(tx_fifo_rdata),
	.wen(tx_fifo_wen),
	.ren(tx_fifo_ren),
	.prog_empty(tx_fifo_prog_empty), 
	.rempty(tx_fifo_rempty),
	.wfull(tx_fifo_wfull)
);

/*******************************************************************/
/************************vedio package******************************/
/*************************同步信号*******************************/

assign is_rx_hsync_start = ((rx_cmd_d[5:0] == 6'h21) || (rx_cmd_d[5:0] == 6'h11)) ? 1 : 0;
assign is_rx_vsync_start = (rx_cmd_d[5:0] == 6'h01) ? 1 : 0;


always @ ( posedge clkrx or negedge rst_n ) begin
	if (!rst_n)
		rx_hsync <= 0;
	else if ( rx_cmd_valid_d&is_rx_hsync_start)
		rx_hsync <= 1;
	else
		rx_hsync <= 0;
end




always @ ( posedge clkrx or negedge rst_n ) begin
	if (!rst_n)
		rx_vsync <= 0;
	else if ( rx_cmd_valid_d&is_rx_vsync_start)
		rx_vsync <= 1;
	else
		rx_vsync <= 0;
end
 
assign rx_decode_hsync = rx_hsync;
assign rx_decode_vsync = rx_vsync;

/*************************************************************/


sync_fifo uut_sync_fifo(
    .wclk(clkrx),
    .rclk(clktx),
    .rrst_n(rst_n),
    .wrst_n(rst_n),
    .wdata({2'b00,rx_decode_vsync,rx_decode_hsync}),
    .rdata(sync_rdata),
    .wen(rx_decode_hsync|rx_decode_vsync),
    .ren(~sync_rempty),
    .rempty(sync_rempty),
    .wfull(sync_wfull)
);


always @ (posedge clktx or negedge rst_n)
if ( !rst_n )
    fifo_sync_readen <= 0;
else
    fifo_sync_readen <= !sync_rempty;

always @ (posedge clktx or negedge rst_n)
if ( !rst_n )
    fifo_sync_readen_d <= 0;
else
    fifo_sync_readen_d <= fifo_sync_readen;
    
always @ (posedge clktx or negedge rst_n)
if ( !rst_n ) begin
    tx_vsync_fo <= 0;
    tx_hsync_fo <= 0;
end
else begin
    tx_vsync_fo <= fifo_sync_readen ? sync_rdata[1] : 0;
    tx_hsync_fo <= fifo_sync_readen ? sync_rdata[0] : 0;
end






sync_delay u_sync_delay(
    .rstn(rst_n),
    .clk(clktx),
    .hsync(tx_hsync_fo),
    .vsync(tx_vsync_fo),
    .hsync_dly(tx_hsync),
    .vsync_dly(tx_vsync)
);


/******************************************/
always @ ( posedge clkrx or negedge rst_n ) begin
	if (!rst_n)
		data_3Eh_valid <= 0;
	else if (rx_cmd_valid_d&( rx_cmd_d[5:0] == 6'h3e))
		data_3Eh_valid <= 1;
	else if (rx_payload_valid_last_d)
		data_3Eh_valid <= 0;
	else
		data_3Eh_valid <= data_3Eh_valid;
end	


always @ ( posedge clkrx or negedge rst_n ) begin
	if (!rst_n)
		data_3Eh_valid_d <= 0;
	else
		data_3Eh_valid_d <= data_3Eh_valid;
end
		

assign data_3Eh_valid_p = ~data_3Eh_valid_d && data_3Eh_valid;


always @ (posedge clkrx or negedge rst_n) begin
	if(!rst_n)
		first_2c <= 1'b0;
	else if(rx_vsync)
		first_2c <= 1'b0;
	else if(data_3Eh_valid_p)
		first_2c <= 1'b1;
	else
		first_2c <= first_2c;
end   
	


always @ (posedge clkrx or negedge rst_n) begin
	if(!rst_n)
		frame_start <= 1'b0;
	else if(rx_vsync)
		frame_start <= 1'b0;
	else if(first_2c && rx_hsync)
		frame_start <= 1'b1;
	else
		frame_start <= frame_start;
end
/******************************************/

MIPI_Tx_Packet_Generator uut_MIPI_Tx_Packet_Generator
(
	.rstn(rst_n),
	.clk_periph(clkrx),
	.TxByteClkHS(clktx),
	.frame_start(frame_start),
/***********tx packet interface*************/
	.host_tx_active(host_tx_active),	
	.host_tx_cmd_ack(host_tx_cmd_ack),
	.host_tx_payload_en(host_tx_payload_en),
	.host_tx_payload_en_last(host_tx_payload_en_last),
	
	.host_tx_cmd_data_type(host_tx_cmd_data_type),
	.host_tx_cmd_byte_count(host_tx_cmd_byte_count),
	.host_tx_cmd_req(host_tx_cmd_req),
	.host_tx_payload(host_tx_payload),
	.host_tx_hs_mode(host_tx_hs_mode),
/******************************************/
	.rgb_data_sel(1'b1),
	.rx_vsync(tx_vsync),
	.rx_hsync(tx_hsync),
	.fifo_empty(tx_fifo_prog_empty),
	
    .tx_fifo_dout(tx_fifo_rdata),	

	.rgb_data_en(),
    .tx_fifo_readen(tx_fifo_ren),
/**************test **********************/		
	.test()
);
 


endmodule

































