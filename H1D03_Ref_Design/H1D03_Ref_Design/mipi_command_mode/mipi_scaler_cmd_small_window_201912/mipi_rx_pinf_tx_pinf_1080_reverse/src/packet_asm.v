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


//reg start_s;
//reg start_t;
//reg start_d;
wire start_r;

//************************************//
//************************************//
//************************************//
//always @ (posedge clkin or negedge rstn) begin
//    if (!rstn) begin
//        start_s<=1'b0;
//        start_t<=1'b0;
//        start_d<=1'b0;
//    end
//    else begin
//        start_s<=start;
//        start_t<=start_s;
//        start_d<=start_t;
//    end
//end

//assign start_r=start_s&(!start_t);
//assign start_r=start_t&(!start_d);
//************************************//
//************************************//
//************************************//
assign start_r = start;
assign hs_mode=hs_cfg;  
assign cmd_rq=cmd_rq_o;

//always @(posedge clkin or negedge rstn)
//begin
//    if(!rstn)
//        delay_cnt<=32'h0;
//    else if(cnt_start)
//        delay_cnt<=delay_cnt+32'h1;
//    else
//        delay_cnt<=32'h0;
//end

//assign timeout=	(delay_cnt==32'd333);	


//assign test[0]=start;
//assign test[1]=cmd_ack;
//assign test[2]=time_out;
//assign test[3]=tx_act;
//assign test[7:4]=state;

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
	
//always @(posedge clkin or negedge rstn)
//begin
//     if(rstn == 1'b0) 
//     begin
//       state <= s0;
//       cmd_rq_o <= 1'h0;	   
//       packet_finish <= 1'h0;	  
//        cnt_start<=1'b0;
//    end
//     else begin
//     case(state)
	 
//     s0: begin			
//            if(start_r)
//                begin
//                    packet_finish <= 1'h0;	 
//                    state<=s1;
//                end
//     end
	 
//     s1: begin
//             cmd_rq_o <= 1'h1;	 
//            if(cmd_ack)
//                begin
//                    cmd_rq_o <= 1'h0;	
//                    state<=s2;
//                end
//            if(time_out)
//                begin
//                    state <= s0; 
//                   cmd_rq_o <= 1'h0;				
//                end				
//     end
	 
//     s2: begin
//            if(!tx_act)
//                cnt_start<=1'b1;
//            if(timeout)
//            begin
//                state<=	s0;
//                cnt_start<=1'b0;
//                packet_finish <= 1'h1;	 
//            end
//     end
//    endcase
//end	 
//end
endmodule
