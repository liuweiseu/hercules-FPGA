
#include "CME-M5.h"
#include "BasicDataType.h"
#include "uart.h"
#include "printf.h"
#include "spi.h"

static void delay (U32 delay)
{
	U32 i;
	for(i=0;i<delay;i++);

}

U8 SpiFlashErase(U8 mode,U32 addr)
{
	U16 del;
	U8 a=0;
	U16 b;
	U8 cmd[4];
	switch(mode)
		{
			case SE:
				cmd[0]=0x20;
				del=SEdelay;
				break;
			case BE:
				cmd[0]=0x52;
				del=BEdelay;
				break;
			case CE:
				cmd[0]=0xd8;
				del=CEdelay;
				break;
			default:
				cmd[0]=0x20;
		}
		cmd[1]=(addr>>16)&0xff;
		b=addr>>8;
		cmd[2]=(U8) b&0xff;
		cmd[3]=(addr&0xff);
		
	do{
		SpiSelect(0);
		delay(10);
		a=SpiTrans(cmd,4);
		delay(10);
		SpiSlaveRel();
		}
	while(a);
	
		delay(200000);
	return 0;
}


U8 SpiFlashRD(U32 addr,U32 length)
{

	U8 a =0;

	U8 cmd[4];
	cmd[0]=Rdata;
	cmd[1]=(addr>>16)&0xff;
	cmd[2]=(addr>>8)&0xff;
	cmd[3]=(addr&0xff); 
	SpiSelect(0);
	delay(10);
	SpiRD(cmd,4,length,spi_rdint);
	delay(10);
	SpiSlaveRel();
	return 0;
}

U8 SpiFlashWr (U8 *buf,U32 addr,U32 length)
{
	U16 num;
	U8 i;
	U8 a=0;
	U8 cmd[260];
	cmd[0]=PagePro;
	cmd[1]=(addr>>16)&0xff;
	cmd[2]=(addr>>8)&0xff;
	cmd[3]=(addr&0xff); //must 0x00
	if(length>256)
		num=256;
	else
		num=length;
	for( i=0;i<num;i++)
		cmd[i+4]=buf[i];
	do{
		SpiSelect(0);
		delay(10);
		i=SpiTrans(cmd,num+4);
		delay(10);
		SpiSlaveRel();
		}
	while(a);
		 delay(100);
		return 0;
}


void SpiFlashWrEnable(void)
{
	U8 a=0;
	U8 buf[4];
	//Timer1Init();
	buf[0]=Wen;
		do{
		SpiSelect(0);
		delay(10);
		a=SpiTrans(buf,1);
		delay(10);
		SpiSlaveRel();
		}
		while(a);
		
 	   delay(100);
}

void SpiFlashWrDis(void)
{
	U8 a=0;
	U8 *buf;
	buf[0]=Wdis;
	SpiSelect(0);
		do{
		SpiSelect(0);
		delay(10);
		a=SpiTrans(buf,1);
		delay(10);
		SpiSlaveRel();
		}
		while(a);
}

void SpiFlashReadID(void)
{
	U8 cmd[4];
	cmd[0]=RdID;
	cmd[1]=0;
	cmd[2]=0;
	cmd[3]=0; 
	SpiSelect(0);
	delay(10);
	SpiRD(cmd,4,3,spi_rdint);
	delay(10);
	SpiSlaveRel();

}

