`timescale 1ns / 1ps
//`define DPI_TEST
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
	input lcd_rstn,
	
	output panel_rst,
	output te,
	output [3:0] tt,
	output swire,
/******************psram************************/
	output psram_rst_n0,
	output psram_rst_n1,
	
	output ram_ck0,
	output ram_ckn0,
	output ram_csn0,
	inout  ram_rwds0,
	inout [7:0] ram_dq0,
	
	output ram_ck1,
	output ram_ckn1,
	output ram_csn1,
	inout  ram_rwds1,
	inout [7:0] ram_dq1
/***********************************************/
	

    );
wire 	osc_o;	
wire 	locked;
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

wire pstart;
wire packet_finish;

reg pstart_s;
reg pstart_t;
wire pstart_f;
reg sys_start;

wire[7:0] fifott;
wire[7:0] test;
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
//***************************************************//
//**************tx dpi interface*********************//
//***************************************************//
wire        dpi_pclk;
wire        host_dpi_vsync;
wire        host_dpi_hsync;
wire        host_dpi_de;
wire[23:0]  host_dpi_d;
wire        host_dpi_sd;
wire        host_dpi_cm;
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
wire[7:0] port3o;
wire[7:0] port2o;
wire[7:0] port1o;
wire[7:0] port0i;
wire[7:0] port1i;
wire[7:0] port3i;
wire[7:0] port2i;

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
wire packet_flag;

/***************************************************/
/*****************8051 extended register************/
/***************************************************/
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
wire te_o;

wire [31:0] dataReadBack_tx_payload;
wire [15:0] dataReadBack_periph_tx_cmd_byte_count;
wire [5:0] dataReadBack_periph_tx_cmd_data_type;
reg lcd_reset_s;

wire i2c_irq;
wire scli_m;
wire sclo_m;
wire sdai_m;
wire sdao_m;

wire scli;
wire sdai;
wire sclo;
wire sdao;

//**************************************************************//
wire[7:0]  psram_ctrl;
wire[20:0] mcu_psram_addr ;
wire[15:0] mcu_psram_wdata;
wire[15:0] mcu_psram_wdata0;
wire[15:0] mcu_psram_wdata1;
wire[15:0] mcu_psram_rdata0;
wire[15:0] mcu_psram_rdata1;
wire psram_clk;
wire psram_clk_clk0;
wire psram_clk_clk1;
wire psram_clk_rd0;
wire psram_clk_wr0;
wire psram_clk_rd1;
wire psram_clk_wr1;
wire psram_finish;
wire psram_finish0;
reg[3:0] clk_cnt;
reg cpu_cnt;
wire rx_dpi_dval;
wire[31:0] rx_dpi_data;
wire vblank;

wire psram_data_load0;
wire psram_data_load1;
wire psram_rd_val0;
wire psram_rd_val1;
wire ltcy_mode0;
wire ltcy_mode1;

wire ps_ck;
wire ps_dir;
wire ps_en;
wire ps_done;
wire [5:0] pssel;	

wire[7:0] spssn;
wire scko;
wire misoi;
wire mosio;
wire esc_clk_bta;
reg[1:0] clk_cnt0;
reg clk_cnt0_s;

wire bta_clk;
wire bta_rd;
wire fifo_rst;
wire[31:0] bta_data;
//**************************************************************//
//**************************************************************//
//**************************************************************//

//**************************************************************//
//**************************************************************//
//**************************************************************//
wire por;
por_v1_1 uut_por(
    .O(por)
);

assign rstn = por;    //locked;
assign PD_DPHY=~rstn_mipi;
//**************************************************************//
//**************************************************************//
//*********************************************************************//
wire [23:0] pixel_dat;
wire host_dpi_vsync_f;
reg host_dpi_vsync_t;
reg dat_val;
reg [7:0] vs_cnt;
always @(posedge dpi_pclk or negedge reset_dpi_n) begin
	if(!reset_dpi_n) begin
		host_dpi_vsync_t <= 1'b0;
	end else begin
		host_dpi_vsync_t <= host_dpi_vsync;
	end
end



assign host_dpi_vsync_f = host_dpi_vsync_t&(!host_dpi_vsync);


always @(posedge dpi_pclk or negedge reset_dpi_n) begin
	if(!reset_dpi_n) begin
		dat_val <= 1'b0;
	end else begin
		if(vs_cnt == 8'd10)
			dat_val <= 1'b1;
		else
			dat_val <= dat_val;
	end
end	



always @(posedge dpi_pclk or negedge reset_dpi_n) begin
	if(!reset_dpi_n) begin
		vs_cnt <= 0;
	end else begin
		if(!dat_val) begin
			if(host_dpi_vsync_f)
				vs_cnt <= vs_cnt + 8'd1;
			else
				vs_cnt <= vs_cnt;
		end else begin
			vs_cnt <= 0;
		end
	end
end	


assign host_dpi_d = (dat_val)?pixel_dat:23'd0;
//*********************************************************************//
//*********************************************************************//
//*********************************************************************//
//*********************************************************************//
//*********************************************************************//
//psram

psram_fb_top u_psram_fb_top(
.ck(ram_ck0),
.ck_n(ram_ckn0),
.cs_n(ram_csn0),
.rwds(ram_rwds0),
.dq(ram_dq0),

.ck1(ram_ck1),
.ck_n1(ram_ckn1),
.cs_n1(ram_csn1),
.rwds1(ram_rwds1),
.dq1(ram_dq1),

.rstn (rstn),
.dpi_pclk  (dpi_pclk),


.mipi_rx_clk(clk_periph),

.psram_clk (psram_clk),
.psram_clk_clk0 (psram_clk_clk0),
.psram_clk_clk1 (psram_clk_clk1),
.psram_clk_rd0 (psram_clk_rd0),
.psram_clk_rd1 (psram_clk_rd1),
.psram_clk_wr0 (psram_clk_wr0),
.psram_clk_wr1 (psram_clk_wr1),

.ram_powerup_on (1'b1),
.psram_ctrl  (psram_ctrl),
.psram_addr_mcu(mcu_psram_addr),
.reg_cfg_data (mcu_psram_wdata),
.reg_cfg_data0 (mcu_psram_wdata0),
.reg_cfg_data1 (mcu_psram_wdata1),

.mcu_psram_rdata0 (mcu_psram_rdata0),
.mcu_psram_rdata1 (mcu_psram_rdata1),
.psram_data_load0 (psram_data_load0),
.psram_data_load1 (psram_data_load1),
.psram_rd_val0 (psram_rd_val0),
.psram_rd_val1 (psram_rd_val1),

.psram_finish(psram_finish),
.ltcy_mode0(ltcy_mode0),
.ltcy_mode1(ltcy_mode1),
 .test(tt),


.mipi_dval(rx_dpi_dval),
.mipi_rx_data(rx_dpi_data),

.mipi_de_mask(mipi_de_mask),

. te(te),     
. host_dpi_de(host_dpi_de),     
. host_dpi_d (pixel_dat) ,     
. host_vsync(host_dpi_vsync),  
.reset_dpi_n (reset_dpi_n)                   
        	
);

//720*1280
defparam u_psram_fb_top.HTOTAL= 10'd720;
defparam u_psram_fb_top.VTOTAL= 11'd1560;



//*********************************************************************//
//*********************************************************************//
//*********************************************************************//
//mipi rx 
wire power_off;
 rx_packet_cmd_mode_dpi u_rx_cmd_dpi(
	 .rstn(rstn),
	 .clkrx(clk_periph),
	 .clk80(osc_o),
	 .RxByteClkHS(RxByteClkHS),   //DPHY CLK信号
	
	 .RxActiveHS(RxActiveHS),
	 .periph_rx_cmd(periph_rx_cmd),
	 .periph_rx_cmd_valid(periph_rx_cmd_valid),
	 .periph_rx_payload(periph_rx_payload),
	 .periph_rx_payload_valid(periph_rx_payload_valid),
	 .periph_rx_payload_valid_last(periph_rx_payload_valid_last),
	
	 .te_mask(mipi_de_mask),
	 .reset_dpi_n(reset_dpi_n),
     .te(te),
     .vblank(vblank),
	 .dpi_dval(rx_dpi_dval),
	 .power_off(power_off),
	 .test(), 
	 .dpi_data(rx_dpi_data)
	
	
 );

 
assign TxByteClkHS=TxByteClkHS_t;

//*********************************************************************//
//*********************************************************************//
//*********************************************************************//
glue uut_glue(
// tx dpi 
	.reset_dpi_n(reset_dpi_n),
	.dpi_pclk(dpi_pclk),
	
    .host_dpi_hsync(host_dpi_hsync),
    .host_dpi_vsync(host_dpi_vsync),
    .host_dpi_de(host_dpi_de),
//    .host_dpi_d(host_dpi_d),

//panel initial	
    .rstn(rstn),
	.cpuclk(cpuclk),
    .TxByteClkHS(TxByteClkHS),
    .pstart(pstart),
    .func(func),
    .lp_rx_timeout(1'b0),
	
    .packet_finish(packet_finish),
	.packet_asm_test(),
//fifo_rd		
    .fifo_rdata(fifo_rdata),
	
    .fifo_rd(fifo_rd),
//tx packet interface
	.host_tx_cmd_ack(host_tx_cmd_ack),
    .host_tx_active(host_tx_active),
	.host_tx_payload_en(host_tx_payload_en),
	.host_tx_payload_en_last(host_tx_payload_en_last),
	
	.host_tx_cmd_vc(host_tx_cmd_vc),
	.host_tx_cmd_data_type(host_tx_cmd_data_type),
	.host_tx_cmd_byte_count(host_tx_cmd_byte_count),
	.host_tx_cmd_req(host_tx_cmd_req),
	.host_tx_hs_mode(host_tx_hs_mode),
	.host_tx_payload(host_tx_payload)

);


OSCV1 u_osc(
    .OSC(osc_o)
);


pll_v1 u_pll(
    .clkin0(osc_o),
    .clkout0(clk_periph ),//160M
    .clkout1(psram_clk_clk0),//160M clk0
    // .clkout2(cpuclk),//32M 
    .clkout2(esc_clk),//16M 
	.clkout3(psram_clk), // 160M-sys
	.clkout4(dpi_pclk),//dpi_pclk
    .clkout5(psram_clk_rd0), //160M=io rd

	.ps_ck(ps_ck),
    .ps_dir(ps_dir),
    .ps_en(ps_en),
    .ps_done(ps_done),
    .pssel(pssel),
	
    .locked(locked)
);
assign psram_clk_wr0=psram_clk;
assign psram_clk_wr1=psram_clk;
assign psram_clk_rd1=psram_clk_rd0;
assign psram_clk_clk1=psram_clk_clk0;

//*******************************************************************//

always @ (posedge clk_periph or negedge rstn) begin
	if (!rstn) begin
		clk_cnt<=0;
	end
	else 
		clk_cnt<=clk_cnt+1'b1;
end 


assign cpuclk=osc_o; 
assign esc_clk_bta=esc_clk; 
assign esc_clk_rx=osc_o;






assign reset_dpi_n=(func[0]&&rstn)?port0o[0]:1'b0;
assign pstart = (func[0]&&rstn)?port0o[1]:1'b0;
assign rstn_mipi =(func[0]&&rstn)? port0o[2] :1'b0;
assign panel_rst=(func[0]&&rstn)? port0o[7]:1'b0;
assign psram_rst_n0=(func[0]&&rstn)? port0o[5]:1'b0;
assign psram_rst_n1=psram_rst_n0;

assign port0i[3]=packet_finish;
assign port0i[4]=tx_dphy_rdy&LOCK&tx_dphy_rdy_periph ;
assign port0i[6]=lcd_rstn ;
  


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
	.pwrite          (pwrite),
    .pwdata          (pwdata   ),
	.psel            (psel     ),


//psram ctrl
	.psram_addr  (mcu_psram_addr   ),
	.psram_finish(psram_finish),
	.psram_ctrl(psram_ctrl),
//	psram_ctrl[7]  rdfifo_rd
	.psram_wdata(mcu_psram_wdata),
	.psram_wdata0(mcu_psram_wdata0),
	.psram_wdata1(mcu_psram_wdata1),
	.psram_rdata0(mcu_psram_rdata0),	
	.psram_rdata1(mcu_psram_rdata1),	
	.psram_rd_val0(psram_rd_val0),	
	.psram_rd_val1(psram_rd_val1),	
	.psram_data_load0(psram_data_load0),	
	.psram_data_load1(psram_data_load1),	
	.ltcy_mode0(ltcy_mode0),
	.ltcy_mode1(ltcy_mode1),
	.psram_clk(psram_clk),
	
	.ps_ck(ps_ck),
    .ps_dir(ps_dir),
    .ps_en(ps_en),
    .pssel(pssel),

	.bta_clk(bta_clk),
    .bta_rd(bta_rd),
    .bta_data(bta_data),
	
    .fifo_rclk       (TxByteClkHS),
    .fifo_rst       (fifo_rst),
    .fifo_rd         (fifo_rd),
    .fifo_rdata      (fifo_rdata),
	.func            (func      ),	
	// .test            (  tt   ),	
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
	.scli			(scli),
    .sdai			(sdai),
	.sclo			(sclo),
    .sdao			(sdao),
	.port0i			(port0i),
    .port1i			(port1i),
    .port2i			(port2i),
    .port3i			(port3i),
	.port0o			(port0o),
    .port1o			(port1o),
    .port2o			(port2o),
    .port3o			(port3o),
	.sfrack			(),
    .sfrdatai		(),
	.sfraddr		(),
    .sfrdatao		(),
    .sfroe			(),
    .sfrwe			(),
	.scki			(),
	.scko			(scko),
    .scktri			(),
    .misoi			(misoi),
    .mosii			(),
	.misoo			(),
    .misotri		(),
    .mosio			(mosio),
    .mositri		(),
	.ssn			(),
    .spssn			(spssn),
	.swd			()
);


spiInterface_v1 u_spiflash(
    .sclk(scko),
    .sdo(misoi),
    .cson(spssn[0]),
    .sdi(mosio)
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
	.mipi1_reset_n 					(rstn_mipi),
	.mipi1_reset_esc_n 				(rstn_mipi),

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

//tx dpi interface
	.mipi1_dpi_pclk                       ( dpi_pclk                    ), // I
    .mipi1_reset_dpi_n                    ( reset_dpi_n                 ), // I
    .mipi1_host_dpi_vsync                 ( host_dpi_vsync                   ), // I
    .mipi1_host_dpi_hsync                 ( host_dpi_hsync                   ), // I
    .mipi1_host_dpi_de                    ( host_dpi_de                      ), // I
    .mipi1_host_dpi_d                     ( host_dpi_d                       ), // I[23:0]
    .mipi1_host_dpi_sd                    ( 1'b0                      ), // I
    .mipi1_host_dpi_cm                    ( 1'b0                         ), // I
    .mipi1_dpi_host_underrun_err          ( dpi_host_underrun_err       ), //	
	.mipi1_PD_DPHY 					(PD_DPHY)	,
	.mipi1_tx_dphy_rdy				(tx_dphy_rdy),	
	
	//.mipi_clk 						(TxByteClkHS_s)	,
    .mipi1_clk 						(TxByteClkHS_t)	,
	
	//************************rx***************************************//
	.mipi2_TxEscClk 				(esc_clk_bta),
	.mipi2_RxEscClk 				(esc_clk_rx),
	.mipi2_reset_n 					(rstn_mipi),
	.mipi2_reset_esc_n 				(rstn_mipi),
	.mipi2_clk_periph 				(clk_periph),
//rx pack2t interface	
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
	.mipi2_periph_trigger_req 		(1'b0),
	.mipi2_periph_trigger_send 		(2'b0),
//return 2d
            
	.mipi2_periph_tx_payload			(periph_tx_payload),    
	.mipi2_periph_tx_cmd_vc				(periph_tx_cmd_vc),     
	.mipi2_periph_tx_cmd_data_type		(periph_tx_cmd_data_type),      
	.mipi2_periph_tx_cmd_byte_count		(periph_tx_cmd_byte_count),
	.mipi2_periph_tx_payload_en			(periph_tx_payload_en),
	.mipi2_periph_tx_payload_en_last	(periph_tx_payload_en_last),
	.mipi2_periph_tx_cmd_req			(periph_tx_cmd_req),
	.mipi2_periph_tx_cmd_ack			(periph_tx_cmd_ack),
	.mipi2_periph_dphy_direction		(periph_dphy_direction),
//apb int2rface	
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

	//************************pll***************************************//	
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

assign swire = 1;

//wire phone_pwm;
//wire [7:0] pulse_num_tgt;
//parameter PULSE_CNT_LIMIT = 16'd1500  ; // 160*62.5ns = 10us --- each pulse high/low width
//parameter PULSE_NUM_GAP   = 16'd2199 ; // 1500*10us  = 15 ms--- GAP between two pulse-Group
//       // use esc_clk as clock, which is 16MHz, 62.5ns per cycles
//pwm_gen   # (
//       .PULSE_CNT_LIMIT ( PULSE_CNT_LIMIT ) , // 160*62.5ns = 10us 
//       .PULSE_NUM_GAP   ( PULSE_NUM_GAP   )   // 1500*10us  = 15 ms
//       ) pwm_gen  (
//       [>output reg   <].backlight_pwm ( phone_pwm ),       
//       [>input [7:0]  <].pulse_num_tgt ( pulse_num_tgt      ),
//       [>input        <].sysclk        ( clk_periph           ),  
//       [>input        <].rst_n         ( rstn       )
//     ); 

//assign pulse_num_tgt = (power_off)?8'd30:((lcd_rstn)?8'd10:8'd30);
//assign swire = phone_pwm;

//wire swire_crl;
//BL_ctrl ubl
//( 
//	.reset_n          ( rstn       ),   //Resets the Design
//	.clk              ( esc_clk       ),   //
//	.clk_periph    ( clk_periph      ),
//	.rx_cmd     ( periph_rx_cmd     ),
//	.rx_cmd_valid    ( periph_rx_cmd_valid    ),
//	.rx_payload    ( periph_rx_payload    ),
//	.rx_payload_valid   ( periph_rx_payload_valid   ),
//	.rx_payload_valid_last  ( periph_rx_payload_valid_last ),
//	.RxActiveHS    ( RxActiveHS      ),
//	.test     (         ),
//	.swire                  ( swire_crl     )
//);

endmodule


