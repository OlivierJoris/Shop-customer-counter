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

array:		    ;Need to put value in w before calling
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

    ;Timer1 OFF using a 1:8 prescaler
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
    maxDigit		EQU 27h	    ;Max value for a digit

    ;Set variables
    clrf mode
    clrf selectedDisplay
    clrf limitTenDigit
    clrf limitUnitDigit
    clrf tenDigit
    clrf unitDigit
    clrf needUpdateDisplay
    movlw 00001001B	;9 in binary
    movwf maxDigit

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
    ;Handles the buttons B1->B4 during the selection of the
    ;maximum number of customers
    bsf PORTD, 7
    
    goto main_loop
    
digit_minus:
    ;Decrements limitTenDigit or limitUnitDigit based on
    ;selectedDisplay and current respective value

    movlb 00h
    btfss selectedDisplay, 0	;Check which variable need to be modified
    goto digit_minus_ten
    goto digit_minus_unit

digit_minus_ten:		;Update variable for tens
    movlw 00000000B
    subwf limitTenDigit, 0
    btfss STATUS, 2		;Check if limitTenDigit == 0
    decf limitTenDigit, 1	;If not, decrement it
    goto digit_minus_end

digit_minus_unit:		;Update variable for units
    movlw 00000000B
    subwf limitUnitDigit, 0
    btfss STATUS, 2		;Check if limitUnitDigit == 0
    decf limitUnitDigit, 1	;If not, decrement it
    goto digit_minus_end

digit_minus_end:
    return

digit_plus:
    ;Increments limitTenDigit or limitUnitDigit based on
    ;selectedDisplay and current respective value

    movlb 00h
    btfss selectedDisplay, 0	;Check which variable need to be modified
    goto digit_plus_ten
    goto digit_plus_unit

digit_plus_ten:			;Update variable for tens
    movf limitTenDigit
    subwf maxDigit, 0
    btfss STATUS, 2		;Check if limitTenDigit == maxDigit
    incf limitTenDigit, 1	;If not, increment it
    goto digit_plus_end
digit_plus_unit:		;Update variable for units
    movf limitUnitDigit
    subwf maxDigit, 0
    btfss STATUS, 2		;Check if limitUnitDigit == maxDigit
    incf limitUnitDigit, 1	;If not, increment it
    goto digit_plus_end

digit_plus_end:
    return
    
next_digit:
    ;Modifies which of the 2 7-segments is going
    ;to be modified

    movlb 00h
    btfss selectedDisplay, 0
    goto next_digit_right
    goto switch_mode
next_digit_right:
    movlw 00000001B
    movwf selectedDisplay
    goto next_digit_end
switch_mode:
    movf limitTenDigit, 0
    movwf tenDigit
    movf limitUnitDigit, 0
    movwf unitDigit
    movlw 00000001B
    movwf mode
next_digit_end:
    return

update_setup_display:
    ;Updates the 7-segments during the setup phase

    movlb 00h
    movf limitTenDigit, 0
    call array
    movwf PORTA

    movf limitUnitDigit, 0
    call array
    movwf PORTB
    return

handle_operation:
    movlb 00h
    bcf PORTD, 7
    ;btfsc PORTE, 3	;Check the reset button
    ;call digit_reset

    btfsc needUpdateDisplay, 0
    call update_display

    goto main_loop

digit_reset:
    movlb 00h
    bcf mode, 0     ;Return in setup mode
    clrf tenDigit
    clrf unitDigit

    call update_display ;Display 0 on both 7-segments

    return

update_display:
    movlb 00h
    movf tenDigit, 0
    call array
    movwf PORTA

    movf unitDigit, 0
    call array
    movwf PORTB

    bcf needUpdateDisplay, 0

    return

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
    goto setup
    goto check_barrier
    
setup:
    movlb 00h
    btfsc PORTE, 0	;Check minus button
    call digit_minus
    btfsc PORTE, 1	;Check plus button
    call digit_plus
    btfsc PORTE, 2	;Check next digit button
    call next_digit
    ;Reset button is not considered because we are
    ;are already in the setup mode
    call update_setup_display
    goto clear

someone_leaves:
    movlb 00h
    movf tenDigit, 0
    subwf limitTenDigit, 0
    btfsc STATUS, 2 ;check if tenDigit == limitTenDigit
    goto check_units ;If equal, check for the unit digit
    goto increment_current_digit ;Else, we can just increment safely

check_units:
    movf unitDigit, 0
    subwf limitUnitDigit, 0 
    btfsc STATUS, 2 ;check if unitDigit == limitUnitDigit
    return ;If equal, we return without updating the display 

increment_current_digit:
    movf unitDigit, 0
    sublw 00001001B 
    btfsc STATUS, 2 ;check if unitDigit = 9 
    goto increment_ten
    incf unitDigit, 1 ;increment unitDigit
    movlw 00000001B	
    movwf needUpdateDisplay ;the display need to be updated
    return

increment_ten:
    movf tenDigit, 0
    sublw 00001001B 
    btfsc STATUS, 2 ;check if tenDigit = 9 
    return ;can't go up (we are at 99)
    incf tenDigit, 1
    clrf unitDigit ;increment ten and reset units
    movlw 00000001B	
    movwf needUpdateDisplay ;the display need to be updated
    return

someone_enters:
    movlb 00h

decrement_current_digit:
    movf unitDigit, 0
    sublw 00000000B 
    btfsc STATUS, 2 ;check if unitDigit = 0 
    goto decrement_ten
    decf unitDigit, 1 ;decrement unitDigit
    movlw 00000001B	
    movwf needUpdateDisplay ;the display need to be updated
    return

decrement_ten:
    movf tenDigit, 0
    sublw 00000000B 
    btfsc STATUS, 2 ;check if tenDigit = 0
    return ;can't go down (we are at 00)
    decf tenDigit, 1
    movlw 00001001B	
    movwf unitDigit ;decrement ten and reset units to 9
    movlw 00000001B	
    movwf needUpdateDisplay ;the display need to be updated
    return

check_barrier:
    movlb 00h
    btfss PORTD, 1 ;Read RD1 pin
    call someone_leaves ;Pass detected at shop enter

    btfss PORTC, 4 ;Read RC4 pin
    call someone_enters ;Pass detected at shop exit
    
    goto clear

clear:
    movlb 00h
    bcf PIR1, 0	    ;Clear timer1 interrupt
    bsf T1CON, 0    ;Timer1 on
    RETFIE
