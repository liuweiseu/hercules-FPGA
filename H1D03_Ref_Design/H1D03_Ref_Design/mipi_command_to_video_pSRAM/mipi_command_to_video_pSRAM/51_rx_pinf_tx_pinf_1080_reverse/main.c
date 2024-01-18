#include "CME-M5.h"
#include "BasicDataType.h"

#include "I2CMan.h"
#include "gpio2iic.h"
#include "tp.h"
#include "psram.h"
#include "spi.h"
#include "spiflash.h"
#include "panel.h"

#define reset_dpi_n P0_0
#define pstart P0_1
#define rstn_mipi P0_2
#define panel_rst P0_7
#define psram_rstn P0_5

#define psram_cfg0_addr 0x600800
#define psram_cfg1_addr 0x600801
#define psram_cfg0 0x8f1c
#define psram_cfg1 0

#define packet_finish P0_3
#define tx_dphy_rdy  P0_4
#define lcd_rstn  P0_6

#define touch_int_in P1_0  //from touch, input
#define touch_int_out P2_2  //to MB, output
#define psram_scan P2_0  //to MB, output
#define psram_err P2_1  //to MB, output


#define test0 P1_4 
#define test1 P1_5 
#define test2 P1_6 
#define test3 P1_7 
#define h_size  720
#define v_size  1560

#define SlaveAddr 0x58

#define psram0_channel 0x2
#define psram1_channel 0x10
#define phase_dir_forward 0x0
#define phase_dir_back 0x1


#define DSI_HOST_MIPI_RATE             560    //853      //mipi rate MHZ 
#define OSC          80                  //FPGA??OSC,??80MHZ
/**********************************************************/
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



U32 cfg_data[37]={
	0x3,   //host_num_lanes
	0x0,   //host_noctn_clk
	0x64,
	0x21,
	0x1e,
	0x1,   //host_auto_eotp
	0x0,
	0x0,
	0x0,
	0x0,
	0xc8,
	720, //host_line_size ??
	200,  //host_fifo_level
	0x5,   //host_color_code 5= RGB 24-bit
	0x3,   //host_rbg_fmt 0= RGB 16-bit,1= RGB 18-bit,2= RGB 18-bit loosely packed,3= RGB 24-bit
	0x1,   //host_vs_pol  Sets polarity of dpi_vsync input, 0 active low, 1 active high
	0x1,   //host_hs_pol  Sets Polarity of dpi_hsync input, 0 active low, 1 active high
	0x2,   //host_video_mode 0=Non-Burst mode with Sync Pulses,1=Non-Burst mode with Sync Events,2=Burst mode
	10,  //host_hfp  ???
	10,  //host_hbp  ???
	2,   //host_hsa  ???
	0x0,   //host_en_mult_pkts 0=Video Line is sent in a single packet,1=Video Line is sent in two packets
	30,   //host_vbp  ???
	20,  //host_vfp  ???
	0x0,   //host_bllp_mode 0=blanking packets are sent during BLLP periods,1=LP mode is used for BLLP periods
	0x0,   //host_en_null_pkt 0=Blanking packet used in bllp region,1=Null packet used in bllp region
	1560, //host_vactive  ??
	0x0,   //host_vc
	0x1,
	0x0,
	0x9,
	0x3c,
	0xd,
	0xd,
	0x10,  //host_pll_cn
	0xea,  //host_pll_cm 20
	0x0    //host_pll_co
	};



U32 peri_cfg_data[37]={
	0x3,   //periph_lanes
	0x0,   //cfg_vc  
	0x0,   //dis_vc_check
	0x0,	//ecc error
	0x0,    //hrx timer
	0x0,    //ltx timer
	0x0,    //bta timer
	0x0,    //tx length err
	0x0,   //bta err
	0x0,   //dis_rlpdt crc
	0x1,   //periph_dis_eotp
	0x1,   //periph_clr_status
	0x7,
	0x7 };

/**********************************************************/
U8 cfg_data0[] = {0xB9,0x83,0x11,0x2A};
U8 cfg_data1[] = {0xB1,0x08,0x27,0x27,0x80,0x80,0x52,0x4A,0xCC};
U8 cfg_data2[] = {0xB2,0x25,0x02,0x00,0x90,0x24,0x00,0x0F,0x1E,0xE9,0x11,0x10,0x00,0x15,0xA0,0x07};
U8 cfg_data3[] = {0xD2,0x2C,0x2C};
U8 cfg_data4[] = {0xB4,0x0A,0xC0,0x0A,0xC0,0x0A,0xC0,0x0A,0xC0,0x0A,0xC0,0x0A,0xC0,0x00,0xFF,0x00,0xFF,0x0A,0x00,0x03,0x04,0x00,0x32,0x05,0x06,0x0A,0x00,0x32};
U8 cfg_data5[] = {0xB6,0x7B,0x7B,0xE3};
U8 cfg_data6[] = {0xBD,0x00};
U8 cfg_data7[] = {0xC1,0x01};
U8 cfg_data8[] = {0xBD,0x01};
U8 cfg_data9[] = {0xC1,0xFF,0xFA,0xF6,0xF2,0xEE,0xEA,0xE6,0xDD,0xD9,0xD5,0xD1,0xCD,0xC9,0xC4,0xC0,0xBC,0xB8,0xB3,0xAF,0xA7,0x9E,0x96,0x8E,0x86,0x7E,0x76,0x6E,0x66,0x5E,0x56,0x4E,0x47,0x40,0x38,0x30,0x28,0x21,0x1A,0x12,0x0A,0x07,0x05,0x03,0x01,0x00,0x29,0x03,0xEE,0x3F,0x79,0x90,0x14,0x61,0x6B,0x4B,0x32,0x00};
U8 cfg_data10[] = {0xBD,0x02};
U8 cfg_data11[] = {0xC1,0xFF,0xFA,0xF6,0xF2,0xEE,0xEA,0xE6,0xDD,0xD9,0xD5,0xD1,0xCD,0xC9,0xC4,0xC0,0xBC,0xB8,0xB3,0xAF,0xA7,0x9E,0x96,0x8E,0x86,0x7E,0x76,0x6E,0x66,0x5E,0x56,0x4E,0x47,0x40,0x38,0x30,0x28,0x21,0x1A,0x12,0x0A,0x07,0x05,0x03,0x01,0x00,0x29,0x03,0xEE,0x3F,0x79,0x90,0x14,0x61,0x6B,0x4B,0x32,0x00};
U8 cfg_data12[] = {0xBD,0x03};
U8 cfg_data13[] = {0xC1,0xFF,0xFA,0xF6,0xF2,0xEE,0xEA,0xE6,0xDD,0xD9,0xD5,0xD1,0xCD,0xC9,0xC4,0xC0,0xBC,0xB8,0xB3,0xAF,0xA7,0x9E,0x96,0x8E,0x86,0x7E,0x76,0x6E,0x66,0x5E,0x56,0x4E,0x47,0x40,0x38,0x30,0x28,0x21,0x1A,0x12,0x0A,0x07,0x05,0x03,0x01,0x00,0x29,0x03,0xEE,0x3F,0x79,0x90,0x14,0x61,0x6B,0x4B,0x32,0x00};
U8 cfg_data14[] = {0xBD,0x00};
U8 cfg_data15[] = {0xCC,0x08};
U8 cfg_data16[] = {0xD3,0xC0,0x00,0x00,0x00,0x00,0x01,0x00,0x06,0x00,0x03,0x03,0x00,0x07,0x10,0x10,0x10,0x10,0x32,0x10,0x10,0x00,0x10,0x32,0x10,0x10,0x00,0x10,0x32,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
U8 cfg_data17[] = {0xBD,0x00};
U8 cfg_data18[] = {0xD5,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0xC0,0xC0,0x31,0x31,0x30,0x30,0x2F,0x2F,0x37,0x37,0x36,0x36,0x35,0x35,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x02,0x03,0x00,0x01,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x20,0x21};
U8 cfg_data19[] = {0xD6,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x40,0x40,0x31,0x31,0x30,0x30,0x2F,0x2F,0x37,0x37,0x36,0x36,0x35,0x35,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x01,0x00,0x03,0x02,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x18,0x21,0x20};
U8 cfg_data20[] = {0xD8,0xAA,0xAA,0xBF,0xAB,0xAA,0xAA,0xAA,0xAA,0xBF,0xAB,0xAA,0xAA,0xAA,0xAA,0xAA,0xAA,0xAA,0xAA,0xAA,0xAA,0xAA,0xAA,0xAA,0xAA};
U8 cfg_data21[] = {0xBD,0x01};
U8 cfg_data22[] = {0xD8,0xAA,0xAF,0xEA,0xAA,0xEA,0xAA,0xAA,0xAF,0xEA,0xAA,0xEA,0xAA,0xAA,0xAF,0xEA,0xAA,0xEA,0xAA,0xAA,0xAF,0xEA,0xAA,0xEA,0xAA};
U8 cfg_data23[] = {0xBD,0x02};
U8 cfg_data24[] = {0xD8,0xAA,0xAF,0xEA,0xAA,0xEA,0xAA,0xAA,0xAF,0xEA,0xAA,0xEA,0xAA};
U8 cfg_data25[] = {0xBD,0x03};
U8 cfg_data26[] = {0xD8,0xAA,0xAA,0xBF,0xAA,0xAA,0xAA,0xAA,0xAA,0xBF,0xAA,0xAA,0xAA,0xAA,0xAF,0xEA,0xAA,0xFF,0xFF,0xAA,0xAF,0xEA,0xAA,0xFF,0xFF};
U8 cfg_data27[] = {0xBD,0x00};
U8 cfg_data28[] = {0xE7,0x0E,0x0E,0x1E,0x65,0x1D,0x65,0x00,0x4A,0x28,0x02,0x00,0x00,0x02,0x02,0x02,0x05,0x14,0x14,0x32,0xB9,0x23,0xB9,0x08,0x03,0x29,0x01};
U8 cfg_data29[] = {0xBD,0x01};
U8 cfg_data30[] = {0xE7,0x02,0x00,0xA5,0x01,0xAA,0x0D,0x8B,0x0E,0x02,0x02};
U8 cfg_data31[] = {0xBD,0x02};
U8 cfg_data32[] = {0xE7,0x00,0x00,0x08,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x04,0x00,0x00,0x00,0x00,0x02,0x00};
U8 cfg_data33[] = {0xBD,0x00};
U8 cfg_data34[] = {0xE9,0xC3};
U8 cfg_data35[] = {0xCB,0xD1,0xD3};
U8 cfg_data36[] = {0xE9,0x3F};
U8 cfg_data37[] = {0xBD,0x02};
U8 cfg_data38[] = {0xB4,0x00,0x92,0x12,0x11,0x88,0x12,0x12,0x00,0x53};
U8 cfg_data39[] = {0xBD,0x00};
U8 cfg_data40[] = {0xC7,0x70,0x00,0x04,0xE0,0x33,0x00};
U8 cfg_data41[] = {0x35,0x00};

/***************************720*1560*******************************/
U8 cfg_data42[] = {0xB9,0x83,0x11,0x2A};
U8 cfg_data43[] = {0xBD,0x01};
U8 cfg_data44[] = {0xDD,0x87,0x0F,0x02,0x04,0x58,0x20,0x9D,0x90,0x24,0x08,0x09,0x18,0x27,0x40,0x68,0xA9};
U8 cfg_data45[] = {0xBD,0x03};
U8 cfg_data46[] = {0xB2,0x02,0xD0,0x06,0x18};
U8 cfg_data47[] = {0xBD,0x00};
U8 cfg_data48[] = {0xE9,0xC3};
U8 cfg_data49[] = {0xCB,0x82,0xB2};
U8 cfg_data50[] = {0xE9,0x3F};
U8 cfg_data51[] = {0xCF,0xFF};
/**********************************************************/
U8 cmd05_cfg_0x11[]={0x11,0x00};
U8 cmd05_cfg_0x29[]={0x29,0x00};
/**********************************************************/	
U8 cmd05_cfg_0x28[]={0x28,0x00};
U8 cmd05_cfg_0x10[]={0x10,0x00};
/**********************************************************/
//**********************************************************************************//

//8051 to tx mipi apb
U32 xdata host_num_lanes 	_at_ 0x8000;
U32 xdata host_noctn_clk 	_at_ 0x8004;
U32 xdata host_t_pre 		_at_ 0x8008;
U32 xdata host_t_post		_at_ 0x800c;
U32 xdata host_tx_gap		_at_ 0x8010;
U32 xdata host_auto_eotp 	_at_ 0x8014;
U32 xdata host_ext_cmd		_at_ 0x8018;
U32 xdata host_hstx_timer	_at_ 0x801c;
U32 xdata host_lpdt_timer	_at_ 0x8020;
U32 xdata host_bta_timer 	_at_ 0x8024;
U32 xdata host_twakeup		_at_ 0x8028;
U32 xdata host_status_ro 	_at_ 0x802c;
U32 xdata host_error_ro		_at_ 0x8030;
U32 xdata host_line_size 	_at_ 0x8200;
U32 xdata host_fifo_level	_at_ 0x8204;
U32 xdata host_color_code	_at_ 0x8208;
U32 xdata host_rbg_fmt		_at_ 0x820c;
U32 xdata host_vs_pol		_at_ 0x8210;
U32 xdata host_hs_pol		_at_ 0x8214;
U32 xdata host_video_mode	_at_ 0x8218;
U32 xdata host_hfp			_at_ 0x821c;
U32 xdata host_hbp			_at_ 0x8220;
U32 xdata host_hsa			_at_ 0x8224;
U32 xdata host_en_mult_pkts	_at_ 0x8228;
U32 xdata host_vbp			_at_ 0x822c;
U32 xdata host_vfp			_at_ 0x8230;
U32 xdata host_bllp_mode 	_at_ 0x8234;
U32 xdata host_en_null_pkt	_at_ 0x8238;
U32 xdata host_vactive		_at_ 0x823c;
U32 xdata host_vc			_at_ 0x8240;
U32 xdata host_phy_d_pre 	_at_ 0x8300;
U32 xdata host_phy_clk_pre	_at_ 0x8304;
U32 xdata host_phy_d_zero	_at_ 0x8308;
U32 xdata host_phy_clk_zero	_at_ 0x830c;
U32 xdata host_phy_d_trail	_at_ 0x8310;
U32 xdata host_phy_clk_trail	_at_ 0x8314;
U32 xdata host_pll_cn		_at_ 0x8318;
U32 xdata host_pll_cm		_at_ 0x831c;
U32 xdata host_pll_co		_at_ 0x8320;

//8051 to rx mipi apb
U32 xdata periph_lanes				_at_ 0x8400;
U32 xdata periph_vc					_at_ 0x8404;
U32 xdata periph_vc_check			_at_ 0x8408;
U32 xdata periph_ecc_err				_at_ 0x840c;
U32 xdata periph_hrx					_at_ 0x8410;
U32 xdata periph_ltx					_at_ 0x8414;
U32 xdata periph_bta					_at_ 0x8418;
U32 xdata periph_crc_err				_at_ 0x841c;
U32 xdata periph_bta_err				_at_ 0x8420;
U32 xdata periph_dis_rlpdt			_at_ 0x8424;
U32 xdata periph_dis_eotp			_at_ 0x8428;
U32 xdata periph_clr_status			_at_ 0x842c;
U32 xdata periph_m_settle			_at_ 0x8680;
U32 xdata periph_mc_settle			_at_ 0x8684;

//extended fp reg	 
volatile U8 xdata cmd_fifo			_at_ 0x8800;  
volatile U8 xdata mipi_sel			_at_ 0x8801;
volatile U8 xdata func_set			_at_ 0x8802;

volatile U8 xdata bta_fifo			_at_ 0x880f;

/**********************************************************/
static void mipi_cfg_set( U32 *reg, U32 dat)
{	
	*reg= dat;
	return;
}

static void mydelay(U32 delay)
{
	U32 i;
	for(i=0;i<delay;i++);
}

static void delay_1ms(U32 delay)
{
	U32 i,j;
	for(i=0;i<delay;i++)
		for(j=0;j<167;j++);
}

static void fiforst(void)
{
	U8 tmp;
	tmp=func_set;
	tmp= tmp&0xfb;
	func_set = tmp;
	mydelay(10);
	tmp= tmp |0x4;
	func_set=tmp;
	mydelay(10);
}

static void fifowr(void)
{
	U8 tmp;
	tmp=func_set;
	tmp= tmp&0xf7;
	func_set = tmp;
	tmp= tmp |0x8;
	func_set=tmp;
}

static void datawr(void)
{
	U8 tmp;
	tmp=func_set;
	tmp= tmp&0xEF;
	func_set = tmp;
	tmp= tmp |0x10;
	func_set=tmp;
}
 
static void hs_enter(U8 flag)
{
	U8 tmp;
	tmp=func_set;
	if(flag)
	{
		tmp= tmp|0x2;		
	}
	else
	{
		tmp= tmp&0xfd;
	}
			func_set = tmp;
}

void mipi_lp_cmd_send(U8 cmd_set,UINT16 cmd_length , U8 *buf , U8 long_cmd)
{
  U16 u16j;
	U8 tmp;
	hs_enter(0);
	fiforst();

	cmd_fifo=cmd_set;
	if(long_cmd)
	{
			tmp=cmd_length&0xff;
      cmd_fifo = tmp;
			tmp=(cmd_length>>8)&0xff;
			cmd_fifo = tmp;
			cmd_fifo = 0x00; //extra 1 byte
			for(u16j=0;u16j<cmd_length;u16j++)
			{
				cmd_fifo = *(buf+u16j);
			}
			cmd_fifo = 0x00;
			cmd_fifo = 0x00;
			cmd_fifo = 0x00;
			cmd_fifo = 0x00;
					
			pstart=1;
			mydelay(1);
			while(!packet_finish);
			pstart=0;	
	
	}
	else
	{				
        cmd_fifo=*(buf);
				if(cmd_length==2)
					cmd_fifo=*(buf+1);
				cmd_fifo = 0x00;
				cmd_fifo = 0x00;

				pstart=1;
				mydelay(1);
				while(!packet_finish);
				pstart=0;		
	}
}

void mipi_lp_cmd_send2(U8 cmd_set,UINT16 cmd_length , U8 *buf , U8 long_cmd)
{
  U16 u16j;
	U8 tmp;
	U8 lens;
	hs_enter(0);
	fiforst();

	cmd_fifo=cmd_set;
	lens=cmd_length-1;
	if(long_cmd)
	{
			tmp=lens&0xff;
      cmd_fifo = tmp;
			tmp=(lens>>8)&0xff;
			cmd_fifo = tmp;
			cmd_fifo = 0x00; //extra 1 byte

			for(u16j=0;u16j<lens;u16j++)
			{
				cmd_fifo = *(buf+u16j+1);
			}
			cmd_fifo = 0x00;
			cmd_fifo = 0x00;
			cmd_fifo = 0x00;
			cmd_fifo = 0x00;
					
			pstart=1;
			mydelay(1);
			while(!packet_finish);
			pstart=0;	
	    
	}
	else
	{				
        cmd_fifo=*(buf+1);
				if(lens==2)
					cmd_fifo=*(buf+1+1);
				cmd_fifo = 0x00;
				cmd_fifo = 0x00;

				pstart=1;
				mydelay(1);
				while(!packet_finish);
				pstart=0;		    
	}
}

static void panel_init(void)
{
		U8 cmd_set=0x29; //0x39
		
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data0)/sizeof(U8),cfg_data0,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data1)/sizeof(U8),cfg_data1,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data2)/sizeof(U8),cfg_data2,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data3)/sizeof(U8),cfg_data3,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data4)/sizeof(U8),cfg_data4,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data5)/sizeof(U8),cfg_data5,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data6)/sizeof(U8),cfg_data6,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data7)/sizeof(U8),cfg_data7,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data8)/sizeof(U8),cfg_data8,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data9)/sizeof(U8),cfg_data9,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data10)/sizeof(U8),cfg_data10,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data11)/sizeof(U8),cfg_data11,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data12)/sizeof(U8),cfg_data12,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data13)/sizeof(U8),cfg_data13,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data14)/sizeof(U8),cfg_data14,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data15)/sizeof(U8),cfg_data15,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data16)/sizeof(U8),cfg_data16,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data17)/sizeof(U8),cfg_data17,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data18)/sizeof(U8),cfg_data18,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data19)/sizeof(U8),cfg_data19,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data20)/sizeof(U8),cfg_data20,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data21)/sizeof(U8),cfg_data21,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data22)/sizeof(U8),cfg_data22,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data23)/sizeof(U8),cfg_data23,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data24)/sizeof(U8),cfg_data24,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data25)/sizeof(U8),cfg_data25,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data26)/sizeof(U8),cfg_data26,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data27)/sizeof(U8),cfg_data27,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data28)/sizeof(U8),cfg_data28,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data29)/sizeof(U8),cfg_data29,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data30)/sizeof(U8),cfg_data30,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data31)/sizeof(U8),cfg_data31,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data32)/sizeof(U8),cfg_data32,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data33)/sizeof(U8),cfg_data33,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data34)/sizeof(U8),cfg_data34,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data35)/sizeof(U8),cfg_data35,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data36)/sizeof(U8),cfg_data36,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data37)/sizeof(U8),cfg_data37,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data38)/sizeof(U8),cfg_data38,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data39)/sizeof(U8),cfg_data39,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data40)/sizeof(U8),cfg_data40,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data41)/sizeof(U8),cfg_data41,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data42)/sizeof(U8),cfg_data42,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data43)/sizeof(U8),cfg_data43,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data44)/sizeof(U8),cfg_data44,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data45)/sizeof(U8),cfg_data45,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data46)/sizeof(U8),cfg_data46,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data47)/sizeof(U8),cfg_data47,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data48)/sizeof(U8),cfg_data48,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data49)/sizeof(U8),cfg_data49,1);
		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data50)/sizeof(U8),cfg_data50,1);
//		mipi_lp_cmd_send(cmd_set,sizeof(cfg_data51)/sizeof(U8),cfg_data51,1);
/**********************************************************************************/

    mipi_lp_cmd_send(0x05,sizeof(cmd05_cfg_0x11)/sizeof(U8),cmd05_cfg_0x11,0);
    mipi_lp_cmd_send(0x05,sizeof(cmd05_cfg_0x29)/sizeof(U8),cmd05_cfg_0x29,0);	
/********************************************************************************/
}

static U8 pll_param_save(void)
{
	U8 tmp[6];
	
	tmp[0]=0xa5;
	tmp[1]=0xa5;

	tmp[2]=clk_phase_step&0xff;
	tmp[3]=(clk_phase_step>>8);

	tmp[4]=rd_phase_step&0xff;
	tmp[5]=(rd_phase_step>>8);
	SpiFlashWrEnable();
	SpiFlashErase(SE, param_base_spi);
	SpiFlashWrEnable();
	SpiFlashWr(tmp,param_base_spi,6);
	return 0;
}

static U8 pll_param_load(void)
{
	U8 tmp[6];

	SpiFlashRD(param_base_spi,6);

	if((spirdbuf[0]==0xa5)&&(spirdbuf[1]==0xa5))
		{
			clk_phase_step=(spirdbuf[3]<<8)+spirdbuf[2];
			rd_phase_step=(spirdbuf[5]<<8)+spirdbuf[4];
			return 0;
		}
	else
		return 1;
}

static void mipi_rx_bta_set(void)
{
	U8 i;
	U8 num;
	U8 tmp;
	U32 bta_set[36]=
	{ 0x31c, 		0x36090,
	0x31c, 		0x36090,
	0x131c, 	0x0B036090, 0x828C0CF0, 0x0E110A14 , 0x1000A112 , 0x00BD0101 ,
	0x121c, 	0x32410000, 0x53325A57 , 0x50473139 ,0x3046444A ,0x00003838,
	0x061c,     0xEA560390, 0x00000062,
	0x2e1c, 	0x4D285301,0x52049000,0x00000008,0x41210000,0x02624141,0x43838262,0x03A303A3,0x03030303,0x03030303,0x00000003,0x00000000,0x00001900,
	0x9c21, 
	0x8021,
	0x0021,
	0xb021
	};
	
	num=36;
	
	fiforst();
	for(i=0;i<num;i++)
	{
		tmp=bta_set[i]&0xff;
		bta_fifo = tmp;
		tmp=(bta_set[i]>>8)&0xff;
		bta_fifo = tmp;
		tmp=(bta_set[i]>>16)&0xff;
		bta_fifo = tmp;
		tmp=(bta_set[i]>>24)&0xff;
		bta_fifo = tmp;
	}

}


/*****************************************************/
static U32 GET_CO_FACTOR(void){
	
	U8 co_factor = 0;
	U8 i;
	for(i<=0;i<4;i++)
	{
		if(((16*OSC)/(3*DSI_HOST_MIPI_RATE))<=TX_PLL_CO[i])
		{
			co_factor = i;
			break;
		}	
	}
	return (U32)co_factor;
}


static U32 GET_CN_FACTOR(void){
	return TX_PLL_CN[2];     //CN = 3   ????
}

static U32 GET_CM_FACTOR(void){
	U16 cm_factor;
	
	cm_factor = (U16)((3*DSI_HOST_MIPI_RATE*TX_PLL_CO[GET_CO_FACTOR()])/OSC);
	return TX_PLL_CM[cm_factor-16];
}
/****************************************************************/


static void mipi_init(void)
{
	mipi_sel=1;  //mipi2
periph_lanes		=peri_cfg_data[0] 	;
periph_vc			=peri_cfg_data[1]	;
periph_vc_check		=peri_cfg_data[2]	;
periph_ecc_err		=peri_cfg_data[3]	;
periph_hrx			=peri_cfg_data[4]	;
periph_ltx			=peri_cfg_data[5]	;
periph_bta			=peri_cfg_data[6]	;
periph_crc_err		=peri_cfg_data[7]	;
periph_bta_err		=peri_cfg_data[8]	;
periph_dis_rlpdt	=peri_cfg_data[9]	;
periph_dis_eotp		=peri_cfg_data[10]	;
periph_clr_status	=peri_cfg_data[11]	;
periph_m_settle		=peri_cfg_data[12]	;
periph_mc_settle	=peri_cfg_data[13]	; 

mipi_sel=0;  //mipi1
host_num_lanes 	   = cfg_data[0];
host_noctn_clk 	   = cfg_data[1];
host_t_pre   	   = cfg_data[2];
host_t_post  	   = cfg_data[3];
host_tx_gap  	   = cfg_data[4];
host_auto_eotp     = cfg_data[5];
host_ext_cmd 	   = cfg_data[6];
host_hstx_timer    = cfg_data[7];
host_lpdt_timer    = cfg_data[8];
host_bta_timer 	   = cfg_data[9];
host_twakeup  	   = cfg_data[10];
host_line_size 	   = cfg_data[11];
host_fifo_level    = cfg_data[12];
host_color_code    = cfg_data[13];
host_rbg_fmt 	   = cfg_data[14];
host_vs_pol  	   = cfg_data[15];
host_hs_pol  	   = cfg_data[16];
host_video_mode    = cfg_data[17];
host_hfp  	 	   = cfg_data[18];
host_hbp  	 	   = cfg_data[19];
host_hsa  	 	   = cfg_data[20];
host_en_mult_pkts  = cfg_data[21];
host_vbp   		   = cfg_data[22];
host_vfp   		   = cfg_data[23];
host_bllp_mode     = cfg_data[24];
host_en_null_pkt   = cfg_data[25];
host_vactive   	   = cfg_data[26];
host_vc   		   = cfg_data[27];
host_phy_d_pre     = cfg_data[28];
host_phy_clk_pre   = cfg_data[29];
host_phy_d_zero    = cfg_data[30];
host_phy_clk_zero  = cfg_data[31];
host_phy_d_trail   = cfg_data[32];
host_phy_clk_trail = cfg_data[33];
//host_pll_cn   	   = cfg_data[34];
//host_pll_cm   	   = cfg_data[35];
//host_pll_co   	   = cfg_data[36];

host_pll_cn   	   = GET_CN_FACTOR();
host_pll_cm   	   = GET_CM_FACTOR();
host_pll_co   	   = GET_CO_FACTOR();
}

void main(void)

{	
	U16 i,b;
	U8 flag;
	U8 power_on;
	
	CKCON=0x55;
	D_PAGESEL= 0x04;

	test0=0;
		test1=0;

	EAL=0;
	EX0=0;
	EX1=0;
	P1=0;
	pstart=0;
	reset_dpi_n=0;
	rstn_mipi=0;
	panel_rst=0;
	power_on = 0;
	

	//mipi_rx_bta_set();
	

		mipi_init();
    func_set=1;
    rstn_mipi=1;//mipi dsi controller reset
		mydelay(10);
    fiforst();
    mydelay(10);
		test1=1;  
	 SpiInit(4,master);
		//CKCON=0x0;	
	if(0)
	 {
	 psram_training_new();
   pll_param_save();
		 
	 }
	 
    if(1) {
        flag=pll_param_load();
        if(flag)
        {
            psram_training_new();
            pll_param_save();
        }
        else
        {
            for(b=0;b<clk_phase_step;b++)
                pll_adjust(psram_clk_channel,phase_dir_forward);
        
            for(b=0;b<rd_phase_step;b++)
                pll_adjust(psram_rd_channel,phase_dir_forward);
        
            psram_init(psram_cfg0_set,psram_cfg1_set);	
        }
    }
		panel_rst=1;
    while(!tx_dphy_rdy);//wait mipi pll lock




		while(1){
			if(power_on == 0)
			{
				if(lcd_rstn == 1)
				{
					panel_init();
					reset_dpi_n=1;
					power_on = 1;
				}
			}
			else
			{
				if(lcd_rstn == 0)
				{
					mipi_lp_cmd_send(0x05,sizeof(cmd05_cfg_0x28)/sizeof(U8),cmd05_cfg_0x28,0);
					mipi_lp_cmd_send(0x05,sizeof(cmd05_cfg_0x10)/sizeof(U8),cmd05_cfg_0x10,0);
					reset_dpi_n=0;
					power_on = 0;
				}
			}
		};


}


