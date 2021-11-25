;
; ejercicio9.asm
;
; Created: 08/10/2018 09:13:45 p. m.
; Author : aleja
;


; Replace with your application code
start:
LDS R16,0X100
LDS R17,0X101

MULS R16,R17
STS 0X102,R0
STS 0X103,R1



    inc r16
    rjmp start
