;   Labor 1 - Problem 2.4
;   Convert a zero-terminated ASCIIZ string to lower characters
;   Subroutine toLower
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
        XDEF toLower

; Defines

; Defines

; RAM: Variable data section
.data: SECTION

  ; Destination muss hier rein

; ROM: Constant data
.const: SECTION

; ROM: Code section
.init: SECTION

toLower:

        TFR D,X
loop:   LDAB 0,X                    
	BEQ Ende
	CMPB #'A'           ; Grossbuchstabe?
	BLO next
	CMPB #'Z'
	BHI next 
	ADDB #32            ; Gross -> klein
next:   STAB 1,X+
        BRA  loop

Ende:   RTS                         ; Restaurieren der gesicherten Register
                                    ; return        
                                                       

