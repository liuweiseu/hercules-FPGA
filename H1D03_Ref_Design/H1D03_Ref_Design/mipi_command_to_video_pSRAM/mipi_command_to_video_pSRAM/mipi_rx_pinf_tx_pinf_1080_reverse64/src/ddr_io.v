// ============================================================
//
// Company:
// Engineer:
//
// Create Date: 10/12/2019 15:21:35   
// Design Name:
// Module Name: ddr_io
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// ============================================================
module ddr_io_r(idp, 
	idn, 
	odp, 
	odn, 
	oen, 
	clk, 
	rstn, 
	setn, 
	clk_en, 
	pad_out,
	pad
);

input odp;
input odn;
input oen;
input clk;
input rstn;
input setn;
input clk_en;
output idp;
output idn;
output pad_out;
inout pad;

parameter oen_sel           = 2'b00;
parameter od_sel            = 2'b00;
parameter is_oen_reg        = 1'b0;
parameter is_clk_gate_en    = 1'b0;
parameter is_setn_inv       = 1'b0;
parameter is_setn_sync      = 1'b0;
parameter is_oen_setn_en    = 1'b0;
parameter is_od_setn_en     = 1'b0;
parameter is_id_setn_en     = 1'b0;
parameter is_rstn_inv       = 1'b0;
parameter is_rstn_sync      = 1'b0;
parameter is_oen_rstn_en    = 1'b0;
parameter is_od_rstn_en     = 1'b0;
parameter is_id_rstn_en     = 1'b0;


wire f_oen;
wire f_out;
wire in;

H6_IOC_FUN u_ioc (
    .clk_en    (clk_en),
    .fclk      (clk),
    .in        (in),
    .out        ({odp, odn}),
    .oen       (oen),
    .rstn      (rstn),
    .setn      (setn),

    .f_in      ({idn, idp}),
    .f_out     (f_out),
    .f_oen     (f_oen),
    .f_out_fb  ()
);

defparam u_ioc.cfg_nc             = 1'b0;
defparam u_ioc.cfg_ddr            = 1'b1;
defparam u_ioc.cfg_foen_sel       = is_oen_reg;
defparam u_ioc.cfg_fout_sel       = 1'b0;
defparam u_ioc.cfg_fin_sel        = 1'b0;
defparam u_ioc.cfg_fclk_inv       = 1'b1;
defparam u_ioc.cfg_fclk_gate_en   = is_clk_gate_en;
defparam u_ioc.cfg_setn_inv       = is_setn_inv;
defparam u_ioc.cfg_setn_sync      = is_setn_sync;
defparam u_ioc.cfg_oen_setn_en    = is_oen_setn_en;
defparam u_ioc.cfg_od_setn_en     = is_od_setn_en;
defparam u_ioc.cfg_id_setn_en     = is_id_setn_en;
defparam u_ioc.cfg_rstn_inv       = is_rstn_inv;
defparam u_ioc.cfg_rstn_sync      = is_rstn_sync;
defparam u_ioc.cfg_oen_rstn_en    = is_oen_rstn_en;
defparam u_ioc.cfg_od_rstn_en     = is_od_rstn_en;
defparam u_ioc.cfg_id_rstn_en     = is_id_rstn_en;

H6_BASIC_IO u_io (
    .f_out    (f_out),
    .f_oen   (f_oen),
    .in      (in),
    .PAD     (pad)
);

defparam u_io.cfg_out_sel         = od_sel;
defparam u_io.cfg_oen_sel         = oen_sel;

endmodule
