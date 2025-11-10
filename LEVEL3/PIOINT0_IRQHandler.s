 AREA PROGRAM, CODE, READONLY
 INCLUDE	LPC11xx.inc
 EXPORT PIOINT0_IRQHandler
 IMPORT LCD_command
 IMPORT LCD_data
 IMPORT LCD_init 
 IMPORT Keypad_init
 IMPORT BusyWait
 IMPORT DisplayT0
 IMPORT DisplayT1
 IMPORT DisplayMemLoc
 IMPORT	DisplayChan
 IMPORT DisplayRecall
 IMPORT T0_value	
 IMPORT T1_value
 IMPORT MemLoc	 
 IMPORT ChannelLoc
 IMPORT MemRec
 	 	 	
PIOINT0_IRQHandler
	PUSH {R0-R4,LR}
	
	;;;;;;;;;;; disable the pending interupt for port 0 ;;;;;;;;;;;;;;;;;;;;;;
	
	LDR R4, =(0xE000E180)		;disable the interrupt, ICER, page 507, 508
	MOVS R3, #0x1				; Interrupt Clear-enable Register, page 508  (ICER)
	MOVS R3, R3, LSL #31		; Interrupt source: Page 70. 
	STR R3, [R4]
	
	;;;;;;;;;;; clear the pending interupt for port 0 ;;;;;;;;;;;;;;;;;;;;;;;;
	
	LDR R4, =(0xE000E280)		;clear the pending interrupt, Interrupt Clear-pending Register (ICPR)
	MOVS R3, #0x1
	MOVS R3, R3, LSL #31
	STR R3, [R4]
	
	;;;;;;;;;; delay ;;;;;;;;;;;;;;;;;
	
	LDR	R3, =0x50000		;adds delay when key is pressed
	BL BusyWait	
	
	
check_row1
		;;;;;;;;;;;;;; crear all rows ;;;;;;;;;;;;;;
		
		LDR	R4,=(GPIO1DATA)	
		MOVS R3, #0x00
		STR R3, [R4]
		
		;;;;;;;;;;; set 1st row low ;;;;;;;;;;;;;;;;;
		
		LDR	R4,=(GPIO1DATA) 
		MOVS R3, #0x07		;set 1st row = 0 and (2,3,4) = 1
		STR R3, [R4]
		
		;;;;;;;;;;; set all columns high ;;;;;;;;;;;
		
		LDR R4, =(GPIO0DATA) ; 
		LDR R3, [R4]
		MOVS R0, #0x1E		;0001_1110
		ANDS R3, R3, R0		;find inoup column
		MOVS R3, R3, LSR #1  ; shift right one bit
		
		;;;;;;;;;; check first column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0x07  		;0111 compare if the first column is 0, "1" on the keypad is pressed. 
		BEQ _col1_row1
		
		;;;;;;;;;; check second column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xB  		;1011 compare if the second column is 0, "2" on the keypad is pressed. 
		BEQ _col2_row1
		
		;;;;;;;;;; check third column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xD  		;1101 compare if the third column is 0, "3" on the keypad is pressed. 
		BEQ _col3_row1
		
		;;;;;;;;;; check fourth column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xE  		;1110 compare if the fourth column is 0, "A" on the keypad is pressed. 
		BEQ _col4_row1
		
		B check_row2
		
_col1_row1

		MOVS	R2, #0x31		;In ASCII table is 1
		B ButtonA
		
_col2_row1
		
		MOVS	R2, #0x32		;In ASCII table is 2
		B ButtonA
		
_col3_row1

		MOVS	R2, #0x33		;In ASCII table is 3
		B ButtonA
		
_col4_row1

		MOVS	R2, #0x41		;In ASCII table is A
		B ButtonA
		
check_row2
		;;;;;;;;;;;;;; crear all rows ;;;;;;;;;;;;;;
		
		LDR	R4,=(GPIO1DATA)	
		MOVS R3, #0x00
		STR R3, [R4]
		
		;;;;;;;;;;; set 2nd row low ;;;;;;;;;;;;;;;;;
		
		LDR	R4,=(GPIO1DATA) 
		MOVS R3, #0xB		;set 2nd row = 0 and (1,3,4) = 1
		STR R3, [R4]
		
		;;;;;;;;;;; set all columns high ;;;;;;;;;;;
		
		LDR R4, =(GPIO0DATA) ; 
		LDR R3, [R4]
		MOVS R0, #0x1E		;0001_1110
		ANDS R3, R3, R0		;find inoup column
		MOVS R3, R3, LSR #1  ; shift right one bit
		
		;;;;;;;;;; check first column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0x07  		;0111 compare if the first column is 0, "4" on the keypad is pressed. 
		BEQ _col1_row2
		
		;;;;;;;;;; check second column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xB  		;1011 compare if the second column is 0, "5" on the keypad is pressed. 
		BEQ _col2_row2
		
		;;;;;;;;;; check third column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xD  		;1101 compare if the third column is 0, "6" on the keypad is pressed. 
		BEQ _col3_row2
		
		;;;;;;;;;; check fourth column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xE  		;1110 compare if the fourth column is 0, "B" on the keypad is pressed. 
		BEQ _col4_row2
		
		B check_row3

_col1_row2

		MOVS	R2, #0x34		;In ASCII table is 4
		B ButtonA
		
_col2_row2
		
		MOVS	R2, #0x35		;In ASCII table is 5
		B ButtonA
		
_col3_row2

		MOVS	R2, #0x36		;In ASCII table is 6
		B ButtonA
		
_col4_row2

		MOVS	R2, #0x42		;In ASCII table is B
		B ButtonB
		
check_row3
		;;;;;;;;;;;;;; crear all rows ;;;;;;;;;;;;;;
		
		LDR	R4,=(GPIO1DATA)	
		MOVS R3, #0x00
		STR R3, [R4]
		
		;;;;;;;;;;; set 3rd row low ;;;;;;;;;;;;;;;;;
		
		LDR	R4,=(GPIO1DATA) 
		MOVS R3, #0xD		;set 3rd row = 0 and (1,2,4) = 1
		STR R3, [R4]
		
		;;;;;;;;;;; set all columns high ;;;;;;;;;;;
		
		LDR R4, =(GPIO0DATA) ; 
		LDR R3, [R4]
		MOVS R0, #0x1E		;0001_1110
		ANDS R3, R3, R0		;find inoup column
		MOVS R3, R3, LSR #1  ; shift right one bit
		
		;;;;;;;;;; check first column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0x07  		;0111 compare if the first column is 0, "7" on the keypad is pressed. 
		BEQ _col1_row3
		
		;;;;;;;;;; check second column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xB  		;1011 compare if the second column is 0, "8" on the keypad is pressed. 
		BEQ _col2_row3
		
		;;;;;;;;;; check third column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xD  		;1101 compare if the third column is 0, "9" on the keypad is pressed. 
		BEQ _col3_row3
		
		;;;;;;;;;; check fourth column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xE  		;1110 compare if the fourth column is 0, "C" on the keypad is pressed. 
		BEQ _col4_row3
		
		B check_row4

_col1_row3

		MOVS	R2, #0x37		;In ASCII table is 7
		B ButtonA
		
_col2_row3
		
		MOVS	R2, #0x38		;In ASCII table is 8
		B ButtonA
		
_col3_row3

		MOVS	R2, #0x39		;In ASCII table is 9
		B ButtonA
		
_col4_row3

		MOVS	R2, #0x43		;In ASCII table is C
		B ButtonC

check_row4
		;;;;;;;;;;;;;; crear all rows ;;;;;;;;;;;;;;
		
		LDR	R4,=(GPIO1DATA)	
		MOVS R3, #0x00
		STR R3, [R4]
		
		;;;;;;;;;;; set 4th row low ;;;;;;;;;;;;;;;;;
		
		LDR	R4,=(GPIO1DATA) 
		MOVS R3, #0xE		;set 4th row = 0 and (1,2,3) = 1
		STR R3, [R4]
		
		;;;;;;;;;;; set all columns high ;;;;;;;;;;;
		
		LDR R4, =(GPIO0DATA) ; 
		LDR R3, [R4]
		MOVS R0, #0x1E		;0001_1110
		ANDS R3, R3, R0		;find inoup column
		MOVS R3, R3, LSR #1  ; shift right one bit
		
		;;;;;;;;;; check first column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0x07  		;0111 compare if the first column is 0, "*" on the keypad is pressed. 
		BEQ _col1_row4
		
		;;;;;;;;;; check second column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xB  		;1011 compare if the second column is 0, "0" on the keypad is pressed. 
		BEQ _col2_row4
		
		;;;;;;;;;; check third column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xD  		;1101 compare if the third column is 0, "#" on the keypad is pressed. 
		BEQ _col3_row4
		
		;;;;;;;;;; check fourth column ;;;;;;;;;;;;;;;;;;
		
		CMP R3, #0xE  		;1110 compare if the fourth column is 0, "D" on the keypad is pressed. 
		BEQ _col4_row4
		
		B keypad

_col1_row4

		MOVS	R2, #0x2A		;In ASCII table is *
		B ButtonStar
		
_col2_row4
		
		MOVS	R2, #0x30		;In ASCII table is 0
		B ButtonA
		
_col3_row4

		MOVS	R2, #0x23		;In ASCII table is #
		B ButtonA
		
_col4_row4

		MOVS	R2, #0x44		;In ASCII table is D
		B ButtonD
		

;;;;;;;;;;;;;;;;;;;;;;; Button conditions ;;;;;;;;;;;;;;;;;

ButtonA
	CMP R2, #0x41		;Checking to see if 'A' is pushed
	BEQ DisplayT0func	;First line display
	
	CMP R2, #0x42		;Checking to see if 'B' is pushed
	BEQ ButtonB
	
	CMP R2, #0x43	;Checking to see if 'C' is pushed
	BEQ ButtonC
	
	CMP R2, #0x2A	;Checking to see if '*' is pushed
	BEQ ButtonStar
	
	CMP R2, #0x44	;Checking to see if 'D' is pushed
	BEQ ButtonD
	
	CMP R6, #0x41		;Continue to store into T0 while A is pressed
	BEQ storeT0
	
ButtonB
	CMP R2, #0x42		;Checking to see if 'B' is pushed
	BEQ DisplayT1func	;First line display

	CMP R2, #0x41		;Checking to see if 'A' is pushed
	BEQ ButtonA
	
	CMP R2, #0x43	;Checking to see if 'C' is pushed
	BEQ ButtonC
	
	CMP R2, #0x2A	;Checking to see if '*' is pushed
	BEQ ButtonStar
	
	CMP R2, #0x44	;Checking to see if 'D' is pushed
	BEQ ButtonD
	
	CMP R6, #0x42		;Continue to store into T1 while B is pressed
	BEQ storeT1

ButtonC
	CMP R2, #0x43	;Checking to see if 'C' is pushed
	BEQ DisplayMemfunc		;First line display
	
	CMP R2, #0x41		;Checking to see if 'A' is pushed
	BEQ ButtonA
	
	CMP R2, #0x42	;Checking to see if 'B' is pushed
	BEQ ButtonB
	
	CMP R2, #0x2A	;Checking to see if '*' is pushed
	BEQ ButtonStar
	
	CMP R2, #0x44	;Checking to see if 'D' is pushed
	BEQ ButtonD
	
	CMP R6, #0x43		;Continue to store into T0 while C is pressed
	BEQ storeMem

	
ButtonStar
	CMP R2, #0x2A	;Checking to see if '*' is pushed
	BEQ DisplayChfunc		;First line display
	
	CMP R2, #0x41		;Checking to see if 'A' is pushed
	BEQ ButtonA
	
	CMP R2, #0x42	;Checking to see if 'B' is pushed
	BEQ ButtonB
	
	CMP R2, #0x43	;Checking to see if 'C' is pushed
	BEQ ButtonC
	
	CMP R2, #0x44	;Checking to see if 'D' is pushed
	BEQ ButtonD
	
	CMP R6, #0x2A		;Continue to store into T0 while C is pressed
	BEQ storeChannel

ButtonD
	CMP R2, #0x44	;Checking to see if 'D' is pushed
	BEQ DisplayRecallfunc		;First line display
	
	CMP R2, #0x41		;Checking to see if 'A' is pushed
	BEQ ButtonA
	
	CMP R2, #0x42	;Checking to see if 'B' is pushed
	BEQ ButtonB
	
	CMP R2, #0x2A	;Checking to see if '*' is pushed
	BEQ ButtonStar
	
	CMP R2, #0x43	;Checking to see if 'D' is pushed
	BEQ ButtonC
	
	CMP R6, #0x44		;Continue to store into T1 while B is pressed
	BEQ RecallMem
	
	B keypad
	
	
;;;;;;;;;;;;;;;;;;;; Button functions ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

DisplayT0func
	BL LCD_init	
	BL DisplayT0
	MOVS R6, #0x41
	B keypad

DisplayT1func	
	BL LCD_init	
	BL DisplayT1
	MOVS R6, #0x42
	B keypad		
	
DisplayMemfunc
	BL LCD_init
	BL DisplayMemLoc
	MOVS R6, #0x43
	B keypad

DisplayChfunc
	BL LCD_init
	BL DisplayChan
	MOVS R6, #0x2A
	B keypad

DisplayRecallfunc
	BL LCD_init
	BL DisplayRecall
	MOVS R6, #0x44
	B keypad
	
;;;;;;;;;;;;;;;;;;; Storing Data ;;;;;;;;;;;;;;;;;;;;;;;;;

storeT0
	BL T0_value
	B keypad

storeT1
	BL T1_value
	B keypad
	
storeMem
	BL MemLoc
	B keypad
	
storeChannel
	BL ChannelLoc
	B keypad
	
RecallMem
	BL MemRec
	B keypad	

	
keypad

	;;ground the rows again
	LDR	R4,=(GPIO1DATA)	; continue to clear rows
	MOVS R3, #0x00
	STR R3, [R4]

;release
;	;Check if all columns are 1
;	;and button is released
;	LDR R4, =(GPIO0DATA) 
;	LDR R5, [R4]
;	MOVS R3, #0x1E		;0001_1110
;	ANDS R5, R5, R3
;	CMP R5, R3
;	BNE release
	
;	LDR	R3, =0x10000		;adds delay when key is released
;	BL BusyWait
;	
;;;;;;;;;;;;;;;;;; keypad detection ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;; set the direction of P0.1, P0.2, P0.3, P0.4 as input for keypad column	
	;set port 0 as input. It will make the interupt to trigger
	LDR R4, =(GPIO0DIR)
    MOVS R3, #(0x0);
    ; Store the new value of R3 into GPIO0DIR;
    STR R3, [R4];
	
	
	;Set bit 1 GPIO1 data direction register to set PIO1_8 as output
	;to enable R/W to or from LCD
    ;Load the address of GPIO1DIR into R4	page 193
    LDR R4, =(GPIO1DIR)
	LDR R0, [R4]
	;then store 1 to R3
    MOVS R3, #(0x1);
	;Load a bit pattern 0x1 into R3  and shift left by 8 position to set bit 1 enable write mode
	MOVS R3, R3, LSL #8
	ORRS R3, R0
    ; Store the new value of R3 into GPIO1DIR;
    STR R3, [R4];
	
	
	;;set the direction of P1.0, P1.1, P1.2, P1.4 as output for keypad row	
	;;and P1.8 output for write mode
    ;Load the address of GPIO1DIR into R4	page 193
    LDR R4, =(GPIO1DIR)
	LDR R0, [R4]
	;store 1 to P1_0, P1_1, P1_2, P1_4, P1_8
    LDR R3, =(0x117);
	ORRS R3, R0
    ; Store the new value of R3 into GPIO1DIR;
    STR R3, [R4];


	;;enable the interrupt for PORT0
	;enable the ISER(Interupt Set Enable Register) and shows which interrupt is enabled for PORT0 pg. 507
	;load the address of Interrupt Set Register(ISER) of NVIC into R4
	LDR R4, =(0xE000E100)	;ISER of NVIC
	MOVS R3, #0x1			;move value 1 to R3
	MOVS R3, R3, LSL #31	;Load R3 with all zeros except bit-32 set, lowest priority
	STR R3, [R4]			;store the value of R3 into ISER of NVIC
	
	
	;;clear the pending interrupt for PORT0
	;enable the ICPR(Interupt Clear-pending Register) and removes pending state from interupt for PORT0 pg. 507
	;load the address of ICPR into R4
	LDR R4, =(0xE000E280)	;address of ICPR
	MOVS R3, #0x1			;move value 1 to R3
	MOVS R3, R3, LSL #31	;Load R3 with all zeros except bit-31 set, lowest priority
	STR R3, [R4]			;store the value of R3 into ICPR
	
	
	;;clear the rows for the next keypad press
	;set GPIO1DATA low
	LDR R4, =(GPIO1DATA); GPIO1DATA Base + 0x3FFC, address 0x5001 3FFC, Table 174, page 192
	; Load the value of GPIO1DATA into R3
    LDR R3, [R4];
	; Load the value 0 
	MOVS R3, #(0x0);
	; Store the value of R3 into GPIO1DATA
	STR R3, [R4];
		
	POP{R0-R4,PC}
	BX LR
	ALIGN
	END