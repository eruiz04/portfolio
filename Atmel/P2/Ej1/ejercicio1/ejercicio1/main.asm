;
; ejercicio1.asm
;
; Created: 16/10/2018 09:01:04 p. m.
; Author : aleja
;


; Replace with your application code


;PONER AB EN LAS LOC. 0X100 A 0X1FA USANDO CICLOS Y DIRECCIONAMIENTO INDEXADO

LDI R30,0X00		;PARTE BAJA REG Z
LDI R31,0X01		;PARTE ALTA REG Z
LDI R16,0XAB		;PONER 0XAB

CICLO:
CPI R30,0XFB		;COMPARADOR CONDICION
BREQ FIN			;FINALIZAR CICLO
ST Z+,R16			;GUARDA R16 EN VALOR ACTUAL REG Z, DESPUES INCREMENTA Z
RJMP CICLO			;REINICIA CICLO

FIN:				;THIS IS THE END
RJMP FIN		