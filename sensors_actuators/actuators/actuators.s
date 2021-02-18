; *** NOT WORKING BUT KEPT FOR LATER ***

; ************************************************************* ;
;                       .:ACTUATORS:.                           ;
;                                                               ;
;    Display a 1 to 99 number on the 7-segments with            ;
;    a 0.25 seconds delay before refreshing a new number.       ;
;                                                               ;
;     Idea                                                      ;
;     ====                                                      ;
;     -> There is a counter to store the current number of the  ;
;        7-segments.                                            ;
;     -> There is a maxcounter to determine the maximum value   ;
;        the counter can reach (10 for the moment).             ;
;     -> The counter takes its corresponding digit              ;
;        representation in the array : one for the first        ;
;        7-segment and one for the second 7-segment.            ;
;     -> When the counter is too high (counter=maxcounter),     ;
;        he is being reset to 0.                                ;
;     -> The 7-segments display a new digit every 250ms         ;
;        (with a 4MHz frequency) or when a button (B1/B2/B3/B4) ;
;        is pushed.                                             ;
;                                                               ;
;     Remarks:                                                  ;
;     - The splitting counter is not implemented yet.           ;
;       -> idea with 47: 47/10 to get 4, 47%10 to get 7.        ;
;      (the same digit is displayed on both 7-segments instead) ;
;                                                               ;
;     - The digit selector button is not implemented yet.       ;
;                                                               ;
; ************************************************************* ;

    processor 16f1789
    #include "config.inc"

    PSECT text, abs, class=CODE, delta=2

    counter EQU 20h    ;adress 20 = General Purpose Register (p.33 in datasheet)
    maxcounter EQU 21h ;adress 21 = General Purpose Register (p.33 in datasheet)

    org 	00h
	  goto  start


array:
    movf counter, w ;w <- counter (p.117 in datasheet)
    addwf PCL, f    ;w is added to PC in order to jump to the corresponding line
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
    movlb 01h			    ;Go to bank 1

    movlw 10d         ;w <- 10
    movwf maxcounter  ;maxcounter <- w

    ;7-segment on the left side(U2)
    clrf TRISA        ;All pins of PORTA = outputs

    ;7-segment on the right side(U3)
    clrf TRISB        ;All pins of PORTB = outputs

    ;Buttons
    movlw 00001111B	  ;RE0,...,RE3 pins = inputs
    movwf TRISE			  ;RE3 <- B1 (Resets)
                      ;RE2 <- B2 (Digit selector)
                      ;RE1 <- B3 (Increments)
                      ;RE0 <- B4 (Decrements)

    movlb 00h			    ;Go to bank 0

    ;Clock configuration
    movlb 01h
    movlw 01101110B
    movwf OSCCON
    movlw 00000000B
    movwf OSCTUNE

    ;Timer1 ON using a 1:4 prescaler (250 000/4)
    movlb 00h
    movlw 00100001B   ;(p.217 in datasheet)
    movwf T1CON       ;configure Timer1

    ;Timer1 Interrupt ON
    movlb 01h
    movlw 00000001B
    movwf PIE1
    movlw 11000000B
    movwf INTCON      ;TMR0IF 1 if timer has overflowed (FFFFh <- TMR1)

    ;Trigger an interrupt after 250 ms (65535 - [4000000*0.25/4²])
    movlb 00h
    movlw 00001011B the 8 most significant bits
    movwf TMR1H
    movlw 11011011B the 8 least significant bits
    movwf TMR1L

    return

main_loop:
    btfsc PORTE, 0	         ;RE0 == 1 ?
      goto reset_on          ;->Resets!
    btfsc PORTE, 1           ;RE1 == 1 ?
      goto increment_on      ;->Increments the counter number!
    btfsc PORTE, 2           ;RE2 == 1 ?
      goto digit_selector_on ;->Puts a right digit!
    btfsc PORTE, 3           ;RE3 == 1 ?
      goto decrement_on      ;->Decrements the counter number!

    goto interrupt_routine

    goto main_loop

interrupt_routine:
    btfss INTCON, 2
    goto timer_interrupt
    RETFIE

timer_interrupt:
    movlb 00h
    bcf T1CON, 0    ;set the first bit to 0
    movlw 00001011B
    movwf TMR1H     ;reset register
    movlw 11011011B
    movwf TMR1L     ;reset register
    bsf T1CON, 0    ;set the first bit to 1

    goto increment_on


digit_selector_on:

    goto increment_on

increment_on:
    call array          ;fetch the number in w based on the counter index
    movwf PORTA         ;pins of the first 7-segment go high based on the number fetched
    movwf PORTB         ;pins of the second 7-segment go high based on the number fetched
    incf counter, f     ;increments the counter
    movf counter, w     ;updates the w value
    subwf maxcounter, w ;counter - maxcounter
    btfsc STATUS, z     ;[counter - maxcounter] == 0 ? (z=zero bit : result of the ALU, p.31 in datasheet)
    clrf counter        ;counter <- 0

    goto clear

    goto main_loop

decrement_on:
    call array          ;fetch the digit in w based on the counter index
    movwf PORTA         ;pins of the first 7-segment go high based on the digit fetched
    movwf PORTB         ;pins of the second 7-segment go high based on the digit fetched
    btfss counter, 0    ;counter == 0 ?
    decf counter, f     ;increments the counter
    movf counter, w     ;updates w

    goto main_loop

reset_on:
    clrf counter        ;counter <- 0
    call array          ;fetch the number in w based on the counter index
    movf counter, w     ;updates w

    goto main_loop

clear:
    bcf INTCON, 2
    RETFIE
