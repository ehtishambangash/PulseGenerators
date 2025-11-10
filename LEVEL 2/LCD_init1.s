	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT LCD_init1
	IMPORT BusyWait
	IMPORT LCD_command	
	 
CLEAR       EQU		0X01
HOME        EQU		0X02
LCD_ON      EQU		0X0C
BLINK       EQU		0X0F
CURSOR_ON   EQU		0X0E
LEFT        EQU		0X10
RIGHT       EQU		0X14
NEXT_LINE   EQU		0xC0
FOURBIT     EQU		0x28    ;0b00101000 = 0x28
LCD_OFF     EQU		0x0A
	
LCD_init1
	PUSH{R0-R7,LR}
	
	;Set bit 1 GPIO0 data direction register to set PIO0_1, PIO0_2, PIO0_3, PIO0_4 and PIO0_7 as output
	;for lcd to display 
    ;Load the address of GPIO0DIR into R4	page 193
    LDR R4, =(GPIO0DIR)
	;then store 1 to PIO0_1, PIO0_2, PIO0_3, PIO0_4 and PIO0_7
    MOVS R5, #(0x9E);
    ; Store the new value of R5 into GPIO0DIR;
    STR R5, [R4];
	
	;Set bit 1 GPIO1 data direction register to set PIO1_8 as output
	LDR R4, =(GPIO1DIR)
	MOVS R5, #0x1			;Load the value of GPIO1DIR into R5
	MOVS R5, R5, LSL #8		;Load a bit pattern 0x1 into R5 and shift left by 8 position to set bit 1
	ORRS R5, R4,R5			;Apply bitwise OR operation between R4(value of GPIO1DIR) and R5(bit pattern)
	STR R5, [R4]
	
	POP {R0-R7,PC}
	ALIGN
	END