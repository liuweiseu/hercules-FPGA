
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

#ifndef GPIO2IIC
#define GPIO2IIC

unsigned char GPIOI2CMasterWrite( unsigned char SlaveAdd,
                              unsigned char *Buffer, 
                              unsigned int ToWrite );


unsigned char GPIOI2CMasterRead( unsigned char SlaveAdd,
							unsigned char *Buffer, 
							unsigned int ToRead );
void Gpio2iic_open(void);

#endif 
