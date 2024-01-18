
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
//`define RX_TEST

`define SC_TEST

module rx_packet_cmd_mode_dpi(
	input rstn,
	input clkrx,
	input clk80,
	input RxByteClkHS,   //DPHY CLK信号
/*****************RX***************************/	
	input RxActiveHS,
	//input [23:0] rx_cmd,
	//input rx_cmd_valid,
	//input [31:0] rx_payload,
	//input rx_payload_valid,
	//input rx_payload_valid_last,

	input [23:0] periph_rx_cmd,
	input periph_rx_cmd_valid,
	input [31:0] periph_rx_payload,
	input periph_rx_payload_valid,
	input periph_rx_payload_valid_last,

	input te_mask,
	input clkin,
	input reset_dpi_n,
    output te,
	output dpi_dval,
	output vblank,
	output[31:0] dpi_data,
	output reg power_off,
	output [3:0] test
	
);


parameter RX_X_RESOLUTION = 16'd1080;
parameter RX_Y_RESOLUTION = 16'd2340;
//parameter TX_X_RESOLUTION = 16'd1080;
//parameter TX_Y_RESOLUTION = 16'd2280;



wire val_det;
reg  fifo_clr;
reg[11:0] clr_cnt;
reg clr_cnt_en;
wire clr_cnt_end0,clr_cnt_end1;
reg cmd_flag;
wire rx_fifo_wen;
wire v_start_flag;
reg cmd_start;
reg rx_wen;
reg v_start_en;
reg[11:0] rx_line_cnt;
wire frame_end;
wire scaler_rstn;
wire hval;
wire[31:0] h_data;
wire te_rstn;
reg te_en;

reg[31:0] rx_payload_s;
wire[31:0] rx_payload_t;
wire rx_payload_valid_t;
reg rx_payload_valid_s;
wire frame_head_det;
wire line_head_det;

wire cmd39_det;
reg cmd39_flag;
wire ram2a;
wire ram2b;

wire[7:0] data_test;
reg full_frame_mask;
wire full_frame_det;


reg [23:0] rx_cmd;
reg rx_cmd_valid;
reg [31:0] rx_payload;
reg rx_payload_valid;
reg rx_payload_valid_last;

always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) begin
        rx_cmd <= 0;
        rx_cmd_valid <=0;
        rx_payload <= 0;
        rx_payload_valid <= 0;
        rx_payload_valid_last <= 0;
    end else begin
        rx_cmd <= periph_rx_cmd;
        rx_cmd_valid <= periph_rx_cmd_valid;
        rx_payload <= periph_rx_payload;
        rx_payload_valid <= periph_rx_payload_valid;
        rx_payload_valid_last <= periph_rx_payload_valid_last;
    end
end


/**********************************************************************************/
/**********************************************************************************/
/**********************************************************************************/


`ifdef RX_TEST

reg reset_dpi_n1;
reg[10:0] sync_cnt;
reg test_dpi_vsync_s;
wire test_dpi_vsync;
wire test_dpi_hsync;
wire test_dpi_vsync_r;
wire fifo_wen;
wire mipi_de_mask;
reg[1:0] de_cnt_tx;
wire[23:0] rx_px_data;
reg[23:0] rx_px_data_s;
reg[23:0] rx_px_data_t;
reg[31:0] fifo_wdata;

always @ (posedge mipirx_clk) begin
	// reset_dpi_n1<=(~mipi_de_mask)&&reset_dpi_n&&(sync_cnt==2'd1);
	reset_dpi_n1<=(~te_mask)&&reset_dpi_n;
end


always @ (posedge mipirx_clk) begin
	test_dpi_vsync_s<=test_dpi_vsync;
end

assign test_dpi_vsync_r=test_dpi_vsync&(!test_dpi_vsync_s);


always @ (posedge mipirx_clk or negedge rstn) begin
	if (!rstn) begin
		sync_cnt<=11'b0;
	end
	else if(test_dpi_vsync_r)
		sync_cnt<=sync_cnt+1'b1;
end 


pattern_gen_test #(          //1080p
	.H_TOTAL(16'd1130),
	.H_VAL(16'd1080),
	.HFP(16'd20),
	.HSP(16'd10),
	.HBP (16'd20),
	.V_TOTAL(16'd2350),
	.V_VAL (16'd2340),
	.VFP(16'd6),
	.VSP(16'd1),
	.VBP (16'd3))	

pgen_rx(
    .px_clk(mipirx_clk),  
    .hsync(test_dpi_hsync),
    .vsync(test_dpi_vsync),
    .dval(test_dpi_de),
    .px_data(rx_px_data),
	.psel(sync_cnt[9:8]),
    .rstn(reset_dpi_n1)
    );
	

always @ (posedge mipirx_clk or negedge rstn) begin
	if (!rstn) begin
		de_cnt_tx<=2'b0;
	end
	else if(test_dpi_de)
		de_cnt_tx<=de_cnt_tx+1'b1;
	else
		de_cnt_tx<=2'b0;
end 

assign fifo_wen= (de_cnt_tx==2'b0)?1'b0:test_dpi_de;


always @ (posedge mipirx_clk or negedge rstn) begin
	if (!rstn) begin
		rx_px_data_s<=24'b0;
		rx_px_data_t<=24'b0;
	end
	else begin
		rx_px_data_s<=rx_px_data;
		rx_px_data_t<=rx_px_data_s;
	end
end 


always @ (*) begin
	case(de_cnt_tx)
	2'd1: fifo_wdata={rx_px_data_s,rx_px_data[23:16]};
	2'd2: fifo_wdata={rx_px_data_s[15:0],rx_px_data[23:8]};
	2'd3: fifo_wdata={rx_px_data_s[7:0],rx_px_data};
	default: fifo_wdata={rx_px_data_s,rx_px_data[23:16]};
	endcase
end 

assign mipirx_clk=clkrx;	
	
assign rx_payload_t=fifo_wdata;
assign rx_payload_valid_t=fifo_wen;
assign val_det=test_dpi_hsync;
assign scaler_rstn=rstn&(!test_dpi_vsync);


/*********************************************************************************/
/*********************************************************************************/
/**********************************************************************************/
//frame ctrl
`else


always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) begin
		cmd_flag<=1'b0;
	end
	else if(val_det)
		cmd_flag<=1'b1;
	else if(rx_payload_valid)
		cmd_flag<=1'b0;
end

always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) 
		rx_line_cnt<=12'b0;
	else if(frame_end)
		rx_line_cnt<=12'b0;
	else if(frame_head_det)
		rx_line_cnt<=12'd1;
	else if(val_det)
		rx_line_cnt<=rx_line_cnt+1'b1;
end

assign frame_end= (rx_line_cnt==RX_Y_RESOLUTION)&&rx_payload_valid_last;
assign frame_head_det= (rx_payload_valid&&(rx_payload[7:0]==8'h2c))&cmd_flag;
assign line_head_det= (rx_payload_valid&&(rx_payload[7:0]==8'h3c))&cmd_flag;

/************************************************************/
/************************************************************/
/*********************te gen*********************************/

always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) begin
		te_en <= 1'b0;
	end else begin
		if(v_start_en==1'b1 && (rx_payload_valid == 1'b1 && rx_payload[15:0] == 16'h2053))
			te_en <= 1'b1;
	end
end


//assign te_rstn=te_en&(!te_mask);
//assign te_rstn=rstn&(!te_mask);
assign te_rstn=reset_dpi_n&(!te_mask);

te_gen uut_te_gen(
    .rstn(te_rstn),
	.clk(clk80),
	.te(te)
);	
/**********************************************************************************/
/*********************************************************************************/
//************************************************************************//
// fifo clear -5ms after last data

always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) begin
		clr_cnt_en<=1'b0;
	end
	else if(frame_end)
		clr_cnt_en<=1'b1;
	else if(clr_cnt_end1)
		clr_cnt_en<=1'b0;
end 

always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) begin
		clr_cnt<=12'b0;
	end
	else if(clr_cnt_en)
		clr_cnt<=clr_cnt+1'b1;
	else
		clr_cnt<=20'b0;
end 

always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) begin
		fifo_clr<=1'b0;
	end
	else if(clr_cnt_end1)
		fifo_clr<=1'b0;
	else if(clr_cnt_end0)
		fifo_clr<=1'b1;
end 

assign clr_cnt_end0= (clr_cnt==20'd3000);
assign clr_cnt_end1= (clr_cnt==20'd3033);

assign vblank=fifo_clr;

//************************************************************************//
/*************************************************************************/
/*************************************************************************/

always @(posedge clkrx or negedge rstn) begin
	if (!rstn) begin
		rx_wen <= 1'b0;
	end else begin
		if(val_det)
			rx_wen <= 1'b1;
		else if(rx_payload_valid_last)
			rx_wen <= 1'b0;	
	end
end

assign rx_fifo_wen = rx_wen&rx_payload_valid;
assign scaler_rstn=rstn&(!fifo_clr);
//assign scaler_rstn=rstn;


// always @(posedge clkrx or negedge rstn) begin
	// if (!rstn) begin
		// rx_payload_s <= 32'b0;
	// end 
	// else if(rx_fifo_wen)
		// rx_payload_s<=rx_payload;		
// end


// assign rx_payload_t={rx_payload_s[15:8],rx_payload_s[23:16],rx_payload_s[31:24],rx_payload[7:0]};
// assign rx_payload_valid_t=rx_fifo_wen&(!cmd_flag);
//assign val_det=full_frame_mask&(rx_cmd_valid&&(rx_cmd[5:0] == 6'h39)&&(rx_cmd[23:8] == RX_X_RESOLUTION*3+1));
assign val_det=(rx_cmd_valid&&(rx_cmd[5:0] == 6'h39)&&(rx_cmd[23:8] == RX_X_RESOLUTION*3+1));


//*********************************************************************************//

always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) begin
		cmd39_flag<=1'b0;
	end
	else if(cmd39_det)
		cmd39_flag<=1'b1;
	else if(rx_payload_valid)
		cmd39_flag<=1'b0;
end


always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) begin
		full_frame_mask<=1'b1;
	end
	else if(ram2b)
		begin
			if(data_test[0])
				full_frame_mask<=1'b1;
			else
				full_frame_mask<=1'b0;
		end
end

assign cmd39_det=(rx_cmd_valid&&(rx_cmd[5:0] == 6'h39));
assign ram2a= (rx_payload_valid&&(rx_payload[7:0]==8'h2a))&cmd39_flag;
assign ram2b= (rx_payload_valid&&(rx_payload[7:0]==8'h2b))&cmd39_flag;

assign full_frame_det=(rx_payload_valid&&(rx_payload==32'h0900002b))&cmd39_flag;

assign data_test[0]=(rx_payload==32'h0900002b);
assign data_test[1]=(rx_payload[7:0]==8'h23);
assign data_test[2]=(rx_payload==32'h0400002a);
assign data_test[3]=(rx_payload[7:0]==8'h37);
// assign data_test[4]=;
// assign data_test[5]=;
// assign data_test[6]=;

//*********************************************************************************//
 // reg[31:0] rx_payload_f;
 // reg rx_payload_valid_f;
 // reg val_det_f;

 // always @(posedge clkrx) begin
	 // rx_payload_f<=rx_payload_t;
 // end

 // always @(posedge clkrx) begin
	 // rx_payload_valid_f<=rx_payload_valid_t;
 // end

 // always @(posedge clkrx) begin
	 // val_det_f<=val_det;
 // end
 // reg ivs,ihs;
 // always @(posedge clkrx) begin
	 // ivs<=frame_head_det;
	 // ihs<=frame_head_det | line_head_det;
 // end
/************************************************************/
/************************************************************/
/************************************************************/

// assign test[0]=line_head_det;

// assign test[7]=((rx_payload_valid&&(rx_payload[7:0]==8'h3c))&cmd_flag);

////////assign test[6]=((rx_payload_valid&&(rx_payload[7:0]==8'h2c))&cmd_flag);

/************************************************************/
/************************************************************/
/************************************************************/

`endif

`ifdef SC_TEST

//sc_1080_720 u1
//(
//.clk        ( clkrx   ),//input   clk;
//.reset      ( ~scaler_rstn   ),//input   reset;
//.clk_enable ( rx_payload_valid_f   ),//input   clk_enable;
//.ivs        ( ivs   ),//input   ivs;
//.ihs        ( ihs  ),//input   ihs;
//.ide        ( rx_payload_valid_f   ),//input   ide;
//.idat       ( rx_payload_f   ),//input   [31:0] idat;
//.ce_out     (    ),//output  ce_out;
//.ovs        (    ),//output  ovs;
//.ohs        (    ),//output  ohs;
//.odat       ( dpi_data   ),//output  [31:0] odat;
//.ode        ( dpi_dval   ) //output  ode;
//);
wire rx_fifo_rempty;
wire rx_fifo_wfull;
wire rx_fifo_empty,rx_fifo_rd;
wire [31:0] rx_fifo_dat;

`define US_HARD0_FIFO
`ifdef US_HARD0_FIFO	//硬FIFO 打0拍
fifo_32s_1k #(
        //.almostemptyth (10'd810),
        .almostemptyth (10'd512),
        .peek (1'b0),
        .outreg	(1'b0)		
)u7(
    .wclk		 (	clkrx			),//input wclk;
    .rclk        (	clkrx			),//input rclk;
    .rrst_n      (	rstn 			),//input rrst_n;
    .wrst_n      (	rstn 			),//input wrst_n;
    .wdata       (	rx_payload		),//input [31:0] wdata;
    .rdata       (	rx_fifo_dat		),//output [31:0] rdata;
    .wen         (	rx_fifo_wen		),//input wen;
    .ren         (	rx_fifo_rd		),//input ren;
	.prog_empty  (	rx_fifo_empty	),
    .rempty      (					),//output rempty;
	.almost_empty(	rx_fifo_rempty				),
    .wfull       (	rx_fifo_wfull				) //output wfull;
);
`else
tsc_fifo_v2 ux1
(
.wclk       (	clkrx			),//input wclk;
.rclk       (	clkrx			),//input rclk;
.rrst_n     (	rstn			),//input rrst_n;
.wrst_n     (	rstn			),//input wrst_n;
.wdata      (	rx_payload		),//input [31:0] wdata;
.rdata      (	rx_fifo_dat		),//output [31:0] rdata;
.wen        (	rx_fifo_wen		),//input wen;
.ren        (	rx_fifo_rd		),//input ren;
.prog_empty (	rx_fifo_empty	),//output prog_empty;
.rempty     (					),//output rempty;
.wfull      (					) //output wfull;
);
`endif

sc_down_top ux2(
	.clk(clkrx),
	.reset(~rstn),
	.vstart(1'b0),
	.hstart(1'b0),
	.rx_fifo_dat(rx_fifo_dat),
	.rx_fifo_empty(rx_fifo_empty),
	.rx_fifo_rd(rx_fifo_rd),
	.tx_fifo_dat(dpi_data),
	.tx_fifo_wen(dpi_dval),
	.vs_out(),
	.hs_out()
);


`else

// scaler_horizon u_scaler_horizon(
scaler_horizon2 u_scaler_horizon(
// scaler_horizon_cut u_scaler_horizon(
// scaler_horizon_cut2 u_scaler_horizon(
    .clkin(clkrx),
    .rstn(scaler_rstn),

	.dval(rx_payload_valid_t),
	// .dval(rx_payload_valid_f),
	
	.din(rx_payload_t),	
	// .din(rx_payload_f),
	
	.h_val(val_det),
	// .h_val(val_det_f),
	
	.dpi_dval(hval), 
	.dpi_data(h_data)
    );
	

// wire[35:0] fifo_d_o;
// wire fifo_emp;
// wire fifo_rd;

// fifo_mipi_rx u_fifo_mipi_rx(
    // .dout(fifo_d_o),
    // .din({4'b0,h_data}),
    // .writeclk(clkrx),
    // .readclk(clkin),
    // .writeen(hval),
    // .readen(fifo_rd),
    // .reset(~scaler_rstn),
    // .full(),
    // .regce(1'b1),
    // .empty(fifo_emp)
// );

// assign fifo_rd=~fifo_emp;

// scaler_vertical_cut u_scaler_vertical(
    // .clkin(clkin),
    // .rstn(scaler_rstn),
	// .dval(fifo_rd),
	// .din(fifo_d_o[31:0]),	
	// .h_val(val_det_s),
	
	// .test(),
	// .dpi_dval(dpi_dval),
	// .dpi_data(dpi_data)
    // );
	

// scaler_vertical u_scaler_vertical(
// scaler_vertical_cut u_scaler_vertical(
// scaler_vertical2 u_scaler_vertical(
// scaler_vertical_cut_1600 u_scaler_vertical(
scaler_vertical_cut_1520 u_scaler_vertical(
    .clkin(clkrx),
    .rstn(scaler_rstn),
	.dval(hval),
	.din(h_data),	
	.h_val(val_det_s),
	
	.test(),
	.dpi_dval(dpi_dval),
	.dpi_data(dpi_data)
    );

// reg[31:0] test_cnt;
`endif

// always @ (posedge clkrx or negedge rstn) begin
	// if (!rstn) begin
		// test_cnt<=32'b0;
	// end
	// else if(dpi_dval)
		// test_cnt<=test_cnt+1'b1;
// end

assign test[0]=rstn;
assign test[1]=rx_fifo_wen;
assign test[2]=rx_fifo_rempty;
assign test[3]=rx_fifo_wfull;



always @ (posedge clkrx or negedge rstn) begin
	if (!rstn) 
		power_off<=1'b0;
	else if(rx_cmd_valid&(rx_cmd[7:0] == 8'h05&&rx_cmd[23:8] == 16'h0028))
		power_off<=1'b1;
end


endmodule







 

