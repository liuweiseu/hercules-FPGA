#ifndef spi_flash
#define spi_flash

#define param_base_spi 0x3c000  // 60 sector : 4K per sector //0x7f000

 void SpiFlashWrEnable(void);
 void SpiFlashWrDis(void);
 U8 SpiFlashWr (U8 *buf,U32 addr,U32 length);
 U8 SpiFlashRD(U32 addr,U32 length);
 U8 SpiFlashErase(U8 mode,U32 addr);
void SpiFlashReadID(void);

#endif