// *******************************************************************
//
//  Copyright (c) 2012  Capital Microelectronics Inc.
//
// *******************************************************************
//
//  Please review the terms of the license agreement before using
//  this file. If you are not an authorized user, please destroy this
//  source code file and notify CME immediately that you inadvertently
//  received an unauthorized copy.
//
// *******************************************************************
//  Project name        : CME-M5-N-L144-EVB
//  Project description : Board interfaces service
//  File name           : BasicDataType.h
//  File version        : 1.00
//  File contents       : Code file for header module
//  Design Engineer     : qrzhou,lkzhang
//  Quality Engineer    : Allen Zhang
//  Last modification   : 2012-12-24
// *******************************************************************
//
//  Modifications with respect to Version 1.00 :

// *******************************************************************

#ifndef __BASICDATATYPE_H__
#define __BASICDATATYPE_H__

// *******************************************************************
//  Demo section
#define ISC_DEMO_ON            //打开ISC
#define ISC_DEMO_1             //编译为ISC第1个image
//#define ISC_DEMO_2             //编译为ISC第2个image
// *******************************************************************

// *******************************************************************
//  variable type redefine
#ifndef UINT8
#define UINT8 unsigned char
#endif

#ifndef UINT16
#define UINT16 unsigned short
#endif

#ifndef UINT32
#define UINT32 unsigned long
#endif

#ifndef INT8
#define INT8 signed char
#endif

#ifndef INT16
#define INT16 signed short
#endif

#ifndef INT32
#define INT32 signed long
#endif

#ifndef SINT8
#define SINT8 signed char
#endif

#ifndef SINT16
#define SINT16 signed short
#endif

#ifndef SINT32
#define SINT32 signed long
#endif

#ifndef U8
#define U8 unsigned char
#endif

#ifndef U16
#define U16 unsigned short
#endif

#ifndef U32
#define U32 unsigned long
#endif

#ifndef I8
#define I8 signed char
#endif

#ifndef I16
#define I16 signed short
#endif

#ifndef I32
#define I32 signed long
#endif

#ifndef FLOAT32
#define FLOAT32 float
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef false
#define false 0
#endif

#ifndef TRUE
#define TRUE 1
#endif

#ifndef true
#define true 1
#endif

#ifndef BOOL
#define BOOL UINT8
#endif

#ifndef bool
#define bool UINT8
#endif

#ifndef NULL
#define NULL ((void *)0)
#endif


#ifndef BIT0
#define BIT0    0x01
#endif

#ifndef BIT1
#define BIT1    0x02
#endif

#ifndef BIT2
#define BIT2    0x04
#endif

#ifndef BIT3
#define BIT3    0x08
#endif

#ifndef BIT4
#define BIT4    0x10
#endif

#ifndef BIT5
#define BIT5    0x20
#endif

#ifndef BIT6
#define BIT6    0x40
#endif

#ifndef BIT7
#define BIT7    0x80
#endif

// *******************************************************************

//8051时钟频率定义：应和FP PLL生成的时钟频率一致
#define CPU_CLOCK   200000000UL
// *******************************************************************

// *******************************************************************
//define temporary globe variable
extern UINT8 data g_u8tmp0,g_u8tmp1;
extern UINT16 data g_u16tmp0,g_u16tmp1;
//define UART globe variable
extern UINT8 g_u8UartTxBuf[256];
//Uart config
extern UINT8  g_u8BaudRateID;
//define I2C globe variable
extern UINT8 RtcSetBuf[16];
extern UINT8 RtcGetBuf[16];
//RUNPARA
extern UINT8  g_u8SoftWdtCounterL;
extern UINT8  g_u8SoftWdtCounterH;
extern UINT8  g_u8SoftWdtResetFlag;
#define SOFT_WDT_VALUE        19        //软件看门狗值19*256*1m=5s
#define SOFT_WDT_FLAG         0x86      //软件看门狗复位标识
// *******************************************************************

#endif

















