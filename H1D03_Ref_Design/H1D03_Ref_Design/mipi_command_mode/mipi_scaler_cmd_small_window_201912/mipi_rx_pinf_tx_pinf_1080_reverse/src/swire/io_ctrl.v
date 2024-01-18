// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 09/06/2019 15:08:42   
// Design Name:
// Module Name: io_ctrl
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
// ============================================================
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
module io_ctrl
(
    input            i_reset_n ,
    input            i_clk_38m,
	
    input            i_swire_start,
	input [15:0]     i_b1_data,
	input [15:0]     i_b5_data,
	output           o_swire
);
	parameter 	LIGHT_STATUS_12    = 8'd11,
				LIGHT_STATUS_11    = 8'd12,
				LIGHT_STATUS_10    = 8'd13,
				LIGHT_STATUS_09    = 8'd14,
				LIGHT_STATUS_08    = 8'd15,
				LIGHT_STATUS_07    = 8'd16,
				LIGHT_STATUS_06    = 8'd17,
				LIGHT_STATUS_05    = 8'd18,
				LIGHT_STATUS_04    = 8'd19,
				LIGHT_STATUS_03    = 8'd20,
				LIGHT_STATUS_02    = 8'd21,
				LIGHT_STATUS_01    = 8'd22,
                LIGHT_STATUS_00    = 8'd23;
				
	reg [7:0] s_led_data;
	always @(posedge i_clk_38m, negedge i_reset_n)
	begin
		if(!i_reset_n)
			s_led_data <= LIGHT_STATUS_11;
		// else if(s_sleep)
			// s_led_data <= 8'h0;
		/* else if(s_ca_data == 16'h0100)
			s_led_data <= LIGHT_STATUS_17; */
		else if(i_b1_data != 16'h0)
		begin
			if(i_b1_data <= 16'h0290 && i_b5_data[15:8] == 8'hDC)
			begin
				case(i_b5_data[7:0])
					8'H04: s_led_data <= LIGHT_STATUS_12;
					8'H05: s_led_data <= LIGHT_STATUS_12;
					8'H06: s_led_data <= LIGHT_STATUS_11;
					8'H07: s_led_data <= LIGHT_STATUS_11;
					8'H08: s_led_data <= LIGHT_STATUS_10;
					8'H09: s_led_data <= LIGHT_STATUS_10;
					8'H0A: s_led_data <= LIGHT_STATUS_09;
					8'H0B: s_led_data <= LIGHT_STATUS_09;
					8'H0C: s_led_data <= LIGHT_STATUS_08;
					8'H0D: s_led_data <= LIGHT_STATUS_07;
					default:s_led_data <= LIGHT_STATUS_07;
				endcase	
			end
			else if(i_b1_data <= 16'h0320)
				s_led_data <= LIGHT_STATUS_06;
			else if(i_b1_data <= 16'h0400)
				s_led_data <= LIGHT_STATUS_05;
			else if(i_b1_data <= 16'h0600)
				s_led_data <= LIGHT_STATUS_04;
			else if(i_b1_data <= 16'h0700)
				s_led_data <= LIGHT_STATUS_03;
			else if(i_b1_data <= 16'h0800)
				s_led_data <= LIGHT_STATUS_02;
			else if(i_b1_data <= 16'h0880)
				s_led_data <= LIGHT_STATUS_01;
			else// if(s_b1_data <= 16'h0890)
				s_led_data <= LIGHT_STATUS_00;
		end
	end
		
	parameter 	SWIRE_IDLE       = 4'h0,
				SWIRE_START      = 4'h1,
				SWIRE_LOW_DGE    = 4'h2,	
				SWIRE_LOW        = 4'h3,	
				SWIRE_HIG_DGE    = 4'h4,	
				SWIRE_HIG        = 4'h5,	
				SWIRE_STOP       = 4'h6;	

	parameter 	SWIRE_INIT_TIME = 20'h1000;
	parameter 	SWIRE_LOW_TIME  = 20'h100;
	parameter 	SWIRE_STOP_TIME = 20'hfff04;
	
	
	reg         s_swire;
	wire [7:0]  s_posedge_count;
	reg  [7:0]  s_swire_rise;
	reg  [3:0]  s_swire_state;
	reg  [3:0]  s_swire_next_state;
	reg  [19:0]  s_swire_clk_count;
	

	
	//ctrl swire
	//genener pwm
	assign s_posedge_count = i_swire_start? s_led_data : 8'd32;
	
	always @(posedge i_clk_38m, negedge i_reset_n)
	begin
		if(!i_reset_n)
			s_swire_clk_count <= 20'h0;
		else if(s_swire_state ==  SWIRE_START ||
				s_swire_state ==  SWIRE_LOW   ||
				s_swire_state ==  SWIRE_HIG   ||
				s_swire_state ==  SWIRE_STOP
				)
			s_swire_clk_count <= s_swire_clk_count + 1;
		else
			s_swire_clk_count <= 20'h0;
	end
	
	
	always @(posedge i_clk_38m, negedge i_reset_n)
	begin
		if(!i_reset_n)
			s_swire_rise <= 8'h0;
		else if(s_swire_state ==  SWIRE_LOW_DGE)
			s_swire_rise <= s_swire_rise + 1;
		else if(s_swire_state ==  SWIRE_IDLE)
			s_swire_rise <= 8'h0;
	end
	
	
	reg s_swire_en;
	always @(posedge i_clk_38m, negedge i_reset_n)
	begin
		if(!i_reset_n)
			s_swire_en <= 1'b0;
		else if(s_posedge_count != 8'h0)
			s_swire_en <= 1'b1;
		else 
			s_swire_en <= 1'b0;
	end
	
	
	always @(posedge i_clk_38m, negedge i_reset_n)
	begin
		if(!i_reset_n)
			s_swire <= 1'b0;
		else if(s_swire_en)
		begin
			if(s_swire_state ==  SWIRE_LOW)
				s_swire <= 1'b0;
			else
				s_swire <= 1'b1;
		end
		else
			s_swire <= 1'b0;
	end
	
	
	always @(posedge i_clk_38m, negedge i_reset_n)
	begin
		if(!i_reset_n)
			s_swire_state <= SWIRE_IDLE;
		else
			s_swire_state <= s_swire_next_state;
	end
	
	always @(*)
	begin
		if(!i_reset_n)
			s_swire_next_state = SWIRE_IDLE;
		else
		begin
			case(s_swire_state)
				SWIRE_IDLE:
				begin
					if(s_swire_en)
						s_swire_next_state = SWIRE_START;
					else
						s_swire_next_state = SWIRE_IDLE;
				end
				SWIRE_START:
				begin
					if(s_swire_clk_count >= SWIRE_INIT_TIME)
						s_swire_next_state = SWIRE_LOW_DGE;
					else
						s_swire_next_state = SWIRE_START;
				end
				SWIRE_LOW_DGE:
				begin
					s_swire_next_state = SWIRE_LOW;
				end
				SWIRE_LOW:
				begin
					if(s_swire_clk_count >= SWIRE_LOW_TIME)
						s_swire_next_state = SWIRE_HIG_DGE;
					else
						s_swire_next_state = SWIRE_LOW;
				end
				SWIRE_HIG_DGE:
				begin
					if(s_swire_rise >= s_posedge_count)
						s_swire_next_state = SWIRE_STOP;
					else
						s_swire_next_state = SWIRE_HIG;
				end
				SWIRE_HIG:
				begin
					if(s_swire_clk_count >= SWIRE_LOW_TIME)
						s_swire_next_state = SWIRE_LOW_DGE;
					else
						s_swire_next_state = SWIRE_HIG;
				end
				SWIRE_STOP:
				begin
					if(s_swire_clk_count >= SWIRE_STOP_TIME)
						s_swire_next_state = SWIRE_IDLE;
					else
						s_swire_next_state = SWIRE_STOP;
				end
			endcase	
		end
	end

	// assign o_swire   = i_reset_n;
	assign o_swire   = s_swire;
	

    
    
    
    
    
endmodule

