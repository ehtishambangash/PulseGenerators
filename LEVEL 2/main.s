 AREA FLASH, CODE, READONLY
 EXPORT __main
 INCLUDE LPC11xx.inc
 IMPORT PIOINT0_IRQHandler
 IMPORT LCD_init
 IMPORT LCD_command
 IMPORT LCD_data
 IMPORT BusyWait
 IMPORT Keypad_init
 IMPORT init
 IMPORT Name	 
 IMPORT Chan_LED_on

 EXPORT __use_two_region_memory

__use_two_region_memory EQU 0
    EXPORT SystemInit
    
   
	ENTRY

SystemInit 
   
; __main routine starts here
__main

	BL init
	
	BL LCD_init
	
	
	
	BL Name
	
	BL Keypad_init
	
	BL Chan_LED_on
	
	MOVS R7, #0		;start the counter and count the key pressed
		
end 
	B end


	END; End of File
