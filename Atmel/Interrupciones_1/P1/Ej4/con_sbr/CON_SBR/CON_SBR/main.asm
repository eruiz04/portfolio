;
; CON_SBR.asm
;
; Created: 09/10/2018 10:03:03 p. m.
; Author : aleja
;


; Replace with your application code
start:

LDS R16,0X100
SBR R16,0X89

    inc r16
    rjmp start
