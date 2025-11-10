 AREA PROGRAM, CODE, READONLY
 INCLUDE	LPC11xx.inc
 EXPORT MR0_input
 IMPORT TIMER32_0_IRQHandler 
 IMPORT BusyWait


MR0_input

	PUSH{R0-R7,LR}
	
	MOVS R0, #0xC		;Move 12 to R0 ;
	MULS R3, R0, R3		;Multiply Dec value by 12 and store to R7, for total clicks
	
	;;;;;;;;;;;;;;;;;;;	Positive pulse ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Load Match Register0(TMR32B0MR0) of 32-bit counter0(TMR32B0 or CT32B0)
    LDR R0, =(TMR32B0MR0); TMR32B0MR0, address 0x4001 4018
    ; Store the value of R3 into TMR32B0MR0
	STR R3, [R0];
	
	LDR	R3, =0x100000		;adds delay when key is pressed
	BL BusyWait
	
	POP {R0-R7,PC}
	ALIGN
	END