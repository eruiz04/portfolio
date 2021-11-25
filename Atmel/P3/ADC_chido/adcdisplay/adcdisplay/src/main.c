#include <asf.h>
#include <avr/io.h>

//puerto b sera para ADC
//puerto d sera para el display

inicializa(){
	
	DDRB=0;    // todos los pines de los puertos B como entrada
	DDRD=0b11111111; // todos los pines de los puertos D como salida
	PORTD=0b11111111; // Activa
	ADMUX = 0b01100000; //"0b"binario, "01"Ref, "1"Para 8 bits, "00000" CH0
	ADCSRB =0b10000000; //"0b"binario, "1" "0" Siempre,"00", "0000" Conversiones continuas
	ADCSRA =0b11100000; //"0b"binario, "1" Enciende ADC, "1" inicia una conversión, "1", "No interrupciones","000" CLK
}


int main(void)
{
	inicializa();
	//const char arreglo[]={0b00111111,0b00000110,0b01011011,0b01001111,0b01100110,0b01101101,0b01111100,0b00000111,0b01111111,0b01100111};
	const char arreglo[10]={0b11000000,0b11111001,0b10100100,0b10101000,0b10011001,0b10001010,0b10000010,0b11111000,0b10000000,0b10011000};
	unsigned char x; 
	unsigned char y; 
	unsigned char decimas; 
	unsigned char volts; 
	
	while (1)
	{
		if(PINB&0b00000010 == 1) // 
		{
			ADCSRA=0b11100000;//// es lo de arriba
			x= ADCH;
			y= x*50/255;  
			volts = y/10;
			PORTD = arreglo[volts];
		}
		else{
			ADCSRA=0b11100000; 
			x= ADCH;
			y= x*50/255;
			decimas = y%10;
			PORTD = arreglo[decimas];
		}
	}
}