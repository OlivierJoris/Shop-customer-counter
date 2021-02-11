; ************************************************************* ;
;                           IR TEST                             ;
;                                                               ;
; Test the infra-red receivers : if someone (or just an object) ; 
; is detected by one of the sensor, light up the green ; LED of ;
; the receiver (D1 on the schematic)                            ;
; ************************************************************* ;
    
    processor 16f1789
    #include "config.inc"

    PSECT text, abs, class=CODE, delta=2

    org 	00h
	goto    start

start:
    movlb 01h			;Go to bank 1
    movlw 00010000B		;Set the port pin types of RC
    movwf TRISC			;RC4 is input

    movlw 00000010B	    ;Set the port pi types of RD
    movwf TRISD         ;RD1 is input

    movlw 10000000B     ;Set the port pin types of the RD
    movwf TRISD			;RD7 is output
    movlb 00h			;Go to bank 0

main_loop:
    btfss PORTC, 4	    ;Read RC4 pin
    goto button_is_off	;If RC4 is '0', then go to no_pass_detected
    btfss PORTD, 1      ;Read RD1 pin
    goto button_is_off  ;If RE1 is '0', then go to no_pass_detected

pass_detected:
    bsf PORTD, 7		;Set RD7 output
    goto main_loop		;Go back to the main loop

no_pass_detected:
    bcf PORTD, 7		;Clear RD7 output
    goto main_loop		;Go back to the main loop
	