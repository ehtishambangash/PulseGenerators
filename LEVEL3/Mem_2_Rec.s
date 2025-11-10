	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT Mem_2_Rec
	IMPORT LCD_data
	IMPORT LCD_init	
	IMPORT BusyWait
	IMPORT LCD_command
	IMPORT division
	IMPORT LCD_init1
	IMPORT MR0_input
	IMPORT MR1_input
	
Mem_2_Rec

	PUSH{R0-R7,LR}
	
	;============ memory 2 =====================
	
	;T0
	LDR R0, = 0x10001200		;load r0 with the source address 
	ADDS R0, R0, #8
	LDR	R3, =0x1000		;adds delay for memory storing
	BL BusyWait
	MOVS R1, R0					;add 4 bits to address stored at R0
	
	BL LCD_init1			;initialize the display
	
	BL division				;call the division
	
	MOVS R0, #0x01			;clear the lcd screen
	BL LCD_command
	
	MOVS R3, R4				;move value from R4 to R3
	
	BL MR0_input
	
	MOVS R0, R4				;move the value from r4 to r0 and pass to LCD_data
							;to display T0 value on LCD	
	
	BL LCD_data				;display value on LCD
	
		;=====DELAY========
	LDR	R3, =0x1000
	BL BusyWait

	MOVS R0, #0xC0	;Force cursor to begin of 2nd line
	BL LCD_command	

	;T1
	LDR R0, = 0x10001300		;load r0 with the source address 
	ADDS R0, R0, #8
	LDR	R3, =0x1000		;adds delay for memory storing
	BL BusyWait
	LDR R1,[R0]					;load the value from the memory
	
	BL division				;call the division
	
	BL MR1_input
	
	MOVS R0, R4				;move the value from r4 to r0 and pass to LCD_data
							;to display T0 value on LCD	
	
	BL LCD_data				;display value on LCD
	
		;=====DELAY========
	LDR	R3, =0x1000
	BL BusyWait
	
	POP{R0-R7,PC}
	ALIGN
	END