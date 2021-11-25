;
; ejercicio8.asm
;
; Created: 08/10/2018 08:53:52 p. m.
; Author : aleja
;


; Replace with your application code
start:

LDS R16,0X101
LDI R17,7

MUL R16,R17
STS 0X102,R0
STS 0X103,R1

  