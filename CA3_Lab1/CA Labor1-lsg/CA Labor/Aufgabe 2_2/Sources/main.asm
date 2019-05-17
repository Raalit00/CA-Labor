
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
SPEED:  EQU    2048                    ; Change this number to change counting speed

; RAM: Variable data section
.data: SECTION
 var1: ds.b 1                           ; Variable für die Forschleife

; ROM: Constant data
.const:SECTION

; ROM: Code section
.init: SECTION

delay_0_5_sec:

        LDX  #SPEED                      ; Delay loop to control toggle Frequency 
waitO:  LDY  #SPEED                      ; (Uses two nested counter loops with registers X and Y)
waitI:  DBNE Y, waitI                   ; --- Decrement Y and branch to waitI if not equal to 0
	      DBNE X, waitO                   ; --- Decrement X and branch to waitO if not equal to 0
	      
	      RTS

main:                                   ; Begin of the program
Entry:
        LDS  #__SEG_END_SSTACK          ; Initialize stack pointer
        CLI                             ; Enable interrupts, needed for debugger

        MOVB #$FF, DDRB                 ; $FF -> DDRB:  Port B.7...0 as outputs (LEDs)
        MOVB #$00, PORTB                ; $00 -> PORTB:  Port B.7...0 LED's aus
        
L3:     MOVB  #31, var1                 ; var1 = 31
        BRA  L4
        
        
L0:     MOVB var1, PORTB
        JSR delay_0_5_sec               ; Springe in den Unterprogramm 
        BRA L1    

L1:     
        LDAA  var1
        CPD  #0
        BGT  L5
        
        BRA  L3

L5:     DEC var1
  
L4:     LDAB var1
        CMPB #0
        BRA  L0                         ; Springe zu L0 wenn Bedingung erfüllt ist

	      
       
