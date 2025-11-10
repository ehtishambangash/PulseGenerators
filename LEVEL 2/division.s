	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT division
	
division
	PUSH{R0-R5,LR}
	
Loop
	ADDS R7, R7, #1			;add 1 to R4
	SUBS R1, R1, R3			;subtract R1 value from R3
	BPL Loop				;loop until positive or zero
	ADDS R2, R1, R3 		;remainder, adding R1 and R3 and store to R2
	SUBS R7, R7, #1			;quotion, subtract 1 from R4
	
done
	POP{R0-R5,PC}
	ALIGN
	END