;export symbols
        XDEF initLED, setLED, getLED, toggleLED              ;

; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'
        
; ROM: Code section
.init:  SECTION

initLED:

;initaliziere alle PORTS die benötigt sind
;Am Ende sollen alle LEDs ausgeschaltet werden

  MOVB #$FF, DDRB                 ; $FF -> DDRB:  Port B.7...0 as outputs (LEDs)
  MOVB #$00, PORTB                ; $00 -> PORTB:  Port B.7...0 LED's aus
  RTS

setLED:

  STAB  PORTB
  RTS

;Das Unterprogramm hat einen 8bit Parameter in Reg B.
;Die Bits definieren welche der 8 LEDs auf 1 or 0 sind

getLED:
               
  LDAB PORTB
  RTS

;Das Unterprogramm returns einen 8bit Wert in Reg B.
;eine 1 bedeutet an und 0 aus
  

toggleLED:
  
  COM PORTB
  RTS

;Hat keine Parameter und kein Return-Wert.
;Er soll alle 8 LEDs tooglen können.