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


inicializa(){
	DDRB=0xff;		//salida display
	//INTERRUPCIONES
	EIMSK=0X01;		//HABLITIA INTERRUPCION
	EICRA=0X03;		//FLANCO DE SUBIDA EN INT0
	
}

unsigned char variable=0;
// timer1 overflw
ISR(INT0_vect) //este nombre de interrupción se obtiene de la tabla
{
	//Aquí se pone el código que queremos se haga cuando suceda la interrupción
	variable++;
	if (variable==16)		//evita que muestre cosas raras al pasar del 16
	variable=0;
}

// cuando termina la subrutina se borra la bandera y esto lo hace la librería para indicar que se /
//atendió la interrupción


int main (void)
{
	const char display[]={0b00111111,0b00000110,0b01011011,0b01001111,0b01100110,0b01101101,0b01111101,0b00000111,0b01111111,0b01101111,0b10001000,0b10000011,0b11000110,0b10100001,0b10000110,0b10001110};
	sei();		//activa las interrupciones globales, es la primera condicion
	
	while(true){
		PORTB=display[variable];
		//~variable
		
	}
	
}
