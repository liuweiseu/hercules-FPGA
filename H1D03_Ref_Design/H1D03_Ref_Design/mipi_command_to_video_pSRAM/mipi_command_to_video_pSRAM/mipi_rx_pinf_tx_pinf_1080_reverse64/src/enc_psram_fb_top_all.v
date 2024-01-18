
module psram_fb_top(


output                      ck,
output                      ck_n,
output                      cs_n,
inout                       rwds,
inout[7:0]                  dq,

output                      ck1,
output                      ck_n1,
output                      cs_n1,
inout                       rwds1,
inout[7:0]                  dq1,

input                       rstn              ,
input                       dpi_pclk              ,
input                       mipi_rx_clk              ,

input                       psram_clk              ,
input                       psram_clk_clk0              ,
input                       psram_clk_clk1              ,
input                       psram_clk_rd0              ,
input                       psram_clk_wr0              ,
input                       psram_clk_wr1              ,
input                       psram_clk_rd1              ,
input                       ram_powerup_on              ,

input[7:0]                  psram_ctrl              ,
//  psram_ctrl[7]  rdfifo_rd
//psram_fifo_rstn=psram_ctrl[6];
//  psram_ctrl[5] psram rstn
//  psram_ctrl[4] init mode
//  psram_ctrl[2]  psram reg set   0 reg0  1 reg1
//  psram_ctrl[1]  rd
//  psram_ctrl[0]  wr

input[20:0]                 psram_addr_mcu        ,
input[15:0]                 reg_cfg_data          ,
input[15:0]                 reg_cfg_data0          ,
input[15:0]                 reg_cfg_data1          ,

output[15:0]                 mcu_psram_rdata0          ,
output[15:0]                 mcu_psram_rdata1          ,
output                      psram_data_load0,
output                      psram_data_load1,
output                      psram_rd_val0,
output                      psram_rd_val1,

output                      psram_finish,
output                      ltcy_mode0,
output                      ltcy_mode1,
output[3:0]                     test,


input                       mipi_dval,
input[31:0]                 mipi_rx_data,
output                      mipi_de_mask,


input                           te,

input                        host_dpi_de,
output reg[23:0]             host_dpi_d  ,
input                        host_vsync,
input                        reset_dpi_n

);


reg wrfifo_sync;
reg wrfifo_sync_s;
wire wrfifo_syncr;


reg rdfifo_sync_s;
reg rdfifo_sync;
wire rdfifo_syncr;


wire rxfifo_pfull;
wire txfifo_pemp;
wire full1;
wire emp1;
wire full;
wire emp;
reg wr_fifo_rst;

wire dpi_fifo_rd;
reg[1:0] de_cnt;
wire[31:0] rd_data_psram;
reg[31:0] rd_data_psram_s;
reg[31:0] rd_data_psram_t;
wire[15:0] wrdata;
wire fifo_rd_en;
reg[15:0] psram_wdata;
reg[15:0] psram_wdata0;
reg[15:0] psram_wdata1;
reg psram_rdy;

wire bd_meet0;
wire ctrl_hold0;
wire wr_rd_set0;
wire psram_finish0;
wire psram_wr_req0;
wire rd_req_ack0;
wire wr_req_ack0;
wire[15:0] psram_rdata0;

wire bd_meet1;
wire ctrl_hold1;
wire wr_rd_set1;
wire psram_finish1;
wire psram_wr_req1;
wire rd_req_ack1;
wire wr_req_ack1;
wire[15:0] psram_rdata1;

reg ram_mode_set; //0 ram0 wr, ram1 rd , 1  ram1 wr, ram0 rd
reg fb_update_done;
reg fb_cvt;
reg ram_hold;
wire ram_rd_done;
wire ram_addr_clr;
reg rd_fifo_rst;
reg rd_addr_clr_s;
reg rd_addr_clr;
wire addr_clr0;
wire addr_clr1;
reg [15:0] psram_rdata;//wire[15:0] psram_rdata;
wire rd_psram_end;
reg rd_fifo_wren;//wire rd_fifo_wren;
wire ram_wr_emp;
wire ram_wr_full;
wire ram_rd_emp;
wire ram_rd_full;
wire psram_rd_req0;
wire psram_rd_req1;
wire bd_meet_f0;
reg reset_dpi_n_s;
reg reset_dpi_n_t;




parameter HTOTAL= 10'd720;
parameter VTOTAL= 11'd1280;
parameter FRAME_TOTAL= HTOTAL*VTOTAL*3/2;


reg mipi_dval_d;
reg fifo_rd_en_d;
reg dpi_fifo_rd_d;
reg rd_fifo_wren_d;
reg bd_meet0_d;

always @ (posedge mipi_rx_clk or negedge rstn) begin
	if (!rstn) 
		mipi_dval_d <=0;		 //0 ram0 wr, ram1 rd , 1  ram1 wr, ram0 rd
	else 
		mipi_dval_d <= mipi_dval;
end 

always @ (posedge psram_clk or negedge rstn) begin
	if (!rstn) 
        fifo_rd_en_d <=0;
	else 
		fifo_rd_en_d <= fifo_rd_en;
end 

always @ (posedge psram_clk or negedge rstn) begin
	if (!rstn) 
        rd_fifo_wren_d <= 0;
    else
        rd_fifo_wren_d <= rd_fifo_wren;
end

always @ (posedge dpi_pclk or negedge rstn) begin
	if (!rstn)
        dpi_fifo_rd_d <= 0;
    else
        dpi_fifo_rd_d <= dpi_fifo_rd;
end

always @ (posedge psram_clk or negedge rstn) begin
	if (!rstn) 
        bd_meet0_d <=0;
	else 
		bd_meet0_d <= bd_meet0;
end 


//test io
//assign test[0]=ram_mode_set;
//assign test[1]=ram_mode_set;
//assign test[2]=mipi_dval;
//assign test[3]=ram_wr_full;
//assign test[4]=bd_meet0;
//assign test[5]=bd_meet1;
//assign test[6]=fifo_rd_en ;
// assign test[7]=dpi_fifo_rd;


//assign test[0]=ram_mode_set;
//assign test[1]=mipi_dval;
//assign test[2]=fifo_rd_en;
//assign test[3]=rd_fifo_wren;
//assign test[4]=bd_meet0;
//assign test[5]=ram_wr_full;

//assign test[0]=0;
//assign test[1]=1;
//assign test[2]=fifo_rd_en_d;
//assign test[3]=rd_fifo_wren_d;
//assign test[4]=mipi_dval_d;
//assign test[5]=dpi_fifo_rd_d;
//assign test[4]=ram_mode_set_d;
//assign test[5]=bd_meet0_d;

// assign test[0]=ram_mode_set;
//assign test[1]=ram_wr_full;
//assign test[2]=mipi_dval;
//assign test[3]=ram_mode_set;
//assign test[4]=bd_meet0;
//assign test[5]=bd_meet1;
//assign test[6]=fifo_rd_en ;
// assign test[7]=dpi_fifo_rd;


assign test[0]=rd_fifo_wren;
assign test[1]=dpi_fifo_rd;
assign test[2]=ram_rd_emp;
assign test[3]=ram_rd_full;

`pragma protect begin_protected
`pragma protect version=1
`pragma protect data_block
00gc!dusm;!efgbvmu!sbn1!xs-!sbn2!se00opsnbmmz-!sbn!xs!jt!epof!cfgpsf!sbn!se-!tp!xs`sbn!jt!bmxbzt!xbjujoh!se!epof-!uifo!gc!dpowfsu/!cfdbvtf!xf!dbo!dpouspm!UF!tjhobm/bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjosbn`npef`tfu=>2(c1<!!!!!!001!sbn1!xs-!sbn2!se!-!2!!sbn2!xs-!sbn1!sefoefmtf!jg)gc`dwu*sbn`npef`tfu=>sbn`npef`tfu<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjogc`vqebuf`epof=>2(c1<foefmtf!jg)gc`dwu*gc`vqebuf`epof=>2(c1<fmtf!jg))sbn`npef`tfu''ce`nffu2*}}))"sbn`npef`tfu*''ce`nffu1**gc`vqebuf`epof=>2(c2<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjosbn`ipme=>2(c1<foefmtf!jg)gc`vqebuf`epof*cfhjojg)sbn`se`epof*sbn`ipme=>2(c2<foefmtfsbn`ipme=>2(c1<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjogc`dwu=>2(c1<foefmtf00!gc`dwu=>)gc`vqebuf`epof''sbn`se`epof*<gc`dwu=>)gc`vqebuf`epof''se`qtsbn`foe*<foebttjho!sbn`se`epof>!sbn`npef`tfu@!ce`nffu1;ce`nffu2<bttjho!sbn`bees`dms>gc`dwu<bttjho!xs`se`tfu1>sbn`npef`tfu<bttjho!xs`se`tfu2>sbn`npef`tfu<bttjho!njqj`ef`nbtl>!gc`vqebuf`epof<00xs!qtsbn!gjgpbmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoxs`gjgp`stu=>2(c2<foefmtfxs`gjgp`stu=>gc`vqebuf`epof<foebttjho!gjgp`se`fo>)xsgjgp`tzods}}xs`sfr`bdl1}}xs`sfr`bdl2*''qtsbn`sez<00!bttjho!gjgp`se`fo>)xs`sfr`bdl1}}xs`sfr`bdl2*''qtsbn`sez<gjgp`qsbn`xs`upq!v`xs`gjgp)/xdml)njqj`sy`dml*-/sdml)qtsbn`dml*-/sftfu)xs`gjgp`stu*-/xebub)njqj`sy`ebub*-/sebub)xsebub*-/xfo)njqj`ewbm*-/sfo)gjgp`se`fo*-/qsph`fnquz)uygjgp`qfnq*-/sfnquz)sbn`xs`fnq*-/xgvmm)sbn`xs`gvmm**<00!gjgp`qsbn`xs`upq`rvbsufs!v`xs`gjgp)00!/xdml)njqj`sy`dml*-00!/sdml)qtsbn`dml*-00!/sftfu)xs`gjgp`stu*-00!/xebub)njqj`sy`ebub*-00!/sebub)xsebub*-00!/xfo)njqj`ewbm*-00!/sfo)gjgp`se`fo*-00!/qsph`fnquz)uygjgp`qfnq*-00!/sfnquz)sbn`xs`fnq*-00!/xgvmm)sbn`xs`gvmm*00!*<00!gjgp`qtsbn`mcvg!v`xs`gjgp)00!/epvu)xsebub*-00!/ejo)|5(c1-njqj`sy`ebub~*-00!/xsjufdml)njqj`sy`dml*-00!/sfbedml)qtsbn`dml*-00!/xsjuffo)njqj`ewbm*-00!/sfbefo)gjgp`se`fo*-00!/sftfu)xs`gjgp`stu*-00!/gvmm)sbn`xs`gvmm*-00!/fnquz)sbn`xs`fnq*-00!/bmnptufnquz)uygjgp`qfnq*!007500!*<bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoxsgjgp`tzod`t=>2(c1<foefmtfxsgjgp`tzod`t=>xsgjgp`tzod<foebttjho!xsgjgp`tzods>xsgjgp`tzod')"xsgjgp`tzod`t*<bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoxsgjgp`tzod=>2(c1<foefmtf!jg)sbn`xs`fnq*xsgjgp`tzod=>2(c1<fmtf!jg)qtsbn`xs`sfr1}qtsbn`xs`sfr2*xsgjgp`tzod=>2(c2<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjosftfu`eqj`o`t=>2(c1<sftfu`eqj`o`u=>2(c1<foefmtf!cfhjosftfu`eqj`o`t=>sftfu`eqj`o<sftfu`eqj`o`u=>sftfu`eqj`o`t<foefoebmxbzt!A!)+*!cfhjojg)"sftfu`eqj`o`u*qtsbn`xebub1=>sfh`dgh`ebub1<fmtfqtsbn`xebub1=>xsebub<00!qtsbn`xebub=>27(igg11<foebmxbzt!A!)+*!cfhjojg)"sftfu`eqj`o`u*qtsbn`xebub2=>sfh`dgh`ebub2<fmtfqtsbn`xebub2=>xsebub<00!qtsbn`xebub=>27(igg11<foe00!bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjo00!jg!)"stuo*!cfhjo00!qtsbn`xebub=>43(c1<00!foe00!fmtf!jg)"sftfu`eqj`o*00!qtsbn`xebub=>sfh`dgh`ebub<00!fmtf00!qtsbn`xebub=>xsebub<00!foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoqtsbn`sez=>2(c1<foefmtfqtsbn`sez=>sftfu`eqj`o<foe001!sbn1!xs-!sbn2!se!-!2!!sbn2!xs-!sbn1!se00xifo!njqj!uy!wtzod-!stu!gjgp!boe!qtsbn!se!dusm!mphjd/00xifo!njqj!sy!boe!sy!sfbez-!stu!qtsbn!xs!gjgp!boe!uxp!qtsbn!dusm!mphjdbttjho!bees`dms1>sbn`bees`dms})sbn`npef`tfu''se`bees`dms`t*<bttjho!bees`dms2>sbn`bees`dms}))"sbn`npef`tfu*''se`bees`dms`t*<bttjho!dusm`ipme1>sbn`ipme})sbn`npef`tfu''se`bees`dms`t*<bttjho!dusm`ipme2>sbn`ipme}))"sbn`npef`tfu*''se`bees`dms`t*<00se!qtsbn!gjgpbmxbzt!A!)qptfehf!eqj`qdml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjose`gjgp`stu=>2(c2<foefmtfse`gjgp`stu=>iptu`wtzod<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjose`bees`dms`t=>2(c1<se`bees`dms=>2(c1<foefmtf!cfhjose`bees`dms=>iptu`wtzod<se`bees`dms`t=>se`bees`dms<foefoebttjho!se`qtsbn`foe>se`bees`dms')"se`bees`dms`t*<gjgp`qtsbn`mcvg`se!v`sbn`se`gjgp)/epvu)se`ebub`qtsbn*-/ejo)|3(c1-qtsbn`sebub~*-/xsjufdml)qtsbn`dml*-/sfbedml)eqj`qdml*-/xsjuffo)se`gjgp`xsfo*-/sfbefo)eqj`gjgp`se*-/sftfu)se`gjgp`stu*-/gvmm)sbn`se`gvmm*-/fnquz)sbn`se`fnq*-/bmnptugvmm)sygjgp`qgvmm*00999*<00bttjho!se`gjgp`xsfo>se`sfr`bdl1}}se`sfr`bdl2<00bttjho!qtsbn`sebub>sbn`npef`tfu!@!qtsbn`sebub1;qtsbn`sebub2<bmxbzt!A!)qptfehf!qtsbn`dml*!cfhjose`gjgp`xsfo!=>!se`sfr`bdl1}}se`sfr`bdl2<jg!)sbn`npef`tfu*!cfhjoqtsbn`sebub=>qtsbn`sebub1<foefmtfqtsbn`sebub=>qtsbn`sebub2<foebmxbzt!A!)qptfehf!eqj`qdml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjosegjgp`tzod`t=>2(c1<foefmtfsegjgp`tzod`t=>segjgp`tzod<foebttjho!segjgp`tzods>segjgp`tzod')"segjgp`tzod`t*<bmxbzt!A!)qptfehf!eqj`qdml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjosegjgp`tzod=>2(c1<foefmtf!jg)se`gjgp`stu*segjgp`tzod=>2(c1<fmtf!jg)sbn`se`fnq*segjgp`tzod=>!2(c2<foe00njqj!uy!eqj!qjyfmbmxbzt!A!)qptfehf!eqj`qdml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoef`dou=>3(c1<foefmtf!jg)iptu`eqj`ef*ef`dou=>ef`dou,2(c2<fmtfef`dou=>3(c1<foebttjho!eqj`gjgp`se>!segjgp`tzods}))ef`dou>>3(c22*@2(c1;iptu`eqj`ef*<bmxbzt!A!)qptfehf!eqj`qdml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjose`ebub`qtsbn`t=>43(c1<00!se`ebub`qtsbn`u=>35(c1<foefmtf!cfhjose`ebub`qtsbn`t=>se`ebub`qtsbn<00!se`ebub`qtsbn`u=>se`ebub`qtsbn`t<foefoe00!bmxbzt!A!)+*!cfhjo00!dbtf)ef`dou*00!3(e1;!iptu`eqj`e=>se`ebub`qtsbn\42;9^<00!3(e2;!iptu`eqj`e=>|se`ebub`qtsbn`t\8;1^-se`ebub`qtsbn\42;27^~<00!3(e3;!iptu`eqj`e=>|se`ebub`qtsbn`t\26;1^-se`ebub`qtsbn\42;35^~<00!3(e4;!iptu`eqj`e=>se`ebub`qtsbn`t\34;1^<00!efgbvmu;!iptu`eqj`e=>se`ebub`qtsbn\42;27^<00!foedbtf00!foebmxbzt!A!)+*!cfhjodbtf)ef`dou*3(e1;!iptu`eqj`e=>|se`ebub`qtsbn\8;1^-se`ebub`qtsbn\26;9^-se`ebub`qtsbn\34;27^~<3(e2;!iptu`eqj`e=>|se`ebub`qtsbn`t\42;35^-se`ebub`qtsbn\8;1^-se`ebub`qtsbn\26;9^~<3(e3;!iptu`eqj`e=>|se`ebub`qtsbn`t\34;27^-se`ebub`qtsbn`t\42;35^-se`ebub`qtsbn\8;1^~<3(e4;!iptu`eqj`e=>|se`ebub`qtsbn`t\26;9^-se`ebub`qtsbn`t\34;27^-se`ebub`qtsbn`t\42;35^~<efgbvmu;!iptu`eqj`e=>|se`ebub`qtsbn\8;1^-se`ebub`qtsbn\26;9^-se`ebub`qtsbn\34;27^~<foedbtffoe00!bmxbzt!A!)+*!cfhjo00!dbtf)ef`dou*00!3(e1;!iptu`eqj`e=>|se`ebub`qtsbn\26;9^-se`ebub`qtsbn\42;27^~<00!3(e2;!iptu`eqj`e=>|se`ebub`qtsbn\34;27^-se`ebub`qtsbn`t\8;1^-se`ebub`qtsbn\42;35^~<00!3(e3;!iptu`eqj`e=>|se`ebub`qtsbn\42;35^-se`ebub`qtsbn`t\26;1^~<00!3(e4;!iptu`eqj`e=>|se`ebub`qtsbn\8;1^-se`ebub`qtsbn\34;9^~<00!efgbvmu;!iptu`eqj`e=>se`ebub`qtsbn\42;27^<00!foedbtf00!foe00!bmxbzt!A!)+*!cfhjo00!dbtf)ef`dou*00!3(e1;!iptu`eqj`e>se`ebub`qtsbn`t\42;9^<00!3(e2;!iptu`eqj`e>|se`ebub`qtsbn`u\8;1^-se`ebub`qtsbn`t\42;27^~<00!3(e3;!iptu`eqj`e>|se`ebub`qtsbn`u\26;1^-se`ebub`qtsbn`t\42;35^~<00!3(e4;!iptu`eqj`e>se`ebub`qtsbn`u\34;1^<00!efgbvmu;!iptu`eqj`e>se`ebub`qtsbn`t\42;27^<00!foedbtf00!foeqtsbn`dusm`upq`sbn1!v`qtsbn`dusm`upq1)/DL!!!!!!!!!!!!!!!!!)dl*-/DL`O!!!!!!!!!!!!!!!)dl`o*-/DT`O!!!!!!!!!!!!!!!)dt`o*-/SXET!!!!!!!!!!!!!!!)sxet*-/ER`SBN!!!!!!!!!!!!!)er*-/stuo!!!!!!!!!!!!!!!!)stuo*-/eqj`qdml!!!!!!!!!!!)njqjuy`dml*-/qtsbn`dml!!!!!!!!!!!)qtsbn`dml*-/qtsbn`dml`dml!!!!!!!!)qtsbn`dml`dml1*-/qtsbn`dml`xs!!!!!!!!)qtsbn`dml`xs1*-/qtsbn`dml`se!!!!!!!!)qtsbn`dml`se1*-/bees`dms!!!!!!!!!!!!!)bees`dms1*-/qtsbn`sez!!!!!!!!!!!!)qtsbn`sez*-/dusm`ipme!!!!!!!!!!!!!!)dusm`ipme1*-/sygjgp`qgvmm!!!!!!!!!!!)sygjgp`qgvmm*-/uygjgp`qfnq!!!!!!!!!!!!)uygjgp`qfnq*-/xs`se`tfu!!!!!!!!!!!!!!)xs`se`tfu1*-!!001!xs!!2!se/qtsbn`xs`sfr!!!!!!!!!!!)qtsbn`xs`sfr1*-/qtsbn`se`sfr!!!!!!!!!!!)qtsbn`se`sfr1*-/se`sfr`bdl!!!!!!!!!)se`sfr`bdl1*-/xs`sfr`bdl!!!!!!!!!)xs`sfr`bdl1*-/qtsbn`xebub!!!!!!!!!!!!)qtsbn`xebub1*-/qtsbn`sebub!!!!!!!!!!!!)qtsbn`sebub1*-/ce`nffu!!!!!!!!!!!!!!!!)ce`nffu1*-/mudz`npef!!!!!!!!!!!!!!)mudz`npef1*-/uftu!!!!!!!!!!!!!!!)*-/qtsbn`dusm!!!!!!!!!!)qtsbn`dusm*-/qtsbn`bees`ndv!!!!!!)qtsbn`bees`ndv*-/qtsbn`gjojti!!!!!!!)qtsbn`gjojti1*-/sbn`qpxfsvq`po!!!!!)sbn`qpxfsvq`po**<efgqbsbn!v`qtsbn`dusm`upq1/SBN`CPVOESZ>GSBNF`UPUBM<bttjho!ndv`qtsbn`sebub1>qtsbn`sebub1<bttjho!ndv`qtsbn`sebub2>qtsbn`sebub2<bttjho!qtsbn`ebub`mpbe1>xs`sfr`bdl1<bttjho!qtsbn`ebub`mpbe2>xs`sfr`bdl2<bttjho!qtsbn`se`wbm1>se`sfr`bdl1<bttjho!qtsbn`se`wbm2>se`sfr`bdl2<00!bttjho!qtsbn`gjojti>qtsbn`gjojti1<qtsbn`dusm`upq`sbn2!v`qtsbn`dusm`upq2)/DL!!!!!!!!!!!!!!!!!)dl2*-/DL`O!!!!!!!!!!!!!!!)dl`o2*-/DT`O!!!!!!!!!!!!!!!)dt`o2*-/SXET!!!!!!!!!!!!!!!)sxet2*-/ER`SBN!!!!!!!!!!!!!)er2*-/stuo!!!!!!!!!!!!!!!!)stuo*-/eqj`qdml!!!!!!!!!!!)njqjuy`dml*-/qtsbn`dml!!!!!!!!!!!)qtsbn`dml*-/qtsbn`dml`dml!!!!!!!!)qtsbn`dml`dml2*-/qtsbn`dml`xs!!!!!!!!)qtsbn`dml`xs2*-/qtsbn`dml`se!!!!!!!!)qtsbn`dml`se2*-/bees`dms!!!!!!!!!!!!!)bees`dms2*-/qtsbn`sez!!!!!!!!!!!!)qtsbn`sez*-/dusm`ipme!!!!!!!!!!!!!!)dusm`ipme2*-/sygjgp`qgvmm!!!!!!!!!!!)sygjgp`qgvmm*-/uygjgp`qfnq!!!!!!!!!!!!)uygjgp`qfnq*-/xs`se`tfu!!!!!!!!!!!!!!)xs`se`tfu2*-!!001!xs!!2!se/qtsbn`xs`sfr!!!!!!!!!!!)qtsbn`xs`sfr2*-/qtsbn`se`sfr!!!!!!!!!!!)qtsbn`se`sfr2*-/se`sfr`bdl!!!!!!!!!)se`sfr`bdl2*-/xs`sfr`bdl!!!!!!!!!)xs`sfr`bdl2*-/qtsbn`xebub!!!!!!!!!!!!)qtsbn`xebub2*-/qtsbn`sebub!!!!!!!!!!!!)qtsbn`sebub2*-/ce`nffu!!!!!!!!!!!!!!!!)ce`nffu2*-/mudz`npef!!!!!!!!!!!!!!)mudz`npef2*-/qtsbn`dusm!!!!!!!!!!)qtsbn`dusm*-/qtsbn`bees`ndv!!!!!!)qtsbn`bees`ndv*-/qtsbn`gjojti!!!!!!!)qtsbn`gjojti2*-/sbn`qpxfsvq`po!!!!!)sbn`qpxfsvq`po**<efgqbsbn!v`qtsbn`dusm`upq2/SBN`CPVOESZ>GSBNF`UPUBM<bttjho!qtsbn`gjojti>qtsbn`gjojti1'qtsbn`gjojti2<foenpevmfnpevmf!qtsbn`dusm`upq`sbn1)pvuqvu!!!!!!!!!!!!!!!!!!!!!!DL-pvuqvu!!!!!!!!!!!!!!!!!!!!!!DL`O-pvuqvu!!!!!!!!!!!!!!!!!!!!!!DT`O-jopvu!!!!!!!!!!!!!!!!!!!!!!!SXET-jopvu\8;1^!!!!!!!!!!!!!!!!!!ER`SBN-joqvu!!!!!!!!!!!!!!!!!!!!!!!stuo!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!eqj`qdml!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dml!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dml`dml!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dml`xs!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dml`se!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!sbn`qpxfsvq`po!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!bees`dms!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`sez!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!dusm`ipme!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!sygjgp`qgvmm-joqvu!!!!!!!!!!!!!!!!!!!!!!!uygjgp`qfnq-joqvu!!!!!!!!!!!!!!!!!!!!!!!xs`se`tfu-pvuqvu!!sfh!!!!!!!!!!!!!!!!!qtsbn`xs`sfr-pvuqvu!!sfh!!!!!!!!!!!!!!!!!qtsbn`se`sfr-00!pvuqvu!!!!!!!!!!!!!!!!!!!!!!!ce`nffu`g-pvuqvu!!!!!!!!!!!!!!!!!!!!!!se`sfr`bdl-pvuqvu!!!!!!!!!!!!!!!!!!!!!!xs`sfr`bdl-pvuqvu!!!!!!!!!!!!!!!!!!!!!!ce`nffu-pvuqvu!!!!!!!!!!!!!!!!!!!!!!mudz`npef-joqvu\26;1^!!!!!!!!!!!!!!!!!qtsbn`xebub-pvuqvu\26;1^!!!!!!!!!!!!!!!!qtsbn`sebub-joqvu\8;1^!!!!!!!!!!!!!!!!!!qtsbn`dusm!!!!!!!!!!!!!!-00!!qtsbn`dusm\8^!!segjgp`se00qtsbn`gjgp`stuo>qtsbn`dusm\7^<00!!qtsbn`dusm\6^!qtsbn!stuo00!!qtsbn`dusm\5^!joju!npef00!!qtsbn`dusm\3^!!qtsbn!sfh!tfu!!!1!sfh1!!2!sfh200!!qtsbn`dusm\2^!!se00!!qtsbn`dusm\1^!!xsjoqvu\31;1^!!!!!!!!!!!!!!!!!qtsbn`bees`ndv!!!!!!!!-pvuqvu!!!!!!!!!!!!!!!!!!!!!!qtsbn`gjojti-pvuqvu\8;1^!!!!!!!!!!!!!!!!!!!!!uftu-joqvu!!!!!!!!!!!!!!!!!!!!!!!!iptu`eqj`ef-pvuqvu!sfh\34;1^!!!!!!!!!!!!!iptu`eqj`e!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!sftfu`eqj`o*<xjsf!!!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dmly3!!!!!!!!!!!!<xjsf!!!!!!!!!!!!!!!!!!!!!!!!!vts`se`sfr!!!!!!!!<sfh!!!!!!!!!!!!!!!!!!!!!!!!!vts`se`sfr2!!!!!!!!<xjsf!!!!!!!!!!!!!!!!!!!!!!!!!vts`xs`sfr!!!!!!!!<sfh!!!!!!!!!!!!!!!!!!!!!!!!!vts`xs`sfr2!!!!!!!!<xjsf!!!!\33;1^!!!!!!!!!!!!!!!qtsbn`bees!!!!!!!!!!<xjsf!!!!\31;1^!!!!!!!!!!!!!!!qtsbn`bees1!!!!!!!!!!<sfh!!!!\31;1^!!!!!!!!!!!!!!!qtsbn`bees`tfu!!!!!!!!!!<sfh!!!!\31;1^!!!!!!!!!!!!!!!vts`bees1!!!!!!!!!!<sfh!vts`se`sfr`g<sfh!vts`se`sfr`t<sfh!vts`se`sfr`u<sfh!vts`xs`sfr`g<sfh!vts`xs`sfr`t<sfh!vts`xs`sfr`u<xjsf!vts`se`sfr`s<xjsf!vts`xs`sfr`s<sfh\2;1^!efmbz`tfm`g<xjsf!qtsbn`stuo<sfh\7;1^!qtsbn`dou<sfh\7;1^!qtsbn`dou2<xjsf!cvstu`foe<xjsf!sxet`f<sfh!npef`tfm<xjsf!dml`tfm<xjsf!dml`jp<sfh!ndv`se`sfr<sfh!ndv`xs`sfr<sfh!vts`se`sfr`bdl`t<sfh!vts`xs`sfr`bdl`t<sfh!dusm`sez<xjsf!xs`bdl`g<xjsf!xs`bdl`s<xjsf!se`bdl`g<xjsf!se`bdl`s<xjsf!ce`nffu`g<sfh!ce`nffu`efu<qbsbnfufs!SBN`CPVOESZ!>!32(e2493511<00qtsbnbmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoqtsbn`bees`tfu=>31(c1<foefmtf!cfhjoqtsbn`bees`tfu=>qtsbn`bees`ndv<foefoebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`se`sfr`g=>2(c1<vts`se`sfr`t=>2(c1<vts`se`sfr`u=>2(c1<foefmtf!cfhjovts`se`sfr`g=>qtsbn`dusm\2^<vts`se`sfr`t=>vts`se`sfr`g<vts`se`sfr`u=>vts`se`sfr`t<foefoebttjho!vts`se`sfr`s>vts`se`sfr`t')"vts`se`sfr`u*<bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`xs`sfr`g=>2(c1<vts`xs`sfr`t=>2(c1<vts`xs`sfr`u=>2(c1<foefmtf!cfhjovts`xs`sfr`g=>qtsbn`dusm\1^<vts`xs`sfr`t=>vts`xs`sfr`g<vts`xs`sfr`u=>vts`xs`sfr`t<foefoebttjho!vts`xs`sfr`s>vts`xs`sfr`t')"vts`xs`sfr`u*<bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjondv`se`sfr=>2(c1<foefmtf!jg)vts`se`sfr`s*ndv`se`sfr=>2(c2<fmtf!jg)se`sfr`bdl*ndv`se`sfr=>2(c1<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjondv`xs`sfr=>2(c1<foefmtf!jg)vts`xs`sfr`s*ndv`xs`sfr=>2(c2<fmtf!jg)xs`sfr`bdl*ndv`xs`sfr=>2(c1<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjonpef`tfm=>2(c1<foefmtfnpef`tfm=>qtsbn`dusm\5^<foebttjho!qtsbn`stuo>qtsbn`dusm\6^<bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjodusm`sez=>2(c1<foefmtf!jg)qtsbn`xs`sfr}}qtsbn`se`sfr*dusm`sez=>2(c1<00fmtf!jg)xs`bdl`g}}se`bdl`g*fmtf!jg)qtsbn`gjojti*dusm`sez=>2(c2<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`xs`sfr`bdl`t=>2(c1<foefmtfvts`xs`sfr`bdl`t=>xs`sfr`bdl<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`se`sfr`bdl`t=>2(c1<foefmtfvts`se`sfr`bdl`t=>se`sfr`bdl<foebttjho!xs`bdl`g>!vts`xs`sfr`bdl`t')"xs`sfr`bdl*<bttjho!xs`bdl`s>!xs`sfr`bdl')"vts`xs`sfr`bdl`t*<bttjho!se`bdl`g>!vts`se`sfr`bdl`t')"se`sfr`bdl*<bttjho!se`bdl`s>!se`sfr`bdl')"vts`se`sfr`bdl`t*<00qtsbn!xs!sebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoqtsbn`xs`sfr=>2(c1<foefmtf!jg)qtsbn`sez*cfhjojg)xs`sfr`bdl}}dusm`ipme*qtsbn`xs`sfr=>2(c1<fmtf!jg))"xs`se`tfu*'')"uygjgp`qfnq*''dusm`sez*qtsbn`xs`sfr=>2(c2<foefmtfqtsbn`xs`sfr=>2(c1<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoqtsbn`se`sfr=>2(c1<foefmtf!jg)qtsbn`sez*cfhjojg)se`sfr`bdl}}dusm`ipme*qtsbn`se`sfr=>2(c1<fmtf!jg))xs`se`tfu*'')"sygjgp`qgvmm*''dusm`sez*qtsbn`se`sfr=>2(c2<foefmtfqtsbn`se`sfr=>2(c1<foebttjho!vts`xs`sfr>qtsbn`xs`sfr}ndv`xs`sfr<bttjho!vts`se`sfr>qtsbn`se`sfr}ndv`se`sfr<00qtsbn1!beesbmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`bees1=>32(c1<foefmtf!jg)ce`nffu`g}})"qtsbn`sez*}}bees`dms*vts`bees1=>32(i1<fmtf!jg))xs`bdl`s}}se`bdl`s*''qtsbn`sez*vts`bees1=>vts`bees1,8(e75<foebttjho!qtsbn`bees1>!qtsbn`sez@!vts`bees1!;qtsbn`bees`tfu<bttjho!ce`nffu`g>)vts`bees1>>SBN`CPVOESZ*<!00831+2391!+40300!bttjho!ce`nffu`g>)se`sfr`bdl'')vts`bees1>>32(e2493511**})xs`sfr`bdl'')vts`bees1>>32(e2373639**<!00se!831+2391!+403!;!xs!831+227:!+40300!bttjho!ce`nffu`g>)se`sfr`bdl'')vts`bees1>>32(e2493511**})xs`sfr`bdl'')vts`bees1>>32(e741831**<!00se!831+2391!+403!;!xs!831+695!+40300!bttjho!ce`nffu`g>)vts`bees1\31;1^>>31(e9751*<!00gps!uftubmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoce`nffu`efu=>2(c1<foefmtf!jg)ce`nffu`g*ce`nffu`efu=>2(i2<fmtf!jg)qtsbn`gjojti*ce`nffu`efu=>2(i1<foebttjho!ce`nffu>!ce`nffu`efu''qtsbn`gjojti<qtsbn`dusm`eesjp!v`qtsbn`dusm`eesjp)/qtsbn`dml!!!!!!!!!!!!!)DL*!!!-/qtsbn`dmlo!!!!!!!!!!!)DL`O*!!!-/qtsbn`dto!!!!!!!!!!)DT`O*!!!-/qtsbn`sxet!!!!!!!!!!!)SXET*!!!-/qtsbn`er!!!!!!!!!!!!!)ER`SBN*!-/stuo!!!!!!!!!!!)stuo*!!-/dml!!!!!!!!!!!!)qtsbn`dml*!!!-/dml`:1!!!!!!!!!)qtsbn`dml`dml*!!!-/dml`jp!!!!!!!!!)dml`jp*!!!-/dml`tfm!!!!!!!!!)dml`tfm*!!!-/sbn`qpxfsvq`po!)sbn`qpxfsvq`po*!!!-/se`sfr!!!!!!!!!)vts`se`sfr*!!!-/xs`sfr!!!!!!!!!)vts`xs`sfr*!!!-/npef`tfm!!!!!!!)npef`tfm*!!-/bees!!!!!!!!!!!)qtsbn`bees1*!!!-/gjojti!!!!!!!!!)qtsbn`gjojti*!!-/ebub`jo!!!!!!!!)qtsbn`xebub*!!!-/ebub`pvu!!!!!!!)qtsbn`sebub*!!!-/se`bdl!!!!!!!!!)se`sfr`bdl*!!!!!-/uftu!!!!!!!!!!!)uftu*!!!-/mudz`npef!!!!!!!!!!)mudz`npef*!!-/xs`bdl!!!!!!!!!)xs`sfr`bdl**<dmldusmtxjudi`3!!v`txd3)/dmljo1)qtsbn`dml`xs*-/dmljo2)qtsbn`dml`se*-/gq`tfm)dml`tfm*-/dmlpvu)dml`jp**<foenpevmfnpevmf!qtsbn`dusm`upq`sbn2)pvuqvu!!!!!!!!!!!!!!!!!!!!!!DL-pvuqvu!!!!!!!!!!!!!!!!!!!!!!DL`O-pvuqvu!!!!!!!!!!!!!!!!!!!!!!DT`O-jopvu!!!!!!!!!!!!!!!!!!!!!!!SXET-jopvu\8;1^!!!!!!!!!!!!!!!!!!ER`SBN-joqvu!!!!!!!!!!!!!!!!!!!!!!!stuo!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!eqj`qdml!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dml!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dml`dml!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dml`xs!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dml`se!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!sbn`qpxfsvq`po!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!bees`dms!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!qtsbn`sez!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!dusm`ipme!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!sygjgp`qgvmm-joqvu!!!!!!!!!!!!!!!!!!!!!!!uygjgp`qfnq-joqvu!!!!!!!!!!!!!!!!!!!!!!!xs`se`tfu-pvuqvu!!sfh!!!!!!!!!!!!!!!!!qtsbn`xs`sfr-pvuqvu!!sfh!!!!!!!!!!!!!!!!!qtsbn`se`sfr-pvuqvu!!!!!!!!!!!!!!!!!!!!!!se`sfr`bdl-pvuqvu!!!!!!!!!!!!!!!!!!!!!!xs`sfr`bdl-pvuqvu!!!!!!!!!!!!!!!!!!!!!!ce`nffu-pvuqvu!!!!!!!!!!!!!!!!!!!!!!mudz`npef-joqvu\26;1^!!!!!!!!!!!!!!!!!qtsbn`xebub-pvuqvu\26;1^!!!!!!!!!!!!!!!!qtsbn`sebub-joqvu\8;1^!!!!!!!!!!!!!!!!!!qtsbn`dusm!!!!!!!!!!!!!!-00!!qtsbn`dusm\8^!!segjgp`se00qtsbn`gjgp`stuo>qtsbn`dusm\7^<00!!qtsbn`dusm\6^!qtsbn!stuo00!!qtsbn`dusm\5^!joju!npef00!!qtsbn`dusm\3^!!qtsbn!sfh!tfu!!!1!sfh1!!2!sfh200!!qtsbn`dusm\2^!!se00!!qtsbn`dusm\1^!!xsjoqvu\31;1^!!!!!!!!!!!!!!!!!qtsbn`bees`ndv!!!!!!!!-pvuqvu!!!!!!!!!!!!!!!!!!!!!!qtsbn`gjojti-pvuqvu\8;1^!!!!!!!!!!!!!!!!!!!!!uftu-joqvu!!!!!!!!!!!!!!!!!!!!!!!!iptu`eqj`ef-pvuqvu!sfh\34;1^!!!!!!!!!!!!!iptu`eqj`e!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!sftfu`eqj`o*<xjsf!!!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dmly3!!!!!!!!!!!!<xjsf!!!!!!!!!!!!!!!!!!!!!!!!!vts`se`sfr!!!!!!!!<sfh!!!!!!!!!!!!!!!!!!!!!!!!!vts`se`sfr2!!!!!!!!<xjsf!!!!!!!!!!!!!!!!!!!!!!!!!vts`xs`sfr!!!!!!!!<sfh!!!!!!!!!!!!!!!!!!!!!!!!!vts`xs`sfr2!!!!!!!!<xjsf!!!!\33;1^!!!!!!!!!!!!!!!qtsbn`bees!!!!!!!!!!<xjsf!!!!\31;1^!!!!!!!!!!!!!!!qtsbn`bees1!!!!!!!!!!<sfh!!!!\31;1^!!!!!!!!!!!!!!!qtsbn`bees`tfu!!!!!!!!!!<sfh!!!!\31;1^!!!!!!!!!!!!!!!vts`bees1!!!!!!!!!!<sfh!vts`se`sfr`g<sfh!vts`se`sfr`t<sfh!vts`se`sfr`u<sfh!vts`xs`sfr`g<sfh!vts`xs`sfr`t<sfh!vts`xs`sfr`u<xjsf!vts`se`sfr`s<xjsf!vts`xs`sfr`s<sfh\2;1^!efmbz`tfm`g<xjsf!qtsbn`stuo<sfh\7;1^!qtsbn`dou<sfh\7;1^!qtsbn`dou2<xjsf!cvstu`foe<xjsf!sxet`f<sfh!npef`tfm<xjsf!dml`tfm<xjsf!dml`jp<sfh!ndv`se`sfr<sfh!ndv`xs`sfr<sfh!vts`se`sfr`bdl`t<sfh!vts`xs`sfr`bdl`t<sfh!dusm`sez<xjsf!xs`bdl`g<xjsf!xs`bdl`s<xjsf!se`bdl`g<xjsf!se`bdl`s<xjsf!ce`nffu`g<sfh!ce`nffu`efu<qbsbnfufs!SBN`CPVOESZ!>!32(e2493511<00qtsbnbmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoqtsbn`bees`tfu=>31(c1<foefmtf!cfhjoqtsbn`bees`tfu=>qtsbn`bees`ndv<foefoebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`se`sfr`g=>2(c1<vts`se`sfr`t=>2(c1<vts`se`sfr`u=>2(c1<foefmtf!cfhjovts`se`sfr`g=>qtsbn`dusm\2^<vts`se`sfr`t=>vts`se`sfr`g<vts`se`sfr`u=>vts`se`sfr`t<foefoebttjho!vts`se`sfr`s>vts`se`sfr`t')"vts`se`sfr`u*<bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`xs`sfr`g=>2(c1<vts`xs`sfr`t=>2(c1<vts`xs`sfr`u=>2(c1<foefmtf!cfhjovts`xs`sfr`g=>qtsbn`dusm\1^<vts`xs`sfr`t=>vts`xs`sfr`g<vts`xs`sfr`u=>vts`xs`sfr`t<foefoebttjho!vts`xs`sfr`s>vts`xs`sfr`t')"vts`xs`sfr`u*<bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjondv`se`sfr=>2(c1<foefmtf!jg)vts`se`sfr`s*ndv`se`sfr=>2(c2<fmtf!jg)se`sfr`bdl*ndv`se`sfr=>2(c1<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjondv`xs`sfr=>2(c1<foefmtf!jg)vts`xs`sfr`s*ndv`xs`sfr=>2(c2<fmtf!jg)xs`sfr`bdl*ndv`xs`sfr=>2(c1<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjonpef`tfm=>2(c1<foefmtfnpef`tfm=>qtsbn`dusm\5^<foebttjho!qtsbn`stuo>qtsbn`dusm\6^<bmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjodusm`sez=>2(c1<foefmtf!jg)qtsbn`xs`sfr}}qtsbn`se`sfr*dusm`sez=>2(c1<00fmtf!jg)xs`bdl`g}}se`bdl`g*fmtf!jg)qtsbn`gjojti*dusm`sez=>2(c2<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`xs`sfr`bdl`t=>2(c1<foefmtfvts`xs`sfr`bdl`t=>xs`sfr`bdl<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`se`sfr`bdl`t=>2(c1<foefmtfvts`se`sfr`bdl`t=>se`sfr`bdl<foebttjho!xs`bdl`g>!vts`xs`sfr`bdl`t')"xs`sfr`bdl*<bttjho!xs`bdl`s>!xs`sfr`bdl')"vts`xs`sfr`bdl`t*<bttjho!se`bdl`g>!vts`se`sfr`bdl`t')"se`sfr`bdl*<bttjho!se`bdl`s>!se`sfr`bdl')"vts`se`sfr`bdl`t*<00qtsbn!xs!sebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoqtsbn`xs`sfr=>2(c1<foefmtf!jg)qtsbn`sez*cfhjojg)xs`sfr`bdl}}dusm`ipme*qtsbn`xs`sfr=>2(c1<fmtf!jg))"xs`se`tfu*'')"uygjgp`qfnq*''dusm`sez*qtsbn`xs`sfr=>2(c2<foefmtfqtsbn`xs`sfr=>2(c1<foebmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoqtsbn`se`sfr=>2(c1<foefmtf!jg)qtsbn`sez*cfhjojg)se`sfr`bdl}}dusm`ipme*qtsbn`se`sfr=>2(c1<fmtf!jg))xs`se`tfu*'')"sygjgp`qgvmm*''dusm`sez*qtsbn`se`sfr=>2(c2<foefmtfqtsbn`se`sfr=>2(c1<foebttjho!vts`xs`sfr>qtsbn`xs`sfr}ndv`xs`sfr<bttjho!vts`se`sfr>qtsbn`se`sfr}ndv`se`sfr<00qtsbn1!beesbmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjovts`bees1=>32(c1<foefmtf!jg)ce`nffu`g}})"qtsbn`sez*}}bees`dms*vts`bees1=>32(i1<fmtf!jg))xs`bdl`s}}se`bdl`s*''qtsbn`sez*vts`bees1=>vts`bees1,8(e75<foebttjho!qtsbn`bees1>!qtsbn`sez@!vts`bees1!;qtsbn`bees`tfu<bttjho!ce`nffu`g>)vts`bees1>>SBN`CPVOESZ*<!00831+2391!+40300!bttjho!ce`nffu`g>)se`sfr`bdl'')vts`bees1>>32(e2493511**})xs`sfr`bdl'')vts`bees1>>32(e2373639**<!00se!831+2391!+403!;!xs!831+227:!+40300!bttjho!ce`nffu`g>)se`sfr`bdl'')vts`bees1>>32(e2493511**})xs`sfr`bdl'')vts`bees1>>32(e741831**<!00se!831+2391!+403!;!xs!831+695!+40300!bttjho!ce`nffu`g>)vts`bees1\31;1^>>31(e9751*<!00gps!uftubmxbzt!A!)qptfehf!qtsbn`dml!ps!ofhfehf!stuo*!cfhjojg!)"stuo*!cfhjoce`nffu`efu=>2(c1<foefmtf!jg)ce`nffu`g*ce`nffu`efu=>2(i2<fmtf!jg)qtsbn`gjojti*ce`nffu`efu=>2(i1<foebttjho!ce`nffu>!ce`nffu`efu''qtsbn`gjojti<00!qtsbn`dusm`eesjp`mwet!v`qtsbn`dusm`eesjp`mwet)qtsbn`dusm`eesjp!v`qtsbn`dusm`eesjp`mwet)/qtsbn`dml!!!!!!!!!!!!!)DL*!!!-/qtsbn`dmlo!!!!!!!!!!!)DL`O*!!!-/qtsbn`dto!!!!!!!!!!)DT`O*!!!-/qtsbn`sxet!!!!!!!!!!!)SXET*!!!-/qtsbn`er!!!!!!!!!!!!!)ER`SBN*!-/stuo!!!!!!!!!!!)stuo*!!-/dml!!!!!!!!!!!!)qtsbn`dml*!!!-/dml`:1!!!!!!!!!)qtsbn`dml`dml*!!!-/dml`jp!!!!!!!!!)dml`jp*!!!-/dml`tfm!!!!!!!!!)dml`tfm*!!!-/sbn`qpxfsvq`po!)sbn`qpxfsvq`po*!!!-/se`sfr!!!!!!!!!)vts`se`sfr*!!!-/xs`sfr!!!!!!!!!)vts`xs`sfr*!!!-/npef`tfm!!!!!!!)npef`tfm*!!-/bees!!!!!!!!!!!)qtsbn`bees1*!!!-/gjojti!!!!!!!!!)qtsbn`gjojti*!!-/ebub`jo!!!!!!!!)qtsbn`xebub*!!!-/ebub`pvu!!!!!!!)qtsbn`sebub*!!!-/se`bdl!!!!!!!!!)se`sfr`bdl*!!!!!-/mudz`npef!!!!!!!!!!)mudz`npef*!!-/uftu!!!!!!!!!!!)*!!!-/xs`bdl!!!!!!!!!)xs`sfr`bdl**<dmldusmtxjudi`4!!v`txd4)/dmljo1)qtsbn`dml`xs*-/dmljo2)qtsbn`dml`se*-/gq`tfm)dml`tfm*-/dmlpvu)dml`jp**<foenpevmfaujnftdbmf!2ot02qtnpevmf!qtsbn`dusm`eesjp)pvuqvu!!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dml!!!!!!!!!!!!!!!!!-pvuqvu!!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dmlo!!!!!!!!!!!!!!!-pvuqvu!!!!!!!!!!!!!!!!!!!!!!!!qtsbn`dto!!!!!!!!!!!!!!!-jopvu!!!!!!!!!!!!!!!!!!!!!!!!qtsbn`sxet!!!!!!!!!!!!!!!-jopvu\8;1^!!!!!!!!!!!!!!!!!!!!qtsbn`er!!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!stuo!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!dml!!!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!dml`:1!!!!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!dml`jp!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!sbn`qpxfsvq`po!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!se`sfr!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!xs`sfr!!!!!!!!!!!!!-joqvu!!!!!!!!!!!!!!!!!!!!!!!!npef`tfm!!!!!!!!!!!-00!2;!sfh!!!1;!ebubjoqvu!!!\31;1^!!!!!!!!!!!!!!!bees!!!!!!!!!!!!!!!-joqvu!!!\26;1^!!!!!!!!!!!!!!!ebub`jo!!!!!!!!!!!!-pvuqvu!!\26;1^!!!!!!!!!!!!!!!ebub`pvu!!!!!!!!!!!-pvuqvu!!!!!!!!!!!!!!!!!!!!!!!se`bdl!!!!!!!!!!!!!!-pvuqvu!!!sfh!!!!!!!!!!!!!!!!!!!!dml`tfm!!!!!!!!!!!!!!-pvuqvu\8;1^!uftu-pvuqvu!!sfh!!!!!!!!!!!!!!!!!!!gjojti-pvuqvu!!!!!!!!!!!!!!!!!!!!!!!!!!mudz`npef-pvuqvu!!!sfh!!!!!!!!!!!!!!!!!!!!xs`bdl*<sfh\58;1^!qtsbn`bees<sfh\4;1^!dvss`tu<sfh\4;1^!ofyu`tu<sfh!xs`gjgp`fo<sfh!se`gjgp`fo<sfh!dt`fo<sfh\7;1^!udou<xjsf!dne`gjojti<xjsf!mudz`gjojti1<xjsf!mudz`gjojti`ec<xjsf!mudz`gjojti<xjsf!ebub`usbot`gjojti<xjsf!ebub`sy`gjojti<xjsf!mudz`hfu<sfh!mudz`epvcmf<sfh\26;1^!gjgp`x`ebub<sfh!dto<sfh!dml`fo<sfh!er`fo<sfh!sxet`fo<sfh!se`ebub`bdl<sfh!sxet`j`t<sfh!se`ebub`ufsn<0000y3!dmlxjsf!dto`y3<xjsf!erfo`y3<xjsf!dmlfo`y3<xjsf!sxetfo`y3<xjsf\8;1^!er`y3<xjsf!xs`gjgp`se`fo<xjsf!xs`gjgp`fnq<sfh\8;1^!cvstu`dou<sfh!se`ebub`ufsn`t<xjsf!se`ebub`ufsn`s<xjsf!sgjgp`fnq<xjsf\8;1^!er`se`y3<sfh\8;1^!er`j`t<sfh!xs`gjgp`se`fo`t<sfh!dto`y3`t<sfh!erfo`y3`t<sfh!dmlfo`y3`t<sfh!sxetfo`y3`t<sfh\8;1^!er`y3`t<xjsf!se`ebu`foe`jou<xjsf!se`ebu`foe`qsf<sfh!se`ebu`foe`g<sfh!se`ebu`foe`t<xjsf!!se`ebu`foe<sfh!se`nbtl<sfh!se`efu<sfh!sgjgp`vq`xfo<sfh\4;1^!dml`ejgg<xjsf!se`gjgp`fo`g<sfh!xs`gjgp`se`fo`u<sfh!dmlfo`y3`u<sfh!se`ebub`ufsn`u<sfh\8;1^!er`j`g<sfh!sxet`qibtf`efu<sfh!sxet`qibtf`efu`t<xjsf!sxet`qibtf`efu`g<sfh\2;1^!sxet`hfu`mpdl<sfh!qibtf`npef<xjsf\2;1^!sxet`hfu<xjsf\26;1^!er`hfu<sfh\26;1^!er`hfu`t<sfh\26;1^!er`hfu`u<sfh\2;1^!sxet`hfu`t<sfh\2;1^!sxet`hfu`u<xjsf!dml`sy<xjsf!sygjgp`fnq<xjsf!sygjgp`se<sfh\2;1^!sxet`hfu`g<sfh!dml`fo`:1<sfh!dml`fo`:1`t<sfh!dml`fo`:1`u<sfh\2;1^!sxet`tfu<xjsf\26;1^!ebub`pvu`g<xjsf!mudz`sy`gjojti<sfh!sygjgp`se`t<sfh!sygjgp`se`u<sfh!se`efu`t<sfh!se`efu`u<qbsbnfufs!JEMF!!!!!!!>!5(e1!<qbsbnfufs!DT`TFM!!!!!>!5(e2!<qbsbnfufs!XS`DNE!!!!!>!5(e3!<qbsbnfufs!XS`SFH!!!!!>!5(e4!<qbsbnfufs!XS`EBU!!!!!>!5(e5!<qbsbnfufs!XS`EBU`MUD!>!5(e6!<qbsbnfufs!SE`DNE!!!!!>!5(e7!<qbsbnfufs!SE`EBU!!!!!>!5(e8!<qbsbnfufs!QPXFSPO`TFR!!!!!>!5(e9!<qbsbnfufs!XBJU`DT!!!!!>!5(e:!<qbsbnfufs!SE`EBU`MUD!!!!!>!5(e21!<qbsbnfufs!EMZ!>!1!<qbsbnfufs!mbufodz`joju!>!8(e9<!!00dne!)4*!,!mbufodz!)7*qbsbnfufs!mbufodz`sy!>!8(e6<!!00dne!)4*!,!mbufodz!)7*qbsbnfufs!mbufodz`joju`ec!>!8(e25<00dne!)4*!,!3!y!mbufodz!)7*qbsbnfufs!ebub`uy`gjojti!>!8(e83<!!00mbufodz`joju!,!75qbsbnfufs!ebub`uy`gjojti`ec!>!8(e89<00mbufodz`jojuy3!,75bmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*cfhjoudou!!!!=>!$EMZ!8(i1!<foefmtf!jg)xs`gjgp`fo*udou!!=>udou,2(c2<fmtfudou!!!!=>!$EMZ!8(i1!<foebttjho!dne`gjojti>)udou>>8(e4*<bttjho!mudz`gjojti1>)udou>>mbufodz`joju*<bttjho!mudz`sy`gjojti>)udou>>mbufodz`sy*<bttjho!mudz`gjojti`ec>)udou>>mbufodz`joju`ec*<bttjho!mudz`gjojti>!mudz`epvcmf!@mudz`gjojti`ec!;mudz`gjojti1!<bttjho!ebub`usbot`gjojti!>!mudz`epvcmf!@!)udou>>ebub`uy`gjojti`ec*!;!)udou>>ebub`uy`gjojti*<00!bttjho!mudz`hfu>!)udou>>8(e5*<bttjho!mudz`hfu>!)udou>>8(e7*<00000000joju!mbufodz!efubmxbztA)qptfehf!dml*cfhjosxet`hfu`t=>sxet`hfu<foebmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*cfhjomudz`epvcmf!!!!=>!$EMZ!2(i1!<foefmtf!jg)ofyu`tu>>JEMF*mudz`epvcmf!!=>!2(c1<fmtf!jg))sxet`hfu`t>>3(c22*'mudz`hfu*mudz`epvcmf!!=>!2(c2<foebttjho!mudz`npef>mudz`epvcmf<bmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*cfhjoqtsbn`bees!!!!=>!$EMZ!59(i1!<foefmtf!jg)xs`gjgp`fo''))dvss`tu>>SE`DNE*}})dvss`tu>>XS`DNE***qtsbn`bees!!=>|qtsbn`bees\42;1^-27(i1~<fmtfqtsbn`bees!=>!$EMZ!|se`sfr-npef`tfm-npef`tfm-22(c1-bees\31;4^-!24(i1-bees\3;1^~!<foe00!gjgp`qtsbn`xs!v`xs`gjgp)00!/epvu)|u2-sxetfo`y3-erfo`y3-dmlfo`y3-dto`y3-er`y3~*-!!0029cju00!/ejo)|9(c1-!sxet`fo-er`fo-dml`fo-dto-gjgp`x`ebub\8;1^-!5(c1-sxet`fo-er`fo-!dml`fo-dto-gjgp`x`ebub\26;9^~*-!0047cju00!/xsjufdml)dml*-00!/sfbedml)dml`y3*-00!/xsjuffo)xs`gjgp`fo*-00!/sfbefo)xs`gjgp`se`fo*-00!/sftfu)stuo*-00!/gvmm)*-00!/fnquz)xs`gjgp`fnq*00!*<00!gjgp`qtsbn`xs!v`xs`gjgp)00!/epvu)er`y3*-!!00:cju00!/ejo)|3(c1-gjgp`x`ebub\8;1^-gjgp`x`ebub\26;9^~*-!0029cju00!/xsjufdml)dml*-00!/sfbedml)dml`y3*-00!/xsjuffo)xs`gjgp`fo*-00!/sfbefo)xs`gjgp`se`fo*-00!/sftfu)stuo*-00!/gvmm)*-00!/fnquz)xs`gjgp`fnq*-00!/bmnptufnquz)*00!*<00!gjgp`qtsbn`dusm!v`xs`dusm`gjgp1)00!/epvu)|dmlfo`y3-dto`y3~*-00!/ejo)|dml`fo-dto-dml`fo-dto~*-00!/xsjufdml)dml*-00!/sfbedml)dml`y3*-00!/xsjuffo)xs`gjgp`fo*-00!/sfbefo)xs`gjgp`se`fo*-00!/sftfu)stuo*-00!/gvmm)*-00!/fnquz)*00!*<00!gjgp`qtsbn`dusm!v`xs`dusm`gjgp2)00!/epvu)|sxetfo`y3-erfo`y3~*-00!/ejo)|sxet`fo-er`fo-sxet`fo-er`fo~*-00!/xsjufdml)dml*-00!/sfbedml)dml`y3*-00!/xsjuffo)xs`gjgp`fo*-00!/sfbefo)xs`gjgp`se`fo*-00!/sftfu)stuo*-00!/gvmm)*-00!/fnquz)*00!*<bmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*se`ebu`foe`t!=>!$EMZ!2(c1!<fmtf!jg)se`sfr*se`ebu`foe`t!=>!$EMZ!2(c1!<fmtfse`ebu`foe`t=>$EMZ!se`ebu`foe`g<foebttjho!ebub`sy`gjojti>se`ebu`foe`t<00!bmxbztA)qptfehf!dml!ps!ofhfehf!stuo*00!cfhjo00!jg)stuo!>>!2(c1*00!se`gjgp`fo!=>!$EMZ!2(c1!<00!fmtf00!se`gjgp`fo=>$EMZ!!)sgjgp`fnq*<00!foe00!bttjho!se`gjgp`fo`g>!)sgjgp`fnq*<bmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*cfhjose`efu`t!!!!=>!!2(c1!<se`efu`u!!!!=>!!2(c1!<foefmtfcfhjose`efu`t!!!!=>!!se`efu<se`efu`u!!!!=>!!se`efu`t<foefoebttjho!uftu\1^>se`nbtl<bttjho!uftu\2^>sxet`hfu`g\1^<bttjho!uftu\3^>sxet`hfu`g\2^<bttjho!uftu\4^>se`sfr<bttjho!uftu\5^>se`efu<bttjho!uftu\6^>ebub`pvu`g>>27(i1211<bttjho!uftu\7^>ebub`pvu`g>>27(i1413<bttjho!uftu\8^>gjojti<00efcvhxbsf`w3`2!v`ech)00!!!!/usjh`pvu`1)*-00!!/ebub`jo`1)|se`sfr-xs`sfr-se`bdl-xs`bdl-!!se`ebu`foe`g-se`efu-sxet`hfu`t-0000!!!!/ebub`jo`1)|usjh-!!cvstu`foe-sxet`f-0000!!!!/ebub`jo`1)|uu\4;1^-0000!!!!!!!!!!!!!!!!qtsbn`xebub\9;1^-qtsbn`bees~*-0000!!!!!!!!!!!!!!!!qtsbn`sebub\26;1^-22(i1-gtn`tubuf~*-0000!!!!!!!!!!!!!!!!qtsbn`sebub\34;27^-qtsbn`sebub\8;1^-qtsbn`xebub\34;27^-qtsbn`xebub\8;1^~*-0000!!!!!!!!!!!!!!!!cvstu`dou-udou!-dvss`tu-ofyu`tu-!ebub`pvu\8;1^~*-0000!!!!!!!!!!!!!!!!dvss`tu-ofyu`tu-er`y3-!gjgp`x`ebub~*-00!!!!!!!!!!!!!!dvss`tu-ofyu`tu-cvstu`dou-!ebub`pvu~*-0000!!!!!!!!!!!!!!!!qtsbn`xebub~*-0000!!!!/sfg`dml`1)dml*00*<0000!efcvhxbsf`w3`2!v`ech)00!/usjh`pvu`1)*-00!/ebub`jo`1)|se`efu-0000!!!!/ebub`jo`1)|usjh-!!cvstu`foe-sxet`f-0000!!!!/ebub`jo`1)|uu\4;1^-0000!!!!!!!!!!!!!!!!qtsbn`xebub\9;1^-qtsbn`bees~*-0000!!!!!!!!!!!!!!!!qtsbn`sebub\26;1^-22(i1-gtn`tubuf~*-0000!!!!!!!!!!!!!!!!qtsbn`sebub\34;27^-qtsbn`sebub\8;1^-qtsbn`xebub\34;27^-qtsbn`xebub\8;1^~*-0000!!!!!!!!!!!!!!!!cvstu`dou-udou!-dvss`tu-ofyu`tu-!ebub`pvu\8;1^~*-0000!!!!!!!!!!!!!!!!dvss`tu-ofyu`tu-er`y3-!gjgp`x`ebub~*-0000!!!!!!!!!!!!!!!!dvss`tu-ofyu`tu-cvstu`dou-!ebub`pvu`g~*-00!ebub`pvu`g~*-0000!!!!!!!!!!!!!!!!00!qtsbn`xebub~*-00!/sfg`dml`1)dml`jp*00!*<00dml`nvy00dml`y3`29100dml`y300gjojti!efubmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*cfhjogjojti!!!!=>!$EMZ!2(c1!<foefmtf!jg)dvss`tu>>JEMF*cfhjogjojti!!!!=>!$EMZ!2(c2!<foefmtfgjojti!!!!=>!$EMZ!2(c1!<foebmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*cfhjodml`tfm!!!!=>!2(c1<foefmtfcfhjodml`tfm!!!!=>!se`ebub`ufsn<foefoe00!bttjho!xs`bdl>xs`gjgp`fo<00!bttjho!se`bdl>se`gjgp`fo<bmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*cfhjodvss`tu!!!!=>!$EMZ!QPXFSPO`TFR!<foefmtfcfhjodvss`tu!!!!=>!$EMZ!ofyu`tu!<foefoebttjho!qpxfs`po`tfr>)dvss`tu>>QPXFSPO`TFR*<bmxbztA)+*cfhjoxs`gjgp`fo=>2(c1<gjgp`x`ebub=>27(i1<dto=>2(i2<dml`fo=>2(i1<se`ebub`ufsn=>2(i1<er`fo=>2(i1<sxet`fo=>2(i1<ofyu`tu=>QPXFSPO`TFR<xs`bdl=>2(c1<dbtf)dvss`tu*QPXFSPO`TFR;!cfhjoxs`gjgp`fo=>2(c2<dml`fo=>2(i2<jg)sbn`qpxfsvq`po*ofyu`tu!=>JEMF<fmtfofyu`tu=>QPXFSPO`TFR<foeJEMF!!!!!!!;!cfhjojg)xs`sfr*cfhjoxs`gjgp`fo=>2(c2<dto=>2(c1<dml`fo=>2(i2<ofyu`tu=>XS`DNE<foefmtf!jg)se`sfr*cfhjoxs`gjgp`fo=>2(c2<dto=>2(c1<dml`fo=>2(i2<ofyu`tu=>SE`DNE<foefmtfofyu`tu=>JEMF<foeSE`DNE!;!cfhjoxs`gjgp`fo=>2(c2<dto=>2(c1<dml`fo=>2(c2<er`fo=>2(c2<ofyu`tu=>SE`DNE<gjgp`x`ebub=>qtsbn`bees\58;43^<jg)dne`gjojti*cfhjoofyu`tu=>SE`EBU`MUD<foefoeSE`EBU`MUD!;!cfhjoxs`gjgp`fo=>2(c2<dto=>2(c1<dml`fo=>2(c2<er`fo=>2(c1<ofyu`tu=>SE`EBU`MUD<jg)mudz`sy`gjojti*cfhjoofyu`tu=>SE`EBU<foefoeSE`EBU!;!cfhjose`ebub`ufsn=>2(i2<xs`gjgp`fo=>2(c2<dto=>2(c1<dml`fo=>2(c2<ofyu`tu=>SE`EBU<jg)ebub`sy`gjojti})ebub`usbot`gjojti'')"se`efu`u***!00bee!ujnfpvucfhjoxs`gjgp`fo=>2(c1<00dto=>2(c2<dml`fo=>2(c1<ofyu`tu=>JEMF<foefoeXS`DNE!;!cfhjoxs`gjgp`fo=>2(c2<dto=>2(c1<dml`fo=>2(c2<er`fo=>2(c2<gjgp`x`ebub=>qtsbn`bees\58;43^<ofyu`tu=>XS`DNE<jg)dne`gjojti*cfhjojg)npef`tfm*ofyu`tu=>XS`SFH<fmtf!00!jg)mudz`gjojti*ofyu`tu=>XS`EBU`MUD<foefoeXS`SFH!!!;!cfhjoxs`gjgp`fo=>2(c2<00!dto=>2(c1<00dml`fo=>2(c1<er`fo=>2(c2<xs`bdl=>2(c2<gjgp`x`ebub=>ebub`jo<ofyu`tu=>JEMF<foeXS`EBU`MUD!;!cfhjoxs`gjgp`fo=>2(c2<dto=>2(c1<dml`fo=>2(c2<er`fo=>2(c2<sxet`fo=>2(c2<gjgp`x`ebub=>qtsbn`bees\58;43^<00!gjgp`x`ebub=>27(i2345<jg)mudz`gjojti*ofyu`tu=>XS`EBU<fmtfofyu`tu=>XS`EBU`MUD<foeXS`EBU!;!cfhjoxs`gjgp`fo=>2(c2<dto=>2(c1<dml`fo=>2(c2<er`fo=>2(c2<xs`bdl=>2(c2<sxet`fo=>2(c2<gjgp`x`ebub=>ebub`jo<ofyu`tu=>XS`EBU<jg)ebub`usbot`gjojti*cfhjo00!xs`gjgp`fo=>2(c1<dto=>2(c2<dml`fo=>2(c1<00!er`fo=>2(c1<00!xs`bdl=>2(c1<ofyu`tu=>JEMF<foefoeefgbvmu!!!!;!ofyu`tu!=>!JEMF!<foedbtffoe00dml!y3!epnbjo00uy00!bmxbztA)qptfehf!dml`y3!ps!ofhfehf!stuo*00!cfhjo00!jg)stuo!>>!2(c1*00!xs`gjgp`se`fo`t!=>!$EMZ!2(c1!<00!fmtf00!xs`gjgp`se`fo`t=>xs`gjgp`fnq<00!foe00!bttjho!xs`gjgp`se`fo!>!)xs`gjgp`fnq*<00sy00bttjho!dml`sy>dml`:1<bttjho!dml`sy>dml`jp<bmxbztA)qptfehf!dml`sy!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*cfhjose`ebub`ufsn`t!=>!$EMZ!2(c1!<se`ebub`ufsn`u!=>!$EMZ!2(c1!<foefmtf!cfhjose`ebub`ufsn`t=>se`ebub`ufsn<se`ebub`ufsn`u=>se`ebub`ufsn`t<foefoebttjho!se`ebub`ufsn`s>se`ebub`ufsn`t')"se`ebub`ufsn`u*<bmxbztA)qptfehf!dml`sy!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*se`nbtl!=>!$EMZ!2(c1!<fmtf!jg)se`ebub`ufsn`s*se`nbtl!=>!$EMZ!2(c2!<fmtf!jg)se`ebu`foe`jou*se`nbtl!=>!$EMZ!2(c1!<foebmxbztA)qptfehf!dml`sy*cfhjojg)se`ebub`ufsn`u*sxet`hfu`g=>sxet`hfu<fmtfsxet`hfu`g=>3(c11<foebmxbztA)qptfehf!dml`sy!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*se`efu!=>!$EMZ!2(c1!<fmtf!jg)se`ebu`foe`jou*se`efu!=>!$EMZ!2(c1!<00!fmtf!jg)se`nbtl')sxet`hfu`g">3(c11**fmtf!jg)se`nbtl')sxet`hfu`g>>3(c12**se`efu!=>!$EMZ!2(c2!<foe00qibtf!efu!qibtf`npef00!bmxbztA)qptfehf!dml!ps!ofhfehf!stuo*00!cfhjo00!jg)stuo!>>!2(c1*00!sxet`qibtf`efu!=>!$EMZ!2(c1!<00!fmtf!jg)se`ebub`ufsn`s*00!sxet`qibtf`efu!=>!$EMZ!2(c2!<00!fmtf!jg))sxet`hfu`t">3(c11**00!sxet`qibtf`efu!=>!$EMZ!2(c1!<00!foe00!bmxbztA)qptfehf!dml!ps!ofhfehf!stuo*00!cfhjo00!jg)stuo!>>!2(c1*00!sxet`qibtf`efu`t!=>!$EMZ!2(c1!<00!fmtf00!sxet`qibtf`efu`t=>sxet`qibtf`efu<00!foe00!bttjho!sxet`qibtf`efu`g>sxet`qibtf`efu`t')"sxet`qibtf`efu*<00dml!epnbjobmxbztA)qptfehf!dml*cfhjosygjgp`se`t=>sygjgp`se<sygjgp`se`u=>sygjgp`se`t<foebttjho!se`bdl>sygjgp`se`t<00!bttjho!se`bdl>sygjgp`se`u<bttjho!sygjgp`se>sygjgp`fnq<gjgp`qtsbn`jp`se!v`sy`gjgp)/epvu)ebub`pvu*-/ejo)ebub`pvu`g*-/xsjufdml)dml`sy*-/sfbedml)dml*-/xsjuffo)se`efu*-/sfbefo)sygjgp`se*-00!/sfbefo)sygjgp`se`t*-/sftfu)stuo*-/gvmm)*-/fnquz)sygjgp`fnq*-/bmnptugvmm)*-/bmnptufnquz)**<00!bmxbztA)+*00!cfhjo00!qibtf`npef=>!)sxet`hfu`g>>3(c21*@!2(c2;2(c1<00!foebmxbztA)qptfehf!dml`sy*cfhjoer`hfu`t=>er`hfu<er`hfu`u=>er`hfu`t<foe00!bttjho!ebub`pvu`g>!qibtf`npef@!er`hfu`t;|er`hfu`u\8;1^-er`hfu`t\26;9^~<bttjho!ebub`pvu`g>!|er`hfu`u\8;1^-er`hfu`t\26;9^~<00se!foe!efubmxbztA)qptfehf!dml`sy!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*se`ebu`foe`g!=>!$EMZ!2(c1!<fmtf!jg)se`ebu`foe`qsf*se`ebu`foe`g!=>!$EMZ!2(c2<fmtf!jg)se`ebub`ufsn`s*se`ebu`foe`g!=>!$EMZ!2(c1!<foebmxbztA)qptfehf!dml`sy!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*cvstu`dou!=>!$EMZ!9(c1!<fmtfcfhjojg)se`efu*cvstu`dou!=>!$EMZ!cvstu`dou!,!2(c2!<fmtfcvstu`dou!=>!$EMZ!9(c1!<foefoebttjho!se`ebu`foe`jou!>!))cvstu`dou!>>!9(e74**!<bttjho!se`ebu`foe`qsf!>!))cvstu`dou!>>!9(e71**!<00!bttjho!ebub`sy`gjojti>))cvstu`dou!>>!9(e72**!<00JPbmxbztA)qptfehf!dml`jp!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*sxet`tfu!=>!$EMZ!3(c1!<fmtfsxet`tfu=>3(c1<foe00!bmxbztA)qptfehf!dml`:1!ps!ofhfehf!stuo*00!cfhjo00!jg)stuo!>>!2(c1*00!cfhjo00!dml`fo`:1!=>!$EMZ!2(c1!<00!dml`fo`:1`t!=>!$EMZ!2(c1!<00!dml`fo`:1`u!=>!$EMZ!2(c1!<00!foe00!fmtf!cfhjo00!dml`fo`:1=>dml`fo<00!dml`fo`:1`t=>dml`fo`:1<00!dml`fo`:1`u=>dml`fo`:1`t<00!foe00!foe00!bmxbztA)+*00!cfhjo00!jg)dml`fo`:1`t*00!jg)dml`fo`:1`u*00!dml`ejgg=>5(c2112<00!fmtf00!dml`ejgg=>5(c1122<00!foe00!bmxbztA)qptfehf!dml`:1!ps!ofhfehf!stuo*00!cfhjo00!jg)stuo!>>!2(c1*00!cfhjo00!dml`ejgg=>5(c1122<00!foe00!fmtf!jg)dml`fo`:1`t*00!dml`ejgg=>5(c2112<00!fmtf00!dml`ejgg=>5(c1122<00!foebmxbztA)qptfehf!dml`:1*cfhjodml`ejgg=>5(c2112<foe00jotfsu!sfhsfh\26;1^!gjgp`x`ebub`t<sfh!dto`t<sfh!dto`u<sfh!sxet`fo`t<sfh\8;1^!er`fo`t<bmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*!cfhjogjgp`x`ebub`t!=>!27(c1!<dto`t!=>!2(c1!<sxet`fo`t!=>!2(c1!<er`fo`t!=>!9(c1!<foefmtf!cfhjogjgp`x`ebub`t!=>gjgp`x`ebub!<dto`t!=>!dto!<sxet`fo`t!=>!sxet`fo<er`fo`t\1^!=>!er`fo<er`fo`t\2^!=>!er`fo<er`fo`t\3^!=>!er`fo<er`fo`t\4^!=>!er`fo<er`fo`t\5^!=>!er`fo<er`fo`t\6^!=>!er`fo<er`fo`t\7^!=>!er`fo<er`fo`t\8^!=>!er`fo<foefoebmxbztA)qptfehf!dml!ps!ofhfehf!stuo*cfhjojg)stuo!>>!2(c1*dto`u!=>!$EMZ!2(c1!<fmtfdto`u=>dto`t<foeqtsbn`jp`ees!v`qtsbn`jp)/dml!!!!!!!)dml*-/dml`ees!!!!!)dml`jp*-/dml`:1!!!!!)dml`:1*-00!/sxet`f!!!!)sxet`fo*-/sxet`f!!!!)sxet`fo`t*-00!/dl`fo!!!!)dml`fo`:1`t*-/dl`fo!!!!)dml`fo`:1`u*-00!/er`xs!!!!!!)gjgp`x`ebub*-/er`xs!!!!!)gjgp`x`ebub`t*-00!/er`f!!!!!!)er`fo*-/er`f!!!!!!)er`fo`t*-00!/dt`o`p!!!!)dto*-00!/dt`o`p!!!!)dto`t*-/dt`o`p!!!!)dto`u*-/dt`o`f!!!!)2(c2*-/dl`p!!!!!!)dml`ejgg\4;3^*-/dl`o`p!!!!)dml`ejgg\2;1^*-/sxet`j!!!!)sxet`hfu*-/sxet`p!!!!)sxet`tfu*-/er`se!!!!!)er`hfu*-/DL!!!!!!!!)qtsbn`dml*-/DL`O!!!!!!)qtsbn`dmlo*-/DT`O!!!!!!)qtsbn`dto*-/SXET!!!!!!)qtsbn`sxet*-/ER!!!!!!!!)qtsbn`er**<
`pragma protect end_protected




endmodule
























