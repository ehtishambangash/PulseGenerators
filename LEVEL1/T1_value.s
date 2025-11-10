	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT T1_value
	IMPORT LCD_data
	IMPORT LCD_init
	IMPORT LCD_init1		
	IMPORT BusyWait
	IMPORT Blinking	
	IMPORT MemLoc
	
T1_value
 
	PUSH{R0-R5,LR}
	
	CMP R2, #0x23		;compare if "#" is pressed
	BEQ pound
	
	BL LCD_init1
	
	MOV R0, R2			;move the value from r2 to r0 and pass to LCD_data
						;to display keypad entry on LCD					
	BL LCD_data
	
	;=====DELAY========
	LDR	R3, =0x10000
	BL BusyWait
	
	CMP R6, #0x42		;compare if B is pressed
	BNE done
	
	CMP R7, #0		;comparing and see if first number is pressed
	BEQ ones_place
	
	
	SUBS R2, R2, #0x30	;Subtracting 30 from Hex and convert to decimal number
	MOVS R0, #0xA		;Move 10 to R0 ;
	MULS R7, R0, R7		;Multiply Dec value by 10 and create a Tenth value
	ADDS R7, R2, R7		;Add 1st*10 + 2nd together to get a single value
	
	B done
	
ones_place
	SUBS R2, R2, #0x30	;Subtracting 30 from Hex and convert to decimal number
	MOVS R7, R2 		;Move decimal number to global register R7	
	
	B done
	
	
pound
	MOVS R4, R7			;Move R7 to R3 T0 value
	BL MemLoc

	MOVS R1, #0xC		;Move 12 to R0 ;
	MULS R7, R1, R7		;Multiply Dec value by 12 and store to R7, for total clicks
	MOVS R4, R7			;Move R7 to R4 T1 value
	
    ;======== Generating a total period pulse ==============
	BL Blinking
	
	MOVS R7, #0x0		;clear the counter
done
	POP{R0-R5,PC}
	ALIGN
	END	