; ************************************************************* ;
;                       .:VISITOR COUNTER:.                     ;
;                                                               ;
;    Display the number of customers that can enter inside      ;
;                             a shop                            ;
; ************************************************************* ;

    processor 16f1789
    #include "config.inc"

    PSECT text, abs, class=CODE, delta=2

    org  00h
    goto start
    
    org 04h
    goto interrupt_routine
    
array:
    movf /*need to be filled */, 0 ;w <- counter (p.117 in datasheet)
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

    ;7-segments U2
    clrf TRISA		;All pins of PORTA = outputs

    ;7-segments U3
    clrf TRISB		;All pins of PORTB = outputs
    
    ;Phototransistor Q1
    movlw 00010000B	;Set the port pin types of RC
    movwf TRISC		;RC4 is input
    
    ;Phototransistor Q2 + Diode D1
    movlw 00000010B	;Set the port pin types of RD
    movwf TRISD		;RD1 is input
    
    ;Buttons B1->B4
    movlw 00001111B	;Set the port pin types of the RE
    movwf TRISE		;RE0, RE1, RE2, and RE3 are inputs
    
    movlb 02h
    clrf LATA		;All outputs of PORTA = 0
    clrf LATB		;All outputs of PORTB = 0
    clrf LATD		;All outputs of PORTD = 0
    
    movlb 03h        
    movlw 00000000B         
    movwf ANSELE	;Set all PORTE as digital
    movlw 00000000B         
    movwf ANSELD	;Set all PORTD as digital
    
    movlb 07h		;Go to bank 7
    movlw 00010000B         
    movwf INLVLC	;Set up schmitt trigger with CMOS levels for RC4

    movlw 00000010B
    movwf INLVLD	;Set up schmitt trigger with CMOS levels for RD1

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

    ;Timer1 OFF using a 1:8 prescaler /* !! VALUES MIGHT NEED TO BE UPDATED */
    movlb 00h
    movlw 00110000B	;(p.217 in datasheet)
    movwf T1CON		;Configure Timer1

    ;Timer1 Interrupt ON
    movlb 01h
    movlw 00000001B
    movwf PIE1		;Enable timer 1 overflow interrupt
    movlw 11000000B
    movwf INTCON	;Enable interrupt

    ;Trigger an interrupt /* !! VALUES MIGHT NEED TO BE UPDATED */
    movlb 00h
    movlw 00001011B	;8 most significant bits
    movwf TMR1H
    movlw 11011011B	;8 least significant bits
    movwf TMR1L
    
    ;Variables
    mode		EQU 20h	    ;0 -> choosing limit | 1 -> operating
    selectedDisplay	EQU 21h	    ;Current display being modified
    limitTenDigit	EQU 22h	    ;Ten limit chosen during setup
    limitUnitDigit	EQU 23h	    ;Unit limit chosen during setup
    tenDigit		EQU 24h	    ;Current ten digit
    unitDigit		EQU 25h	    ;Current unit digit
    needUpdateDisplay	EQU 26h	    ;If display need to be updated
 
    ;Set variables
    clrf mode
    clrf selectedDisplay
    clrf limitTenDigit
    clrf limitUnitDigit
    clrf tenDigit
    clrf unitDigit
    clrf needUpdateDisplay
    
    ;Start timer 1
    movlb 00h
    bsf T1CON, 0

    return
    
main_loop:
    movlb 00h
    btfss mode, 0
    goto handle_setup
    goto handle_operation

handle_setup:
    ;Need to be filled
    
    goto main_loop
    
handle_operation:
    ;Need to be filled
    
    goto main_loop
    
update_display:
    ;Need to be filled
    
    return ;Leave return instead of goto ...
    
interrupt_routine:
    movlb 00h
    btfss PIR1, 0   ;Timer1 overflow interrupt flag bit TMR1IF
    RETFIE

timer_interrupt:
    movlb 00h
    bcf T1CON, 0    ;Timer 1 off
    movlw 00001011B
    movwf TMR1H     ;Reset register
    movlw 11011011B
    movwf TMR1L     ;Reset register
    
    btfss mode, 0
    goto blinking_display
    goto check_barrier
    
blinking_display:
    ;Need to be filled
    
    goto clear
    
check_barrier:
    ;Need to be filled
    
    goto clear

clear:
    movlb 00h
    bcf PIR1, 0	    ;Clear timer1 interrupt
    bsf T1CON, 0    ;Timer1 on
    RETFIE