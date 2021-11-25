/*
 * Control_Trifasico.c
 *
 * Created: 28/11/2018 07:24:39 a. m.
 * Author : EUGENIO RUIZ
 */ 
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>   //libreria de delay

#define Tfre  0.0166666   /*periodo*/
#define tim 0.0000005     //periodo del micro
#define dilei 40          //tiempo muerto
#define F_CPU 2000000UL  // 2 MHz
//#define F_CPU 14.7456E6

unsigned int cuentas;    
unsigned int pulso;
unsigned int desface;
unsigned int desface1;
unsigned char var1;      // Variable
unsigned char var2;      // Variable
unsigned char var3;
unsigned char salida1,salida2,salida3;

inicializa()
{
	cuentas=Tfre/tim;            //cuentas del periodo 360°
	pulso=cuentas/2;             //cuentas de 180°
	desface=(60)*(pulso/180);  //cuentas del desface 60
	desface1=(120)*(pulso/180);  //cuentas del desface 120
	DDRB=0Xf0;                   //puerto b en salida
	TCCR1A=0b00000000;
	TCCR1B=0b00011001;
	TIMSK1=0b00001110;
	ICR1=cuentas;
	OCR1B=cuentas;
	OCR1A=cuentas;
	OCR1C=cuentas;
}
ISR(TIMER1_COMPB_vect)
{
	if (var1==1)
	{
		OCR1B=0;
		salida1=0b00000000;
		PORTB=salida1|salida2|salida3;
		_delay_us (dilei);
		salida1=0b00000001;
		PORTB=salida1|salida2|salida3;
	}
	if (var1==2)
	{
		OCR1B=desface;
		salida1=0b00000000;
	}
	if(var1==3)
	{
		OCR1B=pulso;
		salida1=0b00000000;
		PORTB=salida1|salida2|salida3;
		_delay_us (dilei);
		salida1=0b00000010;
		PORTB=salida1|salida2|salida3;

	}
	if (var1==4)
	{
		OCR1B=pulso+desface;
		salida1=0b00000000;
	}
	var1++;
	if(var1==5)
	var1=1;
}

ISR(TIMER1_COMPA_vect)
{
	if (var2==1)
	{
		OCR1A=desface;
		salida2=0b00000000;
		PORTB=salida1|salida2|salida3;
		_delay_us (dilei);
		salida2=0b00000100;
		PORTB=salida1|salida2|salida3;
	}
	if (var2==2)
	{
		OCR1A=pulso+desface;
		salida2=0b00000000;
		PORTB=salida1|salida2|salida3;
		_delay_us (dilei);
		salida2=0b00001000;
		PORTB=salida1|salida2|salida3;
	}
	var2++;
	if (var2==3)
	var2=1;
}

ISR(TIMER1_COMPC_vect)
{
	if (var3==1)
	{
		OCR1C=desface1;
		salida3=0b00000000;
		PORTB=salida1|salida2|salida3;
		_delay_us (dilei);
		salida3=0b00010000;
		PORTB=salida1|salida2|salida3;
	}
	if(var3==2)
	{
		OCR1C=pulso+desface1;
		salida3=0b00000000;
		PORTB=salida1|salida2|salida3;
		_delay_us (dilei);
		salida3=0b00100000;
		PORTB=salida1|salida2|salida3;
	}
	var3++;
	if(var3==3)
	var3=1;
}

int main(void)
{
	inicializa();
	sei();
	while (1)
	{
		
	}
}

