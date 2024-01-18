//-----------------------------------------------------------------------------
//
// Title       : mipi_host
// Design      : h6_sim
// Author      : Bauer
// Company     : bw
//
//-----------------------------------------------------------------------------
//
// File        : d:\My_Designs\h6_sim\h6_sim\src\mipi_host.v
// Generated   : Sun Dec  8 13:57:06 2019
// From        : interface description file
// By          : Itf2Vhdl ver. 1.22
//
//-----------------------------------------------------------------------------
//
// Description : 
//
//-----------------------------------------------------------------------------
`timescale 1 ns / 1 ps

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {mipi_host}}
module mipi_host (	  
    input reset_n,    
    input clk,
    
    output            RxActiveHS,
    output reg [23:0] periph_rx_cmd,
    output reg        periph_rx_cmd_valid,
    output reg [31:0] periph_rx_payload,
    output reg        periph_rx_payload_valid,
    output reg        periph_rx_payload_valid_last,
	  output lp_o_p,
	  output lp_o_n
);

   



parameter HFP = 16'd60;
parameter HSP = 16'd6;
parameter HBP = 16'd100;
parameter H_VAL = 16'd1080;
parameter H_TOTAL = HSP + HBP + H_VAL + HFP;

parameter VFP = 16'd10;
parameter VSP = 16'd6;
parameter VBP = 16'd20;
parameter V_VAL = 16'd1920;
parameter V_TOTAL = VSP + VBP + V_VAL + VFP;


reg      start;    
reg[1:0] lp_out;
//wire     lp_o_p;
//wire     lp_o_n;
reg      hs_start;

wire     host_dpi_hsync;
wire     host_dpi_vsync;
wire     host_dpi_de;
wire [23:0] host_dpi_d;  

reg vsync_tx;
reg vsync_tx_s;
wire vsync_r;
wire vsync_n;
reg hsync_tx;
reg hsync_tx_s;
wire hsync_r; 
reg vf;

always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		lp_out<=2'b11;
	end
	else if(start)
	begin
		if(lp_out==2'b11)
			lp_out<=2'b01;
		else if(lp_out==2'b01)
			lp_out<=2'b00;			
	end
	else
		lp_out<=2'b11;
end

assign lp_o_p=lp_out[1];
assign lp_o_n=lp_out[0];   
  
always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		hs_start<=1'b0;
	end
	else if(lp_o_p&lp_o_n)
		hs_start<=1'b0;
	else if(!(lp_o_p|lp_o_n))
		hs_start<=1'b1;
end    
  
assign RxActiveHS=hs_start;


/*******************************************************/
reg pclk;
always @(posedge clk or negedge reset_n) begin
	if (!reset_n) begin
		pclk<=1'b0;
	end
		pclk = ~pclk;
end 


pattern_gen #(
	.H_TOTAL(H_TOTAL),
	.H_VAL(H_VAL),
	.HFP(HFP),
	.HSP(HSP),
	.HBP(HBP),
	.V_TOTAL(V_TOTAL),
	.V_VAL (V_VAL),
	.VFP(VFP),
	.VSP(VSP),
	.VBP(VBP))

pgen(
	.px_clk(pclk),  
	.hsync(host_dpi_hsync),
	.vsync(host_dpi_vsync),
	.dval(host_dpi_de),
	.px_data(host_dpi_d),
	.key(),
	.rstn(reset_n),  
	.line_en()
);	
   
   



always @(posedge clk or negedge reset_n)
begin
	if(!reset_n)
		begin
		vsync_tx<=1'b0;
		vsync_tx_s<=1'b0;
		end
	else begin
		vsync_tx<=host_dpi_vsync;
		vsync_tx_s<=vsync_tx;
	end
end

assign vsync_r= vsync_tx&(!vsync_tx_s);
assign vsync_n= (!vsync_tx)&vsync_tx_s;

always @(posedge clk or negedge reset_n)
begin
	if(!reset_n)
		begin
		hsync_tx<=1'b0;
		hsync_tx_s<=1'b0;
		end
	else begin
		hsync_tx<=host_dpi_hsync;
		hsync_tx_s<=hsync_tx;
	end
end

assign hsync_r= hsync_tx&(!hsync_tx_s);


initial begin
periph_rx_cmd = 0;
periph_rx_cmd_valid = 0;
periph_rx_payload_valid = 0;
periph_rx_payload_valid_last = 0;	
test_video_packet;
test_video_packet;
test_video_packet;
test_video_packet;
test_video_packet;
test_video_packet;
test_video_packet;
test_video_packet;
test_video_packet;
test_video_packet;

	
end	
	

task test_video_packet; 
integer i; 
begin  	
	start = 1'b0;
	//send_short_packet(2'h0, 6'h06, 16'h000a);
	wait(vsync_r);
	start = 1'b1;
	#100;
	@(posedge clk);
	send_short_packet(2'h0, 6'h01, 16'h0000);
	send_long_packet (2'h0, 6'h19, HSP);
	send_short_packet(2'h0, 6'h31, 16'h0000);
	//send_short_packet(2'h0, 6'h08, 16'h0f0f);
	#150;
	start = 1'b0;
	
	for(i=0;i<VSP-1;i=i+1) begin
	wait(hsync_r);
	start = 1'b1;
	#100;
	@(posedge clk);
	send_short_packet(2'h0, 6'h21, 16'h0000);
	send_long_packet (2'h0, 6'h19, HSP);
	send_short_packet(2'h0, 6'h31, 16'h0000);
	//send_short_packet(2'h0, 6'h08, 16'h0f0f);
	#150;
	start = 1'b0;
	end
	
	wait(vsync_n);
	start = 1'b1;
	#100;
	@(posedge clk);
	send_short_packet(2'h0, 6'h11, 16'h0000);
	send_long_packet (2'h0, 6'h19, HSP);
	send_short_packet(2'h0, 6'h31, 16'h0000);
	//send_short_packet(2'h0, 6'h08, 16'h0f0f);
	#150;
	start = 1'b0;
		
	for(i=0;i<VBP-1;i=i+1) begin
	wait(hsync_r);
	start = 1'b1;
	#100;
	@(posedge clk);
	send_short_packet(2'h0, 6'h21, 16'h0000);
	send_long_packet (2'h0, 6'h19, HSP);
	send_short_packet(2'h0, 6'h31, 16'h0000);
	//send_short_packet(2'h0, 6'h08, 16'h0f0f);
	#150;
	start = 1'b0;
	end
	
	wait(hsync_r);
	start = 1'b1;
	#100;
	for(i=0;i<V_VAL;i=i+1) begin	
	@(posedge clk);
	send_short_packet(2'h0, 6'h21, 16'h0000);
	send_long_packet (2'h0, 6'h19, HSP);
	send_short_packet(2'h0, 6'h31, 16'h0000);
	send_long_packet (2'h0, 6'h19, HBP);
	send_long_packet (2'h0, 6'h3E, H_VAL*3);
	send_long_packet (2'h0, 6'h19, HFP);
	send_short_packet(2'h0, 6'h31, 16'h0000);
	//send_short_packet(2'h0, 6'h08, 16'h0f0f);
	end
	#150;
	start = 1'b0;
		
	for(i=0;i<VFP-4;i=i+1) begin
	wait(hsync_r);
	start = 1'b1;
	#100;
	@(posedge clk);
	send_short_packet(2'h0, 6'h21, 16'h0000);
	send_long_packet (2'h0, 6'h19, HSP);
	send_short_packet(2'h0, 6'h31, 16'h0000);
	//send_short_packet(2'h0, 6'h08, 16'h0f0f);
	#150;
	start = 1'b0;
	end
	

		
end	
endtask  


task send_short_packet;                                                                                                                                                                                                             
     input [1:0]         vc;                                                                                                                                                                                                                                                                                                                                                  
     input [5:0]         data_type;                                                                                                                                                                                                                                                        
     input [15:0]        data_field;                                                                                                                                                                                                                                                       
         begin                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                 periph_rx_cmd = {data_field, vc, data_type};                                                                                                                                                                                                                                 
                 periph_rx_cmd_valid  = 1'b1;
                 @(posedge clk);
                 periph_rx_cmd_valid  = 1'b0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
         end                                                                                                                                                                                                                                                                               
     endtask   
     
task send_long_packet;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
      input [1:0]         vc;                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
      input [5:0]         data_type;                                                                                                                                        
      input [15:0]        wc;                                                                                                                                                                                                                                                                                                                                                                                     
      reg [31:0]          tx_data;                                                                                                                                                                                                                                                                                                                                                                                                          
          begin                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                                                                                     
              periph_rx_cmd = {wc, vc, data_type}; 
              periph_rx_cmd_valid  = 1'b1;
              @(posedge clk);
              periph_rx_cmd_valid  = 1'b0;  
                                                                                                                                                                                                  
              if (wc<5) begin
              periph_rx_payload_valid  = 1'b1;
              periph_rx_payload_valid_last  = 1'b1;
              @(posedge clk);
               periph_rx_payload_valid  = 1'b0;
              periph_rx_payload_valid_last  = 1'b0;
              end
              
              if (wc>=5) begin
              periph_rx_payload_valid  = 1'b1;
              periph_rx_payload_valid_last  = 1'b0;
              repeat((wc-1)/4) @(posedge clk);
              periph_rx_payload_valid  = 1'b1;
              periph_rx_payload_valid_last  = 1'b1;
              @(posedge clk);
              periph_rx_payload_valid  = 1'b0;
              periph_rx_payload_valid_last  = 1'b0;
              end
          end                                                                 
      endtask 
      
      

always @(posedge clk or negedge reset_n)                                                                                                                                                                                                          
  if(reset_n == 1'b0) begin                                                           
     vf <= 1'b0;                                                 
  end else begin                                                           
    if(periph_rx_cmd_valid&(periph_rx_cmd[5:0]==6'h3e&&periph_rx_cmd[23:8]==H_VAL*3))
      vf <= 1'b1;
    else if(periph_rx_payload_valid_last) 
      vf <= 1'b0;                                                                                 
  end
                   
      
      
 always @(posedge clk or negedge reset_n)                                                                                                                                                                                                          
              if(reset_n == 1'b0)                                             
              begin                                                           
                  periph_rx_payload      <= 32'd0;                                                            
              end                                                             
              else                                                            
              begin                                                           
                  if(periph_rx_cmd_valid)                 
                      periph_rx_payload      <= 32'd0;                                                  
                  else if(periph_rx_payload_valid&vf)                                            
                      periph_rx_payload <= periph_rx_payload + 32'd1; //32'h3A_e1_3A_23;                                                                                 
              end 
              
                                          
     

endmodule
