module glue (
// tx dpi 
	input reset_dpi_n,
	input dpi_pclk,
	
    output host_dpi_hsync,
    output host_dpi_vsync,
    output host_dpi_de,
    output[23:0] host_dpi_d,

//panel initial	
    input rstn,
	input cpuclk,
    input TxByteClkHS,
    input pstart,
    input [7:0] func,
    input lp_rx_timeout,
	
    output packet_finish,
	output[7:0] packet_asm_test,
//fifo_rd		
    input [31:0] fifo_rdata,
	
    output fifo_rd,
//tx packet interface
	input host_tx_cmd_ack,
    input host_tx_active,
	input host_tx_payload_en,
	input host_tx_payload_en_last,
	
	output [1:0] host_tx_cmd_vc,
	output [5:0] host_tx_cmd_data_type,
	output [15:0] host_tx_cmd_byte_count,
	output host_tx_cmd_req,
	output host_tx_hs_mode,
	output [31:0] host_tx_payload

);


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

//*******************************************************************//
//*******************************************************************//


assign host_tx_cmd_vc_init=cmd_s[7:6];
assign host_tx_cmd_data_type_init=cmd_s[5:0];
assign host_tx_cmd_byte_count_init=dnum_s;
assign host_tx_payload_init=fifo_rdata;


assign host_tx_cmd_vc=host_tx_cmd_vc_init;
assign host_tx_cmd_data_type=host_tx_cmd_data_type_init;
assign host_tx_cmd_byte_count=host_tx_cmd_byte_count_init;
assign host_tx_cmd_req=(reset_dpi_n)?1'b0:host_tx_cmd_req_init;
assign host_tx_hs_mode=host_tx_hs_mode_init;
assign host_tx_payload=host_tx_payload_init;


assign host_tx_cmd_ack_init=host_tx_cmd_ack;
assign host_tx_active_init=host_tx_active;

pattern_gen #(        //720p
	.H_VAL(16'd720),
	.HFP(16'd10),
	.HSP(16'd2),
	.HBP (16'd10),
	
	.V_VAL (16'd1560),
	.VFP(16'd20),
	.VSP(16'd2),
	.VBP (16'd30)
)	
pgen(
    .rstn(reset_dpi_n),
    .px_clk(dpi_pclk), 
	
    .hsync(host_dpi_hsync),
    .vsync(host_dpi_vsync),
    .dval(host_dpi_de),
    .px_data(host_dpi_d)
);
	

packet_asm pasm(
    .clkin(TxByteClkHS),
    .rstn(rstn),
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
