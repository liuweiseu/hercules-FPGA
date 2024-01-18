module sync_fifo_emb_v1 (clkr, clkw, cer, cew, rstnr, ar, aw, dw, qr);
input clkr;
input clkw;
input cer;
input cew;
input rstnr;
input [2:0] ar;
input [2:0] aw;
input [3:0] dw;
output [3:0] qr;

wire vcc_net;
wire gnd_net;
wire net_15;
wire net_16;
wire net_17;
wire net_18;
wire net_19;
wire net_20;
wire net_21;
wire net_22;
wire net_23;
wire net_24;
wire net_25;
wire net_26;
wire nc161;
wire nc162;
wire nc163;
wire nc164;
wire nc165;
wire nc166;
wire nc167;
wire nc168;
wire nc169;
wire nc170;
wire nc171;
wire nc172;

assign vcc_net = 1;
assign gnd_net = 0;
EMB5K #(
		.clka_inv (1'b0),
		.clkb_inv (1'b0),
		.outreg_a (1'b0),
		.outreg_b (1'b0),
		.rammode ("sdp"),
		.width_a (18),
		.width_b (18),
		.writemode_a ("write_first"),
		.writemode_b ("write_first"),
		.init_file ("")
	)
	emb_0 (
		.doa ({net_26, net_25, net_24, net_23, net_22, net_21, net_20, net_19, net_18, net_17, net_16, net_15, qr[3], qr[2], qr[1], qr[0]}),
		.dob (),
		.dopa (),
		.dopb (),
		.addra ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, ar[2], ar[1], ar[0]}),
		.addrb ({gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, gnd_net, aw[2], aw[1], aw[0]}),
		.clka (clkr),
		.clkb (clkw),
		.dia (),
		.dib ({nc161, nc162, nc163, nc164, nc165, nc166, nc167, nc168, nc169, nc170, nc171, nc172, dw[3], dw[2], dw[1], dw[0]}),
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
