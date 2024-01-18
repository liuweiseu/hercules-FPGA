module psram_wrap(
	output    reg       memack	,
	output [7:0]   memdatai	,
                                
	input  [22:0]  memaddr		,
	input  [7:0]   memdatao		,
	input          memrd		,
	input          memwr		,
	input          clkin		,
	input          rstn
);

wire[13:0] 	sp_addr; 
wire[31:0] 	sp_datai; 
wire[31:0] 	sp_datao; 
wire[3:0]	 sp_beb; 
wire[7:0]	 memdatai_o; 
wire		 sp_ceb; 
wire		 sp_web; 
wire 		sp_sel;
reg 	memack_s;
reg[1:0] dsel;
wire ram_data_sel;


assign sp_addr= {1'b0,memaddr[14:2]};
assign memdatai= (dsel==2'b00)? sp_datao[7:0] :
					(dsel==2'b01)? sp_datao[15:8] :
					(dsel==2'b10)? sp_datao[23:16] : sp_datao[31:24] ;
					
assign sp_beb= (memaddr[1:0]==2'b00)? 4'b1110 :
					(memaddr[1:0]==2'b01)? 4'b1101 :
					(memaddr[1:0]==2'b10)? 4'b1011 : 4'b0111 ;
					
assign ram_data_sel=(memaddr[22:15]!=8'h0);
assign 	sp_web= ~(memwr);
assign 	sp_ceb = ram_data_sel;	
assign sp_datai= {4{memdatao}};	



//always @(posedge clkin or negedge rstn)
//	begin
//    if (!rstn)
//		memdatai<=8'b0;
//	else
//		memdatai<=memdatai_o;
//end	
//

always @(posedge clkin or negedge rstn)
	begin
    if (!rstn)
		dsel<=2'b0;
	else
		dsel<=memaddr[1:0];
end	

//always @(posedge clkin or negedge rstn)
//	begin
//    if (!rstn)
//		memack<=8'b0;
//	else
//		memack<=memack_s;
//end	

always @(posedge clkin or negedge rstn)
	begin
    if (!rstn)
		memack<=1'b0;
	else if((~sp_ceb)&(memrd|memwr))
		memack<=1'b1;
	else
		memack<=1'b0;
end
		   
SPRAM_16Kx32  u_psram(
    .addr	(sp_addr),
    .beb	(sp_beb),
    .ceb	(sp_ceb),
    .clk	(clkin),
    .datai	(sp_datai),
    .web	(sp_web),
    .datao	(sp_datao)
);


endmodule







