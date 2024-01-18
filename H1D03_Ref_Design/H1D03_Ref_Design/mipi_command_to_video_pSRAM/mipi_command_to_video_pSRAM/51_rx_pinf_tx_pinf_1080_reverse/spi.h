#ifndef SPI_FUNC
#define SPI_FUNC


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

#define spi_rdint 1
#define spi_rdnoint 0

#define Calsave 0x7f000

extern U8 spirddata;
extern U8 spitxlen;
extern U8 spirdlen;
extern U8 spi_mode;
extern U8 spirdbuf[10];
extern U8 spitxbuf[10];
extern U8 spird_overflow;
extern U8 spitx_overflow;


extern void SpiInit(U8 speed,U8 mode );
extern U8 SpiTrans(U8 *buf,U32 length);
extern U8 SpiRD(U8 *rdcmd,U8 rdcmdlen,U32 length,U8 mode);
extern void SpiSelect (U8 channel);
extern void SpiSlaveRel(void);
 extern void Spi_init_set(U8 flag);
#endif