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
 //**********************************************************//
//psram ctrl 
    output reg[7:0]  psram_ctrl,
//	psram_ctrl[7]  rdfifo_rd
	output reg[15:0] psram_wdata,
	output[15:0] psram_wdata0,
	output[15:0] psram_wdata1,
	output reg[20:0] psram_addr,
	input[15:0] psram_rdata0,
	input[15:0] psram_rdata1,


	input psram_rd_val0,
	input psram_rd_val1,
	input psram_clk,
    input psram_data_load0,
    input psram_data_load1,
    input psram_finish,
    input ltcy_mode0,
    input ltcy_mode1,

 //**********************************************************//	
    output reg[7:0]  func,
// func[0] control sel; 1= enable
// func[1]  hs mode sel; 1= hs mode
// func[2]  pfifo rstn; low active
// func[3]  fifo read start

    input fifo_rclk,
    input fifo_rd,
    output [31:0] fifo_rdata,
    output [7:0] test,
	output fifo_rst,
	
	input bta_clk,
    input bta_rd,
    output [31:0] bta_data,

	output ps_ck,
	output ps_dir,
	output ps_en,
	output [5:0] pssel,
	
    output reg       mipi_sel
	
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
reg[7:0] pll_phase_adj;

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
wire fifo_rst;

wire psram_wr;
wire psram_wr_en;
reg psram_w_f;
wire[7:0] psram_rdata_mcu;
wire[7:0] psram_rdata_mcu1;
wire psram_rd_en;
reg psram_rd_en_f;
reg psram_rd_en_s;
reg psram_finish_mcu_f;
reg psram_finish_mcu_s;
wire psram_fifo_rstn;
reg ps_en_s;

reg[2:0] ltcy_s0;
reg[2:0] ltcy_s1;
reg ltcy_det0;
reg ltcy_det1;
wire ltcy_clr;
reg[7:0] psram_ltcy_set;
wire bta_fifo_wr;
reg bta_fifo_s;
wire bta_fifo_wr_en;
reg[5:0] bta_addr;

reg psram_rd_val0_s;
wire psram_rd_val0_r;
reg psram_rd_val1_s;
wire psram_rd_val1_r;
reg[15:0] psram_rdata0_s;
reg[15:0] psram_rdata1_s;

//******************************************************************//
//******************************************************************//
//******************************************************************//

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
//******************************************************************//
//******************************************************************//
//******************************************************************//

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

//******************************************************************//
//******************************************************************//
//******************************************************************//

//8051 extended register


assign reg_rd=memaddr_comb[17]&memaddr_comb[11]&memrd_comb;	
assign reg_wr=memaddr_comb[17]&memaddr_comb[11]&memwr_comb;
assign fifo_wr=memaddr_comb[17]&memaddr_comb[11]&memwr_comb&(memaddr_comb[3:0] == 0);
// assign bta_fifo_wr=memaddr_comb[17]&memaddr_comb[11]&memwr_comb&(memaddr_comb[3:0] == 4'd15);
// assign psram_wr=memaddr_comb[17]&memaddr_comb[11]&memaddr_comb[7]&memwr_comb;


// always @(posedge cpuclk or negedge rstn) begin
    // if(!rstn)
        // psram_w_f <= 0;
    // else
        // psram_w_f <= psram_wr;
// end
// assign psram_wr_en = ~psram_w_f&&psram_wr;

always @(posedge cpuclk or negedge rstn) begin
    if(!rstn)
        fifo_wr_d <= 0;
    else
        fifo_wr_d <= fifo_wr;
end
assign fifo_wr_p = ~fifo_wr_d&&fifo_wr;

// always @(posedge cpuclk or negedge rstn) begin
    // if(!rstn)
        // bta_fifo_s <= 0;
    // else
        // bta_fifo_s <= bta_fifo_wr;
// end
// assign bta_fifo_wr_en = ~bta_fifo_s&&bta_fifo_wr;

//******************************************************************//
//******************************************************************//
//******************************************************************//

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
	  //4'd0: reg_din<=dnum[7:0];
	  //4'd1: reg_din<=dnum[15:8];
	  //4'd2: reg_din<=dset[7:0];	
	  //4'd3: reg_din<=cmd[7:0];	
      // 4'd1: reg_din<=mipi_sel;	
      4'd2: reg_din<=func;		
      4'd3: reg_din<=psram_ctrl;		
      // 4'd4: reg_din<=psram_addr[7:0];		
      // 4'd5: reg_din<=psram_addr[15:8];		
      // 4'd6: reg_din<=psram_addr[22:16];		
      // 4'd7: reg_din<=psram_rdata_mcu;		
      4'd7: reg_din<=psram_rdata0_s[7:0];		
      // 4'd9: reg_din<=psram_rdata_mcu1;		
      4'd9: reg_din<=psram_rdata0_s[15:8];
      4'd8: reg_din<={5'b0,ltcy_det1,ltcy_det0,psram_finish_mcu_s};		
      // 4'd10: reg_din<=pll_phase_adj;	
      4'd12: reg_din<=psram_rdata1_s[7:0];				
      4'd13: reg_din<=psram_rdata1_s[15:8];	  
      default: reg_din<=0;
	endcase
end
end


always @(posedge cpuclk or negedge rstn)
begin
  if(!rstn)
	 begin
      //dnum  <=16'b0;
      //dset  <=16'b0;
	  //cmd  <=8'b0;
	  func  <=8'b0;
	  mipi_sel <=1'b0;
	  psram_ctrl <=8'b0;
	  psram_ltcy_set <=8'b0;
	  pll_phase_adj <=8'b0;
	  psram_addr <=21'b0;
	  psram_wdata<=16'h0;
	 end
    else if (reg_wr) begin
      case (memaddr_comb[3:0])
	  //4'd0: mipi tx fifo
	  4'd1: mipi_sel<=memdatao_comb[0];
	  4'd2: func<=memdatao_comb;
	  4'd3: psram_ctrl<=memdatao_comb;
	  4'd4: psram_addr[7:0]<=memdatao_comb;
	  4'd5: psram_addr[15:8]<=memdatao_comb;
	  4'd6: psram_addr[20:16]<=memdatao_comb[4:0];
	  4'd7: psram_wdata[7:0]<=memdatao_comb;
	  4'd9: psram_wdata[15:8]<=memdatao_comb;
	  4'd10: pll_phase_adj<=memdatao_comb;
	  4'd11: psram_ltcy_set<=memdatao_comb;
	  // 4'd15: bta fifo 
	endcase
end
end


//******************************************************************//
//******************************************************************//
//******************************************************************//

assign ltcy_clr=psram_ltcy_set[7];

always @(posedge cpuclk or negedge rstn) begin
    if(!rstn)
        ltcy_s0 <= 3'b0;
    else
        ltcy_s0 <={ltcy_s0[1:0],ltcy_mode0};
end

always @(posedge cpuclk or negedge rstn) begin
    if(!rstn)
        ltcy_det0 <= 1'b0;
    else if(ltcy_s0[2])
        ltcy_det0 <= 1'b1;
	else if(ltcy_clr)
		ltcy_det0 <= 1'b0;
end

always @(posedge cpuclk or negedge rstn) begin
    if(!rstn)
        ltcy_s1 <= 3'b0;
    else
        ltcy_s1<={ltcy_s1[1:0],ltcy_mode1};
end

always @(posedge cpuclk or negedge rstn) begin
    if(!rstn)
        ltcy_det1 <= 1'b0;
    else if(ltcy_s1[2])
        ltcy_det1 <= 1'b1;
	else if(ltcy_clr)
		ltcy_det1 <= 1'b0;
end
	
//******************************************************************//
//******************************************************************//
//******************************************************************//
//pll adj


always @(posedge cpuclk or negedge rstn) begin
    if(!rstn)
        ps_en_s <= 1'b0;
    else
        ps_en_s <= pll_phase_adj[7];
end
assign ps_ck=cpuclk;
assign ps_dir=pll_phase_adj[6];
assign ps_en=~(pll_phase_adj[7]&(!ps_en_s));
assign pssel= ~pll_phase_adj[5:0];
//******************************************************************//
//******************************************************************//
//******************************************************************//
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

//******************************************************************//
//******************************************************************//
//******************************************************************//
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
//assign fifo_clr = fifo_clr_s&(!fifo_clr_d);
assign fifo_clr = fifo_clr_f;

assign fifo_rst=~(rstn&fifo_clr);
wire[3:0] null;
fifo_pdata u_pdata(
    .writeen(fifo_wr_p),
    .din({1'b0,memdatao_comb}),
    .writeclk(cpuclk),
	
	.dout({null,rdata}),
    .readclk(fifo_rclk),
    .readen(fifo_rd),
	
    .reset(fifo_rst),
    .full(),
    .empty()
);


//assign fifo_rdata = fifo_rdata_d;
assign fifo_rdata = rdata;

assign test[1]=fifo_wr_p;
assign test[2]=fifo_rst;
assign test[3]=fifo_rd;
assign test[7:4]=rdata[3:0];


//***************************************************************//
//***************************************************************//
//***************************************************************//

// always @ (posedge bta_clk or negedge rstn) begin
	// if (!rstn) begin
		// bta_addr<=6'b0;
	// end
	// else if(bta_rd)
	// begin
		// bta_addr<=bta_addr+1'b1;
	// end
// end 


// emb_bta  u_emb_bta(
	// .clk(bta_clk), 
	// .ce(1'b1), 
	// .we(1'b0), 
	// .rstn(rstn), 
	// .regce(1'b1), 
	// .a(bta_addr), 
	// .d(), 
	// .q(bta_data)
	// );
// fifo_bta u_fifo_bta(
    // .writeen(bta_fifo_wr_en),
    // .din({1'b0,memdatao_comb}),
    // .writeclk(cpuclk),
	
	// .dout(bta_data),
    // .readclk(bta_clk),
    // .readen(bta_rd),
	
    // .reset(~rstn),
    // .full(),
    // .empty()
// );
//***************************************************************//
//***************************************************************//
//***************************************************************//
//psram test

assign psram_fifo_rstn=psram_ctrl[6];
 always @(posedge cpuclk or negedge rstn)
 begin
   if (!rstn) begin
		 psram_finish_mcu_f<=1'b0;
		 psram_finish_mcu_s<=1'b0;
	 end
	 else begin
		 psram_finish_mcu_f<=psram_finish;
		 psram_finish_mcu_s<=psram_finish_mcu_f;
	 end
 end


// fifo_mcu_wr_ram u_psram_wdata0(
    // .wclk(cpuclk),
    // .rclk(psram_clk),
    // .rrst_n(psram_fifo_rstn),
    // .wrst_n(psram_fifo_rstn),
    // .wdata(memdatao_comb),
    // .rdata(psram_wdata0),
    // .wen(psram_wr_en),
    // .ren(psram_data_load0),
    // .rempty(),
    // .wfull()
// );

// fifo_mcu_wr_ram u_psram_wdata1(
    // .wclk(cpuclk),
    // .rclk(psram_clk),
    // .rrst_n(psram_fifo_rstn),
    // .wrst_n(psram_fifo_rstn),
    // .wdata(memdatao_comb),
    // .rdata(psram_wdata1),
    // .wen(psram_wr_en),
    // .ren(psram_data_load1),
    // .rempty(),
    // .wfull()
// );

assign psram_wdata0=psram_wdata;
assign psram_wdata1=psram_wdata;

//FIFO access
// always @ (posedge cpuclk or negedge rstn) begin
	// if (!rstn) begin
		// psram_rd_en_f<=1'b0;
		// psram_rd_en_s<=1'b0;
	// end
	// else begin
		// psram_rd_en_f<=psram_ctrl[7];
		// psram_rd_en_s<=psram_rd_en_f;
	// end
// end 
// assign psram_rd_en = psram_rd_en_f&(!psram_rd_en_s);

//*****************************************************************//


always @ (posedge psram_clk or negedge rstn) begin
	if (!rstn) begin
		psram_rd_val0_s<=1'b0;
	end
	else begin
		psram_rd_val0_s<=psram_rd_val0;
	end
end 

assign psram_rd_val0_r = psram_rd_val0&(!psram_rd_val0_s);

always @ (posedge psram_clk or negedge rstn) begin
	if (!rstn) begin
		psram_rdata0_s<=16'b0;
	end
	else if(psram_rd_val0_r) begin
		psram_rdata0_s<=psram_rdata0;
	end
end 


always @ (posedge psram_clk or negedge rstn) begin
	if (!rstn) begin
		psram_rd_val1_s<=1'b0;
	end
	else begin
		psram_rd_val1_s<=psram_rd_val1;
	end
end 

assign psram_rd_val1_r = psram_rd_val1&(!psram_rd_val1_s);

always @ (posedge psram_clk or negedge rstn) begin
	if (!rstn) begin
		psram_rdata1_s<=16'b0;
	end
	else if(psram_rd_val1_r) begin
		psram_rdata1_s<=psram_rdata1;
	end
end 

//fifo_mcu_rd_ram fifo_psram_rd(
//    .wclk(psram_clk),
//    .rclk(cpuclk),
//    .rrst_n(psram_fifo_rstn),
//    .wrst_n(psram_fifo_rstn),
//    .wdata(psram_rdata0),
//    .rdata(psram_rdata_mcu),
//    .wen(psram_rd_val0),
//    .ren(psram_rd_en),
//    .rempty(),
//    .wfull()
//);
//
//fifo_mcu_rd_ram fifo_psram_rd1(
//    .wclk(psram_clk),
//    .rclk(cpuclk),
//    .rrst_n(psram_fifo_rstn),
//    .wrst_n(psram_fifo_rstn),
//    .wdata(psram_rdata1),
//    .rdata(psram_rdata_mcu1),
//    .wen(psram_rd_val1),
//    .ren(psram_rd_en),
//    .rempty(),
//    .wfull()
//);

//assign test[0]=psram_wr_en;
//assign test[1]=psram_data_load0;
//assign test[2]=psram_fifo_rstn;
//assign test[3]=psram_rd_val0;
//assign test[4]=psram_fifo_rstn;
//***************************************************************//
//***************************************************************//
//***************************************************************//
endmodule	














