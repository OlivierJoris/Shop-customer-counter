; ************************************************************* ;
;                           BUTTONS TEST                        ;
;                                                               ;
; Test the buttons : if someone press one of the button, light  ;
; up the green LED of the receiver (D1on the schematic)         ;                      ;
; ************************************************************* ;

    processor 16f1789
    #include "config.inc"

    PSECT text, abs, class=CODE, delta=2

    org 	00h
	goto    start

start:
    movlb 01h			;Go to bank 1
    movlw 00001111B		;Set the port pin types of the RE
    movwf TRISE			;RE0, RE1, RE2, and RE3 are inputs

    movlw 01111111B     ;Set the port pin types of the RD
    movwf TRISD			;RD7 is output
    movlb 00h			;Go to bank 0

main_loop:
    btfss PORTE, 0	    ;Read RE0 pin
    goto button_is_off	;If RE0 is '0', then go to button_is_off
    btfss PORTE, 1      ;Read RE1 pin
    goto button_is_off  ;If RE1 is '0', then go to button_is_off
    btfss PORTE, 2      ;Read RE2 pin
    goto button_is_off  ;If RE2 is '0', then go to button_is_off
    btfss PORTE, 3      ;Read RE3 pin
    goto button_is_off  ;If RE3 is '0', then go to button_is_off

button_is_on:
    bsf PORTD, 7		;Set RD7 output
    goto main_loop		;Go back to the main loop

button_is_off:
    bcf PORTD, 7		;Clear RD7 output
    goto main_loop		;Go back to the main loop
