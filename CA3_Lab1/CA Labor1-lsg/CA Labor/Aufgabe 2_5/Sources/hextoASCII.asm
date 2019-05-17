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
        XDEF strCpy

; Defines

; Defines

; RAM: Variable data section
.data: SECTION

 var:  ds.w 1                                      ; unsigned int var
 var:  ds.b 16                                     ; const char H2A[16]

; ROM: Constant data
.const: SECTION
  h2a: dc.b "0123456789ABCDEF"

; ROM: Code section
.init: SECTION

; void  strCpy(char *dest, char *src);

strCpy: 
        TFR   D,  X                               ; Pointer *src  -> X
        LDY   D,  Y                               ; Pointer *dest -> Y
        RTS

toLower:


loop:   TST          0,X                          ; Stringende?
		    BEQ          Ende
		    LDAB         0,X                          ; Zeilen -> B
		    CMPB         #'A'                         ; Grossbuchstabe?
		    BLT          next
	      CMPB         #'Z'
	      BGT          next 
	      ADDB         #32                          ; Gross -> klein
next:   INC          1,X

Ende:   RTS                                       ; Restaurieren der gesicherten Register
                                                  ; return   
                                                    
; void hex2ASCII(char *p, unsigned int val)     
                                                       
   p[4] = 0                                       ; Ende des Strings
   p[3] = H2A[val & 0x000F]                       ; 1er-Stelle
   p[2] = H2A[(val >> 4) & 0x000F]                ; 16er-Stelle
   p[1] = H2A[(val >> 8) & 0x000F]                ; 256er-Stelle
   p[0] = H2A[(val >> 12) & 0x000F]               ; 256er-Stelle

