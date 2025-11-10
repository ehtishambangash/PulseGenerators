	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT DisplayChan
	IMPORT LCD_init	
	IMPORT LCD_command	
	IMPORT print_string
	
DisplayChan
	PUSH{R0-R7,LR}
	
	LDR R3, =string
	
	MOVS R0, #0x01	;clear the lcd screen
	BL LCD_command
	
	BL print_string
	
	MOVS R0, #0xC0	;Force cursor to begin of 2nd line
	BL LCD_command
	
	POP {R0-R7,PC}
	
string		DCB		"Channel?", 0

	ALIGN	
	END