
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
        XREF delay_0_5_sec
        XREF initLED, getLED, setLED, toggleLED

; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'

; RAM: Variable data section
.data: SECTION
 var1: ds.b 1                           ; Variable für die Forschleife
       

; ROM: Constant data
.const:SECTION

; ROM: Code section
.init: SECTION

main:                                   ; Begin of the program
Entry:
        LDS  #__SEG_END_SSTACK          ; Initialize stack pointer
        CLI                             ; Enable interrupts, needed for debugger

        JSR initLED
        
L3:     MOVB  #31, var1                 ; var1 = 31
        BRA  L4
        
L0:     MOVB var1, PORTB                ; muss zu einem Unterprogramm!!!!
        ;JSR setLED
        JSR delay_0_5_sec               ; Springe in den Unterprogramm
        ;JSR toggleLED
        ;JSR getLED
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

	      
       
