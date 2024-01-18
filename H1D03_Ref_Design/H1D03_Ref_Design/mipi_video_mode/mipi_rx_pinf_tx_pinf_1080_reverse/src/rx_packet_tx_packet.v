// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 02/13/2019 15:31:24   
// Design Name:
// Module Name: rx_packet_tx_packet
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
module rx_packet_tx_packet(

	input clkin,
	input [23:0] rx_cmd,
	input rx_cmd_valid,
	input [31:0] rx_payload,
	input rx_payload_valid,
	input rx_payload_valid_last,
	input RxActiveHS,
	
	input RxByteClkHS,
	
	input periph_ecc_one_bit_err,
	input periph_ecc_two_bit_err,
	input [4:0] periph_ecc_one_bit_err_pos,
	input periph_ecc_err,
	input [2:0] periph_ecc_err_pos,
	input periph_crc_err,
	
	input rstn,
	input clktx,
	output reg req,
	input ack,
	input active,
	output [1:0] host_tx_cmd_vc,
	output [5:0] host_tx_cmd_data_type,
  output [15:0] host_tx_cmd_byte_count,
  output host_tx_hs_mode,
	input host_tx_payload_en,
	input host_tx_payload_en_last,
	output [31:0] host_tx_payload,
	output[15:0] test

);


reg RxActiveHS_s;
reg RxActiveHS_t;
wire RxActiveHS_r;
wire empty;
reg [15:0] cnt_empty;
reg rd_flag;
wire rd;
reg ack_s;
reg active_s;
wire [24:0] cmd_out;
reg host_tx_payload_en_s;
reg host_tx_payload_en_last_s;
wire [31:0] data_out;

wire vsync_start_det_rx;
wire hsync_start_det_rx;
wire data_start_rx;
wire vsync_end_det_rx;
wire vsync_start_det;
wire hsync_start_det;
wire data_start;
wire empty1;
wire full1;
wire full0;

reg[15:0] blk_cnt;
reg vdata_wval;
reg vdata_rval;
wire w_val;
wire r_val;
reg[10:0] rx_cnt;
reg[10:0] tx_cnt;

wire rx_get;
wire tx_get;
wire rx_h_get;
wire tx_h_get;
reg[10:0] rx_h_cnt;
reg[10:0] tx_h_cnt;
	
wire drdy;
reg drdy_s;
reg fifo_rst;

//*************************************************************//
//*************************************************************//
//*************************************************************//
//test
//assign test[0]=rx_get;
//assign test[1]=tx_get;
//assign test[2]=rx_h_get;
//assign test[3]=tx_h_get;
assign test[0]=w_val;
assign test[1]=r_val;
assign test[2]=full1;
assign test[3]=empty1;
//assign test[0]=w_val;
//assign test[1]=RxActiveHS_t;
//assign test[2]=rd_flag;
//assign test[3]=r_val;
//assign test[0]=w_val;
//assign test[1]=hsync_start_det_rx;
//assign test[2]=rd_flag;
//assign test[3]=hsync_start_det;
//assign test[0]=vsync_start_det_rx;
//assign test[1]=vsync_end_det_rx;
//assign test[2]=hsync_start_det_rx;
//assign test[3]=w_val;

assign test[4]=tx_h_get;
assign test[5]=RxActiveHS;
assign test[6]=rd;
assign test[7]=rx_cmd_valid;
assign test[8]=ack; 
assign test[9]=drdy_s;
assign test[10]=tx_get;
assign test[11]=r_val;
assign test[12]=empty;  
assign test[13]=empty1;
assign test[14]=full0;

 
//*************************************************************//
//*************************************************************//
//*************************************************************//


assign vsync_start_det_rx =rx_cmd_valid& (rx_cmd[5:0] == 6'h01);
assign hsync_start_det_rx =rx_cmd_valid& (rx_cmd[5:0] == 6'h21);
assign data_start_rx =rx_cmd_valid& (rx_cmd[5:0] == 6'h3e);
assign vsync_end_det_rx =rx_cmd_valid& (rx_cmd[5:0] == 6'h11);


assign vsync_start_det =req&ack&(host_tx_cmd_data_type == 6'h01);
assign hsync_start_det =req&ack&(host_tx_cmd_data_type == 6'h21);
assign data_start =req&ack&(host_tx_cmd_data_type == 6'h3e);


//*************************************************************//
//*************************************************************//
//*************************************************************//
//cnt test
//
//always @(posedge clkin or negedge rstn) begin
//	if (!rstn) begin
//		rx_h_cnt<=11'h0;
//	end
//	else if(hsync_start_det_rx)
//		rx_h_cnt<=11'h0;
//	else if(w_val)
//		rx_h_cnt<=1'h1+rx_h_cnt;
//end
//
//always @(posedge clkin or negedge rstn) begin
//	if (!rstn) begin
//		rx_cnt<=11'h0;
//	end
//	else if(vsync_start_det_rx)
//		rx_cnt<=11'h0;
//	else if(data_start_rx)
//		rx_cnt<=1'h1+rx_cnt;
//end
//
//always @(posedge clktx or negedge rstn) begin
//	if (!rstn) begin
//		tx_h_cnt<=11'h0;
//	end
//	else if(hsync_start_det)
//		tx_h_cnt<=11'h0;
//	else if(r_val)
//		tx_h_cnt<=1'h1+tx_h_cnt;
//	
//end
//
//always @(posedge clktx or negedge rstn) begin
//	if (!rstn) begin
//		tx_cnt<=11'h0;
//	end
//	else if(vsync_start_det)
//		tx_cnt<=11'h0;
//	else if(data_start)
//		tx_cnt<=1'h1+tx_cnt;
//	
//end
//
//
//
//
//assign rx_get= (rx_cnt==11'd1920);
//assign tx_get= (tx_cnt==11'd1920);
//
//assign rx_h_get= (rx_h_cnt==11'd810);//1080*3/4
//assign tx_h_get= (tx_h_cnt==11'd810);//1080*3/4
//
//*************************************************************//
//*************************************************************//
//*************************************************************//

always @ (posedge clktx or negedge rstn) begin//rd domain
	if (!rstn) begin
		fifo_rst<=1'b0;
	end
	else if(vsync_start_det)
		fifo_rst<=1'b1;
	else if(hsync_start_det)
		fifo_rst<=1'b0;
end 


//rx clk

always @(posedge clkin or negedge rstn) begin
	if (!rstn) begin
		vdata_wval<=1'h0;
	end
	else if(data_start_rx)//high priority
		vdata_wval<=1'h1;
	else if(rx_payload_valid_last)
		vdata_wval<=1'h0;
end

assign w_val=(vdata_wval|(data_start_rx&(!rx_payload_valid_last)))&rx_payload_valid;//data_start_rx&(!rx_payload_valid_last) means current rx_payload_valid, data_start_rx&(rx_payload_valid_last) means last rx_payload_valid


//tx clk

always @(posedge clktx or negedge rstn) begin
	if (!rstn) begin
		vdata_rval<=1'h0;
	end
	else if(data_start)//high priority
		vdata_rval<=1'h1;
	else if(host_tx_payload_en_last)
		vdata_rval<=1'h0;
end

assign r_val=vdata_rval&host_tx_payload_en;

always @(posedge clktx or negedge rstn) begin
	if (!rstn) begin
		RxActiveHS_s<=1'h0;
		RxActiveHS_t<=1'h0;
	end
	else begin
		RxActiveHS_s<=RxActiveHS;
		RxActiveHS_t<=RxActiveHS_s;
		
	end
end

assign RxActiveHS_r=RxActiveHS_s&(!RxActiveHS_t);



always @(posedge clktx or negedge rstn)
begin
  if (!rstn)
		cnt_empty<=16'd0;
//	else if(!RxActiveHS_t)//only decode hs mode
	else if(RxActiveHS_r)//decode hs and lp mode
		cnt_empty<=16'd0;
	else if(RxActiveHS_t&&(!empty))//empty rd domain
		cnt_empty<=cnt_empty+1;	
end

always @(posedge clktx or negedge rstn)
begin
  if (!rstn)
		rd_flag<=1'b0;
	//else if(!RxActiveHS_t)//only decode hs mode
	else if(RxActiveHS_r)//decode hs and lp mode
		rd_flag<=1'b0;
	else if(cnt_empty==16'd50)//can modify, vblanking cmd 411ns,clktx=107.2M, 411*107.2/1000=44.059,50>44
		rd_flag<=1'b1;
end



always @(posedge clktx or negedge rstn)
begin
  if (!rstn)
		blk_cnt<=16'd0;
	else if(RxActiveHS_t)//hs mode
		blk_cnt<=16'd0;
	else if(!empty)//lp mode
		blk_cnt<=blk_cnt+1;	
end



always @(posedge clktx or negedge rstn)
begin
  if (!rstn)
		drdy_s<=1'd0;
	else 
		drdy_s<=drdy;
end


//first rd: rd_flag&&drdy_s&&(!empty)&&(!req),same hs mode next rd: rd_flag&&drdy_s&&(!empty)&&(req&&ack)
//vblanking cmd first rd: (!empty)&&(!rd_flag)&&(blk_cnt==16'd2),same hs mode next rd: (!empty)&&(!rd_flag)&&(req&&ack)
assign	  rd = (rd_flag&&drdy_s&&(!empty)&&((!req)||(req&&ack)))|((!empty)&&(!rd_flag)&&((blk_cnt==16'd2)||(req&&ack)));

always @(posedge clktx or negedge rstn)
begin
  if (!rstn)
		req<=1'b0;
	else if(ack&&empty)
		req<=1'b0;
	else if(rd)
		req<=1'b1;
end


always @ (posedge clktx or negedge rstn) begin
	if (!rstn) begin
		ack_s<=1'b0;
	end
	else 
		ack_s<=ack;
end 

always @ (posedge clktx or negedge rstn) begin
	if (!rstn) begin
		active_s<=1'b0;
	end
	else 
		active_s<=active;
end   

always @ (posedge clktx or negedge rstn) begin
	if (!rstn) begin
		host_tx_payload_en_s<=1'b0;
	end
	else 
		host_tx_payload_en_s<=host_tx_payload_en;
end   

always @ (posedge clktx or negedge rstn) begin
	if (!rstn) begin
		host_tx_payload_en_last_s<=1'b0;
	end
	else 
		host_tx_payload_en_last_s<=host_tx_payload_en_last;
end      

assign host_tx_cmd_vc=cmd_out[7:6];
assign host_tx_cmd_data_type=cmd_out[5:0];
assign host_tx_cmd_byte_count=cmd_out[23:8];
assign host_tx_hs_mode=cmd_out[24];

//assign host_tx_payload=data_out;
reg [31:0] data_out_d;
assign host_tx_payload=data_out_d;
always @(posedge clktx or negedge rstn) begin
    if (~rstn)
        data_out_d <= 0;
    else
        data_out_d <= data_out;
end

rx_cmd_fifo rx_cmd_fifo(
    .wdata({RxActiveHS,rx_cmd[23:0]}),
    .wclk	(clkin),
    .wen	(rx_cmd_valid),
	
    .rclk	    (clktx),		
	  .rdata    (cmd_out),
    .ren	    (rd),
    .wrst_n		(rstn),
    .rrst_n		(rstn),
    .wfull		(full0),
    .rempty		(empty)
);




rx_data_fifo rx_data_fifo(
    .wdata(rx_payload),
    .wclk	(clkin),
    .wen	(w_val),
	
    .rclk	    (clktx),		
	  .rdata    (data_out),
    .ren	    (r_val),
    .wrst_n		(rstn&(!fifo_rst)),//reset for long time
    .rrst_n		(rstn&(!fifo_rst)),//reset for long time
	
//	.wrst_n		(rstn),
//  .rrst_n		(rstn),
//	.almost_full(drdy),
	  .prog_full(drdy),
    .wfull		(full1),
    .rempty		(empty1)
);


endmodule





















