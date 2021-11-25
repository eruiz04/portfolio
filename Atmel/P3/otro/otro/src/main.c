/**
 * \file
 *
 * \brief Empty user application template
 *
 */

/**
 * \mainpage User Application template doxygen documentation
 *
 * \par Empty user application template
 *
 * Bare minimum empty user application template
 *
 * \par Content
 *
 * -# Include the ASF header files (through asf.h)
 * -# "Insert system clock initialization code here" comment
 * -# Minimal main function that starts with a call to board_init()
 * -# "Insert application code here" comment
 *
 */

/*
 * Include header files for all drivers that have been imported from
 * Atmel Software Framework (ASF).
 */
/*
 * Support and FAQ: visit <a href="https://www.microchip.com/support/">Microchip Support</a>
 */
		
		

		#include <asf.h>
		#include <avr/io.h>


		//puerto b es para leer entrada
		//puerto d es para display

		inicializa(){
			DDRB=0xff;		//puerto b salida
			DDRD=0xff;		//puerto d salida
			PORTB=0xff;	//R pull up para B
			//PINB &=~(0x80|0x40|0x20|0x10);					//apaga pines que no usamos 128 64 32 16
		}

		int main (void)
		{
			
			inicializa();
			const char display[]={0b00111111,0b00000110,0b01011011,0b01001111,0b01100110,0b01101101,0b01111101,0b00000111,0b01111111,0b01101111,0b10001000,0b10000011,0b11000110,0b10100001,0b10000110,0b10001110};
			
			while(1)
			{
				
				PORTD= 0xff;
				//display[PINB];
				
			}
		}
		
