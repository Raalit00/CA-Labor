;   Labor 1 - Vorbereitungsaufgabe 2.4
;   Convert a zero-terminated ASCIIZ string to lower characters
;   Main program
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
        XREF toLower
        XREF hexToASCII , strCpy

; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'

; Defines

; RAM: Variable data section
.data:  SECTION
Vtext:  DS.B    80                      ; Hier soll der String gespeichert werden


; ROM: Constant data
.const: SECTION
Ctext:  DC.B  "Test 12345 *!? ABCDE abcde zZ", 0
hilfC: ds.w 1

; ROM: Code section
.init:  SECTION

main:                                   ; Begin of the program
Entry:
        LDS  #__SEG_END_SSTACK          ; Initialize stack pointer
        CLI                             ; Enable interrupts, needed for debugger

;       ... ??? ...                     ; Add your code here
;
;  To Do
;       Copy string from Ctext in ROM to Vtext in RAM
;       Load pointer to string in D
;       Call subroutine toLower

  	LDD #$897F
  	JSR hexToASCII
	
    	LDX #Ctext    ; Aufruf strCpy( D=Const string, Y= String)  //Adressen werden übergeben
    	LDY #Vtext
    	JSR strCpy
    	LDD #Vtext     ;Aufruf toLower(D= String)   //Adresse wird übergeben
    	JSR toLower
	
	
	
	
loop: BRA loop

















