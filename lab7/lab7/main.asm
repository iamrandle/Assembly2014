;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 8 March 2014
;// Lab 7
;// This program uses user defined procedures to fill an array, use the values in the array to create new values for that array, and print out the contents of the array
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

.data						;// data segment. variables go here 
	myArray dword 10 dup(?)	;// an array that will hold the numbers the user enters (up to 10 numbers)
.code				;// code segment. all the instructions go here
main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov ecx, lengthof myArray ;// moves the length of the array as a counter into ecx in preperation of the FillArray procedure
	mov esi, offset myArray ;//set the beginnig of the array to the esi register.
	call FillArray ;// calls the user defined procedure that will fill the array with numbers from the keyboard
	mov esi, offset myArray ;//set the beginnig of the array to the esi register.
	mov edi, offset myArray + (sizeof myArray - type myArray) ;// sets the last spot in the array to the edi register
	mov ecx, lengthof myArray / 2 ;//moves half the length of the array as a counter into ecx in preperation of the AddSubArray procedure
	call AddSubArray ;// calls the user defined procedure that will fill the first 5 elements with sums of opposite elements and thae last 5 with differences
	mov esi, offset myArray ;//set the beginnig of the array to the esi register.
	mov ecx, lengthof myArray ;// moves the length of the array as a counter into ecx in preperation of the PrintArray procedure
	call PrintArray ;// calls the user defined procedure PrintArray that will print the elements of the array

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure

FillArray PROC ;//user defined procedure that will fill an array by calling ReadInt
	push esi ;//pushes the esi onto the stack
	push ecx ;//pushes the ecx onto the stack
L1: ;//this loop uses the number of elements the array holds as a counter and each iteration will add one element to the array
	call ReadInt ;//Irvines function that retrieves a number from the keyboard and stores it into the eax register
	mov [esi], eax ;// puts the number retrieved from ReadInt into the current spot of the Array
	add esi, type myArray ;//adds the size of one array element to the edi register so that the next space in the array can be accessed
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0

	pop ecx ;// pops ecx off the top of the stack
	pop esi ;// pops esi off the top of the stack
	ret ;// returns to where the function was called
FillArray ENDP  ;//ends FillArray Procedure
AddSubArray PROC ;// user defined procedure that adds ar[0] to ar[n-1], then ar[1] to ar[n-2], and so on where ar is an array and n is the number of elements it holds. It then does the same process with subtraction. Finally the array's first half is set the the value of the sums and the last half is set to the value of the differences
	push esi ;//pushes the esi onto the stack
	push edi ;//pushes the edi onto the stack
	push ecx ;//pushes the ecx onto the stack
L1: ;//This loop copies the elements that will be added and subtracted, does the operations, and places the sum and difference into the correct spot int the array
	mov eax, [esi] ;//copies the esi into the eax register
	mov ebx, [edi] ;//copies the edi into the ebx register
	sub ebx, [esi] ;//subtracts the value at esi from the ebx
	add eax, [edi] ;//adds the value at edi to the eax 
	xchg eax, [esi];//swaps the result of the addition with the value at esi
	xchg ebx, [edi];//swaps the result of the subtraction with the value at edi
	add esi, type myArray ;//increments the esi to access the next element in the array
	sub edi, type myArray ;//decrements the edi to access the previous element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	
	pop ecx ;//pops the ecx off the top of the stack
	pop edi ;//pops the edi off the top of the stack
	pop esi ;//pops the esi off the top of the stack
	ret ;// returns to where the function was called
AddSubArray ENDP ;//ends the AddSubArray procedure
PrintArray PROC ;//user defined procedure that will print the elements of an array
	push esi ;//pushes the esi onto the stack
	push ecx ;//pushes the ecx onto the stack
L1:;//This loop simply prints the elements in the array 
	mov eax, [esi] ;//copies the value at esi into the eax so that WriteInt can print it out
	call WriteInt ;//Prints out the interger value of the eax register
	call Crlf ;//creates a carriage return line feed pair (a new line)
	add esi, type myArray ;//increments the esi to access the next element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	
	pop ecx ;// pops ecx off the top of the stack
	pop esi ;// pops esi off the top of the stack
	ret ;// returns to where the function was called
PrintArray ENDP ;//ends the PrintArray procedure

END main		; // ends the program
