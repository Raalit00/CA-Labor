		XDEF Delay

		
SPEED:  EQU     $2040 
init:	 SECTION
Delay:
                           ;Meine subrutine

     	LDY #SPEED
BY:  	LDX #SPEED             ;lade Reg X mit constante 
  	 	
BX:  	DBNE X,BX              ;Decrementiere X und Brunche Wenn X != 0
      	DBNE Y,BY
