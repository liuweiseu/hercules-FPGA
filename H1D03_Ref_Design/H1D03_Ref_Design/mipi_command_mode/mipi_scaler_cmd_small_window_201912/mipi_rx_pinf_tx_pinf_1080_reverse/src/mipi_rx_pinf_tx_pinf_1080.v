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
	input lcd_reset,
	//output te,
	output swire,
	output t0,
	output[3:0] tt,
//	output[7:0] test,
	output panel_rst,
	input            i_spi_cs,
	input            i_spi_clk,
	inout            i_spi_mosi,
	output           o_spi_miso

    );
wire 	osc_o;	
wire 	locked;
reg 	rstn_r = 0;
wire 	rstn;	
wire 	esc_clk;
wire 	esc_clk_rx;
wire	cpuclk;
wire	rstn_mipi;
wire 	reset_dpi_n;

wire 	 tx_dphy_rdy;
wire     tx_dphy_rdy_periph;
wire 	 PD_DPHY;
wire 	 LOCK;
wire te;

wire pstart;
wire packet_finish;

reg pstart_s;
reg pstart_t;
wire pstart_f;
reg sys_start;

wire rstn_dly;
wire rstn_mipi_dly;
wire reset_dpi_n_dly;
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


wire host_tx_payload_en;
wire host_tx_payload_en_last;
wire host_tx_cmd_req;
wire host_tx_cmd_ack;
wire host_tx_hs_mode;
wire host_tx_active;
wire host_lp_rx_timeout;
wire[31:0] host_tx_payload;
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
wire clk38m;
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
wire packet_flag;

/***************************************************/
/*****************8051 extended register************/
/***************************************************/
//wire[15:0] dnum;
//wire[7:0] dset;
//wire[7:0] cmd;
wire[7:0] func;
wire mipi_sel;
wire fifo_rd;
wire [31:0] fifo_rdata;


//return id
wire periph_tx_payload_en;
wire periph_tx_payload_en_last;
wire periph_tx_cmd_ack;
wire periph_dphy_direction;
wire [31:0] periph_tx_payload;
wire periph_tx_cmd_vc;
wire [5:0] periph_tx_cmd_data_type;
wire [15:0] periph_tx_cmd_byte_count;
wire periph_tx_cmd_req;

wire TxByteClkHS_t;

wire [31:0] dataReadBack_tx_payload;
wire [15:0] dataReadBack_periph_tx_cmd_byte_count;
wire [5:0] dataReadBack_periph_tx_cmd_data_type;
wire[7:0] test;
reg lcd_reset_s;

assign PD_DPHY=~rstn_mipi;

//reg rstn_r;
always @ (posedge osc_o) begin
    //rstn_r <= locked;
    rstn_r <= locked && lcd_reset;
end


assign rstn = rstn_r;    //locked;


assign t0=te;//tx_dphy_rdy;




assign rstn_dly=rstn;
assign rstn_mipi_dly=rstn_mipi;
assign reset_dpi_n_dly=reset_dpi_n;



por_v1_1 uut_por_v1_1(
    .O(por)
);


assign TxByteClkHS=TxByteClkHS_t;
//GBUF u_gbuf (
//        .in (TxByteClkHS_t),
//        .out (TxByteClkHS)
//);



/***************windown set***************************/	
wire busy;

wire  wd_rdy;
wire [7:0] wd_2a_dats_l;
wire [7:0] wd_2a_dats_h;
wire [7:0] wd_2a_date_l;
wire [7:0] wd_2a_date_h;
wire [7:0] wd_2b_dats_l;
wire [7:0] wd_2b_dats_h;
wire [7:0] wd_2b_date_l;
wire [7:0] wd_2b_date_h;

glue glue(
//rx packet interface    
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
    		
    .reset_dpi_n_dly(reset_dpi_n_dly),


//panel initial	
	
    .func             (func      ),	
    .cpuclk           (cpuclk),
    .fifo_rd          (fifo_rd),
    .fifo_rdata       (fifo_rdata),
		
  	.TxByteClkHS(TxByteClkHS),
    .rstn_dly(rstn),
    .pstart(pstart),
    .lp_rx_timeout(1'b0),
    .packet_finish(packet_finish),
	.packet_asm_test(fifott),
    .te(te),
	
//tx packet interface	
	.host_tx_cmd_vc 				(host_tx_cmd_vc)	,
	.host_tx_cmd_data_type 		    (host_tx_cmd_data_type)	,
	.host_tx_cmd_byte_count 		(host_tx_cmd_byte_count)	,
	.host_tx_cmd_ack 			    (host_tx_cmd_ack)	,
	.host_tx_cmd_req 			    (host_tx_cmd_req)	,
	.host_tx_payload 				(host_tx_payload)	,
	.host_tx_hs_mode 				(host_tx_hs_mode)	,
	.host_tx_payload_en 			(host_tx_payload_en)	,
	.host_tx_payload_en_last 		(host_tx_payload_en_last)	,
	.host_tx_active 				(host_tx_active),
    .test(test),
	
/**********************windown set*********************/
	.busy(busy),

	.wd_rdy(wd_rdy),
	.wd_2a_dats_l(wd_2a_dats_l),
	.wd_2a_dats_h(wd_2a_dats_h),
	.wd_2a_date_l(wd_2a_date_l),
	.wd_2a_date_h(wd_2a_date_h),
	.wd_2b_dats_l(wd_2b_dats_l),
	.wd_2b_dats_h(wd_2b_dats_h),
	.wd_2b_date_l(wd_2b_date_l),
	.wd_2b_date_h(wd_2b_date_h)
	  
);

assign tt = test[3:0];



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
	.clkout2(esc_clk_rx),//40M
	.clkout3(cpuclk),
	.clkout4(clk38m),	
    .locked(locked)
);


OSCV1 u_osc(
    .OSC(osc_o)
);

assign reset_dpi_n=(func[0]&&rstn)?port0o[0]:1'b0;
assign pstart = (func[0]&&rstn)?port0o[1]:1'b0;
assign rstn_mipi =(func[0]&&rstn)? port0o[2] :1'b0;
assign panel_rst=(func[0]&&rstn)? port0o[7]:1'b0;
//assign panel_rst=1'b1;


assign port0i[3]=packet_finish;
assign port0i[4]=tx_dphy_rdy&tx_dphy_rdy_periph&LOCK;
assign port0i[5]=lcd_reset;




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
	//.pwrite          (mcu_arbiter_pwrite   ),
	//.pwdata          (mcu_arbiter_pwdata   ),
	.pwrite          (pwrite),
    .pwdata          (pwdata   ),
	.psel            (psel     ),
//8051 extended register
	//.dnum            (dnum     ),
    //.dset            (dset     ),
    //.cmd             (cmd      ),
    .fifo_rclk       (TxByteClkHS),
    .fifo_rd         (fifo_rd),
    .fifo_rdata      (fifo_rdata),
	.func            (func      ),	
    .mipi_sel        (mipi_sel ),
/*****************windown set*****************************/
	.wd_rdy(wd_rdy),
	.wd_2a_dats_l(wd_2a_dats_l),
	.wd_2a_dats_h(wd_2a_dats_h),
	.wd_2a_date_l(wd_2a_date_l),
	.wd_2a_date_h(wd_2a_date_h),
	.wd_2b_dats_l(wd_2b_dats_l),
	.wd_2b_dats_h(wd_2b_dats_h),
	.wd_2b_date_l(wd_2b_date_l),
	.wd_2b_date_h(wd_2b_date_h),
	
	.busy(busy)
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
 	
	.mipi1_TxEscClk 				(esc_clk),
	.mipi1_RxEscClk 				(esc_clk_rx),
	.mipi1_reset_n 					(rstn_mipi_dly),
	.mipi1_reset_esc_n 				(rstn_mipi_dly),

//tx packet interface
	.mipi1_host_tx_cmd_vc 				(host_tx_cmd_vc)	,
	.mipi1_host_tx_cmd_data_type 		(host_tx_cmd_data_type)	,
	.mipi1_host_tx_cmd_byte_count 		(host_tx_cmd_byte_count)	,
	.mipi1_host_tx_cmd_ack 				(host_tx_cmd_ack)	,
	.mipi1_host_tx_cmd_req 				(host_tx_cmd_req)	,
	.mipi1_host_tx_payload 				(host_tx_payload)	,
	.mipi1_host_tx_payload_en 			(host_tx_payload_en)	,
	.mipi1_host_tx_payload_en_last 		(host_tx_payload_en_last)	,
	.mipi1_host_tx_hs_mode 				(host_tx_hs_mode)	,
	.mipi1_host_tx_active 				(host_tx_active)	,
	.mipi1_host_tx_ulps_enable 			(5'd0)	,
	.mipi1_host_dphy_turnaround 		(1'b0)	,
	.mipi1_host_trigger_req 			(1'b0)	,
	.mipi1_host_trigger_send 			(2'b0)	,

	.mipi1_host_lp_rx_timeout 			(host_lp_rx_timeout)	,
//apb interface	
    .mipi1_pclk_reset_n                                    ( rstn     ),
    .mipi1_pclk                                            ( pclk             ),
    .mipi1_paddr                                           ( paddr            ),   //bits 1,0 not used
    .mipi1_pwrite                                          ( pwrite           ),   //assert during setup phase for writes
    .mipi1_psel                                            ( psel_mipi1             ),   //device select
    .mipi1_penable                                         ( penable          ),   //assert during access phase, this can be asserted for multiple clocks                                                                           
    .mipi1_pwdata                                          ( pwdata           ),   //write data
    .mipi1_prdata                                          ( prdata_mipi1           ),   //read data
    .mipi1_pready                                          ( pready_mipi1           ),    //always asserted for writes, asserted during access phase for reads

	//.mipi2_clk 						(TxByteClkHS_s)	,
    .mipi1_clk 						(TxByteClkHS_t)	,

	.mipi1_PD_DPHY 					(PD_DPHY)	,
	.mipi1_tx_dphy_rdy				(tx_dphy_rdy),
	
//////////////////////////////////////////////////////////////////////////////////
	.mipi2_TxEscClk 				(esc_clk),
	.mipi2_RxEscClk 				(esc_clk_rx),
	.mipi2_reset_n 					(rstn_mipi_dly),
	.mipi2_reset_esc_n 				(rstn_mipi_dly),
	.mipi2_clk_periph 				(clk_periph),

//rx packet interface	
	.mipi2_periph_rx_cmd 					(periph_rx_cmd),
	.mipi2_periph_rx_cmd_valid 				(periph_rx_cmd_valid),
	.mipi2_periph_rx_payload 				(periph_rx_payload),
	.mipi2_periph_rx_payload_valid 			(periph_rx_payload_valid),
	.mipi2_periph_rx_payload_valid_last 	(periph_rx_payload_valid_last),
	.mipi2_RxActiveHS                       (RxActiveHS),
	
	.mipi2_periph_ecc_one_bit_err			(periph_ecc_one_bit_err),
	.mipi2_periph_ecc_two_bit_err			(periph_ecc_two_bit_err),
	.mipi2_periph_ecc_one_bit_err_pos		(periph_ecc_one_bit_err_pos),
	.mipi2_periph_ecc_err					(periph_ecc_err),
	.mipi2_periph_ecc_err_pos				(periph_ecc_err_pos),
	.mipi2_periph_crc_err					(periph_crc_err),
	
	.mipi2_periph_te_enable 		(1'b0),
	.mipi2_periph_te_event_in 		(1'b0),
	.mipi2_periph_te_fail 			(1'b0),
//	.mipi2_periph_tx_cmd_req 		(1'b0),
	.mipi2_periph_trigger_req 		(1'b0),
	.mipi2_periph_trigger_send 		(2'b0),
	
	
//return id
//	.mipi2_periph_rx_cmd 			    (periph_rx_cmd),		  
//	.mipi2_periph_rx_cmd_valid 			(periph_rx_cmd_valid),               

	.mipi2_periph_tx_payload			(periph_tx_payload),    
	.mipi2_periph_tx_cmd_vc				(periph_tx_cmd_vc),     
	.mipi2_periph_tx_cmd_data_type		(periph_tx_cmd_data_type),      
	.mipi2_periph_tx_cmd_byte_count		(periph_tx_cmd_byte_count),

	.mipi2_periph_tx_payload_en			(periph_tx_payload_en),
	.mipi2_periph_tx_payload_en_last	(periph_tx_payload_en_last),
	.mipi2_periph_tx_cmd_req			(periph_tx_cmd_req),
	.mipi2_periph_tx_cmd_ack			(periph_tx_cmd_ack),
	.mipi2_periph_dphy_direction		(periph_dphy_direction),
	
//apb interface	
    .mipi2_pclk_reset_n                                    ( rstn     ),
    .mipi2_pclk                                            ( pclk             ),
    .mipi2_paddr                                           ( paddr            ),   //bits 1,0 not used
    .mipi2_pwrite                                          ( pwrite           ),   //assert during setup phase for writes
    .mipi2_psel                                            ( psel_mipi2            ),   //device select
    .mipi2_penable                                         ( penable          ),   //assert during access phase, this can be asserted for multiple clocks                                                                           
    .mipi2_pwdata                                          ( pwdata           ),   //write data
    .mipi2_prdata                                          ( prdata_mipi2           ),   //read data
    .mipi2_pready                                          ( pready_mipi2           ),    //always asserted for writes, asserted during access phase for reads


	.mipi2_RxByteClkHS				(RxByteClkHS),
	.mipi2_PD_DPHY 					(PD_DPHY)	,

	.mipi2_tx_dphy_rdy				(tx_dphy_rdy_periph)	,
	//
    .CLKREF							(osc_o),
    .PD_PLL							(!rstn_mipi),
    .LOCK							(LOCK)
);




delaybuf_x32 uut_dataReadBack_delaybuf_x32(
	.I(dataReadBack_tx_payload),
	.O(periph_tx_payload)
);

delaybuf_x16 uut_dataReadBack_delaybuf_x16(
	.I(dataReadBack_periph_tx_cmd_byte_count),
	.O(periph_tx_cmd_byte_count)
);


delaybuf_x6 uut_dataReadBack_delaybuf_x6(
	.I(dataReadBack_periph_tx_cmd_data_type),
	.O(periph_tx_cmd_data_type)
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
	

	.mipi_periph_tx_payload(dataReadBack_tx_payload),
	.mipi_periph_tx_cmd_vc(periph_tx_cmd_vc),
	.mipi_periph_tx_cmd_data_type(dataReadBack_periph_tx_cmd_data_type),
	.mipi_periph_tx_cmd_byte_count(dataReadBack_periph_tx_cmd_byte_count),
	.mipi_periph_tx_cmd_req(periph_tx_cmd_req),
	
	.test()

);


//assign swire=1'b1;


Swire uut_Swire(
	.rst_n(rstn),
	.clkrx(clk_periph),
	.clk38m(clk38m),
	.rx_cmd(periph_rx_cmd),
	.rx_cmd_valid(periph_rx_cmd_valid),
	.rx_payload(periph_rx_payload),
	.rx_payload_valid(periph_rx_payload_valid),
	.rx_payload_valid_last(periph_rx_payload_valid_last),
	
	.swire(swire)
);



//
//Swire(
//	.rst_n(),
//	.clkrx(),
//	.clk38M(),
///*****************RX***************************/	
//	.rx_cmd(),
//	.rx_cmd_valid(),
//	.rx_payload(),
//	.rx_payload_valid(),
//	.rx_payload_valid_last(),
//	
//	.swire()
//);

//	spi_flash uut_spi_flash(
//	
//	.rst_n( s_reset_i_n ),
//	.clk  ( s_clk_100m  ),     //输入时钟频率CLK为SCLK的两倍以上，建议为80MHZ~100MHZ
//
//	.cson ( i_spi_cs    ),
//	.sclk ( i_spi_clk   ),
//	.sdi  ( i_spi_mosi  ), 
//	.sdo  ( o_spi_miso  )
//);


endmodule


