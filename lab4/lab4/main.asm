;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 12 February 2014
;// Lab 4
;// This program will calculate the difference of 3 numbers entered by the user and will display it to the screen

INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

.data						;// data segment. variables go here 
inputMsg byte "Please enter 3 numbers",0dh,0ah,0				;// message that tells the user to enter numbers from the keyboard. Followed by carriage return
																;// line feed, and a null character to signify the end of the string
outputMsg byte "The difference of the 3 numbers is ",0			;// null terminated string that will be used to inform the user of the result of the claculation
num1 dword ?		;//variable that will be used to in the subtraction process. It will provide a place to store a value when it needs to be moved out of the eax

.code				;// code segment. all the instructions go here
main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov edx, offset inputMsg ;// moves the begining (offset) of the inputMsg to the edx register
	call WriteString	;// (From Irvine's library) writes the string from the edx register to the screen
	call ReadInt		;// (From Irvine's library) waits for a user to input an integer from the keyboard and stores it in the eax register
	mov num1, eax		;// subtracts the value at eax from num1
	call ReadInt		;// (From Irvine's library) waits for a user to input an integer from the keyboard and stores it in the eax register
	sub num1, eax		;// subtracts contents of the eax from num1
	call ReadInt		;// (From Irvine's library) waits for a user to input an integer from the keyboard and stores it in the eax register
	sub num1, eax		;// subtracts the value at eax from num1
	mov eax, num1       ;// moves value of num1 to the eax register
	call Crlf					;//this function creates Carriage Return and Line Feed characters which will result in a new line for output
	mov edx, offset outputMsg	;// moves the begining (offset) of the outputMsg to the edx register
	call WriteString			;// (From Irvine's library) writes the string from the edx register to the screen
	call WriteInt				;// (From Irvine's library) writes the integer from the eax register to the screen
	call Crlf					;//this function creates Carriage Return and Line Feed characters which will result in a new line for output


    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure
END main		; // ends the program
