
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
        XREF delay_0_5sec
        XREF initLED , setLED , getLED, toggleLED

; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'

; Defines
                  ; Change this number to change counting speed
; RAM: Variable data section
.data: SECTION

; ROM: Constant data
.const:SECTION		;code funktioniert ohne das hier

; ROM: Code section
.init: SECTION		;muss min einmal definiert sein	

main:                                   ; Begin of the program
Entry:
        LDS  #__SEG_END_SSTACK          ; Initialize stack pointer
        CLI                             ; Enable interrupts, needed for debugger
	
;       ... ??? ...                     ; Add your code here
	JSR initLED			 ;Port 7 bis 0 als ausgang

		
		LDAB #31		
		
loop: 	
	  	JSR setLED
	  	JSR getLED  		;nur zu test zwecken ob getLED funktioniert (verändert nichts)
	  	JSR toggleLED
	  	JSR delay_0_5sec            ;Spring zu subroutine 
	  	BRA loop
	  	
	  	

      	RTS
