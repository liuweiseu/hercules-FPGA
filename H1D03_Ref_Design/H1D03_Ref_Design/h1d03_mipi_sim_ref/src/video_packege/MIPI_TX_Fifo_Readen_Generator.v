
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

    reg is_3Eh_packet;
	reg fifo_readen_mask = 0;
    reg is_3Eh_request;

    always @ ( posedge CLK_tx or negedge RSTn ) begin
        if ( RSTn == 0 )
            is_3Eh_request <= 0;
        else if(Tx_cmd_req & (Tx_cmd_data_type == 6'h3e))
            is_3Eh_request <= 1;
        else if(Tx_cmd_ack)
            is_3Eh_request <= 0;
    end

    always @ ( posedge CLK_tx or negedge RSTn ) begin
        if ( RSTn == 0 )
            is_3Eh_packet <= 0;
        else if(Tx_cmd_ack & (Tx_cmd_data_type == 6'h3e) & is_3Eh_request)
            is_3Eh_packet <= 1;
        else if(Tx_payload_en_last)
            is_3Eh_packet <= 0;
    end
    assign Fifo_readen = is_3Eh_packet & Tx_payload_en;


endmodule

