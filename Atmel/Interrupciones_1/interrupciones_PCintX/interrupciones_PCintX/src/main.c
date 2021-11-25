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
#include <avr/interrupt.h>


//cambiar display a puerto d, puerto b sera para las pcint

inicializa()
{
	DDRD=0xff;		//PUERTO D SALIDAS
	PCICR=0x01;		//SE ACTIVA INTERRUPCIONES DE BLOQUE PCINT6 A PCINT0
	PCMSK0=0X52;	//SE ACTIVA PIN 6,4 Y 1
}
const char display[]={0b11000000,0b11001111,0b10100100,0b10110000,0b10011001,0b10010010,0b10000010,0b10111000,0b10000000,0b10011000,0b10001000,0b10000011,0b11000110,0b10100001,0b10000110,0b10001110}; //combinaciones
unsigned char variable=0;

//PCINT0 es el bloque que comprende pcint0 a pcint6	
	ISR(PCINT0_vect)
	{
		variable++;
	}
	
int main (void)
{
	sei();			//hablitador global de interrupciones I
	inicializa();
	while(1)
	{
		PORTD= display[variable];
	}
	
}
