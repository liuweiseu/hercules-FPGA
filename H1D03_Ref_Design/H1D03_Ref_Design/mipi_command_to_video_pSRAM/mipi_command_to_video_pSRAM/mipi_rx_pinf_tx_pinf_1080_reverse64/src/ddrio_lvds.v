//

//
// ============================================================
// File Name: ddrio_lvds.v

// ============================================================

module ddrio_lvds(
    clk,
    clk_en,
    setn,
    rstn,
	
	idp0,
	idn0,
	oen0,
    odp0,
    odn0,
    pad0,
	
	idp1,
	idn1,
	oen1,
    odp1,
    odn1,
    pad1
);

parameter gpio_type = 0;		// 0 gpio, 1 lvds gpio
input clk;
input clk_en;
input setn;
input rstn;
output idp0;
output idn0;
input oen0;
input odp0;
input odn0;
inout pad0;
output idp1;
output idn1;
input oen1;
input odp1;
input odn1;
inout pad1;

wire rxd_data_p;
wire rxd_data_n;
wire txd_out_p;
wire txd_out_n;
wire ted_d_p;
wire ted_d_n;
wire update_clk;
wire update_b_clk;
wire geclk_up_clk;
wire update_d0;
wire update_b_d0;
wire geclk_up_d0;
wire [15:0] q0_data;
wire	geclk,gsclk;

assign idp0 = q0_data[0]; //posedge
assign idn0 = q0_data[1]; //negedge

assign idp1 = q0_data[8];
assign idn1 = q0_data[9];

assign geclk = clk;
assign gsclk = clk;
/*
UPDATE #( .CFG_UP_SEL (7'b0000001) ) u_data_d (
        .update (update_d0),
        .update_ (update_b_d0),
        .align_user (alignwd),
        .geclk0 (geclk_up_d0)
);
IOBUF ib_geclk(
        .i(clk),
        .o(geclk)
);
DIV  #(.DIV(4'b0000)) div_gsclk(
        .CKIN(clk),
        .CKOUT(gsclk),
        .CLR(~rstn)
);
*/
IOC_LVDS_v2 #(
        .CFG_CK_INV (1'b0),
        .CFG_CK_PAD_EN (1'b1),
        .CFG_DDR_IN_NREG (1'b1),
        .CFG_DDR_IN_NREG_DFF (1'b0),
        .CFG_DDR_IN_PREG (1'b1),
        .CFG_DDR_IN_PREG_DFF (1'b0),
        .CFG_DDR_OUT (1'b1),
        .CFG_DDR_OUT_REG (1'b0),
        .CFG_DQS_CLK (1'b0),
        .CFG_ECLK_INV (1'b0),
        .CFG_FASTIN (1'b0),
        .CFG_FCLK0_I_EN (1'b1),
        .CFG_FCLK0_OEN (1'b1),
        .CFG_FCLK0_O_EN (1'b1),
        .CFG_FCLK0_RS_EN (1'b0),
        .CFG_FCLK0_UPI_EN (1'b0),
        .CFG_FCLK0_UPO_EN (1'b0),
        .CFG_FCLK1_I_EN (1'b1),
        .CFG_FCLK1_O_EN (1'b1),
        .CFG_FCLK_INV (1'b1),
        .CFG_FOUT_SEL (1'b0),
        .CFG_GEAR_IN (8'h0),
        .CFG_GEAR_OUT (1'b0),
        .CFG_GECLK0_I_EN (1'b1),
        .CFG_GECLK0_O_EN (1'b1),
        .CFG_GECLK1_I_EN (1'b1),
        .CFG_GECLK1_O_EN (1'b1),
        .CFG_GSCLK0_I_EN (1'b1),
        .CFG_GSCLK0_O_EN (1'b1),
        .CFG_GSCLK1_I_EN (1'b1),
        .CFG_GSCLK1_O_EN (1'b1),
        .CFG_IN_EN (2'b11),
        .CFG_OEN_INV (1'b0),
        .CFG_OEN_SEL (4'b0010),
        .CFG_OFDBK (1'b0),
        .CFG_OUT_SEL (3'b100),
        .CFG_RSTN (5'b00000),
        .CFG_SCLK_INV (1'b0),
        .CFG_SETN (5'b00000),
        .CFG_SLAVE_IN (1'b0),
        .CFG_TEST (8'b00000000)
)
u0_data_p (
        .geclk0_up_ol (),
        .rxd_dr (),
        .txd_out (txd_out_p),
        .ted_out (ted_d_p),
        .geclk0_up_il (geclk_up_d0),
        .shiftout0_il (shiftout0_il_0_d0),
        .shiftout0_ol (),
        .shiftout1_il (shiftout1_il_0_d0),
        .shiftout1_ol (),
        .q (q0_data[7:0]),
        .oen (oen0),
        .rxd_in (rxd_data_p),
        .shiftin0_il (shiftin0_il_0_d0),
        .shiftin0_ol (),
        .shiftin1_il (shiftin1_il_0_d0),
        .shiftin1_ol (),
        .update_il (),
        .update_b_il (),
        .update_ol (),
        .update_b_ol (),
        .clken (clk_en),
        .rstn (rstn),
        .setn (setn),
        .feclk (geclk ),
        .sclk (gsclk),
        .test (),
        .d ({odp0,odn0})
);
IOC_LVDS_v2 #(
        .CFG_CK_INV (1'b0),
        .CFG_CK_PAD_EN (1'b1),
        .CFG_DDR_IN_NREG (1'b1),
        .CFG_DDR_IN_NREG_DFF (1'b0),
        .CFG_DDR_IN_PREG (1'b1),
        .CFG_DDR_IN_PREG_DFF (1'b0),
        .CFG_DDR_OUT (1'b1),
        .CFG_DDR_OUT_REG (1'b0),
        .CFG_DQS_CLK (1'b0),
        .CFG_ECLK_INV (1'b0),
        .CFG_FASTIN (1'b0),
        .CFG_FCLK0_I_EN (1'b1),
        .CFG_FCLK0_OEN (1'b1),
        .CFG_FCLK0_O_EN (1'b1),
        .CFG_FCLK0_RS_EN (1'b0),
        .CFG_FCLK0_UPI_EN (1'b0),
        .CFG_FCLK0_UPO_EN (1'b0),
        .CFG_FCLK1_I_EN (1'b1),
        .CFG_FCLK1_O_EN (1'b1),
        .CFG_FCLK_INV (1'b1),
        .CFG_FOUT_SEL (1'b0),
        .CFG_GEAR_IN (8'b00000000),
        .CFG_GEAR_OUT (1'b0),
        .CFG_GECLK0_I_EN (1'b1),
        .CFG_GECLK0_O_EN (1'b1),
        .CFG_GECLK1_I_EN (1'b1),
        .CFG_GECLK1_O_EN (1'b1),
        .CFG_GSCLK0_I_EN (1'b1),
        .CFG_GSCLK0_O_EN (1'b1),
        .CFG_GSCLK1_I_EN (1'b1),
        .CFG_GSCLK1_O_EN (1'b1),
        .CFG_IN_EN (2'b11),
        .CFG_OEN_INV (1'b0),
        .CFG_OEN_SEL (4'b0010),
        .CFG_OFDBK (1'b0),
        .CFG_OUT_SEL (3'b100),
        .CFG_RSTN (5'b00000),
        .CFG_SCLK_INV (1'b0),
        .CFG_SETN (5'b00000),
        .CFG_SLAVE_IN (1'b0),
        .CFG_TEST (8'b00000000)
)
u0_data_n (
        .geclk0_up_ol (),
        .rxd_dr (),
        .txd_out (txd_out_n),
        .ted_out (ted_d_n),
        .geclk0_up_il (),
        .shiftout0_il (shiftout0_il_1_d0),
        .shiftout0_ol (),
        .shiftout1_il (shiftout1_il_1_d0),
        .shiftout1_ol (),
        .q (q0_data[15:8]),
        .oen (oen1),
        .rxd_in (rxd_data_n),
        .shiftin0_il (shiftin0_il_1_d0),
        .shiftin0_ol (),
        .shiftin1_il (shiftin1_il_1_d0),
        .shiftin1_ol (),
        .update_il (),
        .update_b_il (),
        .update_ol (),
        .update_b_ol (),
        .clken (clk_en),
        .rstn (rstn),
        .setn (setn),
        .feclk (geclk ),
        .sclk (gsclk),
        .test (),
        .d ({odp1,odn1})
);
CVLVDS #(
        .CMFB_TX_EN (1'b0),
        .CML_TX_EN (1'b0),
        .CFG_IDEL_0 (6'b000000),
        .CFG_IDEL_1 (6'b000000),
        .CFG_IDEL_EN_0 (1'b0),
        .CFG_IDEL_EN_1 (1'b0),
        .CFG_ODEL_0 (6'b000000),
        .CFG_ODEL_1 (6'b000000),
        .CFG_ODEL_EN_0 (1'b0),
        .CFG_ODEL_EN_1 (1'b0),
        .CFG_DYN_IDEL_EN_0 (1'b0),
        .CFG_DYN_IDEL_EN_1 (1'b0),
        .CFG_DYN_ODEL_EN_0 (1'b0),
        .CFG_DYN_ODEL_EN_1 (1'b0),
        .KEEP_0 (2'b00),
        .KEEP_1 (2'b00),
        .LDR (3'b000),
        .LVDS_TX_EN (1'b0),
        .NDR_0 (4'b1111),
        .NDR_1 (4'b1111),
        .NS_LV_0 (2'b11),
        .NS_LV_1 (2'b11),
        .PDR_0 (4'b1111),
        .PDR_1 (4'b1111),
        .RX_DIG_EN_0 (1'b1),
        .RX_DIG_EN_1 (1'b1),
        .RX_LVDS_EN (1'b0),
        .TD (4'b0010),
        .TERM_DIFF_EN (1'b0),
        .TD_FP_EN (1'b0),
        .VPCI_EN_0 (1'b0),
        .VPCI_EN_1 (1'b0),
        .LVPECL_TX_EN (1'b0),
        .TERM_CML_EN (1'b0)
)
u_d0_agio (
        .PAD0 (pad0),
        .PAD1 (pad1),
        .TXD0 (txd_out_p),
        .TXD1 (txd_out_n),
        .TED0 (ted_d_p),
        .TED1 (ted_d_n),
        .RXD0 (rxd_data_p),
        .RXD1 (rxd_data_n)
);

endmodule