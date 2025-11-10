	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT MemLoc
	IMPORT LCD_data
	IMPORT LCD_init	
	IMPORT BusyWait
	
MemLoc
 
	PUSH{R0-R5,LR}
	
	CMP R6, #0x41		;compare if A is pressed
	BEQ Mem0
	CMP R6, #0x42		;compare if B is pressed
	BEQ Mem1
	
	;======== Save to memory location ================
	
Mem0	

	LDR R0, =0x10001000 ;point r1 to address 0x10001000
	STR R3, [R0]		;store content of R3 to memory location 
	
	B done
	
Mem1	
	
	LDR R0, =0x10001200 ;point r1 to address 0x40000200
	STR R4, [R0]		;store content of R4 to memory location 
	
done
	POP{R0-R5,PC}
	ALIGN
	END	