	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT MemRec
	IMPORT LCD_data
	IMPORT LCD_init	
	IMPORT BusyWait
	
MemRec
 
	PUSH{R0-R5,LR}
	
	;	;========== Display T0 on 1st row on LCD =====================
;	
;	;recall T0 from memory
;	LDR R0, = 0x10001000		;load r0 with the source address 
;	LDR R1,[R0]					;load the value from the memory
;	LDR R3, =0xA			;load R3 with value 10
;	LDR R7, =0x0			;load R7 with 0 to reset to store the result
;	
;	BL division				;call the division
;	
;	BL LCD_init1			;initialize the display
;	MOVS R0, #0x01			;clear the lcd screen
;	BL LCD_command	
;	
;	MOVS R0, R7				;move the value from r4 to r0 and pass to LCD_data
;							;to display T0 value on LCD		
;	
;	BL LCD_data				;display T0 value on LCD	

;	MOVS R0, #0xC0			;Force cursor to begin of 2nd line
;	BL LCD_command
;	
;	;========== Display T1 on 2nd row on LCD =====================
;	
;	;recall T1 from memory
;	LDR R0, = 0x10001200		;load r0 with the source address 
;	LDR R1,[R0]					;load the value from the memory
;	LDR R3, =0xA			;load R3 with value 10
;	LDR R7, =0x0			;load R4 with 0 to reset to store the result
;	
;	BL division				;call the division
;	
;	BL LCD_init1			;initialize the display	
;	
;	MOVS R0, R7				;move the value from r4 to r0 and pass to LCD_data
;							;to display T1 value on LCD		

;	BL LCD_data				;display T1 value on LCD	
	
done
	POP{R0-R5,PC}
	ALIGN
	END	