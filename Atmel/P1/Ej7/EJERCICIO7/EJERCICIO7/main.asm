;
; EJERCICIO7.asm
;
; Created: 08/10/2018 08:47:25 p. m.
; Author : aleja
;


; Replace with your application code
start:

LDS R16,0X100
LDS R17,0X101
LDS R18,0X102
LDS R19,0X103

SUB R16,R18
STS 0X104,R16

SBC R17,R19
STS 0X105,R17


    inc r16
    rjmp start
