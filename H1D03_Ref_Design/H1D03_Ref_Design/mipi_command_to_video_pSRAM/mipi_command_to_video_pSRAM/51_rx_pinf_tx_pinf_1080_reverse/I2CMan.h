// *******************************************************************
//
//  Copyright (c) 2006  Evatronix SA
//
// *******************************************************************
//
//  Please review the terms of the license agreement before using
//  this file. If you are not an authorized user, please destroy this
//  source code file and notify Evatronix SA immediately that you
//  inadvertently received an unauthorized copy.
//
// *******************************************************************
//  Project name        : R8051XC I2C SPI  library
//  Project description : Board interfaces service
//  File name           : $RCSfile: I2CMan.h,v $
//  Design_Version      : $Name$
//  File version        : $Revision: 2.0 $
//  File contents       : Header file for I2C module
//  Design Engineer     : Piotr Sroka, Krzysztof Fijak
//  Last modification   : $Date: 2007/08/24 10:34:58 $
// *******************************************************************

/*!
    \file $RCSfile: I2CMan.h,v $
    \version $Revision: 2.0 $
*/

#ifndef I2CMAN_H
#define I2CMAN_H

#include "BasicDataType.h"

//********************************************************************
//  Defines section

/* Status and errors code */
///transfer ended No Errors
#define I2C_OK                          0
///Interface I2C is busy
#define I2C_BUSY                        1
///Bus error
#define I2C_BUS_ERROR                   2
///No data in block
#define I2C_NO_DATA                     3
///No ACK on data
#define I2C_NO_ACK_ON_DATA              4
///No ACK on address
#define I2C_NO_ACK_ON_ADDRESS           5
///Device not present
#define I2C_DEVICE_NON_PRESENT          6
///Arbitration lost
#define I2C_ARBITRATION_LOST            7
///Time out occurred
#define I2C_TIME_OUT                    8
///Slave mode error
#define I2C_SLAVE_ERROR                 9
///Some errors appear during initialization I2C
#define I2C_INIT_ERROR                  10
///Problem with close I2C
#define I2C_CLOSE_ERROR                 11
///Not all data has been transfered
#define I2C_INCOMPLETE_TRANSFER         12
///Bufer for data overflow
#define I2C_BUFFER_OVERFLOV_ERR         13
///Transfer is running
#define I2C_DATA_TRANSFER               255


#define GENERATE_STOP           0x54
#define RELEASE_BUS_ACK         0x44
#define RELEASE_BUS_NOACK       0x40
#define GENERATE_START          0x64


/*I2C bitrate settings*/
#define CLOCK_DIVIDE_BY_256     0x0
#define CLOCK_DIVIDE_BY_224     0x1
#define CLOCK_DIVIDE_BY_192     0x2
#define CLOCK_DIVIDE_BY_160     0x3
#define CLOCK_DIVIDE_BY_960     0x80
#define CLOCK_DIVIDE_BY_120     0x81
#define CLOCK_DIVIDE_BY_60      0x82
#define CLOCK_DIVIDE_BY_8       0x83
#define CLOCK_BITRATE_MASK      0x83

/*I2C ioctl commands*/
///ioctl command - set bitrate
#define SET_BITRATE             1
///ioctl command - select interface
#define SELECT_I2C_INTERFACE    2

/*I2C other errors*/
///ioctl errors - wrong command
#define WRONG_COMMAND           20
///ioctl errors - wrong bitrate value
#define WRONG_BITRATE           21
///ioctl errors - wrong interface number
#define WRONG_INTERFACE_NUMBER  22

///slave address of interface 1
#define SLAVE_ADDRESS_1 0x40
///buffer size for recived data in slave mode
#define I2C_BUFFER_SIZE 16

extern unsigned char slave_busy;
extern unsigned char slave_mun;
extern unsigned char tucRecSlaveBuffer[8];

// ************************************************************
//  Function prototype section

/**************************************************************/
/*!
 * \fn unsigned char I2CMasterWrite( unsigned char SlaveAdd,
 *                                   unsigned char *Buffer,
 *                                   unsigned char ToWrite );
 *
 * \brief       Function write data from buffer to I2C master device
 * \param       SlaveAdd address of I2C slave device
 * \param       Buffer data to write
 * \param       ToWrite number of bytes to write
 * \return      Function return 0 if everything is ok or if some
 *              errors appears return error number
*/
/***************************************************************/
unsigned char I2CMasterWrite( unsigned char SlaveAdd,
                              unsigned char *Buffer,
                              unsigned char ToWrite );

/**************************************************************/
/*!
 * \fn unsigned char I2CMasterRead( unsigned char SlaveAdd,
 *                                  unsigned char *Buffer,
 *                                  unsigned char ToRead );
 *
 * \brief       Function read data to buffer from I2C slave device
 * \param       SlaveAdd address of I2C slave device
 * \param       buffer for read data
 * \param       ToRead number of bytes to read
 * \return      Function return 0 if everything is ok or if some
 *              errors appears return error number
*/
/***************************************************************/
unsigned char I2CMasterRead( unsigned char SlaveAdd,
                             unsigned char *Buffer,
                             unsigned char ToRead );

 unsigned char I2CSlaveWrite( unsigned char *Buffer,
							  unsigned char ToWrite);

unsigned char I2CSlaveRead(     unsigned char *Buffer);

/**************************************************************/
/*!
 * \fn unsigned char I2CIoctl( unsigned char Cmd,
 *                             void *Data,
 *                             unsigned char *SizeOfData );
 *
 * \brief       Input output control function, depends on command
 *              function makes some operations
 * \param       Cmd command to execute
 * \param       Data some data
 * \param       SizeOfData size of *Data
 * \return      Function return 0 if everything is ok or if some
 *              errors appears return error number
*/
/***************************************************************/
unsigned char I2CIoctl( unsigned char BITRATE);

/**************************************************************/
/*!
 * \fn unsigned char I2COpen(void)
 *
 * \brief       Function enable I2C interface and I2C interrupt
 * \return      Function return 0 if everything is ok or if some
 *              errors appears return error number
*/
/***************************************************************/
unsigned char I2COpen(void);

/**************************************************************/
/*!
 * \fn unsigned char I2CClose(void)
 *
 * \brief       Function disable I2C interface and I2C interrupt
 * \return      Function return 0 if everything is ok or if some
 *              errors appears return error number
*/
/***************************************************************/
unsigned char I2CClose(void);

void I2CFinish(void);

#endif
