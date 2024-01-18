
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
module dataReadBack_fifo(
	clk_periph,
	rstn,
//////	periph	
	mipi_periph_rx_cmd,
	mipi_periph_rx_cmd_valid,

	
	bta_clk,
	bta_rd,
	bta_data,

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
	
output [31:0] mipi_periph_tx_payload;
output [1:0] mipi_periph_tx_cmd_vc;
output reg [5:0] mipi_periph_tx_cmd_data_type;
output reg [15:0] mipi_periph_tx_cmd_byte_count;
output reg mipi_periph_tx_cmd_req;

output bta_clk;
output bta_rd;
input [31:0] bta_data;

wire  mipi_periph_dphy_direction_f;
wire  mipi_periph_dphy_direction_r;
reg  mipi_periph_dphy_direction_d;
wire cmd_load;
reg[2:0] dir_f;

assign mipi_periph_tx_cmd_vc = 2'd0;

assign bta_clk=clk_periph;
assign bta_rd=mipi_periph_dphy_direction_f|mipi_periph_tx_payload_en;
assign mipi_periph_tx_payload=bta_data;
//****************************************************************************//
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_cmd_data_type <= 6'b0;
	end else if(cmd_load)
		mipi_periph_tx_cmd_data_type  <= bta_data[5:0];
end



always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_tx_cmd_byte_count <= 16'b0;
	end else if(cmd_load)
		mipi_periph_tx_cmd_byte_count  <= bta_data[23:8];
end


assign cmd_load=dir_f[1];

//****************************************************************************//
always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		mipi_periph_dphy_direction_d <= 1'b0;
	end else begin
		mipi_periph_dphy_direction_d     <= mipi_periph_dphy_direction;
	end
end

assign mipi_periph_dphy_direction_f= mipi_periph_dphy_direction_d&(!mipi_periph_dphy_direction);


always @(posedge clk_periph or negedge rstn) begin
	if(!rstn) begin
		dir_f <= 3'b0;
	end else
		dir_f  <= {dir_f[1:0],mipi_periph_dphy_direction_f};
end

always @ (posedge clk_periph or negedge rstn) begin
	if (!rstn) begin
		mipi_periph_tx_cmd_req<=1'b0;
	end
	else if(dir_f[2])
		mipi_periph_tx_cmd_req<=1'b1;
	else if(mipi_periph_tx_cmd_ack)
		mipi_periph_tx_cmd_req<=1'b0;
end


endmodule


