
`timescale 1 ns / 1 ns

module sc_down_top#(
parameter RX_X_RESOLUTION = 1080
)
(
clk,
reset,
vstart,
hstart,
rx_fifo_dat,
rx_fifo_empty,
rx_fifo_rd,
tx_fifo_dat,
tx_fifo_wen,
vs_out,
hs_out
);


input   clk;
input   reset;
input   [31:0] rx_fifo_dat;
input   rx_fifo_empty;
input   [11:0] vstart;
input   [9:0] hstart;
output  rx_fifo_rd;
output  [31:0] tx_fifo_dat;
output  tx_fifo_wen;
output  vs_out;
output  hs_out;

wire   [9:0] rx_line_len;
wire   [11:0] v_start_p;
wire   [9:0] h_start_p;
wire   rstn;
assign rx_line_len = (RX_X_RESOLUTION*3)>>2;
assign v_start_p = vstart;
assign h_start_p = hstart;
assign rstn = ~reset;

wire ToScl_out1;
wire ToScl_out2;
wire ToScl_out3;
wire ToScl_out4;
wire [31:0] ToScl_out5;
wire t3_out1;
wire t14_out1;
wire ToSclV_out1;
wire t16_out1;
wire ToSclV_out2;
wire t15_out1;
wire [31:0] y;
wire [31:0] t17_out1;
wire sc_1080_720_out1;
wire sc_1080_720_out2;
wire [31:0] sc_1080_720_out3;
wire sc_1080_720_out4;
wire [7:0] t31_out1;
wire [7:0] t32_out1;
wire [7:0] t33_out1;
wire [7:0] t34_out1;
wire [31:0] t23_out1;
wire [31:0] FrScl_out1;
wire FrScl_out3;
wire [31:0] t1_out1;
wire t2_out1;


ToScl u_ToScl (.clk(clk),
.rstn(rstn),
.In1(rx_fifo_empty),
.In2(rx_fifo_dat),
.In3(rx_line_len),
.Out1(ToScl_out1),
.Out2(ToScl_out2),
.Out3(ToScl_out3),
.Out4(ToScl_out4),
.Out5(ToScl_out5)
);

assign rx_fifo_rd = ToScl_out1;

assign t3_out1 = 1'b0;



assign t14_out1 = 1'b1;



assign t16_out1 = (t14_out1 == 1'b0 ? ToSclV_out1 :
ToScl_out3);



assign t15_out1 = (t14_out1 == 1'b0 ? ToSclV_out2 :
ToScl_out2);



assign t17_out1 = (t14_out1 == 1'b0 ? y :
ToScl_out5);



sc_1080_720 u_sc_1080_720 (.clk(clk),
.rstn(rstn),
.ivs(t16_out1),
.ihs(t15_out1),
.idat(t17_out1),
.v_start_p(v_start_p),
.h_start_p(h_start_p),
.ovs(sc_1080_720_out1),
.ohs(sc_1080_720_out2),
.odat(sc_1080_720_out3),
.ode(sc_1080_720_out4)
);

assign t31_out1 = sc_1080_720_out3[7:0];



assign t32_out1 = sc_1080_720_out3[15:8];



assign t33_out1 = sc_1080_720_out3[23:16];



assign t34_out1 = sc_1080_720_out3[31:24];



assign t23_out1 = {t31_out1, t32_out1, t33_out1, t34_out1};



//FrScl u_FrScl (.clk(clk),
//.rstn(rstn),
//.In1(sc_1080_720_out1),
//.In2(sc_1080_720_out2),
//.In3(sc_1080_720_out4),
//.In4(sc_1080_720_out3),
//.Out1(FrScl_out1),
//.Out3(FrScl_out3)
//);
assign vs_out = ToScl_out3;
assign hs_out = ToScl_out2;
assign t1_out1 = (t3_out1 == 1'b0 ? t23_out1 :
FrScl_out1);



assign tx_fifo_dat = t1_out1;

assign t2_out1 = (t3_out1 == 1'b0 ? sc_1080_720_out4 :
FrScl_out3);



assign tx_fifo_wen = t2_out1;

endmodule



















`pragma protect begin_protected
`pragma protect version=1
`pragma protect data_block
aujnftdbmf!2!ot!0!2!otnpevmf!td`2191`831)dml-stuo-jwt-jit-jebu-w`tubsu`q-i`tubsu`q-pwt-pit-pebu-pef*<joqvu!!!dml<joqvu!!!stuo<joqvu!!!jwt<joqvu!!!jit<joqvu!!!\42;1^!jebu<joqvu!!!\22;1^!w`tubsu`q<joqvu!!!\:;1^!i`tubsu`q<pvuqvu!!pwt<pvuqvu!!pit<pvuqvu!!\42;1^!pebu<pvuqvu!!pef<sfh!!u9`pvu2<sfh!!u5`pvu2<sfh!!u:7`pvu2<sfh!!u:8`pvu2<sfh!!\1;8^!u:6`sfh<xjsf!\1;8^!u:6`sfh`ofyu<xjsf!u:6`pvu2<sfh!!u24`pvu2<xjsf!u22`pvu2<xjsf!u23`pvu2<sfh!!u:`pvu2<xjsf!u38`pvu2<sfh!!u27`pvu2<xjsf!u39`pvu2<xjsf!u2`pvu2<sfh!!\1;2^!u57`sfh<xjsf!\1;2^!u57`sfh`ofyu<xjsf!u57`pvu2<sfh!!u58`pvu2<sfh!!u61`pvu2<xjsf!\22;1^!u94`pvu2<sfh!\22;1^!u32`pvu2<xjsf!\23;1^!u93`bee`ufnq<xjsf!\23;1^!u93`2<xjsf!\23;1^!u93`3<xjsf!\22;1^!u93`pvu2<xjsf!\22;1^!u33`pvu2<xjsf!\22;1^!u28`pvu2<xjsf!u4`pvu2<sfh!!u72`pvu2<xjsf!u6:`pvu2<xjsf!u25`pvu2<xjsf!u26`pvu2<xjsf!\:;1^!u37`pvu2<sfh!\:;1^!u35`pvu2<xjsf!\21;1^!u36`bee`ufnq<xjsf!\21;1^!u36`2<xjsf!\21;1^!u36`3<xjsf!\:;1^!u36`pvu2<xjsf!\:;1^!u29`pvu2<xjsf!\21;1^!u71`pvu2<xjsf!\21;1^!u43`pvu2<xjsf!u68`pvu2<xjsf!\:;1^!u67`pvu2<xjsf!\21;1^!u69`pvu2<xjsf!\21;1^!u5:`pvu2<xjsf!\21;1^!u59`pvu2<xjsf!\42;1^!fnc2`pvu2<xjsf!\6;1^!u65`pvu2<xjsf!\6;1^!u74`pvu2<xjsf!\6;1^!u73`pvu2<sfh!\6;1^!u::`pvu2<xjsf!\6;1^!u62`pvu2<xjsf!u41`pvu2<xjsf!u8:`pvu2<sfh!!u6`pvu2<sfh!!u82`pvu2<sfh!!u216`pvu2<xjsf!u89`pvu2<sfh!!\1;8^!u84`sfh<xjsf!\1;8^!u84`sfh`ofyu<xjsf!u84`pvu2<xjsf!u222`pvu2<sfh!!\1;3^!u22`sfh<xjsf!\1;3^!u22`sfh`ofyu<xjsf!u22`pvu2`2<sfh!!\1;3^!u4:`sfh<xjsf!\1;3^!u4:`sfh`ofyu<xjsf!u4:`pvu2<xjsf!u:4`pvu2<xjsf!\34;1^!u63`pvu2<xjsf!\34;1^!u66`pvu2<xjsf!\34;1^!u64`pvu2<sfh!\34;1^!u56`pvu2<xjsf!\4;1^!u45`pvu2<sfh!\4;1^!u2`sfh!\1;3^<xjsf!\4;1^!u2`sfh`ofyu!\1;3^<xjsf!\4;1^!u2`pvu2`2<sfh!\4;1^!u46`sfh!\1;3^<xjsf!\4;1^!u46`sfh`ofyu!\1;3^<xjsf!\4;1^!u46`pvu2<xjsf!\3;1^!u54`pvu2<xjsf!\3;1^!u55`pvu2<xjsf!\3;1^!u61`pvu2`2<xjsf!\3;1^!u57`pvu2`2<xjsf!\3;1^!u56`pvu2`2<xjsf!\3;1^!u5:`pvu2`2<xjsf!\3;1^!u59`pvu2`2<xjsf!\3;1^!u58`pvu2`2<sfh!\3;1^!Pvu2<xjsf!\3;1^!u:2`pvu2<sfh!\3;1^!u52`pvu2<xjsf!\3;1^!u53`pvu2<xjsf!\3;1^!u:1`pvu2<xjsf!u85`pvu2<sfh!!u86`pvu2<xjsf!u87`pvu2<xjsf!\2;1^!u88`pvu2<xjsf!\5;1^!u3:`pvu2<xjsf!\5;1^!u42`pvu2<xjsf!tjhofe!\6;1^!u35`pvu2`2<sfh!tjhofe!\6;1^!u21`sfh!\1;3^<xjsf!tjhofe!\6;1^!u21`sfh`ofyu!\1;3^<xjsf!tjhofe!\6;1^!u21`pvu2<sfh!tjhofe!\6;1^!u:`pvu2`2<xjsf!\2;1^!u5`pvu2`2<xjsf!\5;1^!u27`pvu2`2<xjsf!\5;1^!u36`pvu2`2<xjsf!tjhofe!\6;1^!u31`pvu2<sfh!tjhofe!\6;1^!u:`pvu2`3<xjsf!\2;1^!u5`pvu2`3<sfh!\42;1^!u21`pvu2`2<sfh!\42;1^!u48`pvu2<sfh!\42;1^!u49`pvu2<sfh!\:;1^!u45`pvu2`2<xjsf!u44`pvu2<sfh!!u46`pvu2`2<sfh!!u47`pvu2<xjsf!\42;1^!u8`pvu2<xjsf!\8;1^!u52`pvu2`2<sfh!\8;1^!u213`pvu2<sfh!\8;1^!u4`pvu2`2<xjsf!\8;1^!u53`pvu2`2<sfh!\8;1^!u212`pvu2<xjsf!\9;1^!u22`4<xjsf!\9;1^!u22`5<xjsf!\9;1^!u22`pvu2`3<sfh!\8;1^!u8`pvu2`2<sfh!\9;1^!u23`pvu2`2<xjsf!\8;1^!u24`pvu2`2<sfh!\8;1^!u21`pvu2`3<xjsf!\8;1^!u6`pvu2`2<sfh!\8;1^!u25`pvu2`2<sfh!\8;1^!u2`pvu2`3<sfh!tjhofe!\6;1^!u:`pvu2`4<xjsf!\2;1^!u5`pvu2`4<sfh!\42;1^!u7`pvu2<sfh!\42;1^!u83`pvu2<xjsf!\8;1^!u21:`pvu2<sfh!\8;1^!u34`pvu2<sfh!\8;1^!u8`pvu2`3<xjsf!\8;1^!u221`pvu2<sfh!\8;1^!u3`pvu2<xjsf!\9;1^!u22`7<xjsf!\9;1^!u22`8<xjsf!\9;1^!u22`pvu2`4<sfh!\8;1^!u8`pvu2`4<sfh!\9;1^!u23`pvu2`3<xjsf!\8;1^!u24`pvu2`3<sfh!\8;1^!u21`pvu2`4<xjsf!\8;1^!u6`pvu2`3<sfh!\8;1^!u25`pvu2`3<sfh!\8;1^!u2`pvu2`4<xjsf!\9;1^!u22`:<xjsf!\9;1^!u22`21<xjsf!\9;1^!u22`pvu2`5<sfh!\8;1^!u8`pvu2`5<sfh!\9;1^!u23`pvu2`4<xjsf!\8;1^!u24`pvu2`4<sfh!\8;1^!u21`pvu2`5<xjsf!\8;1^!u6`pvu2`4<sfh!\8;1^!u25`pvu2`4<sfh!\8;1^!u2`pvu2`5<sfh!tjhofe!\6;1^!u:`pvu2`5<xjsf!\2;1^!u5`pvu2`5<xjsf!\5;1^!u28`pvu2`2<xjsf!\5;1^!u37`pvu2`2<xjsf!tjhofe!\6;1^!u32`pvu2`2<sfh!tjhofe!\6;1^!u:`pvu2`6<xjsf!\2;1^!u5`pvu2`6<xjsf!\8;1^!u51`pvu2<sfh!\8;1^!u214`pvu2<sfh!\8;1^!u5`pvu2`7<xjsf!\9;1^!u22`23<xjsf!\9;1^!u22`24<xjsf!\9;1^!u22`pvu2`6<sfh!\8;1^!u8`pvu2`6<sfh!\9;1^!u23`pvu2`5<xjsf!\8;1^!u24`pvu2`5<sfh!\8;1^!u21`pvu2`6<xjsf!\8;1^!u6`pvu2`5<sfh!\8;1^!u25`pvu2`5<sfh!\8;1^!u2`pvu2`6<sfh!tjhofe!\6;1^!u:`pvu2`7<xjsf!\2;1^!u5`pvu2`8<xjsf!\8;1^!u219`pvu2<sfh!\8;1^!u54`pvu2`2<sfh!\8;1^!u9`pvu2`2<xjsf!\9;1^!u22`26<xjsf!\9;1^!u22`27<xjsf!\9;1^!u22`pvu2`7<sfh!\8;1^!u8`pvu2`7<sfh!\9;1^!u23`pvu2`6<xjsf!\8;1^!u24`pvu2`6<sfh!\8;1^!u21`pvu2`7<xjsf!\8;1^!u6`pvu2`6<sfh!\8;1^!u25`pvu2`6<sfh!\8;1^!u2`pvu2`7<xjsf!\9;1^!u22`29<xjsf!\9;1^!u22`2:<xjsf!\9;1^!u22`pvu2`8<sfh!\8;1^!u8`pvu2`8<sfh!\9;1^!u23`pvu2`7<xjsf!\8;1^!u24`pvu2`7<sfh!\8;1^!u21`pvu2`8<xjsf!\8;1^!u6`pvu2`7<sfh!\8;1^!u25`pvu2`7<sfh!\8;1^!u2`pvu2`8<sfh!tjhofe!\6;1^!u:`pvu2`8<xjsf!\2;1^!u5`pvu2`9<xjsf!\5;1^!u29`pvu2`2<xjsf!\5;1^!u38`pvu2`2<xjsf!tjhofe!\6;1^!u33`pvu2`2<sfh!tjhofe!\6;1^!u:`pvu2`9<xjsf!\2;1^!u5`pvu2`:<xjsf!\8;1^!u4:`pvu2`2<sfh!\8;1^!u215`pvu2<sfh!\8;1^!u6`pvu2`8<xjsf!\9;1^!u22`32<xjsf!\9;1^!u22`33<xjsf!\9;1^!u22`pvu2`9<sfh!\8;1^!u8`pvu2`9<sfh!\9;1^!u23`pvu2`8<xjsf!\8;1^!u24`pvu2`8<sfh!\8;1^!u21`pvu2`9<xjsf!\8;1^!u6`pvu2`9<sfh!\8;1^!u25`pvu2`8<sfh!\8;1^!u2`pvu2`9<sfh!tjhofe!\6;1^!u:`pvu2`:<xjsf!\2;1^!u5`pvu2`21<xjsf!\8;1^!u218`pvu2<sfh!\8;1^!u55`pvu2`2<sfh!\8;1^!u:`pvu2`21<xjsf!\9;1^!u22`35<xjsf!\9;1^!u22`36<xjsf!\9;1^!u22`pvu2`:<sfh!\8;1^!u8`pvu2`:<sfh!\9;1^!u23`pvu2`9<xjsf!\8;1^!u24`pvu2`9<sfh!\8;1^!u21`pvu2`:<xjsf!\8;1^!u6`pvu2`:<sfh!\8;1^!u25`pvu2`9<sfh!\8;1^!u2`pvu2`:<xjsf!\9;1^!u22`38<xjsf!\9;1^!u22`39<xjsf!\9;1^!u22`pvu2`21<sfh!\8;1^!u8`pvu2`21<sfh!\9;1^!u23`pvu2`:<xjsf!\8;1^!u24`pvu2`:<sfh!\8;1^!u21`pvu2`21<xjsf!\8;1^!u6`pvu2`21<sfh!\8;1^!u25`pvu2`:<sfh!\8;1^!u2`pvu2`21<sfh!tjhofe!\6;1^!u:`pvu2`22<xjsf!\2;1^!u5`pvu2`22<xjsf!\5;1^!u2:`pvu2<xjsf!\5;1^!u39`pvu2`2<xjsf!tjhofe!\6;1^!u34`pvu2`2<sfh!tjhofe!\6;1^!u:`pvu2`23<xjsf!\2;1^!u5`pvu2`23<xjsf!\9;1^!u22`41<xjsf!\9;1^!u22`42<xjsf!\9;1^!u22`pvu2`22<sfh!\8;1^!u8`pvu2`22<sfh!\9;1^!u23`pvu2`21<xjsf!\8;1^!u24`pvu2`21<sfh!\8;1^!u21`pvu2`22<xjsf!\8;1^!u6`pvu2`22<sfh!\8;1^!u25`pvu2`21<sfh!\8;1^!u2`pvu2`22<sfh!tjhofe!\6;1^!u:`pvu2`24<xjsf!\2;1^!u5`pvu2`24<xjsf!\9;1^!u22`44<xjsf!\9;1^!u22`45<xjsf!\9;1^!u22`pvu2`23<sfh!\8;1^!u8`pvu2`23<sfh!\9;1^!u23`pvu2`22<xjsf!\8;1^!u24`pvu2`22<sfh!\8;1^!u21`pvu2`23<xjsf!\8;1^!u6`pvu2`23<sfh!\8;1^!u25`pvu2`22<sfh!\8;1^!u2`pvu2`23<xjsf!\9;1^!u22`47<xjsf!\9;1^!u22`48<xjsf!\9;1^!u22`pvu2`24<sfh!\8;1^!u8`pvu2`24<sfh!\9;1^!u23`pvu2`23<xjsf!\8;1^!u24`pvu2`23<sfh!\8;1^!u21`pvu2`24<xjsf!\8;1^!u6`pvu2`24<sfh!\8;1^!u25`pvu2`23<sfh!\8;1^!u2`pvu2`24<xjsf!\42;1^!u64`pvu2`2<xjsf!\8;1^!u83`pvu2`2<xjsf!\26;1^!u81`pvu2<xjsf!\34;1^!u79`pvu2<xjsf!\8;1^!u77`pvu2<xjsf!\26;1^!u71`pvu2`2<xjsf!\34;1^!u74`pvu2`2<sfh!\74;1^!u63`pvu2`2<xjsf!\42;1^!u69`pvu2`2<xjsf!\74;1^!u65`pvu2`2<xjsf!\4:;1^!u75`pvu2<xjsf!\74;1^!u73`pvu2`2<xjsf!\58;1^!u76`pvu2<xjsf!\74;1^!u6:`pvu2`2<xjsf!\66;1^!u78`pvu2<xjsf!\74;1^!u67`pvu2`2<xjsf!\4:;1^!u7:`pvu2<xjsf!\74;1^!u68`pvu2`2<xjsf!\58;1^!u82`pvu2`2<xjsf!\74;1^!u72`pvu2`2<xjsf!\66;1^!u84`pvu2`2<xjsf!\74;1^!u66`pvu2`2<sfh!\74;1^!Pvu2`2<xjsf!\42;1^!u8:`pvu2`2<xjsf!\42;1^!u91`pvu2<xjsf!\42;1^!u92`pvu2<xjsf!\42;1^!u93`pvu2`2<xjsf!\42;1^!u89`pvu2`2<sfh!\42;1^!u94`pvu2`2<xjsf!\42;1^!u95`pvu2<sfh!!u97`pvu2<xjsf!u:3`pvu2<sfh!!u96`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u9`qspdfttjg!)stuo!>>!2(c1*!cfhjou9`pvu2!=>!2(c1<foefmtf!cfhjou9`pvu2!=>!jwt<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u5`qspdfttjg!)stuo!>>!2(c1*!cfhjou5`pvu2!=>!2(c1<foefmtf!cfhjou5`pvu2!=>!u9`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:7`qspdfttjg!)stuo!>>!2(c1*!cfhjou:7`pvu2!=>!2(c1<foefmtf!cfhjou:7`pvu2!=>!u5`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:8`qspdfttjg!)stuo!>>!2(c1*!cfhjou:8`pvu2!=>!2(c1<foefmtf!cfhjou:8`pvu2!=>!u:7`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:6`qspdfttjg!)stuo!>>!2(c1*!cfhjou:6`sfh\1^!=>!2(c1<u:6`sfh\2^!=>!2(c1<u:6`sfh\3^!=>!2(c1<u:6`sfh\4^!=>!2(c1<u:6`sfh\5^!=>!2(c1<u:6`sfh\6^!=>!2(c1<u:6`sfh\7^!=>!2(c1<u:6`sfh\8^!=>!2(c1<foefmtf!cfhjou:6`sfh\1^!=>!u:6`sfh`ofyu\1^<u:6`sfh\2^!=>!u:6`sfh`ofyu\2^<u:6`sfh\3^!=>!u:6`sfh`ofyu\3^<u:6`sfh\4^!=>!u:6`sfh`ofyu\4^<u:6`sfh\5^!=>!u:6`sfh`ofyu\5^<u:6`sfh\6^!=>!u:6`sfh`ofyu\6^<u:6`sfh\7^!=>!u:6`sfh`ofyu\7^<u:6`sfh\8^!=>!u:6`sfh`ofyu\8^<foefoebttjho!u:6`pvu2!>!u:6`sfh\8^<bttjho!u:6`sfh`ofyu\1^!>!u:8`pvu2<bttjho!u:6`sfh`ofyu\2^!>!u:6`sfh\1^<bttjho!u:6`sfh`ofyu\3^!>!u:6`sfh\2^<bttjho!u:6`sfh`ofyu\4^!>!u:6`sfh\3^<bttjho!u:6`sfh`ofyu\5^!>!u:6`sfh\4^<bttjho!u:6`sfh`ofyu\6^!>!u:6`sfh\5^<bttjho!u:6`sfh`ofyu\7^!>!u:6`sfh\6^<bttjho!u:6`sfh`ofyu\8^!>!u:6`sfh\7^<bttjho!pwt!>!u:6`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u24`qspdfttjg!)stuo!>>!2(c1*!cfhjou24`pvu2!=>!2(c1<foefmtf!cfhjou24`pvu2!=>!u9`pvu2<foefoebttjho!u22`pvu2!>!!!u24`pvu2<bttjho!u23`pvu2!>!u9`pvu2!'!u22`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u:`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2!=>!2(c1<foefmtf!cfhjou:`pvu2!=>!jit<foefoebttjho!u38`pvu2!>!!!u:`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u27`qspdfttjg!)stuo!>>!2(c1*!cfhjou27`pvu2!=>!2(c1<foefmtf!cfhjou27`pvu2!=>!u:`pvu2<foefoebttjho!u39`pvu2!>!u38`pvu2!'!u27`pvu2<bttjho!u2`pvu2!>!u23`pvu2!}!u39`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u57`qspdfttjg!)stuo!>>!2(c1*!cfhjou57`sfh\1^!=>!2(c1<u57`sfh\2^!=>!2(c1<foefmtf!cfhjou57`sfh\1^!=>!u57`sfh`ofyu\1^<u57`sfh\2^!=>!u57`sfh`ofyu\2^<foefoebttjho!u57`pvu2!>!u57`sfh\2^<bttjho!u57`sfh`ofyu\1^!>!u2`pvu2<bttjho!u57`sfh`ofyu\2^!>!u57`sfh\1^<bmxbzt!A)qptfehf!dml*cfhjo!;!u58`qspdfttjg!)stuo!>>!2(c1*!cfhjou58`pvu2!=>!2(c1<foefmtf!cfhjou58`pvu2!=>!u57`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u61`qspdfttjg!)stuo!>>!2(c1*!cfhjou61`pvu2!=>!2(c1<foefmtf!cfhjou61`pvu2!=>!u58`pvu2<foefoebttjho!u94`pvu2!>!23(c111111111112<bttjho!u93`2!>!|2(c1-!u94`pvu2~<bttjho!u93`3!>!|2(c1-!u32`pvu2~<bttjho!u93`bee`ufnq!>!u93`2!,!u93`3<bttjho!u93`pvu2!>!)u93`bee`ufnq\23^!">!2(c1!@!23(c222222222222!;u93`bee`ufnq\22;1^*<bttjho!u33`pvu2!>!)u39`pvu2!>>!2(c1!@!u32`pvu2!;u93`pvu2*<bttjho!u28`pvu2!>!)u23`pvu2!>>!2(c1!@!u33`pvu2!;w`tubsu`q*<bmxbzt!A)qptfehf!dml*cfhjo!;!u32`qspdfttjg!)stuo!>>!2(c1*!cfhjou32`pvu2!=>!23(c111111111111<foefmtf!cfhjou32`pvu2!=>!u28`pvu2<foefoebttjho!u4`pvu2!>!u32`pvu2\22^<bmxbzt!A)qptfehf!dml*cfhjo!;!u72`qspdfttjg!)stuo!>>!2(c1*!cfhjou72`pvu2!=>!2(c1<foefmtf!cfhjou72`pvu2!=>!u4`pvu2<foefoebttjho!u6:`pvu2!>!2(c1<bttjho!u25`pvu2!>!!!u27`pvu2<bttjho!u26`pvu2!>!u:`pvu2!'!u25`pvu2<bttjho!u37`pvu2!>!21(c1111111112<bttjho!u36`2!>!|2(c1-!u37`pvu2~<bttjho!u36`3!>!|2(c1-!u35`pvu2~<bttjho!u36`bee`ufnq!>!u36`2!,!u36`3<bttjho!u36`pvu2!>!)u36`bee`ufnq\21^!">!2(c1!@!21(c2222222222!;u36`bee`ufnq\:;1^*<bttjho!u29`pvu2!>!)u26`pvu2!>>!2(c1!@!u36`pvu2!;i`tubsu`q*<bmxbzt!A)qptfehf!dml*cfhjo!;!u35`qspdfttjg!)stuo!>>!2(c1*!cfhjou35`pvu2!=>!21(c1111111111<foefmtf!cfhjou35`pvu2!=>!u29`pvu2<foefoebttjho!u71`pvu2!>!|u6:`pvu2-!u35`pvu2~<bttjho!u43`pvu2!>!u32`pvu2\21;1^<bttjho!u68`pvu2!>!2(c2<bttjho!u67`pvu2!>!u32`pvu2\:;1^<bttjho!u69`pvu2!>!|u68`pvu2-!u67`pvu2~<bttjho!u5:`pvu2!>!)u4`pvu2!>>!2(c1!@!u43`pvu2!;u69`pvu2*<bttjho!u59`pvu2!>!)u58`pvu2!>>!2(c1!@!u71`pvu2!;u5:`pvu2*<fnc2!v`fnc2!)/dml)dml*-/sftfu)stuo*-/Jo2)u59`pvu2*-/Pvu2)fnc2`pvu2**<bttjho!u65`pvu2!>!fnc2`pvu2\3:;35^<bttjho!u74`pvu2!>!fnc2`pvu2\6;1^<bttjho!u73`pvu2!>!)u72`pvu2!>>!2(c1!@!u65`pvu2!;u74`pvu2*<bttjho!u62`pvu2!>!)u61`pvu2!>>!2(c1!@!u::`pvu2!;u73`pvu2*<bmxbzt!A)qptfehf!dml*cfhjo!;!u::`qspdfttjg!)stuo!>>!2(c1*!cfhjou::`pvu2!=>!7(c111111<foefmtf!cfhjou::`pvu2!=>!u62`pvu2<foefoebttjho!u41`pvu2!>!u::`pvu2\1^<bttjho!u8:`pvu2!>!2(c1<bmxbzt!A)qptfehf!dml*cfhjo!;!u6`qspdfttjg!)stuo!>>!2(c1*!cfhjou6`pvu2!=>!2(c1<foefmtf!cfhjou6`pvu2!=>!u:`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u82`qspdfttjg!)stuo!>>!2(c1*!cfhjou82`pvu2!=>!2(c1<foefmtf!cfhjou82`pvu2!=>!u6`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u216`qspdfttjg!)stuo!>>!2(c1*!cfhjou216`pvu2!=>!2(c1<foefmtf!cfhjou216`pvu2!=>!u82`pvu2<foefoebttjho!u89`pvu2!>!)u41`pvu2!>>!2(c1!@!u8:`pvu2!;u216`pvu2*<bmxbzt!A)qptfehf!dml*cfhjo!;!u84`qspdfttjg!)stuo!>>!2(c1*!cfhjou84`sfh\1^!=>!2(c1<u84`sfh\2^!=>!2(c1<u84`sfh\3^!=>!2(c1<u84`sfh\4^!=>!2(c1<u84`sfh\5^!=>!2(c1<u84`sfh\6^!=>!2(c1<u84`sfh\7^!=>!2(c1<u84`sfh\8^!=>!2(c1<foefmtf!cfhjou84`sfh\1^!=>!u84`sfh`ofyu\1^<u84`sfh\2^!=>!u84`sfh`ofyu\2^<u84`sfh\3^!=>!u84`sfh`ofyu\3^<u84`sfh\4^!=>!u84`sfh`ofyu\4^<u84`sfh\5^!=>!u84`sfh`ofyu\5^<u84`sfh\6^!=>!u84`sfh`ofyu\6^<u84`sfh\7^!=>!u84`sfh`ofyu\7^<u84`sfh\8^!=>!u84`sfh`ofyu\8^<foefoebttjho!u84`pvu2!>!u84`sfh\8^<bttjho!u84`sfh`ofyu\1^!>!u89`pvu2<bttjho!u84`sfh`ofyu\2^!>!u84`sfh\1^<bttjho!u84`sfh`ofyu\3^!>!u84`sfh\2^<bttjho!u84`sfh`ofyu\4^!>!u84`sfh\3^<bttjho!u84`sfh`ofyu\5^!>!u84`sfh\4^<bttjho!u84`sfh`ofyu\6^!>!u84`sfh\5^<bttjho!u84`sfh`ofyu\7^!>!u84`sfh\6^<bttjho!u84`sfh`ofyu\8^!>!u84`sfh\7^<bttjho!pit!>!u84`pvu2<bttjho!u222`pvu2!>!u41`pvu2!'!u216`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u22`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou22`sfh\1^!=>!2(c1<u22`sfh\2^!=>!2(c1<u22`sfh\3^!=>!2(c1<foefmtf!cfhjou22`sfh\1^!=>!u22`sfh`ofyu\1^<u22`sfh\2^!=>!u22`sfh`ofyu\2^<u22`sfh\3^!=>!u22`sfh`ofyu\3^<foefoebttjho!u22`pvu2`2!>!u22`sfh\3^<bttjho!u22`sfh`ofyu\1^!>!u222`pvu2<bttjho!u22`sfh`ofyu\2^!>!u22`sfh\1^<bttjho!u22`sfh`ofyu\3^!>!u22`sfh\2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u4:`qspdfttjg!)stuo!>>!2(c1*!cfhjou4:`sfh\1^!=>!2(c1<u4:`sfh\2^!=>!2(c1<u4:`sfh\3^!=>!2(c1<foefmtf!cfhjou4:`sfh\1^!=>!u4:`sfh`ofyu\1^<u4:`sfh\2^!=>!u4:`sfh`ofyu\2^<u4:`sfh\3^!=>!u4:`sfh`ofyu\3^<foefoebttjho!u4:`pvu2!>!u4:`sfh\3^<bttjho!u4:`sfh`ofyu\1^!>!u22`pvu2`2<bttjho!u4:`sfh`ofyu\2^!>!u4:`sfh\1^<bttjho!u4:`sfh`ofyu\3^!>!u4:`sfh\2^<bttjho!u:4`pvu2!>!!!u4:`pvu2<bttjho!u63`pvu2!>!fnc2`pvu2\34;1^<bttjho!u66`pvu2!>!35(c111111111111111111111111<bttjho!u64`pvu2!>!)u61`pvu2!>>!2(c1!@!u63`pvu2!;u66`pvu2*<bmxbzt!A)qptfehf!dml*cfhjo!;!u56`qspdfttjg!)stuo!>>!2(c1*!cfhjou56`pvu2!=>!35(c111111111111111111111111<foefmtf!cfhjou56`pvu2!=>!u64`pvu2<foefoebttjho!u45`pvu2!>!u56`pvu2\4;1^<bmxbzt!A)qptfehf!dml*cfhjo!;!u2`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`sfh\1^!=>!5(c1111<u2`sfh\2^!=>!5(c1111<u2`sfh\3^!=>!5(c1111<foefmtf!cfhjou2`sfh\1^!=>!u2`sfh`ofyu\1^<u2`sfh\2^!=>!u2`sfh`ofyu\2^<u2`sfh\3^!=>!u2`sfh`ofyu\3^<foefoebttjho!u2`pvu2`2!>!u2`sfh\3^<bttjho!u2`sfh`ofyu\1^!>!u45`pvu2<bttjho!u2`sfh`ofyu\2^!>!u2`sfh\1^<bttjho!u2`sfh`ofyu\3^!>!u2`sfh\2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u46`qspdfttjg!)stuo!>>!2(c1*!cfhjou46`sfh\1^!=>!5(c1111<u46`sfh\2^!=>!5(c1111<u46`sfh\3^!=>!5(c1111<foefmtf!cfhjou46`sfh\1^!=>!u46`sfh`ofyu\1^<u46`sfh\2^!=>!u46`sfh`ofyu\2^<u46`sfh\3^!=>!u46`sfh`ofyu\3^<foefoebttjho!u46`pvu2!>!u46`sfh\3^<bttjho!u46`sfh`ofyu\1^!>!u2`pvu2`2<bttjho!u46`sfh`ofyu\2^!>!u46`sfh\1^<bttjho!u46`sfh`ofyu\3^!>!u46`sfh\2^<bttjho!u54`pvu2!>!4(c111<bttjho!u55`pvu2!>!4(c112<bttjho!u61`pvu2`2!>!4(c121<bttjho!u57`pvu2`2!>!4(c122<bttjho!u56`pvu2`2!>!4(c112<bttjho!u5:`pvu2`2!>!4(c121<bttjho!u59`pvu2`2!>!4(c122<bttjho!u58`pvu2`2!>!4(c211<bmxbzt!A)u46`pvu2-!u54`pvu2-!u55`pvu2-!u56`pvu2`2-!u57`pvu2`2-!u58`pvu2`2-!u59`pvu2`2-u5:`pvu2`2-!u61`pvu2`2*!cfhjodbtf!)!u46`pvu2*5(c1111!;cfhjoPvu2!>!u54`pvu2<foe5(c1112!;cfhjoPvu2!>!u55`pvu2<foe5(c1121!;cfhjoPvu2!>!u54`pvu2<foe5(c1122!;cfhjoPvu2!>!u61`pvu2`2<foe5(c1211!;cfhjoPvu2!>!u54`pvu2<foe5(c1212!;cfhjoPvu2!>!u54`pvu2<foe5(c1221!;cfhjoPvu2!>!u54`pvu2<foe5(c1222!;cfhjoPvu2!>!u57`pvu2`2<foe5(c2111!;cfhjoPvu2!>!u56`pvu2`2<foe5(c2112!;cfhjoPvu2!>!u54`pvu2<foe5(c2121!;cfhjoPvu2!>!u54`pvu2<foe5(c2122!;cfhjoPvu2!>!u54`pvu2<foe5(c2211!;cfhjoPvu2!>!u5:`pvu2`2<foe5(c2212!;cfhjoPvu2!>!u54`pvu2<foe5(c2221!;cfhjoPvu2!>!u59`pvu2`2<foe5(c2222!;cfhjoPvu2!>!u58`pvu2`2<foeefgbvmu!;cfhjoPvu2!>!u54`pvu2<foefoedbtffoebttjho!u:2`pvu2!>!4(c111<bttjho!u53`pvu2!>!Pvu2!,!u52`pvu2<bttjho!u:1`pvu2!>!)u:4`pvu2!>>!2(c1!@!u53`pvu2!;u:2`pvu2*<bmxbzt!A)qptfehf!dml*cfhjo!;!u52`qspdfttjg!)stuo!>>!2(c1*!cfhjou52`pvu2!=>!4(c111<foefmtf!cfhjou52`pvu2!=>!u:1`pvu2<foefoebttjho!u85`pvu2!>!u52`pvu2\3^<bmxbzt!A)qptfehf!dml*cfhjo!;!u86`qspdfttjg!)stuo!>>!2(c1*!cfhjou86`pvu2!=>!2(c1<foefmtf!cfhjou86`pvu2!=>!u85`pvu2<foefoebttjho!u87`pvu2!>!u86`pvu2!_!u85`pvu2<bttjho!u88`pvu2!>!u52`pvu2\2;1^<bttjho!u3:`pvu2!>!u::`pvu2\6;2^<bttjho!u42`pvu2!>!u3:`pvu2<bttjho!u35`pvu2`2!>!|2(c1-!u42`pvu2~<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`sfh\1^!=>!7(tc111111<u21`sfh\2^!=>!7(tc111111<u21`sfh\3^!=>!7(tc111111<foefmtf!cfhjou21`sfh\1^!=>!u21`sfh`ofyu\1^<u21`sfh\2^!=>!u21`sfh`ofyu\2^<u21`sfh\3^!=>!u21`sfh`ofyu\3^<foefoebttjho!u21`pvu2!>!u21`sfh\3^<bttjho!u21`sfh`ofyu\1^!>!u35`pvu2`2<bttjho!u21`sfh`ofyu\2^!>!u21`sfh\1^<bttjho!u21`sfh`ofyu\3^!>!u21`sfh\2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u:`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`2!=>!7(tc111111<foefmtf!cfhjou:`pvu2`2!=>!u21`pvu2<foefoebttjho!u5`pvu2`2!>!u:`pvu2`2\5;4^<bttjho!u27`pvu2`2!>!u56`pvu2\34;2:^<bttjho!u36`pvu2`2!>!u27`pvu2`2<bttjho!u31`pvu2!>!|2(c1-!u36`pvu2`2~<bmxbzt!A)qptfehf!dml*cfhjo!;!u:`3`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`3!=>!7(tc111111<foefmtf!cfhjou:`pvu2`3!=>!u31`pvu2<foefoebttjho!u5`pvu2`3!>!u:`pvu2`3\5;4^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou21`pvu2`2!=>!jebu<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u48`qspdfttjg!)stuo!>>!2(c1*!cfhjou48`pvu2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou48`pvu2!=>!u21`pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u49`qspdfttjg!)stuo!>>!2(c1*!cfhjou49`pvu2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou49`pvu2!=>!u48`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u45`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou45`pvu2`2!=>!21(c1111111111<foefmtf!cfhjou45`pvu2`2!=>!u35`pvu2<foefoebttjho!u44`pvu2!>!)u:`pvu2!">!2(c1!@!2(c2!;2(c1*<bmxbzt!A)qptfehf!dml*cfhjo!;!u46`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou46`pvu2`2!=>!2(c1<foefmtf!cfhjou46`pvu2`2!=>!u44`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u47`qspdfttjg!)stuo!>>!2(c1*!cfhjou47`pvu2!=>!2(c1<foefmtf!cfhjou47`pvu2!=>!u46`pvu2`2<foefoeTjnqmfEvbmQpsuSBN`hfofsjd!$)/BeesXjeui)21*-/EbubXjeui)43**v`u8!)/dml)dml*-/xs`ejo)u49`pvu2*-/xs`bees)u45`pvu2`2*-/xs`fo)u47`pvu2*-/se`bees)u35`pvu2*-/se`epvu)u8`pvu2**<bttjho!u52`pvu2`2!>!u8`pvu2\34;27^<bmxbzt!A)qptfehf!dml*cfhjo!;!u213`qspdfttjg!)stuo!>>!2(c1*!cfhjou213`pvu2!=>!9(c11111111<foefmtf!cfhjou213`pvu2!=>!u52`pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u4`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou4`pvu2`2!=>!9(c11111111<foefmtf!cfhjou4`pvu2`2!=>!u213`pvu2<foefoebttjho!u53`pvu2`2!>!u8`pvu2\42;35^<bmxbzt!A)qptfehf!dml*cfhjo!;!u212`qspdfttjg!)stuo!>>!2(c1*!cfhjou212`pvu2!=>!9(c11111111<foefmtf!cfhjou212`pvu2!=>!u53`pvu2`2<foefoebttjho!u22`4!>!|2(c1-!u212`pvu2~<bttjho!u22`5!>!|2(c1-!u4`pvu2`2~<bttjho!u22`pvu2`3!>!u22`4!,!u22`5<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`2!=>!9(c11111111<foefmtf!cfhjou8`pvu2`2!=>!u4`pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`2!=>!:(c111111111<foefmtf!cfhjou23`pvu2`2!=>!u22`pvu2`3<foefoebttjho!u24`pvu2`2!>!u23`pvu2`2\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`3`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`3!=>!9(c11111111<foefmtf!cfhjou21`pvu2`3!=>!u212`pvu2<foefoebttjho!u6`pvu2`2!>!)u5`pvu2`3!>>!3(c11!@!u8`pvu2`2!;)u5`pvu2`3!>>!3(c12!@!u24`pvu2`2!;)u5`pvu2`3!>>!3(c21!@!u21`pvu2`3!;u21`pvu2`3***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`2!=>!9(c11111111<foefmtf!cfhjou25`pvu2`2!=>!u6`pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`3`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`3!=>!9(c11111111<foefmtf!cfhjou2`pvu2`3!=>!u25`pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:`4`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`4!=>!7(tc111111<foefmtf!cfhjou:`pvu2`4!=>!u31`pvu2<foefoebttjho!u5`pvu2`4!>!u:`pvu2`4\5;4^<bmxbzt!A)qptfehf!dml*cfhjo!;!u7`qspdfttjg!)stuo!>>!2(c1*!cfhjou7`pvu2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou7`pvu2!=>!u21`pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u83`qspdfttjg!)stuo!>>!2(c1*!cfhjou83`pvu2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou83`pvu2!=>!u7`pvu2<foefoebttjho!u21:`pvu2!>!u83`pvu2\34;27^<bmxbzt!A)qptfehf!dml*cfhjo!;!u34`qspdfttjg!)stuo!>>!2(c1*!cfhjou34`pvu2!=>!9(c11111111<foefmtf!cfhjou34`pvu2!=>!u21:`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u8`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`3!=>!9(c11111111<foefmtf!cfhjou8`pvu2`3!=>!u34`pvu2<foefoebttjho!u221`pvu2!>!u83`pvu2\42;35^<bmxbzt!A)qptfehf!dml*cfhjo!;!u3`qspdfttjg!)stuo!>>!2(c1*!cfhjou3`pvu2!=>!9(c11111111<foefmtf!cfhjou3`pvu2!=>!u221`pvu2<foefoebttjho!u22`7!>!|2(c1-!u3`pvu2~<bttjho!u22`8!>!|2(c1-!u8`pvu2`3~<bttjho!u22`pvu2`4!>!u22`7!,!u22`8<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`3`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`4!=>!9(c11111111<foefmtf!cfhjou8`pvu2`4!=>!u8`pvu2`3<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`3`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`3!=>!:(c111111111<foefmtf!cfhjou23`pvu2`3!=>!u22`pvu2`4<foefoebttjho!u24`pvu2`3!>!u23`pvu2`3\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`4`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`4!=>!9(c11111111<foefmtf!cfhjou21`pvu2`4!=>!u3`pvu2<foefoebttjho!u6`pvu2`3!>!)u5`pvu2`4!>>!3(c11!@!u8`pvu2`4!;)u5`pvu2`4!>>!3(c12!@!u24`pvu2`3!;)u5`pvu2`4!>>!3(c21!@!u21`pvu2`4!;u21`pvu2`4***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`3`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`3!=>!9(c11111111<foefmtf!cfhjou25`pvu2`3!=>!u6`pvu2`3<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`4`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`4!=>!9(c11111111<foefmtf!cfhjou2`pvu2`4!=>!u25`pvu2`3<foefoebttjho!u22`:!>!|2(c1-!u2`pvu2`4~<bttjho!u22`21!>!|2(c1-!u2`pvu2`3~<bttjho!u22`pvu2`5!>!u22`:!,!u22`21<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`4`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`5!=>!9(c11111111<foefmtf!cfhjou8`pvu2`5!=>!u2`pvu2`3<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`4`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`4!=>!:(c111111111<foefmtf!cfhjou23`pvu2`4!=>!u22`pvu2`5<foefoebttjho!u24`pvu2`4!>!u23`pvu2`4\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`5`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`5!=>!9(c11111111<foefmtf!cfhjou21`pvu2`5!=>!u2`pvu2`4<foefoebttjho!u6`pvu2`4!>!)u5`pvu2`2!>>!3(c11!@!u8`pvu2`5!;)u5`pvu2`2!>>!3(c12!@!u24`pvu2`4!;)u5`pvu2`2!>>!3(c21!@!u21`pvu2`5!;u21`pvu2`5***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`4`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`4!=>!9(c11111111<foefmtf!cfhjou25`pvu2`4!=>!u6`pvu2`4<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`5`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`5!=>!9(c11111111<foefmtf!cfhjou2`pvu2`5!=>!u25`pvu2`4<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:`5`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`5!=>!7(tc111111<foefmtf!cfhjou:`pvu2`5!=>!u21`pvu2<foefoebttjho!u5`pvu2`5!>!u:`pvu2`5\5;4^<bttjho!u28`pvu2`2!>!u56`pvu2\29;25^<bttjho!u37`pvu2`2!>!u28`pvu2`2<bttjho!u32`pvu2`2!>!|2(c1-!u37`pvu2`2~<bmxbzt!A)qptfehf!dml*cfhjo!;!u:`6`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`6!=>!7(tc111111<foefmtf!cfhjou:`pvu2`6!=>!u32`pvu2`2<foefoebttjho!u5`pvu2`6!>!u:`pvu2`6\5;4^<bttjho!u51`pvu2!>!u8`pvu2\26;9^<bmxbzt!A)qptfehf!dml*cfhjo!;!u214`qspdfttjg!)stuo!>>!2(c1*!cfhjou214`pvu2!=>!9(c11111111<foefmtf!cfhjou214`pvu2!=>!u51`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u5`7`qspdfttjg!)stuo!>>!2(c1*!cfhjou5`pvu2`7!=>!9(c11111111<foefmtf!cfhjou5`pvu2`7!=>!u214`pvu2<foefoebttjho!u22`23!>!|2(c1-!u213`pvu2~<bttjho!u22`24!>!|2(c1-!u5`pvu2`7~<bttjho!u22`pvu2`6!>!u22`23!,!u22`24<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`5`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`6!=>!9(c11111111<foefmtf!cfhjou8`pvu2`6!=>!u5`pvu2`7<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`5`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`5!=>!:(c111111111<foefmtf!cfhjou23`pvu2`5!=>!u22`pvu2`6<foefoebttjho!u24`pvu2`5!>!u23`pvu2`5\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`6`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`6!=>!9(c11111111<foefmtf!cfhjou21`pvu2`6!=>!u213`pvu2<foefoebttjho!u6`pvu2`5!>!)u5`pvu2`6!>>!3(c11!@!u8`pvu2`6!;)u5`pvu2`6!>>!3(c12!@!u24`pvu2`5!;)u5`pvu2`6!>>!3(c21!@!u21`pvu2`6!;u21`pvu2`6***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`5`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`5!=>!9(c11111111<foefmtf!cfhjou25`pvu2`5!=>!u6`pvu2`5<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`6`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`6!=>!9(c11111111<foefmtf!cfhjou2`pvu2`6!=>!u25`pvu2`5<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:`7`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`7!=>!7(tc111111<foefmtf!cfhjou:`pvu2`7!=>!u32`pvu2`2<foefoebttjho!u5`pvu2`8!>!u:`pvu2`7\5;4^<bttjho!u219`pvu2!>!u83`pvu2\26;9^<bmxbzt!A)qptfehf!dml*cfhjo!;!u54`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou54`pvu2`2!=>!9(c11111111<foefmtf!cfhjou54`pvu2`2!=>!u219`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u9`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou9`pvu2`2!=>!9(c11111111<foefmtf!cfhjou9`pvu2`2!=>!u54`pvu2`2<foefoebttjho!u22`26!>!|2(c1-!u34`pvu2~<bttjho!u22`27!>!|2(c1-!u9`pvu2`2~<bttjho!u22`pvu2`7!>!u22`26!,!u22`27<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`6`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`7!=>!9(c11111111<foefmtf!cfhjou8`pvu2`7!=>!u9`pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`6`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`6!=>!:(c111111111<foefmtf!cfhjou23`pvu2`6!=>!u22`pvu2`7<foefoebttjho!u24`pvu2`6!>!u23`pvu2`6\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`7`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`7!=>!9(c11111111<foefmtf!cfhjou21`pvu2`7!=>!u34`pvu2<foefoebttjho!u6`pvu2`6!>!)u5`pvu2`8!>>!3(c11!@!u8`pvu2`7!;)u5`pvu2`8!>>!3(c12!@!u24`pvu2`6!;)u5`pvu2`8!>>!3(c21!@!u21`pvu2`7!;u21`pvu2`7***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`6`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`6!=>!9(c11111111<foefmtf!cfhjou25`pvu2`6!=>!u6`pvu2`6<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`7`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`7!=>!9(c11111111<foefmtf!cfhjou2`pvu2`7!=>!u25`pvu2`6<foefoebttjho!u22`29!>!|2(c1-!u2`pvu2`7~<bttjho!u22`2:!>!|2(c1-!u2`pvu2`6~<bttjho!u22`pvu2`8!>!u22`29!,!u22`2:<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`7`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`8!=>!9(c11111111<foefmtf!cfhjou8`pvu2`8!=>!u2`pvu2`6<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`7`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`7!=>!:(c111111111<foefmtf!cfhjou23`pvu2`7!=>!u22`pvu2`8<foefoebttjho!u24`pvu2`7!>!u23`pvu2`7\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`8`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`8!=>!9(c11111111<foefmtf!cfhjou21`pvu2`8!=>!u2`pvu2`7<foefoebttjho!u6`pvu2`7!>!)u5`pvu2`5!>>!3(c11!@!u8`pvu2`8!;)u5`pvu2`5!>>!3(c12!@!u24`pvu2`7!;)u5`pvu2`5!>>!3(c21!@!u21`pvu2`8!;u21`pvu2`8***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`7`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`7!=>!9(c11111111<foefmtf!cfhjou25`pvu2`7!=>!u6`pvu2`7<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`8`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`8!=>!9(c11111111<foefmtf!cfhjou2`pvu2`8!=>!u25`pvu2`7<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:`8`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`8!=>!7(tc111111<foefmtf!cfhjou:`pvu2`8!=>!u21`pvu2<foefoebttjho!u5`pvu2`9!>!u:`pvu2`8\5;4^<bttjho!u29`pvu2`2!>!u56`pvu2\24;:^<bttjho!u38`pvu2`2!>!u29`pvu2`2<bttjho!u33`pvu2`2!>!|2(c1-!u38`pvu2`2~<bmxbzt!A)qptfehf!dml*cfhjo!;!u:`9`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`9!=>!7(tc111111<foefmtf!cfhjou:`pvu2`9!=>!u33`pvu2`2<foefoebttjho!u5`pvu2`:!>!u:`pvu2`9\5;4^<bttjho!u4:`pvu2`2!>!u8`pvu2\8;1^<bmxbzt!A)qptfehf!dml*cfhjo!;!u215`qspdfttjg!)stuo!>>!2(c1*!cfhjou215`pvu2!=>!9(c11111111<foefmtf!cfhjou215`pvu2!=>!u4:`pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u6`8`qspdfttjg!)stuo!>>!2(c1*!cfhjou6`pvu2`8!=>!9(c11111111<foefmtf!cfhjou6`pvu2`8!=>!u215`pvu2<foefoebttjho!u22`32!>!|2(c1-!u214`pvu2~<bttjho!u22`33!>!|2(c1-!u6`pvu2`8~<bttjho!u22`pvu2`9!>!u22`32!,!u22`33<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`8`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`9!=>!9(c11111111<foefmtf!cfhjou8`pvu2`9!=>!u6`pvu2`8<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`8`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`8!=>!:(c111111111<foefmtf!cfhjou23`pvu2`8!=>!u22`pvu2`9<foefoebttjho!u24`pvu2`8!>!u23`pvu2`8\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`9`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`9!=>!9(c11111111<foefmtf!cfhjou21`pvu2`9!=>!u214`pvu2<foefoebttjho!u6`pvu2`9!>!)u5`pvu2`:!>>!3(c11!@!u8`pvu2`9!;)u5`pvu2`:!>>!3(c12!@!u24`pvu2`8!;)u5`pvu2`:!>>!3(c21!@!u21`pvu2`9!;u21`pvu2`9***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`8`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`8!=>!9(c11111111<foefmtf!cfhjou25`pvu2`8!=>!u6`pvu2`9<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`9`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`9!=>!9(c11111111<foefmtf!cfhjou2`pvu2`9!=>!u25`pvu2`8<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:`:`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`:!=>!7(tc111111<foefmtf!cfhjou:`pvu2`:!=>!u33`pvu2`2<foefoebttjho!u5`pvu2`21!>!u:`pvu2`:\5;4^<bttjho!u218`pvu2!>!u83`pvu2\8;1^<bmxbzt!A)qptfehf!dml*cfhjo!;!u55`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou55`pvu2`2!=>!9(c11111111<foefmtf!cfhjou55`pvu2`2!=>!u218`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:`21`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`21!=>!9(c11111111<foefmtf!cfhjou:`pvu2`21!=>!u55`pvu2`2<foefoebttjho!u22`35!>!|2(c1-!u54`pvu2`2~<bttjho!u22`36!>!|2(c1-!u:`pvu2`21~<bttjho!u22`pvu2`:!>!u22`35!,!u22`36<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`9`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`:!=>!9(c11111111<foefmtf!cfhjou8`pvu2`:!=>!u:`pvu2`21<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`9`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`9!=>!:(c111111111<foefmtf!cfhjou23`pvu2`9!=>!u22`pvu2`:<foefoebttjho!u24`pvu2`9!>!u23`pvu2`9\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`:`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`:!=>!9(c11111111<foefmtf!cfhjou21`pvu2`:!=>!u54`pvu2`2<foefoebttjho!u6`pvu2`:!>!)u5`pvu2`21!>>!3(c11!@!u8`pvu2`:!;)u5`pvu2`21!>>!3(c12!@!u24`pvu2`9!;)u5`pvu2`21!>>!3(c21!@!u21`pvu2`:!;u21`pvu2`:***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`9`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`9!=>!9(c11111111<foefmtf!cfhjou25`pvu2`9!=>!u6`pvu2`:<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`:`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`:!=>!9(c11111111<foefmtf!cfhjou2`pvu2`:!=>!u25`pvu2`9<foefoebttjho!u22`38!>!|2(c1-!u2`pvu2`:~<bttjho!u22`39!>!|2(c1-!u2`pvu2`9~<bttjho!u22`pvu2`21!>!u22`38!,!u22`39<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`:`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`21!=>!9(c11111111<foefmtf!cfhjou8`pvu2`21!=>!u2`pvu2`9<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`:`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`:!=>!:(c111111111<foefmtf!cfhjou23`pvu2`:!=>!u22`pvu2`21<foefoebttjho!u24`pvu2`:!>!u23`pvu2`:\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`21`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`21!=>!9(c11111111<foefmtf!cfhjou21`pvu2`21!=>!u2`pvu2`:<foefoebttjho!u6`pvu2`21!>!)u5`pvu2`9!>>!3(c11!@!u8`pvu2`21!;)u5`pvu2`9!>>!3(c12!@!u24`pvu2`:!;)u5`pvu2`9!>>!3(c21!@!u21`pvu2`21!;u21`pvu2`21***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`:`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`:!=>!9(c11111111<foefmtf!cfhjou25`pvu2`:!=>!u6`pvu2`21<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`21`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`21!=>!9(c11111111<foefmtf!cfhjou2`pvu2`21!=>!u25`pvu2`:<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:`22`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`22!=>!7(tc111111<foefmtf!cfhjou:`pvu2`22!=>!u21`pvu2<foefoebttjho!u5`pvu2`22!>!u:`pvu2`22\5;4^<bttjho!u2:`pvu2!>!u56`pvu2\9;5^<bttjho!u39`pvu2`2!>!u2:`pvu2<bttjho!u34`pvu2`2!>!|2(c1-!u39`pvu2`2~<bmxbzt!A)qptfehf!dml*cfhjo!;!u:`23`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`23!=>!7(tc111111<foefmtf!cfhjou:`pvu2`23!=>!u34`pvu2`2<foefoebttjho!u5`pvu2`23!>!u:`pvu2`23\5;4^<bttjho!u22`41!>!|2(c1-!u215`pvu2~<bttjho!u22`42!>!|2(c1-!u212`pvu2~<bttjho!u22`pvu2`22!>!u22`41!,!u22`42<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`21`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`22!=>!9(c11111111<foefmtf!cfhjou8`pvu2`22!=>!u212`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`21`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`21!=>!:(c111111111<foefmtf!cfhjou23`pvu2`21!=>!u22`pvu2`22<foefoebttjho!u24`pvu2`21!>!u23`pvu2`21\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`22`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`22!=>!9(c11111111<foefmtf!cfhjou21`pvu2`22!=>!u215`pvu2<foefoebttjho!u6`pvu2`22!>!)u5`pvu2`23!>>!3(c11!@!u8`pvu2`22!;)u5`pvu2`23!>>!3(c12!@!u24`pvu2`21!;)u5`pvu2`23!>>!3(c21!@!u21`pvu2`22!;u21`pvu2`22***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`21`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`21!=>!9(c11111111<foefmtf!cfhjou25`pvu2`21!=>!u6`pvu2`22<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`22`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`22!=>!9(c11111111<foefmtf!cfhjou2`pvu2`22!=>!u25`pvu2`21<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u:`24`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2`24!=>!7(tc111111<foefmtf!cfhjou:`pvu2`24!=>!u34`pvu2`2<foefoebttjho!u5`pvu2`24!>!u:`pvu2`24\5;4^<bttjho!u22`44!>!|2(c1-!u55`pvu2`2~<bttjho!u22`45!>!|2(c1-!u3`pvu2~<bttjho!u22`pvu2`23!>!u22`44!,!u22`45<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`22`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`23!=>!9(c11111111<foefmtf!cfhjou8`pvu2`23!=>!u3`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`22`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`22!=>!:(c111111111<foefmtf!cfhjou23`pvu2`22!=>!u22`pvu2`23<foefoebttjho!u24`pvu2`22!>!u23`pvu2`22\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`23`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`23!=>!9(c11111111<foefmtf!cfhjou21`pvu2`23!=>!u55`pvu2`2<foefoebttjho!u6`pvu2`23!>!)u5`pvu2`24!>>!3(c11!@!u8`pvu2`23!;)u5`pvu2`24!>>!3(c12!@!u24`pvu2`22!;)u5`pvu2`24!>>!3(c21!@!u21`pvu2`23!;u21`pvu2`23***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`22`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`22!=>!9(c11111111<foefmtf!cfhjou25`pvu2`22!=>!u6`pvu2`23<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`23`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`23!=>!9(c11111111<foefmtf!cfhjou2`pvu2`23!=>!u25`pvu2`22<foefoebttjho!u22`47!>!|2(c1-!u2`pvu2`23~<bttjho!u22`48!>!|2(c1-!u2`pvu2`22~<bttjho!u22`pvu2`24!>!u22`47!,!u22`48<bmxbzt!A)qptfehf!dml*cfhjo!;!u8`23`qspdfttjg!)stuo!>>!2(c1*!cfhjou8`pvu2`24!=>!9(c11111111<foefmtf!cfhjou8`pvu2`24!=>!u2`pvu2`22<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u23`23`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2`23!=>!:(c111111111<foefmtf!cfhjou23`pvu2`23!=>!u22`pvu2`24<foefoebttjho!u24`pvu2`23!>!u23`pvu2`23\9;2^<bmxbzt!A)qptfehf!dml*cfhjo!;!u21`24`qspdfttjg!)stuo!>>!2(c1*!cfhjou21`pvu2`24!=>!9(c11111111<foefmtf!cfhjou21`pvu2`24!=>!u2`pvu2`23<foefoebttjho!u6`pvu2`24!>!)u5`pvu2`22!>>!3(c11!@!u8`pvu2`24!;)u5`pvu2`22!>>!3(c12!@!u24`pvu2`23!;)u5`pvu2`22!>>!3(c21!@!u21`pvu2`24!;u21`pvu2`24***<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`23`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2`23!=>!9(c11111111<foefmtf!cfhjou25`pvu2`23!=>!u6`pvu2`24<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`24`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2`24!=>!9(c11111111<foefmtf!cfhjou2`pvu2`24!=>!u25`pvu2`23<foefoebttjho!u64`pvu2`2!>!|u2`pvu2`5-!u2`pvu2`8-!u2`pvu2`21-!u2`pvu2`24~<bttjho!u83`pvu2`2!>!u64`pvu2`2\8;1^<bttjho!u81`pvu2!>!u64`pvu2`2\26;1^<bttjho!u79`pvu2!>!u64`pvu2`2\34;1^<bttjho!u77`pvu2!>!u64`pvu2`2\42;35^<bttjho!u71`pvu2`2!>!u64`pvu2`2\42;27^<bttjho!u74`pvu2`2!>!u64`pvu2`2\42;9^<bttjho!u69`pvu2`2!>!u63`pvu2`2\42;1^<bttjho!u65`pvu2`2!>!|u69`pvu2`2-!u64`pvu2`2~<bttjho!u75`pvu2!>!u63`pvu2`2\4:;1^<bttjho!u73`pvu2`2!>!|u75`pvu2-!u74`pvu2`2~<bttjho!u76`pvu2!>!u63`pvu2`2\58;1^<bttjho!u6:`pvu2`2!>!|u76`pvu2-!u71`pvu2`2~<bttjho!u78`pvu2!>!u63`pvu2`2\66;1^<bttjho!u67`pvu2`2!>!|u78`pvu2-!u77`pvu2~<bttjho!u7:`pvu2!>!u63`pvu2`2\4:;1^<bttjho!u68`pvu2`2!>!|u7:`pvu2-!u79`pvu2~<bttjho!u82`pvu2`2!>!u63`pvu2`2\58;1^<bttjho!u72`pvu2`2!>!|u82`pvu2`2-!u81`pvu2~<bttjho!u84`pvu2`2!>!u63`pvu2`2\66;1^<bttjho!u66`pvu2`2!>!|u84`pvu2`2-!u83`pvu2`2~<bmxbzt!A)u46`pvu2-!u63`pvu2`2-!u65`pvu2`2-!u66`pvu2`2-!u67`pvu2`2-!u68`pvu2`2-u6:`pvu2`2-!u72`pvu2`2-!u73`pvu2`2*!cfhjodbtf!)!u46`pvu2*5(c1111!;cfhjoPvu2`2!>!u63`pvu2`2<foe5(c1112!;cfhjoPvu2`2!>!u66`pvu2`2<foe5(c1121!;cfhjoPvu2`2!>!u63`pvu2`2<foe5(c1122!;cfhjoPvu2`2!>!u72`pvu2`2<foe5(c1211!;cfhjoPvu2`2!>!u63`pvu2`2<foe5(c1212!;cfhjoPvu2`2!>!u63`pvu2`2<foe5(c1221!;cfhjoPvu2`2!>!u63`pvu2`2<foe5(c1222!;cfhjoPvu2`2!>!u68`pvu2`2<foe5(c2111!;cfhjoPvu2`2!>!u67`pvu2`2<foe5(c2112!;cfhjoPvu2`2!>!u63`pvu2`2<foe5(c2121!;cfhjoPvu2`2!>!u63`pvu2`2<foe5(c2122!;cfhjoPvu2`2!>!u63`pvu2`2<foe5(c2211!;cfhjoPvu2`2!>!u6:`pvu2`2<foe5(c2212!;cfhjoPvu2`2!>!u63`pvu2`2<foe5(c2221!;cfhjoPvu2`2!>!u73`pvu2`2<foe5(c2222!;cfhjoPvu2`2!>!u65`pvu2`2<foeefgbvmu!;cfhjoPvu2`2!>!u63`pvu2`2<foefoedbtffoebmxbzt!A)qptfehf!dml*cfhjo!;!u63`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou63`pvu2`2!=>!75(i1111111111111111<foefmtf!cfhjou63`pvu2`2!=>!Pvu2`2<foefoebttjho!u8:`pvu2`2!>!u63`pvu2`2\42;1^<bttjho!u91`pvu2!>!u63`pvu2`2\4:;9^<bttjho!u92`pvu2!>!u63`pvu2`2\58;27^<bttjho!u93`pvu2`2!>!u63`pvu2`2\66;35^<bttjho!u89`pvu2`2!>!)u88`pvu2!>>!3(c11!@!u8:`pvu2`2!;)u88`pvu2!>>!3(c12!@!u91`pvu2!;)u88`pvu2!>>!3(c21!@!u92`pvu2!;u93`pvu2`2***<bttjho!u95`pvu2!>!)u87`pvu2!>>!2(c1!@!u94`pvu2`2!;u89`pvu2`2*<bmxbzt!A)qptfehf!dml*cfhjo!;!u94`2`qspdfttjg!)stuo!>>!2(c1*!cfhjou94`pvu2`2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou94`pvu2`2!=>!u95`pvu2<foefoebttjho!pebu!>!u94`pvu2`2<bmxbzt!A)qptfehf!dml*cfhjo!;!u97`qspdfttjg!)stuo!>>!2(c1*!cfhjou97`pvu2!=>!2(c1<foefmtf!cfhjou97`pvu2!=>!u4:`pvu2<foefoebttjho!u:3`pvu2!>!u97`pvu2!'!u87`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u96`qspdfttjg!)stuo!>>!2(c1*!cfhjou96`pvu2!=>!2(c1<foefmtf!cfhjou96`pvu2!=>!u:3`pvu2<foefoebttjho!pef!>!u96`pvu2<foenpevmfaujnftdbmf!2!ot!0!2!otnpevmf!UpTdm)dml-stuo-Jo2-Jo3-Jo4-Pvu2-Pvu3-Pvu4-Pvu5-Pvu6*<qbsbnfufs!jt`u5`JO`tu2!>!3(e1-!jt`u5`JO`tu3!>!3(e2-!jt`u5`JO`tu4!>!3(e3-!jt`u5`JO`tu5!>!3(e4<joqvu!!!dml<joqvu!!!stuo<joqvu!!!Jo2<joqvu!!!\42;1^!Jo3<joqvu!!!\:;1^!Jo4<pvuqvu!!Pvu2<pvuqvu!!Pvu3<pvuqvu!!Pvu4<pvuqvu!!Pvu5<pvuqvu!!\42;1^!Pvu6<xjsf!u4`pvu2<sfh!!u6`pvu2<xjsf!u8`pvu2<sfh!\2;1^!jt`u5<xjsf!Pvu2`2<xjsf!Pvu3`2<xjsf!Pvu4`2<sfh!\:;1^!u2<sfh!!Pvu2`sfh<sfh!!Pvu3`sfh<sfh!!Pvu4`sfh<sfh!\2;1^!jt`u5`ofyu<sfh!\:;1^!u2`ofyu<sfh!!Pvu2`sfh`ofyu<sfh!!Pvu3`sfh`ofyu<sfh!!Pvu4`sfh`ofyu<sfh!!u7`pvu2<sfh!!u:`pvu2<sfh!!\1;4^!u39`sfh<xjsf!\1;4^!u39`sfh`ofyu<xjsf!u39`pvu2<sfh!!u9`pvu2<sfh!!u38`pvu2<xjsf!\8;1^!u21`pvu2<xjsf!u28`pvu2<xjsf!u2:`pvu2<sfh!!u33`pvu2<xjsf!u29`pvu2<xjsf!u32`pvu2<xjsf!u31`pvu2<sfh!!\1;2^!u34`sfh<xjsf!\1;2^!u34`sfh`ofyu<xjsf!u34`pvu2<sfh!!u22`pvu2<sfh!\42;1^!u25`pvu2<xjsf!\34;1^!u24`pvu2<xjsf!\42;1^!u26`pvu2<xjsf!\8;1^!u27`pvu2<xjsf!\8;1^!u35`pvu2<xjsf!\8;1^!u36`pvu2<xjsf!\8;1^!u37`pvu2<xjsf!\42;1^!u23`pvu2<sfh!\42;1^!u3:`sfh!\1;3^<xjsf!\42;1^!u3:`sfh`ofyu!\1;3^<xjsf!\42;1^!u3:`pvu2<sfh!\21;1^!bee`ufnq<sfh!\21;1^!u`1<bttjho!u4`pvu2!>!!!Jo2<bmxbzt!A)qptfehf!dml*cfhjo!;!u6`qspdfttjg!)stuo!>>!2(c1*!cfhjou6`pvu2!=>!2(c1<foefmtf!cfhjou6`pvu2!=>!u4`pvu2<foefoebttjho!u8`pvu2!>!u6`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u5`qspdfttjg!)stuo!>>!2(c1*!cfhjou2!=>!21(c1111111111<Pvu2`sfh!=>!2(c1<Pvu3`sfh!=>!2(c1<Pvu4`sfh!=>!2(c1<jt`u5!=>!jt`u5`JO`tu2<foefmtf!cfhjojt`u5!=>!jt`u5`ofyu<u2!=>!u2`ofyu<Pvu2`sfh!=>!Pvu2`sfh`ofyu<Pvu3`sfh!=>!Pvu3`sfh`ofyu<Pvu4`sfh!=>!Pvu4`sfh`ofyu<foefoebmxbzt!A)Jo4-!Pvu2`sfh-!Pvu3`sfh-!Pvu4`sfh-!jt`u5-!u2-!u8`pvu2*!cfhjoPvu2`sfh`ofyu!>!Pvu2`sfh<Pvu3`sfh`ofyu!>!Pvu3`sfh<Pvu4`sfh`ofyu!>!Pvu4`sfh<jt`u5`ofyu!>!jt`u5<u2`ofyu!>!u2<dbtf!)!jt`u5*jt`u5`JO`tu2!;cfhjojg!)2(c1!>>!u8`pvu2*!cfhjoPvu2`sfh`ofyu!>!2(c1<Pvu3`sfh`ofyu!>!2(c1<Pvu4`sfh`ofyu!>!2(c1<jt`u5`ofyu!>!jt`u5`JO`tu2<foefmtf!jg!)2(c2!>>!u8`pvu2*!cfhjoPvu2`sfh`ofyu!>!2(c2<Pvu3`sfh`ofyu!>!2(c2<Pvu4`sfh`ofyu!>!2(c1<u2`ofyu!>!21(c1111111111<jt`u5`ofyu!>!jt`u5`JO`tu3<foefoejt`u5`JO`tu3!;cfhjojg!)Jo4!?!u2*!cfhjoPvu2`sfh`ofyu!>!2(c1<Pvu3`sfh`ofyu!>!2(c2<Pvu4`sfh`ofyu!>!2(c2<u`1!>!|2(c1-!u2~<bee`ufnq!>!u`1!,!22(c11111111112<jg!)bee`ufnq\21^!">!2(c1*!cfhjou2`ofyu!>!21(c2222222222<foefmtf!cfhjou2`ofyu!>!bee`ufnq\:;1^<foejt`u5`ofyu!>!jt`u5`JO`tu3<foefmtf!jg!)Jo4!>>!u2*!cfhjoPvu2`sfh`ofyu!>!2(c1<Pvu3`sfh`ofyu!>!2(c1<Pvu4`sfh`ofyu!>!2(c1<jt`u5`ofyu!>!jt`u5`JO`tu4<foefoejt`u5`JO`tu4!;cfhjoPvu2`sfh`ofyu!>!2(c1<Pvu3`sfh`ofyu!>!2(c1<Pvu4`sfh`ofyu!>!2(c1<jt`u5`ofyu!>!jt`u5`JO`tu5<foeefgbvmu!;cfhjoPvu2`sfh`ofyu!>!2(c1<Pvu3`sfh`ofyu!>!2(c1<Pvu4`sfh`ofyu!>!2(c1<jt`u5`ofyu!>!jt`u5`JO`tu2<foefoedbtffoebttjho!Pvu2`2!>!Pvu2`sfh`ofyu<bttjho!Pvu3`2!>!Pvu3`sfh`ofyu<bttjho!Pvu4`2!>!Pvu4`sfh`ofyu<bmxbzt!A)qptfehf!dml*cfhjo!;!u7`qspdfttjg!)stuo!>>!2(c1*!cfhjou7`pvu2!=>!2(c1<foefmtf!cfhjou7`pvu2!=>!Pvu3`2<foefoebttjho!Pvu2!>!u7`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u:`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2!=>!2(c1<foefmtf!cfhjou:`pvu2!=>!Pvu4`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u39`qspdfttjg!)stuo!>>!2(c1*!cfhjou39`sfh\1^!=>!2(c1<u39`sfh\2^!=>!2(c1<u39`sfh\3^!=>!2(c1<u39`sfh\4^!=>!2(c1<foefmtf!cfhjou39`sfh\1^!=>!u39`sfh`ofyu\1^<u39`sfh\2^!=>!u39`sfh`ofyu\2^<u39`sfh\3^!=>!u39`sfh`ofyu\3^<u39`sfh\4^!=>!u39`sfh`ofyu\4^<foefoebttjho!u39`pvu2!>!u39`sfh\4^<bttjho!u39`sfh`ofyu\1^!>!u:`pvu2<bttjho!u39`sfh`ofyu\2^!>!u39`sfh\1^<bttjho!u39`sfh`ofyu\3^!>!u39`sfh\2^<bttjho!u39`sfh`ofyu\4^!>!u39`sfh\3^<bttjho!Pvu3!>!u39`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u9`qspdfttjg!)stuo!>>!2(c1*!cfhjou9`pvu2!=>!2(c1<foefmtf!cfhjou9`pvu2!=>!Pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u38`qspdfttjg!)stuo!>>!2(c1*!cfhjou38`pvu2!=>!2(c1<foefmtf!cfhjou38`pvu2!=>!u9`pvu2<foefoebttjho!u21`pvu2!>!Jo3\8;1^<bttjho!u28`pvu2!>!u21`pvu2!>>!9(c11212211<bttjho!u2:`pvu2!>!u38`pvu2!'!u28`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u33`qspdfttjg!)stuo!>>!2(c1*!cfhjou33`pvu2!=>!2(c1<foefmtf!cfhjou33`pvu2!=>!u2:`pvu2<foefoebttjho!Pvu4!>!u33`pvu2<bttjho!u29`pvu2!>!u21`pvu2!>>!9(c11222211<bttjho!u32`pvu2!>!u28`pvu2!}!u29`pvu2<bttjho!u31`pvu2!>!u38`pvu2!'!u32`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u34`qspdfttjg!)stuo!>>!2(c1*!cfhjou34`sfh\1^!=>!2(c1<u34`sfh\2^!=>!2(c1<foefmtf!cfhjou34`sfh\1^!=>!u34`sfh`ofyu\1^<u34`sfh\2^!=>!u34`sfh`ofyu\2^<foefoebttjho!u34`pvu2!>!u34`sfh\2^<bttjho!u34`sfh`ofyu\1^!>!u31`pvu2<bttjho!u34`sfh`ofyu\2^!>!u34`sfh\1^<bmxbzt!A)qptfehf!dml*cfhjo!;!u22`qspdfttjg!)stuo!>>!2(c1*!cfhjou22`pvu2!=>!2(c1<foefmtf!cfhjou22`pvu2!=>!u34`pvu2<foefoebttjho!Pvu5!>!u22`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou25`pvu2!=>!Jo3<foefoebttjho!u24`pvu2!>!u25`pvu2\42;9^<bttjho!u26`pvu2!>!|u21`pvu2-!u24`pvu2~<bttjho!u27`pvu2!>!u26`pvu2\8;1^<bttjho!u35`pvu2!>!u26`pvu2\26;9^<bttjho!u36`pvu2!>!u26`pvu2\34;27^<bttjho!u37`pvu2!>!u26`pvu2\42;35^<bttjho!u23`pvu2!>!|u27`pvu2-!u35`pvu2-!u36`pvu2-!u37`pvu2~<bmxbzt!A)qptfehf!dml*cfhjo!;!u3:`qspdfttjg!)stuo!>>!2(c1*!cfhjou3:`sfh\1^!=>!43(c11111111111111111111111111111111<u3:`sfh\2^!=>!43(c11111111111111111111111111111111<u3:`sfh\3^!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou3:`sfh\1^!=>!u3:`sfh`ofyu\1^<u3:`sfh\2^!=>!u3:`sfh`ofyu\2^<u3:`sfh\3^!=>!u3:`sfh`ofyu\3^<foefoebttjho!u3:`pvu2!>!u3:`sfh\3^<bttjho!u3:`sfh`ofyu\1^!>!u23`pvu2<bttjho!u3:`sfh`ofyu\2^!>!u3:`sfh\1^<bttjho!u3:`sfh`ofyu\3^!>!u3:`sfh\2^<bttjho!Pvu6!>!u3:`pvu2<foenpevmfaujnftdbmf!2!ot!0!2!otnpevmf!unbd`unbd)dml-stuo-Jo2-Jo3-Jo4-Pvu2*<joqvu!!!dml<joqvu!!!stuo<joqvu!!!tjhofe!\6;1^!Jo2<joqvu!!!tjhofe!\9;1^!Jo3<joqvu!!!\8;1^!Jo4<pvuqvu!!tjhofe!\24;1^!Pvu2<xjsf!!\35;1^!nbd`pvu<xjsf!!\22;1^!ejoy<xjsf!!\!9;1^!ejoz<xjsf!!\35;1^!ejo{<bttjho!ejoz!>!|Jo2\6^-Jo2\6^-Jo2\6^-Jo2~<bttjho!ejoy!>!|Jo3\9^-Jo3\9^-Jo3\9^-Jo3~<bttjho!ejo{!>!|24(c1111-!Jo4-!5(c1111~<i7`nbd!v2)/dml!!!!!!!!!!!!)!!!dml!!!!!!!!!*-/ejo{`fo!!!!!!!!)!!!2(c2!!!!!!!!*-/nbd`pvu!!!!!!!!)!!!nbd`pvu!!!!!*-/nbd`pvu`dfo!!!!)!!!2(c2!!!!!!!!*-/nbd`pvu`ts!!!!!)!!!stuo!!!!!!!!*-/ejoy!!!!!!!!!!!)!!!ejoy!!!!!!!!*-/ejoz!!!!!!!!!!!)!!!ejoz!!!!!!!!*-/ejo{!!!!!!!!!!!)!!!ejo{!!!!!!!!**<bttjho!Pvu2!>!nbd`pvu\24;1^<foenpevmfaujnftdbmf!2!ot!0!2!otnpevmf!GsTdm)dml-stuo-Jo2-Jo3-Jo4-Jo5-Pvu2-Pvu4*<qbsbnfufs!jt`u7`JO`tu2!>!4(e1-!jt`u7`JO`tu3!>!4(e2-!jt`u7`JO`tu4!>!4(e3-!jt`u7`JO`tu5!>!4(e4-!jt`u7`JO`tu6!>!4(e5-!jt`u7`JO`tu7!>!4(e6-!jt`u7`JO`tu8!>!4(e7<qbsbnfufs!jt`u9`JO`tu2!>!3(e1-!jt`u9`JO`tu3!>!3(e2-!jt`u9`JO`tu4!>!3(e3<joqvu!!!dml<joqvu!!!stuo<joqvu!!!Jo2<joqvu!!!Jo3<joqvu!!!Jo4<joqvu!!!\42;1^!Jo5<pvuqvu!!\42;1^!Pvu2<pvuqvu!!Pvu4<xjsf!u46`pvu2<xjsf!\8;1^!u42`pvu2<xjsf!\8;1^!u43`pvu2<xjsf!\8;1^!u44`pvu2<xjsf!\8;1^!u45`pvu2<xjsf!\42;1^!u34`pvu2<sfh!\42;1^!u47`pvu2<xjsf!\42;1^!u51`pvu2<sfh!!u22`pvu2<xjsf!u29`pvu2<xjsf!u28`pvu2<xjsf!u2:`pvu2<sfh!!u31`pvu2<xjsf!u49`pvu2<xjsf!u48`pvu2<xjsf!u4:`pvu2<sfh!\2;1^!jt`u9<xjsf!Pvu2`2<xjsf!Pvu3<sfh!!Pvu2`sfh<sfh!!Pvu3`sfh<sfh!\2;1^!jt`u9`ofyu<sfh!!Pvu2`sfh`ofyu<sfh!!Pvu3`sfh`ofyu<sfh!!u33`pvu2<sfh!!u2`pvu2<xjsf!u4`pvu2<sfh!!u23`pvu2<xjsf!u35`pvu2<xjsf!u3`pvu2<xjsf!u8`pvu2<xjsf!u27`pvu2<xjsf!u37`pvu2<sfh!\3;1^!jt`u7<xjsf!Pvu2`3<sfh!!Pvu2`sfh`2<sfh!\3;1^!jt`u7`ofyu<sfh!!Pvu2`sfh`ofyu`2<sfh!!u5`pvu2<xjsf!\8;1^!u39`pvu2<xjsf!\8;1^!u38`pvu2<xjsf!\8;1^!u3:`pvu2<sfh!\8;1^!u6`pvu2<sfh!\42;1^!u25`pvu2<xjsf!\42;1^!u32`pvu2<xjsf!\34;1^!u21`pvu2<xjsf!\8;1^!u24`pvu2<xjsf!\8;1^!u41`pvu2<xjsf!\42;1^!u26`pvu2<sfh!\42;1^!u55`pvu2<sfh!!u:`pvu2<sfh!!u53`pvu2<bttjho!u46`pvu2!>!Jo4<bttjho!u42`pvu2!>!Jo5\8;1^<bttjho!u43`pvu2!>!Jo5\26;9^<bttjho!u44`pvu2!>!Jo5\34;27^<bttjho!u45`pvu2!>!Jo5\42;35^<bttjho!u34`pvu2!>!|u42`pvu2-!u43`pvu2-!u44`pvu2-!u45`pvu2~<bttjho!u51`pvu2!>!)u46`pvu2!>>!2(c1!@!u47`pvu2!;u34`pvu2*<bmxbzt!A)qptfehf!dml*cfhjo!;!u47`qspdfttjg!)stuo!>>!2(c1*!cfhjou47`pvu2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou47`pvu2!=>!u51`pvu2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u22`qspdfttjg!)stuo!>>!2(c1*!cfhjou22`pvu2!=>!2(c1<foefmtf!cfhjou22`pvu2!=>!Jo3<foefoebttjho!u29`pvu2!>!!!u22`pvu2<bttjho!u28`pvu2!>!u29`pvu2!'!Jo3<bttjho!u2:`pvu2!>!u28`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u31`qspdfttjg!)stuo!>>!2(c1*!cfhjou31`pvu2!=>!2(c1<foefmtf!cfhjou31`pvu2!=>!Jo3<foefoebttjho!u49`pvu2!>!!!Jo3<bttjho!u48`pvu2!>!u31`pvu2!'!u49`pvu2<bttjho!u4:`pvu2!>!u48`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u9`qspdfttjg!)stuo!>>!2(c1*!cfhjoPvu2`sfh!=>!2(c1<Pvu3`sfh!=>!2(c1<jt`u9!=>!jt`u9`JO`tu2<foefmtf!cfhjojt`u9!=>!jt`u9`ofyu<Pvu2`sfh!=>!Pvu2`sfh`ofyu<Pvu3`sfh!=>!Pvu3`sfh`ofyu<foefoebmxbzt!A)Pvu2`sfh-!Pvu3`sfh-!jt`u9-!u2:`pvu2-!u46`pvu2-!u4:`pvu2*!cfhjoPvu2`sfh`ofyu!>!Pvu2`sfh<Pvu3`sfh`ofyu!>!Pvu3`sfh<jt`u9`ofyu!>!jt`u9<dbtf!)!jt`u9*jt`u9`JO`tu2!;cfhjojg!)2(c2!>>!u2:`pvu2*!cfhjoPvu3`sfh`ofyu!>!2(c1<jg!)2(c2!>>!u46`pvu2*!cfhjoPvu2`sfh`ofyu!>!2(c2<jt`u9`ofyu!>!jt`u9`JO`tu4<foefmtf!cfhjoPvu2`sfh`ofyu!>!2(c1<jt`u9`ofyu!>!jt`u9`JO`tu3<foefoefmtf!jg!)2(c1!>>!u2:`pvu2*!cfhjoPvu2`sfh`ofyu!>!2(c1<Pvu3`sfh`ofyu!>!2(c1<jt`u9`ofyu!>!jt`u9`JO`tu2<foefoejt`u9`JO`tu3!;cfhjojg!)2(c1!>>!u46`pvu2*!cfhjoPvu2`sfh`ofyu!>!2(c1<Pvu3`sfh`ofyu!>!2(c1<jt`u9`ofyu!>!jt`u9`JO`tu3<foefmtf!jg!)2(c2!>>!u46`pvu2*!cfhjoPvu2`sfh`ofyu!>!2(c2<Pvu3`sfh`ofyu!>!2(c1<jt`u9`ofyu!>!jt`u9`JO`tu4<foefoeefgbvmu!;cfhjojg!)2(c1!>>!u4:`pvu2*!cfhjoPvu2`sfh`ofyu!>!u46`pvu2<Pvu3`sfh`ofyu!>!2(c2<jt`u9`ofyu!>!jt`u9`JO`tu4<foefmtf!jg!)2(c2!>>!u4:`pvu2*!cfhjoPvu2`sfh`ofyu!>!2(c2<Pvu3`sfh`ofyu!>!2(c2<jt`u9`ofyu!>!jt`u9`JO`tu2<foefoefoedbtffoebttjho!Pvu2`2!>!Pvu2`sfh`ofyu<bttjho!Pvu3!>!Pvu3`sfh`ofyu<bmxbzt!A)qptfehf!dml*cfhjo!;!u33`qspdfttjg!)stuo!>>!2(c1*!cfhjou33`pvu2!=>!2(c1<foefmtf!cfhjou33`pvu2!=>!Pvu3<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u2`qspdfttjg!)stuo!>>!2(c1*!cfhjou2`pvu2!=>!2(c1<foefmtf!cfhjou2`pvu2!=>!Jo2<foefoebttjho!u4`pvu2!>!!!u2`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u23`qspdfttjg!)stuo!>>!2(c1*!cfhjou23`pvu2!=>!2(c1<foefmtf!cfhjou23`pvu2!=>!Jo3<foefoebttjho!u35`pvu2!>!!!u23`pvu2<bttjho!u3`pvu2!>!u4`pvu2!'!Jo2<bttjho!u8`pvu2!>!u3`pvu2<bttjho!u27`pvu2!>!u35`pvu2!'!Jo3<bttjho!u37`pvu2!>!u27`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u7`qspdfttjg!)stuo!>>!2(c1*!cfhjoPvu2`sfh`2!=>!2(c1<jt`u7!=>!jt`u7`JO`tu2<foefmtf!cfhjojt`u7!=>!jt`u7`ofyu<Pvu2`sfh`2!=>!Pvu2`sfh`ofyu`2<foefoebmxbzt!A)Pvu2`sfh`2-!jt`u7-!u37`pvu2-!u8`pvu2*!cfhjoPvu2`sfh`ofyu`2!>!Pvu2`sfh`2<jt`u7`ofyu!>!jt`u7<dbtf!)!jt`u7*jt`u7`JO`tu2!;cfhjojg!)2(c2!>>!u8`pvu2*!cfhjoPvu2`sfh`ofyu`2!>!2(c2<jt`u7`ofyu!>!jt`u7`JO`tu3<foefmtf!jg!)2(c2!>>!u37`pvu2*!cfhjoPvu2`sfh`ofyu`2!>!2(c1<jt`u7`ofyu!>!jt`u7`JO`tu6<foefoejt`u7`JO`tu3!;cfhjojg!)2(c2!>>!u37`pvu2*!cfhjoPvu2`sfh`ofyu`2!>!2(c2<jt`u7`ofyu!>!jt`u7`JO`tu4<foefoejt`u7`JO`tu4!;cfhjoPvu2`sfh`ofyu`2!>!2(c2<jt`u7`ofyu!>!jt`u7`JO`tu5<foejt`u7`JO`tu5!;cfhjoPvu2`sfh`ofyu`2!>!2(c2<jt`u7`ofyu!>!jt`u7`JO`tu2<foejt`u7`JO`tu6!;cfhjoPvu2`sfh`ofyu`2!>!2(c1<jt`u7`ofyu!>!jt`u7`JO`tu8<foejt`u7`JO`tu7!;cfhjoPvu2`sfh`ofyu`2!>!2(c1<jt`u7`ofyu!>!jt`u7`JO`tu2<foeefgbvmu!;cfhjoPvu2`sfh`ofyu`2!>!2(c1<jt`u7`ofyu!>!jt`u7`JO`tu7<foefoedbtffoebttjho!Pvu2`3!>!Pvu2`sfh`ofyu`2<bmxbzt!A)qptfehf!dml*cfhjo!;!u5`qspdfttjg!)stuo!>>!2(c1*!cfhjou5`pvu2!=>!2(c1<foefmtf!cfhjou5`pvu2!=>!Pvu2`3<foefoebttjho!u39`pvu2!>!9(c11222211<bttjho!u38`pvu2!>!9(c11212211<bttjho!u3:`pvu2!>!)u5`pvu2!>>!2(c1!@!u39`pvu2!;u38`pvu2*<bmxbzt!A)qptfehf!dml*cfhjo!;!u6`qspdfttjg!)stuo!>>!2(c1*!cfhjou6`pvu2!=>!9(c11111111<foefmtf!cfhjou6`pvu2!=>!u3:`pvu2<foefoebttjho!u32`pvu2!>!)u46`pvu2!>>!2(c1!@!u25`pvu2!;u47`pvu2*<bmxbzt!A)qptfehf!dml*cfhjo!;!u25`qspdfttjg!)stuo!>>!2(c1*!cfhjou25`pvu2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou25`pvu2!=>!u32`pvu2<foefoebttjho!u21`pvu2!>!u47`pvu2\34;1^<bttjho!u24`pvu2!>!u25`pvu2\42;35^<bttjho!u41`pvu2!>!)u33`pvu2!>>!2(c1!@!u6`pvu2!;u24`pvu2*<bttjho!u26`pvu2!>!|u21`pvu2-!u41`pvu2~<bmxbzt!A)qptfehf!dml*cfhjo!;!u55`qspdfttjg!)stuo!>>!2(c1*!cfhjou55`pvu2!=>!43(c11111111111111111111111111111111<foefmtf!cfhjou55`pvu2!=>!u26`pvu2<foefoebttjho!Pvu2!>!u55`pvu2<bmxbzt!A)qptfehf!dml*cfhjo!;!u:`qspdfttjg!)stuo!>>!2(c1*!cfhjou:`pvu2!=>!2(c1<foefmtf!cfhjou:`pvu2!=>!Pvu2`2<foefoebmxbzt!A)qptfehf!dml*cfhjo!;!u53`qspdfttjg!)stuo!>>!2(c1*!cfhjou53`pvu2!=>!2(c1<foefmtf!cfhjou53`pvu2!=>!u:`pvu2<foefoebttjho!Pvu4!>!u53`pvu2<foenpevmf
`pragma protect end_protected


















`timescale 1 ns / 1 ns

module SimpleDualPortRAM_generic
(clk,
wr_din,
wr_addr,
wr_en,
rd_addr,
rd_dout);

parameter AddrWidth = 1;
parameter DataWidth = 1;

input   clk;
input   [DataWidth - 1:0] wr_din;
input   [AddrWidth - 1:0] wr_addr;
input   wr_en;
input   [AddrWidth - 1:0] rd_addr;
output  [DataWidth - 1:0] rd_dout;


sdpram u1
(
.clkr  (  clk       ),
.clkw  (  clk       ),
.cer   (  enb       ),
.cew   (  enb       ),
.rstnr (  1'b1      ),
.ar    (  rd_addr   ),
.aw    (  wr_addr   ),
.dw    (  wr_din    ),
.qr    (  rd_dout   )
);


endmodule



















`timescale 1 ns / 1 ns

module MAC_block
(clk,
rstn,
In1,
In2,
In3,
Out1);


input   clk;
input   rstn;
input   signed [5:0] In1;
input   signed [8:0] In2;
input   [7:0] In3;
output  signed [13:0] Out1;


wire  [24:0] mac_out;
wire  [11:0] dinx;
wire  [ 8:0] diny;
wire  [24:0] dinz;
assign diny = {In1[5],In1[5],In1[5],In1};
assign dinx = {In2[8],In2[8],In2[8],In2};
assign dinz = {13'b0000, In3, 4'b0000};
h6_mac u1(
.clk            (   clk         ),
.dinz_en        (   1'b1        ),
.mac_out        (   mac_out     ),
.mac_out_cen    (   1'b1        ),
.mac_out_sr     (   rstn        ),
.dinx           (   dinx        ),
.diny           (   diny        ),
.dinz           (   dinz        )
);
assign Out1 = mac_out[13:0];

endmodule
