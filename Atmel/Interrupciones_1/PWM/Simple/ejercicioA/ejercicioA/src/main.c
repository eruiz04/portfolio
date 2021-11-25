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

inicializa(){
	//PINB=0XFF;
	//timer 0, canal A es B7 y canal B es D0
	TCCR0A=0b11100011;
	TCCR0B=0b00000010;
	OCR0A=192;			//75% canal A
	OCR0B=230;			///90% canal B
	//DDRB=(1<<PORTB7);
	//DDRD=(1<<PORTD0);
	DDRB|=(1<<7);		//pin B7 como salida, canal A
	DDRD|=(1<<0);		//pin D0 como salida, canal B
}

int main (void)
{
	inicializa();
	while(1){
		
	}
}
