	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT ChannelLoc
	IMPORT LCD_data
	IMPORT LCD_init	
	IMPORT LCD_init1
	IMPORT BusyWait
	
ChannelLoc
 
	PUSH{R0-R4,LR}
	
	CMP R2, #0x23	;Compare if # is pushed
	BEQ pound

	BL LCD_init1			;initialize LCD
	
	MOV R0, R2				;move the value from r3 to r0 and pass to LCD_data
							;to display value on LCD	

	BL LCD_data				;display value on LCD
	
	;=====DELAY========
	LDR	R3, =0x300
	BL BusyWait
		
	MOVS R5, R2				;moves the R2 to R5 to track the channels
	B done
	
pound
	CMP R5, #0x31		;compare if channel 1 is pushed previously
	BEQ Channel1
	CMP R5, #0x32		;compare if channel 2 is pushed previously
	BEQ Channel2
	
	B done
	
Channel1
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
	
	;Set bit 1 GPIO1 data direction register to set PIO1_6 as output
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

Channel2
	;================ setup pin 1_7 ======================
	; Load the address of IOCON_PIO1_7 into R0
    LDR R0, =(IOCON_PIO1_7)
    ; Load the value of IOCON_PIO1_6 into R1
    LDR R1, [R0];
     ; Load R2 with 0x8 
    LDR R2, =(0x8);selects the 1_7 pin and 4th bit pull down 1000
    ; Apply OR operation between R1 and R2
    ORRS R1, R2;
    ; Store the new value of R1 into IOCON_PIO1_5
    STR R1, [R0];
	
	;Set bit 1 GPIO1 data direction register to set PIO1_6 as output
    ;Load the address of GPIO1DIR into R0	page 193
    LDR R0, =(GPIO1DIR)
    ; Load the value of GPIO0DIR into R1
    LDR R1, [R0];
	;then store 1 to r2
    MOVS R2, #0x80
    ;Apply bitwise OR operation between R1(value of GPIO1DIR) and R2(bit pattern)
    ORRS R1, R2;
    ; Store the new value of R1 into GPIO1DIR;
    STR R1, [R0];
	
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
	POP{R0-R4,PC}
	ALIGN
	END	