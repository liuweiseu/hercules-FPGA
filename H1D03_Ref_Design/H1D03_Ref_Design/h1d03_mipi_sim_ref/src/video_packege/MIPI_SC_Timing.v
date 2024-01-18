
module MIPI_SC_Timing
(
	input CLK_tx,
	input RSTn,
	
	input Vsync,
	input Hsync,
    input tx_fifo_req,
	
	input frame_start,
	input first_3e,
	
	output reg rstf,
    output reg fifo_readen

);
    parameter RX_VACTIVE = 12'd2688;
    parameter RX_HCNT    = 11'd621; //1080*3/4

    assign vsync_p = Vsync;
    assign hsync_p = Hsync;

    reg  rd_line_data_en;
    reg [11:0] rd_line_cnt;

    always @ ( posedge CLK_tx or negedge RSTn ) begin
	if ( RSTn == 0 )
        rd_line_cnt <= 0;
    else if(vsync_p)
        rd_line_cnt <= 0;
    else if(frame_start && hsync_p)
        rd_line_cnt <= rd_line_cnt + 1;
    end

    always @ ( posedge CLK_tx or negedge RSTn ) begin
	if ( RSTn == 0 )
        rd_line_data_en <= 0;
    else if( frame_start && rd_line_cnt< (RX_VACTIVE))
        rd_line_data_en <= 1;
    else
        rd_line_data_en <= 0;
    end

	reg [11:0] rst_cnt;
    always @ ( posedge CLK_tx or negedge RSTn ) begin
	if ( RSTn == 0 )
        rst_cnt <= 0;
    else if(vsync_p)
        rst_cnt <= 0;
    else if(hsync_p)
        rst_cnt <= rst_cnt + 1;
    end
	
	reg first_3e_d;
	always @ ( posedge CLK_tx or negedge RSTn ) begin
		if ( RSTn == 0 )
			first_3e_d <= 0;
		else
			first_3e_d <= first_3e;
    end

    always @ ( posedge CLK_tx or negedge RSTn ) begin
    if ( RSTn == 0 )
       rstf <= 0;
   else if(rst_cnt==12'd6)
       rstf <= 0;
   else
       rstf <= 1;
   end

    reg [11:0] data_cnt;
    always @ ( posedge CLK_tx or negedge RSTn ) begin
	if ( RSTn == 0 )
        data_cnt <= 0;
    else if(hsync_p)
        data_cnt <= 0;
    else if(rd_line_data_en && data_cnt<=RX_HCNT) // && (~fifoempty)
        data_cnt <= data_cnt + 1;
    end

    always @ ( posedge CLK_tx or negedge RSTn ) begin
	if ( RSTn == 0 )
        fifo_readen <= 0;
    else if(rd_line_data_en && data_cnt<RX_HCNT) // && (~fifoempty)
        fifo_readen <= 1;
    else
        fifo_readen <= 0;
    end
	

endmodule


