;
; SUBI.asm
;
; Created: 08/10/2018 11:11:32 a. m.
; Author : aleja
;


; Replace with your application code
start:
LDI R16, 0XAA			;CARGA 0X0A
SUBI R16,1
STS 0X100,R16
STS 0X101,R16
STS 0X102,R16
STS 0X103,R16
STS 0X104,R16
STS 0X105,R16



    inc r16
    rjmp start
