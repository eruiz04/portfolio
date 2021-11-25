O;
; PONENCERO.asm
;
; Created: 09/10/2018 10:13:15 p. m.
; Author : aleja
;


; Replace with your application code
start:

LDS R16,0X100
LDI R17,0XAD
AND R16,R17

    inc r16
    rjmp start
