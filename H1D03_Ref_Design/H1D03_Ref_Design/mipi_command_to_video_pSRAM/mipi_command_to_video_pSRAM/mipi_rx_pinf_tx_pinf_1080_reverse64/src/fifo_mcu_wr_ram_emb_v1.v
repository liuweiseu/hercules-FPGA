module fifo_mcu_wr_ram_emb_v1 (clkr, clkw, cer, cew, rstnr, ar, aw, dw, qr);
input clkr;
input clkw;
input cer;
input cew;
input rstnr;
input [5:0] ar;
input [6:0] aw;
input [7:0] dw;
output [15:0] qr;

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

assign vcc_net = 1;
assign gnd_net = 0;
EMB5K #(
		.clka_inv (1'b0),
		.clkb_inv (1'b0),
		.init_file (""),
		.outreg_a (1'b0),
		.outreg_b (1'b0),
		.rammode ("sdp"),
		.width_a (18),
		.width_b (9),
		.writemode_a ("write_first"),
		.writemode_b ("write_first")
	)
	emb_0 (
		.doa ({qr[15], qr[14], qr[13], qr[12], qr[11], qr[10], qr[9], qr[8], qr[7], qr[6], qr[5], qr[4], qr[3], qr[2], qr[1], qr[0]}),
		.dob (),
		.dopa (),
		.dopb (),
		.addra ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, ar[5], ar[4], ar[3], ar[2], ar[1], ar[0]}),
		.addrb ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, aw[6], aw[5], aw[4], aw[3], aw[2], aw[1], aw[0]}),
		.clka (clkr),
		.clkb (clkw),
		.dia (),
		.dib ({nc1, nc2, nc3, nc4, nc5, nc6, nc7, nc8, dw[7], dw[6], dw[5], dw[4], dw[3], dw[2], dw[1], dw[0]}),
		.dipa (),
		.dipb (),
		.cea (cer),
		.ceb (cew),
		.regcea (vcc_net),
		.regceb (),
		.regsra (rstnr),
		.regsrb (),
		.wea (gnd_net),
		.web (vcc_net)
	);

endmodule
