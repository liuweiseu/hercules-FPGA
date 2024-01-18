`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/13 17:36:31
// Design Name: 
// Module Name: mipi_rx_pinf_tx_pinf_1080
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mipi_rx_pinf_tx_pinf_1080(
	
	//output[3:0] test,
    output rx_decode_hsync,
    output rx_decode_vsync,
    output swire,
	input phone_rst
//    ,output lcd_rst

    );
wire 	osc_o;	
wire 	locked;
reg 	rstn_r = 0;
wire 	rstn;	
wire 	esc_clk;
wire 	esc_clk_rx;
wire	cpuclk;
wire    macclk;

wire	rstn_mipi;
wire 	reset_dpi_n;

wire 	 tx_dphy_rdy;
wire     tx_dphy_rdy_periph;
wire 	 PD_DPHY;
wire 	 LOCK;

wire pstart;
wire packet_finish;

wire[7:0] fifott;
/***************************************************/
/*****************apb interface*********************/
/***************************************************/
wire[17:0] 	 paddr;
wire[19:0] 	 paddr_mst;
wire[31:0] 	 prdata;
wire[31:0] 	 prdata_mipi2;
wire[31:0] 	 prdata_mipi1;
wire[31:0] 	 pwdata;
wire 	 pready;
wire 	 pready_mipi2;
wire 	 pready_mipi1;
wire 	 psel_mipi1;
wire 	 psel_mipi2;
wire 	 pclk;
wire 	 pwrite;
wire 	 psel;
wire 	 penable;

/***************************************************/
/*****************tx packet interface***************/
/***************************************************/

wire[1:0] host_tx_cmd_vc;
wire[5:0] host_tx_cmd_data_type;
wire[15:0] host_tx_cmd_byte_count;

    //wire rx_decode_hsync;
    //wire rx_decode_vsync;

wire host_tx_cmd_req;
wire host_tx_cmd_ack;
wire host_tx_hs_mode;
wire host_tx_active;
wire host_lp_rx_timeout;
wire[31:0] host_tx_payload;
wire host_tx_payload_en;
wire host_tx_payload_en_last;
wire TxByteClkHS;
wire TxByteClkHS_s;


/***************************************************/
/*****************8051 interface********************/
/***************************************************/
wire memack;
wire mempsack;
wire mempsrd_comb;
wire mempswr_comb;
wire memrd_comb;
wire memwr_comb;
wire[7:0] memdatai;
wire[7:0] memdatao_comb;
wire[22:0] memaddr_comb;

wire[7:0] port0o;
wire[7:0] port0i;
wire[7:0] port1i;

/***************************************************/
/*****************rx packet interface***************/
/***************************************************/
wire clk_periph;
wire[23:0]	periph_rx_cmd ;
wire		periph_rx_cmd_valid ;
wire[31:0]	periph_rx_payload ;
wire		periph_rx_payload_valid ;
wire		periph_rx_payload_valid_last ;
wire        RxActiveHS;
wire RxByteClkHS;
wire periph_ecc_one_bit_err;
wire periph_ecc_two_bit_err;
wire [4:0] periph_ecc_one_bit_err_pos;
wire periph_ecc_err;
wire [2:0] periph_ecc_err_pos;
wire periph_crc_err;

/***************************************************/
/*****************8051 extended register************/
/***************************************************/
wire[7:0] func;
wire mipi_sel;
wire fifo_rd;
wire [31:0] fifo_rdata;

//ID processing
wire periph_tx_payload_en;
wire periph_tx_payload_en_last;
wire periph_tx_cmd_ack;
wire periph_dphy_direction;
wire [31:0] periph_tx_payload;
wire periph_tx_cmd_vc;
wire [5:0] periph_tx_cmd_data_type;
wire [15:0] periph_tx_cmd_byte_count;
wire periph_tx_cmd_req;
wire fifo_empty;
wire rx_packet_test;

//assign rx_decode_hsync =  host_tx_cmd_req;
//assign rx_decode_hsync =  fifo_empty;

//assign rx_decode_hsync =  host_tx_cmd_ack;
//assign rx_decode_vsync =  host_tx_cmd_ack;

//test
// assign test[0]=osc_o;
// assign test[1]=reg_sel;
// assign test[2]=data_sel;
// assign test[3]=ram_ack;
// assign test[4]=apb_sel;
// assign test[5]=apb_memack;
// assign test[6]=memack;
// assign test[7]=reg_rd;
// assign test[8]=reg_wr;
// assign test[9]=host_tx_cmd_req_init;
// assign test[10]=host_tx_cmd_ack_init;
// assign test[11]=host_lp_rx_timeout;
// assign test[12]=tx_dphy_rdy;
// assign test[13]=rstn_mipi;
// assign test[14]=tx_dphy_rdy_periph;
 //assign panel_rst=port0o[7];

 assign swire = 1;
// assign lcd_rst = phone_rst;



assign PD_DPHY=~rstn_mipi;


always @ (posedge osc_o) begin
    rstn_r <= locked;
end

//GBUF buf_rst(.in(rstn_r), .out(rstn));
//assign rstn = locked;
assign rstn = rstn_r & phone_rst;



//assign TxByteClkHS=TxByteClkHS_s;
wire TxByteClkHS_t;

mipi_byteclk_delay #(.DLY_LEVEL(4)) u0_mipi1_clkdly(.I(TxByteClkHS_s), .O(TxByteClkHS_t));
//mipi_byteclk_delay #(.DLY_LEVEL(7)) u0_mipi1_clkdly(.I(TxByteClkHS_s), .O(TxByteClkHS_t));
//mipi_byteclk_delay #(.DLY_LEVEL(2)) u0_mipi1_clkdly(.I(TxByteClkHS_s), .O(TxByteClkHS_t));

gbuf_v1_1 u_gbuf(
   .I(TxByteClkHS_t),
   .O(TxByteClkHS)
);



glue glue(
//rx packet interface    
	.macclk(clk_periph/*macclk*/), //@0831 wlzhu
    .clk_periph(clk_periph),
	.periph_rx_cmd(periph_rx_cmd),
	.periph_rx_cmd_valid(periph_rx_cmd_valid),
	.periph_rx_payload(periph_rx_payload),
	.periph_rx_payload_valid(periph_rx_payload_valid),
	.periph_rx_payload_valid_last(periph_rx_payload_valid_last),
	.RxActiveHS(RxActiveHS),
	
	.RxByteClkHS(RxByteClkHS),
	.periph_ecc_one_bit_err(periph_ecc_one_bit_err),
    .periph_ecc_two_bit_err(periph_ecc_two_bit_err),
    .periph_ecc_one_bit_err_pos(periph_ecc_one_bit_err_pos),
    .periph_ecc_err(periph_ecc_err),
    .periph_ecc_err_pos(periph_ecc_err_pos),
    .periph_crc_err(periph_crc_err),

    .rx_decode_vsync(rx_decode_vsync),
    .rx_decode_hsync(rx_decode_hsync),
    //.fifo_empty(fifo_empty),
	.reset_dpi_n(reset_dpi_n),
    .rx_packet_test(rx_packet_test),

//panel initial	
    
	.func             (func      ),	

    .fifo_rd          (fifo_rd),
    .fifo_rdata       (fifo_rdata),

	.TxByteClkHS(TxByteClkHS),
    .rstn(rstn),
    .pstart(pstart),
    .lp_rx_timeout(1'b0),
    .packet_finish(packet_finish),
	.packet_asm_test(fifott),
	
//tx packet interface	
	.host_tx_cmd_vc 				(host_tx_cmd_vc)	,
	.host_tx_cmd_data_type 		    (host_tx_cmd_data_type)	,
	.host_tx_cmd_byte_count 		(host_tx_cmd_byte_count)	,
	.host_tx_cmd_ack 			    (host_tx_cmd_ack)	,
	.host_tx_cmd_req 			    (host_tx_cmd_req)	,
	.host_tx_payload 				(host_tx_payload)	,
	.host_tx_payload_en 			(host_tx_payload_en)	,
	.host_tx_payload_en_last 		(host_tx_payload_en_last)	,
	.host_tx_hs_mode 				(host_tx_hs_mode)	,
	.host_tx_active 				(host_tx_active)	

);




//debugware_v2_1 debugware(
//    .trig_out_0(),
//    //.data_in_0({RxActiveHS,periph_rx_payload_valid_last,periph_rx_payload_valid,periph_rx_cmd,periph_rx_cmd_valid}),
//    //.ref_clk_0(clk_periph)
//	.data_in_0({host_tx_payload_en_last,host_tx_payload_en,host_tx_cmd_byte_count,host_tx_cmd_data_type,host_tx_cmd_vc,host_tx_cmd_ack,host_tx_cmd_req}),
//    .ref_clk_0(TxByteClkHS)
//);
	

pll_v1 u_pll(
    .clkin0(osc_o),
    .clkout0(clk_periph), //130M
    .clkout1(esc_clk), //20M
    .clkout2(esc_clk_rx),//60M
	.clkout3(cpuclk),//50M
	.clkout4(macclk),
    .locked(locked)
);

//assign esc_clk_rx = cpuclk;


OSCV1 u_osc(
    .OSC(osc_o)
);

//assign rx_decode_hsync =  osc_o;
//assign rx_decode_vsync =  RxByteClkHS;

assign reset_dpi_n=(func[0]&&rstn)?port0o[0]:1'b0;
assign pstart = (func[0]&&rstn)?port0o[1]:1'b0;
assign rstn_mipi =(func[0]&&rstn)? port0o[2] :1'b0;
//assign panel_rst=(func[0]&&rstn)? port0o[7]:1'b0;

assign port0i[3]=packet_finish;
assign port0i[4]=tx_dphy_rdy&tx_dphy_rdy_periph&LOCK;
assign port0i[5]=phone_rst;



//assign cpuclk = clk_periph;

mcu_arbiter  mcu_arbiter(                               
	.cpuclk          (cpuclk	   ),
	.rstn            (rstn		   ),
	.memaddr_comb    (memaddr_comb ),
	.memdatao_comb   (memdatao_comb),
	.memrd_comb      (memrd_comb   ),
	.memwr_comb      (memwr_comb   ),
	.mempsrd_comb    (mempsrd_comb ),
    .mempswr_comb    (mempswr_comb ),
	
	.memack          (memack  ),
	.memdatai        (memdatai),
	.mempsack        (mempsack),
    
//8051 to mipi apb	
	.prdata  	     (prdata   ),
	.pready          (pready   ),
	.paddr_mst    	 (paddr_mst),
	.pwrite          (pwrite   ),
	.pwdata          (pwdata   ),
	.psel            (psel     ),
//8051 extended register
    .fifo_rclk       (TxByteClkHS),
    .fifo_rd         (fifo_rd),
    .fifo_rdata      (fifo_rdata),
	.func            (func      ),	
    .mipi_sel        (mipi_sel )
);

mcu_v1 u_8051(
    .clkcpu	   (cpuclk),
	.resetn			(rstn),
    .memack			(memack),
    .memdatai		(memdatai),
    .mempsack		(mempsack),
	.memaddr_comb	(memaddr_comb),
    .memdatao_comb	(memdatao_comb),
    .mempsrd_comb	(mempsrd_comb),
    .mempswr_comb	(mempswr_comb),
    .memrd_comb		(memrd_comb),
    .memwr_comb		(memwr_comb),
	.clkcpuen    (),
    .clkperen		(),
	.ro                (),
	.hold			(1'b0),
	.holda			(),
    .intoccur		(),
	.waitstaten		(),
	.scli			(),
    .sdai			(),
	.sclo			(),
    .sdao			(),
	.port0i			(port0i),
    .port1i			(port1i),
    .port2i			(),
    .port3i			(),
	.port0o			(port0o),
    .port1o			(),
    .port2o			(),
    .port3o			(),
	.sfrack			(),
    .sfrdatai		(),
	.sfraddr		(),
    .sfrdatao		(),
    .sfroe			(),
    .sfrwe			(),
	.scki			(),
	.scko			(),
    .scktri			(),
    .misoi			(),
    .mosii			(),
	.misoo			(),
    .misotri		(),
    .mosio			(),
    .mositri		(),
	.ssn			(),
    .spssn			(),
	.swd			()
);


//apb interface
assign psel_mipi2=(paddr_mst[17]&psel)&mipi_sel;	
assign psel_mipi1=(paddr_mst[17]&psel)&(~mipi_sel);	
assign paddr={8'h0,paddr_mst[9:0]};
assign pready=pready_mipi2|pready_mipi1;
assign penable=psel_mipi2|psel_mipi1;
assign pclk= cpuclk;
assign prdata= pready_mipi2? prdata_mipi2: prdata_mipi1;
	 
	

mipi_v1 mipi_inst(
 	
	.mipi2_TxEscClk 				(esc_clk),
	.mipi2_RxEscClk 				(esc_clk),
	.mipi2_reset_n 					(rstn_mipi),
	.mipi2_reset_esc_n 				(rstn_mipi),

//tx packet interface
	.mipi2_host_tx_cmd_vc 				(host_tx_cmd_vc)	,
	.mipi2_host_tx_cmd_data_type 		(host_tx_cmd_data_type)	,
	.mipi2_host_tx_cmd_byte_count 		(host_tx_cmd_byte_count)	,
	.mipi2_host_tx_cmd_ack 				(host_tx_cmd_ack)	,
	.mipi2_host_tx_cmd_req 				(host_tx_cmd_req)	,
	.mipi2_host_tx_payload 				(host_tx_payload)	,
	.mipi2_host_tx_payload_en 			(host_tx_payload_en)	,
	.mipi2_host_tx_payload_en_last 		(host_tx_payload_en_last)	,
	.mipi2_host_tx_hs_mode 				(host_tx_hs_mode)	,
	.mipi2_host_tx_active 				(host_tx_active)	,
	.mipi2_host_tx_ulps_enable 			(5'd0)	,
	.mipi2_host_dphy_turnaround 		(1'b0)	,
	.mipi2_host_trigger_req 			(1'b0)	,
	.mipi2_host_trigger_send 			(2'b0)	,

	.mipi2_host_lp_rx_timeout 			(host_lp_rx_timeout)	,
//apb interface	
    .mipi2_pclk_reset_n                                    ( rstn     ),
    .mipi2_pclk                                            ( pclk             ),
    .mipi2_paddr                                           ( paddr            ),   //bits 1,0 not used
    .mipi2_pwrite                                          ( pwrite           ),   //assert during setup phase for writes
    .mipi2_psel                                            ( psel_mipi2             ),   //device select
    .mipi2_penable                                         ( penable          ),   //assert during access phase, this can be asserted for multiple clocks                                                                           
    .mipi2_pwdata                                          ( pwdata           ),   //write data
    .mipi2_prdata                                          ( prdata_mipi2           ),   //read data
    .mipi2_pready                                          ( pready_mipi2           ),    //always asserted for writes, asserted during access phase for reads

	.mipi2_clk 						(TxByteClkHS_s)	,

	.mipi2_PD_DPHY 					(PD_DPHY)	,
	.mipi2_tx_dphy_rdy				(tx_dphy_rdy),
	
//////////////////////////////////////////////////////////////////////////////////
	.mipi1_TxEscClk 				(esc_clk),
	.mipi1_RxEscClk 				(esc_clk_rx),
	.mipi1_reset_n 					(rstn_mipi),
	.mipi1_reset_esc_n 				(rstn_mipi),
	.mipi1_clk_periph 				(clk_periph),

//rx packet interface	
	.mipi1_periph_rx_cmd 					(periph_rx_cmd),
	.mipi1_periph_rx_cmd_valid 				(periph_rx_cmd_valid),
	.mipi1_periph_rx_payload 				(periph_rx_payload),
	.mipi1_periph_rx_payload_valid 			(periph_rx_payload_valid),
	.mipi1_periph_rx_payload_valid_last 	(periph_rx_payload_valid_last),
	.mipi1_RxActiveHS                       (RxActiveHS),
	
	.mipi1_periph_ecc_one_bit_err			(periph_ecc_one_bit_err),
	.mipi1_periph_ecc_two_bit_err			(periph_ecc_two_bit_err),
	.mipi1_periph_ecc_one_bit_err_pos		(periph_ecc_one_bit_err_pos),
	.mipi1_periph_ecc_err					(periph_ecc_err),
	.mipi1_periph_ecc_err_pos				(periph_ecc_err_pos),
	.mipi1_periph_crc_err					(periph_crc_err),
	
	.mipi1_periph_te_enable 		(1'b0),
	.mipi1_periph_te_event_in 		(1'b0),
	.mipi1_periph_te_fail 			(1'b0),
	.mipi1_periph_trigger_req 		(1'b0),
	.mipi1_periph_trigger_send 		(2'b0),

	.mipi1_periph_tx_payload			(periph_tx_payload),    
	.mipi1_periph_tx_cmd_vc				(periph_tx_cmd_vc),     
	.mipi1_periph_tx_cmd_data_type		(periph_tx_cmd_data_type),      
	.mipi1_periph_tx_cmd_byte_count		(periph_tx_cmd_byte_count),

	.mipi1_periph_tx_payload_en			(periph_tx_payload_en),
	.mipi1_periph_tx_payload_en_last	(periph_tx_payload_en_last),
	.mipi1_periph_tx_cmd_req			(periph_tx_cmd_req),
	.mipi1_periph_tx_cmd_ack			(periph_tx_cmd_ack),
	.mipi1_periph_dphy_direction		(periph_dphy_direction),
	
//apb interface	
    .mipi1_pclk_reset_n                                    ( rstn     ),
    .mipi1_pclk                                            ( pclk             ),
    .mipi1_paddr                                           ( paddr            ),   //bits 1,0 not used
    .mipi1_pwrite                                          ( pwrite           ),   //assert during setup phase for writes
    .mipi1_psel                                            ( psel_mipi1            ),   //device select
    .mipi1_penable                                         ( penable          ),   //assert during access phase, this can be asserted for multiple clocks                                                                           
    .mipi1_pwdata                                          ( pwdata           ),   //write data
    .mipi1_prdata                                          ( prdata_mipi1           ),   //read data
    .mipi1_pready                                          ( pready_mipi1           ),    //always asserted for writes, asserted during access phase for reads


	.mipi1_RxByteClkHS				(RxByteClkHS),
	.mipi1_PD_DPHY 					(PD_DPHY)	,

	.mipi1_tx_dphy_rdy				(tx_dphy_rdy_periph)	,
	//
    .CLKREF							(osc_o),
    .PD_PLL							(!rstn_mipi),
    .LOCK							(LOCK)
);


dataReadBack uut_dataReadBack(
	.clk_periph(clk_periph),
	.rstn(rstn),
//////	periph	
	.mipi_periph_rx_cmd(periph_rx_cmd),
	.mipi_periph_rx_cmd_valid(periph_rx_cmd_valid),
	.mipi_periph_tx_payload_en(periph_tx_payload_en),
	.mipi_periph_tx_payload_en_last(periph_tx_payload_en_last),
	.mipi_periph_tx_cmd_ack(periph_tx_cmd_ack),
	.mipi_periph_dphy_direction(periph_dphy_direction),
	

	.mipi_periph_tx_payload(periph_tx_payload),
	.mipi_periph_tx_cmd_vc(periph_tx_cmd_vc),
	.mipi_periph_tx_cmd_data_type(periph_tx_cmd_data_type),
	.mipi_periph_tx_cmd_byte_count(periph_tx_cmd_byte_count),
	.mipi_periph_tx_cmd_req(periph_tx_cmd_req)

);


endmodule


