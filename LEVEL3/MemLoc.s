	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT MemLoc
	IMPORT LCD_data
	IMPORT LCD_init1
	IMPORT BusyWait
	IMPORT Mem_0_Loc
	IMPORT Mem_1_Loc
	IMPORT Mem_2_Loc
	IMPORT Mem_3_Loc
	IMPORT Mem_4_Loc 
	IMPORT Mem_5_Loc
	IMPORT Mem_6_Loc
	IMPORT Mem_7_Loc
	IMPORT Mem_8_Loc 
	IMPORT Mem_9_Loc
		   	
MemLoc
 
	PUSH{R0-R4,LR}
	
	CMP R2, #0x23
	BEQ pound

	BL LCD_init1			;initialize LCD
	
	MOV R0, R2				;move the value from r2 to r0 and pass to LCD_data
							;to display value on LCD	

	BL LCD_data				;display value on LCD
	
	;=====DELAY========
	LDR	R3, =0x1000
	BL BusyWait
		
	MOVS R5, R2				;moves the R2 to R5 to track the memory
	B done
	
pound
	CMP R5, #0x30		;compare if memory 0 is pushed
	BEQ MemNum
	
	CMP R5, #0x31		;compare if memory 1 is pushed
	BEQ MemNum1
	
	CMP R5, #0x32		;compare if memory 2 is pushed
	BEQ MemNum2
	
	CMP R5, #0x33		;compare if memory 3 is pushed
	BEQ MemNum3
	
	CMP R5, #0x34		;compare if memory 4 is pushed
	BEQ MemNum4
	
	CMP R5, #0x35		;compare if memory 5 is pushed
	BEQ MemNum5
	
	CMP R5, #0x36		;compare if memory 6 is pushed
	BEQ MemNum6
	
	CMP R5, #0x37		;compare if memory 7 is pushed
	BEQ MemNum7
	
	CMP R5, #0x38		;compare if memory 8 is pushed
	BEQ MemNum8
	
	CMP R5, #0x39		;compare if memory 9 is pushed
	BEQ MemNum9
	
	B done
	
MemNum
	
	BL Mem_0_Loc
	
	B done

MemNum1

	BL Mem_1_Loc
	
	B done
	
MemNum2

	BL Mem_2_Loc
		
	B done	
	
MemNum3

	BL Mem_3_Loc
	
	B done

MemNum4

	BL Mem_4_Loc
	
	B done
	
MemNum5

	BL Mem_5_Loc
	
	B done
	
MemNum6

	BL Mem_6_Loc

	B done	
	
MemNum7

	BL Mem_7_Loc
	
	B done	
	
MemNum8
	
	BL Mem_8_Loc

	B done	
	
MemNum9

	BL Mem_9_Loc

	B done	
	
done
	POP{R0-R4,PC}
	ALIGN
	END