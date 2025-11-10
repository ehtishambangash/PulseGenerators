 AREA PROGRAM, CODE, READONLY
 INCLUDE	LPC11xx.inc
 EXPORT LCD_command
 IMPORT BusyWait
	 
OFFSET_E	EQU		8
OFFSET_RS	EQU		7
OFFSET_DB	EQU		1
	
	
DELAY		EQU		500

SIG_EN		RN	7
payload		RN	6

LCD_command
	PUSH{R0-R7,LR}

	MOVS SIG_EN, #0x01
	
	LDR  R4, =(GPIO0DATA)   ;clear RS and data pins
	LDR R5, =0xFFFFFF61	
	ANDS R5, R4, R5
	STR  R5, [R4]
	
	LDR  R4, =(GPIO1DATA)	;clear E
	LDR R5, =0xFFFFFEFF
	ANDS R5, R4, R5
	STR  R5, [R4]

	
Load_UpperDB
	
	;== Split data into upper bit
	
	MOVS payload, R0, LSR #4
	MOVS R3, #0x0F
	ANDS payload,payload, R3

	;===Clear DB PINs====
	LDR  R4, =(GPIO0DATA)
	LDR R5, =0xFFFFFFE1
	STR  R5, [R4]
	
	;== Send upper 4-bit
	LDR R4, =(GPIO0DATA)
	MOVS R5, payload, LSL #OFFSET_DB
	STR R5, [R4]
	
	;;===Delay
	LDR R3, =DELAY
	BL BusyWait
	
	;==Set E;;;
	LDR R4, =(GPIO1DATA)
	MOVS R5, #0x1
	MOVS R5, R5, LSL #OFFSET_E
	STR	R5, [R4]
	
	;===Delay
	LDR R3, =DELAY
	BL BusyWait
	
	
	;==Clear E
	
	LDR R4, =(GPIO1DATA)
	MOVS R5, #0x0
	MOVS R5, R5, LSL #OFFSET_E      ;Clear only E pin
	STR	R5, [R4]
	
	;===Delay
	LDR R3, =DELAY
	BL BusyWait
	
Load_LowerDB

	;==split data into lower 4-bit
	
	MOVS payload, R0
	MOVS R3, #0x0F
	ANDS payload, payload, R3
	
	;===Clear DB PINs====
	LDR  R4, =(GPIO0DATA)
	LDR R5, =0xFFFFFFE1
	STR  R5, [R4]

	;== Send lower 4-bit
	LDR R4, =(GPIO0DATA)
	MOVS R5, payload, LSL #OFFSET_DB 
	
	STR R5, [R4]
	
	;;===Delay
	LDR R3, =DELAY
	BL BusyWait
	
	;==Set E;;;
	LDR R4, =(GPIO1DATA)
	MOVS R5, #0x1
	MOVS R5, R5, LSL #OFFSET_E
	STR	R5, [R4]
	
	;===Delay
	LDR R3, =DELAY
	BL BusyWait
	
	
	;==Clear E
	
	LDR R4, =(GPIO1DATA)
	MOVS R5, #0x0
	MOVS R5, R5, LSL #OFFSET_E	;Clear only E pin
	STR	R5, [R4]
	
	;===Delay
	LDR R3, =DELAY
	BL BusyWait
	
	LDR R3, =10000
	BL BusyWait
	
	POP {R0-R7,PC}
	ALIGN
	END