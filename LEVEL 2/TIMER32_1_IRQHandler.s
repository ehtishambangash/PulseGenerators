 AREA PROGRAM, CODE, READONLY
 INCLUDE	LPC11xx.inc
 EXPORT TIMER32_1_IRQHandler
	 	 
TIMER32_1_IRQHandler
	PUSH {R0-R7}

	;;;;;;;;;;;;;;;;;;;;;; Load the interupt ;;;;;;;;;;;;;;;;;
	
	; Load the address 0x4001 4000 of TMR32B1IR into R0, page 381
    LDR R0, =(TMR32B1IR)
	LDR R1, [R0];
	MOVS R2, #0x1		;MR0 
	MOVS R3, #0x2		;MR1 
	CMP R1, R2			;Compare if MR0 
	BEQ LED_Off
	CMP R1, R3			;Compare if MR1
	BEQ LED_On	
	B recount
	
	;;;;;;;;;;;;;; Turn LED off ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
LED_Off	
	; Set the initial output on PIO1_7 as low
	; Load the address of GPIO1DATA(last unmasked address base+0x3FFC) into R0
	LDR R0, =(GPIO1DATA); GPIO1DATA Base + 0x3FFC, address 0x5001 3FFC, Table 174, page 192
	; Load the value (0) at bit location 6 and 7 to set PIO1_6 and PIO1_6 low
	MOVS R1, #(0x0);
	; Store the value of R1 into GPIO1DATA
	STR R1, [R0];
	
	B recount
	
	
LED_On

	;;;;;;;;;;;;;; Turn LEd On ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	; Set the initial output on PIO1_7 as high
	; Load the address of GPIO1DATA(last unmasked address base+0x3FFC) into R0
	LDR R0, =(GPIO1DATA); GPIO1DATA Base + 0x3FFC, address 0x5001 3FFC, Table 174, page 192
	; Load the value (1) at bit location 6 and 7 to set PIO1_6 and PIO1_6 high
	LDR R1, =0x80
	; Store the value of R1 into GPIO1DATA
	STR R1, [R0];

	
recount

	;;;;;;;;;;;;;;;; Clear the interrupt ;;;;;;;;;;;;;;;;;;;;;;;;;
	
	; Load the address 0x4001 4000 of TMR32B1IR into R0, page 381
    LDR R0, =(TMR32B1IR)
	LDR R1, =0x3      ;Write bits 0 and 1 to clear interrupts 0 and 1 
	STR R1, [R0]
	
	POP {R0-R7}
	BX LR
	
	ALIGN
	END