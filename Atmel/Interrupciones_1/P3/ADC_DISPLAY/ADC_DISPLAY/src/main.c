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

#define entero  PORTB|= (1<<PORTB4)
#define fracc PORTB&= ~(1<<PORTB4)
#define SELECC PINB|=(1<<PINB4)

inicializa(){
	ADMUX=0b01100000;
	ADCSRB=0x80;
	ADCSRA=0xE0;
	DDRD=0xff;
}

int main (void)
{
	const char display[]={0b00111111,0b00000110,0b01011011,0b01001111,0b01100110,0b01101101,0b01111101,0b00000111,0b01111111,0b01101111,0b10001000,0b10000011,0b11000110,0b10100001,0b10000110,0b10001110};
	DDRB |= (1<<DDB5);
	DDRB &= ~(1<<DDB7);
	
	inicializa();
	
	float temporal = ADCH;
	int x;			//parte entera
	float y;		//parte fraccionaria
	x=temporal;		//parte entera
	y=(temporal-x);		//parte fracc
	int z;
	z=10*y;		//parte "entera" de la fraccion

	while(1){
		
		if(!PINB & (1<<PINB7))			//SW ESTA EN 0
		{
			entero;
			x= (((x)*5)/255);
			PORTD = display[x];
			
		}
		
		else
		{
			fracc;
			z=(((z)*5)/255);
			PORTD = display[z];
			
		}
		
	}
}
