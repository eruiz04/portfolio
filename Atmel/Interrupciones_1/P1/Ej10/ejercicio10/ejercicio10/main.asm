;
; ejercicio10.asm
;
; Created: 10/10/2018 07:06:18 a. m.
; Author : aleja
;


; Replace with your application code
start:
/*LDS R17,0X102
ADC R16,R17
LDS R17,0X103
ADC R16,R17
LDS R17,0X104
ADC R16,R17
LDS R17,0X105
ADC R16,R17
LDS R17,0X106
ADC R16,R17
LDS R17,0X107
ADC R16,R17
LDS R17,0X108
ADC R16,R17
LDS R17,0X109
ADC R16,R17
STS 0X10B,R16
CLR R18
ADD R18,R16
SBC R16,R18
STS 0X10A,R16
*/

CLR R16 ;PRIMER CERO
CLR R17 ;SEGUNDO CERO
LDS R18,0X100
LDS R19,0X101
LDS R20,0X102
LDS R21,0X103
LDS R22,0X104
LDS R23,0X105
LDS R24,0X106
LDS R25,0X107
LDS R26,0X108
LDS R27,0X109

ADD R18,R19
ADC R16,R17 ;ACARREO
ADD R18,R20
ADC R16,R17 ;ACARREO
ADD R18,R21
ADC R16,R17 ;ACARREO
ADD R18,R22
ADC R16,R17 ;ACARREO
ADD R18,R22
ADC R16,R17 ;ACARREO
ADD R18,R23
ADC R16,R17 ;ACARREO
ADD R18,R24
ADC R16,R17 ;ACARREO
ADD R18,R25
ADC R16,R17 ;ACARREO
ADD R16,R26
ADC R16,R17 ;ACARREO
ADD R16,R27
ADC R16,R17 ;ACARREO
STS 0X10A,R18
STS 0X10B,R16