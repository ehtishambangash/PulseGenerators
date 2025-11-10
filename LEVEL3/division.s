	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT division
	IMPORT LCD_data
	IMPORT BusyWait
		
division
	PUSH{R0-R4,LR}
	
	LDR R3, =0xF4240		;load 1,000,000 to R3
	MOVS R4, #0x0			;move R4 with 0 to reset to store the result
Loop
	ADDS R4, R4, #1			;add 1 to R4
	SUBS R1, R1, R3			;subtract R1 value from R3 and store to R1
	BPL Loop				;loop until positive or zero
	ADDS R2, R1, R3 		;R2 is remainder, adding R1 and R3 and store to R2
	SUBS R4, R4, #1			;R4 is quotion, subtract 1 from R4
	
	ADDS R4, R4, #0x30		;Adding 30 to decimal and convert to Hex number
	
	MOVS R0, R4				;move the value from r4 to r0 and pass to LCD_data
							;to display T0 value on LCD	
	
	BL LCD_data				;display value on LCD
	
	;=====DELAY========
	LDR	R3, =0x1000
	BL BusyWait
	
	ADDS R2, R2, #0x30		;Adding 30 to decimal and convert to Hex number
	
	MOVS R0, R2				;move the value from r2 to r0 and pass to LCD_data
							;to display remainder on LCD	
							
	BL LCD_data				;display value on LCD
	
	;=====DELAY========
	LDR	R3, =0x1000
	BL BusyWait						
			
done
	POP{R0-R4,PC}
	ALIGN
	END