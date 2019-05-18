;   Labor 1 - Vorbereitungsaufgabe 2.5
;   Author:   Muhammed Yildirim, Raghid Allaham

; export symbols
        XDEF hexToASCII

; ROM: Constant data
.const: SECTION
  h2a: dc.b "0123456789ABCDEF"

; ROM: Code section
.init: SECTION
                                                    
; void hex2ASCII(char *p, unsigned int val)     
                                                       
   ;p[4] = 0                                       ; Ende des Strings
   ;p[3] = H2A[val & 0x000F]                       ; 1er-Stelle
   ;p[2] = H2A[(val >> 4) & 0x000F]                ; 16er-Stelle
   ;p[1] = H2A[(val >> 8) & 0x000F]                ; 256er-Stelle
   ;p[0] = H2A[(val >> 12) & 0x000F]               ; 256er-Stelle
   
   
hexToASCII:
   
      PSHX               ; Sichere RegX
      PSHA               ; Sichere RegA
      PSHB               ; Sichere RegB
      
      LDY #h2a           ;  
      TFR D, Y           ; D -> Y
      TAB                ; verschiebe den Inhalt von RegA in RegB
      CLRA               ;
      LSRB               ; Logical Shift Right
      LSRB               ;
      LSRB               ;
      LSRB               ;
      ADDD #h2a          ; H2A[D] -> D
      EXG D,Y            ; D <-> Y
      MOVB Y, 1, X+      ; MOV Character to &STRING (1er-Stelle) 
      
      TFR D, Y           ; CPY D -> Y
      TAB                ; verschiebe den Inhalt von RegA in RegB 
      CLRA               ;
      ANDB #$0F          ;
      ADDD #h2a          ; H2A[D] -> D
      EXG D,Y            ; D <-> Y
      MOVB Y, 1, X+      ; MOV Character to &STRING (16er-Stelle)
      
      TFR D, Y           ;
      CLRA               ; verschiebe den Inhalt von RegA in RegB 
      LSRB               ; Logical Shift Right
      LSRB               ;
      LSRB               ;
      LSRB               ;
      ADDD #h2a          ;
      EXG D, Y           ;
      MOVB Y, 1, X+      ; MOV Character to &STRING (256er-Stelle)
      
      TFR D, Y           ;
      CLRA               ; setze 0 von d15 zu d4 
      ANDB #$0F          ;
      ADDD #h2a          ;
      EXG D,Y            ;
      MOVB Y, 1, X+      ; MOV Character to &STRING (4096er-Stelle)
                         ;
      MOVB #$00, X       ; determinierende 0
      
      PULB
      PULA
      PULX   
      RTS

