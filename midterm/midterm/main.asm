;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// PI 2014
;// Midterm
;// This program takes two arrays of the same size, adds and subtracts the corresponding elements of both arrays, stores them sums in the first array and the differences in the second, then prints two coloms of different colors of the sums and differneces side by side
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

.data						;// data segment. variables go here 
	firstArray dword 8 dup(?)	;// first array that will hold the numbers the user enters (up to 8 numbers) then the sums of the two arrays
	secondArray dword 8 dup(?)	;// second array that will hold the numbers the user enters (up to 8 numbers) then the differences of the two arrays
	tabChar byte 09, 0 ;//tab character that will be used to seperate coloms
	sumMsg byte "Sum", 0 ;//null terminated string that will denote the sum colom
	difMsg byte "Difference", 0 ;//null terminated string that will denote the difference colom
	enterFirst byte "Please fill the first array with ", 0 ;//null terminated string that instruct the user to enter numbers for the first array
	enterSec byte "Please fill the second array with ",0 ;//null terminated string that instruts the user to enter numbers for the second array
	numMsg byte " numbers", 0dh, 0ah, 0 ;//null terminated string that will end both the preceding messages
	printMsg byte "The Sums and Differences of the arrays are as follows:", 0dh, 0ah, 0 ;//null terminated string that will notify the user that the following values are the sum and differences of the two arrays

.code				;// code segment. all the instructions go here
main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov edx, offset enterFirst ;// moves the offset of enterFirst message to the edx for use with WriteString
	call WriteString ;//prints the contents of the edx register
	mov eax, lengthof firstArray ;// moves the size of the first array to the eax for use with WriteInt
	call WriteInt ;//Prints out the interger value of the eax register
	mov edx, offset numMsg ;//moves the offset of numMsg string to the edx for use with WriteString
	call WriteString ;//prints the contents of the edx register
	mov ecx, lengthof firstArray ;// moves the length of the first array as a counter into ecx in preperation of the FillArray procedure
	mov esi, offset firstArray ;//set the beginnig of the first array to the esi register.
	call FillArray ;// calls the user defined procedure that will fill the array with numbers from the keyboard

	mov edx, offset enterSec ;// moves the offset of enterSec message to the edx for use with WriteString
	call WriteString ;//prints the contents of the edx register
	mov eax, lengthof secondArray ;// moves the size of the second array to the eax for use with WriteInt
	call WriteInt ;//Prints out the interger value of the eax register
	mov edx, offset numMsg ;//moves the offset of numMsg string to the edx for use with WriteString
	call WriteString ;//prints the contents of the edx register
	mov ecx, lengthof secondArray ;// moves the length of the second array as a counter into ecx in preperation of the FillArray procedure
	mov esi, offset secondArray ;//set the beginnig of the second array to the esi register.
	call FillArray ;// calls the user defined procedure that will fill the array with numbers from the keyboard
	
	
	mov esi, offset firstArray ;//set the beginnig of the first array to the esi register.
	mov edi, offset secondArray ;//set the beginnig of the second array to the edi register.
	mov ecx, lengthof firstArray ;//moves the length of the first array as a counter into ecx in preperation of the AddSubArrays procedure (both arrays are the same size)
	call AddSubArrays ;// calls the user defined procedure that will add the corresponding elements of both arrays and store them in the first array, then subtract corresponding elements and store them into the second array

	mov esi, offset firstArray ;//set the beginnig of the first array to the esi register.
	mov ecx, lengthof firstArray ;// moves the length of the first array as a counter into ecx in preperation of the PrintArrayColoms procedure
	mov edi, offset secondArray ;//set the beginnig of the second array to the edi register.
	call PrintArrayColoms ;// calls the user defined procedure PrintArrayColoms that will print the new elements both arrays side by side in different colors

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure

FillArray PROC ;//user defined procedure that will fill an array by calling ReadInt
	push esi ;//pushes the esi onto the stack
	push ecx ;//pushes the ecx onto the stack
L1: ;//this loop uses the number of elements the array holds as a counter and each iteration will add one element to the array
	call ReadInt ;//Irvines function that retrieves a number from the keyboard and stores it into the eax register
	mov [esi], eax ;// puts the number retrieved from ReadInt into the current spot of the Array
	add esi, type firstArray ;//adds the size of one array element to the esi register so that the next space in the array can be accessed
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0

	pop ecx ;// pops ecx off the top of the stack
	pop esi ;// pops esi off the top of the stack
	ret ;// returns to where the function was called
FillArray ENDP  ;//ends FillArray Procedure
AddSubArrays PROC ;// user defined procedure that adds the corresponding elements in both arrays and stores the sums in the first array and then subtracts the corresponding elements of both arrays and stores the differences in the second array
	push esi ;//pushes the esi onto the stack
	push edi ;//pushes the edi onto the stack
	push ecx ;//pushes the ecx onto the stack
L1: ;//This loop copies the elements that will be added and subtracted, does the operations, and places the sum and difference into the correct spot int the arrays
	mov eax, [esi] ;//copies the esi into the eax register
	mov ebx, [edi] ;//copies the edi into the ebx register
	sub ebx, [esi] ;//subtracts the value at esi from the ebx
	add eax, [edi] ;//adds the value at edi to the eax 
	xchg eax, [esi];//swaps the result of the addition with the value at esi
	xchg ebx, [edi];//swaps the result of the subtraction with the value at edi
	add esi, type firstArray ;//increments the esi to access the next element in the array
	add edi, type secondArray ;//decrements the edi to access the previous element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	
	pop ecx ;//pops the ecx off the top of the stack
	pop edi ;//pops the edi off the top of the stack
	pop esi ;//pops the esi off the top of the stack
	ret ;// returns to where the function was called
AddSubArrays ENDP ;//ends the AddSubArrays procedure
PrintArrayColoms PROC ;//user defined procedure that will print the elements of two arrays side by side in different colors
	push esi ;//pushes the esi onto the stack
	push edi ;//pushes the edi onto the stack
	push ecx ;//pushes the ecx onto the stack

	mov edx, offset printMsg ;//moves the offset of the sumMsg to the edx for use with WriteString
	call WriteString ;//prints the contents of the edx register
	mov eax, lightMagenta ;//moves the lightMagenta constant defined in Irvine32.inc to the eax for use with SetTextColor
	call SetTextColor ;//Changes the text color to the color corresponding to the value in the eax register
	mov edx, offset sumMsg ;//moves the offset of the sumMsg to the edx for use with WriteString
	call WriteString  ;//prints the contents of the edx register
	mov edx, offset tabChar ;//moves the offset of the tabChar to the edx for use with WriteString
	call WriteString ;//prints the contents of the edx register
	mov eax, lightCyan ;//moves the lightCyan constant defined in Irvine32.inc to the eax for use with SetTextColor
	call SetTextColor ;//Changes the text color to the color corresponding to the value in the eax register
	mov edx, offset difMsg ;//moves the offset of the difMsg to the edx for use with WriteString
	call WriteString ;//prints the contents of the edx register
	call Crlf ;//prints out a carriage return line feed pair (a new line)

L1:;//This loop simply prints the elements in the array 
	mov eax, lightMagenta ;//moves the lightMagenta constant defined in Irvine32.inc to the eax for use with SetTextColor
	call SetTextColor ;//Changes the text color to the color corresponding to the value in the eax register
	mov eax, [esi] ;//copies the value at esi into the eax so that WriteInt can print it out
	call WriteInt ;//Prints out the interger value of the eax register
	mov edx, offset tabChar ;//moves the offset of the tabChar to the edx for use with WriteString
	call WriteString ;//prints the contents of the edx register
	mov eax, lightCyan ;//moves the lightCyan constant defined in Irvine32.inc to the eax for use with SetTextColor
	call SetTextColor ;//Changes the text color to the color corresponding to the value in the eax register
	mov eax, [edi] ;//copies the value at edi into the eax so that WriteInt can print it out
	call WriteInt ;//Prints out the interger value of the eax register
	call Crlf ;//prints out a carriage return line feed pair (a new line)
	add esi, type firstArray ;//increments the esi to access the next element in the array
	add edi, type secondArray ;//increments the edi to access the next element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	mov eax, lightGray ;//moves the lightGray constant defined in Irvine32.inc to the eax for use with SetTextColor
	call SetTextColor ;//Changes the text color to the color corresponding to the value in the eax register
	
	pop ecx ;// pops ecx off the top of the stack
	pop edi ;// pops edi off the top of the stack
	pop esi ;// pops esi off the top of the stack
	ret ;// returns to where the function was called
PrintArrayColoms ENDP ;//ends the PrintArrayColoms procedure

END main		; // ends the program
