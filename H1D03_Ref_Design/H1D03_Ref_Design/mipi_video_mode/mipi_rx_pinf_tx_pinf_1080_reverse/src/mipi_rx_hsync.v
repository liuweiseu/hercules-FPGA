

module MIPI_Rx_Hsync
(
	input CLKn,
	input RSTn,
	
	input [5:0]Rx_cmd_data_type,
	input Rx_cmd_valid,

	output Hsync
);
	
	wire is_rx_hsync_start = (Rx_cmd_data_type == 6'h21) ? 1 : 0;
	wire is_rx_vsync_start = (Rx_cmd_data_type == 6'h01) ? 1 : 0;
		
	reg rx_hsync = 0;
	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
		rx_hsync <= 0;
	//else if ( Rx_cmd_valid & (is_rx_hsync_start | is_rx_vsync_start) )
	else if ( Rx_cmd_valid & is_rx_hsync_start )
		rx_hsync <= 1;
	else
		rx_hsync <= 0;
		
	reg [5:0]rx_hsync_dly = 0;
	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
		rx_hsync_dly <= 0;
	else
		rx_hsync_dly <= {rx_hsync_dly[4:0], rx_hsync};
		
	reg hsync = 0;
	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
		hsync <= 0;
	else
		hsync <= (rx_hsync_dly != 0) ? 1 : 0;
	
	//assign Hsync = hsync;
	assign Hsync = rx_hsync;

endmodule

