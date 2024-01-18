
module MIPI_TX_Timing_Generator
(
	input CLK_tx,
	input RSTn,
	
	input frame_start,
	input Vsync,
	input Hsync,
    input tx_fifo_req,

	output [5:0]Tx_cmd_data_type,
	output [15:0]Tx_cmd_byte_count,
	output Tx_cmd_req,
	input Tx_cmd_ack,
	input Tx_payload_en,
	input Tx_payload_en_last,
	output reg test,
	
    output reg fifo_readen,
	input Fifo_almostempty
);

    parameter TX_VACTIVE = 12'd1440;


    assign hsync_p = Hsync;
    assign vsync_p = Vsync;

    reg hsync_d1, hsync_d2;
    always @ ( posedge CLK_tx or negedge RSTn ) begin
	if ( RSTn == 0 )
        {hsync_d2,hsync_d1} <= 0;
    else
        {hsync_d2,hsync_d1} <= {hsync_d1,hsync_p};
    end

	reg line_data_en = 0;
	reg line_data_en_d = 0;
    wire line_data_en_neg;
	reg [11:0] line_cnt = 0;
	
	reg [1:0] frame_start_sync;
	always @ ( posedge CLK_tx or negedge RSTn )
	if ( RSTn == 0 )
		frame_start_sync <= 2'b00;
	else
		frame_start_sync <= {frame_start_sync[0], frame_start};

	reg frame_start_d;
	wire frame_start_p;
	assign frame_start_p = (~frame_start_d) & frame_start_sync[1];
	always @ ( posedge CLK_tx or negedge RSTn )
	if ( RSTn == 0 )
		frame_start_d <= 0;
    //else if(vsync_p)
    //    frame_start_d <= 0;
	else
		frame_start_d <= frame_start_sync[1];

    reg [11:0] tx_line_cnt;
	always @ ( posedge CLK_tx or negedge RSTn )
	if ( RSTn == 0 )
		line_data_en <= 0;
    else if(vsync_p)
        line_data_en <= 0;
    else if(tx_line_cnt >= TX_VACTIVE)
		line_data_en <= 0;
    else if (frame_start_p)
        line_data_en <= 1;

	always @ ( posedge CLK_tx or negedge RSTn )
	if ( RSTn == 0 )
        line_data_en_d <= 0;
    else
        line_data_en_d <= line_data_en;

    assign line_data_en_neg = ~line_data_en && line_data_en_d;

	//always @ ( posedge CLK_tx or negedge RSTn )
	//if ( RSTn == 0 )
    //    line_cnt <= 0;
    //else if(vsync_p)
    //    line_cnt <= 0;
    //else if(frame_start_sync[1] && hsync_p)
    //    line_cnt <= line_cnt + 1;

	parameter cmdv =  32'h01080000;
	parameter cmdh1 = 32'h21080000;
	parameter cmdh2 = 32'h21193E19;
	parameter cmdh3 = 32'h19080019;
	parameter cmdh4 = 32'h09090909;
	parameter byte_count_v =  64'h0000F0F000000000;
	parameter byte_count_h1 = 64'h00000F0F00000030;
    parameter byte_count_h3 = 64'h0030003000300030;
	parameter byte_count_h2 = 64'h0000002008700020; //HCNT set here: 720*3 = 2160 (0x0870)
	parameter byte_count_h4 = 64'h0020002000200020;

    wire tx_3e_flag;
    reg last_line_flag;
	reg [31:0]tx_cmd = 0;
	reg [63:0]tx_cmd_byte_count = 0;
    reg tx_line_flag;
    reg tx_cmd_ack_d;

    assign tx_3e_flag = line_data_en_d && (Tx_cmd_data_type == 6'h3E);
    always @ ( posedge CLK_tx or negedge RSTn ) begin
        if ( RSTn == 0 )
            last_line_flag <= 0;
        else if(hsync_p)
            last_line_flag <= 0;
        else if(line_data_en_neg)
            last_line_flag <= 1;
    end

    always @ ( posedge CLK_tx or negedge RSTn ) begin
        if ( RSTn == 0 )
            tx_cmd_ack_d<= 0;
        else
            tx_cmd_ack_d <= Tx_cmd_ack;
    end

    always @ ( posedge CLK_tx or negedge RSTn ) begin
        if ( RSTn == 0 )
            tx_line_flag <= 0;
        else if(hsync_d2 && line_data_en && (~Fifo_almostempty))
            tx_line_flag <= 1;
        else if(tx_cmd_ack_d && Tx_cmd_data_type == 6'h3E)
            tx_line_flag <= 0;
    end

    always @ ( posedge CLK_tx or negedge RSTn ) begin
        if ( RSTn == 0 ) begin
            tx_cmd <= 0;
            tx_cmd_byte_count <= 0;
        end else if (vsync_p) begin
            tx_cmd <= cmdv;
            tx_cmd_byte_count <= byte_count_v;
        end else if(line_data_en) begin
            if(hsync_d2) begin
                tx_cmd <= ~Fifo_almostempty ? cmdh2 : cmdh4;
                tx_cmd_byte_count <= ~Fifo_almostempty ? byte_count_h2 : byte_count_h4;
            end else if(Tx_cmd_ack) begin
                tx_cmd <= tx_line_flag ? {tx_cmd[23:0], tx_cmd[31:24]} : cmdh4;
                tx_cmd_byte_count <= tx_line_flag ? {tx_cmd_byte_count[47:0], tx_cmd_byte_count[63:48]} : byte_count_h4;
            end
        end else begin
            if(hsync_p) begin
                tx_cmd <= cmdh1;
                tx_cmd_byte_count <= byte_count_h1;
            end else if(Tx_cmd_ack) begin
                tx_cmd <= (~last_line_flag) ? {tx_cmd[23:0], 8'h00} : cmdh4;
                tx_cmd_byte_count <= (~last_line_flag) ? {tx_cmd_byte_count[47:0], 16'h0000} : byte_count_h4;
                //tx_cmd <= {tx_cmd[15:0], 8'h00};
                //tx_cmd_byte_count <= {tx_cmd_byte_count[31:0], 16'h0000};
            end
        end
    end

    always @ ( posedge CLK_tx or negedge RSTn )
    if ( RSTn == 0 )
        tx_line_cnt <= 0;
    else if(vsync_p)
        tx_line_cnt <= 0;
    else if(line_data_en && Tx_cmd_ack && Tx_cmd_data_type==6'h3E)
        tx_line_cnt <= tx_line_cnt + 1;

	wire is_cmd_end = (tx_cmd[31:24] == 0) ? 1 : 0;
	reg tx_cmd_req = 0;
	always @ ( posedge CLK_tx or negedge RSTn )
	if ( RSTn == 0 )
		tx_cmd_req <= 0;
	else
		tx_cmd_req <= ~is_cmd_end;

	//assign Tx_cmd_data_type = tx_cmd[31:24];
	//assign Tx_cmd_byte_count = tx_cmd_byte_count[63:48];
	assign Tx_cmd_data_type = tx_cmd[31:24];
	assign Tx_cmd_byte_count = tx_cmd_byte_count[63:48];
	assign Tx_cmd_req = tx_cmd_req & (~is_cmd_end);
	//assign Tx_cmd_req = tx_cmd_req;
    always @ ( posedge CLK_tx or negedge RSTn ) begin
        if ( RSTn == 0 )
            test <= 0;
        else
            test <= tx_line_flag;
    end

	

endmodule


