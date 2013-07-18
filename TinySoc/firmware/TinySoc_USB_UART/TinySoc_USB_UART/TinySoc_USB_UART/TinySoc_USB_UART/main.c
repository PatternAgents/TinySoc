/*****************************************************************************
# File Name:	TinySoc_USB_UART
# Platform :	TinySoc
# Version  :	1.10
# Author   :	(www.PatternAgents.com)
#*****************************************************************************
# Copyright:	(C) 2001-2013 by PatternAgents. All rights reserved.
#*****************************************************************************
# PatternAgents Licensing Model:
# 
# PatternAgents uses the increasingly popular business model called 
# "Dual Licensing" in which both the open source software distribution 
# mechanism and traditional commercial software distribution models 
# are combined.
# 
# Open Source Projects:
# 
# If you are developing and distributing open source applications 
# under the GNU General Public License version 2 (GPLv2), 
# as published by the Free Software Foundation, then you are free 
# to use the RSVP software under the GPLv2 license. Please note 
# that GPLv2 Section 2(b) requires that all modifications to the 
# original code as well as all Derivative Works must also be 
# released under the terms of the GPLv2 open source license.
# 
# Closed Source Projects:
# 
# If you are developing and distributing traditional closed source 
# applications, you must purchase a PatternAgents commercial use license, 
# which is specifically designed for users interested in retaining 
# the proprietary status of their code. All PatternAgents commercial licenses 
# expressly supersede the GPLv2 open source license. This means that 
# when you license the PatternAgents software under a commercial license, 
# you specifically do not use the software under the open source 
# license and therefore you are not subject to any of its terms.
#
# Commercial licensing options available on the PatternAgents Website at : 
#	http://www.PatternAgents.com/licensing/
#
#*****************************************************************************
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, 
# BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES 
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED 
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE 
# USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#*****************************************************************************
#
# Introduction:
#
# The TinySoc is a postage stamp size PC board with a USB based PSoC1
# (Programmable System-on-Chip) of type CY7C64215 (Encore III) 
#
#*****************************************************************************
#
# Description:
#
# This first example loops back the USB data stream for testing.
#			
*****************************************************************************/

#include <m8c.h>        			// part specific constants and macros
#include "PSoCAPI.h"    			// PSoC API definitions for all User Modules

const char rsvp_lcd_str_blank[ ]   = "                ";
const char rsvp_lcd_str_version[ ] = "RSVP Version 1.1";
const char rsvp_lcd_str_crlf[ ]    = "\n\r";

/* Buffer for storing UART configuration data */
BYTE ReadData[10];

/* Buffer for incoming USB data, and pointer to current place in that buffer */
BYTE pData[33];
BYTE len;

/* Flag and counter for VBUS detection */
BYTE VDD_ON = 0;
BYTE USB_VDD_Counter = 0;

char * strPtr;                         /* Parameter pointer */
BYTE Data1;  						   /* Data byte for UART */

BYTE USB_Count;
BYTE USB_Buffer[64];

int delay, loop;

void RSVP_Initialize(void);        		/* RSVP Initialize */
void RSVP_UART_1_Config( void );
void RSVP_USBUART_Initialize( void );
void RSVP_blinkVersion( void );
void RSVP_UART_Initialize( void );
void RSVP_USBUART_Send_Greeting( void );
void RSVP_USBUART_Echo( void );

void main(void)
{
	RSVP_Initialize();				    /* Initialize all components */
	RSVP_USBUART_Initialize();			/* Enumerate the USB UART    */
	RSVP_blinkVersion();				/* Blink the Version Number  */
	RSVP_UART_Initialize();				/* Initialize the UART       */
	RSVP_USBUART_Send_Greeting();		/* Print Greeting on USBUART */
		
		
    while(1)
    {
		RSVP_USBUART_Echo();
    }
}

void RSVP_USBUART_Echo( void )
{
	    LED_1_Off();
		USB_Count = USBUART_1_bGetRxCount();
		if(USB_Count != 0)							/* Check for input data from PC */
		{
		    LED_1_On();
			USBUART_1_ReadAll(USB_Buffer);
			USBUART_1_Write(USB_Buffer, USB_Count);		/* Echo data back to PC */
			UART_1_Write(USB_Buffer, USB_Count);
			while(!USBUART_1_bTxIsReady()){}		/* Wait for Tx to finish */ 
		}
}

void RSVP_USBUART_Send_Greeting( void )
{
	/* output the greeting/version string */
	USBUART_1_CWrite(rsvp_lcd_str_version, 16);
	USBUART_1_CWrite(rsvp_lcd_str_crlf, 2);
	//USBUART_1_PutCRLF();
	while(!USBUART_1_bTxIsReady()){}
}

void RSVP_blinkVersion( void )
{
	/* Send the Version Number as blinks, give time to receive */
	for (loop = 0; loop < 30; loop++) {
		for (delay = 0; delay < 10000; delay++) {
			LED_1_On();
		}
		for (delay = 0; delay < 10000; delay++) {
			LED_1_Off();
		}
	}
}

void RSVP_USBUART_Initialize( void )
{
	/* Wait for USBUART_1 to initialize */
	while( !USBUART_1_Init() ) {
		LED_1_On();
	}
	LED_1_Off();
}

void RSVP_UART_Initialize( void )
{
/*
	UART_1_SwitchBuffer = 0;		
	UART_1_bTxCnt = 0;				
	UART_1_bTxFlag = 0;
*/
	UART_1_CWrite(rsvp_lcd_str_version, 16);
	UART_1_CWrite(rsvp_lcd_str_crlf, 2);
}

void RSVP_UART_1_Config( void )
{
	unsigned long dwDTERate;
	BYTE Return_Config;
	USBUART_1_dwGetDTERate( &dwDTERate );

    switch( dwDTERate )
    {
    	case 2400:
			Counter8_1_OUTPUT_REG = 0x40 | (Counter8_1_OUTPUT_REG &0x3F); 
			OSC_CR1 = 0x70 | (OSC_CR1& OSC_CR1_VC2); 
			Counter8_1_INPUT_REG = (Counter8_1_INPUT_REG & 0xF0) | 0x05;
			Counter8_1_WritePeriod(155);
			Counter8_1_WriteCompareValue(78);
			ReadData[2] = 0;
			ReadData[3] = 24;
    	break;

    	case 4800:
			Counter8_1_OUTPUT_REG = 0x40 | (Counter8_1_OUTPUT_REG &0x3F);
			OSC_CR1 = 0x30 | (OSC_CR1& OSC_CR1_VC2); 
			Counter8_1_INPUT_REG = (Counter8_1_INPUT_REG & 0xF0) | 0x05;
			Counter8_1_WritePeriod(155);
			Counter8_1_WriteCompareValue(78);
			ReadData[2] = 0;
			ReadData[3] = 48;
    	break;

 		case 9600:
    	default:
			Counter8_1_OUTPUT_REG = 0x40 | (Counter8_1_OUTPUT_REG &0x3F);
			OSC_CR1 = 0x10 | (OSC_CR1& OSC_CR1_VC2); 
			Counter8_1_INPUT_REG = (Counter8_1_INPUT_REG & 0xF0) | 0x05;
			Counter8_1_WritePeriod(155);
			Counter8_1_WriteCompareValue(78);
			ReadData[2] = 0;
			ReadData[3] = 96;
    	break;

    	case 19200:
			Counter8_1_OUTPUT_REG = 0xC0 | (Counter8_1_OUTPUT_REG &0x3F); 
			OSC_CR1 = 0x00 | (OSC_CR1& OSC_CR1_VC2); 
			Counter8_1_INPUT_REG = (Counter8_1_INPUT_REG & 0xF0) | 0x05; 
			Counter8_1_WritePeriod(155);
			Counter8_1_WriteCompareValue(78);
			ReadData[2] = 1;
			ReadData[3] = 92;
    	break;

    	case 38400:
			Counter8_1_OUTPUT_REG = 0x00 | (Counter8_1_OUTPUT_REG &0x3F);
			Counter8_1_INPUT_REG = (Counter8_1_INPUT_REG & 0xF0) | 0x04; 
			Counter8_1_WritePeriod(155);
			Counter8_1_WriteCompareValue(78);
			ReadData[2] = 3;
			ReadData[3] = 84;
    	break;

    	case 57600:
			Counter8_1_OUTPUT_REG = 0x00 | (Counter8_1_OUTPUT_REG &0x3F);
			Counter8_1_INPUT_REG = (Counter8_1_INPUT_REG & 0xF0) | 0x04;
			Counter8_1_WritePeriod(103);
			Counter8_1_WriteCompareValue(52);
			ReadData[2] = 5;
			ReadData[3] = 76;
    	break;

    	case 115200:
			Counter8_1_OUTPUT_REG = 0x00 | (Counter8_1_OUTPUT_REG &0x3F);
			Counter8_1_INPUT_REG = (Counter8_1_INPUT_REG & 0xF0) | 0x04; 
			Counter8_1_WritePeriod(51);
			Counter8_1_WriteCompareValue(26);
			ReadData[2] =11;
			ReadData[3] = 52;
    	break;
    }

	Return_Config = USBUART_1_bGetParityType();

	switch( Return_Config )
	{
		case USBUART_1_PARITY_NONE:
			UART_1_Start( UART_1_PARITY_NONE );
		break;

		case USBUART_1_PARITY_ODD:
			UART_1_Start( UART_1_PARITY_ODD );      
	 	break;

		case USBUART_1_PARITY_EVEN:
			UART_1_Start( UART_1_PARITY_EVEN );       
		break;

		default:
		case USBUART_1_PARITY_MARK:
		case USBUART_1_PARITY_SPACE:
			UART_1_Start( UART_1_PARITY_NONE );        
		break;
	}
	return;
}

//-----------------------------------------------------------------------------
//  Sleep timer ISR function definition
//-----------------------------------------------------------------------------
void SleepTimer_1_ISRV(void)
{
	// start of the Sleep Timer ISR, 
	// the M8C processor executes this ISR after it comes out of sleep
	// Toggle the LED
	   LED_1_Invert(); 
}

//-----------------------------------------------------------------------------
//  RSVP_Initialize function definition
//  Initialize RSVP Platform
//-----------------------------------------------------------------------------
void RSVP_Initialize(void)
{
	SleepTimer_1_Start();
	SleepTimer_1_SetInterval(SleepTimer_1_1_HZ);
	SleepTimer_1_EnableInt();

	LED_1_Start();
	LED_1_On();

    //UART_1_IntCntl( UART_1_ENABLE_RX_INT|UART_1_ENABLE_TX_INT );    /* Setup UART baud clock */
	Counter8_1_OUTPUT_REG = 0x00 | (Counter8_1_OUTPUT_REG &0x3F);
	Counter8_1_INPUT_REG = (Counter8_1_INPUT_REG & 0xF0) | 0x04;
	Counter8_1_WritePeriod(103);
	Counter8_1_WriteCompareValue(52);
    Counter8_1_Start();                     						 /* Start UART baud clock */

    UART_1_Start(UART_1_PARITY_NONE);         					/* Enable UART */
    USB_CR1 |= USB_CR1_ENABLE_LOCK;		  						/* Lock IMO to USB clock */
    M8C_EnableGInt ;                     						/* Enable global interrupts */

	USBUART_1_Start(USBUART_1_5V_OPERATION);    				/* Start USBUART */
    RSVP_UART_1_Config();		     							/* Setup UART to match USBUART */
	LED_1_Off();
}
