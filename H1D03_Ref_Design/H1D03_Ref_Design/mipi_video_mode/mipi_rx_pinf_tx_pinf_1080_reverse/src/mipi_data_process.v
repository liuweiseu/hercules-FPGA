

module mipi_data_process 
(
	input CLKn,
	input RSTn,

    input rx_vsync,
    input rx_hsync,
	
	input [5:0]Rx_cmd_data_type,
	input [15:0]Rx_cmd_word_count,
	input Rx_cmd_valid,
	input [31:0]Rx_payload,
	input Rx_payload_valid,
	input Rx_payload_valid_last,
    output reg frame_start,

	output reg fifo_writeen,
	output reg [31:0]fifo_din
);

    parameter HEIGHT = 11'd1440;
	
	reg data_3Eh_valid = 0;
	reg data_3Eh_valid_d = 0;
	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
		data_3Eh_valid <= 0;
	else if ( Rx_cmd_valid & ( Rx_cmd_data_type == 6'h3E ) )
		data_3Eh_valid <= 1;
	else if ( Rx_payload_valid_last )
		data_3Eh_valid <= 0;
	else
		data_3Eh_valid <= data_3Eh_valid;

	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
        data_3Eh_valid_d <= 0;
    else
		data_3Eh_valid_d <= data_3Eh_valid;

    wire data_3Eh_valid_p = ~data_3Eh_valid_d && data_3Eh_valid;


	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
		fifo_din <= 0;
	else
		fifo_din <= Rx_payload;
	
	always @ ( posedge CLKn or negedge RSTn )
	if ( RSTn == 0 )
		fifo_writeen <= 0;
	else
		//fifo_writeen <= data_3Eh_valid & Rx_payload_valid & (rcnt < HEIGHT);
        fifo_writeen <= data_3Eh_valid & Rx_payload_valid;
//	 fifo_writeen <= data_3Eh_valid & Rx_payload_valid & (ignor_cnt == 6'd1 ||ignor_cnt == 6'd2) & (ignor_hcnt == 12'd1 || ignor_hcnt == 12'd2);// 

    reg first_3e;
    always @ (posedge CLKn or negedge RSTn) begin
	if(~RSTn)
		first_3e <= 1'b0;
	else if(rx_vsync)
		first_3e <= 1'b0;
	//else if(rx_cmd_data_type == 6'h3e[> && rx_cmd_valid<])
    //else if(rx_cmd_data_type == 6'h3e && rx_cmd_valid)
    else if(data_3Eh_valid_p)
		first_3e <= 1'b1;
	else
		first_3e <= first_3e;
    end

    always @ (posedge CLKn or negedge RSTn) begin
        if(~RSTn)
            frame_start <= 1'b0;
        else if(rx_vsync)
            frame_start <= 1'b0;
        else if(first_3e && rx_hsync)
            frame_start <= 1'b1;
        else
            frame_start <= frame_start;
    end

endmodule

