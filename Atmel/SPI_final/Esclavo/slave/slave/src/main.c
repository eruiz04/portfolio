
#include <avr/io.h>

#include <avr/interrupt.h>
ISR(SPI_STC_vect){
	PORTD=SPDR;
	SPDR =ADCH;
	
	
}

int main(void)

{  ADMUX=0b01100000;
	ADCSRA=0b11100000;
	ADCSRB=0b00000000;
	DDRD=0b11111111;
	DDRB=0b00001000;
	SPCR=0b11100011;
	sei();
	
	while (1)
	{

		
	}
	
}
