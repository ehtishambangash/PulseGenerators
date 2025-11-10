	AREA PROGRAM, CODE, READONLY
	INCLUDE	LPC11xx.inc
	EXPORT ChannelLoc
	IMPORT LCD_data
	IMPORT LCD_init	
	IMPORT BusyWait
	
ChannelLoc
 
	PUSH{R0-R5,LR}
	
	
	
done
	POP{R0-R5,PC}
	ALIGN
	END	