`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/10 19:28:23
// Design Name: 
// Module Name: packet_asm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module packet_asm(
    input clkin,
    input rstn,
    input start,
    output cmd_rq,
    output hs_mode,
    output reg packet_finish,
    input cmd_ack,
    input time_out,
    input tx_act,
    input empty,
	input hs_cfg,
	
	output[7:0] test
    );
	


parameter s0 = 4'd0;
parameter s1 = 4'd1;
parameter s2 = 4'd2;
parameter s3 = 4'd3;
parameter s4 = 4'd4;


reg[3:0] state;
reg cmd_rq_o;
reg cnt_start;

reg[31:0] delay_cnt;

wire timeout;
reg tx_act_d;
wire tx_act_neg;


wire start_r;


assign start_r = start;
assign hs_mode=hs_cfg;  
assign cmd_rq=cmd_rq_o;



always @(posedge clkin or negedge rstn) begin
    if(~rstn)
        cmd_rq_o <= 0;
    else if(cmd_ack)
        cmd_rq_o <= 0;
    else if(start_r)
        cmd_rq_o <= 1;
end

always @(posedge clkin or negedge rstn) begin
    if(~rstn)
        tx_act_d <= 0;
    else
        tx_act_d <= tx_act;
end

assign tx_act_neg = ~tx_act && tx_act_d;

always @(posedge clkin or negedge rstn) begin
    if(~rstn)
        packet_finish <= 0;
    else if(start_r)
        packet_finish <= 0;
    else if(tx_act_neg)
        packet_finish <= 1;
end
	

endmodule
