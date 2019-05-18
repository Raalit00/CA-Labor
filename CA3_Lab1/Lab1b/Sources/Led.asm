	XDEF initLED
	XDEF setLED
	XDEF getLED
	XDEF toggleLED
; ROM: Code section
.init: SECTION			;zeigt wo sich der ROM befindet`?
; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'    ;Ohne dieser Zeile werden die LEDs nicht erkannt

initLED:

  BSET DDRJ,#2
  BCLR PTJ,#2
	MOVB #$FF, DDRB 	;Alle LEDs als Ausgänge
	MOVB #$FF, PORTB	;Schalte alle LED aus
	CLR DDRH
	
	RTS
	
	
	
L31:	LDAB #31	
setLED:
					
 		 DECB                   ; Decrement Regst B
 		 COMB		  	;Invertiere Reg B
		 STAB PORTB		;store B in port
		 COMB                  ;Invertiere Reg B
	         BEQ L31		;jump to L31 wenn Zero flag=0

	RTS
	
	
getLED:

		LDAB PORTB
		COMB	
	
	
	RTS
	
	
toggleLED:

	COM PORTB

	RTS