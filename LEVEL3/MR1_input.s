 AREA PROGRAM, CODE, READONLY
 INCLUDE	LPC11xx.inc
 EXPORT MR1_input
 IMPORT TIMER32_0_IRQHandler 
 IMPORT BusyWait


MR1_input

	PUSH{R0-R7,LR}
	
	MOVS R0, #0xC		;Move 12 to R0 ;
	MULS R4, R0, R4		;Multiply Dec value by 12 and store to R7, for total clicks
	
	;;;;;;;;;;;;;;;;;;;;; Total period ;;;;;;;;;;;;;;;;;;;;;
	; Load Match Register1(TMR32B0MR1) of 32-bit counter0(TMR32B0 or CT32B0)
    LDR R0, =(TMR32B0MR1); TMR32B0MR1, address 0x4001 4018 MR1(Match Register1),
						 ; generate interupt every time MR1 matches TC (Timer Counter) pg. 379
    ; Store the value of R4 into TMR32B0MR0
    STR R4, [R0];

	LDR	R3, =0x100000		;adds delay when key is pressed
	BL BusyWait
	
	POP {R0-R7,PC}
	ALIGN
	END