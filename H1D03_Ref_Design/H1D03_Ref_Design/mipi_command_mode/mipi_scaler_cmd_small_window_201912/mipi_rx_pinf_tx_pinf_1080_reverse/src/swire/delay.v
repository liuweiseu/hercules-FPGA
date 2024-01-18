`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:37:33 04/22/2017
// Design Name: 
// Module Name:    mipi_decode
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module delay#
(
	parameter  SWIRESTARTDELAY        = 24'h30
)
(
    input            i_reset_n    ,
	input            i_clk_38m    ,

	output           o_swire_start
);

	reg s_swire_start;
	reg[23:0] s_clk_count;
	
	always @(posedge i_clk_38m, negedge i_reset_n)
	begin
		if(!i_reset_n)
			s_swire_start <= 1'b0;
		else if(s_clk_count >= SWIRESTARTDELAY)
			s_swire_start <= 1'b1;
	end
		
	always @(posedge i_clk_38m, negedge i_reset_n)
	begin
		if(!i_reset_n)	
			s_clk_count <= 24'h0;
		else if(!s_swire_start)
			s_clk_count <= s_clk_count + 24'h1;
		else
			s_clk_count <= 24'h0;
	end
	assign o_swire_start = s_swire_start;
	
endmodule
