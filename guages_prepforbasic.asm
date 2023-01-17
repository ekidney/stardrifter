*=$1201


        jmp start

SCREENMEM=$1000
COLORMEM=$9300
COLORSTART=$95A2    

XBARCHARACTERS
    BYTE $20,$73,$74,$75,$76,$77,$78,$79,$7A  ; $20 A0 65 e7
    ;     0   1   2   3   4   5   6   7   8
        byte 0

SCREENY
    BYTE $06,$1C,$32,$48,$58,$6E,$84,$9A,$B0
    
    ;     0   1   2   3   4   5   6   7   8
        byte 0

BARSTARTHI
    BYTE $01
BARSTARTLO
    BYTE $02

VITALS              ; current power value set to arbitary
    ;BYTE $50, $70, $B0, $FF  
    BYTE $50, $00, $00, $00
    ;BYTE $F5, $FB, $FD, $FF
NVITALS              ; new power value set to arbitary
    ;BYTE $00, $00, $00, $00
    BYTE $D0, $B0, $80, $20 

POWERRESULT        ; result for bar
    BYTE $00
REMAIN
    BYTE $00       ; remainder dictating final bar symbol
POWERBUF
    BYTE $00
REMAINBUF
    BYTE $00
BARCOLOR
    BYTE $02
VITALN             ; which vital is processing
    BYTE $00
CURV
    BYTE $00       ; current vital
NEWV
    BYTE $00       ; new vital 

    
start
   ;tax ; init
   ;tay ; init
   ;jsr buildb ;bb
   

MAINLOOP
   ;jsr $FFE4            ;test input
   ;cmp #0               ;if no input ...
   ;beq MAINLOOP         ;  don't do anything
   jsr TEST_VITALS
   jsr buildb
   rts

TEST_VITALS
    LDX #00
    STX VITALN                  ;reset index
        

vitalsLoop
    LDX VITALN                  ;load v index
    LDA NVITALS,X               ;load new vitals
    STA NEWV
    LDY VITALS,X                ;load current vitals to Y
    CPY NEWV                    ;compare to new vitals
    BEQ incLoop                 ;if the same nm go to next vital 
    CPY NEWV                    ;compare to current vitals
    BCC lessthan                ;if more than do more
    LDA VITALS,X
    DEY                         ;assume less than, so dec
    TYA
    STA VITALS,X

incLoop

    INX
    ;jsr buildxbar              ;if keeping track of X exit to build bar 
    CPX #$04
    BEQ returnl                  ;***EXIT LOOP TO BUILD WHOLE BARS??****
    STX VITALN
    jmp vitalsLoop
     
lessthan
    LDY VITALS,X
    INY
    TYA
    STA VITALS,X
    jmp incLoop

returnl
    jsr reset
    rts

   
    
buildb  clc
        Ldx #$00    ; load zero
vloop   jsr getlen  ; calculate length of the bar
        jsr barloc  ; get the screen location of the beginning of the current bar
        jsr bardraw ; draw bar
        jsr printr  ; print remainder of bar
        CLC
        LDA BARCOLOR             ;lets increment barcolor
        ADC #$01
        STA BARCOLOR
        CLC
        LDA VITALN               ;lets incrememt vital ID
        ADC #$01
        STA VITALN
        CMP #$04                 ;check if 4 bars have been drawn
        BEQ gotoMain             ;if so go to main
        jmp vloop                ;if not continue cycle
        rts                     ;could be deprecated

gotoMain
        ;jsr reset
        rts            ;begin main guage update loop

reset   LDA #02
        STA BARSTARTLO
        LDA #02
        STA BARCOLOR
        LDA #00
        STA VITALN
        LDX #00
        LDY #00
        rts

barloc  ldx VITALN
        lda SCREENY,X
        sta BARSTARTLO
        rts

printr  LDX REMAIN              ;get remainder
        LDA XBARCHARACTERS,X    ;use remainder to get correct char
        TAY                     ;store char in Y
        LDA POWERRESULT         ;get power result for screen pos addition
        ADC BARSTARTLO          ;add screen pos addition to bar start screen location
        TAX                     ;store final screen pos in X
        TYA                     ;put chracter in A
        STA $11A1,X             ;store final position as addition to starting point of 
        RTS

color   LDX #$00
ccont   LDA BARCOLOR
        CMP #$05
        BEQ creturn
        STA COLORSTART,X     
        INX        
        CPX #$21
        BEQ colorChange
        jmp ccont
creturn rts
        

colorChange
        INC BARCOLOR
        LDA COLORSTART
        ADC #$22
        STA COLORSTART
        jmp ccont
        
bardraw LDA BARSTARTLO  ;load screen location of bar start
        TAX             ; put screen location in x register
        LDA #$00        ;load 0
        TAY             ;transfer 0 to y register for counting up        
barloop LDA #$A0        ;load a block
        CPY #$00
        BEQ noblock
        STA $11A1,X     ;store block on screen location
noblock LDA BARCOLOR    ;load current color
        STA $95A1,X     ;store color
        INX
        STA $95A1,X     ;debug by printing colour on next location
        DEX             ;debug cont.
        CPY POWERRESULT ;check if main bar is drawn       
        BCS exit        ;exit if so
        INX
        INY
        JMP barloop

exit    
        RTS

getlen  LDX VITALN
        LDA VITALS,X
        CLC
        LSR
        LSR
        LSR
        LSR
        STA POWERRESULT ; divide 256 number by 16 to get round number of bar
        LDA VITALS,X
        AND #$0F ; get lo nybble of bar to get remainder
        LSR ; divide lo remainder by 2 to get value between 1 and 8
        STA REMAIN
        RTS

CLEAR
        LDA #$93   ; Load the Accumulator register (A storage location in the CPU)
           ; with the value $93, which is the Clear Screen code
        JSR $FFD2  ; Jump to a subroutine at location $FFD2 (Print a character routine).
        rts
     

