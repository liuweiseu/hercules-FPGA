
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
module rx_packet_tx_packet_cmd_mode(
	input rst_n,
	input clkrx,
	input clktx,
	input RxByteClkHS,   //DPHY CLK信号
/*****************RX***************************/	
	input RxActiveHS,
	input [23:0] rx_cmd,
	input rx_cmd_valid,
	input [31:0] rx_payload,
	input rx_payload_valid,
	input rx_payload_valid_last,
	
/****************error status*********************/
	input periph_ecc_one_bit_err,
	input periph_ecc_two_bit_err,
	input [4:0] periph_ecc_one_bit_err_pos,
	input periph_ecc_err,
	input [2:0] periph_ecc_err_pos,
	input periph_crc_err,
	
/*********************TX****************************/	
	input host_tx_cmd_ack,
	input host_tx_active,
	input host_tx_payload_en,
	input host_tx_payload_en_last,
	
	output reg host_tx_cmd_req,
	output [1:0] host_tx_cmd_vc,
	output [5:0] host_tx_cmd_data_type,
	output [15:0] host_tx_cmd_byte_count,
	output host_tx_hs_mode,
    output reg [31:0] host_tx_payload,
    //output [31:0] host_tx_payload,

/********************TEST****************************/
	output [7:0] test
	
);


parameter RX_X_RESOLUTION = 1080;
parameter RX_Y_RESOLUTION = 2220;
parameter TX_X_RESOLUTION = 1080;
parameter TX_Y_RESOLUTION = 2160;




reg RxActiveHS_d;
reg [23:0] rx_cmd_d;
reg rx_cmd_valid_d;
reg [31:0] rx_payload_d;
reg rx_payload_valid_d;
reg rx_payload_valid_last_d;
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


wire val_det;
assign val_det=(rx_cmd_valid_d&&(rx_cmd_d[5:0] == 6'h39)&&(rx_cmd_d[23:8] == RX_X_RESOLUTION*3+1));

reg din_val;
always @ (posedge clkrx or negedge rst_n) begin
	if (!rst_n) begin
		din_val<=1'b0;
	end else if(val_det)
		din_val<=1'b1;
	else if(rx_payload_valid_last_d)
		din_val<=1'b0;
end

/***********************************************************/
/***********************rx fifo*****************************/
wire rx_fifo_wen;
wire rx_fifo_ren;
wire [31:0] rx_fifo_wdata;
wire [31:0] rx_fifo_rdata;
wire rx_fifo_prog_empty;
wire rx_fifo_rempty;
wire rx_fifo_wfull;

assign rx_fifo_wen = din_val&rx_payload_valid_d;
assign rx_fifo_wdata = rx_payload_d;


rx_data_fifo uut_rx_data_fifo(
	.wclk(clkrx),
	.rclk(clkrx),
	.rrst_n(rst_n),
	.wrst_n(rst_n),
	.wdata(rx_fifo_wdata),
	.rdata(rx_fifo_rdata),
	.wen(rx_fifo_wen),
	.ren(rx_fifo_ren),
	.prog_empty(rx_fifo_prog_empty),
	.rempty(rx_fifo_rempty),
	.wfull(rx_fifo_wfull)
);

reg [31:0] rx_fifo_rdata_d;
always @(posedge clkrx or negedge rst_n) begin
	if(!rst_n) begin
		rx_fifo_rdata_d <= 0;
	end else begin
		rx_fifo_rdata_d <= rx_fifo_rdata;
	end
end

/***********************************************************/
/***********************scaling****************************/
wire vs_out;
wire hs_out;
reg scalings_down_en;
always @ (posedge clkrx or negedge rst_n) begin
	if (!rst_n) begin
		scalings_down_en <= 1'b1;
	end else begin
		if(!rx_fifo_prog_empty)
			scalings_down_en <= 1'b0;
		else
			scalings_down_en <= 1'b1;
	end

end

wire tx_fifo_wen;
wire [31:0] tx_fifo_dat;
sc_down_top #(
	.RX_X_RESOLUTION(RX_X_RESOLUTION)
)
uut_sc_down_top(
	.clk(clkrx),
	.reset(~rst_n),
	.rx_fifo_dat(rx_fifo_rdata_d),
	.rx_fifo_empty(scalings_down_en),
	.rx_fifo_rd(rx_fifo_ren),
	.tx_fifo_dat(tx_fifo_dat),
	.tx_fifo_wen(tx_fifo_wen),
	.vs_out(vs_out),
	.hs_out(hs_out)
);
/***********************************************************/
/***********************tx fifo*****************************/
wire tx_fifo_ren;
wire [31:0] tx_fifo_rdata;
wire tx_fifo_prog_empty;
wire tx_fifo_rempty;
wire tx_fifo_wfull;

tx_data_fifo uut_tx_data_fifo(
    .wclk(clkrx),
    .rclk(clktx),
    .rrst_n(rst_n),
    .wrst_n(rst_n),
    .wdata(tx_fifo_dat),
    .rdata(tx_fifo_rdata),
//    .rdata(host_tx_payload),
    .wen(tx_fifo_wen),
    .ren(tx_fifo_ren),
    .prog_empty(tx_fifo_prog_empty),
    .rempty(tx_fifo_rempty),
    .wfull(tx_fifo_wfull)
);



always @(posedge clktx or negedge rst_n) begin
	if(!rst_n) begin
		host_tx_payload <= 0;
	end else begin
		host_tx_payload <= tx_fifo_rdata;
	end
end


/***********************************************************/
/***********************************************************/
reg rx_vs;
always @(posedge clkrx or negedge rst_n) begin
	if(!rst_n) begin
		rx_vs <=0;
	end else begin
		if(vs_out)
			rx_vs <= 1;
		else if(rx_vs_cnt >=4'd10)
			rx_vs <=0;
	end
end

reg [3:0] rx_vs_cnt;
always @(posedge clkrx or negedge rst_n) begin
	if(!rst_n) begin
		rx_vs_cnt <= 0;
	end else begin
		if(rx_vs)
			rx_vs_cnt <= rx_vs_cnt + 4'd1;
		else
			rx_vs_cnt <= 0;
	end
end



wire vss;
reg vsd;
reg vsdd;


assign vss = vsd&(!vsdd);
always @(posedge clktx or negedge rst_n) begin
	if(!rst_n) begin
		vsd <= 1'b0;
		vsdd <= 1'b0;
	end else begin
		vsd <= rx_vs;
		vsdd <= vsd;
	end
end


reg tx_frames;
always @(posedge clktx or negedge rst_n) begin
	if(!rst_n) begin
		tx_frames <= 1'b0;
	end else begin
		if(vss)
			tx_frames <= 1'b1;
		else if(tx_line_cnt >= TX_Y_RESOLUTION)
			tx_frames <= 1'b0;
	end
end


reg tx_fifo_ready;
always @(posedge clktx or negedge rst_n) begin
	if(!rst_n) begin
		tx_fifo_ready <= 1'b0;
	end else begin
		if(!tx_fifo_prog_empty)
			tx_fifo_ready <= 1'b1;
		else 
			tx_fifo_ready <= 1'b0;
	end
end



reg [11:0] tx_line_cnt;
always @(posedge clktx or negedge rst_n) begin
	if(!rst_n) begin
		tx_line_cnt <= 12'd0;
	end else begin
		if(tx_frames) begin
			if(tx_fifo_rd&host_tx_payload_en_last) 
				tx_line_cnt <= tx_line_cnt + 12'd1;
		end else begin
			tx_line_cnt <= 12'd0;
		end

	end
end




/***********************************************************/

assign host_tx_hs_mode=1'b1;
assign host_tx_cmd_vc=2'b00;
assign host_tx_cmd_data_type  = tx_fifo_ready?6'h39:6'h09;
assign host_tx_cmd_byte_count = tx_fifo_ready?(TX_X_RESOLUTION*3+1):16'd4;




always @(posedge clktx or negedge rst_n) begin
    if(!rst_n) begin
		host_tx_cmd_req <= 1'b0;
	end else begin
		if(tx_frames&tx_fifo_ready)
			host_tx_cmd_req <= 1'b1;
		else if((!tx_frames)&(tx_fifo_rempty))
			host_tx_cmd_req <= 1'b0;		
	end
end


assign tx_fifo_ren = host_tx_payload_en&tx_fifo_rd;

reg tx_fifo_rd;
always @ (posedge clktx or negedge rst_n) begin
	if (!rst_n) begin
		tx_fifo_rd<=1'b0;
	end else if(host_tx_cmd_ack&tx_fifo_ready) begin
			tx_fifo_rd<=1'b1;
	end else if(host_tx_payload_en_last) begin
			tx_fifo_rd<=1'b0;
	end
end 

/***********************************************************/
/*************************te********************************/
//te_gen #(
//.T1(23'd1000),     //9.97509ms
//.T2(23'd11814),		  //77.97us
//.T3(23'd2514569)  	  //16.596155ms
//)
//uut_te_gen(
//    //.rstn(te_en),
//    .rstn(rst_n),
//	.clk(clkrx),
//	.te(te)
//);
/***********************************************************/
/***********************************************************/
/*************************test******************************/


reg cmd_start;
always @(posedge clkrx or negedge rst_n) begin
	if (!rst_n) begin
		cmd_start <= 1'b0;
	end else begin
		if(rx_cmd_valid_d)
			cmd_start <= 1'b1;
		else if(rx_payload_valid_d)
			cmd_start <= 1'b0;
	end
end





                    
assign test[0]= (tx_fifo_dat[7:0]==8'h2c);     //(rx_payload_valid_d&&(rx_payload_d[7:0]==8'h2c))&cmd_start;
assign test[1]= (tx_fifo_dat[7:0]==8'h3c);     //(rx_payload_valid_d&&(rx_payload_d[7:0]==8'h3c))&cmd_start;
assign test[2]=  tx_fifo_wen;//host_tx_cmd_ack&tx_fifo_ready;   //(tx_fifo_dat[7:0]==8'h2c); //tx_fifo_ren;  //tx_fifo_ren_r&(tx_fifo_dat[7:0]==8'h2c);
assign test[3]=  vs_out; //tx_fifo_ren;  //(tx_fifo_dat[7:0]==8'h3c);//tx_fifo_ren_r;  //tx_fifo_ren_r&(tx_fifo_dat[7:0]==8'h3c);

assign test[4]=0;
assign test[5]=0;
assign test[6]=0;
assign test[7]=0;

/***********************************************************/
/***********************************************************/


endmodule













