
#include <asf.h>
#include <avr/io.h>

inicializa(){
	//DDRD=(1<<PORTD0);
	DDRD|=(1<<0);		//D0 como salida del canal B
	TCCR0A=0b10100011;
	TCCR0B=0b00001011;
	OCR0A=156;			//5ms
	OCR0B=117;			//75%
	
}

int main (void)
{
	inicializa();
	while(1){
		
	}
}
