module fifo_psram_lbuf_emb_v1 (clkr, clkw, cer, cew, rstnr, ar, aw, dw, qr);
input clkr;
input clkw;
input cer;
input cew;
input rstnr;
input [7:0] ar;
input [6:0] aw;
input [31:0] dw;
output [15:0] qr;

wire vcc_net;
wire gnd_net;
wire nc993;
wire nc994;
wire nc995;
wire nc996;
wire nc997;
wire nc998;
wire nc999;
wire nc1000;
wire nc1001;
wire nc1002;
wire nc1003;
wire nc1004;
wire nc1005;
wire nc1006;
wire nc1007;
wire nc1008;

assign vcc_net = 1;
assign gnd_net = 0;
EMB9K #(
		.emb5k_1_init_file (""),
		.emb5k_2_init_file (""),
		.init_file ("none"),
		.clka_inv (1'b0),
		.clkb_inv (1'b0),
		.extension_mode ("area"),
		.outreg_a (1'b0),
		.outreg_b (1'b0),
		.rammode ("sdp"),
		.use_parity (1'b0),
		.width_a (18),
		.width_b (36),
		.writemode_a ("write_first"),
		.writemode_b ("write_first"),
		.byte_write_enable (1'b0)
	)
	emb_0 (
		.doa ({nc993, nc994, nc995, nc996, nc997, nc998, nc999, nc1000, nc1001, nc1002, nc1003, nc1004, nc1005, nc1006, nc1007, nc1008, qr[15], qr[14], qr[13], qr[12], qr[11], qr[10], qr[9], qr[8], qr[7], qr[6], qr[5], qr[4], qr[3], qr[2], qr[1], qr[0]}),
		.dob (),
		.dopa (),
		.dopb (),
		.addra ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, ar[7], ar[6], ar[5], ar[4], ar[3], ar[2], ar[1], ar[0]}),
		.addrb ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, aw[6], aw[5], aw[4], aw[3], aw[2], aw[1], aw[0]}),
		.clka (clkr),
		.clkb (clkw),
		.dia (),
		.dib ({dw[31], dw[30], dw[29], dw[28], dw[27], dw[26], dw[25], dw[24], dw[23], dw[22], dw[21], dw[20], dw[19], dw[18], dw[17], dw[16], dw[15], dw[14], dw[13], dw[12], dw[11], dw[10], dw[9], dw[8], dw[7], dw[6], dw[5], dw[4], dw[3], dw[2], dw[1], dw[0]}),
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
