// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 05/16/2019 11:35:27   
// Design Name:
// Module Name: spi_flash
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
module spi_flash(
//system
input rst_n,
input clk,     //输入时钟频率CLK为SCLK的两倍以上，建议为80MHZ~100MHZ
//spi
input cson,
input sclk,
inout sdi, 
output sdo	

);

	reg s_decode_mosi;
	
	wire i_spi_flash_miso;
	wire o_spi_flash_mosi2;
	wire o_spi_flash_cs;
	wire o_spi_flash_clk;
	wire o_spi_flash_mosi;
	reg s_spi_dir;
	assign sdo   = i_spi_flash_miso;
	assign o_spi_flash_cs   = cson;
	assign o_spi_flash_clk  = sclk;
	assign o_spi_flash_mosi = s_decode_mosi? 1'b1 : sdi;
	assign sdi = s_spi_dir? o_spi_flash_mosi2 : 1'bz;
	
	reg s_spi_clk;
	reg s_spi_clk_d1;
	reg s_spi_clk_d2;
	
	reg s_spi_cs;
	reg s_spi_cs_d1;
	reg s_spi_cs_d2;
	
	reg s_spi_mosi;
	reg s_spi_mosi_d1;
	reg s_spi_mosi_d2;
	always @(posedge clk)
	begin
		s_spi_clk     <= sclk;
		s_spi_cs      <= cson;
		s_spi_mosi    <= sdi;
		
		s_spi_clk_d1  <= s_spi_clk; 
		s_spi_cs_d1   <= s_spi_cs;  
		s_spi_mosi_d1 <= s_spi_mosi;
		
		s_spi_clk_d2  <= s_spi_clk_d1; 
		s_spi_cs_d2   <= s_spi_cs_d1;  
		s_spi_mosi_d2 <= s_spi_mosi_d1;
	end
	
	
	reg [7:0] s_spi_clk_count;
	always @(posedge clk)
	begin
		if(s_spi_cs_d2)
			s_spi_clk_count <= 8'h0;
		else if(!s_spi_clk_d2 && s_spi_clk_d1 && s_spi_clk_count <= 8'hf0)
			s_spi_clk_count <= s_spi_clk_count + 8'h1;
	end
	
	reg [7:0] s_spi_shift;
	always @(posedge clk)
	begin
		if(s_spi_cs_d2)
			s_spi_shift <= 8'h0;
		else if(!s_spi_clk_d2 && s_spi_clk_d1)
			s_spi_shift <= {s_spi_shift[6:0],s_spi_mosi_d2};
	end
	
	reg [7:0] s_spi_cmd;
	always @(posedge clk)
	begin
		if(s_spi_cs_d2)
			s_spi_cmd <= 8'h0;
		else if(s_spi_clk_count == 8'h8)
			s_spi_cmd <= s_spi_shift;
	end
	
	always @(posedge clk)
	begin
		if(s_spi_cs_d2)
			s_decode_mosi <= 1'b0;
		else if((s_spi_cmd == 8'h03 || s_spi_cmd == 8'h0B||s_spi_cmd == 8'h3B) && s_spi_clk_count == 8'hd)
			s_decode_mosi <= 1'b1;
		else
			s_decode_mosi <= 1'b0;
	end
	
	reg s_spi_dir;
	always @(posedge clk)
	begin
		if(s_spi_cs_d2)
			s_spi_dir <= 1'b0;
		else if(s_spi_cmd == 8'h3B && s_spi_clk_count >= 8'd38)
			s_spi_dir <= 1'b1;
	end

spiInterface_v1 uut_spiInterface_v1(
.sclk(o_spi_flash_clk),
.sdo(i_spi_flash_miso),
.cson(o_spi_flash_cs),
.sdi_in(o_spi_flash_mosi),
.sdi_oen(!s_spi_dir),
.sdi_out(o_spi_flash_mosi2 )
);



endmodule
