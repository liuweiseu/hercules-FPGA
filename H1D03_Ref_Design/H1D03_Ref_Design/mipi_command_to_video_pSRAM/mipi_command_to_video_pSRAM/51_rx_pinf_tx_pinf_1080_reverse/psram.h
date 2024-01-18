
//================================================================================
// Copyright (c) 2012 Capital-micro, Inc.(Beijing)  All rights reserved.
//
// Capital-micro, Inc.(Beijing) Confidential.
//
// No part of this code may be reproduced, distributed, transmitted,
// transcribed, stored in a retrieval system, or translated into any
// human or computer language, in any form or by any means, electronic,
// mechanical, magnetic, manual, or otherwise, without the express
// written permission of Capital-micro, Inc.
//
//================================================================================
// File Description: 
// Code for external I2C 
//================================================================================
// Revision History :
//     V1.0   2013-01-10  FPGA IP Grp, first created
//================================================================================

#ifndef PSRAM_H
#define PSRAM_H

#define psram0_clk_channel 0x2
#define psram1_clk_channel 0x10
#define psram0_rd_channel 0x4
#define psram1_rd_channel 0x8
#define psram_rd_channel 0x20
#define psram_clk_channel 0x2

#define phase_dir_forward 0x0
#define phase_dir_back 0x1

#define psram_cfg0_set 0x9f14
#define psram_cfg1_set 0

extern U8 psram_rd_buf[256];
extern U8 psram_wr_buf[128];

extern U16 dttt;
extern U16 padj0;
extern U16 padj1;
extern U16 dtmp,dtmp1;

extern U16 clk_phase_step;
extern U16 rd_phase_step;


//void psram_wr(U32 addr, U8 *buf, U32 mun); //burst 128-bytes
void psram_wr(U32 addr, U8 *buf); //burst 128-bytes
void psram_rd(U32 addr, U8 *buf, U16 mun); //burst 128-bytes
void psram_init(U16 psram_cfg0,U16 psram_cfg1);
U8 psram_training(void);
void pll_adjust(U8 channel, U8 dir);
U8 psram_training_new(void);

#endif 
