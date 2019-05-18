;   Labor 1 - Vorbereitungsaufgabe 2.6
;   Author:   Muhammed Yildirim, Raghid Allaham

; export symbols
        XDEF decToASCII
; Defines

; Defines

; RAM: Variable data section
.data: SECTION

; ROM: Constant data
.const: SECTION
 d2a: dc.b "0123456789", 0

; ROM: Code section
.init: SECTION
                                                     
decToASCII:

        PSHX              ; Sichere RegX
        PSHA              ; Sichere RegA
        PSHB              ; Sichere RegB
        
        CMPA #$7F         ; schaue ob es sich um eine pos oder neg Wert handelt  
        BLS pos           ; Branch if Lower or Same
        COMA              ; 2er Complement
        COMB              ; 2er Complement
        ADDD #1           ; 2er Complement
        MOVB #45, 1, X+   ; '-' Zeichen in ASCII = $2D
        BRA L0
        
pos:    MOVB #$43, 1, X+  ; '+' Zeichen in ASCII = $2B
        
L0:     LDY #d2a          ; Lade die Adresse von d2a in RegY
        MOVB Y, 1, X+     ; fülle mit 0en
        MOVB Y, 1, X+     ; fülle mit 0en
        MOVB Y, 1, X+     ; fülle mit 0en
        MOVB Y, 1, X+     ; fülle mit 0en
        MOVB Y, 1, X+     ; fülle mit 0en
        MOVB #$00, 1, X-  ; determinierende 0
        
        EXG Y, X           
           
loop:   LDX #10           ; D / X = X, remains D
        IDIV              ; Division 16-bit unsigned
        ADDD #d2a         ; D = *(D2A[D]) 
        EXG D, X          ; X <-> D
        MOVB X, 1, Y-     ; Y = X
        
        TSTA              ;
        BNE loop          ; Branch if RegA != 0
        TSTB              ;
        BNE loop          ; Branch if RegB != 0
        
        EXG Y, X          
        
        PULB              
        PULA
        PULX   
        RTS

