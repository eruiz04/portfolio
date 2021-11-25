;
; eLgUS.asm
;
; Created: 08/10/2018 01:46:43 p. m.
; Author : aleja
;

.org 0


; Replace with your application code
	lds r16,0x100
start:sts 0x101,r16
    rjmp start
