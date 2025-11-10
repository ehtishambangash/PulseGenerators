	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT init	
	
init
	PUSH{R0-R7,LR}	
	
	;;;;;;;;;;;;;;;;;; enable clock for GPIO ;;;;;;;;;;;;;;;

	LDR R0, =(SYSAHBCLKCTRL); SYSAHBCLKCTRL, address 0x4004 8080
    ; Load R1 with the value of SYSAHBCLKCTRL
    LDR R1, [R0];
    ; Load the bit pattern to enable clock for I/O config block(bit 16), GPIO(bit 6)
    LDR R2, =( 0x10640 );
    ; Apply bitwise OR between R1(value of SYSAHBCLKCTRL) and R2(new bit pattern)
    ; and save the result into R1
    ORRS R1, R2;
    ; Store the new value of R1 into SYSAHBCLKCTRL
    STR R1, [R0];
	
	; Enable CT32B0 interrupt (bit 18) in Nested Vectored Interrupt Controller(NVIC)
    ; Load the address of Interrupt Set Register(ISER) of NVIC into R0
    LDR R0, =(NVIC); ISER of NVIC, address 0xE000 E100
    ; Load R1 with all zeros except bit-18 set
    LDR R1, =(0x1)
	MOVS R1, R1, LSL #18
    ; Store the value of R1 into ISER of NVIC
    STR R1, [R0];
	
	POP {R0-R7,PC}
	
	ALIGN
	END