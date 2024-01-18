module mcu_arbiter(                               
	input          cpuclk		,
	input          rstn		    ,
	input  [22:0]  memaddr_comb ,
	input  [7:0]   memdatao_comb,
	input          memrd_comb   ,
	input          memwr_comb   ,
	input          mempsrd_comb ,
    input          mempswr_comb ,
		
	output         memack,
	output [7:0]   memdatai,
	output         mempsack,
//8051 to mipi apb    
	input  [31:0] 	 prdata,
	input            pready,
	output [19:0] 	 paddr_mst,
	output           pwrite,
	output [31:0] 	 pwdata,
	output           psel,
//8051 extended register	
	//output reg[15:0]  dnum,
    //output reg[7:0] dset,
    //output reg[7:0]  cmd,
    
    output reg[7:0]  func,
// func[0] control sel; 1= enable
// func[1]  hs mode sel; 1= hs mode
// func[2]  pfifo rstn; low active
// func[3]  fifo read start

    input fifo_rclk,
    input fifo_rd,
    output [31:0] fifo_rdata,
    output reg       mipi_sel,
	
/*****************windown set********************/
	input  wd_rdy,
	input [7:0] wd_2a_dats_l,
	input [7:0] wd_2a_dats_h,
	input [7:0] wd_2a_date_l,
	input [7:0] wd_2a_date_h,
	input [7:0] wd_2b_dats_l,
	input [7:0] wd_2b_dats_h,
	input [7:0] wd_2b_date_l,
	input [7:0] wd_2b_date_h,
	
	output reg busy
);

	

reg code_sel;
reg data_sel;
reg apb_sel;
reg reg_sel;

//8051 to mipi apb   
wire apb_memack;
wire[7:0] memdatai_apb;
wire ahbrd;
wire ahbwr;

//8051 extended register
wire reg_rd;
wire reg_wr;
wire fifo_wr;
wire fifo_wr_p;
reg fifo_wr_d;
reg reg_memack;
reg[7:0] reg_din;

wire [31:0] rdata;
reg [31:0] fifo_rdata_d;

//8051 to sram  
wire ram_ack;
wire[7:0] memdatai_ram;
wire ramrd;
wire ramwr;

reg fifo_clr_s;
reg fifo_clr_f;
reg fifo_clr_d;

always @ (posedge cpuclk) begin
	apb_sel <= memaddr_comb[17]&(!memaddr_comb[11]) ;
end

always @ (posedge cpuclk) begin
	reg_sel <= memaddr_comb[17]&memaddr_comb[11] ;
end

always @ (posedge cpuclk) begin
	code_sel <= mempsrd_comb|mempswr_comb;
end

always @ (posedge cpuclk) begin
	data_sel <= memrd_comb|memwr_comb;
end   


assign memack=	reg_sel?reg_memack:
                apb_sel? apb_memack:
				data_sel?ram_ack:1'b0;
				
assign mempsack=code_sel?ram_ack:1'b0;				
				
assign memdatai=reg_sel?reg_din:
				apb_sel? memdatai_apb:memdatai_ram;				


//8051 to mipi apb   
assign ahbrd=memaddr_comb[17]&(!memaddr_comb[11])&memrd_comb;	
assign ahbwr=memaddr_comb[17]&(!memaddr_comb[11])&memwr_comb;

emif2apb u_emif2apb (
			.clk             (cpuclk),  
			.rst_n           (rstn),

			.memack     (apb_memack),
			.memdatai     (memdatai_apb),            //Memory data input
			.memaddr (memaddr_comb),        //memory address
			.memdatao(memdatao_comb),       //memory data output
			.memrd (ahbrd),        //program store read enable
			.memwr (ahbwr),       //program store write enable

			.fpga_HRDATA     (prdata),
			.fpga_HREADY     (pready),
			.fpga_HADDR      (paddr_mst),
			.fpga_HWRITE     (pwrite),
			.fpga_HWDATA     (pwdata),
			.fpga_HSEL       (psel),
			.interrupt		  () 	
           );


//8051 extended register
assign reg_rd=memaddr_comb[17]&memaddr_comb[11]&memrd_comb;	
assign reg_wr=memaddr_comb[17]&memaddr_comb[11]&memwr_comb;
assign fifo_wr=memaddr_comb[17]&memaddr_comb[11]&memwr_comb&(memaddr_comb[3:0] == 0);

always @(posedge cpuclk or negedge rstn) begin
    if(!rstn)
        fifo_wr_d <= 0;
    else
        fifo_wr_d <= fifo_wr;
end
assign fifo_wr_p = ~fifo_wr_d&&fifo_wr;

always @(posedge cpuclk or negedge rstn)
begin
  if (!rstn)
		reg_memack<=1'b0;
	else if(reg_wr|reg_rd)
		reg_memack<=1'b1;
	else
		reg_memack<=1'b0;
end

always @(posedge cpuclk or negedge rstn)
begin
  if(!rstn)
	 begin
      reg_din  <=8'b0;
	 end
    else if (reg_rd) begin
      case (memaddr_comb[3:0])	
      4'd1: reg_din<=mipi_sel;	
      4'd2: reg_din<=func;	
	  4'd3:	reg_din <= wd_rdy_d;
	  4'd4:	reg_din <= wd_2a_dats_l_d;
	  4'd5: reg_din <= wd_2a_dats_h_d;
	  4'd6: reg_din <= wd_2a_date_l_d;
	  4'd7: reg_din <= wd_2a_date_h_d;
	  4'd8:	reg_din <= wd_2b_dats_l_d;
	  4'd9: reg_din <= wd_2b_dats_h_d;
	  4'd10: reg_din <= wd_2b_date_l_d;
	  4'd11: reg_din <= wd_2b_date_h_d;
      default: reg_din<=0;
	endcase
end
end


always @(posedge cpuclk or negedge rstn)
begin
  if(!rstn)
	 begin
	  func  <=8'b0;
	  mipi_sel <=1'b0;
	 end
    else if (reg_wr) begin
      case (memaddr_comb[3:0])
	  //4'd0: dnum[7:0]<=memdatao_comb;
	  4'd1: mipi_sel<=memdatao_comb[0];
	  4'd2: func<=memdatao_comb;
	  4'd12: busy <= memdatao_comb[0];
	endcase
end
end

//8051 to sram  
assign ramrd=(!memaddr_comb[17])&memrd_comb;	
assign ramwr=(!memaddr_comb[17])&memwr_comb;

psram_wrap u_psram(
	. memack	(ram_ack),
	. memdatai	(memdatai_ram),
	. memaddr	(memaddr_comb),
	. memdatao	(memdatao_comb),
	. memrd		(mempsrd_comb|ramrd),
	. memwr		(mempswr_comb|ramwr),
	. clkin		(cpuclk),
	. rstn		(rstn)
);

//FIFO access
always @ (posedge cpuclk or negedge rstn) begin
	if (!rstn) begin
		fifo_clr_f<=1'b0;
		fifo_clr_s<=1'b0;
		fifo_clr_d<=1'b0;
	end
	else begin
		fifo_clr_f<=func[2];
		fifo_clr_s<=fifo_clr_f;
		fifo_clr_d<=fifo_clr_s;
	end
end 
assign fifo_clr = fifo_clr_s&(!fifo_clr_d);

fifo_pdata u_pfifo(
    .wclk           (cpuclk),
    .wrst_n			(~fifo_clr&rstn),
    .wdata			(memdatao_comb),
    .wen			(fifo_wr_p),
	.wclr			(1'b0),
    .prog_full		(),
    .wfull			(),

    .rclk           (fifo_rclk),
    .rrst_n			(~fifo_clr&rstn),
    //.rdata			(fifo_rdata),
    .rdata			(rdata),
    .ren			(fifo_rd),
    .rclr			(1'b0),
    .prog_empty		(),
    .rempty			()
);

always @ (posedge fifo_rclk or negedge rstn) begin
	if (!rstn)
        fifo_rdata_d<=0;
    else
        fifo_rdata_d <= rdata;
end

assign fifo_rdata = fifo_rdata_d;
//assign fifo_rdata = rdata;


/***************************************************************/
reg  wd_rdy_d;
reg [7:0] wd_2a_dats_l_d;
reg [7:0] wd_2a_dats_h_d;
reg [7:0] wd_2a_date_l_d;
reg [7:0] wd_2a_date_h_d;
reg [7:0] wd_2b_dats_l_d;
reg [7:0] wd_2b_dats_h_d;
reg [7:0] wd_2b_date_l_d;
reg [7:0] wd_2b_date_h_d;
	
	
always @ (posedge cpuclk or negedge rstn) begin
	if (!rstn) begin
		wd_rdy_d 	   <= 0;
		wd_2a_dats_l_d <= 0;
		wd_2a_dats_h_d <= 0;
		wd_2a_date_l_d <= 0;
		wd_2a_date_h_d <= 0;
		wd_2b_dats_l_d <= 0;
		wd_2b_dats_h_d <= 0;
		wd_2b_date_l_d <= 0;
		wd_2b_date_h_d <= 0;
	end
	else begin
		wd_rdy_d 	   <= wd_rdy;
		wd_2a_dats_l_d <= wd_2a_dats_l;
		wd_2a_dats_h_d <= wd_2a_dats_h;
		wd_2a_date_l_d <= wd_2a_date_l;
		wd_2a_date_h_d <= wd_2a_date_h;
		wd_2b_dats_l_d <= wd_2b_dats_l;
		wd_2b_dats_h_d <= wd_2b_dats_h;
		wd_2b_date_l_d <= wd_2b_date_l;
		wd_2b_date_h_d <= wd_2b_date_h;
	end
end 
/***************************************************************/

endmodule	