;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 24 January 2014
;// Lab 1

INCLUDE Irvine32.inc

.data 
    msg BYTE "Hello World", 0dh, 0ah, 0

.code
main PROC 
    mov edx, OFFSET msg
    call WriteString
	call ReadHex
	call WriteHex
    exit
main ENDP
END main
