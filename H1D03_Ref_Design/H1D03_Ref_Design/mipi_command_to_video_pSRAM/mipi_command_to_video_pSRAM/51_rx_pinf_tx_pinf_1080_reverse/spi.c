#include "CME-M5.h"
#include "BasicDataType.h"

#include "printf.h"

#include "uart.h"
#define WrError 0x40
#define SyncError 0x20

//area
#define TotalVolumeB 0x80000
#define SectorB 0x1000
#define BlockB 0x10000

//spi flash command
#define Wen 0x06
#define Wdis 0x04
#define RdStaL 0x05
#define RdStaH 0x35
#define Wstate 0x01
#define Rdata 0x03
#define PagePro 0x02
#define SErase 0x20
#define BErase32k 0x52
#define BErase64k 0xd8
#define CErase 0xc7
#define RdmanuID 0x90
#define RdID 0x9f

#define SE 0x0
#define BE 0x1
#define CE 0x2

//spi flash command delay
#define PPdelay 1
#define SEdelay 100
#define BEdelay 500
#define CEdelay 3000


#define master 1
#define slave 0
#define jdeep 1
#define deep 1


U8 spirdbuf[10];
U8 spitxbuf[10];

U8 writing;
U8 wrdone;
U8 rddone;
U8 spirdlen;
U8 spitxlen;
U8 spird_overflow;
U8 spitx_overflow;

U8 spi_mode;

static void delay (U32 delay)
{
	U32 i;
	for(i=0;i<delay;i++);

}

void SpiSelect (U8 channel)
{
	SPSSN =~(1<<channel);

}

void SpiSlaveRel(void)
{

	SPSSN=0xff;
}

void SpiClearFlag(void)
{
	U8 j;
	j=SPSTA; //must clear
	j=SPDAT;
	j=SPSTA; 
}

void SpiHandler(void) interrupt 9
{

	
	if(writing)
		{
			 EX2=0;
			EAL=0;
			wrdone=1;
			writing=0;
			 SpiClearFlag();
			EAL=1;
			EX2=1; 
			
		}
	else
		{
			EX2=0;
			SpiClearFlag();
			EAL=0;
		if(spi_mode==slave)
			{
			if(!spitx_overflow)
				{
					SPDAT=spitxbuf[spitxlen+1];
					//myprintf("spitxbuf is %x !\n",spitxbuf[spitxlen+1]);
			 		spitxlen++;
				}			
			}
		else
			{
				if(!spird_overflow)
					{
			    			spirdbuf[spirdlen]=SPDAT;
							
				 		spirdlen++;
					}
				rddone=1;
				
			}
			
			 if(spitxlen>=(deep*3))
			 	spitx_overflow=0x1;	
			 else
				 spitx_overflow=0;
			 if(spirdlen>=10)
			 	spird_overflow=1;
			 else
				 spird_overflow=0;
			EAL=1;
			EX2=1; 
		}

}

U8 SpiFinish(void)
{
return wrdone;
}


U8 SpiTrans(U8 *buf,U32 length)
{
	U8 dat,i;
       SpiClearFlag();
	   EX2=1; 
	for(i=0;i<length;i++)
		{
			dat=*buf;
			writing=1;
			wrdone=0;		
			SPDAT=dat;
			while(!SpiFinish());
			buf++;
			delay(10);
		}
	EX2=0; 
	return 0;


}

U8 SpiRD(U8 *rdcmd,U8 rdcmdlen,U32 length,U8 mode)
{
	U8 a=0;
	spirdlen=0;
	writing=0;
	
	SpiClearFlag();
	if(rdcmdlen)
	{
	do{
		a=SpiTrans(rdcmd,rdcmdlen);
		}
	while(a);
		}

	if(mode)
		{
		EX2=1; 
		while(spirdlen<length)
			{			
				rddone=0;			
				writing=0;
				delay(5);
				SPDAT=0x0;
				while(!rddone);
				delay(5);				
			}	
		}
	else
	{
	    EX2=0; 
		spirdlen=0;
	   while(spirdlen<length)
			{
				delay(10);
				SPDAT=0x0;//send clock
				delay(10);
				spirdbuf[spirdlen]=SPDAT;
				spirdlen++;				
	    	}
	}
	
		return 0;
}

void SpiSpeedSet(U8 spd)
{
	SPCON&=0x7c;
	switch(spd)
		{
		case 2:
			SPCON&=0x7c;
			break;
		case 4:
			SPCON|=0x1;
			break;
		case 8:
			SPCON|=0x2;
			break;
		case 16:
			SPCON|=0x3;
			break;
		case 32:
			SPCON|=0x80;
			break;
		case 64:
			SPCON|=0x81;
			break;
		case 128:
			SPCON|=0x82;
			break;
		default:
			SPCON|=0x83;
		}

}

void Spi_init_set(U8 flag)
{
	EX2=flag;
}

void SpiInit(U8 speed,U8 mode )
{

	spirdlen=0;
	spitxlen=0;
	writing=0;
	spird_overflow=0;
	spitx_overflow=0;
	spi_mode=master;
	
	SPCON=0;
	EAL=0;
	EX2=0;   
	SpiSlaveRel();
	SpiSpeedSet(speed);
	SpiClearFlag();
	if(mode)
		
			SPCON|=0x30; //master and dis sspn
		
	else
		{
			SPCON&=0xef; //salve mode
			EX2=1; //slave int enable
		}

	SPCON|=0x40; //enable
	EAL=1;
	  
}




