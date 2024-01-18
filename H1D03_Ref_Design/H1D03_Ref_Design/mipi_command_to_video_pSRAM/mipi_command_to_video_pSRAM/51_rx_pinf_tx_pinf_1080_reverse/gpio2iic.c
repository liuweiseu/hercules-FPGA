#include "BasicDataType.h"
#include "CME-M5.h"

#define SCL  P2_0
#define SDA  P2_1

#define delay0 20
#define delay1 10

#define Delay_I2C delay100k
//#define Delay_I2C delay400k


static void delay100k(void) /*��ʱ����*/
{
	
 U8 i,j;
  for(i=0;i<5;i++);
}

static void delay400k(void) /*��ʱ����*/
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

//����I2C����,������I2C��ʼ����:SCLΪ�ߵ�ƽ�ڼ䣬SDA�����½���
void Start_I2C(void)
{
    SDA = 1;
    Delay_I2C();            //��ʱһ��ʱ��
    SCL = 1;
    Delay_I2C();
    SDA = 0;
    Delay_I2C();
    SCL = 0;                //???           /*ǯסI2C���ߣ�׼�����ͻ�������� */
    Delay_I2C();        


}

//ֹͣI2C�����ź�,������I2Cֹͣ����:SCLΪ�ߵ�ƽ�ڼ䣬SDA����������
void Stop_I2C(void)
{
    SDA = 0;
    Delay_I2C();            //��ʱһ��ʱ��
    SCL = 1;
    Delay_I2C();
    SDA = 1;
    Delay_I2C();
}


//����Ӧ���ź�
unsigned char CheckAck(void)
{
        unsigned char val;
        /*������һ���ֽں�����豸��Ӧ���ź�*/
        SDA=1;
        SCL=1;
        Delay_I2C();
        val=SDA;
        Delay_I2C();
        SCL=0;
        Delay_I2C();

        return val;
}


//ͨ��I2C���߷���һ���ֽ�
unsigned char SendByte_I2C(unsigned char  c)
{
    unsigned char i = 0;

    SCL = 0;                //???           /*ǯסI2C���ߣ�׼�����ͻ�������� */
    Delay_I2C();        

    for(i = 0;i<8;++i)
    {
        if(c<<i & 0x80)
            SDA = 1;
        else
            SDA = 0;
			Delay_I2C(); 
            SCL = 1;    /*��ʱ����Ϊ�ߣ�֪ͨ��������ʼ��������λ*/
            Delay_I2C();    
            SCL = 0;
           // Delay_I2C();            //???
    }
	Delay_I2C();
    return CheckAck();      //���ؽ��շ���ȷ�Ͻ��
}


//��I2C�����н���һ���ֽڵ�����
unsigned char RecByte_I2C(void)
{
    unsigned char  retc;
  unsigned char  BitCnt;

  retc=0; 
  SDA=1;                       /*�ͷ�����*/
  
  for(BitCnt=0;BitCnt<8;BitCnt++)
    {

        SCL=0;                  /*��ʱ����Ϊ�ͣ�׼����������λ*/
        Delay_I2C();
        SCL=1;                  /*��ʱ����Ϊ��ʹ��������������Ч*/
        Delay_I2C();
        retc=retc<<1;
        if(SDA==1)retc=retc+1;  /*������λ,���յ�����λ����retc�� */
        //Delay_I2C(); 
    }
        SCL=0;    
        Delay_I2C();
        return(retc);
}


//����Ӧ���ź�
void Ack_I2C(unsigned char ack)
{
    if(ack==0)
        SDA=0;              /*�ڴ˷���Ӧ����Ӧ���ź� */
  else
        SDA=1;
  Delay_I2C();     
  SCL=1;
  Delay_I2C();
  SCL=0;                     /*��ʱ���ߣ�ǯסI2C�����Ա��������*/
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



