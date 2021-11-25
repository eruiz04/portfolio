
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

ISR(SPI_STC_vect){
PORTD=SPDR;
SPDR =ADCH;
}
void inicia(void){
	
	sei();
	DDRB=0b00000111;
	SPCR=0b11110011;
	
	ADMUX=0b01100000;
	ADCSRB=0x00;
	ADCSRA=0xE0;
	
	DDRD=0xff;
	
	SPDR=1;
	//SPDR=0;
}

int main(void)

{ inicia();
	
	while (1)
	{
	}
	
}