


module sync_delay (
    input hsync,
    input vsync,
    input clk,
    input rstn,
    output reg hsync_dly,
    output reg vsync_dly
);

//`define NORMAL_DELAY
`define ONE_LINE_DELAY


parameter WIDTH = 8;
//parameter THRESH = 8'h80;
parameter THRESH = 8'h32;

reg [WIDTH-1:0] hcnt;
reg [WIDTH-1:0] vcnt;
reg hs_delay_en, hs_delay_en_d;
reg vs_delay_en, vs_delay_en_d;
reg first_line_flag;
reg first_vs_delay_flag;
reg sec_vs_delay_flag;
reg thd_vs_delay_flag;
wire hs_delay_en_p;
wire vs_delay_en_p;

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        hcnt <= 0;
    else if(hs_delay_en)
        hcnt <= hcnt + 1;
    else
        hcnt <= 0;
end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        hs_delay_en <= 0;
    else if(hsync|vsync)
        hs_delay_en <= 1;
    else if(hcnt == THRESH)
        hs_delay_en <= 0;
end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        hs_delay_en_d <= 0;
    else
        hs_delay_en_d <= hs_delay_en;
end


`ifdef ONE_LINE_DELAY
assign hs_delay_en_p = (~hs_delay_en && hs_delay_en_d);

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        hsync_dly <= 0;
    else
        hsync_dly <= hs_delay_en_p;
end

//delay one line to start vs
always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        first_line_flag <= 0;
    else if(vsync)
        first_line_flag <= 1;
    else if(vsync_dly)
        first_line_flag <= 0;
end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        first_vs_delay_flag <= 0;
    else if(first_line_flag && hsync)
        first_vs_delay_flag <= 1;
    else if(vsync_dly)
        first_vs_delay_flag <= 0;
end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        sec_vs_delay_flag <= 0;
    else if(first_vs_delay_flag && hsync)
        sec_vs_delay_flag <= 1;
    else if(vsync_dly)
        sec_vs_delay_flag <= 0;
end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        thd_vs_delay_flag <= 0;
    else if(sec_vs_delay_flag && hsync)
        thd_vs_delay_flag <= 1;
    else if(vsync_dly)
        thd_vs_delay_flag <= 0;
end

//always @ ( posedge clk or negedge rstn) begin
//    if(~rstn)
//        vcnt <= 0;
//    else if(vs_delay_en)
//        vcnt <= vcnt + 1;
//    else
//        vcnt <= 0;
//end

//assign vs_delay_en_p = (~vs_delay_en && vs_delay_en_d);
//always @ ( posedge clk or negedge rstn) begin
//    if(~rstn)
//        vs_delay_en <= 0;
//    else if(first_line_flag && hsync)
//        vs_delay_en <= 1;
//    else if(vcnt == THRESH)
//        vs_delay_en <= 0;
//end

//always @ ( posedge clk or negedge rstn) begin
//    if(~rstn)
//        vs_delay_en_d <= 0;
//    else
//        vs_delay_en_d <= vs_delay_en;
//end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        vsync_dly <= 0;
    else
        //vsync_dly <= first_vs_delay_flag && hs_delay_en_p;
        //vsync_dly <= sec_vs_delay_flag && hs_delay_en_p;
        vsync_dly <= thd_vs_delay_flag && hs_delay_en_p;
end

`endif
     
`ifdef NORMAL_DELAY
always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        vcnt <= 0;
    else if(vs_delay_en)
        vcnt <= vcnt + 1;
    else
        vcnt <= 0;
end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        vs_delay_en <= 0;
    else if(vsync)
        vs_delay_en <= 1;
    else if(vcnt == THRESH)
        vs_delay_en <= 0;
end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        vs_delay_en_d <= 0;
    else
        vs_delay_en_d <= vs_delay_en;
end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        hsync_dly <= 0;
    else
        hsync_dly <= ~hs_delay_en && hs_delay_en_d;
end

always @ ( posedge clk or negedge rstn) begin
    if(~rstn)
        vsync_dly <= 0;
    else
        vsync_dly <= ~vs_delay_en && vs_delay_en_d;
end

`endif

endmodule


