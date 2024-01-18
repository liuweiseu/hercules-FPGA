/*--------------------------------------------------------------------------
CME-M5.H

Header file for CME M5 Embedded 8051 microcontroller.
--------------------------------------------------------------------------*/

#ifndef __CME_M5_H__
#define __CME_M5_H__

/* Byte Register */
/*Register Location     Reset value     Description */
sfr P0            = 0x80;    //    FFh         Port 0
sfr P1            = 0x90;    //    FFh         Port 1
sfr P2            = 0xA0;    //    FFh         Port 2
sfr P3            = 0xB0;    //    FFh         Port 3
sfr PSW           = 0xD0;    //    FFh         Program Status Word
sfr ACC           = 0xE0;    //    FFh         Accumulator
sfr B             = 0xF0;    //    FFh         B Register

sfr SP            = 0x81;    //    07h         Stack Pointer
sfr DPL           = 0x82;    //    00h         Data Pointer Low
sfr DPH           = 0x83;    //    00h         Data Pointer High
sfr DPL1          = 0x84;    //    00h         Data Pointer 1 Low
sfr DPH1          = 0x85;    //    00h         Data Pointer 1 High
sfr WDTREL        = 0x86;    //    00h         Watchdog Timer Reload register
sfr PCON          = 0x87;    //    00h         Power Control
sfr TCON          = 0x88;    //    00h         Timer/Counter Control Register
sfr TMOD          = 0x89;    //    00h         Timer Mode Register
sfr TL0           = 0x8A;    //    00h         Timer 0, low byte
sfr TL1           = 0x8B;    //    00h         Timer 1, low byte
sfr TH0           = 0x8C;    //    00h         Timer 0, high byte
sfr TH1           = 0x8D;    //    00h         Timer 1, high byte
sfr CKCON         = 0x8E;    //    71h         Clock Control Register

sfr DPSEL         = 0x92;    //    00h         Data Pointer Select Register
sfr DPC           = 0x93;    //    00h         Data Pointer Control Register
sfr PAGESEL       = 0x94;    //    01h         Program Memory Page selector
sfr D_PAGESEL     = 0x95;    //    01h         External Data Memory Page selector
sfr S0CON         = 0x98;    //    00h         Serial Port 0, Control Register
sfr S0BUF         = 0x99;    //    00h         Serial Port 0, Data Buffer
sfr IEN2          = 0x9A;    //    00h         Interrupt Enable Register 2
sfr S1CON         = 0x9B;    //    00h         Serial Port 1, Control Register
sfr S1BUF         = 0x9C;    //    00h         Serial Port 1, Data Buffer
sfr S1RELL        = 0x9D;    //    00h         Serial Port 1, Reload Register, low byte

sfr DMAS0         = 0xA1;    //    00h         DMA Source Address Register 0
sfr DMAS1         = 0xA2;    //    00h         DMA Source Address Register 1
sfr DMAS2         = 0xA3;    //    00h         DMA Source Address Register 2
sfr DMAT0         = 0xA4;    //    00h         DMA Target Address Register 0
sfr DMAT1         = 0xA5;    //    00h         DMA Target Address Register 1
sfr DMAT2         = 0xA6;    //    00h         DMA Target Address Register 2
sfr IEN0          = 0xA8;    //    00h         Interrupt Enable Register 0
sfr IP0           = 0xA9;    //    00h         Interrupt Priority Register 0
sfr S0RELL        = 0xAA;    //    D9h         Serial Port 0, Reload Register, low byte
sfr I2CSPISEL     = 0xAB;    //    00h         I2C source and fixed or user IO select
sfr ISCDATA0      = 0xAC;    //    00h         In System Configuration Data[7:0]
sfr ISCDATA1      = 0xAD;    //    00h         In System Configuration Data[15:8]
sfr ISCDATA2      = 0xAE;    //    00h         In System Configuration Data[23:16]
sfr ISCDATA3      = 0xAF;    //    00h         In System Configuration Data[31:24]

sfr DMAC0         = 0xB1;    //    00h         DMA Byte Counter Register 0
sfr DMAC1         = 0xB2;    //    00h         DMA Byte Counter Register 1
sfr DMAC2         = 0xB3;    //    00h         DMA Byte Counter Register 2
sfr DMASEL        = 0xB4;    //    00h         DMA Channel Select Register
sfr DMAM0         = 0xB5;    //    00h         DMA Mode Register 0
sfr DMAM1         = 0xB6;    //    1Fh         DMA Mode Register 1
sfr IEN1          = 0xB8;    //    00h         Interrupt Enable Register 1
sfr IP1           = 0xB9;    //    00h         Interrupt Priority Register 1
sfr S0RELH        = 0xBA;    //    03h         Serial Port 0, Reload Register, high byte
sfr S1RELH        = 0xBB;    //    03h         Serial Port 1, Reload Register, high byte
sfr IRCON2        = 0xBF;    //    00h         Interrupt Request Control 2 Register

sfr IRCON         = 0xC0;    //    00h         Interrupt Request Control Register
sfr CCEN          = 0xC1;    //    00h         Compare/Capture Enable Register
sfr CCL1          = 0xC2;    //    00h         Compare/Capture Register 1, low byte
sfr CCH1          = 0xC3;    //    00h         Compare/Capture Register 1, high byte
sfr CCL2          = 0xC4;    //    00h         Compare/Capture Register 2, low byte
sfr CCH2          = 0xC5;    //    00h         Compare/Capture Register 2, low byte
sfr CCL3          = 0xC6;    //    00h         Compare/Capture Register 3, low byte
sfr CCH3          = 0xC7;    //    00h         Compare/Capture Register 3, high byte
sfr T2CON         = 0xC8;    //    00h         Timer 2 Control Register
sfr CRCL          = 0xCA;    //    00h         Compare/Reload/Capture Register, low byte
sfr CRCH          = 0xCB;    //    00h         Compare/Reload/Capture Register, high byte
sfr TL2           = 0xCC;    //    00h         Timer 2, low byte
sfr TH2           = 0xCD;    //    00h         Timer 2, high byte

sfr IEN4          = 0xD1;    //    00h         Interrupt Enable Register 4
sfr ADCON         = 0xD8;    //    00h         Serial Port 0 Baud Rate Select register (only adcon.7 bit used)
sfr I2CDAT        = 0xDA;    //    00h         I2C Data Register
sfr I2CADR        = 0xDB;    //    00h         I2C Address Register
sfr I2CCON        = 0xDC;    //    00h         I2C Control Register
sfr I2CSTA        = 0xDD;    //    00h         I2C Status Register

sfr SPSTA         = 0xE1;    //    00h         Serial Peripheral(SPI) Status Register
sfr SPCON         = 0xE2;    //    14h         Serial Peripheral(SPI) Control Register
sfr SPDAT         = 0xE3;    //    00h         Serial Peripheral(SPI) Data Register
sfr SPSSN         = 0xE4;    //    FFh         Serial Peripheral(SPI) Slave Select Register
sfr RTCCMD        = 0xE5;    //    00h         RTC Command Register
sfr RTCSEL        = 0xE6;    //    00h         RTC Select Register
sfr RTCDATA       = 0xE7;    //    00h         RTC Data Register
sfr MD0           = 0xE9;    //    00h         Multiplication/Division Register 0
sfr MD1           = 0xEA;    //    00h         Multiplication/Division Register 1
sfr MD2           = 0xEB;    //    00h         Multiplication/Division Register 2
sfr MD3           = 0xEC;    //    00h         Multiplication/Division Register 3
sfr MD4           = 0xED;    //    00h         Multiplication/Division Register 4
sfr MD5           = 0xEE;    //    00h         Multiplication/Division Register 5
sfr ARCON         = 0xEF;    //    00h         Arithmetic Control Register

sfr ISCCMD        = 0xF2;    //    00h         In System Configuration Command
sfr ISCHEADER0    = 0xF3;    //    00h         In System Configuration Header[7:0]
sfr ISCHEADER1    = 0xF4;    //    00h         In System Configuration Header[15:8]
sfr ISCHEADER2    = 0xF5;    //    00h         In System Configuration Header[23:9]
sfr ISCHEADER3    = 0xF6;    //    00h         In System Configuration Header[31:24]
sfr SRST          = 0xF7;    //    00h         Software Reset Register
sfr GCLKCMD       = 0xF8;    //    00h         Global Clock Command Register
sfr GCLKADDR      = 0xF9;    //    00h         Global Clock Address Register
sfr GCLKDATA      = 0xFA;    //    00h         Global Clock Data Register
sfr ISMDIRCTRL    = 0xFB;    //    00h         In System Management Control Register

/* BIT Register */

/* PSW:Program Status Word->Byte Address:0xD0,bit Address:0xD0~0xD7 */
sbit CY       = 0xD7;
sbit AC       = 0xD6;
sbit F0       = 0xD5;
sbit RS1      = 0xD4;
sbit RS0      = 0xD3;
sbit OV       = 0xD2;
sbit F1       = 0xD1;
sbit P        = 0xD0;

/* TCON:Timer/Counter Control Register->Byte Address:0x88,bit Address:0x88~0x8F */
sbit TF1      = 0x8F;
sbit TR1      = 0x8E;
sbit TF0      = 0x8D;
sbit TR0      = 0x8C;
sbit IE1      = 0x8B;
sbit IT1      = 0x8A;
sbit IE0      = 0x89;
sbit IT0      = 0x88;

/* T2CON:Timer 2 Control Register->Byte Address:0xC8,bit Address:0xC8~0xCF */
sbit T2PS     = 0xCF;
sbit I3FR     = 0xCE;
sbit I2FR     = 0xCD;
sbit T2R1     = 0xCC;
sbit T2R0     = 0xCB;
sbit T2CM     = 0xCA;
sbit T2I1     = 0xC9;
sbit T2I0     = 0xC8;

/* S0CON:Serial Port 0,Control Register->Byte Address:0x98,bit Address:0x98~0x9F */
sbit SM0      = 0x9F;
sbit SM1      = 0x9E;
sbit SM20     = 0x9D;
sbit REN0     = 0x9C;
sbit TB80     = 0x9B;
sbit RB80     = 0x9A;
sbit TI0      = 0x99;
sbit RI0      = 0x98;

/* IEN0:Interrupt Enable Register 0->Byte Address:0xA8,bit Address:0xA8~0xAF */
sbit EAL      = 0xAF;
sbit WDT      = 0xAE;
sbit ET2      = 0xAD;
sbit ES0      = 0xAC;
sbit ET1      = 0xAB;
sbit EX1      = 0xAA;
sbit ET0      = 0xA9;
sbit EX0      = 0xA8;

/* IEN1:Interrupt Priority Register/Enable Register 1 */
sbit EXEN2    = 0xBF;
sbit SWDT     = 0xBE;
sbit EX6      = 0xBD;
sbit EX5      = 0xBC;
sbit EX4      = 0xBB;
sbit EX3      = 0xBA;
sbit EX2      = 0xB9;
sbit EX7      = 0xB8;

/* IRCON:Interrupt Request Control Register->Byte Address:0xC0,bit Address:0xC0~0xC7 */
sbit EXF2     = 0xC7;
sbit TF2      = 0xC6;
sbit IEX6     = 0xC5;
sbit IEX5     = 0xC4;
sbit IEX4     = 0xC3;
sbit IEX3     = 0xC2;
sbit IEX2     = 0xC1;
sbit IADC     = 0xC0;

/* ADCON:Serial Port 0 Baud Rate Select register (only adcon.7 bit used) */
sbit BD       = 0xDF;

/* P0:Port 0->Byte Address:0x80,bit Address:0x80~0x87 */
sbit P0_0     = 0x80;
sbit P0_1     = 0x81;
sbit P0_2     = 0x82;
sbit P0_3     = 0x83;
sbit P0_4     = 0x84;
sbit P0_5     = 0x85;
sbit P0_6     = 0x86;
sbit P0_7     = 0x87;

/* P1:Port 1->Byte Address:0x90,bit Address:0x90~0x97 */
sbit P1_0     = 0x90;
sbit P1_1     = 0x91;
sbit P1_2     = 0x92;
sbit P1_3     = 0x93;
sbit P1_4     = 0x94;
sbit P1_5     = 0x95;
sbit P1_6     = 0x96;
sbit P1_7     = 0x97;

/* P2:Port 2->Byte Address:0xA0,bit Address:0xA0~0xA7 */
sbit P2_0     = 0xA0;
sbit P2_1     = 0xA1;
sbit P2_2     = 0xA2;
sbit P2_3     = 0xA3;
sbit P2_4     = 0xA4;
sbit P2_5     = 0xA5;
sbit P2_6     = 0xA6;
sbit P2_7     = 0xA7;

/* P3:Port 3->Byte Address:0xB0,bit Address:0xB0~0xB7 */
sbit P3_0     = 0xB0;
sbit P3_1     = 0xB1;
sbit P3_2     = 0xB2;
sbit P3_3     = 0xB3;
sbit P3_4     = 0xB4;
sbit P3_5     = 0xB5;
sbit P3_6     = 0xB6;
sbit P3_7     = 0xB7;

/* MISCCON:Misc Control Register->Byte Address:0xF8,bit Address:0xF8~0xFF */
sbit ISCEN    = 0xF8;
sbit DPRAMWP  = 0xF9;
sbit PLLLOCK  = 0xFA;
sbit PLLPWD   = 0xFB;
sbit CLKCPUTRIG = 0xFC;
sbit CLKO0TRIG  = 0xFD;
sbit CLKO1TRIG  = 0xFE;
sbit CLKO2TRIG  = 0xFF;


/*****************************************************************************************************/
unsigned long TX_PLL_CM[240] = {
	0xE0,0xE1,0xE2,0xE3,0xE4,0xE5,0xE6,0xE7,0xE8,0xE9,0xEA,0xEB,0xEC,0xED,0xEE,0xEF,     //16~31
	0xC0,0xC1,0xC2,0xC3,0xC4,0xC5,0xC6,0xC7,0xC8,0xC9,0xCA,0xCB,0xCC,0xCD,0xCE,0xCF,		 //32~47
	0xD0,0xD1,0xD2,0xD3,0xD4,0xD5,0xD6,0xD7,0xD8,0xD9,0xDA,0xDB,0xDC,0xDD,0xDE,0xDF,		 //48~63
	0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87,0x88,0x89,0x8A,0x8B,0x8C,0x8D,0x8E,0x8F,			//64~79
	0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97,0x98,0x99,0x9A,0x9B,0x9C,0x9D,0x9E,0x9F,			//80~95
	0xA0,0xA1,0xA2,0xA3,0xA4,0xA5,0xA6,0xA7,0xA8,0xA9,0xAA,0xAB,0xAC,0xAD,0xAE,0xAF,			//96~111
	0xB0,0xB1,0xB2,0xB3,0xB4,0xB5,0xB6,0xB7,0xB8,0xB9,0xBA,0xBB,0xBC,0xBD,0xBE,0xBF,			//112~127
	0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
	0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F,
	0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27,0x28,0x29,0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,
	0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37,0x38,0x39,0x3A,0x3B,0x3C,0x3D,0x3E,0x3F,
	0x40,0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4C,0x4D,0x4E,0x4F,
	0x50,0x51,0x52,0x53,0x54,0x55,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5C,0x5D,0x5E,0x5F,
	0x60,0x61,0x62,0x63,0x64,0x65,0x66,0x67,0x68,0x69,0x6A,0x6B,0x6C,0x6D,0x6E,0x6F,
	0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77,0x78,0x79,0x7A,0x7B,0x7C,0x7D,0x7E,0x7F
};


unsigned long TX_PLL_CN[32] = {
	0x1F,0x00,0x10,0x18,0x1C,0x0E,0x07,0x13,
	0x09,0x04,0x02,0x11,0x08,0x14,0x0A,0x15,
	0x1A,0x1D,0x1E,0x0F,0x17,0x1B,0x0D,0x16,
	0x0B,0x05,0x12,0x19,0x0C,0x06,0x03,0x01
};


unsigned long TX_PLL_CO[4] = {1,2,4,8};

/**************************************************************************************************/

#endif
