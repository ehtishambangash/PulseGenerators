 AREA PROGRAM, CODE, READONLY
 INCLUDE	LPC11xx.inc
 EXPORT Chan_LED_on
	 
	 
Chan_LED_on
	PUSH{R0-R7,LR}


	;=========== initialization ===================
	
	LDR  R4, =(IOCON_PIO1_6)
	MOVS R5, #0x8
	STR  R5, [R4]	
	
	LDR  R4, =(IOCON_PIO1_7)
	MOVS R5, #0x8
	STR  R5, [R4]
	
	;============ setup direction ===================
	
	LDR R4, =(GPIO1DIR)
	LDR R5, [R4];
	MOVS R0, #0xC0
	ORRS R5, R0
	STR R5, [R4]

	;============ turn LED on =====================
	
	LDR R0, =(GPIO1DATA)
	MOVS R1, #0xC0
	STR R1, [R0];
	
	POP {R0-R7,PC}
	ALIGN
	END