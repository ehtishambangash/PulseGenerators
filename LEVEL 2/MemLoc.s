	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT MemLoc
	IMPORT LCD_data
	IMPORT LCD_init	
	IMPORT BusyWait
	
MemLoc
 
	PUSH{R0-R4,LR}
	
	CMP R6, #0x41		;compare if A is pressed
	BEQ Mem0
	CMP R6, #0x42		;compare if B is pressed
	BEQ Mem1
	
	;======== Save to memory location ================
	
Mem0	

	LDR R0, =0x10001000 ;point r1 to address 0x10001000
	
	LDR	R3, =0x100000		;adds delay for memory storing
	BL BusyWait
	
	STR R1, [R0]		;store content of R1 to memory location 
	

	
	B done
	
Mem1	
	
	LDR R0, =0x10001200 ;point r1 to address 0x40000200
	
	LDR	R3, =0x100000		;adds delay for memory storing
	BL BusyWait	
	
	STR R4, [R0]		;store content of R4 to memory location 
	

	
done
	POP{R0-R4,PC}
	ALIGN
	END	