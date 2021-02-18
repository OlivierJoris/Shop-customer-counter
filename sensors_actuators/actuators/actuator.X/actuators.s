; ************************************************************* ;
;                       .:ACTUATORS:.                           ;
;                                                               ;
;    Display 0 to 9 on each 7-segments with a delay between     ;
;    each digit.                                                ;
;                                                               ;
;     Idea:                                                     ;
;     =====                                                     ;
;     -> There is a counter to store the current digit of the   ;
;        7-segments.                                            ;
;     -> There is a maxcounter to determine the maximum value   ;
;        the counter can reach (10 for the moment).             ;
;     -> The counter takes its corresponding digit              ;
;        representation in the array                            ;
;     -> When the counter is too high (counter=maxcounter),     ;
;        it is being reset to 0.		                ;
; ************************************************************* ;

    processor 16f1789
    #include "config.inc"

    PSECT text, abs, class=CODE, delta=2

    org  00h
    goto start
    
    org 04h
    goto interrupt_routine


array:
    movf counter, 0 ;w <- counter (p.117 in datasheet)
    addwf PCL, 1    ;w is added to PCL in order to jump to the corresponding line
                    ;which is returning a literal value into w (retlw) and
                    ;comes back to the originated call.
    retlw 00111111B ;representation of 0 in the 7-segment(3F)
    retlw 00000110B ;representation of 1 in the 7-segment(06)
    retlw 01011011B ;representation of 2 in the 7-segment(5B)
    retlw 01001111B ;representation of 3 in the 7-segment(4F)
    retlw 01100110B ;representation of 4 in the 7-segment(66)
    retlw 01101101B ;representation of 5 in the 7-segment(6D)
    retlw 01111100B ;representation of 6 in the 7-segment(7D)
    retlw 00000111B ;representation of 7 in the 7-segment(07)
    retlw 01111111B ;representation of 8 in the 7-segment(7F)
    retlw 01100111B ;representation of 9 in the 7-segment(6F)

start:
    call initialisation
    goto main_loop

initialisation:
    movlb 01h		;Go to bank 1

    ;7-segment on the left side(U2)
    clrf TRISA		;All pins of PORTA = outputs

    ;7-segment on the right side(U3)
    clrf TRISB		;All pins of PORTB = outputs
    
    movlb 02h
    clrf LATA		;All outputs of PORTA = 0
    clrf LATB		;All outputs of PORTB = 0

    ;Clock configuration - 4MHz - Internal oscillator
    movlb 01h
    movlw 01101110B
    movwf OSCCON
    movlw 00000000B
    movwf OSCTUNE
    
    ;Clear before enabling interrupts
    movlb 00h
    clrf TMR1H
    clrf TMR1L
    bcf PIR1, 0		;TMR1IF = 0

    ;Timer1 ON using a 1:8 prescaler
    movlb 00h
    movlw 00110001B	;(p.217 in datasheet)
    movwf T1CON		;configure Timer1

    ;Timer1 Interrupt ON
    movlb 01h
    movlw 00000001B
    movwf PIE1		;Enable timer 1 overflow interrupt
    movlw 11000000B
    movwf INTCON	;Enable interrupt

    ;Trigger an interrupt
    movlb 00h
    movlw 00001011B	;the 8 most significant bits
    movwf TMR1H
    movlw 11011011B	;the 8 least significant bits
    movwf TMR1L
    
    counter EQU 20h    ;adress 20 = General Purpose Register (p.33 in datasheet)
    maxcounter EQU 21h ;adress 21 = General Purpose Register (p.33 in datasheet)
 
    ;set counter and maxcounter
    movlb 00h
    movlw 00000000B
    movwf counter
    movlw 00001010B
    movwf maxcounter

    return

main_loop:
    goto main_loop

interrupt_routine:
    movlb 00h
    btfss PIR1, 0   ;timer1 overflow interrupt flag bit TMR1IF
    RETFIE

timer_interrupt:
    movlb 00h
    bcf T1CON, 0    ;set the first bit to 0
    movlw 00001011B
    movwf TMR1H     ;reset register
    movlw 11011011B
    movwf TMR1L     ;reset register

increment_on:
    call array          ;fetch the number in w based on the counter index
    movlb 00h
    movwf PORTA         ;pins of the first 7-segment go high based on the number fetched
    movwf PORTB         ;pins of the second 7-segment go high based on the number fetched
    incf counter, 1     ;increments the counter
    movf counter, 0     ;updates the w value
    subwf maxcounter, 0 ;maxcounter - counter
    btfsc STATUS, 2     ;[maxcounter - counter] == 0 ? (2nd bit=zero bit : result of the ALU, p.31 in datasheet)
    clrf counter        ;counter <- 0

clear:
    movlb 00h
    bcf PIR1, 0	    ;clear timer1 interrupt
    bsf T1CON, 0    ;timer1 on
    RETFIE
