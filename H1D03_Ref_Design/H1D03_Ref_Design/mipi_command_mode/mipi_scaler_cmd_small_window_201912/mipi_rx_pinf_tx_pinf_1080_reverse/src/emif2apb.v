`timescale 1ns/10ps

module emif2apb(input            clk             ,  
                input            rst_n           ,
		 // pmem interface
			    output reg       memack     ,
                output reg[7:0]  memdatai     ,
                input[22:0]      memaddr ,     
                input[7:0]       memdatao,     
                input            memrd ,       
                input            memwr ,       
		  // fpga ahb 
		        input[31:0]      fpga_HRDATA     ,
                input            fpga_HREADY     ,
                output[19:0] fpga_HADDR      ,
                output       fpga_HWRITE     ,
                output[31:0] fpga_HWDATA     ,
                output       fpga_HSEL       ,
			    input            interrupt
           );

reg[31:0]  write_data_temp;
reg[1:0]  write_byte_cnt;
reg write_buffer_full;
reg       memrd_s;
reg       memwr_s;
wire memrd_t;
wire memwr_t;
wire memrd_r;
wire memwr_r;
wire Hwr;
wire Hsel;
reg fpga_HRD;
reg fpga_HREADY_s;
wire fpga_HREADY_r;
reg       fpga_HWRITE_reg;

assign fpga_HADDR= {memaddr[19:2], 2'b0};
assign fpga_HSEL= fpga_HWRITE|fpga_HRD;

assign fpga_HWDATA=write_data_temp;
assign fpga_HWRITE=fpga_HWRITE_reg;


//**************************************************************//
//**************************************************************//
//**************************************************************//

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
      memrd_s  <=1'b0;
    else 
      memrd_s  <=memrd;
end

assign memrd_t =memrd_s &(!memack);

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
      memwr_s  <=1'b0;
    else 
      memwr_s  <=memwr;
end

assign memwr_t =memwr_s ;

assign memrd_r=memrd&(!memrd_t)&(!memack);
assign memwr_r=memwr&(!memwr_t)&(!memack);


//**************************************************************//
//**************************************************************//
//**************************************************************//
//wr
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
        write_data_temp<=32'd0;
     else if(memwr_r)
	    write_data_temp<={write_data_temp[23:0],memdatao};
end	 

always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
        write_byte_cnt<=2'd0;
     else if(memwr_r)
	    write_byte_cnt<=write_byte_cnt+1'b1;
end	 

always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
        fpga_HWRITE_reg<=1'd0;
	 else if(fpga_HREADY)
		fpga_HWRITE_reg<=1'd0;
     else if(memwr_r&(write_byte_cnt==2'd3))
	    fpga_HWRITE_reg<=1'b1;
end	 

//**************************************************************//
//**************************************************************//
//**************************************************************//
//rd
always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
        fpga_HRD<=1'd0;
	 else if(fpga_HREADY)
		fpga_HRD<=1'd0;
     else if(memrd_r)
	    fpga_HRD<=1'b1;
end	 


always@(posedge clk or negedge rst_n)
begin 
     if(!rst_n)
       memdatai<=8'd0;
     else if(fpga_HREADY_r) begin
	   if(memaddr[1:0]==2'd0)
	     memdatai<=fpga_HRDATA[31:24];
	   else if(memaddr[1:0]==2'd1)
	     memdatai<=fpga_HRDATA[23:16];
       else if(memaddr[1:0]==2'd2)
	     memdatai<=fpga_HRDATA[15:8];
	   else if(memaddr[1:0]==2'd3)
	     memdatai<=fpga_HRDATA[7:0];
     end
end

//**************************************************************//
//**************************************************************//
//**************************************************************//
//ack

always@(posedge clk or negedge rst_n)
begin
    if(!rst_n)
      fpga_HREADY_s  <=1'b0;
    else 
      fpga_HREADY_s  <=fpga_HREADY;
end

assign fpga_HREADY_r=fpga_HREADY&(!fpga_HREADY_s);

always@(posedge clk or negedge rst_n)
begin
     if(!rst_n)
       memack<=1'b0;
	 else if((memrd|memwr)&&(fpga_HREADY_r|((memwr_r)&&(write_byte_cnt<2'd3))))
	   memack<=1'b1;
     else if(!(memrd|memwr))
	   memack<=1'b0;
end	 

endmodule
