;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 12 February 2014
;// Practice 4

TITLE Add and Subtract (AddSub.asm)
; //This program adds and subtracts 32-bit integers.

INCLUDE Irvine32.inc		;// Irvine's library of functions such as WriteInt

.code				;// code segment. all the instructions go here
main PROC			;// main procedure or start point of the program
	mov eax, 10000h ;// the eax register is updated to equal 10000 hex
	call WriteInt	;// this displays +65536 because WriteInt writes the signed decimal value of the eax register
	call Crlf		;//this function creates Carriage Return and Line Feed characters which will result in a new line for output
	add eax, 40000h ;// adds 40000 hex to what is already in the eax register
	call WriteInt	;// the result of the addition is 50000 hex but since WriteInt prints a signed decimal value, +327680 is ouputed
	call Crlf		;//this function creates Carriage Return and Line Feed characters which will result in a new line for output
	sub eax, 20000h ;// subtracts 20000 hex from the 50000 hex in the eax, updating the eax to 30000 hex
	call WriteInt	;// converts the 30000 hex to +196608 decimal and prints that to the screen
	call Crlf		;//this function creates Carriage Return and Line Feed characters which will result in a new line for output
	call DumpRegs	;// shows the contents of the registers in hex

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure
END main		; // ends the program
