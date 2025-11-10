 AREA PROGRAM, CODE, READONLY
 INCLUDE	LPC11xx.inc
 EXPORT LCD_data
 IMPORT BusyWait
 IMPORT LCD_command
	 
DELAY		EQU		500
RS_DATA		EQU		1	;RS = 1 for Data mode
RS_CMD		EQU		0	;RS = 0 for command mode

OFFSET_E	EQU		8
OFFSET_RS	EQU		7
OFFSET_DB	EQU		1

SIG_EN		RN	7
payload		RN	6

LCD_data
	PUSH{R0-R7,LR}

	MOVS	R1, #RS_DATA		;Set LCD Mode
	MOVS	SIG_EN, #0x01
	
	;======= Begin Data loading sequence========
	
	LDR  R4, =(GPIO0DATA)
	LDR R5, =0xFFFFFFE1		;Clear E
	STR  R5, [R4]
	
	LDR  R4, =(GPIO1DATA)	;Clear RS
	LDR R5, =0xFFFFFEFF
	STR  R5, [R4]
	
	;==set RS (Data mode) ====
	LDR R4, =(GPIO0DATA)
	MOVS R5, #0x01
	MOVS R5, R5, LSL #OFFSET_RS
	STR R5, [R4]
	
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
	MOVS R2, #0x80
	ORRS R5, R2, R5
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
	MOVS R5, R5, LSL #OFFSET_E
	STR	R5, [R4]
	
Load_LowerDB

	;==split data into lower 4-bit
	
	MOVS payload, R0
	MOVS R3, #0x0F
	ANDS payload, R3
	
	;===Clear DB PINs====
	LDR  R4, =(GPIO0DATA)
	LDR R5, =0xFFFFFFE1
	STR  R5, [R4]
	
	;== Send lower 4-bit
	LDR R4, =(GPIO0DATA)
	MOVS R5, payload, LSL #OFFSET_DB
	MOVS R2, #0x80
	ORRS R5, R2, R5
	STR R5, [R4]
	
	;;===Delay
	LDR R3, =DELAY
	BL BusyWait
	
	;==Set E;;;
	LDR R4, =(GPIO1DATA)
	MOVS R5, #0x1
	MOVS R5, R5, LSL #OFFSET_E		;Clear only E pin
	STR	R5, [R4]
	
	;===Delay
	LDR R3, =DELAY
	BL BusyWait
	
	
	;==Clear E
	
	LDR R4, =(GPIO1DATA)
	MOVS R5, #0x0
	MOVS R5, R5, LSL #OFFSET_E	;Clear only E pin
	STR	R5, [R4]
	
Post_processing
   ;;delay to allow LCD to process information
	
	LDR R3, =10000
	BL BusyWait
	
	POP {R0-R7,PC}
	ALIGN
	END