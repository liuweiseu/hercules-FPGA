#include "BasicDataType.h"
#include "CME-M5.h"

#define SCL  P2_0
#define SDA  P2_1

#define delay0 20
#define delay1 10

#define Delay_I2C delay100k
//#define Delay_I2C delay400k


static void delay100k(void) /*延时函数*/
{
	
 U8 i,j;
  for(i=0;i<5;i++);
}

static void delay400k(void) /*延时函数*/
{
 U32 i,j;
  for(i=0;i<7;i++)
  	{
  		for(j=0;j<8;j++);
  	}
}



void Gpio2iic_open(void)
{
	SCL=1;
	SDA=1;
}

//启动I2C总线,即发送I2C起始条件:SCL为高电平期间，SDA出现下降沿
void Start_I2C(void)
{
    SDA = 1;
    Delay_I2C();            //延时一段时间
    SCL = 1;
    Delay_I2C();
    SDA = 0;
    Delay_I2C();
    SCL = 0;                //???           /*钳住I2C总线，准备发送或接收数据 */
    Delay_I2C();        


}

//停止I2C总线信号,即发送I2C停止条件:SCL为高电平期间，SDA出现上升沿
void Stop_I2C(void)
{
    SDA = 0;
    Delay_I2C();            //延时一段时间
    SCL = 1;
    Delay_I2C();
    SDA = 1;
    Delay_I2C();
}


//检验应答信号
unsigned char CheckAck(void)
{
        unsigned char val;
        /*发送完一个字节后检验设备的应答信号*/
        SDA=1;
        SCL=1;
        Delay_I2C();
        val=SDA;
        Delay_I2C();
        SCL=0;
        Delay_I2C();

        return val;
}


//通过I2C总线发送一个字节
unsigned char SendByte_I2C(unsigned char  c)
{
    unsigned char i = 0;

    SCL = 0;                //???           /*钳住I2C总线，准备发送或接收数据 */
    Delay_I2C();        

    for(i = 0;i<8;++i)
    {
        if(c<<i & 0x80)
            SDA = 1;
        else
            SDA = 0;
			Delay_I2C(); 
            SCL = 1;    /*置时钟线为高，通知被控器开始接收数据位*/
            Delay_I2C();    
            SCL = 0;
           // Delay_I2C();            //???
    }
	Delay_I2C();
    return CheckAck();      //返回接收方的确认结果
}


//从I2C总线中接收一个字节的数据
unsigned char RecByte_I2C(void)
{
    unsigned char  retc;
  unsigned char  BitCnt;

  retc=0; 
  SDA=1;                       /*释放总线*/
  
  for(BitCnt=0;BitCnt<8;BitCnt++)
    {

        SCL=0;                  /*置时钟线为低，准备接收数据位*/
        Delay_I2C();
        SCL=1;                  /*置时钟线为高使数据线上数据有效*/
        Delay_I2C();
        retc=retc<<1;
        if(SDA==1)retc=retc+1;  /*读数据位,接收的数据位放入retc中 */
        //Delay_I2C(); 
    }
        SCL=0;    
        Delay_I2C();
        return(retc);
}


//发送应答信号
void Ack_I2C(unsigned char ack)
{
    if(ack==0)
        SDA=0;              /*在此发出应答或非应答信号 */
  else
        SDA=1;
  Delay_I2C();     
  SCL=1;
  Delay_I2C();
  SCL=0;                     /*清时钟线，钳住I2C总线以便继续接收*/
  Delay_I2C(); 
}

unsigned char GPIOI2CMasterWrite( unsigned char SlaveAdd,
                              unsigned char *Buffer, 
                              unsigned int ToWrite )
{
	U8 dat;
	U8 ack;
	unsigned int i;
	if(ToWrite==0)
		return 1;
	Start_I2C();
	dat=SlaveAdd;
	ack=SendByte_I2C(dat);
	if(ack)
		return 1;
	for(i=0;i<ToWrite;i++)
		{
			Delay_I2C();
			Delay_I2C();
			Delay_I2C();
			Delay_I2C();
			Delay_I2C();
			Delay_I2C();
			dat=*Buffer;
			Buffer++;
			ack=SendByte_I2C(dat);
			if(ack)
				return 1;
		}
	Stop_I2C();
	return 0;
}

unsigned char GPIOI2CMasterRead( unsigned char SlaveAdd,
                              unsigned char *Buffer, 
                              unsigned int ToRead )
{
	U8 dat;
	U8 ack;
	unsigned int i;
	if(ToRead==0)
		return 1;
	Start_I2C();
	dat=SlaveAdd+1;
	ack=SendByte_I2C(dat);
	if(ack)
		return 1;
	for(i=ToRead;i>0;i--)
		{
			Delay_I2C();
			Delay_I2C();
			Delay_I2C();
			Delay_I2C();
			Delay_I2C();
			Delay_I2C();
			*Buffer=RecByte_I2C();
			Buffer++;
			if(i==1)
				Ack_I2C(1);
			else
				Ack_I2C(0);
		}
	Stop_I2C();
	return 0;
}							  



