
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
	mipi_periph_tx_cmd_req,
	test

);

`define BTA_REG
//`define READ_ID
//`define ESD_CHECK
//`define TX_DATA
`ifdef BTA_REG
	parameter   CHANGE_REG0           = 8'hda,
	            CHANGE_REG1           = 8'hdb,
	            CHANGE_REG2           = 8'hdc,
	            CHANGE_REG3           = 8'hc8,
	            CHANGE_REG4           = 8'ha1,
	            CHANGE_REG5           = 8'hd6,
	            CHANGE_REG6           = 8'hb6,
	            CHANGE_REG7           = 8'hb4,
	            CHANGE_REG8           = 8'hc9,
	            CHANGE_REG9           = 8'h0A,
	            CHANGE_REGA           = 8'h04;
`endif

`ifdef READ_ID
/*******************ID0*************************************/
/********************21 41 00 ECC***************************/
parameter RDID_AR0 = 8'h04;             //设置要读的寄存器地址

parameter DATA_TYPE0 = 8'h21;		   
parameter WC0 = 16'h0081;    
/***********************************************************/
/*******************ID1*************************************/
/********************21 40 00 ECC***************************/
parameter RDID_AR1 = 8'hDB;             //设置要读的寄存器地址
parameter DATA_TYPE1 = 8'h21;
parameter WC1 = 16'h0011;    
/***********************************************************/
/*******************ID2*************************************/
/********************21 24 00 ECC***************************/
parameter RDID_AR2 = 8'hDC;             //设置要读的寄存器地址
parameter DATA_TYPE2 = 8'h21;
parameter WC2 = 16'h0042;    
/***********************************************************/
`endif

`ifdef ESD_CHECK
/*******************ESD_CHECK*************************************/
/********************21 9E 00 ECC***************************/
parameter RDID_AR3 = 8'h0A;             //设置要读的寄存器地址
parameter DATA_TYPE3 = 8'h21;		   
parameter WC3 = 16'h009E;    
/***********************************************************/
`endif


`ifdef TX_DATA
/********************************TX_DATA0*************************************/
parameter BUFFER_SIZE = 4;            //取长包所需反馈数的最大BYTE数
parameter COUNT_BIT_SIZE = 1;          //tx_payload 计数器，其值为：COUNT_BIT_SIZE >= BUFFER_SIZE/4的值，如BUFFER_SIZE=10，则COUNT_BIT_SIZE >= 3
parameter PACKAGE_NUM = 4'd2;          //
/*********1C 0A 00 ECC 01 02 03 04 05 06 07 08 09 0A***************************/
parameter RDID_AR4 = 8'hA0;             //设置要读的寄存器地址
parameter DATA_TYPE4 = 8'h1C;		   
parameter WC4 = 16'h000A;  				  
parameter P0_DATA0=8'h01,P0_DATA1=8'h02,P0_DATA2=8'h03,P0_DATA3=8'h04,P0_DATA4=8'h05,P0_DATA5=8'h06,P0_DATA6=8'h07,P0_DATA7=8'h08,P0_DATA8=8'h09,P0_DATA9=8'h0A;
/******************************************************************************/
/********************************TX_DATA1*************************************/
/*********1C 0A 00 ECC AA BB CC 05 06***************************/
parameter RDID_AR5 = 8'hB0;             //设置要读的寄存器地址
parameter DATA_TYPE5 = 8'h1C;		   
parameter WC5 = 16'h0005;    
parameter P1_DATA0=8'hAA,P1_DATA1=8'hBB,P1_DATA2=8'hCC,P1_DATA3=8'h05,P1_DATA4=8'h06;
/******************************************************************************/
`endif


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
output[7:0] test;




reg [23:0] mipi_periph_rx_cmd_d;
reg  mipi_periph_rx_cmd_valid_d;
reg  mipi_periph_tx_payload_en_d;
reg  mipi_periph_tx_payload_en_last_d;
reg  mipi_periph_dphy_direction_d;


always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_rx_cmd_d 			 <= 1'b0;
		mipi_periph_rx_cmd_valid_d 		 <= 1'b0;
		mipi_periph_tx_payload_en_d 	 <= 1'b0;
		mipi_periph_tx_payload_en_last_d <= 1'b0;
		mipi_periph_dphy_direction_d 	 <= 1'b0;
	end else begin
		mipi_periph_rx_cmd_d 			 <= mipi_periph_rx_cmd;
		mipi_periph_rx_cmd_valid_d 		 <= mipi_periph_rx_cmd_valid;
		mipi_periph_tx_payload_en_d 	 <= mipi_periph_tx_payload_en;
		mipi_periph_tx_payload_en_last_d <= mipi_periph_tx_payload_en_last;
		mipi_periph_dphy_direction_d 	 <= mipi_periph_dphy_direction;
	end
end





assign test[0]=mipi_periph_dphy_direction_f;
assign test[4]=mipi_periph_tx_cmd_req;
assign test[5]=mipi_periph_tx_cmd_ack;

reg  mipi_periph_dphy_direction_dd;
wire  mipi_periph_dphy_direction_f;
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_dphy_direction_dd <= 1'b0;
	end else begin
		mipi_periph_dphy_direction_dd     <= mipi_periph_dphy_direction_d;
	end
end


assign mipi_periph_tx_cmd_vc = 2'd0;

`ifdef BTA_REG
reg [7:0]  s_wc;
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn)
		s_wc <= 8'h1;
	else if(mipi_periph_rx_cmd_valid_d && mipi_periph_rx_cmd_d[5:0]==6'h37)
		s_wc = mipi_periph_rx_cmd_d[15:8];
end

always @(posedge clk_periph or negedge rstn) begin
	if(!rstn)
		mipi_periph_tx_cmd_data_type  <= 6'd0;
	else 
		case(s_wc)
			8'h0: mipi_periph_tx_cmd_data_type  <= 6'h02;
			8'h1: mipi_periph_tx_cmd_data_type  <= 6'h21;
			8'h2: mipi_periph_tx_cmd_data_type  <= 6'h22;
			default:mipi_periph_tx_cmd_data_type  <= 6'h1C;
		endcase
end


always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_cmd_byte_count <= 16'd0;
		mipi_periph_tx_payload <= 32'd0;
	end else begin
		if(mipi_periph_rx_cmd_valid_d && (mipi_periph_rx_cmd_d[5:0]==6'h06 || mipi_periph_rx_cmd_d[5:0]==6'h14)) begin
			case(mipi_periph_rx_cmd_d[15:8])
				CHANGE_REG0: begin
					mipi_periph_tx_cmd_byte_count <= 16'H0081;
					mipi_periph_tx_payload <= 32'd0;
				end 
				CHANGE_REG1: begin
					mipi_periph_tx_cmd_byte_count <= 16'H0011;
					mipi_periph_tx_payload <= 32'd0;
				end 
				CHANGE_REG2: begin
					mipi_periph_tx_cmd_byte_count <= 16'H0042;
					mipi_periph_tx_payload <= 32'd0;
				end 
				CHANGE_REG9:
				begin
					mipi_periph_tx_cmd_byte_count <= 16'H009E;
					mipi_periph_tx_payload <= 32'd0;
				end
				// CHANGE_REG8:
				// begin
					// mipi_periph_tx_cmd_byte_count <= 16'H00C0;
					// mipi_periph_tx_payload <= 32'd0;
				// end
				CHANGE_REGA:
				begin
					mipi_periph_tx_cmd_byte_count <= {8'h0,s_wc};
					mipi_periph_tx_payload <= {8'h00,8'h42,8'h11,8'h81};
				end
				default: begin
					if(s_wc>=3)
					begin
						mipi_periph_tx_cmd_byte_count <= {8'h0,s_wc};
						mipi_periph_tx_payload <= {8'h27,8'h0E,8'h07,8'h61};
					end
					else
					begin
						mipi_periph_tx_cmd_byte_count <= 16'H0000;
						mipi_periph_tx_payload <= 32'd0;
					end
				end
			endcase
		end
	end
end
`endif





`ifdef READ_ID
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_cmd_data_type  <= 6'd0;
		mipi_periph_tx_cmd_byte_count <= 16'd0;
		mipi_periph_tx_payload <= 32'd0;
	end else begin
		if(mipi_periph_rx_cmd_valid_d && (mipi_periph_rx_cmd_d[5:0]==6'h06 || mipi_periph_rx_cmd_d[5:0]==6'h14)) begin
			if(mipi_periph_rx_cmd_d[15:8]==RDID_AR0) begin
				mipi_periph_tx_cmd_data_type  <= DATA_TYPE0;
				mipi_periph_tx_cmd_byte_count <= WC0;
				mipi_periph_tx_payload <= 32'd0;
			end else if(mipi_periph_rx_cmd_d[15:8]==RDID_AR1) begin
				mipi_periph_tx_cmd_data_type  <= DATA_TYPE1;
				mipi_periph_tx_cmd_byte_count <= WC1;
				mipi_periph_tx_payload <= 32'd0;
			end else if(mipi_periph_rx_cmd_d[15:8]==RDID_AR2) begin
				mipi_periph_tx_cmd_data_type  <= DATA_TYPE2;
				mipi_periph_tx_cmd_byte_count <= WC2;
				mipi_periph_tx_payload <= 32'd0;
			end 
		end
	end
end
`endif



`ifdef ESD_CHECK
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_cmd_data_type  <= 6'd0;
		mipi_periph_tx_cmd_byte_count <= 16'd0;
		mipi_periph_tx_payload <= 32'd0;
	end else begin
		if(mipi_periph_rx_cmd_valid_d && (mipi_periph_rx_cmd_d[5:0]==6'h06 || mipi_periph_rx_cmd_d[5:0]==6'h14)) begin
			if(mipi_periph_rx_cmd_d[15:8]==RDID_AR3) begin
				mipi_periph_tx_cmd_data_type  <= DATA_TYPE3;
				mipi_periph_tx_cmd_byte_count <= WC3;
				mipi_periph_tx_payload <= 32'd0;
			end
		end
	end
end
`endif


`ifdef TX_DATA

reg [BUFFER_SIZE*8-1:0] tx_buff;
reg [3:0] packageNum;
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		packageNum <= 4'd0;
	end else begin
		if(mipi_periph_tx_payload_en_last_d && packageNum < PACKAGE_NUM)
			packageNum <= packageNum + 4'd1;
	end
end

reg [COUNT_BIT_SIZE-1:0] byteCnt;    //!!!!!!!!其BYTE数不能超过16
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_payload <= 32'd0;
		byteCnt <= 4'd0;
	end else begin
		if(mipi_periph_tx_payload_en_d) begin 
			mipi_periph_tx_payload <= tx_buff[(byteCnt+1)*32-1:byteCnt*32];
			if(mipi_periph_tx_payload_en_last_d)	byteCnt <= 4'd0;
			else								byteCnt <= byteCnt + 4'd1;
		end

	end
end



always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_cmd_data_type  <= 6'd0;
		mipi_periph_tx_cmd_byte_count <= 16'd0;
		tx_buff <= (BUFFER_SIZE*8)'d0;
	end else begin
		if(mipi_periph_rx_cmd_valid_d && (mipi_periph_rx_cmd_d[5:0]==6'h06 || mipi_periph_rx_cmd_d[5:0]==6'h14)) begin
			case(packageNum)
				4'd0:begin
						mipi_periph_tx_cmd_data_type  <= DATA_TYPE4;
						mipi_periph_tx_cmd_byte_count <= WC4;
						tx_buff <= {P0_DATA9,P0_DATA8,P0_DATA7,P0_DATA6,P0_DATA5,P0_DATA4,P0_DATA3,P0_DATA2,P0_DATA1,P0_DATA0};	 //BUFFER_SIZE=10 				
					end
				4'd1:begin
						mipi_periph_tx_cmd_data_type  <= DATA_TYPE5;
						mipi_periph_tx_cmd_byte_count <= WC5;
						tx_buff <= {{(BUFFER_SIZE*8-40){1'b0}},P1_DATA4,P1_DATA3,P1_DATA2,P1_DATA1,P1_DATA0};   // BUFFER_SIZE=10 
					end
				default:begin
						mipi_periph_tx_cmd_data_type  <= 6'd0;
						mipi_periph_tx_cmd_byte_count <= 16'd0;
						tx_buff <= (BUFFER_SIZE*8)'d0;
					end
			endcase
		end
	end
end


`endif



assign mipi_periph_dphy_direction_f= mipi_periph_dphy_direction_dd&(!mipi_periph_dphy_direction_d);
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

