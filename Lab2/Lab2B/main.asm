;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 24 January 2014
;// Lab 1

INCLUDE Irvine32.inc

.data 
    msg BYTE "Welcome to", 0dh, 0ah, 0
	msg2 BYTE "ASM Programming!", 0dh, 0ah,0
	msg3 BYTE 0dh, 0ah, 0
	msg4 BYTE "This class textbook cost $110.22 ", 0dh, 0ah, 0


.code
main PROC 
	call Clrscr	;//clears the screen

    mov edx, OFFSET msg	;//moves into the edx registry the first message string 
    call WriteString ;//writes the message
	mov edx, OFFSET msg2 ;//moves into the edx registry the second message string 	
	call WriteString ;//writes the message
	mov edx, OFFSET msg3 ;//moves into the edx registry the third message string 
	call WriteString ;//writes the message
	mov edx, OFFSET msg4 ;//moves into the edx registry the fourth message string 
	call WriteString ;//writes the message

    exit
main ENDP
END main
