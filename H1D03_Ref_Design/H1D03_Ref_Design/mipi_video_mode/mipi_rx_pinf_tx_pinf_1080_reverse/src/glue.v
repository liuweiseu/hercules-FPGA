module glue (
//rx packet interface
	input macclk,
    input clk_periph,
	input [23:0] periph_rx_cmd,
	input periph_rx_cmd_valid,
	input [31:0] periph_rx_payload,
	input periph_rx_payload_valid,
	input periph_rx_payload_valid_last,
	input RxActiveHS,
	
	input RxByteClkHS,
	input periph_ecc_one_bit_err,
	input periph_ecc_two_bit_err,
	input [4:0] periph_ecc_one_bit_err_pos,
	input periph_ecc_err,
	input [2:0] periph_ecc_err_pos,
	input periph_crc_err,
		
	input reset_dpi_n,
	output rx_packet_test,
	
//panel initial	
    input [7:0] func,
    input [31:0] fifo_rdata,
    output fifo_rd,

    input TxByteClkHS,
    input rstn,
    input pstart,
    output packet_finish,
    input lp_rx_timeout,
	output[7:0] packet_asm_test,

    output rx_decode_vsync,
    output rx_decode_hsync,
    output fifo_empty,
	
//tx packet interface	
	output [1:0] host_tx_cmd_vc,
	output [5:0] host_tx_cmd_data_type,
	output [15:0] host_tx_cmd_byte_count,
	output host_tx_cmd_req,
	input host_tx_cmd_ack,
	output host_tx_hs_mode,
    input host_tx_active,
	input host_tx_payload_en,
	input host_tx_payload_en_last,
	output [31:0] host_tx_payload

);

//reg host_tx_cmd_ack_init_s;
//reg host_tx_active_init_s;


wire host_tx_cmd_req_init;
wire host_tx_cmd_ack_init;
wire host_tx_active_init;
wire [1:0] host_tx_cmd_vc_init;
wire [5:0] host_tx_cmd_data_type_init;
wire [15:0] host_tx_cmd_byte_count_init;
wire host_tx_hs_mode_init;
wire host_tx_payload_en_init;
wire host_tx_payload_en_last_init;
wire [31:0] host_tx_payload_init;


wire host_tx_cmd_req_bypass;
wire host_tx_cmd_ack_bypass;
wire host_tx_active_bypass;
wire [1:0] host_tx_cmd_vc_bypass;
wire [5:0] host_tx_cmd_data_type_bypass;
wire [15:0] host_tx_cmd_byte_count_bypass;
wire host_tx_hs_mode_bypass;
wire host_tx_payload_en_bypass;
wire host_tx_payload_en_last_bypass;
wire [31:0] host_tx_payload_bypass;


//FIFO access interface

reg rd_start_f,rd_start_s,rd_start_d;
wire rd_start_p;
reg rd_cmd_flag;
reg rd_cmd_flag_d;
reg [7:0] cmd_s;
reg [15:0] dnum_s;

always @ (posedge TxByteClkHS or negedge rstn) begin
	if (!rstn) begin
		rd_start_f<=1'b0;
		rd_start_s<=1'b0;
		rd_start_d<=1'b0;
	end
	else begin
		//rd_start_f<=func[2];
        rd_start_f<=pstart;
		rd_start_s<=rd_start_f;
		rd_start_d<=rd_start_s;
	end
end 

assign rd_start_p = rd_start_s&(!rd_start_d);

always @ (posedge TxByteClkHS or negedge rstn) begin
	if (!rstn)
        {rd_cmd_flag_d,rd_cmd_flag} <= 0;
    else
        {rd_cmd_flag_d,rd_cmd_flag} <= {rd_cmd_flag, rd_start_p};
end

always @ (posedge TxByteClkHS or negedge rstn) begin
	if (!rstn)
        cmd_s <= 0;
    else if(rd_cmd_flag_d)
        cmd_s <= fifo_rdata[7:0];
end

always @ (posedge TxByteClkHS or negedge rstn) begin
	if (!rstn)
        dnum_s <= 0;
    else if(rd_cmd_flag_d)
        dnum_s <= fifo_rdata[23:8];
end

assign fifo_rd = rd_cmd_flag || host_tx_payload_en;


//0x29
//assign host_tx_cmd_vc_init=cmd[7:6];
//assign host_tx_cmd_data_type_init=cmd[5:0];
//assign host_tx_cmd_byte_count_init=(cmd==6'h29)?{8'h0,dnum}:dset;
//assign host_tx_payload_init=(cmd==6'h29)?{16'h0,dset}:32'h0;

assign host_tx_cmd_vc_init=cmd_s[7:6];
assign host_tx_cmd_data_type_init=cmd_s[5:0];
assign host_tx_cmd_byte_count_init=dnum_s;
assign host_tx_payload_init=fifo_rdata;


assign host_tx_cmd_vc=(reset_dpi_n)?host_tx_cmd_vc_bypass:host_tx_cmd_vc_init;
assign host_tx_cmd_data_type=(reset_dpi_n)?host_tx_cmd_data_type_bypass:host_tx_cmd_data_type_init;
assign host_tx_cmd_byte_count=(reset_dpi_n)?host_tx_cmd_byte_count_bypass:host_tx_cmd_byte_count_init;
assign host_tx_cmd_req=(reset_dpi_n)?host_tx_cmd_req_bypass:host_tx_cmd_req_init;
assign host_tx_hs_mode=(reset_dpi_n)?host_tx_hs_mode_bypass:host_tx_hs_mode_init;
assign host_tx_payload=(reset_dpi_n)?host_tx_payload_bypass:host_tx_payload_init;

assign host_tx_cmd_ack_init=(!reset_dpi_n)?host_tx_cmd_ack:1'b0;
assign host_tx_active_init=(!reset_dpi_n)?host_tx_active:1'b0;
assign host_tx_cmd_ack_bypass=(reset_dpi_n)?host_tx_cmd_ack:1'b0;
assign host_tx_active_bypass=(reset_dpi_n)?host_tx_active:1'b0;
assign host_tx_payload_en_init=(!reset_dpi_n)?host_tx_payload_en:1'b0;
assign host_tx_payload_en_last_init=(!reset_dpi_n)?host_tx_payload_en_last:1'b0;
assign host_tx_payload_en_bypass=(reset_dpi_n)?host_tx_payload_en:1'b0;
assign host_tx_payload_en_last_bypass=(reset_dpi_n)?host_tx_payload_en_last:1'b0;


//assign host_tx_cmd_ack_bypass=host_tx_cmd_ack;
//assign host_tx_active_bypass=host_tx_active;
//assign host_tx_payload_en_bypass=host_tx_payload_en;
//assign host_tx_payload_en_last_bypass=host_tx_payload_en_last;
//
//assign host_tx_cmd_ack_init=host_tx_cmd_ack;
//assign host_tx_active_init=host_tx_active;
//assign host_tx_payload_en_init=host_tx_payload_en;
//assign host_tx_payload_en_last_init=host_tx_payload_en_last;

rx_packet_tx_packet_video rx_packet_tx_packet(
	.macclk(macclk),
	.clkin(clk_periph),
	.rx_cmd(periph_rx_cmd),
	.rx_cmd_valid(periph_rx_cmd_valid),
	.rx_payload(periph_rx_payload),
	.rx_payload_valid(periph_rx_payload_valid),
	.rx_payload_valid_last(periph_rx_payload_valid_last),
	.RxActiveHS(RxActiveHS),
	
	.RxByteClkHS(RxByteClkHS),
	.periph_ecc_one_bit_err(periph_ecc_one_bit_err),
    .periph_ecc_two_bit_err(periph_ecc_two_bit_err),
    .periph_ecc_one_bit_err_pos(periph_ecc_one_bit_err_pos),
    .periph_ecc_err(periph_ecc_err),
    .periph_ecc_err_pos(periph_ecc_err_pos),
    .periph_crc_err(periph_crc_err),

    .test0(rx_decode_hsync),
    .test1(rx_decode_vsync),
    //.fifo_empty(fifo_empty),
    	
	.rstn(rstn),
    .rgb_data_sel(reset_dpi_n),
	.clktx(TxByteClkHS),
	.req(host_tx_cmd_req_bypass),//output
	.ack(host_tx_cmd_ack_bypass),//input
	.active(host_tx_active_bypass),//input
	.host_tx_cmd_vc(host_tx_cmd_vc_bypass),//output
	.host_tx_cmd_data_type(host_tx_cmd_data_type_bypass),//output
	.host_tx_cmd_byte_count(host_tx_cmd_byte_count_bypass),//output
	.host_tx_hs_mode(host_tx_hs_mode_bypass),//output
	.host_tx_payload_en(host_tx_payload_en_bypass),//input
	.host_tx_payload_en_last(host_tx_payload_en_last_bypass),//input
	.host_tx_payload(host_tx_payload_bypass),//output
	.test(rx_packet_test)

);



packet_asm pasm(
    .clkin(TxByteClkHS),
    .rstn(rstn),
    //.start(rd_cmd_flag),//input
    .start(rd_cmd_flag_d),//input
    .cmd_rq(host_tx_cmd_req_init),//output
    .hs_mode(host_tx_hs_mode_init),//output
    .cmd_ack(host_tx_cmd_ack_init),//input
    .time_out(lp_rx_timeout),//input
    .packet_finish(packet_finish),//output
    .tx_act(host_tx_active_init),//input
    .hs_cfg(func[1]),
  	.test(packet_asm_test)
    );

	
endmodule	
