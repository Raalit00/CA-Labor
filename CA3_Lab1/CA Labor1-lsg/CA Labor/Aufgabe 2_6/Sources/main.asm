;   Labor 1 - Laboraufgabe 3.3
;   Author:   Muhammed Yildirim, Raghid Allaham

; export symbols
        XDEF Entry, main

; import symbols
        XREF __SEG_END_SSTACK       ; End of stack
        XREF decToASCII              
        XREF hexToASCII
        XREF initLCD                
        XREF writeLine              
        XREF delay_10ms
        XREF delay_0_5_sec

; include derivative specific macros
        INCLUDE 'mc9s12dp256.inc'

; RAM: Variable data section
.data:  SECTION
 dstring: ds.b 7                    ; dstring[7] 8-bit
 string:  ds.b 7                    ; string[7]  8-bit
 i:       ds.w 1                    ; int i     16-bit

; ROM: Code section
.init:  SECTION

main:                               ; Begin of the program
Entry:
        LDS  #__SEG_END_SSTACK      ; Initialize stack pointer
        CLI                         ; Enable interrupts, needed for debugger

        BSET DDRJ, #2               ; Bit Set: PORTJ.1 as output 
        BCLR PTJ, #2                ; Bit Clear: J.1 = 0 --> Act LEDS
        JSR  delay_10ms             ; Delay 20ms during power up
        JSR  delay_10ms
        JSR initLCD                 ; springe in den Unterprogramm initLCD
        MOVW #0,i                   ; setze i auf 0
loop:   
        LDY i                       ; Lade den Wert von i in den RegY
        BRCLR PTH,#8,add10          ; SW2 (mit dem Button wird dstring um 10 erhöht) 
        BRCLR PTH,#4,add16          ; SW3 (mit dem Button wird dstring um 16 erhöht)
        BRCLR PTH,#1,sub1           ; SW5 (mit dem Button wird dstring um 1  abgezogen)
        INY                         ; Inkrementiere Y in einer LOOP
        JSR delay_0_5_sec           ; Springe in den Unterprogramm Delay 0.5s
L3:     STY i                       ; speichere den Wert von Y in die Variable i ab
        
        LDD i                       ; lade den Wert von i in den RegD ab
        LDX #dstring                ; lade die Adr. von dstring in den RegX ab
        JSR decToASCII              ; springe in den Unterprogramm decToASCII
        COMA                        ; 2er-Komplement
        COMB                        ; 2er-Komplement
        ADDD #1                     ; 2er-Komplement
        
        LDAB #0                     ; Write to line 0
        JSR  writeLine              ; hier wird der Dec Wert auf dem LCD ausgegeben
                                    ;
        LDD i                       ;
        MOVB #'0', string           ; 
        MOVB #'x', string+1         ; string wird um 0x erweitert 
        LDX #string+2               ;
        JSR hexToASCII              ; springe in den Unterprogramm hexToASCII
                                    ;
        LDX #string                 ; Lade den string in den RegX
        LDAB #1                     ; Write to line 01
        JSR  writeLine              ; hier wird der Hex Wert auf dem LCD ausgegeben
        
        BRA loop                    ; LOOP
add10:
        TFR Y,D                      
        BRCLR PTH,#1,sub10           
        ADDD #10
        BRA L1
sub10:  ADDD #-10
      
L1:     TFR D,Y
        JSR delay_0_5_sec
        BRA L3
      
add16:
        TFR Y,D
        BRCLR PTH,#1,sub16
        ADDD #16
        BRA L2
sub16:  ADDD #-16
L2:     TFR D,Y
        JSR delay_0_5_sec
        BRA L3
      
sub1:   
        DEY
        JSR delay_0_5_sec
        BRA L3 
      
        
        

