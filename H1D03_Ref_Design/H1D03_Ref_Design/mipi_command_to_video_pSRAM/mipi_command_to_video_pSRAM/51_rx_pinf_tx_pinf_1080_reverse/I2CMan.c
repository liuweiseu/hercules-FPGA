//*******************************************************************
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
//  Project description :
//  File name           : $RCSfile: I2CMan.c,v $
//  Design_Version      : $Name$
//  File version        : $Revision: 2.0 $
//  File contents       : Code file for I2C module
//  Design Engineer     : Piotr Sroka, Krzysztof Fijak
//  Last modification   : $Date: 2007/08/24 10:35:48 $
// *******************************************************************

/*!
  \file $RCSfile: I2CMan.c,v $
  \version $Revision: 2.0 $
 */


// ******************************************************************
//  Include section
#include <stddef.h>
#include "I2CMan.h"
#include "CME-M5.h"

#define touch_int_out P2_2  //to MB, output

#define test0 P1_4 
#define test1 P1_5 
#define test2 P1_6 
#define test3 P1_7 
// *******************************************************************
///information about last I2C interface error
static data volatile unsigned char ucLastStatus = 0;
/*!
 * \var static volatile _data unsigned char ucCurrDestAddr
 * \brief address of slave I2C device,
 * this address is used during transmission in master mode
 */
static data unsigned char ucCurrDestAddr = 0;
///size of data to read or write
static data volatile unsigned char uiDataCount = 0;

///buffer for data to read or write
static unsigned char *pucBuffer;


///Flag is used to control enabling and disabling I2C interrupts
static unsigned char flag = 1;
static unsigned char Baudrate;

unsigned char slave_busy=0;
unsigned char slave_mun=0;
unsigned char tucRecSlaveBuffer[8];


/*****************************************************************/
//  Code implementation

/*****************************************************************/
///I2C interrupt handler function
void I2CIntHandler_master(void)
{
    unsigned char ucTmp = I2CSTA;

    /********* MASTER ************************/
    switch(ucTmp){
    case 0x00:      // Bus error
        ucLastStatus = I2C_BUS_ERROR;
        I2CCON = (GENERATE_STOP|Baudrate);
        break;

        // (rep) Start condition transmitted
        // Send slave address and R/W
    case 0x08:
    case 0x10:
        I2CDAT = ucCurrDestAddr;
        I2CCON =  (RELEASE_BUS_ACK|Baudrate) ;
        break;

        // SLA+W  transmitted, ACK received
    case 0x18:
        if ( uiDataCount == 0 ){
            ucLastStatus = I2C_OK;
            // transmit stop
            I2CCON = (GENERATE_STOP|Baudrate) ;
        }
        else{
            // transmit data
            I2CDAT = *pucBuffer;
            uiDataCount--;
            pucBuffer++;
            I2CCON = (RELEASE_BUS_ACK|Baudrate) ;
        }
        break;


        // Data transmitted, ACK received
    case 0x28:
        if ( uiDataCount > 0 ){
            // transmit data
            I2CDAT = *pucBuffer;
            uiDataCount--;
            pucBuffer++;
            I2CCON =  (RELEASE_BUS_ACK|Baudrate) ;
        }
        else {
            // transmit  stop
            ucLastStatus = I2C_OK;
            I2CCON =  (GENERATE_STOP|Baudrate);
        }
        break;

        // SLA+W/R transmitted, NOT ACK received
    case 0x20:
    case 0x48:
        ucLastStatus = I2C_NO_ACK_ON_ADDRESS;
        I2CCON =(GENERATE_STOP|Baudrate) ;
        break;

        // DATA transmitted, NOT ACK received
    case 0x30:
        ucLastStatus = I2C_NO_ACK_ON_DATA;
        I2CCON = (GENERATE_STOP|Baudrate);
        break;

        // Arbitration lost in SLA+W or DATA
    case 0x38:
        I2CCON = (GENERATE_START|Baudrate) ; // release bus, set STA
        ucLastStatus = I2C_ARBITRATION_LOST;
        break;

        // SLA+R transmitted, ACK received
    case 0x40:
        if ( uiDataCount > 1 )
            I2CCON =(RELEASE_BUS_ACK|Baudrate) ; // ACK on next byte
        else
            I2CCON = (RELEASE_BUS_NOACK|Baudrate) ; // No ack on next byte
        break;

        // DATA received, ACK has been returned
    case 0x50:
        *pucBuffer = I2CDAT;
        uiDataCount--;
        pucBuffer++;

        if ( uiDataCount  > 1 )
            I2CCON = (RELEASE_BUS_ACK|Baudrate);
        else
            //the next byte is the last one so NO ACK is transmit
            I2CCON = (RELEASE_BUS_NOACK|Baudrate) ;

        break;

        // DATA received, NOT ACK has been returned
    case 0x58:
        *pucBuffer = I2CDAT;
        uiDataCount--;

        if ( uiDataCount != 0 )
            ucLastStatus = I2C_INCOMPLETE_TRANSFER;
        else
            ucLastStatus = I2C_OK;

        I2CCON = (GENERATE_STOP|Baudrate) ;

        break;

    default:
        I2CCON = (RELEASE_BUS_NOACK|Baudrate) ;
        break;
    }
}

/*****************************************************************/

/*****************************************************************/
void I2CIntHandler_slave(void)
{
    unsigned char ucTmp = I2CSTA;

    switch(ucTmp){
   // ****************************** SLAVE MODE *****************************
		//slave rx
        // Own SLA+W or general call address 00
        // has been received
        // ACK has been returned
    case 0x60:      //Slave Rx
    case 0x70:      //Slave Rx
    	slave_busy=1;
        I2CCON = RELEASE_BUS_ACK | Baudrate;
        break;

#if 0
        // Arbitration lost as master
        // Own SLA+W or general call address 00
        // has been received
        // ACK has been returned
    case 0x68:      //Slave Rx
    case 0x78:      //Slave Rx
        I2CCON = RELEASE_BUS_ACK | Baudrate;
        break;
#endif

        // Previously addressed with
        // own SLA+W or general call 
        // data has been received
        // ACK returnd
    case 0x80:      //Slave Rx
    case 0x90:      //Slave Rx
        tucRecSlaveBuffer[slave_mun++] = I2CDAT;
        I2CCON = RELEASE_BUS_ACK | Baudrate;
        break;


    case 0x88:      //Slave Rx
    case 0x98:      //Slave Rx

        tucRecSlaveBuffer[slave_mun++] = I2CDAT;

        ucLastStatus = I2C_OK;

        // set flag to flase to don't enable I2C interrupt
       // flag = 0;
		slave_busy=0;
        I2CCON = RELEASE_BUS_ACK | Baudrate;
        break;


        // A STOP condition or repeated
        // START condition has been
        // received while still addresses as slave
    case 0xA0:      //Slave Rx
        ucLastStatus = I2C_OK;
		slave_busy=0;
        I2CCON = RELEASE_BUS_ACK | Baudrate;
        break;


/*******************************************************************/
		//slave tx
        // Own SLA+R has been
        // received; ACK has been returned
    case 0xA8:      //Slave Tx
//        I2CCON = RELEASE_BUS_ACK | Baudrate;
        // transmit data
		

			if(ucLastStatus == I2C_DATA_TRANSFER )
				{								
					I2CDAT = *pucBuffer;
					pucBuffer++;
					uiDataCount--;
				}
				else
						I2CDAT=0;   

				touch_int_out=1;
        I2CCON = RELEASE_BUS_ACK | Baudrate;
        break;

#if 0
        // Arbitration lost in SLA+R/W as
        // master; own SLA+R has been
        // received; ACK has been returned
    case 0xB0:      //Slave Tx
        I2CCON = RELEASE_BUS_ACK | Baudrate;
        break;
#endif

        // Data byte in SSDAT has been
        // transmitted; NOT ACK has been received
    case 0xB8:      //Slave Tx
        // transmit data
				if(ucLastStatus == I2C_DATA_TRANSFER )
				{										
						I2CDAT = *pucBuffer;
					pucBuffer++;
					uiDataCount--;
				}
				else
						I2CDAT=0;       
        
        I2CCON = RELEASE_BUS_ACK | Baudrate;
        break;

        // Data byte in SSDAT has been
        // transmitted; NOT ACK has been received
    case 0xC0:      //Slave Tx
        if ( uiDataCount == 0 )
            ucLastStatus = I2C_OK;
        else
            ucLastStatus = I2C_INCOMPLETE_TRANSFER;
				I2CCON = RELEASE_BUS_ACK | Baudrate;
        // Last data byte in SSDAT has
        // been transmitted ACK has been received
    case 0xC8:      //Slave Tx
        ucLastStatus = I2C_OK;
        I2CCON = RELEASE_BUS_ACK | Baudrate;
        break;


    default:
        I2CCON = RELEASE_BUS_NOACK | Baudrate;
        break;
    }
}

/*****************************************************************/

/*****************************************************************/

/*!
 * \fn void I2CCommonIntHandler(void)
 * \brief I2C interrupt handler
 */
void I2CCommonIntHandler(void) interrupt 8
{
    //disable I2C interrupt
    IEN1 &= 0xFE;
    //I2CCON &= 0xFB;
    // check which interface generate interrupt
    // and call apriopriate procedure to handle it
    if ( I2CSTA != 0xF8 )
        I2CIntHandler_slave();

        IEN1 |= 0x1;
}

/*****************************************************************/
unsigned char I2CMasterWrite(unsigned char SlaveAdd,
                             unsigned char *Buffer,
                             unsigned char ToWrite)
{
    if ( ToWrite == 0 )
        return 0;
    //set slave address and write flag
    ucCurrDestAddr = SlaveAdd & 0xFE;
    pucBuffer = Buffer;
    uiDataCount = ToWrite;
    ucLastStatus = I2C_DATA_TRANSFER;

    //enable I2C interrupt
    IEN1 |= 0x1;

    // generate START condition
    I2CCON |= GENERATE_START;


    //wait for transfer end
    while ( ucLastStatus == I2C_DATA_TRANSFER );

    return ucLastStatus;
}

/****************************************************************/
unsigned char I2CMasterRead( unsigned char SlaveAdd,
                             unsigned char *Buffer,
                             unsigned char ToRead)
{
    if ( ToRead == 0 )
        return 0;

    // set slave address and read flag
    ucCurrDestAddr = SlaveAdd | 0x1;
    pucBuffer = Buffer;
    uiDataCount = ToRead;

    ucLastStatus = I2C_DATA_TRANSFER;

    //enable I2C interrupt
    IEN1 |= 0x1;

    // generate START condition
    I2CCON =(GENERATE_START|Baudrate);

    // wait for finish transfer
    while ( ucLastStatus == I2C_DATA_TRANSFER );

    return ucLastStatus;
}

 /*****************************************************************/
 unsigned char I2CSlaveWrite( unsigned char *Buffer,
							  unsigned char ToWrite)
 {
	 if ( ToWrite == 0 )
		 return 0;

	 pucBuffer = Buffer;
	 uiDataCount = ToWrite;
	 ucLastStatus = I2C_DATA_TRANSFER;
 
	 //enable I2C interrupt
	 IEN1 |= 0x1;

	 //touch_int_out=0;
	 //wait for transfer end
	 while ( ucLastStatus == I2C_DATA_TRANSFER );

	 return ucLastStatus;
 }

/****************************************************************/
unsigned char I2CSlaveRead(     unsigned char *Buffer)
{
   // tucRecSlaveBuffer = Buffer;
	slave_mun=0;
    uiDataCount = 0;
    ucLastStatus = I2C_DATA_TRANSFER;

    //enable I2C interrupt
    IEN1 |= 0x1;

    // wait for finish transfer
    while ( ucLastStatus == I2C_DATA_TRANSFER );
				
    return slave_mun;
}							 

/****************************************************************/

/*****************************************************************/

unsigned char I2CIoctl( unsigned char BITRATE)
{
    if ( ( ~CLOCK_BITRATE_MASK & BITRATE ) != 0 )
        //wrong bitrate value return error
        return WRONG_BITRATE;
		Baudrate=BITRATE;
    I2CCON &= ~0x83;
    I2CCON |= BITRATE;

  return 0;
}


/*****************************************************************/

void I2CFinish(void)
{
	IEN1 &= ~0x1;
	touch_int_out=1;
    slave_busy=0;
	slave_mun=0;
	IEN1 |= 0x1;
}

/*****************************************************************/
unsigned char I2COpen(void)
{
	touch_int_out=1;
	I2CFinish();
    //enable all interupts
    IEN0 |= 0x80;
    //enable I2C interrupt
    IEN1 |= 0x1;

    // enable both I2C interfaces
    I2CCON |= 0x44;

    // set slave addresses of both I2C interfaces
    I2CADR |= SLAVE_ADDRESS_1 ;

    return 0;
}

/*****************************************************************/
unsigned char I2CClose(void)
{
    // disable I2C interrupt
    IEN1 &= ~0x1;

    return 0;
}



