//int0 flanco de subida display+1
//int1 ambos flancos display-1
//int2 flanco de subida display=0
//int3 flanco de bajada display=9

//10 BAJADA
//11 SUBIDA
//01 CUALQUIER FLANCO
#include <asf.h>
#include <avr/io.h>
#include <avr/interrupt.h>


//cambiar display a puerto d, puerto b sera para las pcint

inicializa()
{
	DDRB=0xff;		//PUERTO B SALIDAS
	//PCICR=0x01;		//SE ACTIVA INTERRUPCIONES DE BLOQUE PCINT6 A PCINT0
	//PCMSK0=0xF;	//SE ACTIVA PIN 0,1,2,3		ob00001111
	EICRA=0xB7;
	//EICRA= 0b1011 0111
	//EICRA= 0b00000111
	EIMSK=0X0F;		//HABILITA LAS INTERRUPCIONES
}
//const char display[]={0b11000000,0b11001111,0b10100100,0b10110000,0b10011001,0b10010010,0b10000010,0b10111000,0b10000000,0b10011000};//0b10001000,0b10000011,0b11000110,0b10100001,0b10000110,0b10001110}; //combinaciones
unsigned char variable=0;
//const char display[]={0xC0,0xF9,0xA4,0xB0,0x99,0x92,0x82,0xF8,0x80,0x90};
//const char display[]={0x1,0x4F,0x12,0x6,0x4C,0x24,0x20,0xF,0x0,0x6};
//const char display[]={0xC0,}
const char display[]={0b11000000,0b11111001,0b10100100,0b10101000,0b10011001,0b10001010,0b10000010,0b11111000,0b10000000,0b10011000};//0b10001000,0b10000011,0b11000110,0b10100001,0b10000110,0b10001110}; //combinaciones

ISR(INT0_vect)
{
	variable++;
	if(variable==10)
	variable=0;
}
ISR(INT1_vect)
{
	variable--;
	if (variable==0)
	variable=10;
}
ISR(INT2_vect)
{
	variable=0;
}
ISR(INT3_vect)
{
	variable=9;
}


int main (void)
{
	sei();			//hablitador global de interrupciones I
	inicializa();
	while(1)
	{
		PORTB= display[variable];
	}
	
}