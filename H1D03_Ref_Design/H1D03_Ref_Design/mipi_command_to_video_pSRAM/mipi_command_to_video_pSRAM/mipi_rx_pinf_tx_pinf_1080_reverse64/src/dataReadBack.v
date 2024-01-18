
// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 06/12/2019 10:33:21   
// Design Name:
// Module Name: dataReadBack
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
module dataReadBack(
	clk_periph,
	rstn,
//////	periph	
	mipi_periph_rx_cmd,
	mipi_periph_rx_cmd_valid,
	mipi_periph_tx_payload_en,
	mipi_periph_tx_payload_en_last,
	mipi_periph_tx_cmd_ack,
	mipi_periph_dphy_direction,
	

	mipi_periph_tx_payload,
	mipi_periph_tx_cmd_vc,
	mipi_periph_tx_cmd_data_type,
	mipi_periph_tx_cmd_byte_count,
	mipi_periph_tx_cmd_req

);





input clk_periph;
input rstn;
//////	periph	
input [23:0] mipi_periph_rx_cmd;
input  mipi_periph_rx_cmd_valid;
input  mipi_periph_tx_payload_en;
input  mipi_periph_tx_payload_en_last;
input  mipi_periph_tx_cmd_ack;
input  mipi_periph_dphy_direction;
	
output reg [31:0] mipi_periph_tx_payload;
output [1:0] mipi_periph_tx_cmd_vc;
output reg [5:0] mipi_periph_tx_cmd_data_type;
output reg [15:0] mipi_periph_tx_cmd_byte_count;
output reg mipi_periph_tx_cmd_req;



assign mipi_periph_tx_cmd_vc = 2'd0;


always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_cmd_data_type  <= 6'd0;
		mipi_periph_tx_cmd_byte_count <= 16'd0;
	end else begin
		if(mipi_periph_rx_cmd_valid && (mipi_periph_rx_cmd[5:0]==6'h06 || mipi_periph_rx_cmd[5:0]==6'h14)) begin
			case(mipi_periph_rx_cmd[23:8])
				16'h00da : begin
						mipi_periph_tx_cmd_data_type  <= 6'h21;
						mipi_periph_tx_cmd_byte_count <= 16'h0076;
					end
				16'h00b7 : begin
						mipi_periph_tx_cmd_data_type  <= 6'h21;
						mipi_periph_tx_cmd_byte_count <= 16'h0093;
					end
				16'h00b8 : begin
						mipi_periph_tx_cmd_data_type  <= 6'h21;
						mipi_periph_tx_cmd_byte_count <= 16'h0028;
					end
//				16'h00b8 : begin
//						mipi_periph_tx_cmd_data_type  <= 6'h21;
//						mipi_periph_tx_cmd_byte_count <= 16'h0000;
//					end
				default : begin
						mipi_periph_tx_cmd_data_type  <= 6'h00;
						mipi_periph_tx_cmd_byte_count <= 16'h0000;
					end
			endcase	
		end	
	end
end


//reg [31:0] tx_buff[11:0];
//always @(posedge clk_periph or negedge rstn) begin
//	if(!rstn) begin
//		tx_buff[0] <= 0;
//		tx_buff[1] <= 0;
//		tx_buff[2] <= 0;
//		tx_buff[3] <= 0;
//		tx_buff[4] <= 0;
//		tx_buff[5] <= 0;
//		tx_buff[6] <= 0;
//		tx_buff[7] <= 0;
//		tx_buff[8] <= 0;
//		tx_buff[9] <= 0;
//		tx_buff[10] <= 0;
//		tx_buff[11] <= 0;
//	end else begin
//		if(mipi_periph_rx_cmd_valid && (mipi_periph_rx_cmd[5:0]==6'h06 || mipi_periph_rx_cmd[5:0]==6'h14)) begin
//			case(mipi_periph_rx_cmd[23:8])
//				16'h0004 : begin
//						tx_buff[0] <= 32'h00_43_11_81;
//					end
//				16'h0005 : begin
//						tx_buff[0] <= 0;
//					end
//				16'h00EE : begin
//						tx_buff[0] <= 0;
//					end
//				16'h000F : begin
//						tx_buff[0] <= 0;
//					end
//				16'h000A : begin
//						tx_buff[0] <= 0;
//					end	
//				16'h00C8 : begin
//						tx_buff[0] <= 32'h3A_64_32_20;
//						tx_buff[1] <= 32'h59_56_56_8F;
//						tx_buff[2] <= 32'h42_5b_58_58;
//						tx_buff[3] <= 32'h46_4a_47_41;
//						tx_buff[4] <= 32'h5f_57_58_4e;
//						tx_buff[5] <= 32'h35_5c_54_57;
//						tx_buff[6] <= 32'h69_61_44_39;
//						tx_buff[7] <= 32'h06_28_01_63;
//						tx_buff[8] <= 0;
//						tx_buff[9] <= 0;
//						tx_buff[10] <= 32'h26_09_02_73;
//						tx_buff[11] <= 32'h00_01_0d_00;
//					end	
//				16'h00A1 : begin
//						tx_buff[0] <= 32'h6e_0c_a0_0b;
//					end	
//				16'h00D6 : begin
//						tx_buff[0] <= 32'hA9_50_18_43;
//						tx_buff[1] <= 32'h00_00_00_fe;
//					end	
//				16'h00B5 : begin
//						tx_buff[0] <= 32'h01_04_dc_19;
//						tx_buff[1] <= 32'hcd_9a_67_34;
//						tx_buff[2] <= 32'h44_33_22_01;
//						tx_buff[3] <= 32'h99_09_00_c0;
//						tx_buff[4] <= 32'h11_01_13_33;
//						tx_buff[5] <= 32'h08_12_00_10;
//					end	
//				16'h00C9 : begin
//						tx_buff[0] <= 32'h01_01_10_01;
//						tx_buff[1] <= 32'h4e_32_41_a6;
//						tx_buff[2] <= 32'h38_53_31_4c;
//						tx_buff[3] <= 32'h51_52_42_31;
//						tx_buff[4] <= 32'h35_30_48_44;
//						tx_buff[5] <= 32'h00_00_00_36;
//					end	
//				16'h00B3 : begin
//						tx_buff[0] <= 32'h00_07_40_03;
//						tx_buff[1] <= 32'h77_30_26_2e;
//						tx_buff[2] <= 32'h7c_7c_77_79;
//						tx_buff[3] <= 32'h7e_7e_7e_7d;
//						tx_buff[4] <= 32'h80_7c_7c_7c;
//						tx_buff[5] <= 32'h79_79_7f_7f;
//						tx_buff[6] <= 32'h7d_7c_7d_7a;
//						tx_buff[7] <= 32'h7f_68_6e_68;
//						tx_buff[8] <= 32'h00_00_7a_58;
//					end	
//				16'h00B8 : begin
//						tx_buff[0] <= 32'h00_00_b2_c0;
//						tx_buff[1] <= 32'h00_00_80_00;
//						tx_buff[2] <= 32'h2c_61_80_00;
//						tx_buff[3] <= 32'h33_c4_4e_30;
//						tx_buff[4] <= 32'hc7_7a_12_69;
//						tx_buff[5] <= 0;
//						tx_buff[6] <= 32'h1a_50_50_50;
//						tx_buff[7] <= 32'h1b_1b_1a_1a;
//						tx_buff[8] <= 32'h00_00_00_1b;
//					end	
//				16'h00EB : begin
//						tx_buff[0] <= 32'h00_00_15_5e;
//						tx_buff[1] <= 32'h00_63_00_00;
//					end	
//				16'h00EC : begin
//						tx_buff[0] <= 32'h00_00_88_88;
//						tx_buff[1] <= 32'h88_88_02_01;
//					end
//				default : begin
//						tx_buff[0] <= 0;
//						tx_buff[1] <= 0;
//						tx_buff[2] <= 0;
//						tx_buff[3] <= 0;
//						tx_buff[4] <= 0;
//						tx_buff[5] <= 0;
//						tx_buff[6] <= 0;
//						tx_buff[7] <= 0;
//						tx_buff[8] <= 0;
//						tx_buff[9] <= 0;
//						tx_buff[10] <= 0;
//						tx_buff[11] <= 0;
//					end
//			endcase		
//		end
//	end
//end




reg  mipi_periph_tx_payload_en_last_d;
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_payload_en_last_d <= 1'b0;
	end else begin
		mipi_periph_tx_payload_en_last_d     <= mipi_periph_tx_payload_en_last;
	end
end


wire mipi_periph_tx_payload_en_last_f;
assign mipi_periph_tx_payload_en_last_f = mipi_periph_tx_payload_en_last_d&(!mipi_periph_tx_payload_en_last);


reg [7:0] bufCnt;
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		bufCnt <= 0;
	end else begin
		if(mipi_periph_tx_payload_en) begin 
			bufCnt <= bufCnt + 1;
		end	else if(mipi_periph_tx_payload_en_last_f) begin
			bufCnt <= 0;
		end
	end
end




always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_payload <= 0;
	end else begin
		if(mipi_periph_tx_payload_en) begin 
			mipi_periph_tx_payload <= 0;  //tx_buff[bufCnt];
		end	else begin
			mipi_periph_tx_payload <= 0;
		end
	end
end












reg  mipi_periph_dphy_direction_d;
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_dphy_direction_d <= 1'b0;
	end else begin
		mipi_periph_dphy_direction_d     <= mipi_periph_dphy_direction;
	end
end



wire  mipi_periph_dphy_direction_f;
assign mipi_periph_dphy_direction_f= mipi_periph_dphy_direction_d&(!mipi_periph_dphy_direction);

always @ (posedge clk_periph or negedge rstn) begin
	if (!rstn) begin
		mipi_periph_tx_cmd_req<=1'b0;
	end
	else if(mipi_periph_dphy_direction_f)
		mipi_periph_tx_cmd_req<=1'b1;
	else if(mipi_periph_tx_cmd_ack)
		mipi_periph_tx_cmd_req<=1'b0;
end

endmodule

