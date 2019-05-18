	XDEF delay_0_5sec

		
.init:  SECTION
delay_0_5sec:
SPEED:  EQU     $500                            ;Meine subrutine
      PSHX
      PSHY
     	LDY #SPEED
BY:  	LDX #SPEED             ;lade Reg X mit constante 
  	 	
BX:  	DBNE X,BX              ;Decrementiere X und Brunche Wenn X != 0
      	DBNE Y,BY
      	PULX
      	PULY
      	
    
	RTS