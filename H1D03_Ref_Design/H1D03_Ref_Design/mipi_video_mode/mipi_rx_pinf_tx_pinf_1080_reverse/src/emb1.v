                                                       

`timescale 1 ns / 1 ns

module emb1
          (clk,
           reset,
           enb,
           In1,
           Out1);


  input   clk;
  input   reset;
  input   enb;
  input   [10:0] In1;           
  output  [31:0] Out1;           
  
	wire [31:0] datao;

//	emb_v10 xx(
//		.rstn(1'b1), 
//		.clk(clk),
//		.a(In1),
//		.d(2'b0),
//		.ce(enb),
//		.we(1'b0),
//		.q(Out1)
//	);

	sram_v2 xx2(
		.clk	(	clk	),
		.ceb	(	1'b0	),
		.web	(	1'b1	),
		.datai	(	32'd0	),
		.addr	(	In1	),
		.datao  (	datao	)
	);

	assign Out1 = datao[31:0];


endmodule         

