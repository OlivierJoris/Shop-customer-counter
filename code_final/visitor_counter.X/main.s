; ************************************************************* ;
;                       .:VISITOR COUNTER:.                     ;
;                                                               ;
;    Displays the number of customers that can enter inside     ;
;     a shop & detects who is entering or leaving based on      ;
;                        an infrared system                     ;
;                                                               ;
;         CRUCIFIX Arnaud, GOFFART Maxime, JORIS Olivier        ;
;                      Academic Year 2020-2021                  ;
;                                                               ;
; ************************************************************* ;

    processor 16f1789
    #include "config.inc"

    PSECT text, abs, class=CODE, delta=2

    org  00h
    goto start

    org 04h
    goto interrupt_routine

;Contains the mapping between a number and the representation
;on a 7-segment.
array:		        ;Need to put value in w before calling
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

;Initializes the MCU;
initialisation:
    ;IO configuration
    movlb 01h

    ;7-segments U2
    clrf TRISA		;All pins of PORTA = outputs

    ;7-segments U3
    clrf TRISB		;All pins of PORTB = outputs

    ;TSOP U4
    movlw 00010000B	;Set the port pin types of RC
    movwf TRISC		;RC4 is input

    ;TSOP U5 + Diode D2 + Button B1
    movlw 00000011B	;Set the port pin types of RD
    movwf TRISD		;RD0 & RD1 is input

    ;Buttons B2->B4
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
    movlw 00000000B
    movwf ANSELC    ;Set all PORTC as digital

    movlb 07h
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

    ;Interrupts configuration
    movlb 00h
    clrf TMR1H
    clrf TMR1L
    bcf PIR1, 0		;TMR1IF = 0

    ;Timer1 using a 1:8 prescaler
    movlb 00h
    movlw 00110000B	;(p.217 in datasheet)
    movwf T1CON		;Configure Timer1

    ;Timer1 Interrupt
    movlb 01h
    movlw 00000001B
    movwf PIE1		;Enable timer 1 overflow interrupt
    movlw 11000000B
    movwf INTCON	;Enable interrupt

    ;Trigger an interrupt
    movlb 00h
    movlw 00001011B	;8 most significant bits
    movwf TMR1H
    movlw 11011011B	;8 least significant bits
    movwf TMR1L

    ;Variables
    mode		        EQU 20h     ;0 -> config | 1 -> operating
    selectedDisplay	    EQU 21h	    ;Current display being modified
    limitTenDigit	    EQU 22h	    ;Ten limit chosen during setup
    limitUnitDigit	    EQU 23h	    ;Unit limit chosen during setup
    tenDigit		    EQU 24h	    ;Current ten digit
    unitDigit		    EQU 25h	    ;Current unit digit
    needUpdateDisplay	EQU 26h     ;If display need to be updated
    maxDigit		    EQU 27h	    ;Max value for a digit

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
    call update_setup_display

    ;Starts timer 1
    movlb 00h
    bsf T1CON, 0

    return

; ------ CODE FOR MAIN LOOP ------

;Main loop of the program
main_loop:
    ;Choose between configuration and operating mode
    movlb 00h
    btfss mode, 0
    goto handle_setup       ;If in configuration mode
    goto handle_operation   ;If in operating mode

;Configuration mode.
;Handles the buttons B1->B4 during the selection of the
;maximum number of customers.
handle_setup:
    ;Switch on LED D2
    bsf PORTD, 7
    
    ;Checks if display need to be updated & updates if required
    btfsc needUpdateDisplay, 0
    call update_setup_display
    
    goto main_loop

;Operating mode
;Checks the status of the barrier & updates the counter accordingly.
;If the counter is modified, updates the 7-segments accordingly.
handle_operation:
    movlb 00h
    bcf PORTD, 7    ;Switches off LED D2.
    btfsc PORTD, 0	;Checks the reset button
    call digit_reset

    ;Checks if display need to be updated & updates it if required
    btfsc needUpdateDisplay, 0
    call update_display

    goto main_loop

; ------ END CODE FOR MAIN LOOP ------


; ------ CODE FOR CONFIG MODE ------

;Updates the 7-segments during the config mode
update_setup_display:
    movlb 00h
    bcf needUpdateDisplay, 0
    movf limitTenDigit, 0
    call array
    movwf PORTA

    movf limitUnitDigit, 0
    call array
    movwf PORTB
    return

;Decrements limitTenDigit or limitUnitDigit based on
;selectedDisplay and current respective value.
digit_minus:
    movlb 00h
    btfss selectedDisplay, 0    ;Checks which variable need to be modified
    goto digit_minus_ten
    goto digit_minus_unit

digit_minus_ten:		;Updates variable for tens
    movlw 00000000B
    subwf limitTenDigit, 0
    btfss STATUS, 2		;Checks if limitTenDigit == 0
    goto digit_minus_ten_dec
    goto digit_minus_end
digit_minus_ten_dec:
    decf limitTenDigit, 1	;If not, decrement it
    bsf needUpdateDisplay, 0
    goto digit_minus_end

digit_minus_unit:		;Update variable for units
    movlw 00000000B
    subwf limitUnitDigit, 0
    btfss STATUS, 2		;Check if limitUnitDigit == 0
    goto digit_minus_unit_dec
    goto digit_minus_end
digit_minus_unit_dec:
    decf limitUnitDigit, 1	;If not, decrement it
    bsf needUpdateDisplay, 0

digit_minus_end:
    return

;Increments limitTenDigit or limitUnitDigit based on
;selectedDisplay and current respective value
digit_plus:
    movlb 00h
    btfss selectedDisplay, 0	;Checks which variable need to be modified
    goto digit_plus_ten
    goto digit_plus_unit

digit_plus_ten:			;Updates variable for tens
    movf limitTenDigit
    subwf maxDigit, 0
    btfss STATUS, 2		;Checks if limitTenDigit == maxDigit
    goto digit_plus_ten_inc
    goto digit_plus_end
digit_plus_ten_inc:
    incf limitTenDigit, 1	;If not, increments it
    bsf needUpdateDisplay, 0
    goto digit_plus_end

digit_plus_unit:		;Updates variable for units
    movf limitUnitDigit
    subwf maxDigit, 0
    btfss STATUS, 2		;Checks if limitUnitDigit == maxDigit
    goto digit_plus_unit_inc
    goto digit_plus_end
digit_plus_unit_inc:
    incf limitUnitDigit, 1	;If not, increments it
    bsf needUpdateDisplay, 0

digit_plus_end:
    return
    
;Modifies which of the 2 7-segments is going
;to be modified
next_digit:
    movlb 00h
    btfss selectedDisplay, 0
    goto next_digit_right
    goto switch_mode
next_digit_right:
    movlw 00000001B
    movwf selectedDisplay
    goto next_digit_end
switch_mode: ; If both digit already set, switches to operating mode
    movf limitTenDigit, 0
    movwf tenDigit
    movf limitUnitDigit, 0
    movwf unitDigit
    movlw 00000001B
    movwf mode
next_digit_end:
    return

; ------ END CODE FOR CONFIG MODE ------


; ------ CODE FOR OPERATING MODE ------

;Reacts when the reset button has been pressed during operating mode
digit_reset:
    movlb 00h
    bcf mode, 0                 ;Returns in configuration mode
    clrf tenDigit               ;Clears current counters
    clrf unitDigit
    clrf selectedDisplay        ;Reset display being selected
    call update_setup_display   ;Display last values of setup

    return

;Updates the 7-segments during the operating mode
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

;Reacts when someone leaves the shop
someone_leaves:
    movlb 00h
    movf tenDigit, 0
    subwf limitTenDigit, 0
    btfsc STATUS, 2                 ;Checks if tenDigit == limitTenDigit
    goto check_units                ;If equal, checks for the unit digit
    goto increment_current_digit    ;Else, we can just increment safely

check_units:
    movf unitDigit, 0
    subwf limitUnitDigit, 0 
    btfsc STATUS, 2 ;Checks if unitDigit == limitUnitDigit
    return          ;If equal, we return without updating the display 

increment_current_digit:
    movf unitDigit, 0
    sublw 00001001B 
    btfsc STATUS, 2         ;Checks if unitDigit = 9 
    goto increment_ten
    incf unitDigit, 1       ;Increments unitDigit
    movlw 00000001B	
    movwf needUpdateDisplay ;The display need to be updated
    return

increment_ten:
    movf tenDigit, 0
    sublw 00001001B 
    btfsc STATUS, 2         ;Checks if tenDigit = 9 
    return                  ;Can't go up (we are at 99)
    incf tenDigit, 1
    clrf unitDigit          ;Increments ten and reset units
    movlw 00000001B	
    movwf needUpdateDisplay ;The display need to be updated
    return

;Reacts when someone enters the shop
someone_enters:
    movlb 00h

decrement_current_digit:
    movf unitDigit, 0
    sublw 00000000B 
    btfsc STATUS, 2         ;Checks if unitDigit = 0 
    goto decrement_ten
    decf unitDigit, 1       ;Decrements unitDigit
    movlw 00000001B	
    movwf needUpdateDisplay ;The display need to be updated
    return

decrement_ten:
    movf tenDigit, 0
    sublw 00000000B 
    btfsc STATUS, 2         ;Checks if tenDigit = 0
    return                  ;Can't go down (we are at 00)
    decf tenDigit, 1
    movlw 00001001B	
    movwf unitDigit         ;Decrements ten and reset units to 9
    movlw 00000001B	
    movwf needUpdateDisplay ;The display need to be updated
    return

; ------ END CODE FOR OPERATING MODE ------


; ------ CODE FOR INTERRUPT ROUTINE ------

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

    btfss mode, 0       ;Checks the current mode 
    goto setup          ;If config mode
    goto check_barrier  ;If operating mode

;Handles interrupt when in configuration mode  
setup:
    movlb 00h
    btfsc PORTE, 0	;Checks minus button
    call digit_minus
    btfsc PORTE, 1	;Checks plus button
    call digit_plus
    btfsc PORTE, 2	;Checks next digit button
    call next_digit
    ;Reset button is not considered because we are
    ;are already in the setup mode
    goto clear

;Handles interrupt when in operating mode
check_barrier:
    movlb 00h
    btfsc PORTD, 1      ;Reads RD1 pin
    call someone_leaves ;Pass detected at shop exit

    btfsc PORTC, 4      ;Reads RC4 pin
    call someone_enters ;Pass detected at shop entry
    
    goto clear

clear:
    movlb 00h
    bcf PIR1, 0	    ;Clear timer1 interrupt
    bsf T1CON, 0    ;Timer1 on
    RETFIE

; ------ END CODE FOR INTERRUPT ROUTINE ------
