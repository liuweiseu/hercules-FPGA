//-----------------------------------------------------------------------------
//
// Title       : mipi_host_tb
// Design      : h6_sim
// Author      : Bauer
// Company     : bw
//
//-----------------------------------------------------------------------------
//
// File        : mipi_host_TB.v
// Generated   : Sun Dec  8 14:06:05 2019
// From        : d:\My_Designs\h6_sim\h6_sim\src\TestBench\mipi_host_TB_settings.txt
// By          : tb_verilog.pl ver. ver 1.2s
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------

`timescale 1ns / 1ns
module h6_mipi_sim_tb;

//Internal signals declarations:

wire reset_n;
wire clkrx;
wire clktx;
wire RxActiveHS;
wire [23:0]periph_rx_cmd;
wire periph_rx_cmd_valid;
wire [31:0]periph_rx_payload;
wire periph_rx_payload_valid;
wire periph_rx_payload_valid_last;
wire lp_o_p;
wire lp_o_n;

wire host_tx_cmd_ack;
wire host_tx_active;
wire host_tx_payload_en;
wire host_tx_payload_en_last;
	
wire host_tx_cmd_req;
wire [1:0] host_tx_cmd_vc;
wire [5:0] host_tx_cmd_data_type;
wire [15:0] host_tx_cmd_byte_count;
wire host_tx_hs_mode;
wire [31:0] host_tx_payload;



 //Unit Under Test port map
	mipi_host UUT (
		.reset_n(reset_n),
		.clk(clkrx),
		.RxActiveHS(RxActiveHS),
		.periph_rx_cmd(periph_rx_cmd),
		.periph_rx_cmd_valid(periph_rx_cmd_valid),
		.periph_rx_payload(periph_rx_payload),
		.periph_rx_payload_valid(periph_rx_payload_valid),
		.periph_rx_payload_valid_last(periph_rx_payload_valid_last),
		.lp_o_p(lp_o_p),
		.lp_o_n(lp_o_n));
		







rx_packet_tx_packet_video_mode uut_rx_packet_tx_packet_video_mode(
	.rst_n(reset_n),
	.clkrx(clkrx),
	.clktx(clktx),
	.RxByteClkHS(),   //DPHY CLK信号
//*****************RX***************************//
	.RxActiveHS(RxActiveHS),
	.rx_cmd(periph_rx_cmd),
	.rx_cmd_valid(periph_rx_cmd_valid),
	.rx_payload(periph_rx_payload),
  .rx_payload_valid(periph_rx_payload_valid),
	.rx_payload_valid_last(periph_rx_payload_valid_last),
	
//*********************TX****************************//	
	.host_tx_cmd_ack(host_tx_cmd_ack),
	.host_tx_active(host_tx_active),
	.host_tx_payload_en(host_tx_payload_en),
	.host_tx_payload_en_last(host_tx_payload_en_last),
	
	.host_tx_cmd_req(host_tx_cmd_req),
	.host_tx_cmd_vc(host_tx_cmd_vc),
	.host_tx_cmd_data_type(host_tx_cmd_data_type),
	.host_tx_cmd_byte_count(host_tx_cmd_byte_count),
	.host_tx_hs_mode(host_tx_hs_mode),
    .host_tx_payload(host_tx_payload)
);



mipi_slave uut_mipi_slave
(
	// clock and reset
	.clk_byte(clktx), // byte  clock
	.reset_byte_n(reset_n),

	.tx_hs_mode_bc(host_tx_hs_mode), // 1==HSTX, 0==LPDT request
	.tx_payload_bc(host_tx_payload), // User pixel input 
	.tx_payload_en_bc(host_tx_payload_en), // Pixel read enable to user logic
	.tx_payload_en_last_bc(host_tx_payload_en_last), // Last pixel indicator, asserts on last cycle of l_pixel_rd_en
	.tx_cmd_vc_bc(host_tx_cmd_vc), // pkt cmd vc
	.tx_cmd_data_type_bc(host_tx_cmd_data_type), // pkt cmd data type
	.tx_cmd_byte_count_bc(host_tx_cmd_byte_count), // pkt payload size, in bytes
	.tx_cmd_req_bc(host_tx_cmd_req), // pkt xmit request
	.tx_cmd_ack_bc(host_tx_cmd_ack), // pkt cmd ack
	.tx_active_bc(host_tx_active)
);





sys_ctrl_task #(
  .PERIOD(10)
)
sys_ctrl(
  .clk(clkrx),
  .rst_n(reset_n)
);	

sys_ctrl_task #(
  .PERIOD(6)
)
sys_ctrl_tx(
  .clk(clktx),
  .rst_n()
);
	
	
		
initial begin 
  sys_ctrl.sys_reset(32'd1000);
end	 
		

endmodule



module sys_ctrl_task #(
  parameter PERIOD = 10

)
(
  clk,
  rst_n
);
  output reg clk;
  output reg rst_n;
  
  parameter RST_ING = 1'b0;
  
  initial begin
    clk = 0;
    forever
            #(PERIOD/2) clk = ~clk;
  end
  
  task sys_reset;
    input [31:0] reset_time;
    begin
      rst_n = RST_ING;
      #reset_time;
      rst_n = ~RST_ING;
    end
  endtask
  
endmodule
