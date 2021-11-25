
;CodeVisionAVR C Compiler V3.24 Evaluation
;(C) Copyright 1998-2015 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Debug
;Chip type              : ATmega32U4
;Program type           : Application
;Clock frequency        : 7.991000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : float, width, precision
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 640 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Mode 2
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega32U4
	#pragma AVRPART MEMORY PROG_FLASH 32768
	#pragma AVRPART MEMORY EEPROM 1024
	#pragma AVRPART MEMORY INT_SRAM SIZE 2560
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU EECR=0x1F
	.EQU EEDR=0x20
	.EQU EEARL=0x21
	.EQU EEARH=0x22
	.EQU SPSR=0x2D
	.EQU SPDR=0x2E
	.EQU SMCR=0x33
	.EQU MCUSR=0x34
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU WDTCSR=0x60
	.EQU UCSR1A=0xC8
	.EQU UDR1=0xCE
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU GPIOR0=0x1E

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x0AFF
	.EQU __DSTACK_SIZE=0x0280
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD2M
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF __lcd_x=R4
	.DEF __lcd_y=R3
	.DEF __lcd_maxx=R6

;GPIOR0 INITIALIZATION VALUE
	.EQU __GPIOR0_INIT=0x00

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_0x0:
	.DB  0x76,0x6F,0x6C,0x74,0x61,0x6A,0x65,0x3A
	.DB  0x0,0x25,0x35,0x2E,0x32,0x66,0x0
_0x2000000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0
_0x2020003:
	.DB  0x80,0xC0
_0x20A0060:
	.DB  0x1
_0x20A0000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x09
	.DW  _0xB
	.DW  _0x0*2

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

	.DW  0x01
	.DW  __seed_G105
	.DW  _0x20A0060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;GPIOR0 INITIALIZATION
	LDI  R30,__GPIOR0_INIT
	OUT  GPIOR0,R30

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x380

	.CSEG
;
;
;#include <io.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
     .EQU __sm_adc_noise_red=0x02 // 26022010_1
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif
;#include <stdio.h>
;#include <delay.h>
;
;#include <alcd.h>
;
;// Declare your global variables here
;float adc=0;
;// Voltage Reference: AREF pin
;#define ADC_VREF_TYPE ((0<<REFS1) | (0<<REFS0) | (0<<ADLAR))
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0000 0010 {

	.CSEG
_read_adc:
; .FSTART _read_adc
; 0000 0011 ADMUX=(adc_input & 0x1f) | ADC_VREF_TYPE;
	ST   -Y,R17
	MOV  R17,R26
;	adc_input -> R17
	MOV  R30,R17
	ANDI R30,LOW(0x1F)
	STS  124,R30
; 0000 0012 if (adc_input & 0x20) ADCSRB|=(1<<MUX5);
	SBRS R17,5
	RJMP _0x3
	LDS  R30,123
	ORI  R30,0x20
	RJMP _0xD
; 0000 0013 else ADCSRB&= ~(1<<MUX5);
_0x3:
	LDS  R30,123
	ANDI R30,0xDF
_0xD:
	STS  123,R30
; 0000 0014 // Delay needed for the stabilization of the ADC input voltage
; 0000 0015 delay_us(10);
	__DELAY_USB 27
; 0000 0016 // Start the AD conversion
; 0000 0017 ADCSRA|=(1<<ADSC);
	LDS  R30,122
	ORI  R30,0x40
	STS  122,R30
; 0000 0018 // Wait for the AD conversion to complete
; 0000 0019 while ((ADCSRA & (1<<ADIF))==0);
_0x5:
	LDS  R30,122
	ANDI R30,LOW(0x10)
	BREQ _0x5
; 0000 001A ADCSRA|=(1<<ADIF);
	LDS  R30,122
	ORI  R30,0x10
	STS  122,R30
; 0000 001B return ADCW;
	LDS  R30,120
	LDS  R31,120+1
	JMP  _0x20C0004
; 0000 001C }
; .FEND
;
;unsigned char lcd[8];
;   void main(void)
; 0000 0020 {
_main:
; .FSTART _main
; 0000 0021 // Declare your local variables here
; 0000 0022 
; 0000 0023 // Crystal Oscillator division factor: 1
; 0000 0024 #pragma optsize-
; 0000 0025 CLKPR=(1<<CLKPCE);
	LDI  R30,LOW(128)
	STS  97,R30
; 0000 0026 CLKPR=(0<<CLKPCE) | (0<<CLKPS3) | (0<<CLKPS2) | (0<<CLKPS1) | (0<<CLKPS0);
	LDI  R30,LOW(0)
	STS  97,R30
; 0000 0027 #ifdef _OPTIMIZE_SIZE_
; 0000 0028 #pragma optsize+
; 0000 0029 #endif
; 0000 002A 
; 0000 002B // Input/Output Ports initialization
; 0000 002C // Port B initialization
; 0000 002D // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 002E DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x4,R30
; 0000 002F // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0030 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x5,R30
; 0000 0031 
; 0000 0032 // Port C initialization
; 0000 0033 // Function: Bit7=In Bit6=In
; 0000 0034 DDRC=(0<<DDC7) | (0<<DDC6);
	OUT  0x7,R30
; 0000 0035 // State: Bit7=T Bit6=T
; 0000 0036 PORTC=(0<<PORTC7) | (0<<PORTC6);
	OUT  0x8,R30
; 0000 0037 
; 0000 0038 // Port D initialization
; 0000 0039 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 003A DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
	OUT  0xA,R30
; 0000 003B // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 003C PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	OUT  0xB,R30
; 0000 003D 
; 0000 003E // Port E initialization
; 0000 003F // Function: Bit6=In Bit2=In
; 0000 0040 DDRE=(0<<DDE6) | (0<<DDE2);
	OUT  0xD,R30
; 0000 0041 // State: Bit6=T Bit2=T
; 0000 0042 PORTE=(0<<PORTE6) | (0<<PORTE2);
	OUT  0xE,R30
; 0000 0043 
; 0000 0044 // Port F initialization
; 0000 0045 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit1=In Bit0=In
; 0000 0046 DDRF=(0<<DDF7) | (0<<DDF6) | (0<<DDF5) | (0<<DDF4) | (0<<DDF1) | (0<<DDF0);
	OUT  0x10,R30
; 0000 0047 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit1=T Bit0=T
; 0000 0048 PORTF=(0<<PORTF7) | (0<<PORTF6) | (0<<PORTF5) | (0<<PORTF4) | (0<<PORTF1) | (0<<PORTF0);
	OUT  0x11,R30
; 0000 0049 
; 0000 004A PLLCSR=(0<<PINDIV) | (0<<PLLE) | (0<<PLOCK);
	OUT  0x29,R30
; 0000 004B PLLFRQ=(0<<PINMUX) | (0<<PLLUSB) | (0<<PLLTM1) | (0<<PLLTM0) | (0<<PDIV3) | (0<<PDIV2) | (0<<PDIV1) | (0<<PDIV0);
	OUT  0x32,R30
; 0000 004C 
; 0000 004D // Timer/Counter 0 initialization
; 0000 004E // Clock source: System Clock
; 0000 004F // Clock value: Timer 0 Stopped
; 0000 0050 // Mode: Normal top=0xFF
; 0000 0051 // OC0A output: Disconnected
; 0000 0052 // OC0B output: Disconnected
; 0000 0053 TCCR0A=(0<<COM0A1) | (0<<COM0A0) | (0<<COM0B1) | (0<<COM0B0) | (0<<WGM01) | (0<<WGM00);
	OUT  0x24,R30
; 0000 0054 TCCR0B=(0<<WGM02) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x25,R30
; 0000 0055 TCNT0=0x00;
	OUT  0x26,R30
; 0000 0056 OCR0A=0x00;
	OUT  0x27,R30
; 0000 0057 OCR0B=0x00;
	OUT  0x28,R30
; 0000 0058 
; 0000 0059 // Timer/Counter 1 initialization
; 0000 005A // Clock source: System Clock
; 0000 005B // Clock value: Timer1 Stopped
; 0000 005C // Mode: Normal top=0xFFFF
; 0000 005D // OC1A output: Disconnected
; 0000 005E // OC1B output: Disconnected
; 0000 005F // OC1C output: Disconnected
; 0000 0060 // Noise Canceler: Off
; 0000 0061 // Input Capture on Falling Edge
; 0000 0062 // Timer1 Overflow Interrupt: Off
; 0000 0063 // Input Capture Interrupt: Off
; 0000 0064 // Compare A Match Interrupt: Off
; 0000 0065 // Compare B Match Interrupt: Off
; 0000 0066 // Compare C Match Interrupt: Off
; 0000 0067 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<COM1C1) | (0<<COM1C0) | (0<<WGM11) | (0<<WGM10);
	STS  128,R30
; 0000 0068 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	STS  129,R30
; 0000 0069 TCNT1H=0x00;
	STS  133,R30
; 0000 006A TCNT1L=0x00;
	STS  132,R30
; 0000 006B ICR1H=0x00;
	STS  135,R30
; 0000 006C ICR1L=0x00;
	STS  134,R30
; 0000 006D OCR1AH=0x00;
	STS  137,R30
; 0000 006E OCR1AL=0x00;
	STS  136,R30
; 0000 006F OCR1BH=0x00;
	STS  139,R30
; 0000 0070 OCR1BL=0x00;
	STS  138,R30
; 0000 0071 OCR1CH=0x00;
	STS  141,R30
; 0000 0072 OCR1CL=0x00;
	STS  140,R30
; 0000 0073 
; 0000 0074 // Timer/Counter 3 initialization
; 0000 0075 // Clock source: System Clock
; 0000 0076 // Clock value: Timer3 Stopped
; 0000 0077 // Mode: Normal top=0xFFFF
; 0000 0078 // OC3A output: Disconnected
; 0000 0079 // OC3B output: Disconnected
; 0000 007A // OC3C output: Disconnected
; 0000 007B // Noise Canceler: Off
; 0000 007C // Input Capture on Falling Edge
; 0000 007D // Timer3 Overflow Interrupt: Off
; 0000 007E // Input Capture Interrupt: Off
; 0000 007F // Compare A Match Interrupt: Off
; 0000 0080 // Compare B Match Interrupt: Off
; 0000 0081 // Compare C Match Interrupt: Off
; 0000 0082 TCCR3A=(0<<COM3A1) | (0<<COM3A0) | (0<<COM3B1) | (0<<COM3B0) | (0<<COM3C1) | (0<<COM3C0) | (0<<WGM31) | (0<<WGM30);
	STS  144,R30
; 0000 0083 TCCR3B=(0<<ICNC3) | (0<<ICES3) | (0<<WGM33) | (0<<WGM32) | (0<<CS32) | (0<<CS31) | (0<<CS30);
	STS  145,R30
; 0000 0084 TCNT3H=0x00;
	STS  149,R30
; 0000 0085 TCNT3L=0x00;
	STS  148,R30
; 0000 0086 ICR3H=0x00;
	STS  151,R30
; 0000 0087 ICR3L=0x00;
	STS  150,R30
; 0000 0088 OCR3AH=0x00;
	STS  153,R30
; 0000 0089 OCR3AL=0x00;
	STS  152,R30
; 0000 008A OCR3BH=0x00;
	STS  155,R30
; 0000 008B OCR3BL=0x00;
	STS  154,R30
; 0000 008C OCR3CH=0x00;
	STS  157,R30
; 0000 008D OCR3CL=0x00;
	STS  156,R30
; 0000 008E 
; 0000 008F // Timer/Counter 4 initialization
; 0000 0090 // Clock: Timer4 Stopped
; 0000 0091 // Mode: Normal top=OCR4C
; 0000 0092 // OC4A output: OC4A=Disc. /OC4A=Disc.
; 0000 0093 // OC4B output: OC4B=Disc. /OC4B=Disc.
; 0000 0094 // OC4D output: OC4D=Disc. /OC4D=Disc.
; 0000 0095 // Fault Protection: Off
; 0000 0096 // Fault Protection Noise Canceler: Off
; 0000 0097 // Fault Protection triggered on Falling Edge
; 0000 0098 // Timer4 Overflow Interrupt: Off
; 0000 0099 // Compare A Match Interrupt: Off
; 0000 009A // Compare B Match Interrupt: Off
; 0000 009B // Compare D Match Interrupt: Off
; 0000 009C // Fault Protection Interrupt: Off
; 0000 009D // Dead Time Prescaler: 1
; 0000 009E // Dead Time Rising Edge: 0.000 us
; 0000 009F // Dead Time Falling Edge: 0.000 us
; 0000 00A0 
; 0000 00A1 // Set Timer4 for synchronous operation
; 0000 00A2 PLLFRQ&=(1<<PINMUX) | (1<<PLLUSB) | (0<<PLLTM1) | (0<<PLLTM0) | (1<<PDIV3) | (1<<PDIV2) | (1<<PDIV1) | (1<<PDIV0);
	IN   R30,0x32
	ANDI R30,LOW(0xCF)
	OUT  0x32,R30
; 0000 00A3 
; 0000 00A4 TCCR4A=(0<<COM4A1) | (0<<COM4A0) | (0<<COM4B1) | (0<<COM4B0) | (0<<FOC4A) | (0<<FOC4B) | (0<<PWM4A) | (0<<PWM4B);
	LDI  R30,LOW(0)
	STS  192,R30
; 0000 00A5 TCCR4B=(0<<PWM4X) | (0<<PSR4) | (0<<DTPS41) | (0<<DTPS40) | (0<<CS43) | (0<<CS42) | (0<<CS41) | (0<<CS40);
	STS  193,R30
; 0000 00A6 TCCR4C=(0<<COM4A1S) | (0<<COM4A0S) | (0<<COM4B1S) | (0<<COM4B0S) | (0<<COM4D1) | (0<<COM4D0) | (0<<FOC4D) | (0<<PWM4D);
	STS  194,R30
; 0000 00A7 TCCR4D=(0<<FPIE4) | (0<<FPEN4) | (0<<FPNC4) | (0<<FPES4) | (0<<FPAC4) | (0<<FPF4) | (0<<WGM41) | (0<<WGM40);
	STS  195,R30
; 0000 00A8 TCCR4E=(0<<TLOCK4) | (0<<ENHC4) | (0<<OC4OE5) | (0<<OC4OE4) | (0<<OC4OE3) | (0<<OC4OE2) | (0<<OC4OE1) | (0<<OC4OE0);
	STS  196,R30
; 0000 00A9 TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00AA TCNT4=0x00;
	STS  190,R30
; 0000 00AB TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00AC OCR4A=0x00;
	STS  207,R30
; 0000 00AD TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00AE OCR4B=0x00;
	STS  208,R30
; 0000 00AF TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00B0 OCR4C=0x00;
	STS  209,R30
; 0000 00B1 TC4H=0x00;
	RCALL SUBOPT_0x0
; 0000 00B2 OCR4D=0x00;
	STS  210,R30
; 0000 00B3 DT4=0x00;
	LDI  R30,LOW(0)
	STS  212,R30
; 0000 00B4 
; 0000 00B5 // Timer/Counter 0 Interrupt(s) initialization
; 0000 00B6 TIMSK0=(0<<OCIE0B) | (0<<OCIE0A) | (0<<TOIE0);
	STS  110,R30
; 0000 00B7 
; 0000 00B8 // Timer/Counter 1 Interrupt(s) initialization
; 0000 00B9 TIMSK1=(0<<ICIE1) | (0<<OCIE1C) | (0<<OCIE1B) | (0<<OCIE1A) | (0<<TOIE1);
	STS  111,R30
; 0000 00BA 
; 0000 00BB // Timer/Counter 3 Interrupt(s) initialization
; 0000 00BC TIMSK3=(0<<ICIE3) | (0<<OCIE3C) | (0<<OCIE3B) | (0<<OCIE3A) | (0<<TOIE3);
	STS  113,R30
; 0000 00BD 
; 0000 00BE // Timer/Counter 4 Interrupt(s) initialization
; 0000 00BF TIMSK4=(0<<OCIE4D) | (0<<OCIE4A) | (0<<OCIE4B) | (0<<TOIE4);
	STS  114,R30
; 0000 00C0 
; 0000 00C1 // External Interrupt(s) initialization
; 0000 00C2 // INT0: Off
; 0000 00C3 // INT1: Off
; 0000 00C4 // INT2: Off
; 0000 00C5 // INT3: Off
; 0000 00C6 // INT6: Off
; 0000 00C7 EICRA=(0<<ISC31) | (0<<ISC30) | (0<<ISC21) | (0<<ISC20) | (0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	STS  105,R30
; 0000 00C8 EICRB=(0<<ISC61) | (0<<ISC60);
	STS  106,R30
; 0000 00C9 EIMSK=(0<<INT6) | (0<<INT3) | (0<<INT2) | (0<<INT1) | (0<<INT0);
	OUT  0x1D,R30
; 0000 00CA // PCINT0 interrupt: Off
; 0000 00CB // PCINT1 interrupt: Off
; 0000 00CC // PCINT2 interrupt: Off
; 0000 00CD // PCINT3 interrupt: Off
; 0000 00CE // PCINT4 interrupt: Off
; 0000 00CF // PCINT5 interrupt: Off
; 0000 00D0 // PCINT6 interrupt: Off
; 0000 00D1 // PCINT7 interrupt: Off
; 0000 00D2 PCMSK0=(0<<PCINT7) | (0<<PCINT6) | (0<<PCINT5) | (0<<PCINT4) | (0<<PCINT3) | (0<<PCINT2) | (0<<PCINT1) | (0<<PCINT0);
	STS  107,R30
; 0000 00D3 PCICR=(0<<PCIE0);
	STS  104,R30
; 0000 00D4 
; 0000 00D5 // USART1 initialization
; 0000 00D6 // USART1 disabled
; 0000 00D7 UCSR1B=(0<<RXCIE1) | (0<<TXCIE1) | (0<<UDRIE1) | (0<<RXEN1) | (0<<TXEN1) | (0<<UCSZ12) | (0<<RXB81) | (0<<TXB81);
	STS  201,R30
; 0000 00D8 
; 0000 00D9 // Analog Comparator initialization
; 0000 00DA // Analog Comparator: Off
; 0000 00DB // The Analog Comparator's positive input is
; 0000 00DC // connected to the AIN0 pin
; 0000 00DD // The Analog Comparator's negative input is
; 0000 00DE // connected to the AIN1 pin
; 0000 00DF ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x30,R30
; 0000 00E0 // Digital input buffer on AIN0: On
; 0000 00E1 DIDR1=(0<<AIN0D);
	LDI  R30,LOW(0)
	STS  127,R30
; 0000 00E2 
; 0000 00E3 // ADC initialization
; 0000 00E4 // ADC Clock frequency: 998.875 kHz
; 0000 00E5 // ADC Voltage Reference: AREF pin
; 0000 00E6 // ADC High Speed Mode: Off
; 0000 00E7 // ADC Auto Trigger Source: ADC Stopped
; 0000 00E8 // Digital input buffers on ADC0: On, ADC1: On
; 0000 00E9 // ADC4: On, ADC5: On, ADC6: On, ADC7: On
; 0000 00EA DIDR0=(0<<ADC7D) | (0<<ADC6D) | (0<<ADC5D) | (0<<ADC4D) | (0<<ADC1D) | (0<<ADC0D);
	STS  126,R30
; 0000 00EB // Digital input buffers on ADC8: On, ADC9: On, ADC10: On, ADC11: On
; 0000 00EC // ADC12: On, ADC13: On
; 0000 00ED DIDR2=(0<<ADC13D) | (0<<ADC12D) | (0<<ADC11D) | (0<<ADC10D) | (0<<ADC9D) | (0<<ADC8D);
	STS  125,R30
; 0000 00EE ADMUX=    ADC_VREF_TYPE;
	STS  124,R30
; 0000 00EF ADCSRA=(1<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (1<<ADPS1) | (1<<ADPS0);
	LDI  R30,LOW(131)
	STS  122,R30
; 0000 00F0 ADCSRB=(1<<ADHSM) | (0<<MUX5) | (0<<ADTS3) | (0<<ADTS2) | (0<<ADTS1) | (0<<ADTS0);
	LDI  R30,LOW(128)
	STS  123,R30
; 0000 00F1 
; 0000 00F2 // SPI initialization
; 0000 00F3 // SPI disabled
; 0000 00F4 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	LDI  R30,LOW(0)
	OUT  0x2C,R30
; 0000 00F5 
; 0000 00F6 // TWI initialization
; 0000 00F7 // TWI disabled
; 0000 00F8 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	STS  188,R30
; 0000 00F9 
; 0000 00FA // Alphanumeric LCD initialization
; 0000 00FB // Connections are specified in the
; 0000 00FC // Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
; 0000 00FD // RS - PORTB Bit 0
; 0000 00FE // RD - PORTB Bit 1
; 0000 00FF // EN - PORTB Bit 2
; 0000 0100 // D4 - PORTB Bit 4
; 0000 0101 // D5 - PORTB Bit 5
; 0000 0102 // D6 - PORTB Bit 6
; 0000 0103 // D7 - PORTB Bit 7
; 0000 0104 // Characters/line: 8
; 0000 0105 lcd_init(8);
	LDI  R26,LOW(8)
	RCALL _lcd_init
; 0000 0106 
; 0000 0107 while (1)
_0x8:
; 0000 0108       {
; 0000 0109 
; 0000 010A 
; 0000 010B       adc=read_adc(0)/200.6;
	LDI  R26,LOW(0)
	RCALL _read_adc
	CLR  R22
	CLR  R23
	RCALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x4348999A
	RCALL __DIVF21
	STS  _adc,R30
	STS  _adc+1,R31
	STS  _adc+2,R22
	STS  _adc+3,R23
; 0000 010C       lcd_clear();
	RCALL _lcd_clear
; 0000 010D       lcd_gotoxy(2,1);
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RCALL _lcd_gotoxy
; 0000 010E        lcd_gotoxy(0,0);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _lcd_gotoxy
; 0000 010F       lcd_puts("voltaje:");
	__POINTW2MN _0xB,0
	RCALL _lcd_puts
; 0000 0110 
; 0000 0111       sprintf(lcd,"%5.2f",adc);
	LDI  R30,LOW(_lcd)
	LDI  R31,HIGH(_lcd)
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,9
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_adc
	LDS  R31,_adc+1
	LDS  R22,_adc+2
	LDS  R23,_adc+3
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _sprintf
	ADIW R28,8
; 0000 0112       lcd_puts(lcd);
	LDI  R26,LOW(_lcd)
	LDI  R27,HIGH(_lcd)
	RCALL _lcd_puts
; 0000 0113       delay_ms(500);
	LDI  R26,LOW(500)
	LDI  R27,HIGH(500)
	RCALL _delay_ms
; 0000 0114 
; 0000 0115 
; 0000 0116 
; 0000 0117  }
	RJMP _0x8
; 0000 0118 }
_0xC:
	RJMP _0xC
; .FEND

	.DSEG
_0xB:
	.BYTE 0x9
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
     .EQU __sm_adc_noise_red=0x02 // 26022010_1
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif

	.CSEG
_put_buff_G100:
; .FSTART _put_buff_G100
	RCALL __SAVELOCR6
	MOVW R18,R26
	LDD  R21,Y+6
	ADIW R26,2
	RCALL __GETW1P
	SBIW R30,0
	BREQ _0x2000016
	MOVW R26,R18
	ADIW R26,4
	RCALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000018
	__CPWRN 16,17,2
	BRLO _0x2000019
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1RNS 18,4
_0x2000018:
	MOVW R26,R18
	ADIW R26,2
	RCALL SUBOPT_0x1
	SBIW R30,1
	ST   Z,R21
_0x2000019:
	MOVW R26,R18
	RCALL __GETW1P
	TST  R31
	BRMI _0x200001A
	RCALL SUBOPT_0x1
_0x200001A:
	RJMP _0x200001B
_0x2000016:
	MOVW R26,R18
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x200001B:
	RCALL __LOADLOCR6
	ADIW R28,7
	RET
; .FEND
__ftoe_G100:
; .FSTART __ftoe_G100
	RCALL SUBOPT_0x2
	LDI  R30,LOW(128)
	RCALL SUBOPT_0x3
	MOVW R20,R26
	LDD  R18,Y+10
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x200001F
	ST   -Y,R21
	ST   -Y,R20
	__POINTW2FN _0x2000000,0
	RCALL _strcpyf
	RJMP _0x20C0006
_0x200001F:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BRNE _0x200001E
	ST   -Y,R21
	ST   -Y,R20
	__POINTW2FN _0x2000000,1
	RCALL _strcpyf
	RJMP _0x20C0006
_0x200001E:
	LDD  R26,Y+11
	CPI  R26,LOW(0x7)
	BRLO _0x2000021
	LDI  R30,LOW(6)
	STD  Y+11,R30
_0x2000021:
	LDD  R17,Y+11
_0x2000022:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x2000024
	RCALL SUBOPT_0x4
	RJMP _0x2000022
_0x2000024:
	RCALL SUBOPT_0x5
	RCALL __CPD10
	BRNE _0x2000025
	LDI  R19,LOW(0)
	RCALL SUBOPT_0x4
	RJMP _0x2000026
_0x2000025:
	LDD  R19,Y+11
	RCALL SUBOPT_0x6
	BREQ PC+2
	BRCC PC+2
	RJMP _0x2000027
	RCALL SUBOPT_0x4
_0x2000028:
	RCALL SUBOPT_0x6
	BRLO _0x200002A
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x8
	RJMP _0x2000028
_0x200002A:
	RJMP _0x200002B
_0x2000027:
_0x200002C:
	RCALL SUBOPT_0x6
	BRSH _0x200002E
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0xA
	SUBI R19,LOW(1)
	RJMP _0x200002C
_0x200002E:
	RCALL SUBOPT_0x4
_0x200002B:
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xA
	RCALL SUBOPT_0x6
	BRLO _0x200002F
	RCALL SUBOPT_0x7
	RCALL SUBOPT_0x8
_0x200002F:
_0x2000026:
	LDI  R17,LOW(0)
_0x2000030:
	LDD  R30,Y+11
	CP   R30,R17
	BRLO _0x2000032
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0xD
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x7
	RCALL __DIVF21
	RCALL __CFD1U
	MOV  R16,R30
	PUSH R21
	PUSH R20
	__ADDWRN 20,21,1
	SUBI R30,-LOW(48)
	POP  R26
	POP  R27
	ST   X,R30
	MOV  R30,R16
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __CDF1
	RCALL SUBOPT_0xC
	RCALL __MULF12
	RCALL SUBOPT_0x7
	RCALL __SWAPD12
	RCALL __SUBF12
	RCALL SUBOPT_0xA
	MOV  R30,R17
	SUBI R17,-1
	CPI  R30,0
	BRNE _0x2000030
	MOVW R26,R20
	__ADDWRN 20,21,1
	LDI  R30,LOW(46)
	ST   X,R30
	RJMP _0x2000030
_0x2000032:
	PUSH R21
	PUSH R20
	__ADDWRN 20,21,1
	MOV  R30,R18
	POP  R26
	POP  R27
	ST   X,R30
	CPI  R19,0
	BRGE _0x2000034
	NEG  R19
	MOVW R26,R20
	LDI  R30,LOW(45)
	RJMP _0x2000119
_0x2000034:
	MOVW R26,R20
	LDI  R30,LOW(43)
_0x2000119:
	ST   X,R30
	__ADDWRN 20,21,1
	PUSH R21
	PUSH R20
	RCALL SUBOPT_0xF
	RCALL __DIVB21
	SUBI R30,-LOW(48)
	POP  R26
	POP  R27
	ST   X,R30
	PUSH R21
	PUSH R20
	RCALL SUBOPT_0xF
	RCALL __MODB21
	SUBI R30,-LOW(48)
	POP  R26
	POP  R27
	ST   X,R30
	MOVW R26,R20
	LDI  R30,LOW(0)
	ST   X,R30
_0x20C0006:
	RCALL __LOADLOCR6
	ADIW R28,16
	RET
; .FEND
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,63
	SBIW R28,17
	RCALL __SAVELOCR6
	LDI  R17,0
	__GETW1SX 88
	STD  Y+8,R30
	STD  Y+8+1,R31
	__GETW1SX 86
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000036:
	MOVW R26,R28
	SUBI R26,LOW(-(92))
	SBCI R27,HIGH(-(92))
	RCALL SUBOPT_0x1
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000038
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200003C
	CPI  R18,37
	BRNE _0x200003D
	LDI  R17,LOW(1)
	RJMP _0x200003E
_0x200003D:
	RCALL SUBOPT_0x10
_0x200003E:
	RJMP _0x200003B
_0x200003C:
	CPI  R30,LOW(0x1)
	BRNE _0x200003F
	CPI  R18,37
	BRNE _0x2000040
	RCALL SUBOPT_0x10
	RJMP _0x200011A
_0x2000040:
	LDI  R17,LOW(2)
	LDI  R30,LOW(0)
	STD  Y+21,R30
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000041
	LDI  R16,LOW(1)
	RJMP _0x200003B
_0x2000041:
	CPI  R18,43
	BRNE _0x2000042
	LDI  R30,LOW(43)
	STD  Y+21,R30
	RJMP _0x200003B
_0x2000042:
	CPI  R18,32
	BRNE _0x2000043
	LDI  R30,LOW(32)
	STD  Y+21,R30
	RJMP _0x200003B
_0x2000043:
	RJMP _0x2000044
_0x200003F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000045
_0x2000044:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000046
	ORI  R16,LOW(128)
	RJMP _0x200003B
_0x2000046:
	RJMP _0x2000047
_0x2000045:
	CPI  R30,LOW(0x3)
	BRNE _0x2000048
_0x2000047:
	CPI  R18,48
	BRLO _0x200004A
	CPI  R18,58
	BRLO _0x200004B
_0x200004A:
	RJMP _0x2000049
_0x200004B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200003B
_0x2000049:
	LDI  R20,LOW(0)
	CPI  R18,46
	BRNE _0x200004C
	LDI  R17,LOW(4)
	RJMP _0x200003B
_0x200004C:
	RJMP _0x200004D
_0x2000048:
	CPI  R30,LOW(0x4)
	BRNE _0x200004F
	CPI  R18,48
	BRLO _0x2000051
	CPI  R18,58
	BRLO _0x2000052
_0x2000051:
	RJMP _0x2000050
_0x2000052:
	ORI  R16,LOW(32)
	LDI  R26,LOW(10)
	MUL  R20,R26
	MOV  R20,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R20,R30
	RJMP _0x200003B
_0x2000050:
_0x200004D:
	CPI  R18,108
	BRNE _0x2000053
	ORI  R16,LOW(2)
	LDI  R17,LOW(5)
	RJMP _0x200003B
_0x2000053:
	RJMP _0x2000054
_0x200004F:
	CPI  R30,LOW(0x5)
	BREQ PC+2
	RJMP _0x200003B
_0x2000054:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x2000059
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x11
	LDD  R26,Z+4
	ST   -Y,R26
	RCALL SUBOPT_0x13
	RJMP _0x200005A
_0x2000059:
	CPI  R30,LOW(0x45)
	BREQ _0x200005D
	CPI  R30,LOW(0x65)
	BRNE _0x200005E
_0x200005D:
	RJMP _0x200005F
_0x200005E:
	CPI  R30,LOW(0x66)
	BRNE _0x2000060
_0x200005F:
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x15
	RCALL __GETD1P
	RCALL SUBOPT_0x16
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	LDD  R26,Y+13
	TST  R26
	BRMI _0x2000061
	LDD  R26,Y+21
	CPI  R26,LOW(0x2B)
	BREQ _0x2000063
	CPI  R26,LOW(0x20)
	BREQ _0x2000065
	RJMP _0x2000066
_0x2000061:
	RCALL SUBOPT_0x17
	RCALL __ANEGF1
	RCALL SUBOPT_0x16
	LDI  R30,LOW(45)
	STD  Y+21,R30
_0x2000063:
	SBRS R16,7
	RJMP _0x2000067
	LDD  R30,Y+21
	ST   -Y,R30
	RCALL SUBOPT_0x13
	RJMP _0x2000068
_0x2000067:
_0x2000065:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	ADIW R30,1
	STD  Y+14,R30
	STD  Y+14+1,R31
	SBIW R30,1
	LDD  R26,Y+21
	STD  Z+0,R26
_0x2000068:
_0x2000066:
	SBRS R16,5
	LDI  R20,LOW(6)
	CPI  R18,102
	BRNE _0x200006A
	RCALL SUBOPT_0x17
	RCALL __PUTPARD1
	ST   -Y,R20
	LDD  R26,Y+19
	LDD  R27,Y+19+1
	RCALL _ftoa
	RJMP _0x200006B
_0x200006A:
	RCALL SUBOPT_0x17
	RCALL __PUTPARD1
	ST   -Y,R20
	ST   -Y,R18
	LDD  R26,Y+20
	LDD  R27,Y+20+1
	RCALL __ftoe_G100
_0x200006B:
	RCALL SUBOPT_0x14
	RCALL SUBOPT_0x18
	RJMP _0x200006C
_0x2000060:
	CPI  R30,LOW(0x73)
	BRNE _0x200006E
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x19
	RCALL SUBOPT_0x18
	RJMP _0x200006F
_0x200006E:
	CPI  R30,LOW(0x70)
	BRNE _0x2000071
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x19
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	RCALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x200006F:
	ANDI R16,LOW(127)
	CPI  R20,0
	BREQ _0x2000073
	CP   R20,R17
	BRLO _0x2000074
_0x2000073:
	RJMP _0x2000072
_0x2000074:
	MOV  R17,R20
_0x2000072:
_0x200006C:
	LDI  R20,LOW(0)
	LDI  R30,LOW(0)
	STD  Y+20,R30
	LDI  R19,LOW(0)
	RJMP _0x2000075
_0x2000071:
	CPI  R30,LOW(0x64)
	BREQ _0x2000078
	CPI  R30,LOW(0x69)
	BRNE _0x2000079
_0x2000078:
	ORI  R16,LOW(4)
	RJMP _0x200007A
_0x2000079:
	CPI  R30,LOW(0x75)
	BRNE _0x200007B
_0x200007A:
	LDI  R30,LOW(10)
	STD  Y+20,R30
	SBRS R16,1
	RJMP _0x200007C
	__GETD1N 0x3B9ACA00
	RCALL SUBOPT_0x1A
	LDI  R17,LOW(10)
	RJMP _0x200007D
_0x200007C:
	__GETD1N 0x2710
	RCALL SUBOPT_0x1A
	LDI  R17,LOW(5)
	RJMP _0x200007D
_0x200007B:
	CPI  R30,LOW(0x58)
	BRNE _0x200007F
	ORI  R16,LOW(8)
	RJMP _0x2000080
_0x200007F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x20000BE
_0x2000080:
	LDI  R30,LOW(16)
	STD  Y+20,R30
	SBRS R16,1
	RJMP _0x2000082
	__GETD1N 0x10000000
	RCALL SUBOPT_0x1A
	LDI  R17,LOW(8)
	RJMP _0x200007D
_0x2000082:
	__GETD1N 0x1000
	RCALL SUBOPT_0x1A
	LDI  R17,LOW(4)
_0x200007D:
	CPI  R20,0
	BREQ _0x2000083
	ANDI R16,LOW(127)
	RJMP _0x2000084
_0x2000083:
	LDI  R20,LOW(1)
_0x2000084:
	SBRS R16,1
	RJMP _0x2000085
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x15
	ADIW R26,4
	RCALL __GETD1P
	RJMP _0x200011B
_0x2000085:
	SBRS R16,2
	RJMP _0x2000087
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x15
	ADIW R26,4
	RCALL __GETW1P
	RCALL __CWD1
	RJMP _0x200011B
_0x2000087:
	RCALL SUBOPT_0x11
	RCALL SUBOPT_0x12
	RCALL SUBOPT_0x15
	ADIW R26,4
	RCALL __GETW1P
	CLR  R22
	CLR  R23
_0x200011B:
	__PUTD1S 10
	SBRS R16,2
	RJMP _0x2000089
	LDD  R26,Y+13
	TST  R26
	BRPL _0x200008A
	RCALL SUBOPT_0x17
	RCALL __ANEGD1
	RCALL SUBOPT_0x16
	LDI  R30,LOW(45)
	STD  Y+21,R30
_0x200008A:
	LDD  R30,Y+21
	CPI  R30,0
	BREQ _0x200008B
	SUBI R17,-LOW(1)
	SUBI R20,-LOW(1)
	RJMP _0x200008C
_0x200008B:
	ANDI R16,LOW(251)
_0x200008C:
_0x2000089:
	MOV  R19,R20
_0x2000075:
	SBRC R16,0
	RJMP _0x200008D
_0x200008E:
	CP   R17,R21
	BRSH _0x2000091
	CP   R19,R21
	BRLO _0x2000092
_0x2000091:
	RJMP _0x2000090
_0x2000092:
	SBRS R16,7
	RJMP _0x2000093
	SBRS R16,2
	RJMP _0x2000094
	ANDI R16,LOW(251)
	LDD  R18,Y+21
	SUBI R17,LOW(1)
	RJMP _0x2000095
_0x2000094:
	LDI  R18,LOW(48)
_0x2000095:
	RJMP _0x2000096
_0x2000093:
	LDI  R18,LOW(32)
_0x2000096:
	RCALL SUBOPT_0x10
	SUBI R21,LOW(1)
	RJMP _0x200008E
_0x2000090:
_0x200008D:
_0x2000097:
	CP   R17,R20
	BRSH _0x2000099
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200009A
	RCALL SUBOPT_0x1B
	BREQ _0x200009B
	SUBI R21,LOW(1)
_0x200009B:
	SUBI R17,LOW(1)
	SUBI R20,LOW(1)
_0x200009A:
	LDI  R30,LOW(48)
	ST   -Y,R30
	RCALL SUBOPT_0x13
	CPI  R21,0
	BREQ _0x200009C
	SUBI R21,LOW(1)
_0x200009C:
	SUBI R20,LOW(1)
	RJMP _0x2000097
_0x2000099:
	MOV  R19,R17
	LDD  R30,Y+20
	CPI  R30,0
	BRNE _0x200009D
_0x200009E:
	CPI  R19,0
	BREQ _0x20000A0
	SBRS R16,3
	RJMP _0x20000A1
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	LPM  R18,Z+
	STD  Y+14,R30
	STD  Y+14+1,R31
	RJMP _0x20000A2
_0x20000A1:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	LD   R18,X+
	STD  Y+14,R26
	STD  Y+14+1,R27
_0x20000A2:
	RCALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x20000A3
	SUBI R21,LOW(1)
_0x20000A3:
	SUBI R19,LOW(1)
	RJMP _0x200009E
_0x20000A0:
	RJMP _0x20000A4
_0x200009D:
_0x20000A6:
	RCALL SUBOPT_0x1C
	RCALL __DIVD21U
	MOV  R18,R30
	CPI  R18,10
	BRLO _0x20000A8
	SBRS R16,3
	RJMP _0x20000A9
	SUBI R18,-LOW(55)
	RJMP _0x20000AA
_0x20000A9:
	SUBI R18,-LOW(87)
_0x20000AA:
	RJMP _0x20000AB
_0x20000A8:
	SUBI R18,-LOW(48)
_0x20000AB:
	SBRC R16,4
	RJMP _0x20000AD
	CPI  R18,49
	BRSH _0x20000AF
	RCALL SUBOPT_0x1D
	__CPD2N 0x1
	BRNE _0x20000AE
_0x20000AF:
	RJMP _0x20000B1
_0x20000AE:
	CP   R20,R19
	BRSH _0x200011C
	CP   R21,R19
	BRLO _0x20000B4
	SBRS R16,0
	RJMP _0x20000B5
_0x20000B4:
	RJMP _0x20000B3
_0x20000B5:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x20000B6
_0x200011C:
	LDI  R18,LOW(48)
_0x20000B1:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x20000B7
	RCALL SUBOPT_0x1B
	BREQ _0x20000B8
	SUBI R21,LOW(1)
_0x20000B8:
_0x20000B7:
_0x20000B6:
_0x20000AD:
	RCALL SUBOPT_0x10
	CPI  R21,0
	BREQ _0x20000B9
	SUBI R21,LOW(1)
_0x20000B9:
_0x20000B3:
	SUBI R19,LOW(1)
	RCALL SUBOPT_0x1C
	RCALL __MODD21U
	RCALL SUBOPT_0x16
	LDD  R30,Y+20
	RCALL SUBOPT_0x1D
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __DIVD21U
	RCALL SUBOPT_0x1A
	__GETD1S 16
	RCALL __CPD10
	BREQ _0x20000A7
	RJMP _0x20000A6
_0x20000A7:
_0x20000A4:
	SBRS R16,0
	RJMP _0x20000BA
_0x20000BB:
	CPI  R21,0
	BREQ _0x20000BD
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	RCALL SUBOPT_0x13
	RJMP _0x20000BB
_0x20000BD:
_0x20000BA:
_0x20000BE:
_0x200005A:
_0x200011A:
	LDI  R17,LOW(0)
_0x200003B:
	RJMP _0x2000036
_0x2000038:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL __GETW1P
	RCALL __LOADLOCR6
	ADIW R28,63
	ADIW R28,31
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	RCALL __SAVELOCR6
	MOVW R30,R28
	RCALL __ADDW1R15
	__GETWRZ 20,21,14
	MOV  R0,R20
	OR   R0,R21
	BRNE _0x20000BF
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x20C0005
_0x20000BF:
	MOVW R26,R28
	ADIW R26,8
	RCALL __ADDW2R15
	MOVW R16,R26
	__PUTWSR 20,21,8
	LDI  R30,LOW(0)
	STD  Y+10,R30
	STD  Y+10+1,R30
	MOVW R26,R28
	ADIW R26,12
	RCALL __ADDW2R15
	RCALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,12
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x20C0005:
	RCALL __LOADLOCR6
	ADIW R28,12
	POP  R15
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x01
	.EQU __sm_mask=0x0E
     .EQU __sm_adc_noise_red=0x02 // 26022010_1
	.EQU __sm_powerdown=0x04
	.EQU __sm_powersave=0x06
	.EQU __sm_standby=0x0C
	.EQU __sm_ext_standby=0x0E
	.SET power_ctrl_reg=smcr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G101:
; .FSTART __lcd_write_nibble_G101
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x5
	ANDI R30,LOW(0xF)
	MOV  R26,R30
	MOV  R30,R17
	ANDI R30,LOW(0xF0)
	OR   R30,R26
	OUT  0x5,R30
	__DELAY_USB 13
	SBI  0x5,2
	__DELAY_USB 13
	CBI  0x5,2
	__DELAY_USB 13
	RJMP _0x20C0004
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 133
	ADIW R28,1
	RET
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R17
	ST   -Y,R16
	MOV  R17,R26
	LDD  R16,Y+2
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	ADD  R30,R16
	MOV  R26,R30
	RCALL __lcd_write_data
	MOV  R4,R16
	MOV  R3,R17
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x1E
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x1E
	LDI  R30,LOW(0)
	MOV  R3,R30
	MOV  R4,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R17
	MOV  R17,R26
	CPI  R17,10
	BREQ _0x2020005
	CP   R4,R6
	BRLO _0x2020004
_0x2020005:
	LDI  R30,LOW(0)
	ST   -Y,R30
	INC  R3
	MOV  R26,R3
	RCALL _lcd_gotoxy
	CPI  R17,10
	BREQ _0x20C0004
_0x2020004:
	INC  R4
	SBI  0x5,0
	MOV  R26,R17
	RCALL __lcd_write_data
	CBI  0x5,0
	RJMP _0x20C0004
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	RCALL __SAVELOCR4
	MOVW R18,R26
_0x2020008:
	MOVW R26,R18
	__ADDWRN 18,19,1
	LD   R30,X
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x202000A
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2020008
_0x202000A:
	RCALL __LOADLOCR4
	JMP  _0x20C0003
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R17
	MOV  R17,R26
	IN   R30,0x4
	ORI  R30,LOW(0xF0)
	OUT  0x4,R30
	SBI  0x4,2
	SBI  0x4,0
	SBI  0x4,1
	CBI  0x5,2
	CBI  0x5,0
	CBI  0x5,1
	MOV  R6,R17
	MOV  R30,R17
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	MOV  R30,R17
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	LDI  R26,LOW(20)
	LDI  R27,0
	RCALL _delay_ms
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0x1F
	RCALL SUBOPT_0x1F
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G101
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x20C0004:
	LD   R17,Y+
	RET
; .FEND

	.CSEG

	.CSEG
_strcpyf:
; .FSTART _strcpyf
	ST   -Y,R27
	ST   -Y,R26
    ld   r30,y+
    ld   r31,y+
    ld   r26,y+
    ld   r27,y+
    movw r24,r26
strcpyf0:
	lpm  r0,z+
    st   x+,r0
    tst  r0
    brne strcpyf0
    movw r30,r24
    ret
; .FEND
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.CSEG
_ftrunc:
; .FSTART _ftrunc
	RCALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
; .FEND
_floor:
; .FSTART _floor
	RCALL __PUTPARD2
	RCALL __GETD2S0
	RCALL _ftrunc
	RCALL __PUTD1S0
    brne __floor1
__floor0:
	RCALL SUBOPT_0x20
	RJMP _0x20C0003
__floor1:
    brtc __floor0
	RCALL SUBOPT_0x20
	__GETD2N 0x3F800000
	RCALL __SUBF12
_0x20C0003:
	ADIW R28,4
	RET
; .FEND

	.CSEG
_ftoa:
; .FSTART _ftoa
	RCALL SUBOPT_0x2
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x3
	MOVW R18,R26
	LDD  R21,Y+10
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	CPI  R30,LOW(0xFFFF)
	LDI  R26,HIGH(0xFFFF)
	CPC  R31,R26
	BRNE _0x20A000D
	ST   -Y,R19
	ST   -Y,R18
	__POINTW2FN _0x20A0000,0
	RCALL _strcpyf
	RJMP _0x20C0002
_0x20A000D:
	CPI  R30,LOW(0x7FFF)
	LDI  R26,HIGH(0x7FFF)
	CPC  R31,R26
	BRNE _0x20A000C
	ST   -Y,R19
	ST   -Y,R18
	__POINTW2FN _0x20A0000,1
	RCALL _strcpyf
	RJMP _0x20C0002
_0x20A000C:
	LDD  R26,Y+14
	TST  R26
	BRPL _0x20A000F
	RCALL SUBOPT_0x21
	RCALL __ANEGF1
	RCALL SUBOPT_0x22
	MOVW R26,R18
	__ADDWRN 18,19,1
	LDI  R30,LOW(45)
	ST   X,R30
_0x20A000F:
	CPI  R21,7
	BRLO _0x20A0010
	LDI  R21,LOW(6)
_0x20A0010:
	MOV  R17,R21
_0x20A0011:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x20A0013
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0xD
	RCALL SUBOPT_0x23
	RJMP _0x20A0011
_0x20A0013:
	RCALL SUBOPT_0x24
	RCALL __ADDF12
	RCALL SUBOPT_0x22
	LDI  R17,LOW(0)
	__GETD1N 0x3F800000
	RCALL SUBOPT_0x23
_0x20A0014:
	RCALL SUBOPT_0x24
	RCALL __CMPF12
	BRLO _0x20A0016
	RCALL SUBOPT_0x4
	SUBI R17,-LOW(1)
	CPI  R17,39
	BRLO _0x20A0017
	ST   -Y,R19
	ST   -Y,R18
	__POINTW2FN _0x20A0000,5
	RCALL _strcpyf
	RJMP _0x20C0002
_0x20A0017:
	RJMP _0x20A0014
_0x20A0016:
	CPI  R17,0
	BRNE _0x20A0018
	MOVW R26,R18
	__ADDWRN 18,19,1
	LDI  R30,LOW(48)
	ST   X,R30
	RJMP _0x20A0019
_0x20A0018:
_0x20A001A:
	MOV  R30,R17
	SUBI R17,1
	CPI  R30,0
	BREQ _0x20A001C
	RCALL SUBOPT_0xC
	RCALL SUBOPT_0xD
	RCALL SUBOPT_0xB
	RCALL SUBOPT_0xE
	RCALL SUBOPT_0x25
	RCALL __DIVF21
	RCALL __CFD1U
	MOV  R16,R30
	PUSH R19
	PUSH R18
	RCALL SUBOPT_0x26
	POP  R26
	POP  R27
	ST   X,R30
	MOV  R30,R16
	LDI  R31,0
	RCALL SUBOPT_0xC
	RCALL __CWD1
	RCALL __CDF1
	RCALL __MULF12
	RCALL SUBOPT_0x25
	RCALL __SWAPD12
	RCALL __SUBF12
	RCALL SUBOPT_0x22
	RJMP _0x20A001A
_0x20A001C:
_0x20A0019:
	CPI  R21,0
	BREQ _0x20C0001
	MOVW R26,R18
	__ADDWRN 18,19,1
	LDI  R30,LOW(46)
	ST   X,R30
_0x20A001E:
	MOV  R30,R21
	SUBI R21,1
	CPI  R30,0
	BREQ _0x20A0020
	RCALL SUBOPT_0x25
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x22
	RCALL SUBOPT_0x21
	RCALL __CFD1U
	MOV  R16,R30
	PUSH R19
	PUSH R18
	RCALL SUBOPT_0x26
	POP  R26
	POP  R27
	ST   X,R30
	MOV  R30,R16
	LDI  R31,0
	RCALL SUBOPT_0x25
	RCALL __CWD1
	RCALL __CDF1
	RCALL __SWAPD12
	RCALL __SUBF12
	RCALL SUBOPT_0x22
	RJMP _0x20A001E
_0x20A0020:
_0x20C0001:
	MOVW R26,R18
	LDI  R30,LOW(0)
	ST   X,R30
_0x20C0002:
	RCALL __LOADLOCR6
	ADIW R28,15
	RET
; .FEND

	.DSEG

	.CSEG

	.DSEG
_adc:
	.BYTE 0x4
_lcd:
	.BYTE 0x8
__base_y_G101:
	.BYTE 0x4
__seed_G105:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x0:
	LDI  R30,LOW(0)
	STS  191,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x1:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2:
	SBIW R28,4
	LDI  R30,LOW(0)
	ST   Y,R30
	STD  Y+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	STD  Y+2,R30
	LDI  R30,LOW(63)
	STD  Y+3,R30
	RCALL __SAVELOCR6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:46 WORDS
SUBOPT_0x4:
	__GETD2S 6
	__GETD1N 0x41200000
	RCALL __MULF12
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	__GETD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:22 WORDS
SUBOPT_0x6:
	__GETD1S 6
	__GETD2S 12
	RCALL __CMPF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x7:
	__GETD2S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x8:
	__GETD1N 0x3DCCCCCD
	RCALL __MULF12
	__PUTD1S 12
	SUBI R19,-LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x9:
	__GETD1N 0x41200000
	RCALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xA:
	__PUTD1S 12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xB:
	__GETD2N 0x3F000000
	RCALL __ADDF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xC:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0xD:
	__GETD1N 0x3DCCCCCD
	RCALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xE:
	MOVW R26,R30
	MOVW R24,R22
	RCALL _floor
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	__ADDWRN 20,21,1
	MOV  R26,R19
	LDI  R30,LOW(10)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x10:
	ST   -Y,R18
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x11:
	__GETW1SX 90
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:28 WORDS
SUBOPT_0x12:
	SBIW R30,4
	__PUTW1SX 90
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x13:
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LDD  R30,Y+9
	LDD  R31,Y+9+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	MOVW R30,R28
	ADIW R30,22
	STD  Y+14,R30
	STD  Y+14+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:23 WORDS
SUBOPT_0x15:
	__GETW2SX 90
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x16:
	__PUTD1S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x17:
	__GETD1S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	RCALL _strlen
	MOV  R17,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x19:
	RCALL SUBOPT_0x15
	ADIW R26,4
	RCALL __GETW1P
	STD  Y+14,R30
	STD  Y+14+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x1A:
	__PUTD1S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x1B:
	ANDI R16,LOW(251)
	LDD  R30,Y+21
	ST   -Y,R30
	__GETW2SX 87
	__GETW1SX 89
	ICALL
	CPI  R21,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x1C:
	__GETD1S 16
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	__GETD2S 16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1E:
	RCALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x1F:
	LDI  R26,LOW(48)
	RCALL __lcd_write_nibble_G101
	__DELAY_USW 200
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	RCALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	__GETD1S 11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x22:
	__PUTD1S 11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x23:
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x24:
	__GETD1S 6
	__GETD2S 11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x25:
	__GETD2S 11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x26:
	__ADDWRN 18,19,1
	MOV  R30,R16
	SUBI R30,-LOW(48)
	RET

;RUNTIME LIBRARY

	.CSEG
__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__ADDW1R15:
	CLR  R0
	ADD  R30,R15
	ADC  R31,R0
	RET

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CBD1:
	MOV  R31,R30
	ADD  R31,R31
	SBC  R31,R31
	MOV  R22,R31
	MOV  R23,R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__DIVB21U:
	CLR  R0
	LDI  R25,8
__DIVB21U1:
	LSL  R26
	ROL  R0
	SUB  R0,R30
	BRCC __DIVB21U2
	ADD  R0,R30
	RJMP __DIVB21U3
__DIVB21U2:
	SBR  R26,1
__DIVB21U3:
	DEC  R25
	BRNE __DIVB21U1
	MOV  R30,R26
	MOV  R26,R0
	RET

__DIVB21:
	RCALL __CHKSIGNB
	RCALL __DIVB21U
	BRTC __DIVB211
	NEG  R30
__DIVB211:
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	MOVW R20,R0
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__MODB21:
	CLT
	SBRS R26,7
	RJMP __MODB211
	NEG  R26
	SET
__MODB211:
	SBRC R30,7
	NEG  R30
	RCALL __DIVB21U
	MOV  R30,R26
	BRTC __MODB212
	NEG  R30
__MODB212:
	RET

__MODD21U:
	RCALL __DIVD21U
	MOVW R30,R26
	MOVW R22,R24
	RET

__CHKSIGNB:
	CLT
	SBRS R30,7
	RJMP __CHKSB1
	NEG  R30
	SET
__CHKSB1:
	SBRS R26,7
	RJMP __CHKSB2
	NEG  R26
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSB2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	MOVW R22,R30
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	MOVW R20,R18
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	wdr
	__DELAY_USW 0x7CE
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

;END OF CODE MARKER
__END_OF_CODE:
