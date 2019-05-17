
;   Labor 1 - Problem 2.2
;   Incrementing a value once per second and binary output to LEDs
;
;   Computerarchitektur 3
;   (C) 2019 J. Friedrich, W. Zimmermann
;   Hochschule Esslingen
;
;   Author:   W.Zimmermann, Feb 4, 2019
;            (based on code provided by J. Friedrich)
;   Modified: -
;

; export symbols
        XDEF Entry, main

; import symbols
        XREF __SEG_END_SSTACK           ; End of stack

; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'

; Defines
SPEED:  EQU     $FFFF                   ; Change this number to change counting speed
IMAX: EQU 2040 
; RAM: Variable data section
.data: SECTION

; ROM: Constant data
.const:SECTION

; ROM: Code section
.init: SECTION

main:                                   ; Begin of the program
Entry:
        LDS  #__SEG_END_SSTACK          ; Initialize stack pointer
        CLI                             ; Enable interrupts, needed for debugger

;       ... ??? ...                     ; Add your code here
	  	MOVB #$FF, DDRB 					;Port 7 bis 0 als ausgang
L31:	LDAA #31
		
	;	MOVB #31, PORTB
		
		
loop: 	
 		  DECA                   ; Decrement Regst A
 		  COMA							   	;Invertiere Reg A
		  STAA PORTB						;store y in port
		  COMA                  ;Invertiere Reg A
	  	BEQ L31							;jump to L31 wenn Zero flag=0
	  	LDY #IMAX
BY:  	LDX #IMAX             ;lade Reg X mit constante 
  	 	
BX:  	DBNE X,BX
      DBNE Y,BY
	  	BRA loop
