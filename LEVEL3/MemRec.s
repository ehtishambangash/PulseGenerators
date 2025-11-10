	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT MemRec
	IMPORT LCD_data	
	IMPORT BusyWait
	IMPORT LCD_init1
	IMPORT Mem_0_Rec
	IMPORT Mem_1_Rec
	IMPORT Mem_2_Rec
	IMPORT Mem_3_Rec
	IMPORT Mem_4_Rec
	IMPORT Mem_5_Rec
	IMPORT Mem_6_Rec
	IMPORT Mem_7_Rec
	IMPORT Mem_8_Rec
	IMPORT Mem_9_Rec
	
MemRec
 
	PUSH{R0-R4,LR}
	
	CMP R2, #0x23
	BEQ pound

	BL LCD_init1			;initialize LCD
	
	MOV R0, R2				;move the value from r3 to r0 and pass to LCD_data
							;to display value on LCD	

	BL LCD_data				;display value on LCD
	
	;=====DELAY========
	LDR	R3, =0x300
	BL BusyWait
		
	MOVS R5, R2				;moves the R2 to R5 to track the memory
	B done
	
pound
	
	CMP R5, #0x30	;Compare if 0 is pushed
	BEQ MemoryNum
	
	CMP R5, #0x31	;Compare if 1 is pushed
	BEQ MemoryNum1
	
	CMP R5, #0x32	;Compare if 2 is pushed
	BEQ MemoryNum2
	
	CMP R5, #0x33	;Compare if 3 is pushed
	BEQ MemoryNum3
	
	CMP R5, #0x34	;Compare if 4 is pushed
	BEQ MemoryNum4
	
	CMP R5, #0x35	;Compare if 5 is pushed
	BEQ MemoryNum_5
	
	CMP R5, #0x36	;Compare if 6 is pushed
	BEQ MemoryNum6
	
	CMP R5, #0x37	;Compare if 7 is pushed
	BEQ MemoryNum7
	
	CMP R5, #0x38	;Compare if 8 is pushed
	BEQ MemoryNum8
	
	CMP R5, #0x39	;Compare if 9 is pushed
	BEQ MemoryNum9
	
	CMP R5, #0x23	;Compare if # is pushed
	BEQ pound
	
MemoryNum

	BL Mem_0_Rec
	
	B done
		
MemoryNum1
	
	BL Mem_1_Rec
	
	B done
	
MemoryNum2
	
	BL Mem_2_Rec
	
	B done
	
MemoryNum3
	
	BL Mem_3_Rec
	
	B done

MemoryNum4
	
	BL Mem_4_Rec
	
	B done
	
MemoryNum_5
	
	BL Mem_5_Rec
	
	B done
	
MemoryNum6
	
	BL Mem_6_Rec
	
	B done	
	
MemoryNum7
	
	BL Mem_7_Rec
	
	B done
	
MemoryNum8

	BL Mem_8_Rec
	
	B done
	
MemoryNum9

	BL Mem_9_Rec
	
done
	POP{R0-R4,PC}
	ALIGN
	END	