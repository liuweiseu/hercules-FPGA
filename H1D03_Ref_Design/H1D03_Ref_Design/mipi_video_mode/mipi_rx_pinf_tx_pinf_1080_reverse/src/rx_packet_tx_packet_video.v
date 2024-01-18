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
module rx_packet_tx_packet_video(
	input macclk,
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
	output req,
	input ack,
	input active,
	output [1:0] host_tx_cmd_vc,
	output [5:0] host_tx_cmd_data_type,
  output [15:0] host_tx_cmd_byte_count,
  output host_tx_hs_mode,
	input host_tx_payload_en,
	input host_tx_payload_en_last,
	output [31:0] host_tx_payload,
    input rgb_data_sel,
    output test0,
    output test1,
	output test

);

reg rx_cmd_valid_d;
reg rx_cmd_valid_dual;
reg [23:0] rx_cmd_d;
reg [23:0] rx_cmd_dual;
reg [31:0] rx_payload_d;
reg rx_payload_valid_d;
reg rx_payload_valid_last_d;
reg rx_active_hs_d;


wire tx_sync_fifo_empty;


//======================================================================================
//hsync and vsync processing
//======================================================================================
//reg tx_vsync, tx_hsync;
wire tx_vsync, tx_hsync;
reg tx_vsync_fo, tx_hsync_fo;
wire [5:0] rx_cmd_data_type = rx_cmd_d[5:0];
wire [15:0] rx_cmd_word_count = rx_cmd_d[23:8];

wire [5:0] rx_cmd_data_type_dual = rx_cmd_dual[5:0];
wire [15:0] rx_cmd_word_count_dual = rx_cmd_dual[23:8];
wire rx_decode_vsync;
wire rx_decode_hsync;

reg fifo_sync_readen = 0;
reg fifo_sync_readen_d = 0;
wire fifo_sync_empty;
wire tx_vsync_out, tx_hsync_out;

wire fifo_writeen;
wire [31:0]fifo_din;
wire fifo_almostempty_o;
wire fifo_empty_o;
reg fifo_empty;
reg fifo_almostempty;
wire fifo_readen;
wire [31:0] fifo_dout;
wire fifo_prog_empty_o;
wire fifo_wfull;
wire tx_fifo_readen;
wire [31:0] tx_fifo_dout;

wire [31:0] oxdat;
wire oxde;
reg oxde_d;
wire oxde_p;

wire rgb_data_en;
wire rstf;
reg  rstrf;
reg [1:0] rstsf;
reg sc_vs;
reg fifo_vs;
wire scde;
wire frame_start;

assign host_tx_cmd_vc = 2'b00;
//======================================================================================
//common logic
//======================================================================================
always@(posedge clkin or negedge rstn) begin
    if(~rstn) begin
        rx_cmd_d <= 0;
        rx_cmd_dual <= 0;
        rx_cmd_valid_d <= 0;
        rx_cmd_valid_dual <= 0;
        rx_payload_d <= 0;
        rx_payload_valid_d <= 0;
        rx_payload_valid_last_d <= 0;
        rx_active_hs_d <= 0;
    end else begin
        rx_cmd_d <= rx_cmd;
        rx_cmd_dual <= rx_cmd;
        rx_payload_d <= rx_payload;
        rx_cmd_valid_d <= rx_cmd_valid ;
        rx_cmd_valid_dual <= rx_cmd_valid ;
        rx_payload_valid_d <= rx_payload_valid;
        rx_payload_valid_last_d <= rx_payload_valid_last;
        rx_active_hs_d <= RxActiveHS;
    end
end


wire is_rx_hsync_start = ((rx_cmd_data_type == 6'h21) || (rx_cmd_data_type == 6'h11)) ? 1 : 0;
wire is_rx_vsync_start = (rx_cmd_data_type == 6'h01) ? 1 : 0;

/////////////////////////////////////////////////

reg rx_hsync = 0;
always @ ( posedge clkin or negedge rstn )
if ( rstn == 0 )
    rx_hsync <= 0;
else if ( rx_cmd_valid_d & is_rx_hsync_start & rx_active_hs_d)
    rx_hsync <= 1;
else
    rx_hsync <= 0;
    
assign rx_decode_hsync = rx_hsync;

reg rx_vsync = 0;
always @ ( posedge clkin or negedge rstn )
if ( rstn == 0 )
    rx_vsync <= 0;
else if ( rx_cmd_valid_d & is_rx_vsync_start & rx_active_hs_d)
    rx_vsync <= 1;
else
    rx_vsync <= 0;
    
assign rx_decode_vsync = rx_vsync;


wire tx_blight_out,tx_blight_outf;

fifo_sync fifo_sync_inst
(
    .reset(~rstn),
    
    .writeclk(clkin),
    .writeen(rx_decode_hsync | rx_decode_vsync),
    .din({2'b00,rx_decode_vsync, rx_decode_hsync}),
    .full(),
    .overflow(),

    .readclk(clktx),
    .readen(~fifo_sync_empty),
    .dout({tx_blight_outf,tx_blight_out,tx_vsync_out, tx_hsync_out}),
    .empty(fifo_sync_empty),
    .underflow()
);


always @ (posedge clktx or negedge rstn)
if ( !rstn )
    fifo_sync_readen <= 0;
else
    fifo_sync_readen <= !fifo_sync_empty;

always @ (posedge clktx or negedge rstn)
if ( !rstn )
    fifo_sync_readen_d <= 0;
else
    fifo_sync_readen_d <= fifo_sync_readen;
    
always @ (posedge clktx or negedge rstn)
if ( !rstn ) begin
    tx_vsync_fo <= 0;
    tx_hsync_fo <= 0;
end
else begin
    tx_vsync_fo <= fifo_sync_readen ? tx_vsync_out : 0;
    tx_hsync_fo <= fifo_sync_readen ? tx_hsync_out : 0;
    //tx_hsync_fo <= fifo_sync_readen ? (tx_hsync_out|tx_vsync_out) : 0;
end

sc_1080_720 u_scaler (
.clk_enable (	1'b1	),
.ce_out     (			),  //基于video模式的缩放
.macclk     (   clkin   ),
.clk		(	clkin		), 
.reset		(	~rstn), 
//.ivs		(	rx_vsync ),  //帧起始信号
.ivs		(	sc_vs	),
//.ihs		(   1'b0    ),  //行起始信号
.ide		(	fifo_readen  ),  //| scde输入数据有效信号，在数据期间一直保持高，可以和ihs同时有效，最多比ihs晚2个钟
.ihs		(   fifo_readen    ),  //行起始信号
.ovs		(	),  //输出的帧起始信号
.ohs		(	),  //输出的行起始信号
.idat		(	fifo_dout ),  //输入的待运算数据
.odat		(	oxdat	),  //输出的运算好的数据
.ode		(	oxde	)   //输出的数据有效信号，缩小时是断续的
);



always @( posedge clkin or negedge rstn) begin
    if(~rstn) begin
        rstrf <= 0;
    end else begin
        rstrf <= rstf;
    end
end


always @( posedge clkin or negedge rstn) begin
    if(~rstn) begin
        rstsf <= 0;
		sc_vs <= 0;
		fifo_vs <= 1;
    end else begin
        rstsf <= {rstsf[0],rstrf};
		if(rstsf==2'b01)begin
			sc_vs <= 1'b1;
			fifo_vs <= 0;
		end else begin
			sc_vs <= 1'b0;
			fifo_vs <= 1;
		end
    end
end

//wlzhu @ 0829 fifo_tx_sync from_sc_fifo(
fifo_32_1k from_sc_fifo(
	.wclk(clkin),
    .rclk(clktx),
//    .rrst_n(rstn&(~tx_vsync)),//&rstrf
//    .wrst_n(rstn&(~tx_vsync)),//&rstf
    .rrst_n(rstn&fifo_vs),//&rstrf
    .wrst_n(rstn&fifo_vs),//&rstf
    .wdata(oxdat),
    .rdata(tx_fifo_dout),
    .wen(oxde),
    .ren(tx_fifo_readen),
    .rempty(),
	.prog_empty(tx_sync_fifo_empty),
    .wfull()
);
//assign test0 = rx_vsync | fifo_readen;
//assign test1 = oxde;//rx_hsync;//fifo_writeen;//

//assign test0 = rx_vsync | fifo_readen;
//assign test1 = tx_fifo_readen;//oxde;//rx_hsync;//fifo_writeen;//

assign test0 = rx_vsync | fifo_readen;//oxde;//tx_sync_fifo_empty;//
assign test1 = fifo_writeen;//tx_fifo_readen;//rx_hsync;//

//assign test0 = rx_vsync;// | tx_hsync;
//assign test1 = rx_hsync;//fifo_writeen;//oxde;//

//assign test0 = 0;//tx_vsync;// | tx_hsync;
//assign test1 = 0;//tx_hsync;//fifo_writeen;//oxde;//

reg prog_empty_to_scl_t;

MIPI_SC_Timing sc1(
	.CLK_tx				(	clkin	),
	.RSTn				(	rstn	),
	.Vsync				(	rx_vsync	),
	.Hsync				(	rx_hsync	),
    .tx_fifo_req		(		),
    .fifo_readen		(	fifo_readen	),
	.rstf				(	rstf	),
//	.scde				(	scde	),
	.Fifo_almostempty   (prog_empty_to_scl_t		),
	.frame_start            (frame_start),
	.first_3e           (   first_3e)
);

sync_delay u_sync_delay(
    .hsync(tx_hsync_fo),
    .vsync(tx_vsync_fo),
    .clk(clktx),
    .rstn(rstn),
    .hsync_dly(tx_hsync),
    .vsync_dly(tx_vsync)
);

//assign test0 = tx_hsync;
//assign test1 = tx_vsync;
//assign test1 = tx_hsync;
//======================================================================================
//data processing 
//======================================================================================

mipi_data_process u_data_process (
    .CLKn(clkin),
    .RSTn(rstn),

    .rx_vsync(rx_decode_vsync),
    .rx_hsync(rx_decode_hsync),
    
    //.Rx_cmd_data_type(rx_cmd_data_type),
    //.Rx_cmd_word_count(rx_cmd_word_count),
    //.Rx_cmd_valid(rx_cmd_valid_d),
    .Rx_cmd_data_type(rx_cmd_data_type_dual),
    .Rx_cmd_word_count(rx_cmd_word_count_dual),
    .Rx_cmd_valid(rx_cmd_valid_dual),
    .Rx_payload(rx_payload_d),
    .Rx_payload_valid(rx_payload_valid_d),
    .Rx_payload_valid_last(rx_payload_valid_last_d),

	.frame_start            (frame_start),
    .fifo_writeen(fifo_writeen),
    .fifo_din(fifo_din)
);


//wlzhu@0829 fifo_mipi_tx to_sc_fifo(
fifo_32_1k to_sc_fifo(
    .wclk(clkin),
    .rclk(clkin),
    //.wrst_n(rstn & (~rx_decode_vsync)),
//    .wrst_n(rstn & (~rx_vsync)),//&rstf
//    .rrst_n(rstn & (~rx_vsync)),//&rstf
    .wrst_n(rstn & fifo_vs),//&rstf
    .rrst_n(rstn & fifo_vs),//&rstf
    .wdata(fifo_din),
    .rdata(fifo_dout),
//    .wen(fifo_writeen & rgb_data_en),
	.wen( fifo_writeen ),
    .ren(fifo_readen),
    .prog_empty(fifo_prog_empty_o),
    .almost_empty(fifo_almostempty_o),
    .rempty(fifo_empty_o),
    .wfull(fifo_wfull)
);

always @( posedge clkin or negedge rstn) begin
    if(~rstn) 
        prog_empty_to_scl_t <= 0;
    else
        prog_empty_to_scl_t <= fifo_prog_empty_o;
end



always @( posedge clktx or negedge rstn) begin
    if(~rstn) begin
        fifo_empty <= 1;
        fifo_almostempty <= 1;
    end else begin
        fifo_empty <= tx_sync_fifo_empty;
        //fifo_empty <= fifo_empty_o;
        //fifo_empty <= fifo_prog_empty_o;
        fifo_almostempty <= fifo_almostempty_o;
    end
end

MIPI_Tx_Packet_Generator mipi_tx_packet_generator
(  
    .clk_periph(clkin),
    .rstn(rstn),

    .TxByteClkHS(clktx),
	
	.frame_start(frame_start),
    //tx packet interface
    .host_tx_cmd_data_type(host_tx_cmd_data_type),
    .host_tx_cmd_byte_count(host_tx_cmd_byte_count),
    .host_tx_cmd_ack(ack),
    .host_tx_cmd_req(req),
    .host_tx_payload(host_tx_payload),
    .host_tx_payload_en(host_tx_payload_en),
    .host_tx_payload_en_last(host_tx_payload_en_last),
    .host_tx_hs_mode(host_tx_hs_mode),
    .host_tx_active(active),
    
    .rgb_data_sel(rgb_data_sel),
    //.rgb_data_sel(0),
    .rgb_data_en(rgb_data_en),
    .rx_vsync(tx_vsync),
    .rx_hsync(tx_hsync),
    .fifo_empty(fifo_empty),
    .fifo_almostempty(fifo_almostempty),
    //.fifo_readen(),//fifo_readen
    .test(test),
    //.rx_dsync(rx_decode_dsync),
	//.tx_blight_out(	tx_blight_out	),
    
    .tx_fifo_req(1'b0),
    .tx_fifo_readen(tx_fifo_readen),
    .tx_fifo_dout(tx_fifo_dout)
);

endmodule





















