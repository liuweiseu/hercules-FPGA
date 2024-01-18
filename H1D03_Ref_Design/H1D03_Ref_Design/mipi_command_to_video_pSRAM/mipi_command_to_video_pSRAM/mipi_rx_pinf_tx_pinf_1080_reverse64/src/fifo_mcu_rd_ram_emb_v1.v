module fifo_mcu_rd_ram_emb_v1 (clkr, clkw, cer, cew, rstnr, ar, aw, dw, qr);
input clkr;
input clkw;
input cer;
input cew;
input rstnr;
input [6:0] ar;
input [5:0] aw;
input [15:0] dw;
output [7:0] qr;

wire vcc_net;
wire gnd_net;
wire nc9;
wire nc10;
wire nc11;
wire nc12;
wire nc13;
wire nc14;
wire nc15;
wire nc16;

assign vcc_net = 1;
assign gnd_net = 0;
EMB5K #(
		.clka_inv (1'b0),
		.clkb_inv (1'b0),
		.init_file (""),
		.outreg_a (1'b0),
		.outreg_b (1'b0),
		.rammode ("sdp"),
		.width_a (9),
		.width_b (18),
		.writemode_a ("write_first"),
		.writemode_b ("write_first")
	)
	emb_0 (
		.doa ({nc9, nc10, nc11, nc12, nc13, nc14, nc15, nc16, qr[7], qr[6], qr[5], qr[4], qr[3], qr[2], qr[1], qr[0]}),
		.dob (),
		.dopa (),
		.dopb (),
		.addra ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, ar[6], ar[5], ar[4], ar[3], ar[2], ar[1], ar[0]}),
		.addrb ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, aw[5], aw[4], aw[3], aw[2], aw[1], aw[0]}),
		.clka (clkr),
		.clkb (clkw),
		.dia (),
		.dib ({dw[15], dw[14], dw[13], dw[12], dw[11], dw[10], dw[9], dw[8], dw[7], dw[6], dw[5], dw[4], dw[3], dw[2], dw[1], dw[0]}),
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
