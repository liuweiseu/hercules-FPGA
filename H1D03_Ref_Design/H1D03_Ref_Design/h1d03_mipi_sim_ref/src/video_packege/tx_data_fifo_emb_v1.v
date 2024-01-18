module tx_data_fifo_emb_v1 (clkr, clkw, cer, cew, rstnr, ar, aw, dw, qr);
input clkr;
input clkw;
input cer;
input cew;
input rstnr;
input [9:0] ar;
input [9:0] aw;
input [31:0] dw;
output [31:0] qr;

wire vcc_net;
wire gnd_net;
wire net_57;
wire net_58;
wire nc193;
wire nc194;
wire nc195;
wire nc196;
wire nc197;
wire nc198;
wire nc199;
wire nc200;
wire nc201;
wire nc202;
wire nc203;
wire nc204;
wire nc205;
wire nc206;
wire nc207;
wire nc208;
wire nc209;
wire nc210;
wire nc211;
wire nc212;
wire nc213;
wire nc214;
wire nc215;
wire nc216;
wire nc217;
wire nc218;
wire nc219;
wire nc220;
wire nc221;
wire nc222;
wire nc223;
wire nc224;
wire nc225;
wire nc226;
wire nc227;
wire nc228;
wire nc229;
wire nc230;
wire nc231;
wire nc232;
wire nc233;
wire nc234;
wire nc235;
wire nc236;
wire nc237;
wire nc238;
wire nc239;
wire nc240;
wire nc241;
wire nc242;
wire nc243;
wire nc244;
wire nc245;
wire nc246;
wire nc247;
wire nc248;
wire nc249;
wire nc250;
wire nc251;
wire nc252;
wire nc253;
wire nc254;
wire nc255;
wire nc256;
wire nc257;
wire nc258;
wire nc259;
wire nc260;
wire nc261;
wire nc262;
wire nc263;
wire nc264;
wire nc265;
wire nc266;
wire nc267;
wire nc268;
wire nc269;
wire nc270;
wire nc271;
wire nc272;
wire nc273;
wire nc274;
wire nc275;
wire nc276;
wire nc277;
wire nc278;
wire nc279;
wire nc280;
wire nc281;
wire nc282;
wire nc283;
wire nc284;
wire nc285;
wire nc286;
wire nc287;
wire nc288;
wire nc289;
wire nc290;
wire nc291;
wire nc292;
wire nc293;
wire nc294;
wire nc295;
wire nc296;
wire nc297;
wire nc298;
wire nc299;
wire nc300;
wire nc301;
wire nc302;
wire nc303;
wire nc304;
wire nc305;
wire nc306;
wire nc307;
wire nc308;
wire nc309;
wire nc310;
wire nc311;
wire nc312;
wire nc313;
wire nc314;
wire nc315;
wire nc316;
wire nc317;
wire nc318;
wire nc319;
wire nc320;
wire nc321;
wire nc322;
wire nc323;
wire nc324;
wire nc325;
wire nc326;
wire nc327;
wire nc328;
wire nc329;
wire nc330;
wire nc331;
wire nc332;
wire nc333;
wire nc334;
wire nc335;
wire nc336;
wire nc337;
wire nc338;
wire nc339;
wire nc340;
wire nc341;
wire nc342;
wire nc343;
wire nc344;
wire nc345;
wire nc346;
wire nc347;
wire nc348;
wire nc349;
wire nc350;
wire nc351;
wire nc352;
wire nc353;
wire nc354;
wire nc355;
wire nc356;
wire nc357;
wire nc358;
wire nc359;
wire nc360;
wire nc361;
wire nc362;
wire nc363;
wire nc364;
wire nc365;
wire nc366;
wire nc367;
wire nc368;
wire nc369;
wire nc370;
wire nc371;
wire nc372;
wire nc373;
wire nc374;
wire nc375;
wire nc376;
wire nc377;
wire nc378;
wire nc379;
wire nc380;
wire nc381;
wire nc382;
wire nc383;
wire nc384;

assign vcc_net = 1;
assign gnd_net = 0;
EMB18K #(
		.clka_inv (1'b0),
		.clkb_inv (1'b0),
		.eccreaden (1'b0),
		.eccwriteen (1'b0),
//		.emb5k_1_init_file (""),
//		.emb5k_2_init_file (""),
//		.emb5k_3_init_file (""),
//		.emb5k_4_init_file (""),
		.extension_mode ("power"),
		.init_file ("none"),
		.outreg_a (1'b0),
		.outreg_b (1'b0),
		.rammode ("sdp"),
		.use_parity (1'b0),
		.width_a (18),
		.width_b (18),
		.writemode_a ("write_first"),
		.writemode_b ("write_first")
	)
	emb_0 (
		.doa ({nc193, nc194, nc195, nc196, nc197, nc198, nc199, nc200, nc201, nc202, nc203, nc204, nc205, nc206, nc207, nc208, nc209, nc210, nc211, nc212, nc213, nc214, nc215, nc216, nc217, nc218, nc219, nc220, nc221, nc222, nc223, nc224, nc225, nc226, nc227, nc228, nc229, nc230, nc231, nc232, nc233, nc234, nc235, nc236, nc237, nc238, nc239, nc240, qr[15], qr[14], qr[13], qr[12], qr[11], qr[10], qr[9], qr[8], qr[7], qr[6], qr[5], qr[4], qr[3], qr[2], qr[1], qr[0]}),
		.dob (),
		.dopa (),
		.dopb (),
		.addra ({gnd_net, gnd_net, gnd_net, gnd_net, ar[9], ar[8], ar[7], ar[6], ar[5], ar[4], ar[3], ar[2], ar[1], ar[0]}),
		.addrb ({gnd_net, gnd_net, gnd_net, gnd_net, aw[9], aw[8], aw[7], aw[6], aw[5], aw[4], aw[3], aw[2], aw[1], aw[0]}),
		.clka (clkr),
		.clkb (clkw),
		.dia (),
		.dib ({nc241, nc242, nc243, nc244, nc245, nc246, nc247, nc248, nc249, nc250, nc251, nc252, nc253, nc254, nc255, nc256, nc257, nc258, nc259, nc260, nc261, nc262, nc263, nc264, nc265, nc266, nc267, nc268, nc269, nc270, nc271, nc272, nc273, nc274, nc275, nc276, nc277, nc278, nc279, nc280, nc281, nc282, nc283, nc284, nc285, nc286, nc287, nc288, dw[15], dw[14], dw[13], dw[12], dw[11], dw[10], dw[9], dw[8], dw[7], dw[6], dw[5], dw[4], dw[3], dw[2], dw[1], dw[0]}),
		.dipa (),
		.dipb (),
		.cea (cer),
		.ceb (cew),
		.regcea (vcc_net),
		.regceb (),
		.regsra (rstnr),
		.regsrb (),
		.wea ({gnd_net, gnd_net, gnd_net, gnd_net}),
		.web ({vcc_net, vcc_net, vcc_net, vcc_net}),
		.eccoutdberr (),
		.eccoutsberr (),
		.eccreadaddr (),
		.eccindberr (gnd_net),
		.eccinsberr (gnd_net)
	);
EMB18K #(
		.clka_inv (1'b0),
		.clkb_inv (1'b0),
		.eccreaden (1'b0),
		.eccwriteen (1'b0),
//		.emb5k_1_init_file (""),
//		.emb5k_2_init_file (""),
//		.emb5k_3_init_file (""),
//		.emb5k_4_init_file (""),
		.extension_mode ("power"),
		.init_file ("none"),
		.outreg_a (1'b0),
		.outreg_b (1'b0),
		.rammode ("sdp"),
		.use_parity (1'b0),
		.width_a (18),
		.width_b (18),
		.writemode_a ("write_first"),
		.writemode_b ("write_first")
	)
	emb_4 (
		.doa ({nc289, nc290, nc291, nc292, nc293, nc294, nc295, nc296, nc297, nc298, nc299, nc300, nc301, nc302, nc303, nc304, nc305, nc306, nc307, nc308, nc309, nc310, nc311, nc312, nc313, nc314, nc315, nc316, nc317, nc318, nc319, nc320, nc321, nc322, nc323, nc324, nc325, nc326, nc327, nc328, nc329, nc330, nc331, nc332, nc333, nc334, nc335, nc336, qr[31], qr[30], qr[29], qr[28], qr[27], qr[26], qr[25], qr[24], qr[23], qr[22], qr[21], qr[20], qr[19], qr[18], qr[17], qr[16]}),
		.dob (),
		.dopa (),
		.dopb (),
		.addra ({gnd_net, gnd_net, gnd_net, gnd_net, ar[9], ar[8], ar[7], ar[6], ar[5], ar[4], ar[3], ar[2], ar[1], ar[0]}),
		.addrb ({gnd_net, gnd_net, gnd_net, gnd_net, aw[9], aw[8], aw[7], aw[6], aw[5], aw[4], aw[3], aw[2], aw[1], aw[0]}),
		.clka (clkr),
		.clkb (clkw),
		.dia (),
		.dib ({nc337, nc338, nc339, nc340, nc341, nc342, nc343, nc344, nc345, nc346, nc347, nc348, nc349, nc350, nc351, nc352, nc353, nc354, nc355, nc356, nc357, nc358, nc359, nc360, nc361, nc362, nc363, nc364, nc365, nc366, nc367, nc368, nc369, nc370, nc371, nc372, nc373, nc374, nc375, nc376, nc377, nc378, nc379, nc380, nc381, nc382, nc383, nc384, dw[31], dw[30], dw[29], dw[28], dw[27], dw[26], dw[25], dw[24], dw[23], dw[22], dw[21], dw[20], dw[19], dw[18], dw[17], dw[16]}),
		.dipa (),
		.dipb (),
		.cea (cer),
		.ceb (cew),
		.regcea (vcc_net),
		.regceb (),
		.regsra (rstnr),
		.regsrb (),
		.wea ({gnd_net, gnd_net, gnd_net, gnd_net}),
		.web ({vcc_net, vcc_net, vcc_net, vcc_net}),
		.eccoutdberr (),
		.eccoutsberr (),
		.eccreadaddr (),
		.eccindberr (gnd_net),
		.eccinsberr (gnd_net)
	);

endmodule