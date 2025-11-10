 AREA PROGRAM, CODE, READONLY
 INCLUDE	LPC11xx.inc
 EXPORT	Name
 IMPORT BusyWait
 IMPORT	print_string
 IMPORT LCD_command 

	
Name
	PUSH{R0-R7,LR}

	LDR R3, =string
	
	MOVS	R0, #0x01	;clear the lcd screen
	BL		LCD_command
	
	BL print_string
	
	MOVS		R0, #0x0C	;cursor off, blinking off
	BL		LCD_command

	POP {R0-R7,PC}
	
string		DCB		"Andrey Kretsu", 0
	ALIGN	
	END