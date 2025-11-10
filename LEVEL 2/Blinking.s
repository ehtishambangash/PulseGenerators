 AREA PROGRAM, CODE, READONLY
 INCLUDE	LPC11xx.inc
 EXPORT Blinking
 IMPORT TIMER32_0_IRQHandler 
 IMPORT BusyWait	 
	  
Blinking

	PUSH{R0-R5,LR}
	
;;;;;;;;;;;;;;;;;;; Load Match registers ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	CMP R6, #0x41		;compare if A is pressed
	BEQ T0_value
	CMP R6, #0x42		;compare if B is pressed
	BEQ T1_value
	
	B done
	
T0_value
	;;;;;;;;;;;;;;;;;;;	Positive pulse ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Load Match Register0(TMR32B0MR0) of 32-bit counter0(TMR32B0 or CT32B0)
    LDR R0, =(TMR32B0MR0); TMR32B0MR0, address 0x4001 4018
    ; Store the value of R3 into TMR32B0MR0
	STR R3, [R0];
	
	LDR	R3, =0x100000		;adds delay when key is pressed
	BL BusyWait
	
	B done
	
T1_value	
	
	;================ setup pin 1_6 ======================
	; Load the address of IOCON_PIO1_6 into R0
    LDR R0, =(IOCON_PIO1_6)
    ; Load the value of IOCON_PIO1_6 into R1
    LDR R1, [R0];
     ; Load R2 with 0x8 
    LDR R2, =(0x8);selects the 1_6 pin and 4th bit pull down 1000
    ; Apply OR operation between R1 and R2
    ORRS R1, R2;
    ; Store the new value of R1 into IOCON_PIO1_5
    STR R1, [R0];
	
	;=============== Setup direction =====================

	;Set bit 1 GPIO1 data direction register to set PIO1_6 output
    ;Load the address of GPIO1DIR into R0	page 193
    LDR R0, =(GPIO1DIR)
    ; Load the value of GPIO0DIR into R1
    LDR R1, [R0];
	;then store 1 to r2
    MOVS R2, #0x40
    ;Apply bitwise OR operation between R1(value of GPIO1DIR) and R2(bit pattern)
    ORRS R1, R2;
    ; Store the new value of R1 into GPIO1DIR;
    STR R1, [R0];
	
	;;;;;;;;;;;;;;;;;;;;; Total period ;;;;;;;;;;;;;;;;;;;;;
	; Load Match Register1(TMR32B0MR1) of 32-bit counter0(TMR32B0 or CT32B0)
    LDR R0, =(TMR32B0MR1); TMR32B0MR1, address 0x4001 4018 MR1(Match Register1),
						 ; generate interupt every time MR1 matches TC (Timer Counter) pg. 379
    ; Store the value of R4 into TMR32B0MR0
    STR R4, [R0];

	LDR	R3, =0x100000		;adds delay when key is pressed
	BL BusyWait
	
    ;;;;;;;;;;;;; Setup Match control register ;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	; set the Match Control Register(MCR) to call interrupt MR0 when timer matches the register
    LDR R0, =(TMR32B0MCR)
    MOVS R1, #(0x19) ;0001_1001 Bit 0 and 3 Enable Interupt on MR0 and MR1(interupt is generated when MR0 amd MR1 
					 ;matches the value in the TC) timer continue. Bit 4 Reset on MR1 the TC will be reset if MR1 matches it.
    STR R1, [R0];
	
    ;;;;;;;;;;;; Start the counter ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	; Start the counter by setting bit 1 of Timer Control Register(TCR)
    LDR R0, =(TMR32B0TCR)
    ; Load R1 with all zeros except bit 1 set
    MOVS R1, #(0x1);When one, the Timer Counter and Prescale Counter are
				   ;enabled for counting. When zero, the counters are disabled.
    ; Store R1 into TMR32B0TCR. This starts the counter
    STR R1, [R0];
	
done
	
	POP {R0-R5,PC}
	ALIGN
	END