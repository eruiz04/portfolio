;
; PONERENCERO.asm
;
; Created: 09/10/2018 10:17:53 p. m.
; Author : aleja
;


; Replace with your application code
start:
LDS R16,0X100
CBR R16,0B01010010
STS 0X100,R16
