module mipi_slave
   (
    // clock and reset
    input                           clk_byte, // byte  clock
    input                           reset_byte_n,
     
    input                           tx_hs_mode_bc, // 1==HSTX, 0==LPDT request
    input [31:0]                    tx_payload_bc, // User pixel input 
    output                          tx_payload_en_bc, // Pixel read enable to user logic
    output                          tx_payload_en_last_bc, // Last pixel indicator, asserts on last cycle of l_pixel_rd_en
    input [1:0]                     tx_cmd_vc_bc, // pkt cmd vc
    input [5:0]                     tx_cmd_data_type_bc, // pkt cmd data type
    input [15:0]                    tx_cmd_byte_count_bc, // pkt payload size, in bytes
    input                           tx_cmd_req_bc, // pkt xmit request
    output                          tx_cmd_ack_bc, // pkt cmd ack
    output                          tx_active_bc
    );

wire                           hstx_mode_request_bc;
wire                           hstx_mode_active_bc;  
wire                           lpdt_request_ex_rd_data;  
wire                           byte_cnt_eq_0_bc;
wire                           lpdt_mode_request_bc;
wire                           lpdt_mode_active_bc;
wire                           lpdt_mode_done_pulse;
    
mipi_slave_pkt mipi_slave_pkt(
    .clk_byte                 (clk_byte), 
    .reset_byte_n             (reset_byte_n), 
 
    .tx_hs_mode_bc            (tx_hs_mode_bc),  
    .tx_payload_bc            (tx_payload_bc),
    .tx_payload_en_bc         (tx_payload_en_bc),
    .tx_payload_en_last_bc    (tx_payload_en_last_bc),
    .tx_cmd_vc_bc             (tx_cmd_vc_bc),
    .tx_cmd_data_type_bc      (tx_cmd_data_type_bc),
    .tx_cmd_byte_count_bc     (tx_cmd_byte_count_bc),
    .tx_cmd_req_bc            (tx_cmd_req_bc),
    .tx_cmd_ack_bc            (tx_cmd_ack_bc),
    .tx_active_bc             (tx_active_bc),
 
    .hstx_mode_request_bc     (hstx_mode_request_bc),
    .hstx_mode_active_bc      (hstx_mode_active_bc),
    .lpdt_mode_request_bc     (lpdt_mode_request_bc),
    .lpdt_mode_active_bc      (lpdt_mode_active_bc),
    .lpdt_request_ex_rd_data  (lpdt_request_ex_rd_data),
    .byte_cnt_eq_0_bc         (byte_cnt_eq_0_bc),
    .lpdt_mode_done_pulse     (lpdt_mode_done_pulse)
 );   
 
dphy_state dphy_state(
    .clk_byte                 (clk_byte), 
    .reset_byte_n             (reset_byte_n),
    
    .hstx_mode_request_bc     (hstx_mode_request_bc), 
    .hstx_mode_active_bc      (hstx_mode_active_bc),
    .lpdt_request             (lpdt_mode_request_bc),
    .lpdt_mode_active         (lpdt_mode_active_bc),
    .lpdt_request_ex_rd_data  (lpdt_request_ex_rd_data),//lpdt_state==1,2,4,5
    .byte_cnt_eq_0            (byte_cnt_eq_0_bc),
    .tx_hs_mode               (tx_hs_mode_bc),
    .lpdt_mode_done_pulse     (lpdt_mode_done_pulse)
 );
 
endmodule   



module dphy_state
    (
    // clock and reset
    input                           clk_byte, // byte  clock
    input                           reset_byte_n,
    
    input                           hstx_mode_request_bc, // request for high speed mode
    output  reg                     hstx_mode_active_bc,
    input                           lpdt_request,
    output  reg                     lpdt_mode_active,
    input                           lpdt_request_ex_rd_data,//lpdt_state==1,2,4,5
    input                           byte_cnt_eq_0,
    input                           tx_hs_mode,
    output                          lpdt_mode_done_pulse
    );


localparam [3:0]IDLE               = 4'd0;
localparam [3:0]HSTX_MODE          = 4'd1;
localparam [3:0]LPDT_MODE          = 4'd4;
localparam [3:0]EXIT_LPDT_MODE     = 4'd5;

reg [3:0]  current_mode;
reg hstx_data_in_process; 
reg hstx_request; 
reg [7:0] hstx_mode_done_cnt;
reg hstx_mode_done;
reg [9:0] lpdt_mode_done_cnt;      
reg       lpdt_mode_done;
reg       lpdt_mode_done_d;
reg       byte_cnt_eq_0_reg;
reg       lpdt_request_r1;
wire      lpdt_exit_req;
 
 always @(posedge clk_byte or negedge reset_byte_n)
     if(reset_byte_n == 1'b0)
     begin
       hstx_mode_active_bc <= 1'b0;
       lpdt_mode_active    <= 1'b0;
     end  
     else
     begin
       hstx_mode_active_bc <= (current_mode==HSTX_MODE);
       lpdt_mode_active    <= (current_mode == LPDT_MODE) | (current_mode == EXIT_LPDT_MODE);
     end  
       
       
       
 always @(posedge clk_byte or negedge reset_byte_n)
     if(reset_byte_n == 1'b0)
       current_mode <= IDLE;    
     else begin
       case(current_mode)    
         IDLE:
          if(hstx_request==1'b1)
             current_mode <= HSTX_MODE;  
          else if ((lpdt_request) == 1'b1)  
             current_mode <= LPDT_MODE;    
          else
             current_mode <= IDLE;   
         HSTX_MODE:
          if((hstx_mode_done & ~hstx_request)==1'b1)  
             current_mode <= IDLE;  
          else
             current_mode <= HSTX_MODE; 
         LPDT_MODE: 
              begin 
                  if (lpdt_mode_done_pulse & byte_cnt_eq_0_reg)
                      current_mode     <=  EXIT_LPDT_MODE;
                  else
                      current_mode     <=  LPDT_MODE;   // stay
              end   
         EXIT_LPDT_MODE:
                    begin 
                        if (lpdt_exit_req)
                            current_mode     <=  IDLE;
                        else
                            current_mode     <=  EXIT_LPDT_MODE;   // stay
                    end      
         default: begin 
             current_mode <= IDLE; 
         end
       endcase 
     end  
     
 always @(posedge clk_byte or negedge reset_byte_n)
     if(reset_byte_n == 1'b0) begin
       hstx_data_in_process <= 1'b0;
       hstx_request <= 1'b0;
     end  
     else begin
       hstx_data_in_process <= hstx_mode_request_bc;
       hstx_request <= hstx_data_in_process;   
     end   
     
 always @(posedge clk_byte or negedge reset_byte_n)//clk_byte=110M,CAN MODIFY
     if(reset_byte_n == 1'b0) begin
       hstx_mode_done_cnt <= 8'd0; 
       hstx_mode_done <= 1'b0;    
     end 
     else if(hstx_request) begin
       hstx_mode_done_cnt <= 8'd0; 
       hstx_mode_done <= 1'b0;
     end 
     else if(hstx_mode_done_cnt==77) begin//700ns
       hstx_mode_done_cnt <= hstx_mode_done_cnt;
       hstx_mode_done <= 1'b1;
     end  
     else if(!hstx_request) begin
       hstx_mode_done_cnt <= hstx_mode_done_cnt+1;
       hstx_mode_done <= 1'b0;
     end 


assign  lpdt_exit_req =  hstx_request | (tx_hs_mode) | (~lpdt_request & ~lpdt_request_r1);

always @ (posedge clk_byte or negedge reset_byte_n)
    if(reset_byte_n == 1'b0)
    begin
        lpdt_mode_done_d  <= 1'b0;
        byte_cnt_eq_0_reg <= 1'b0;
        lpdt_request_r1 <= 1'b0;
    end
    else
    begin
        lpdt_mode_done_d  <= lpdt_mode_done;
        byte_cnt_eq_0_reg <= byte_cnt_eq_0;
        lpdt_request_r1 <= lpdt_request;
    end

assign lpdt_mode_done_pulse = lpdt_mode_done & ~lpdt_mode_done_d;
     
  always @(posedge clk_byte or negedge reset_byte_n)//clk_byte=110M,CAN MODIFY    
     if(reset_byte_n == 1'b0) begin
       lpdt_mode_done_cnt <= 10'd0; 
       lpdt_mode_done <= 1'b0;    
     end 
     else if(lpdt_request_ex_rd_data) begin
       lpdt_mode_done_cnt <= 10'd0; 
       lpdt_mode_done <= 1'b0;
     end 
     else if(lpdt_mode_done_cnt==418) begin//3800ns
       lpdt_mode_done_cnt <= lpdt_mode_done_cnt;
       lpdt_mode_done <= 1'b1;
     end  
     else if(!lpdt_request_ex_rd_data) begin
       lpdt_mode_done_cnt <= lpdt_mode_done_cnt+1;
       lpdt_mode_done <= 1'b0;
     end      
       
 
endmodule                        



module mipi_slave_pkt
   (
    // clock and reset
    input                           clk_byte, // byte  clock
    input                           reset_byte_n,
     
    input                           tx_hs_mode_bc, // 1==HSTX, 0==LPDT request
    input [31:0]                    tx_payload_bc, // User pixel input 
    output                          tx_payload_en_bc, // Pixel read enable to user logic
    output                          tx_payload_en_last_bc, // Last pixel indicator, asserts on last cycle of l_pixel_rd_en
    input [1:0]                     tx_cmd_vc_bc, // pkt cmd vc
    input [5:0]                     tx_cmd_data_type_bc, // pkt cmd data type
    input [15:0]                    tx_cmd_byte_count_bc, // pkt payload size, in bytes
    input                           tx_cmd_req_bc, // pkt xmit request
    output                          tx_cmd_ack_bc, // pkt cmd ack
    output                          tx_active_bc,
    
    output                          hstx_mode_request_bc, // request for high speed mode
    input                           hstx_mode_active_bc,
    
    output                          lpdt_mode_request_bc,
    input                           lpdt_mode_active_bc,
    output                          lpdt_request_ex_rd_data,//lpdt_state==1,2,4,5
    output                          byte_cnt_eq_0_bc,
    input                           lpdt_mode_done_pulse
    );
    
    /* states for LPDT Tx */
   localparam LPDT_STATE_AWAITING_CMD               = 3'd0;
   localparam LPDT_STATE_MODE_REQ                   = 3'd1;
   localparam LPDT_STATE_SHORT_PACKET_CMD           = 3'd2;
   localparam LPDT_STATE_SHORT_PACKET_RD_DATA       = 3'd3;
   localparam LPDT_STATE_LONG_PACKET_CMD            = 3'd4;
   localparam LPDT_STATE_LONG_PACKET_DATA           = 3'd5;
   localparam LPDT_STATE_LONG_PACKET_RD_DATA        = 3'd6;
   localparam LPDT_STATE_WAIT_DONE                  = 3'd7; 
    
    
    /* States for HS Tx*/
   localparam HSTX_STATE_AWAITING_CMD               = 5'd0;
   localparam HSTX_STATE_MODE_REQ                   = 5'd1;
   localparam HSTX_STATE_SHORT_PACKET_CMD           = 5'd2;
   localparam HSTX_STATE_LONG_PACKET_CMD            = 5'd3;
   localparam HSTX_STATE_LONG_PACKET_DATA           = 5'd4;
   localparam HSTX_STATE_WAIT_DONE                  = 5'd5;
   localparam HSTX_STATE_SEND_DUMMY_COMMANDS_AT_END = 5'd6;
   localparam HSTX_STATE_FINISH_NOCHECK_HSTX        = 5'd8;
   localparam HSTX_STATE_HS_TX_TIMEOUT              = 5'd9;

reg [2:0]                        lpdt_state;
reg [2:0]                        lpdt_next_state;
   
reg [4:0]                        hstx_state;
reg [4:0]                        hstx_next_state;

wire                             lpdt_cmd_req_bc;
wire                             lpdt_tx_cmd_ack_bc;
wire                             lpdt_tx_payload_en_bc;
wire                             lpdt_tx_payload_en_last_bc;


wire                             lpdt_cmd_valid;
wire                             lpdt_data_valid;
wire                             lpdt_fifo_wr_valid;
wire                             lpdt_fifo_rd_ack;
reg                              lpdt_fifo_wr_empty;


reg [13:0]                       byte_cnt;
wire                             load_byte_cnt;
wire                             dec_byte_cnt;
wire                             short_pkt;

wire                             hstx_long_done;

wire                             hstx_tx_cmd_ack_bc;
wire                             hstx_cmd_req_bc;
wire                             hstx_tx_payload_en_bc;
wire                             hstx_tx_payload_en_last_bc;

wire                             hstx_sm_idle;
wire                             lpdt_sm_idle;



assign hstx_cmd_req_bc = tx_cmd_req_bc == 1'b1 & tx_hs_mode_bc == 1'b1;
assign lpdt_cmd_req_bc = tx_cmd_req_bc == 1'b1 & tx_hs_mode_bc == 1'b0;

 
assign tx_payload_en_bc = (lpdt_tx_payload_en_bc == 1'b1) | (hstx_tx_payload_en_bc == 1'b1);
assign tx_payload_en_last_bc = (lpdt_tx_payload_en_last_bc == 1'b1) | (hstx_tx_payload_en_last_bc == 1'b1);
assign tx_cmd_ack_bc =  (lpdt_tx_cmd_ack_bc == 1'b1) | (hstx_tx_cmd_ack_bc == 1'b1);
assign tx_active_bc = lpdt_mode_active_bc | hstx_mode_active_bc;

//-------------------------------------------------------------------------
//
//  LPDT State Machine
//
//-------------------------------------------------------------------------
   
   
   // all lpdt tx states except LPDT_STATE_AWAITING_CMD and LPDT_STATE_WAIT_DONE
   assign lpdt_mode_request_bc = (lpdt_state == LPDT_STATE_MODE_REQ) |
                                 (lpdt_state == LPDT_STATE_SHORT_PACKET_CMD) |
                                 (lpdt_state == LPDT_STATE_SHORT_PACKET_RD_DATA) |
                                 (lpdt_state == LPDT_STATE_LONG_PACKET_CMD) |
                                 (lpdt_state == LPDT_STATE_LONG_PACKET_DATA) |
                                 (lpdt_state == LPDT_STATE_LONG_PACKET_RD_DATA);
                                 
   assign lpdt_request_ex_rd_data = (lpdt_state == LPDT_STATE_MODE_REQ) |
                                 (lpdt_state == LPDT_STATE_SHORT_PACKET_CMD) |                          
                                 (lpdt_state == LPDT_STATE_LONG_PACKET_CMD) |
                                 (lpdt_state == LPDT_STATE_LONG_PACKET_DATA);                              
   
   assign lpdt_tx_cmd_ack_bc = (lpdt_state == LPDT_STATE_MODE_REQ) & (lpdt_mode_active_bc == 1'b1);
   
   
   assign lpdt_cmd_valid = (lpdt_state == LPDT_STATE_SHORT_PACKET_CMD) | 
                           (lpdt_state == LPDT_STATE_LONG_PACKET_CMD);
   
   assign lpdt_data_valid = (lpdt_state == LPDT_STATE_LONG_PACKET_DATA);
   
   
   assign lpdt_tx_payload_en_bc = (lpdt_state == LPDT_STATE_LONG_PACKET_RD_DATA) & 
                                  (lpdt_fifo_wr_empty == 1'b1) & 
                                  !(byte_cnt_eq_0_bc == 1'b1);
   
   assign lpdt_tx_payload_en_last_bc = lpdt_tx_payload_en_bc & (byte_cnt <= 14'h4 );
   
   assign lpdt_sm_idle = (lpdt_state == LPDT_STATE_AWAITING_CMD);

  
always @* begin
      case (lpdt_state)
        LPDT_STATE_AWAITING_CMD: begin  // Waiting for a LPDT command
           if((lpdt_cmd_req_bc & hstx_sm_idle) == 1'b1) 
             lpdt_next_state = LPDT_STATE_MODE_REQ;
           else
             lpdt_next_state = LPDT_STATE_AWAITING_CMD;
        end
        LPDT_STATE_MODE_REQ: begin  // Got command, requesting LPDT mode
           if(lpdt_mode_active_bc == 1'b1) 
             if(short_pkt)
               lpdt_next_state = LPDT_STATE_SHORT_PACKET_CMD;
             else
               lpdt_next_state = LPDT_STATE_LONG_PACKET_CMD;
           else
             lpdt_next_state = LPDT_STATE_MODE_REQ;
        end
        LPDT_STATE_SHORT_PACKET_CMD: begin
           lpdt_next_state = LPDT_STATE_SHORT_PACKET_RD_DATA;
        end
        LPDT_STATE_SHORT_PACKET_RD_DATA:  begin // data read from FIFO
           if(lpdt_fifo_wr_empty == 1'b1)
             if(lpdt_cmd_req_bc == 1'b1) 
               lpdt_next_state = LPDT_STATE_MODE_REQ;  // Handle pending request
             else
               lpdt_next_state = LPDT_STATE_WAIT_DONE;
           else
             lpdt_next_state = LPDT_STATE_SHORT_PACKET_RD_DATA;
        end
        
        LPDT_STATE_LONG_PACKET_CMD: begin
           lpdt_next_state = LPDT_STATE_LONG_PACKET_RD_DATA;
        end
        LPDT_STATE_LONG_PACKET_DATA: begin
           lpdt_next_state = LPDT_STATE_LONG_PACKET_RD_DATA;
        end
        LPDT_STATE_LONG_PACKET_RD_DATA: begin  // data read from FIFO
           if(lpdt_fifo_wr_empty == 1'b1)
             if(byte_cnt_eq_0_bc == 1'b0)
               lpdt_next_state = LPDT_STATE_LONG_PACKET_DATA;  // Handle next data
             else
               if(lpdt_cmd_req_bc == 1'b1) 
                 lpdt_next_state = LPDT_STATE_MODE_REQ;  // Handle pending request
               else
                 lpdt_next_state = LPDT_STATE_WAIT_DONE;
           else
             lpdt_next_state = LPDT_STATE_LONG_PACKET_RD_DATA;
        end // case: LPDT_STATE_LONG_PACKET_RD_DATA
        LPDT_STATE_WAIT_DONE: begin // Necessary to handle the case were a new command after deassertion of mode
           if(lpdt_mode_active_bc == 1'b0)
             lpdt_next_state = LPDT_STATE_AWAITING_CMD;
           else
             lpdt_next_state = LPDT_STATE_WAIT_DONE;
        end
        default : begin
           lpdt_next_state = LPDT_STATE_AWAITING_CMD;
        end
      endcase // case (lpdt_state)
   end // always @ *
   
   always @(posedge clk_byte or negedge reset_byte_n)
     if(reset_byte_n == 1'b0)
       lpdt_state <= LPDT_STATE_AWAITING_CMD;
     else
       lpdt_state <= lpdt_next_state;                         
                         
                         
//-------------------------------------------------------------------------
//
//  HSTX State Machine
//
//-------------------------------------------------------------------------
   
assign hstx_sm_idle = (hstx_state == HSTX_STATE_AWAITING_CMD);                        

assign hstx_mode_request_bc =    (hstx_state == HSTX_STATE_MODE_REQ) |
                                 (hstx_state == HSTX_STATE_SHORT_PACKET_CMD) |
                                 (hstx_state == HSTX_STATE_LONG_PACKET_CMD) |
                                 (hstx_state == HSTX_STATE_LONG_PACKET_DATA) |                              
                                 (hstx_state == HSTX_STATE_FINISH_NOCHECK_HSTX);


assign hstx_tx_cmd_ack_bc = (tx_cmd_req_bc & tx_hs_mode_bc &
                            ((hstx_state == HSTX_STATE_SHORT_PACKET_CMD)|hstx_long_done)) |
                            ((hstx_state == HSTX_STATE_MODE_REQ) & hstx_mode_active_bc);
                            
assign hstx_tx_payload_en_bc = (hstx_state == HSTX_STATE_LONG_PACKET_DATA | 
                                   hstx_state == HSTX_STATE_LONG_PACKET_CMD) &
                                  ~byte_cnt_eq_0_bc;                            


assign hstx_long_done = (byte_cnt <= 14'h4) & (hstx_state == HSTX_STATE_LONG_PACKET_DATA | hstx_state == HSTX_STATE_LONG_PACKET_CMD);

assign hstx_tx_payload_en_last_bc = (hstx_tx_payload_en_bc & hstx_long_done);




always @ (*) begin
case (hstx_state)

HSTX_STATE_AWAITING_CMD: begin // Waiting for a HSTX command 
 if(hstx_cmd_req_bc & lpdt_sm_idle)
 hstx_next_state = HSTX_STATE_MODE_REQ;
 else
 hstx_next_state = HSTX_STATE_AWAITING_CMD;
end 
HSTX_STATE_MODE_REQ:begin // Got command, requesting HSTX mode
 if(hstx_mode_active_bc & lpdt_sm_idle)
  if(short_pkt==1'b1)
   hstx_next_state = HSTX_STATE_SHORT_PACKET_CMD;
  else
   hstx_next_state = HSTX_STATE_LONG_PACKET_CMD; 
 else
  hstx_next_state = HSTX_STATE_MODE_REQ;
end  
HSTX_STATE_SHORT_PACKET_CMD: begin  // Another packet pending
 if(hstx_cmd_req_bc == 1'b1) 
  if(short_pkt==1'b1) 
   hstx_next_state = HSTX_STATE_SHORT_PACKET_CMD;
  else
   hstx_next_state = HSTX_STATE_LONG_PACKET_CMD;  
 else
  if(hstx_mode_active_bc==1'b1)  
   hstx_next_state = HSTX_STATE_WAIT_DONE;
  else
   hstx_next_state = HSTX_STATE_AWAITING_CMD;
end
HSTX_STATE_LONG_PACKET_CMD: begin
if(byte_cnt > 14'h4)
  hstx_next_state = HSTX_STATE_LONG_PACKET_DATA;  // Handle next data
else
     if(hstx_cmd_req_bc == 1'b1) 
       if (short_pkt)
         hstx_next_state = HSTX_STATE_SHORT_PACKET_CMD;
       else
         hstx_next_state = HSTX_STATE_LONG_PACKET_CMD;
     else
         hstx_next_state = HSTX_STATE_FINISH_NOCHECK_HSTX;
end 
HSTX_STATE_LONG_PACKET_DATA: begin
if(byte_cnt > 14'h4)
  hstx_next_state = HSTX_STATE_LONG_PACKET_DATA;  // Handle next data
else 
    if(hstx_cmd_req_bc == 1'b1) 
      begin
         if (short_pkt)
           hstx_next_state = HSTX_STATE_SHORT_PACKET_CMD;
         else
           hstx_next_state = HSTX_STATE_LONG_PACKET_CMD;
      end
    else
        hstx_next_state = HSTX_STATE_FINISH_NOCHECK_HSTX;
end 
HSTX_STATE_WAIT_DONE: begin // Necessary to handle the case were a new command after deassertion of mode
if(hstx_mode_active_bc == 1'b0)
  hstx_next_state = HSTX_STATE_AWAITING_CMD;
else
  hstx_next_state = HSTX_STATE_WAIT_DONE;
end
HSTX_STATE_FINISH_NOCHECK_HSTX: begin
  if(hstx_mode_active_bc == 1'b1)
    hstx_next_state = HSTX_STATE_WAIT_DONE;
  else
    hstx_next_state = HSTX_STATE_AWAITING_CMD;
end
default: begin 
    hstx_next_state = HSTX_STATE_AWAITING_CMD;
    end
  endcase 
end 

 always @(posedge clk_byte or negedge reset_byte_n)
     if(reset_byte_n == 1'b0)
       hstx_state <= HSTX_STATE_AWAITING_CMD;
     else
       hstx_state <= hstx_next_state;
   //-------------------------------------------------------------------------
   //
   //  Byte Count Logic
   //
   //-------------------------------------------------------------------------       
       
assign byte_cnt_eq_0_bc = (byte_cnt == 0);
   
assign load_byte_cnt = lpdt_tx_cmd_ack_bc | hstx_tx_cmd_ack_bc;
   
assign dec_byte_cnt = tx_payload_en_bc;

assign clr_byte_cnt = ((load_byte_cnt == 1'b1) & (short_pkt == 1'b1)) |
                      ((tx_payload_en_last_bc == 1'b1) & (load_byte_cnt == 1'b0));
   
   
   always @(posedge clk_byte or negedge reset_byte_n)
     if(reset_byte_n == 1'b0)
       byte_cnt <= 14'h0;
     else
       if(clr_byte_cnt == 1'b1)
         byte_cnt <= 14'h0;
       else
         if(load_byte_cnt == 1'b1)
           byte_cnt <= tx_cmd_byte_count_bc[13:0];
         else
           if(dec_byte_cnt == 1'b1)
             byte_cnt <= byte_cnt - (14'h4);       


assign lpdt_fifo_wr_valid   = lpdt_cmd_valid | lpdt_data_valid;     

assign lpdt_fifo_rd_ack = lpdt_mode_done_pulse;   
       
 always @(posedge clk_byte or negedge reset_byte_n)
     if(reset_byte_n == 1'b0)
       lpdt_fifo_wr_empty <= 1'b1;
     else if(lpdt_fifo_wr_valid == 1'b1)
       lpdt_fifo_wr_empty <= 1'b0;
     else if(lpdt_fifo_rd_ack == 1'b1)
       lpdt_fifo_wr_empty <= 1'b1;       
       

assign short_pkt = short_pkt_detection(tx_cmd_data_type_bc);       
       
 function short_pkt_detection;
      input [5:0] data_type;
      begin
         case (data_type)
           6'h09, 
           6'h19, 
           6'h29, 
           6'h39, 
           6'h0C,
           6'h1C,
           6'h2C,  // but not 3C, which is undefined
           6'h0D,
           6'h1D,
           6'h3D,  // but not 2D, which is undefined
           6'h0E, 
           6'h1E,
           6'h0a,
           6'h0b,
           6'h2E, 
           6'h3E: 
             short_pkt_detection = 1'b0;        // above types are long packet
           default:    short_pkt_detection = 1'b1;        // default: it's a short packet
         endcase // case (data_type)
      end
   endfunction // case    
   
endmodule      



      








