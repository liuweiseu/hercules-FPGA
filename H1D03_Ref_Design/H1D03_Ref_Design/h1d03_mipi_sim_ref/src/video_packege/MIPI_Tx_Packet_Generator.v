

module MIPI_Tx_Packet_Generator
(
	input rstn,
	input clk_periph,
	input TxByteClkHS,
	input frame_start,
/***********tx packet interface*************/
	input host_tx_active,	
	input host_tx_cmd_ack,
	input host_tx_payload_en,
	input host_tx_payload_en_last,
	
	output [5:0]host_tx_cmd_data_type,
	output [15:0]host_tx_cmd_byte_count,
	output host_tx_cmd_req,
	output reg [31:0]host_tx_payload,
	output host_tx_hs_mode,
/******************************************/
	input rgb_data_sel,
	input rx_vsync,
	input rx_hsync,
    input tx_fifo_req,
	input fifo_empty,
	input fifo_almostempty,
	input tx_blight_out,
    input [31:0] tx_fifo_dout,	

	output reg rgb_data_en,
    output tx_fifo_readen,
/**************test **********************/		
	output test
);
	wire fifo_readen_0;
	wire host_tx_cmd_ack_bypass;
	wire host_tx_payload_en_bypass;
	wire host_tx_payload_en_last_bypass;

	assign tx_fifo_readen = fifo_readen_0;
    assign host_tx_hs_mode = 1;


	assign host_tx_cmd_ack_bypass = rgb_data_sel ? host_tx_cmd_ack : 0;
	assign host_tx_payload_en_bypass = rgb_data_sel ? host_tx_payload_en : 0;
	assign host_tx_payload_en_last_bypass = rgb_data_sel ? host_tx_payload_en_last : 0;
    
	
	//reg rgb_data_en = 0;
	always @ ( posedge clk_periph or negedge rstn )
	if ( !rstn )
		rgb_data_en <= 0;
	else if ( rx_vsync )
		rgb_data_en <= rgb_data_sel;
		
		
	MIPI_TX_Timing_Generator mipi_tx_timing_generator_inst
	(
		.RSTn(rstn),
		
		.Vsync(rx_vsync),
		.Hsync(rx_hsync),
		.frame_start(frame_start),

        .tx_fifo_req(tx_fifo_req),
	
		.CLK_tx(TxByteClkHS),
		.Tx_cmd_data_type(host_tx_cmd_data_type),
		.Tx_cmd_byte_count(host_tx_cmd_byte_count),
		.Tx_cmd_req(host_tx_cmd_req),
		.Tx_cmd_ack(host_tx_cmd_ack_bypass),
		.Tx_payload_en(host_tx_payload_en_bypass),
		.Tx_payload_en_last(host_tx_payload_en_last_bypass),
		.test(test),
        //.fifo_readen(fifo_readen),
		
        //.Fifo_almostempty(fifo_almostempty)
        .Fifo_almostempty(fifo_empty)
	);
	
	MIPI_TX_Fifo_Readen_Generator mipi_tx_fifo_readen_generator_inst
	(
		.CLK_tx(TxByteClkHS),
		.RSTn(rstn),
	
		.Tx_cmd_data_type(host_tx_cmd_data_type),
		.Tx_cmd_req(host_tx_cmd_req),
		.Tx_cmd_ack(host_tx_cmd_ack_bypass),
		.Tx_payload_en(host_tx_payload_en_bypass),
		.Tx_payload_en_last(host_tx_payload_en_last_bypass),
		.Fifo_almostempty(fifo_empty),
		.Fifo_readen(fifo_readen_0)
	);	

    always @ ( posedge TxByteClkHS or negedge rstn ) begin
        if ( !rstn )
            host_tx_payload <= 0;
        else
            host_tx_payload <= tx_fifo_dout;
    end
	
endmodule

