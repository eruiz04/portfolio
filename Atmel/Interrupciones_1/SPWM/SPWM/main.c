/*
 * SPWM.c
 *
 * Created: 05/12/2018 09:55:15 a. m.
 * Author : GERARDO MARTINEZ
 */ 
#include <avr/io.h>
#include <avr/interrupt.h>
#include <util/delay.h>

#define Tfre  0.008052  /*periodo*/
#define tim 0.0000005     //periodo del micro
#define dilei 60   //tiempo muerto para encender los complementarios

////tiempos de encendido y apagado de S1 y S2
#define dilei1 563
#define dilei2 340
#define dilei3 805
#define dilei4 895
#define dilei5 313
#define dilei6 1181
#define dilei7 183
#define dilei8 1138
#define dilei9 313
#define dilei10 938
#define dilei11 805
#define dilei12 297
#define dilei13 1169
#define dilei14 297
#define dilei15 804
#define dilei16 939
#define dilei17 313
#define dilei18 1137
#define dilei19 140
#define dilei20 1225
#define dilei21 313
#define dilei22 851
#define dilei23 805
#define dilei24 384
 

#define F_CPU 2000000UL  // 2 MHz

//#define F_CPU 14.7456E6

unsigned int cuentas;
unsigned int pulso;

inicializa()
{
	cuentas=Tfre/tim;            //cuentas del periodo 360°
	DDRB=0Xff;                   //puerto b en salida
	TCCR1A=0b00000000;
	TCCR1B=0b00011001;
	TIMSK1=0b00000110;
	ICR1=cuentas;
	OCR1B=pulso;
}

ISR(TIMER1_COMPB_vect)
{
	OCR1B=pulso;
	PORTB=0b00000011;//0     1  s1s2
	_delay_us(dilei1);
	PORTB=0b00000001;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001001;//Vcc   2  s1s4
    _delay_us(dilei2);
	PORTB=0b00001000;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001100;//0     3   s3s4
	_delay_us(dilei3);
	PORTB=0b00001000;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001001;//Vcc   4   s1s4 
	_delay_us(dilei4);
	PORTB=0b00000001;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000011;//0     5    s1s2
	_delay_us(dilei5);
	PORTB=0b00000001;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001001;//Vcc   6    s1s4
	_delay_us(dilei6);
	PORTB=0b00001000;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001100;//0     7   s3s4
	_delay_us(dilei7);
	PORTB=0b00001000;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001001;//Vcc   8    s1s4
	_delay_us(dilei8);
	PORTB=0b00000001;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000011;//0     9    s1s2
	_delay_us(dilei9);
	PORTB=0b00000001;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001001;//Vcc   10    s1s4
	_delay_us(dilei10);
	PORTB=0b00001000;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001100;//0     11   s3s4
	_delay_us(dilei11);
	PORTB=0b00001000;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001001;//Vcc   12    s1s4
	_delay_us(dilei12);
	PORTB=0b00000001;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000011;//0     13    s1s2
	_delay_us(dilei13);
	PORTB=0b00000010;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000110;//0     14    s2s3
	_delay_us(dilei14); 
	PORTB=0b00000100;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001100;//0     15   s3s4
	_delay_us(dilei15);
	PORTB=0b00000100;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000110;//0     16    s2s3
	_delay_us(dilei16);
	PORTB=0b00000010;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000011;//0     17    s1s2
	_delay_us(dilei17);
	PORTB=0b00000010;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000110;//0     18    s2s3
	_delay_us(dilei18);
	PORTB=0b00000100;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001100;//0     19   s3s4
	_delay_us(dilei19);
	PORTB=0b00000100;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000110;//0     20    s2s3
	_delay_us(dilei20);
	PORTB=0b00000010;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000011;//0     21    s1s2
	_delay_us(dilei21);
	PORTB=0b00000010;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00000110;//0     22    s2s3
	_delay_us(dilei22);
	PORTB=0b00000100;//tiempo muerto
	_delay_us(dilei);
	PORTB=0b00001100;//0     19   s3s4
	_delay_us(dilei23);
	PORTB=0b00000000;//tiempo muerto
	_delay_us(dilei);
}


int main(void)
{
	inicializa();
	sei();
	while (1)
	{
		
	}
}