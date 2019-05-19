
	XDEF hexToASCII	
	 XREF __SEG_END_SSTACK
	 
	  XREF toLower, strCpy
	  
 ;RAM: Variable data section
.data: SECTION

zahl: ds.b 5			;char Zahl[5]

; ROM: Constant data
.const: SECTION
H2A:  DC.B  "0123456789ABCDEF", 0;const char[]="123..F"

; ROM: Code section
.init: SECTION


;Übergabe Parameter in X RAM string, In D Int §1234	
 
hexToASCII:
  
  PSHY
  PSHX
  
	;LDD #$1F24        ;die kommentare wurden geführt bei var =1F24
	MOVB #$0000,zahl+4 		;end of string -> Zahl[4]=0
	TFR D,Y             ;Übertrage D nach Y
	TFR A,B              ; A nach B  
	CLRA                ; 0 0 1 F
	LSRD
	LSRD
	LSRD
	LSRD                ;0 0 0 1
	ADDD #H2A
	EXG D,Y             ;D wieder 1F24 und Y Adrsse von '0 1<- 2 3 4 5 6 7 8 9 A B C D E F'
	
	LDX #zahl+3         ;gehe zu Zahl[3]
  MOVB Y , X          ;zahl[3]= *Y
	
  TFR D,Y             ;D -> Y  (y als zwischenspeicher)
  TFR A,B             ;A -> B 
  CLRA                 ;D= 00MX
  ANDB #$0F             ;D=000X   /mit Maske undieren
  ADDD #H2A           ;D=000X + H2A  -> '0 1 2 3 4 5 6 7 8 9 A B C D E F<-'
  EXG D,Y              ; D=XXXX wieder, und Y = '0 1 2 3 4 5 6 7 8 9 A B C D E F<-'
  LDX #zahl+2
  MOVB Y , X
  
  TFR D,Y            ;D -> Y  (y als zwischenspeicher)
  CLRA               ;D= 00MX
  ANDB #$F0          ;D= 00M0
  LSRD
  LSRD
  LSRD
  LSRD               ;D= 000M
  ADDD #H2A          ; D=  '0 1 2<- 3 4 5 6 7 8 9 A B C D E F'
  EXG Y,D             ; D =XXXX , Y='0 1 2 3 4 5 6 7 8 9 A B C D E F<-'
  LDX #zahl+1
  MOVB Y,X
  
  	
  TFR D,Y             ;D -> Y  (y als zwischenspeicher)
  CLRA                ;D=00MX
  ANDB #$0F           ;D=000X
  ADDD #H2A           ;D=  '0 1 2 3 4<- 5 6 7 8 9 A B C D E F'
  EXG D,Y             ;D =XXXX , Y='0 1 2 3 4<- 5 6 7 8 9 A B C D E F'
  LDX #zahl
  MOVB Y,X  
 
  
  LDY #zahl            ;jetzt versuche ich strCpy zum von Außen gegebenen Str
  PULX                 ;Da strCpy(X=Const String -> Y = string)
  EXG X,Y              ;
  JSR strCpy           ;zahl -> string
                       ;
  PULY
  
            
  RTS
  
  
  
  
  
	
	
