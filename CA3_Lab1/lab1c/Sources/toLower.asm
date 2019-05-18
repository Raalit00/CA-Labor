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
;str:	DS.B 80

; ROM: Constant data
.const: SECTION
;Cstr:  DC.B  "123456789ABCDEF", 0;

; ROM: Code section
.init: SECTION

toLower:

	
	TFR D,X	  	;übertrage D nach X weil man in D nicht arbeiten kann
loop:	TST 0,X		;Überprüfe ob wir schon am ende des string sind (string end =0)
	BEQ ende	  ;wenn ja (Z=1) springe zu next;
	LDAB 0,X	;Lade B mit *X[0]  (X wird als pointer später INC)
	CMPB #'A'	;vergleiche register B mit 'A'
	BLT next	;wenn B kleiner 'A' springe zu next
	CMPB #'Z'	;vergleiche B mit 'Z'
	BGT next	;wenn B größer als 'Z' springe zu next	
	ADDB #32 	;Addiere 32 zu B um den kleinen buchstaben zu erhalten 
	
	
next:	STAB 1,X+
;	INX		;incrementiere A um zum nechsten zeichen zu gelangen
	BRA loop	;springe immer zu Loop
	          
ende:
 
 	RTS
 	
 	
 	
 	
 

 	;LDX #Cstr
 ;	LDY #str
 ;@ für string copy müssen zwei Pointer übergeben werden Const string auf Reg.X und und RAM string auf Y
strCpy: 	
LP:	     MOVB 0,X,1,Y+      ;bewegt aus x[0] die zeichen in einer folge von Y -1- zeichen reservieren
 	       TST 1,X+           ;testet ob zeichen gleich 0 und addiert 1 zu x
 	       BNE LP
 
 	RTS
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 