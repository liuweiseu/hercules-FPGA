//
// This is a file generated by SPI Interface wizard.
// Please do not edit this file!
// Generated time: 06/06/2019 10:37:13
// Version: Fuxi 2019.1 win64
// Wizard name: SPI Interface 1.0a
//
// ============================================================
// File Name: spiInterface_v1.v
// IP core : spiInterface
// Device name: HR02PN3W24C7
// ============================================================

module spiInterface_v1(
    sclk,
    sdo,
    cson,
    sdi_in,
	sdi_oen,
	sdi_out
);

input sclk;
output sdo;
input cson;
input sdi_in;
input sdi_oen;
output sdi_out;

dspi_interface u_spi_interface (
        .sclk (sclk),
        .sdo (sdo),
        .cson (cson),
        .sdi_in (sdi_in),
        .sdi_oen (sdi_oen),
        .sdi_out (sdi_out)
);

endmodule

// ============================================================
//                  spiInterface Setting
//
// Warning: This part is read by Fuxi, please don't modify it.
// ============================================================
// Device          : HR02PN3W24C7
// Module          : spiInterface_v1
// IP core         : spiInterface
// IP Version      : 1

// Simulation Files: 
// Synthesis Files : 