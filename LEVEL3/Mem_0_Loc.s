	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT Mem_0_Loc
	IMPORT LCD_data
	IMPORT LCD_init
	IMPORT LCD_command
	IMPORT LCD_init1
	IMPORT BusyWait
    IMPORT print_string	
	IMPORT division
	
Mem_0_Loc
 
	PUSH{R0-R7,LR}
	
	;============ memory 0 =====================
	
	;T0	
	LDR R0, = 0x10001000		;load r0 with the temp source address
	LDR	R3, =0x1000		;adds delay for memory storing
	BL BusyWait
	LDR R1,[R0]					;extract value from R0 to R1
	LDR	R3, =0x1000		;adds delay for memory storing
	BL BusyWait
	LDR R3, = 0x10001200		;load r1 with the source address
	STR R1,[R3]
	
	BL LCD_init1			;initialize the display
	
	MOVS R0, #0x01			;clear the lcd screen
	BL LCD_command
	
	BL division

	MOVS R0, #0xC0			;Force cursor to begin of 2nd line
	BL LCD_command	
	
	;T1
	LDR R0, = 0x10000800		;load r0 with the temp source address 
	LDR	R3, =0x1000		;adds delay for memory storing
	BL BusyWait
	LDR R1,[R0]					;extract value from R0 to R1
	LDR	R3, =0x1000		;adds delay for memory storing
	BL BusyWait
	LDR R3, = 0x10001300		;load r1 with the source address
	STR R1,[R3]
	
	BL division
	
	POP{R0-R7,PC}
	ALIGN
	END