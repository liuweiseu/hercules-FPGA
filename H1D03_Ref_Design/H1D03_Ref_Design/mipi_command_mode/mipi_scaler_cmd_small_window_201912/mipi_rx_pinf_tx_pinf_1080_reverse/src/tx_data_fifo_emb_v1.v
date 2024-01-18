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
wire nc769;
wire nc770;
wire nc771;
wire nc772;
wire nc773;
wire nc774;
wire nc775;
wire nc776;
wire nc777;
wire nc778;
wire nc779;
wire nc780;
wire nc781;
wire nc782;
wire nc783;
wire nc784;
wire nc785;
wire nc786;
wire nc787;
wire nc788;
wire nc789;
wire nc790;
wire nc791;
wire nc792;
wire nc793;
wire nc794;
wire nc795;
wire nc796;
wire nc797;
wire nc798;
wire nc799;
wire nc800;
wire nc801;
wire nc802;
wire nc803;
wire nc804;
wire nc805;
wire nc806;
wire nc807;
wire nc808;
wire nc809;
wire nc810;
wire nc811;
wire nc812;
wire nc813;
wire nc814;
wire nc815;
wire nc816;
wire nc817;
wire nc818;
wire nc819;
wire nc820;
wire nc821;
wire nc822;
wire nc823;
wire nc824;
wire nc825;
wire nc826;
wire nc827;
wire nc828;
wire nc829;
wire nc830;
wire nc831;
wire nc832;
wire nc833;
wire nc834;
wire nc835;
wire nc836;
wire nc837;
wire nc838;
wire nc839;
wire nc840;
wire nc841;
wire nc842;
wire nc843;
wire nc844;
wire nc845;
wire nc846;
wire nc847;
wire nc848;
wire nc849;
wire nc850;
wire nc851;
wire nc852;
wire nc853;
wire nc854;
wire nc855;
wire nc856;
wire nc857;
wire nc858;
wire nc859;
wire nc860;
wire nc861;
wire nc862;
wire nc863;
wire nc864;
wire nc865;
wire nc866;
wire nc867;
wire nc868;
wire nc869;
wire nc870;
wire nc871;
wire nc872;
wire nc873;
wire nc874;
wire nc875;
wire nc876;
wire nc877;
wire nc878;
wire nc879;
wire nc880;
wire nc881;
wire nc882;
wire nc883;
wire nc884;
wire nc885;
wire nc886;
wire nc887;
wire nc888;
wire nc889;
wire nc890;
wire nc891;
wire nc892;
wire nc893;
wire nc894;
wire nc895;
wire nc896;
wire nc897;
wire nc898;
wire nc899;
wire nc900;
wire nc901;
wire nc902;
wire nc903;
wire nc904;
wire nc905;
wire nc906;
wire nc907;
wire nc908;
wire nc909;
wire nc910;
wire nc911;
wire nc912;
wire nc913;
wire nc914;
wire nc915;
wire nc916;
wire nc917;
wire nc918;
wire nc919;
wire nc920;
wire nc921;
wire nc922;
wire nc923;
wire nc924;
wire nc925;
wire nc926;
wire nc927;
wire nc928;
wire nc929;
wire nc930;
wire nc931;
wire nc932;
wire nc933;
wire nc934;
wire nc935;
wire nc936;
wire nc937;
wire nc938;
wire nc939;
wire nc940;
wire nc941;
wire nc942;
wire nc943;
wire nc944;
wire nc945;
wire nc946;
wire nc947;
wire nc948;
wire nc949;
wire nc950;
wire nc951;
wire nc952;
wire nc953;
wire nc954;
wire nc955;
wire nc956;
wire nc957;
wire nc958;
wire nc959;
wire nc960;

assign vcc_net = 1;
assign gnd_net = 0;
EMB18K #(
		.clka_inv (1'b0),
		.clkb_inv (1'b0),
		.eccreaden (1'b0),
		.eccwriteen (1'b0),
		.emb5k_1_init_file (""),
		.emb5k_2_init_file (""),
		.emb5k_3_init_file (""),
		.emb5k_4_init_file (""),
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
		.doa ({nc769, nc770, nc771, nc772, nc773, nc774, nc775, nc776, nc777, nc778, nc779, nc780, nc781, nc782, nc783, nc784, nc785, nc786, nc787, nc788, nc789, nc790, nc791, nc792, nc793, nc794, nc795, nc796, nc797, nc798, nc799, nc800, nc801, nc802, nc803, nc804, nc805, nc806, nc807, nc808, nc809, nc810, nc811, nc812, nc813, nc814, nc815, nc816, qr[15], qr[14], qr[13], qr[12], qr[11], qr[10], qr[9], qr[8], qr[7], qr[6], qr[5], qr[4], qr[3], qr[2], qr[1], qr[0]}),
		.dob (),
		.dopa (),
		.dopb (),
		.addra ({gnd_net, gnd_net, gnd_net, gnd_net, ar[9], ar[8], ar[7], ar[6], ar[5], ar[4], ar[3], ar[2], ar[1], ar[0]}),
		.addrb ({gnd_net, gnd_net, gnd_net, gnd_net, aw[9], aw[8], aw[7], aw[6], aw[5], aw[4], aw[3], aw[2], aw[1], aw[0]}),
		.clka (clkr),
		.clkb (clkw),
		.dia (),
		.dib ({nc817, nc818, nc819, nc820, nc821, nc822, nc823, nc824, nc825, nc826, nc827, nc828, nc829, nc830, nc831, nc832, nc833, nc834, nc835, nc836, nc837, nc838, nc839, nc840, nc841, nc842, nc843, nc844, nc845, nc846, nc847, nc848, nc849, nc850, nc851, nc852, nc853, nc854, nc855, nc856, nc857, nc858, nc859, nc860, nc861, nc862, nc863, nc864, dw[15], dw[14], dw[13], dw[12], dw[11], dw[10], dw[9], dw[8], dw[7], dw[6], dw[5], dw[4], dw[3], dw[2], dw[1], dw[0]}),
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
		.emb5k_1_init_file (""),
		.emb5k_2_init_file (""),
		.emb5k_3_init_file (""),
		.emb5k_4_init_file (""),
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
		.doa ({nc865, nc866, nc867, nc868, nc869, nc870, nc871, nc872, nc873, nc874, nc875, nc876, nc877, nc878, nc879, nc880, nc881, nc882, nc883, nc884, nc885, nc886, nc887, nc888, nc889, nc890, nc891, nc892, nc893, nc894, nc895, nc896, nc897, nc898, nc899, nc900, nc901, nc902, nc903, nc904, nc905, nc906, nc907, nc908, nc909, nc910, nc911, nc912, qr[31], qr[30], qr[29], qr[28], qr[27], qr[26], qr[25], qr[24], qr[23], qr[22], qr[21], qr[20], qr[19], qr[18], qr[17], qr[16]}),
		.dob (),
		.dopa (),
		.dopb (),
		.addra ({gnd_net, gnd_net, gnd_net, gnd_net, ar[9], ar[8], ar[7], ar[6], ar[5], ar[4], ar[3], ar[2], ar[1], ar[0]}),
		.addrb ({gnd_net, gnd_net, gnd_net, gnd_net, aw[9], aw[8], aw[7], aw[6], aw[5], aw[4], aw[3], aw[2], aw[1], aw[0]}),
		.clka (clkr),
		.clkb (clkw),
		.dia (),
		.dib ({nc913, nc914, nc915, nc916, nc917, nc918, nc919, nc920, nc921, nc922, nc923, nc924, nc925, nc926, nc927, nc928, nc929, nc930, nc931, nc932, nc933, nc934, nc935, nc936, nc937, nc938, nc939, nc940, nc941, nc942, nc943, nc944, nc945, nc946, nc947, nc948, nc949, nc950, nc951, nc952, nc953, nc954, nc955, nc956, nc957, nc958, nc959, nc960, dw[31], dw[30], dw[29], dw[28], dw[27], dw[26], dw[25], dw[24], dw[23], dw[22], dw[21], dw[20], dw[19], dw[18], dw[17], dw[16]}),
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
