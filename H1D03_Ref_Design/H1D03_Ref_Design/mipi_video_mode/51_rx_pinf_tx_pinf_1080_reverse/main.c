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

#define packet_finish P0_3
#define tx_dphy_rdy  P0_4
#define phone_rst  P0_5

//8051 to tx mipi apb
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
	720, //host_line_size 宽度
	0xb9,  //host_fifo_level
	0x5,   //host_color_code 5= RGB 24-bit
	0x3,   //host_rbg_fmt 0= RGB 16-bit,1= RGB 18-bit,2= RGB 18-bit loosely packed,3= RGB 24-bit
	0x1,   //host_vs_pol  Sets polarity of dpi_vsync input, 0 active low, 1 active high
	0x1,   //host_hs_pol  Sets Polarity of dpi_hsync input, 0 active low, 1 active high
	2,   //host_video_mode 0=Non-Burst mode with Sync Pulses,1=Non-Burst mode with Sync Events,2=Burst mode
	16,  //host_hfp  宽前肩
	16,  //host_hbp  宽后肩
	4,   //host_hsa  宽同步
	0x0,   //host_en_mult_pkts 0=Video Line is sent in a single packet,1=Video Line is sent in two packets
	12,   //host_vbp  高后肩
	88,  //host_vfp  高前肩
	0x1,   //host_bllp_mode 0=blanking packets are sent during BLLP periods,1=LP mode is used for BLLP periods
	0x0,   //host_en_null_pkt 0=Blanking packet used in bllp region,1=Null packet used in bllp region
	1624, //host_vactive  高度
	0x0,   //host_vc
	0x1,
	0x1,
	0x0F,
	0x02,
	0x6,
	0x6,
	0x10,  //host_pll_cn
	//0xc0,  //host_pll_cm
	0xcc, //500Mbps
	0x1    //host_pll_co
	};

//8051 to rx mipi apb	
U32 peri_cfg_data[37]={
	0x3,   //periph_lanes
	0x0,   
	0x0,
	0x0,
	0x0,
	0x0,
	0x0,
	0x0,
	0x0,
	0x0,
	0x1,   //periph_dis_eotp
	0x0,
	0x7,
	0x10 };




U8 cmd_cfg_data0[2]={0x11,0x00};
U8 cmd_cfg_data1[2]={0x29,0x00};

U8 cmd_cfg_data2[2]={0x53,0x24};
U8 cmd_cfg_data3[2]={0x51,0xff};
U8 cmd_cfg_data4[2]={0x35,0x00};

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
//volatile U8 xdata dnum			_at_ 0x8800;   
//volatile U8 xdata dset_l			_at_ 0x8801;   
//volatile U8 xdata dset_h			_at_ 0x8802;   
//volatile U8 xdata cmd			_at_ 0x8803;  
//volatile U8 xdata mipi_sel			_at_ 0x8804;

volatile U8 xdata cmd_fifo			_at_ 0x8800;  
volatile U8 xdata mipi_sel			_at_ 0x8804;
volatile U8 xdata func_set			_at_ 0x8805;
// func[0] control sel; 1= enable
// func[1]  hs mode sel; 1= hs mode
// func[2]  pfifo rstn; low active



static void mipi_cfg_set( U32 *reg, U32 dat)
{	
	*reg= dat;
	return;
}

//static void pinf_cfg_set( U8 *reg, U8 dat)
//{	
//	*reg= dat;
//	return;
//}

static void mydelay(U32 delay)
{
	U32 i;
	for(i=0;i<delay;i++);
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

//void mipi_lp_cmd_send(U8 cmd_set,UINT16 cmd_length , UINT16 num , U8 *buf)
//{
//  UINT16 u16i;
//	U8 tmp;
//	
//	cmd=cmd_set;
//  dnum=cmd_length;
//  for(u16i=0;u16i<num;u16i+=2)
//  {
//			tmp= *(buf+u16i+1);
//		  dset_l= tmp;
//		  tmp= *(buf+u16i);
//		  dset_h= tmp;
//			pstart=1;
//			while(!packet_finish);
//			pstart=0;
//		mydelay(1);
//  }
//}


//void mipi_lp_cmd_send(U8 cmd_set,UINT16 cmd_length ,  UINT16 num ,U8 *buf , U8 long_cmd)
//{
//  UINT16 u16i,u16j;
//    U8 tmp;
//    hs_enter(0);//lp mode
		
//    for(u16i=0;u16i<num;u16i+=cmd_length)
//    {
//    fiforst();//fifo_clr	
//    cmd_fifo=cmd_set;
//    if(long_cmd)
//    {
//            tmp=cmd_length&0xff;			
//      cmd_fifo = tmp;
		
//            tmp=(cmd_length>>8)&0xff;
//      cmd_fifo = tmp;
		
//      cmd_fifo = 0x00; //extra 1 byte ecc
		
//          for(u16j=cmd_length;u16j>0;u16j--)
//                {					
//                cmd_fifo = *(buf+u16i+u16j-1);
//                }
					
//      cmd_fifo = 0x00;//fifo 8bit write 32bit read,extra zero
//      cmd_fifo = 0x00;
//      cmd_fifo = 0x00;
//      cmd_fifo = 0x00;
				
                    
//            pstart=1;
//            while(!packet_finish);
//            pstart=0;	
//    }
//    else
//    {				
		
//    cmd_fifo=*(buf+u16i+1);
//        cmd_fifo=*(buf+u16i);
//    cmd_fifo = 0x00;//ecc
//    cmd_fifo = 0x00;//fifo 8bit write 32bit read,extra zero
				
//        pstart=1;
//        while(!packet_finish);
//        pstart=0;		
//    }
//mydelay(1);
//}
	
//}

void mipi_lp_cmd_send(U8 cmd_set,UINT16 cmd_length , U8 *buf , U8 long_cmd)
{
  UINT16 u16j;//u16i,
	U8 tmp;
	hs_enter(0);
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
			fiforst();
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
				fiforst();
	}

 
}


static void panel_init(void)
{
    //mipi_lp_cmd_send(0x39,4, cmd29_cfg_data0 , 1);
    //mipi_lp_cmd_send(0x39,3, cmd29_cfg_data1 , 1);
    //mipi_lp_cmd_send(0x39,3, cmd29_cfg_data2 , 1);
    //mipi_lp_cmd_send(0x39,7, cmd29_cfg_data3 , 1);
    //mipi_lp_cmd_send(0x39,5, cmd29_cfg_data4 , 1);
    //mipi_lp_cmd_send(0x39,4, cmd29_cfg_data5 , 1);
    //mipi_lp_cmd_send(0x39,3, cmd29_cfg_data6 , 1);
    //mipi_lp_cmd_send(0x39,4, cmd29_cfg_data7 , 1);

    //mipi_lp_cmd_send(0x39,23, cmd29_cfg_data8 , 1);
    //mipi_lp_cmd_send(0x39,17, cmd29_cfg_data9 , 1);
    //mipi_lp_cmd_send(0x39,13, cmd29_cfg_data10 , 1);
    //mipi_lp_cmd_send(0x39,4, cmd29_cfg_data11 , 1);

    //mipi_lp_cmd_send(0x39,48, cmd29_cfg_data12 , 1);
    //mipi_lp_cmd_send(0x39,48, cmd29_cfg_data13 , 1);
    //mipi_lp_cmd_send(0x39,48, cmd29_cfg_data14 , 1);
    //mipi_lp_cmd_send(0x39,22, cmd29_cfg_data15 , 1);
    //mipi_lp_cmd_send(0x39,22, cmd29_cfg_data16 , 1);
    //mipi_lp_cmd_send(0x39,22, cmd29_cfg_data17 , 1);
    //mipi_lp_cmd_send(0x39,22, cmd29_cfg_data18 , 1);
    //mipi_lp_cmd_send(0x39,33, cmd29_cfg_data19 , 1);
    //mipi_lp_cmd_send(0x39,34, cmd29_cfg_data20 , 1);

    //mipi_lp_cmd_send(0x39,3, cmd29_cfg_data21 , 1);
    ////mipi_lp_cmd_send(0x15,2, cmd29_cfg_data22 , 0);
    //mipi_lp_cmd_send(0x39,5, cmd29_cfg_data23 , 1);
    //mipi_lp_cmd_send(0x15,2, cmd29_cfg_data24 , 0);
    ////mipi_lp_cmd_send(0x15,2, cmd29_cfg_data25 , 0);
    ////mipi_lp_cmd_send(0x15,2, cmd29_cfg_data26 , 0);

    //mipi_lp_cmd_send(0x39,3, cmd29_cfg_data27 , 1);
    //mipi_lp_cmd_send(0x39,4, cmd29_cfg_data28 , 1);
    //mipi_lp_cmd_send(0x39,9, cmd29_cfg_data29 , 1);

    //mipi_lp_cmd_send(0x15,2, cmd29_cfg_data30 , 0);
    //mipi_lp_cmd_send(0x15,2, cmd29_cfg_data31 , 0);
    //mipi_lp_cmd_send(0x15,2, cmd29_cfg_data32 , 0);
    //mipi_lp_cmd_send(0x15,2, cmd29_cfg_data33 , 0);

    //mipi_lp_cmd_send(0x39,2, cmd29_cfg_data30 , 1);
    //mipi_lp_cmd_send(0x39,2, cmd29_cfg_data31 , 1);
    //mipi_lp_cmd_send(0x39,2, cmd29_cfg_data32 , 1);
    //mipi_lp_cmd_send(0x39,2, cmd29_cfg_data33 , 1);
}


void main(void)

{	bit prst;
//	U32 a;
	U8 b=0;
//	U8 cmd_d[8];
//	UINT16 u16i;
	CKCON=0x55;
	//CKCON=0x11;
  D_PAGESEL= 0x04;

	EAL=1;
	EX0=0;
	EX1=0;
	P1=0;
	pstart=0;
	reset_dpi_n=0;
	rstn_mipi=0;
  rstn_lcd=0;
	
 mipi_sel=1;	//mipi2, Tx
 mipi_cfg_set( &host_num_lanes 	  ,cfg_data[0]);
 mipi_cfg_set( &host_noctn_clk 	  ,cfg_data[1]);
 mipi_cfg_set( &host_t_pre   	  ,cfg_data[2]);
 mipi_cfg_set( &host_t_post  	  ,cfg_data[3]);
 mipi_cfg_set( &host_tx_gap  	  ,cfg_data[4]);
 mipi_cfg_set( &host_auto_eotp  	  ,cfg_data[5]);
 mipi_cfg_set( &host_ext_cmd 	  ,cfg_data[6]);
 mipi_cfg_set( &host_hstx_timer    ,cfg_data[7]);
 mipi_cfg_set( &host_lpdt_timer    ,cfg_data[8]);
 mipi_cfg_set( &host_bta_timer 	  ,cfg_data[9]);
 mipi_cfg_set( &host_twakeup  	  ,cfg_data[10]);
 mipi_cfg_set( &host_line_size 	  ,cfg_data[11]);
 mipi_cfg_set( &host_fifo_level    ,cfg_data[12]);
 mipi_cfg_set( &host_color_code    ,cfg_data[13]);
 mipi_cfg_set( &host_rbg_fmt 	  ,cfg_data[14]);
 mipi_cfg_set( &host_vs_pol  	  ,cfg_data[15]);
 mipi_cfg_set( &host_hs_pol  	  ,cfg_data[16]);
 mipi_cfg_set( &host_video_mode    ,cfg_data[17]);
 mipi_cfg_set( &host_hfp  	 	  ,cfg_data[18]);
 mipi_cfg_set( &host_hbp  	 	  ,cfg_data[19]);
 mipi_cfg_set( &host_hsa  	 	  ,cfg_data[20]);
 mipi_cfg_set( &host_en_mult_pkts  ,cfg_data[21]);
 mipi_cfg_set( &host_vbp   		  ,cfg_data[22]);
 mipi_cfg_set( &host_vfp   		  ,cfg_data[23]);
 mipi_cfg_set( &host_bllp_mode  	  ,cfg_data[24]);
 mipi_cfg_set( &host_en_null_pkt   ,cfg_data[25]);
 mipi_cfg_set( &host_vactive   	  ,cfg_data[26]);
 mipi_cfg_set( &host_vc   		  ,cfg_data[27]);
 mipi_cfg_set( &host_phy_d_pre     ,cfg_data[28]);
 mipi_cfg_set( &host_phy_clk_pre   ,cfg_data[29]);
 mipi_cfg_set( &host_phy_d_zero    ,cfg_data[30]);
 mipi_cfg_set( &host_phy_clk_zero  ,cfg_data[31]);
 mipi_cfg_set( &host_phy_d_trail   ,cfg_data[32]);
 mipi_cfg_set( &host_phy_clk_trail ,cfg_data[33]);
 mipi_cfg_set( &host_pll_cn   	  ,cfg_data[34]);
 mipi_cfg_set( &host_pll_cm   	  ,cfg_data[35]);
 mipi_cfg_set( &host_pll_co   	  ,cfg_data[36]);

mipi_sel=0;  //mipi1, Rx
mipi_cfg_set(  &periph_lanes			,peri_cfg_data[0] 	);
mipi_cfg_set(  &periph_vc			,peri_cfg_data[1]	);
mipi_cfg_set(  &periph_vc_check		,peri_cfg_data[2]	);
mipi_cfg_set(  &periph_ecc_err		,peri_cfg_data[3]	);
mipi_cfg_set(  &periph_hrx			,peri_cfg_data[4]	);
mipi_cfg_set(  &periph_ltx			,peri_cfg_data[5]	);
mipi_cfg_set(  &periph_bta			,peri_cfg_data[6]	);
mipi_cfg_set(  &periph_crc_err		,peri_cfg_data[7]	);
mipi_cfg_set(  &periph_bta_err		,peri_cfg_data[8]	);
mipi_cfg_set(  &periph_dis_rlpdt		,peri_cfg_data[9]	);
mipi_cfg_set(  &periph_dis_eotp		,peri_cfg_data[10]	);
mipi_cfg_set(  &periph_clr_status	,peri_cfg_data[11]	);
mipi_cfg_set(  &periph_m_settle		,peri_cfg_data[12]	);
mipi_cfg_set(  &periph_mc_settle		,peri_cfg_data[13]	); 

func_set=1;//func[0] control sel; 1= enable
//mydelay(100);
	
//	rstn_mipi=1;//mipi dsi controller reset
//	while(!tx_dphy_rdy);//wait mipi pll lock

	rstn_mipi=1;//mipi dsi controller reset
	while(!tx_dphy_rdy);//wait mipi pll lock
    
	mydelay(3500);
	mydelay(2500);
	

	rstn_mipi=0;//mipi dsi controller reset
	while(!phone_rst); //wait phone's reset
//	rstn_lcd=1;
	rstn_mipi=1;//mipi dsi controller reset
	while(!tx_dphy_rdy);//wait mipi pll lock


//panel initial use cmd29
    mydelay(1000);//180ms
//    panel_init();
    mipi_lp_cmd_send(0x29,2,cmd_cfg_data2,1);
	mydelay(500);//180ms
	
    mipi_lp_cmd_send(0x29,2,cmd_cfg_data3,1);
	mydelay(500);//180ms
	
//	mipi_lp_cmd_send(0x05,2,cmd_cfg_data4,0);
//	mydelay(500);//180ms

	mipi_lp_cmd_send(0x05,2,cmd_cfg_data0,0);
	mydelay(500);//180ms
	
	//cmd_d[0]=0x29;
    //mipi_lp_cmd_send(0x5, 0x1 ,cmd_d,0);
    mipi_lp_cmd_send(0x05,2,cmd_cfg_data1,0);

	
	//cmd_d[1]=0x11;
	//mipi_lp_cmd_send(0x29, 2 ,2,cmd_d,1);
	
	//mydelay(10000);//180ms
	

	reset_dpi_n=1;	//start to recive vediodata
	
	prst = phone_rst;

	 while(1){
/*		 P2_0 = 0;
		 mydelay(1000);//180ms
		 P2_0 = 1;
		 mydelay(1000);//180ms
		 */
		 if(phone_rst){
			 if(prst){
			 }else{

				reset_dpi_n=0;
				mydelay(500);//180ms
				mipi_lp_cmd_send(0x05,2,cmd_cfg_data0,0);
				mydelay(500);//180ms
				mipi_lp_cmd_send(0x05,2,cmd_cfg_data1,0);
				mydelay(500);//180ms
				reset_dpi_n=1;
				
			 }
			 prst = 1;
		 }else{
			 prst = 0;
		 }
	 }
}


