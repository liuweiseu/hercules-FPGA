
module MIPI_TX_Fifo_Readen_Generator
(
	input CLK_tx,
	input RSTn,

	input [5:0]Tx_cmd_data_type,
    input Tx_cmd_req,
	input Tx_cmd_ack,
	input Tx_payload_en,
	input Tx_payload_en_last,
	input Fifo_almostempty,
	
	output Fifo_readen
);
	//wire is_3Eh_packet = (Tx_cmd_ack & (Tx_cmd_data_type == 6'h3E)) ? 1 : 0;

    reg is_3Eh_packet;
	reg fifo_readen_mask = 0;
    reg is_3Eh_request;

    always @ ( posedge CLK_tx or negedge RSTn ) begin
        if ( RSTn == 0 )
            is_3Eh_request <= 0;
        else if(Tx_cmd_req & (Tx_cmd_data_type == 6'h3E))
            is_3Eh_request <= 1;
        else if(Tx_cmd_ack)
            is_3Eh_request <= 0;
    end

    always @ ( posedge CLK_tx or negedge RSTn ) begin
        if ( RSTn == 0 )
            is_3Eh_packet <= 0;
        else if(Tx_cmd_ack & (Tx_cmd_data_type == 6'h3E) & is_3Eh_request)
            is_3Eh_packet <= 1;
        else if(Tx_payload_en_last)
            is_3Eh_packet <= 0;
    end
    assign Fifo_readen = is_3Eh_packet & Tx_payload_en;

	//always @ ( posedge CLK_tx or negedge RSTn )
	//if ( RSTn == 0 )
	//    fifo_readen_mask <= 0;
	//else if ( Tx_payload_en_last ) begin
	//    if ( is_3Eh_packet )
	//        fifo_readen_mask <= 1;
	//    else
	//        fifo_readen_mask <= 0;
	//end
	
	//assign Fifo_readen = fifo_readen_mask & Tx_payload_en;
	//assign Fifo_readen = (fifo_readen_mask & (Tx_payload_en & (!Tx_payload_en_last))) | is_3Eh_packet;
/*
debugware_v2_1  dbg(
    .trig_out_0(),
	//.data_in_0({mipi1_tx_dphy_rdy, mipi2_tx_dphy_rdy, mipi_pll_lock, mcu8051_clkperen, mcu8051_clkcpuen}),
	//.data_in_0({mipi1_tx_dphy_rdy, mipi2_tx_dphy_rdy, mipi_pll_lock, pready_mipi1, penable, pwrite, psel_mipi1, paddr, pwdata}),
	//				1						1				1			1			1			1		1		18		32
    //.ref_clk_0(pll_hs_clk)
	
	.data_in_0({Fifo_readen, fifo_readen_mask, Tx_payload_en_last, Tx_payload_en, Tx_cmd_ack, Tx_cmd_data_type}),
	//				1				1					1				1				1			6
	.ref_clk_0(CLK_tx)
	
	//.data_in_0({do_en, mipi_lane_data}),
	//.ref_clk_0(bytsclk)
);
*/
endmodule

