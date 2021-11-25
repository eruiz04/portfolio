;
; poneren1.asm
;
; Created: 09/10/2018 09:47:24 p. m.
; Author : aleja
;


; Replace with your application code
start:

LDS R16, 0X100
LDI R17, 0X89
OR R16,R17
    inc r16
    rjmp start
