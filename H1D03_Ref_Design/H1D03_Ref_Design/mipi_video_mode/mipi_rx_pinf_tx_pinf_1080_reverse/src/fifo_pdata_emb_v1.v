module fifo_pdata_emb_v1 (clkr, clkw, cer, cew, rstnr, ar, aw, dw, qr);
input clkr;
input clkw;
input cer;
input cew;
input rstnr;
input [5:0] ar;
input [7:0] aw;
input [7:0] dw;
output [31:0] qr;

wire vcc_net;
wire gnd_net;
wire nc1;
wire nc2;
wire nc3;
wire nc4;
wire nc5;
wire nc6;
wire nc7;
wire nc8;
wire nc9;
wire nc10;
wire nc11;
wire nc12;
wire nc13;
wire nc14;
wire nc15;
wire nc16;
wire nc17;
wire nc18;
wire nc19;
wire nc20;
wire nc21;
wire nc22;
wire nc23;
wire nc24;

assign vcc_net = 1;
assign gnd_net = 0;
EMB9K #(
		.clka_inv (1'b0),
		.clkb_inv (1'b0),
		.emb5k_1_init_file (""),
		.emb5k_2_init_file (""),
		.extension_mode ("area"),
		.init_file ("none"),
		.outreg_a (1'b0),
		.outreg_b (1'b0),
		.rammode ("sdp"),
		.use_parity (1'b0),
		.width_a (36),
		.width_b (9),
		.writemode_a ("write_first"),
		.writemode_b ("write_first"),
		.byte_write_enable (1'b0)
	)
	emb_0 (
		.doa ({qr[31], qr[30], qr[29], qr[28], qr[27], qr[26], qr[25], qr[24], qr[23], qr[22], qr[21], qr[20], qr[19], qr[18], qr[17], qr[16], qr[15], qr[14], qr[13], qr[12], qr[11], qr[10], qr[9], qr[8], qr[7], qr[6], qr[5], qr[4], qr[3], qr[2], qr[1], qr[0]}),
		.dob (),
		.dopa (),
		.dopb (),
		.addra ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, ar[5], ar[4], ar[3], ar[2], ar[1], ar[0]}),
		.addrb ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, aw[7], aw[6], aw[5], aw[4], aw[3], aw[2], aw[1], aw[0]}),
		.clka (clkr),
		.clkb (clkw),
		.dia (),
		.dib ({nc1, nc2, nc3, nc4, nc5, nc6, nc7, nc8, nc9, nc10, nc11, nc12, nc13, nc14, nc15, nc16, nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, dw[7], dw[6], dw[5], dw[4], dw[3], dw[2], dw[1], dw[0]}),
		.dipa (),
		.dipb (),
		.cea (cer),
		.ceb (cew),
		.regcea (vcc_net),
		.regceb (),
		.regsra (rstnr),
		.regsrb (),
		.wea ({gnd_net, gnd_net}),
		.web ({vcc_net, vcc_net})
	);

endmodule
