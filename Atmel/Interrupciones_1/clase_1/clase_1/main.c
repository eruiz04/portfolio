
#include <avr/io.h>
#include <avr/interrupt.h>//libreria de las interrupciones
inicializa()
{
    DDRB=0xff;     //Puerto b como salidas (ponemos todos en 1).
	EIMSK=0x01;     //habilitamos la interrupcion 0
	EICRA=0X03;     //habilitamos para el flanco de subida en la interrupcion 0 
}
unsigned char variable; // Variable
ISR(INT0_vect)
{
	variable++;
	if (variable==16)
	variable=0;
}
int main(void)
{
	const char display[]={0b11000000,0b11001111,0b10100100,0b10110000,0b10011001,0b10010010,0b10000010,0b10111000,0b10000000,0b10011000,0b10001000,0b10000011,0b11000110,0b10100001,0b10000110,0b10001110}; //convinaciones
    sei();       //SET1 I habilita cualquier interrupcion que nosotros queramos
	inicializa();
    while (1) 
    {
		PORTB=display[variable];
    }
}

