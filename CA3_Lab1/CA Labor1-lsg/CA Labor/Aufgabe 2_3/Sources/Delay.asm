;export symbols
        XDEF delay_0_5_sec              ;
        
; Defines
SPEED:  EQU    2048                    ; Change this number to change counting speed

; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'

; ROM: Code section
.init:  SECTION

;**************************************************************
; Public interface function: initLCD ... Initialize LCD (called once)
; Parameter: -
; Return:    - 
delay_0_5_sec:

        LDX  #SPEED                      ; Delay loop to control toggle Frequency 
waitO:  LDY  #SPEED                      ; (Uses two nested counter loops with registers X and Y)
waitI:  DBNE Y, waitI                   ; --- Decrement Y and branch to waitI if not equal to 0
	      DBNE X, waitO                   ; --- Decrement X and branch to waitO if not equal to 0
	      
	      RTS