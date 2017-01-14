;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 25 April 2014
;// Lab 12
;// This program modifies Lab 7, which uses user defined procedures to fill an array then alter its values, so that the invoke call and local variables are used, it also shows the user what is on the stack after each function call
INCLUDE procedure.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

.data						;// data segment. variables go here 
	
	replacement byte ? ;//will hold the character to be replaced
	replacer byte ? ;//will hold the character that will will replace the old one
	numMsg byte "Number of replacements: ",0 ;//null terminated string that will tell the user how many replacements there were
	myArray byte max+1 dup(0)	;// an array that will hold the numbers the user enters (up to 10 numbers)
	origMsg byte "Original Text: ",0ah,0dh, 0 ;// null terminated string that tells the user what the original text was
	newMsg byte "Please enter a character to replace the old one: ",0ah,0dh,0 ;//null terminated string that holds the name of the PrintArray procedure
	oldMsg byte "Please enter a character to be replaced: ", 0ah,0dh,0 ;//null terminated string that holds the name of the CalculateElements procedure
	inMsg byte "Please enter a text no longer than 40 characters",0ah,0dh,0 ;//null terminated string that tells the user to enter 10 numbers
	
.code				;// code segment. all the instructions go here

main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov edx, offset inMsg ;//moves the beginning of the inMsg to the edx
	call WriteString	;//prints the contents of the edx register to the screen
	mov ecx, max	;//moves the maximum size of the array to the ecx
	mov edx, offset myArray ;//moves the beginning of the myArray to the edx
	call ReadString	;//retrieves a string from the keyboard, stores its offset in edx
	mov edx, offset oldMsg ;//moves the beginning of the oldMsg to the edx
	call WriteString	;//prints the contents of the edx register to the screen
	call ReadChar ;//retrieves a character from the keyboard, stores it in al
	mov replacement, al ;//moves the retieved character to replacement
	movzx edx, replacement ;//moves to dl replacement character and extends zeros to the rest of edx
	call WriteChar ;//prints the character in dl
	call Crlf ;//prints a new line
	mov edx, offset newMsg ;//moves the beginning of the newMsg to the edx
	call WriteString	;//prints the contents of the edx register to the screen
	call ReadChar ;//retrieves a character from the keyboard, stores it in al
	mov replacer, al ;//moves the retieved character to replacer
	movzx edx, replacer ;//moves to dl replacer character and extends zeros to the rest of edx
	call WriteChar ;//prints the character in dl
	call Crlf ;//prints a new line
	mov edx, offset origMsg	;//moves the beginning of the orifMsg to the edx
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset myArray ;//moves the beginning of the myArray to the edx
	call WriteString ;//prints the contents of the edx register to the screen
	call Crlf ;//prints a new line
	call Crlf ;//prints a new line
	mov eax, 0 ;//clears eax
L1: ;//start of the loop
	push eax ;//save eax
	invoke replaceChar, addr myArray, replacement, replacer ;//call replaceChar passing its parameters
	cmp ebx, 1 ;//cmp ebx to 1
	jne FINISH ;//if it is not equal then a replacement didnt occur and we are done
	invoke printText, addr myArray ;//call printText, passing its parameters
	pop eax ;//restore eax
	inc eax ;//increments eax by one
	jmp L1 ;//jumps to L1
FINISH: ;//marks the end of the loop
	pop eax ;//restore eax
	mov edx, offset numMsg ;//moves the beginning of the numMsg to the edx
	call WriteString ;//prints the contents of the edx register to the screen
	call WriteDec ;//prints unsigned decimal value of the eax
	call Crlf ;//prints a new line

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure

END main		; // ends the program

	