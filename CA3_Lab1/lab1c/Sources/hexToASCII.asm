
	XDEF hexToASCII	
	 XREF __SEG_END_SSTACK
 ;RAM: Variable data section
.data: SECTION
var: ds.w 1		;int var;
zahl: ds.b 5			;char Zahl[5]
; ROM: Constant data
.const: SECTION
H2A:  DC.B  "123456789ABCDEF", 0;const char[]="123..F"

; ROM: Code section
.init: SECTION

	
 
hexToASCII:
	MOVW #$1234,var
	LDAA 0
	MOVB #$0000,zahl+4 		;end of string -> Zahl[4]=0
	
	LDAA #$0F			;reg A =000F
	LDX var
	PSHX				;A= A & var
	PULB
	ANDA SP 
	PSHA 
	MOVB SP,zahl+3

	PULB
	
	LDAA #$F0
	ANDA SP  
	LSRA
	LSRA
	LSRA
	LSRA
	PSHA
	MOVB SP,zahl+2
	PULB
	PULB
	
	LDAA #$0F
	PSHX
	ANDA SP
	PSHA
	MOVB SP,zahl+1
	PULB
	
	LDAA #$F0
	ANDA SP
	LSRA
	LSRA
	LSRA
	LSRA
	PSHA
	PSHA
	MOVB SP,zahl
	
	PULB
	PULB
	PULB 
	
	
	LDAA var
	
	
	
	
	
	
	
	RTS