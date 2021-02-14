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
    goto	start

start:
    call initialisation
    goto main_loop

initialisation:
    movlb 01h			    ;Go to bank 1
    clrf TRISC
    movlw 00010000B		    ;Set the port pin types of RC
    movwf TRISC			    ;RC4 is input
    
    clrf TRISD			    ;All pins of PORTD are output
    movlw 00000010B		    ;RD1 is input. Others are output.
    movwf TRISD			    ;RD1 is input
    
    movlb 02h			    
    clrf LATD               ;Clear output of all PORTD

    movlb 07h               ;Go to bank 7
    movlw 00010000B         
    movwf INLVLC            ;Set up schmitt trigger with CMOS levels for RC4

    movlw 00000010B
    movwf INLVLD            ;Set up schmitt trigger with CMOS levels for RD1
    
    ; configure the clock
    movlb 01h
    movlw 01101110B
    movwf OSCCON
    movlw 00000000B
    movwf OSCTUNE
    
    return

main_loop:
    movlb 00h
    btfss PORTC, 4	            ;Read RC4 pin
    goto no_pass_detected	    ;If RC4 is '0', then go to no_pass_detected
    goto pass_detected          ;Else go to pass_detected
    btfss PORTD, 1	            ;Read RD1 pin
    goto no_pass_detected       ;If RD1 is '0', then go to no_pass_detected
    goto pass_detected          ;Else go to pass_detected

pass_detected:
    movlb 02h
    movlw 10000000B	            ;Set RD7 output
    movwf LATD
    goto main_loop	            ;Go back to the main loop

no_pass_detected:
    movlb 02h
    movlw 00000000B		        ;Clear RD7 output
    movwf LATD
    goto main_loop	            ;Go back to the main loop
	
