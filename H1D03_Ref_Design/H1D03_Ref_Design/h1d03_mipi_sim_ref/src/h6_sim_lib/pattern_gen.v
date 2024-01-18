
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/02 18:43:17
// Design Name: 
// Module Name: pattern_gen
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


module pattern_gen #( 
	parameter H_TOTAL = 16'd1252,
	parameter H_VAL = 16'd1242,
	parameter HFP = 16'd4,
	parameter HSP = 16'd6,
	parameter HBP = 16'd0,
	parameter V_TOTAL = 16'd2706,
	parameter V_VAL = 16'd1920,
	parameter VFP = 16'd10,
	parameter VSP = 16'd3,
	parameter VBP = 16'd5
)
(
    input px_clk,
    output hsync,
    output reg vsync,
    output reg dval,
    output reg [23:0] px_data,
    input[3:0] key,
    input rstn,
    output reg line_en
    );




reg[15:0] hcnt;
reg[15:0] vcnt;

reg hsync_o;
reg hsync_s;
wire hsync_r;

reg[15:0] h_act;
reg[15:0] hs_get;
reg[15:0] hs_go;
reg[15:0] h_finish;
reg[15:0] h_go;


reg[23:0] px_data0;
reg[23:0] px_data1;
reg[23:0] px_data2;
reg[23:0] px_data3;

reg h_val;
reg v_val;

wire vs_s;
wire vs_e;
wire dval_o;

reg[15:0] v_act;
reg[15:0] vs_get;
reg[15:0] vs_go;
reg[15:0] v_finish;
reg[15:0] v_go;

reg[15:0] key_cnt;
reg[3:0] key_s;
wire key_press;
reg key_press_s;
wire key_p_r;

reg[1:0] pt_sel;


//***************************************************************//
//***************************************************************//
//***************************************************************//
//key det

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		key_cnt<=16'b0;
	else if(key_press)
		key_cnt<=key_cnt;
	else if(key_s[0])
		key_cnt<=key_cnt+16'b1;
	else 
		key_cnt<=16'b0;
end

assign key_press=key_s[0]&(key_cnt>16'd20000);

always @( posedge px_clk)
 begin
		key_s<=key;
end

always @( posedge px_clk)
 begin
		key_press_s<=key_press;
end

assign key_p_r=key_press&(!key_press_s);

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		pt_sel<=2'b0;
	else if(key_p_r)
		pt_sel<=pt_sel+2'b1;
end

//***************************************************************//
//***************************************************************//
//***************************************************************//
always @( posedge px_clk)
 begin
		h_act<=hs_go+HBP;
		hs_get<=HFP-1'b1;
		hs_go<=hs_get+HSP;
		h_finish<=H_TOTAL-1'b1;
		h_go<=h_act+H_VAL;
end


always @(posedge px_clk or negedge rstn)
	begin
	if (!rstn)
		hcnt<=16'b0;
	else if(hcnt==h_finish)
		hcnt<=16'b0;
	else 
		hcnt<=hcnt+16'b1;
end

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		hsync_s<=16'b0;
	else 
		hsync_s<=hsync_o;
end

assign hsync_r=hsync_o&(!hsync_s);
assign hsync=hsync_s;

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		hsync_o<=1'b0;
	else if(hcnt==hs_get)
		hsync_o<=1'b1;
	else if(hcnt==hs_go)
		hsync_o<=1'b0;
end

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		h_val<=1'b0;
	else if(hcnt==h_act)
		h_val<=1'b1;
	else if(hcnt==h_go)
		h_val<=1'b0;
end

//***************************************************************//
//***************************************************************//

assign dval_o=h_val&v_val;

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		dval<=1'b0;
	else 
		dval<=dval_o;
end

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		line_en<=1'b0;
	else 
		line_en<=v_val;
end


always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		px_data0<=24'h0;
	else if(hcnt==h_act)
		px_data0<=24'hff0000;
	else if(hcnt==(h_act+16'd90))
		px_data0<=24'h00ff00;		
	else if(hcnt==(h_act+16'd180))
		px_data0<=24'h0000ff;
	else if(hcnt==(h_act+16'd270))
		px_data0<=24'hffffff;	
	else if(hcnt==(h_act+16'd360))
		px_data0<=24'hffff00;	
	else if(hcnt==(h_act+16'd450))
		px_data0<=24'h00ffff;	
	else if(hcnt==(h_act+16'd540))
		px_data0<=24'hff00ff;	
	else if(hcnt==(h_act+16'd630))
		px_data0<=24'h123456;			
end

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		px_data1<=24'h0;
	else if(dval_o)
		px_data1<=px_data1+24'h0001;
	else 
		px_data1<=24'h0;
end

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		px_data2<=24'h0;
	else 
		px_data2<=24'h0000ff;
end

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		px_data3<=24'h0;
		else if(dval_o)
		px_data3<=px_data3+24'h111111;
	else 
		px_data3<=24'h0;
end


//always @(posedge px_clk or negedge rstn)
//	begin
//  if (!rstn)
//		px_data<=24'h0;
//	else if (pt_sel==2'h0)
//		px_data<=px_data0;
//	else if (pt_sel==2'h1)
//		px_data<=px_data1;
//	else if (pt_sel==2'h2)
//		px_data<=px_data2;
//	else if (pt_sel==2'h3)
//		px_data<=px_data3;
//end

always @( posedge px_clk)
px_data<=px_data0;

//***************************************************************//
//***************************************************************//

always @( posedge px_clk)
begin
		v_act<=vs_go+VBP;
		vs_get<=VFP;
		vs_go<=vs_get+VSP;
		v_finish<=V_TOTAL;
		v_go<=v_act+V_VAL;
end

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		vcnt<=16'b0;
	else if((vcnt==v_finish))
		vcnt<=16'b0;
	else if(hsync_r)
		vcnt<=vcnt+16'b1;
end

always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		vsync<=1'b0;
	else if(vs_s)
		vsync<=1'b1;
	else if(vs_e)
		vsync<=1'b0;
end

assign vs_s=((vcnt==(vs_get-1'b1))&&hsync_r);
assign vs_e=((vcnt==(vs_go-1'b1))&&hsync_r);


always @(posedge px_clk or negedge rstn)
	begin
    if (!rstn)
		v_val<=1'b0;
	else if(vcnt==v_act)
		v_val<=1'b1;
	else if(vcnt==v_go)
		v_val<=1'b0;
end




endmodule