;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 21 February 2014
;// Lab 5
;// This program will store numbers entered from the keyboard into an array, add all the elements together, and print the sum on the screen

INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

.data						;// data segment. variables go here 
	howMany byte "How many numbers would you like to enter?", 0dh, 0ah, 0 ;//null terminated string that will prompt the user to enter how many numbers they want to enter
	usersNumber dword ? ;//a variable that will hold the number of elements that will be stored in the array (specified by the user)
	myArray dword 30 dup(?)	;// an array that will hold the numbers the user enters (up to 30 numbers)
.code				;// code segment. all the instructions go here
main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov edx, offset howMany	;//moves the offset of the howMany string to the edx register
	call WriteString	;//prints the contents of the edx register
	mov eax, 0		;// resets the eax register by setting it to 0
	call ReadInt	;//retrieves an interger from the keyboard and stores it it the eax register
	mov usersNumber, eax	;//moves the number retrieved from ReadInt into the variable usersNumber;
	mov eax, 0	;// resets the eax register by setting it to 0
	mov ecx, usersNumber	;// updates the ecx register for L1 with the number of elements the user has decided to enter
	mov edi, offset myArray	;// moves the offset of myArray to the edi register
L1:		;//begining of the first loop that will get an integer from the keyboard and add it into an array
	call ReadInt	;//retrieves an interger from the keyboard and stores it it the eax register
	mov [edi], eax	;//moves the contents retrieved from ReadInt into the array
	add edi, type myArray ;//adds the number of bytes == the size of one member of myArray in order to store the next element
	Loop L1		;//jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	mov eax, 0	;// resets the eax register by setting it to 0
	mov ecx, usersNumber ;// updates the ecx register for L2 
	mov edi, offset myArray ;// moves the offset of myArray to the edi register
L2:	;//begining of the second loop that will add all the elments of the array together and store the sum in the eax
	add eax, [edi]	;//adds the current element of the array to the contents of eax (the previous elements)
	add edi, type myArray ;//adds the number of bytes == the size of one member of myArray in order to store the next element
	Loop L2		;//jumps back to the beginnig of L2 and decrements the ecx register. Loop ends when ecx == 0
	call WriteInt	;//prints the signed decimal value of the contents of the eax register
	call Crlf	;//prints out a carriage return line feed pair (a new line)
	

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure
END main		; // ends the program
