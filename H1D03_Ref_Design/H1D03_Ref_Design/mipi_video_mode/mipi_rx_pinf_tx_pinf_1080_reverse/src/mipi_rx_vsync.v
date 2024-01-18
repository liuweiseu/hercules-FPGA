

module MIPI_Rx_Vsync
(
	input CLKn,
	input RSTn,
	
	input [5:0]Rx_cmd_data_type,
	input Rx_cmd_valid,

	output Vsync
);

	wire is_rx_vsync_start = (Rx_cmd_data_type == 6'h01) ? 1 : 0;

	reg rx_vsync = 0;
	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
		rx_vsync <= 0;
	else if ( Rx_cmd_valid & is_rx_vsync_start )
		rx_vsync <= 1;
	else
		rx_vsync <= 0;
		
	reg [5:0]rx_vsync_dly = 0;
	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
		rx_vsync_dly <= 0;
	else
		rx_vsync_dly <= {rx_vsync_dly[4:0], rx_vsync};
		
	reg vsync = 0;
	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
		vsync <= 0;
	else
		vsync <= (rx_vsync_dly != 0) ? 1 : 0;
	
	//assign Vsync = vsync;
	assign Vsync = rx_vsync;

endmodule

