#include "CME-M5.h"
#include "BasicDataType.h"

/*
assign reset_dpi_n=port0o[0];
assign pstart = port0o[1];
assign rstn_mipi = port0o[2];

assign port0i[3]=packet_finish;
assign port0i[4]=tx_dphy_rdy;
*/

#define reset_dpi_n P0_0
#define pstart P0_1
#define rstn_mipi P0_2
#define rstn_lcd P0_7
#define phone_rst  P0_5

#define packet_finish P0_3
#define tx_dphy_rdy  P0_4

#define DSI_PERIPH_X_RESOLUTION						1080
#define DSI_PERIPH_Y_RESOLUTION						2220



/****************************************************************************************/
/****************************************************************************************/
/******************************MIPI HOST CONFIG******************************************/
#define DSI_HOST_NUM_LANES 							4
#define DSI_HOST_X_RESOLUTION						1080
#define DSI_HOST_Y_RESOLUTION						2160
#define DSI_HOST_HFP										10
#define DSI_HOST_HBP										10
#define DSI_HOST_HSA										2   //HS=VS
#define DSI_HOST_VBP										10
#define DSI_HOST_VFP										20
#define DSI_HOST_VSA										2    //HS=VS
#define DSI_HOST_VC											0
#define DSI_HOST_MIPI_RATE             1100    //853      //mipi rate MHZ    



#define DSI_HOST_NONCONTINUOUS_CLK 			1
#define DSI_HOST_T_PRE									100
#define DSI_HOST_T_POST									33
#define DSI_HOST_TX_GAP									30
#define DSI_HOST_AUTOINSERT_EOTP				1
#define DSI_HOST_EXTRA_CMDS_AFTER_EOTP  0
#define DSI_HOST_HTX_TO_COUNT						0
#define DSI_HOST_LRX_H_TO_COUNT					0
#define DSI_HOST_BTA_H_TO_COUNT					0
#define DSI_HOST_TWAKEUP								200
#define DSI_HOST_PIXEL_PAYLOAD_SIZE			DSI_HOST_X_RESOLUTION    //
#define DSI_HOST_PIXEL_FIFO_SEND_LEVEL	240
#define DSI_HOST_INTERFACE_COLOR_CODING	5   //DPI:0:16bit RGB cfg1 1:16bit RGB cfg2 2:18bit RGB cfg3 //3:18bit RGB cfg1 4:18bit RGB cfg2 //5:24bit RGB
#define DSI_HOST_PIXEL_FORMAT						3		//Sets the DSI packet type of the pixels 0= RGB 16-bit 1= RGB 18-bit 2= RGB 18-bit loosely packed 3= RGB 24-bit
#define DSI_HOST_VSYNC_POLARITY					1		//Sets polarity of dpi_vsync input, 0 active low, 1 active high
#define DSI_HOST_HSYNC_POLARITY					1		//Sets Polarity of dpi_hsync input, 0 active low, 1 active high
#define DSI_HOST_VIDEO_MODE							0		//0=Non-Burst mode with Sync Pulses,1=Non-Burst mode with Sync Events,2=Burst mode

#define DSI_HOST_ENABLE_MULT_PKTS				0

#define DSI_HOST_BLLP_MODE							1		//0=blanking packets are sent during BLLP periods,1=LP mode is used for BLLP periods		
#define DSI_HOST_USE_NULL_PKT_BLLP			0		//0=Blanking packet used in bllp region,1=Null packet used in bllp region
#define DSI_HOST_VACTIVE								DSI_HOST_Y_RESOLUTION             //

#define DSI_HOST_DPHY_HS_DATA_PRE				1
#define DSI_HOST_DPHY_HS_CLOCK_PRE			0
#define DSI_HOST_DPHY_HS_DATA_ZERO			25
#define DSI_HOST_DPHY_HS_CLOCK_ZERO			60
#define DSI_HOST_DPHY_HS_CLOCK_TRAIL		13
#define DSI_HOST_DPHY_HS_CLOCK_TRAIL		13

#define OSC          80                  //FPGA??OSC,??80MHZ
/*******************************************************************************/
/*******************************************************************************/
/******************************MIPI PERIPHERAL CONFIG***************************/
#define	DSI_PERIPHERAL_NUM_LANES															4
#define	DSI_PERIPHERAL_VC																			0
#define	DSI_PERIPHERAL_DISABLE_VC_CHECK												0
#define	DSI_PERIPHERAL_REPRESSED_AFTER_UNRECOVER_ECC_ERR			0
#define	DSI_PERIPHERAL_HRX_TO_COUNT														0
#define	DSI_PERIPHERAL_LTX_P_TO_COUNT													0
#define	DSI_PERIPHERAL_BTA_P_TO_COUNT													0
#define	DSI_PERIPHERAL_CRC_ERR_ASSERTS_INVALID_TX_LENGTH_ERR	0
#define	DSI_PERIPHERAL_ALLOW_READBACK_AFTER_MISSING_BTA_ERR		0
#define	DSI_PERIPHERAL_DISABLE_RLPDT_CRC											0
#define	DSI_PERIPHERAL_DISABLE_EOTP														0
#define	DSI_PERIPHERAL_ENABLE_AUTOCLEAR_STATUS_REG						1
#define	DSI_PERIPHERAL_THS_SETTLE															7
#define	DSI_PERIPHERAL_TCLK_SETTLE														16
/*******************************************************************************/

U8 cfg_data0[  2]  = {0xB0,0x00};
U8 cfg_data1[  4]  = {0xB3,0x00,0x00,0x06};
U8 cfg_data2[  2]  = {0xB4,0x00};
U8 cfg_data3[  6]  = {0xB6,0x33,0xDB,0x80,0x02,0x00};
U8 cfg_data4[  8]  = {0xB8,0x57,0x3D,0x19,0x1E,0x0A,0x50,0x50};
U8 cfg_data5[  8]  = {0xB9,0x6F,0x3D,0x28,0x3C,0x14,0xC8,0xC8};
U8 cfg_data6[  8]  = {0xBA,0xB5,0x33,0x41,0x64,0x23,0xA0,0xA0};
U8 cfg_data7[  3]  = {0xBB,0x14,0x14};
U8 cfg_data8[  3]  = {0xBC,0x37,0x32};
U8 cfg_data9[  3]  = {0xBD,0x64,0x32};
U8 cfg_data10[ 2]  = {0xBE,0x04};

/************************************************************/
U8 cfg_data_2a[5]  = {0x2A,0x00,0x00,0x04,0x37}; 
U8 cfg_data_2b[5]  = {0x2B,0x00,0x00,0x08,0x6F};
U8 cmd05_cfg_0x11[2]={0x11,0x00};
U8 cmd05_cfg_0x29[2]={0x29,0x00};
/************************************************************/







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

volatile U8 xdata wd_rdy			_at_ 0x8803;
volatile U8 xdata wd_2a_dats_l			_at_ 0x8804;
volatile U8 xdata wd_2a_dats_h			_at_ 0x8805;
volatile U8 xdata wd_2a_date_l			_at_ 0x8806;
volatile U8 xdata wd_2a_date_h			_at_ 0x8807;
volatile U8 xdata wd_2b_dats_l			_at_ 0x8808;
volatile U8 xdata wd_2b_dats_h			_at_ 0x8809;
volatile U8 xdata wd_2b_date_l			_at_ 0x880a;
volatile U8 xdata wd_2b_date_h			_at_ 0x880b;
volatile U8 xdata busy							_at_ 0x880c;
/****************************ID******************************/

/************************************************************/
/************************ESD CHECK***************************/

/***********************************************************/
/************************TX DATA****************************/

/**********************************************************/
static void mipi_cfg_set( U32 *reg, U32 dat)
{	
	*reg= dat;
	return;
}

//static void pinf_cfg_set( U8 *reg, U8 dat)
//{	
//    *reg= dat;
//    return;
//}

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
	mydelay(1);
	tmp= tmp |0x4;
	func_set=tmp;
	mydelay(1);
}

static void fifowr(void)
{
	U8 tmp;
	tmp=func_set;
	tmp= tmp&0xf7;
	func_set = tmp;
	//mydelay(1);
	tmp= tmp |0x8;
	func_set=tmp;
}

static void datawr(void)
{
	U8 tmp;
	tmp=func_set;
	tmp= tmp&0xEF;
	func_set = tmp;
	//mydelay(1);
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
  UINT16 u16i,u16j;
	U8 tmp;
//	hs_enter(0);
	fiforst();
	//cmd=cmd_set;
	cmd_fifo=cmd_set;
	if(long_cmd)
	{
			tmp=cmd_length&0xff;
			//dnum_l=tmp;
            cmd_fifo = tmp;
			tmp=(cmd_length>>8)&0xff;
			//dnum_h=tmp;
            cmd_fifo = tmp;
            cmd_fifo = 0x00; //extra 1 byte
			//datawr();
		
			//fiforst();
			for(u16j=0;u16j<cmd_length;u16j++)
				{
						//dset= *(buf+u16j);
                        cmd_fifo = *(buf+u16j);
						//fifowr();
				}
                cmd_fifo = 0x00;
                cmd_fifo = 0x00;
                cmd_fifo = 0x00;
                cmd_fifo = 0x00;
					//fifowr();
					//fifowr();
					//fifowr();
					//fifowr();
					
			pstart=1;
			while(!packet_finish);
			pstart=0;	
	        //fiforst();
	}
	else
	{				
				//dnum_l=*(buf);
                cmd_fifo=*(buf);
				if(cmd_length==2)
					//dnum_h=*(buf+1);
                    cmd_fifo=*(buf+1);
                cmd_fifo = 0x00;
                cmd_fifo = 0x00;
				//datawr();
				pstart=1;
				while(!packet_finish);
				pstart=0;		
	      //fiforst();
	}

 
}

void cmd_fill_frame(void)
{
  UINT16 u16i,u16j;
  UINT16 len;
	U8 tmp;
	U8 flag=0;
	U8 r,g,b;
	UINT16 data_len;
	hs_enter(1);
	fiforst();

	
	data_len = DSI_HOST_X_RESOLUTION*3;
    len = data_len + 1;
    for(u16i=0;u16i<DSI_HOST_Y_RESOLUTION;u16i+=1)  //2line
    {
        if(u16i<540)
        {
            r=0;
            b=0xff;
            g=0;
        }
        else if(u16i<1080)
        {
            r=0;
            b=0;
            g=0xff;
        }
        else if(u16i<1620)
        {
            r=0xff;
            b=0xff;
            g=0xff;
        }
        else
        {
            r=0xff;
            b=0;
            g=0;
        }
    
        fiforst();
        cmd_fifo=0x39;
        tmp=len&0xff;
        cmd_fifo=tmp;
        tmp=(len>>8)&0xff;
        cmd_fifo=tmp;
        cmd_fifo=0x00;

        //fiforst();
        if(flag)
            //dset=0x3c;
            cmd_fifo=0x3c;
        else
        {
            //dset=0x2c;
            //cmd_fifo=0x2c;
            cmd_fifo=0x2c;
            flag=1;
        }
        //fifowr(); //write cmd

        for(u16j=0;u16j<data_len;u16j+=3)
        {

            //dset= r;
            //fifowr();
            //dset= g;
            //fifowr();
            //dset= b;
            //fifowr();
					if(u16j<1000)
					{
            cmd_fifo = r;
            cmd_fifo = g;
            cmd_fifo = b;
					}
					else if(u16j<2222)
					{
            cmd_fifo = g;
            cmd_fifo = b;
            cmd_fifo = r;
					}
					else 
					{
            cmd_fifo = b;
            cmd_fifo = r;
            cmd_fifo = g;
					}
        }
        cmd_fifo = 0x00;
        cmd_fifo = 0x00;
        cmd_fifo = 0x00;
        cmd_fifo = 0x00;
        //fifowr();
        //fifowr();
        //fifowr();
        //fifowr();

        pstart=1;
        while(!packet_finish);
        pstart=0;
				fiforst();

        //mydelay(1); // 15us delay
    }
}


static void panel_init(void)
{
/**************************************************/
    mipi_lp_cmd_send(0x29,  2,cfg_data0 , 1);
    mipi_lp_cmd_send(0x29,  4,cfg_data1 , 1);
    mipi_lp_cmd_send(0x29,  2,cfg_data2 , 1);
    mipi_lp_cmd_send(0x29,  6,cfg_data3 , 1);
    mipi_lp_cmd_send(0x29,  8,cfg_data4 , 1);
    mipi_lp_cmd_send(0x29,  8,cfg_data5 , 1);
		
/**********************************************************************************/
    mipi_lp_cmd_send(0x39,  5,cfg_data_2a , 1);
    mipi_lp_cmd_send(0x39,  5,cfg_data_2b , 1);
    mipi_lp_cmd_send(0x05,sizeof(cmd05_cfg_0x11)/sizeof(U8),cmd05_cfg_0x11,0);
    mipi_lp_cmd_send(0x05,sizeof(cmd05_cfg_0x29)/sizeof(U8),cmd05_cfg_0x29,0);	
/********************************************************************************/
		
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

/****************************************************************/
void wd_2a_set(U8 dats_h,U8 dats_l,U8 date_h,U8 date_l)
{
	U16 dat_s,dat_e;
	dat_s = (((U16)dats_h)<<8)+(U16)dats_l;
	dat_e = (((U16)date_h)<<8)+(U16)date_l;
	if((DSI_PERIPH_X_RESOLUTION-DSI_HOST_X_RESOLUTION)==0)
	{
		cfg_data_2a[1] = dats_h;
		cfg_data_2a[2] = dats_l;
		cfg_data_2a[3] = date_h;
		cfg_data_2a[4] = date_l;
	}
	else if((DSI_PERIPH_X_RESOLUTION-DSI_HOST_X_RESOLUTION)>0)
	{
		dat_s = dat_s - dat_s/(DSI_PERIPH_X_RESOLUTION/(DSI_PERIPH_X_RESOLUTION-DSI_HOST_X_RESOLUTION));
		dat_e = dat_e - dat_e/(DSI_PERIPH_X_RESOLUTION/(DSI_PERIPH_X_RESOLUTION-DSI_HOST_X_RESOLUTION));
		
		cfg_data_2a[1] = (U8)(dat_s>>8);
		cfg_data_2a[2] = (U8)dat_s;
		cfg_data_2a[3] = (U8)(dat_e>>8);
		cfg_data_2a[4] = (U8)dat_e;
	}
	else if((DSI_PERIPH_X_RESOLUTION-DSI_HOST_X_RESOLUTION)<0)
	{
		dat_s = dat_s + dat_s/(DSI_HOST_X_RESOLUTION/(DSI_HOST_X_RESOLUTION-DSI_PERIPH_X_RESOLUTION));
		dat_e = dat_e + dat_e/(DSI_HOST_X_RESOLUTION/(DSI_HOST_X_RESOLUTION-DSI_PERIPH_X_RESOLUTION));
		
		cfg_data_2a[1] = (U8)(dat_s>>8);
		cfg_data_2a[2] = (U8)dat_s;
		cfg_data_2a[3] = (U8)(dat_e>>8);
		cfg_data_2a[4] = (U8)dat_e;
	}
		
}




void wd_2b_set(U8 dats_h,U8 dats_l,U8 date_h,U8 date_l)
{
	U16 dat_s,dat_e;
	dat_s = (((U16)dats_h)<<8)+(U16)dats_l;
	dat_e = (((U16)date_h)<<8)+(U16)date_l;
	if((DSI_PERIPH_Y_RESOLUTION-DSI_HOST_Y_RESOLUTION)==0)
	{
		cfg_data_2b[1] = dats_h;
		cfg_data_2b[2] = dats_l;
		cfg_data_2b[3] = date_h;
		cfg_data_2b[4] = date_l;
	}
	else if((DSI_PERIPH_Y_RESOLUTION-DSI_HOST_Y_RESOLUTION)>0)
	{
		dat_s = dat_s - dat_s/(DSI_PERIPH_Y_RESOLUTION/(DSI_PERIPH_Y_RESOLUTION-DSI_HOST_Y_RESOLUTION));
		dat_e = dat_e - dat_e/(DSI_PERIPH_Y_RESOLUTION/(DSI_PERIPH_Y_RESOLUTION-DSI_HOST_Y_RESOLUTION));
		
		cfg_data_2b[1] = (U8)(dat_s>>8);
		cfg_data_2b[2] = (U8)dat_s;
		cfg_data_2b[3] = (U8)(dat_e>>8);
		cfg_data_2b[4] = (U8)dat_e;
	}
	else if((DSI_PERIPH_Y_RESOLUTION-DSI_HOST_Y_RESOLUTION)<0)
	{
		dat_s = dat_s + dat_s/(DSI_HOST_Y_RESOLUTION/(DSI_HOST_Y_RESOLUTION-DSI_PERIPH_Y_RESOLUTION));
		dat_e = dat_e + dat_e/(DSI_HOST_Y_RESOLUTION/(DSI_HOST_Y_RESOLUTION-DSI_PERIPH_Y_RESOLUTION));
		
		cfg_data_2b[1] = (U8)(dat_s>>8);
		cfg_data_2b[2] = (U8)dat_s;
		cfg_data_2b[3] = (U8)(dat_e>>8);
		cfg_data_2b[4] = (U8)dat_e;
	}
		
}
/***************************************************************/

void main(void)

{	
		U32 a;
		U8 b=0;
		U8 cmd_d[8];
		UINT16 u16i;
		CKCON=0x55;
		D_PAGESEL= 0x04;

		busy=0;
		wd_rdy=0;
		EAL=1;
		EX0=0;
		EX1=0;
		P1=0;
		P0_5 = 1;
		pstart=0;
		reset_dpi_n=0;
		rstn_mipi=0;
		//rstn_lcd=1;
		rstn_lcd=0;
		mipi_sel=0;	//mipi2
		mipi_cfg_set( &host_num_lanes 	  	,DSI_HOST_NUM_LANES-1);
		mipi_cfg_set( &host_noctn_clk 	  	,DSI_HOST_NONCONTINUOUS_CLK);
		mipi_cfg_set( &host_t_pre   	  		,DSI_HOST_T_PRE);
		mipi_cfg_set( &host_t_post  	  		,DSI_HOST_T_POST);
		mipi_cfg_set( &host_tx_gap  	  		,DSI_HOST_TX_GAP);
		mipi_cfg_set( &host_auto_eotp  	  	,DSI_HOST_AUTOINSERT_EOTP);
		mipi_cfg_set( &host_ext_cmd 	  		,DSI_HOST_EXTRA_CMDS_AFTER_EOTP);
		mipi_cfg_set( &host_hstx_timer    	,DSI_HOST_HTX_TO_COUNT);
		mipi_cfg_set( &host_lpdt_timer    	,DSI_HOST_LRX_H_TO_COUNT);
		mipi_cfg_set( &host_bta_timer 	  	,DSI_HOST_BTA_H_TO_COUNT);
		mipi_cfg_set( &host_twakeup  	  		,DSI_HOST_TWAKEUP);
		mipi_cfg_set( &host_line_size 	  	,DSI_HOST_PIXEL_PAYLOAD_SIZE);
		mipi_cfg_set( &host_fifo_level    	,DSI_HOST_PIXEL_FIFO_SEND_LEVEL);
		mipi_cfg_set( &host_color_code    	,DSI_HOST_INTERFACE_COLOR_CODING);
		mipi_cfg_set( &host_rbg_fmt 	  		,DSI_HOST_PIXEL_FORMAT);
		mipi_cfg_set( &host_vs_pol  	  		,DSI_HOST_VSYNC_POLARITY);
		mipi_cfg_set( &host_hs_pol  	  		,DSI_HOST_HSYNC_POLARITY);
		mipi_cfg_set( &host_video_mode    	,DSI_HOST_VIDEO_MODE);
		mipi_cfg_set( &host_hfp  	 	  			,DSI_HOST_HFP);
		mipi_cfg_set( &host_hbp  	 	  			,DSI_HOST_HBP);
		mipi_cfg_set( &host_hsa  	 	  			,DSI_HOST_HSA);
		mipi_cfg_set( &host_en_mult_pkts  	,DSI_HOST_ENABLE_MULT_PKTS);
		mipi_cfg_set( &host_vbp   		  		,DSI_HOST_VBP);
		mipi_cfg_set( &host_vfp   		  		,DSI_HOST_VFP);
		mipi_cfg_set( &host_bllp_mode  	  	,DSI_HOST_BLLP_MODE);
		mipi_cfg_set( &host_en_null_pkt   	,DSI_HOST_USE_NULL_PKT_BLLP);
		mipi_cfg_set( &host_vactive   	  	,DSI_HOST_VACTIVE);
		mipi_cfg_set( &host_vc   		  			,DSI_HOST_VC);
		mipi_cfg_set( &host_phy_d_pre     	,DSI_HOST_DPHY_HS_DATA_PRE);
		mipi_cfg_set( &host_phy_clk_pre   	,DSI_HOST_DPHY_HS_CLOCK_PRE);
		mipi_cfg_set( &host_phy_d_zero    	,DSI_HOST_DPHY_HS_DATA_ZERO);
		mipi_cfg_set( &host_phy_clk_zero  	,DSI_HOST_DPHY_HS_CLOCK_ZERO);
		mipi_cfg_set( &host_phy_d_trail   	,DSI_HOST_DPHY_HS_CLOCK_TRAIL);
		mipi_cfg_set( &host_phy_clk_trail 	,DSI_HOST_DPHY_HS_CLOCK_TRAIL);
		mipi_cfg_set( &host_pll_cn   	  		,GET_CN_FACTOR());
		mipi_cfg_set( &host_pll_cm   	  		,GET_CM_FACTOR());
		mipi_cfg_set( &host_pll_co   	  		,GET_CO_FACTOR());

		mipi_sel=1;  //mipi1
		mipi_cfg_set(  &periph_lanes			,DSI_PERIPHERAL_NUM_LANES-1 	);
		mipi_cfg_set(  &periph_vc					,DSI_PERIPHERAL_VC	);
		mipi_cfg_set(  &periph_vc_check		,DSI_PERIPHERAL_DISABLE_VC_CHECK	);
		mipi_cfg_set(  &periph_ecc_err		,DSI_PERIPHERAL_REPRESSED_AFTER_UNRECOVER_ECC_ERR	);
		mipi_cfg_set(  &periph_hrx				,DSI_PERIPHERAL_HRX_TO_COUNT	);
		mipi_cfg_set(  &periph_ltx				,DSI_PERIPHERAL_LTX_P_TO_COUNT	);
		mipi_cfg_set(  &periph_bta				,DSI_PERIPHERAL_BTA_P_TO_COUNT	);
		mipi_cfg_set(  &periph_crc_err		,DSI_PERIPHERAL_CRC_ERR_ASSERTS_INVALID_TX_LENGTH_ERR	);
		mipi_cfg_set(  &periph_bta_err		,DSI_PERIPHERAL_ALLOW_READBACK_AFTER_MISSING_BTA_ERR	);
		mipi_cfg_set(  &periph_dis_rlpdt	,DSI_PERIPHERAL_DISABLE_RLPDT_CRC	);
		mipi_cfg_set(  &periph_dis_eotp		,DSI_PERIPHERAL_DISABLE_EOTP	);
		mipi_cfg_set(  &periph_clr_status	,DSI_PERIPHERAL_ENABLE_AUTOCLEAR_STATUS_REG	);
		mipi_cfg_set(  &periph_m_settle		,DSI_PERIPHERAL_THS_SETTLE	);
		mipi_cfg_set(  &periph_mc_settle	,DSI_PERIPHERAL_TCLK_SETTLE	); 

		func_set=1;
		fiforst();
		rstn_mipi=1;//mipi dsi controller reset
		while(!tx_dphy_rdy);//wait mipi pll lock
		delay_1ms(1);
		panel_init();
		delay_1ms(1);
		hs_enter(0);


		//cmd_fill_frame();
		reset_dpi_n=1;	//start to recive vediodata
		while(1){
			if(wd_rdy==1)
			{
					busy = 1;
					reset_dpi_n=0;
					wd_2a_set(wd_2a_dats_h,wd_2a_dats_l,wd_2a_date_h,wd_2a_date_l);
					wd_2b_set(wd_2b_dats_h,wd_2b_dats_l,wd_2b_date_h,wd_2b_date_l);

					mydelay(1);
					mipi_lp_cmd_send(0x39,5,cfg_data_2a,1);
					mipi_lp_cmd_send(0x39,5,cfg_data_2b,1);
					mydelay(1);
					busy = 0;
					while(wd_rdy!=0);
					reset_dpi_n=1;
			}
		}

}


















