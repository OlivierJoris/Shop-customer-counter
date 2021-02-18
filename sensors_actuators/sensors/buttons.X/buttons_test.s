; ************************************************************* ;
;                           BUTTONS TEST                        ;
;                                                               ;
; Test the buttons : if someone press one of the button, light  ;
; up the green LED of the receiver (D1on the schematic)         ;                      ;
; ************************************************************* ;

    processor 16f1789
    #include "config.inc"

    PSECT text, abs, class=CODE, delta=2

    org  00h
    goto start

start:
    call initialisation
    goto main_loop

initialisation:
    movlb 01h			;Go to bank 1
    movlw 00000001B		;Set the port pin types of the RE
    movwf TRISE			;RE0, RE1, RE2, and RE3 are inputs

    movlw 01111111B		;Set the port pin types of the RD
    movwf TRISD			;RD7 is output
    
    movlb 02h			    
    clrf LATD			;Clear output of all PORTD
    
    movlb 03h        
    movlw 00000000B         
    movwf ANSELE		;Set all PORTE as digital 
    movlw 00000000B         
    movwf ANSELD		;Set all PORTD as digital 
    
    ; configure the clock
    movlb 01h
    movlw 01101110B
    movwf OSCCON
    movlw 00000000B
    movwf OSCTUNE
    
    return

main_loop:
    movlb 00h
    btfss PORTE, 0	;Read RE0 pin
    goto button_is_off	;If RE0 is '0', then go to button_is_off
    goto button_is_on   ;Else go to button_is_on
    goto main_loop

button_is_on:
    movlb 02h
    movlw 10000000B	;Set RD7 output
    movwf LATD
    goto main_loop	;Go back to the main loop

button_is_off:
    movlb 02h
    movlw 00000000B	;Clear RD7 output
    movwf LATD
    goto main_loop	;Go back to the main loop
