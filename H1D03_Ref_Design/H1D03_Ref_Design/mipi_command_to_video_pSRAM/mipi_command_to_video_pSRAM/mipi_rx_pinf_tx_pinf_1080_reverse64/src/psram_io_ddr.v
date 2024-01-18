`timescale 1ns/1ps
//`define USE_2CLK ;
module psram_io_ddr(
input                        clk       ,
input                        clk_ddr     ,
input                        clk_90     ,

input                        cs_n_o    ,
input                        cs_n_e    ,
input[1:0]                        ck_o      ,
input[1:0]                          ck_n_o    ,
input                        ck_en   ,
output[1:0]                   rwds_i    ,
input[1:0]                        rwds_o  ,
input                        rwds_e    ,
output[15:0]                 dq_rd     ,
input[15:0]                  dq_wr	   ,
input[7:0]                        dq_e      ,

output                        CK        ,
output                        CK_N      ,
output                        CS_N      ,
inout                        RWDS      ,
inout[7:0]                  DQ		        
);





// ddrio U_clk(
    // .clk        (clk        ) ,
    // .clk_en     (1'b1           ) ,
    // .od         (ck_o           ) ,
    // .id         (               ) ,
    // .oen        (1'b1           ) ,
    // .pad        (CK             ) 
// );


// ddrio U_clk_n(
    // .clk        (clk        ) ,
    // .clk_en     (1'b1           ) ,
    // .od         (ck_n_o         ) ,
    // .id         (               ) ,
    // .oen        (1'b1           ) ,
    // .pad        (CK_N           ) 
// );


ddrio_v1 U_ck(
    .clk(clk_90)    ,
    .clk_en(1'b1)   ,
    .odp(ck_o[1])      ,
    .odn(ck_o[0])      ,
    .idp()      ,
    .idn()      ,
    .oen(1'b1)      ,
    .pad(CK)      
);

ddrio_v1 U_ckn(
    .clk(clk_90)    ,
    .clk_en(1'b1)   ,
    .odp(ck_n_o[1])      ,
    .odn(ck_n_o[0])      ,
    .idp()      ,
    .idn()      ,
    .oen(1'b1)      ,
    .pad(CK_N)      
);


ddrio_v1 U_rwds(
    .clk(clk_ddr)    ,
    .clk_en(1'b1)   ,
    .odp(rwds_o[1])      ,
    .odn(rwds_o[0])      ,
    .idp(rwds_i[1])      ,
    .idn(rwds_i[0])      ,
    .oen(rwds_e)      ,
    .pad(RWDS)      
);

// ddrio_v1 U_dq(
    // .clk(clk_ddr)    ,
    // .clk_en(1'b1)   ,
    // .odp(dq_wr[8])      ,
    // .odn(dq_wr[1])      ,
    // .idp(dq_rd[8])      ,
    // .idn(dq_rd[1])      ,
    // .oen(~dq_e)      ,
    // .pad(RWDS)      
// ); 

ddrio_v1 U_cs_n (
    .clk(clk_ddr)    ,
    .clk_en(1'b1)   ,
    .odp(cs_n_o)      ,
    .odn(cs_n_o)      ,
    .idp()      ,
    .idn()      ,
    .oen(cs_n_e)      ,
    .pad(CS_N)      
);

genvar i;

generate
for(i=0;i<8;i=i+1)
begin: mipi_io

ddrio_v1 U_dq(
    .clk(clk_ddr)    ,
    .clk_en(1'b1)   ,
    .odp(dq_wr[i+8])      ,
    .odn(dq_wr[i])      ,
    .idp(dq_rd[i+8])      ,
    .idn(dq_rd[i])      ,
    .oen(dq_e[i])      ,
    .pad(DQ[i])      
);
end
endgenerate


endmodule
