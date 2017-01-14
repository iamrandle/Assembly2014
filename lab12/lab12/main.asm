;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 25 April 2014
;// Lab 12
;// This program modifies Lab 7, which uses user defined procedures to fill an array then alter its values, so that the invoke call and local variables are used, it also shows the user what is on the stack after each function call
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

FillArray PROTO, arrayType: dword, arrayOff: dword, arrayLen: dword ;//prototype for the FillArray procedure, lists its parameters
CalculateElements PROTO, arrayType:dword, arrayOff:  dword, arrayLen: dword, arraySize:dword ;//prototype for the CalculateElements procedure, lists its parameters
PrintArray PROTO, arrayType: dword, arrayOff:  dword, arrayLen: dword ;//prototype for the PrintArray procedure, lists its parameters
ShowParams PROTO, paramNum : dword ;//prototype for the ShowParams procedure, lists its parameters

.data						;// data segment. variables go here 
	myArray dword 10 dup(?)	;// an array that will hold the numbers the user enters (up to 10 numbers)
	addressMsg byte "Address: ",0 ;//null terminated string the specifies a stack address
	equalMsg byte " = ",0 ;//null terminated string that tells the user what is at a certain stack address
	stackMsg byte "Stack after ", 0 ;//null terminated sting that begins to tell the user what is on the stack
	stackMsg2 byte " and ShowParams calls",0dh,0ah,"Stack Parameters:",0dh,0ah,"-----------------------------",0dh,0ah,0 ;//null terminated sting that ends the stackMsg
	fillMsg byte "FillArray",0 ;//null terminated string that holds the name of the FillArray procedure
	printMsg byte "PrintArray",0 ;//null terminated string that holds the name of the PrintArray procedure
	calcMsg byte "CalculateElements",0 ;//null terminated string that holds the name of the CalculateElements procedure
	inMsg byte "Enter 10 numbers:",0dh,0ah,0dh,0ah,0 ;//null terminated string that tells the user to enter 10 numbers
	
.code				;// code segment. all the instructions go here

main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	invoke FillArray, type myArray  , offset myArray, lengthof myArray;// calls the user defined procedure FillArray using invoke to push its parameters
	invoke CalculateElements, type myArray, offset myArray, lengthof myArray, size myArray ;// calls the user defined procedure CalculateElements using invoke to push its parameters
	invoke PrintArray, type myArray, offset myArray, lengthof myArray ;// calls the user defined procedure PrintArray using invoke to push its parameters
    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure

FillArray PROC, ;//user defined procedure that will fill an array by calling ReadInt
arrayType:dword, arrayOff: dword, arrayLen:dword ;//parameter list, 3 parameter (using local variables will take care of the stack automatically)
	mov edx, offset stackMsg ;//moves the beginnig of the stackMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset fillMsg ;//moves the beginnig of the fillMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset stackMsg2 ;//moves the beginnig of the stackMsg2 to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	invoke ShowParams, 8 ;// calls the user defined procedure ShowParams using invoke to push its parameters
	pushad ;//pushes all the registers onto the stack
	mov edx, offset inMsg ;//moves the beginnig of the inMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov esi, arrayOff ;//moves the array offset to the esi
	mov ecx, arrayLen ;//moves the array length to the ecx
L1: ;//this loop uses the number of elements the array holds as a counter and each iteration will add one element to the array
	call ReadInt ;//Irvines function that retrieves a number from the keyboard and stores it into the eax register
	mov [esi], eax ;// puts the number retrieved from ReadInt into the current spot of the Array
	add esi, arrayType ;//adds the size of one array element to the edi register so that the next space in the array can be accessed
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	popad ;//pops all the registers off the stack
	ret ;// returns to where the function was called
FillArray ENDP  ;//ends FillArray Procedure
CalculateElements PROC, ;// user defined procedure that adds ar[0] to ar[n-1], then ar[1] to ar[n-2], and so on where ar is an array and n is the number of elements it holds. It then does the same process with subtraction. Finally the array's first half is set the the value of the sums and the last half is set to the value of the differences
arrayType:dword, arrayOff: dword, arrayLen: dword, arraySize:dword ;//parameter list, 4 parameters (using local variables will take care of the stack automatically)
	mov edx, offset stackMsg ;//moves the beginnig of the stackMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset calcMsg ;//moves the beginnig of the calcMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset stackMsg2 ;//moves the beginnig of the stackMsg2 to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	invoke ShowParams, 9 ;// calls the user defined procedure ShowParams using invoke to push its parameters
	pushad ;//pushes all the registers onto the stack
	mov esi, arrayOff ;//moves the array offset to the esi
	mov edi, arrayOff  ;//moves the array offset to the edi
	add edi, arraySize ;//adds the arrays size to edi (points at end of the array)
	sub edi, arrayType ;//subtracts the arrays type from the edi (points at the last element)
	mov eax, arrayLen ;//moves the array length to the eax
	mov ecx, 2 ;//moves 2 to the ecx
	mov edx, 0 ;// clears the edx register
	div ecx ;//divides eax by ecx (array length by 2)
	mov ecx, eax ;//movs the value at eax to ecx
L1: ;//This loop copies the elements that will be added and subtracted, does the operations, and places the sum and difference into the correct spot int the array
	mov eax, [esi] ;//copies the esi into the eax register
	mov ebx, [edi] ;//copies the edi into the ebx register
	sub ebx, [esi] ;//subtracts the value at esi from the ebx
	add eax, [edi] ;//adds the value at edi to the eax 
	xchg eax, [esi];//swaps the result of the addition with the value at esi
	xchg ebx, [edi];//swaps the result of the subtraction with the value at edi
	add esi, arrayType ;//increments the esi to access the next element in the array
	sub edi, arrayType ;//decrements the edi to access the previous element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	popad ;//pops all the registers off the stack
	
	ret ;// returns to where the function was called
CalculateElements ENDP ;//ends the CalculateElements procedure
PrintArray PROC, ;//user defined procedure that will print the elements of an array
arrayType:dword, arrayOff: dword, arrayLen:dword ;//parameter list, 3 parameters (using local variables will take care of the stack automatically)
	mov edx, offset stackMsg ;//moves the beginnig of the stackMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset printMsg ;//moves the beginnig of the printMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset stackMsg2 ;//moves the beginnig of the stackMsg2 to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	invoke ShowParams, 8 ;// calls the user defined procedure ShowParams using invoke to push its parameters
	pushad ;//pushes all the registers onto the stack
	mov esi, arrayOff ;// moves the array offset to the esi 
	mov ecx, arrayLen ;//moves the array length to the ecx
L1:;//This loop simply prints the elements in the array 
	mov eax, [esi] ;//copies the value at esi into the eax so that WriteInt can print it out
	call WriteInt ;//Prints out the interger value of the eax register
	call Crlf ;//creates a carriage return line feed pair (a new line)
	add esi, arrayType ;//increments the esi to access the next element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	
	popad
	ret ;// returns to where the function was called
PrintArray ENDP ;//ends the PrintArray procedure
ShowParams PROC, ;// user defined procedure that will print a number of stack addresses and what they contain
	paramNum:dword ;//parameter list, 1 parameter (using local variables will take care of the stack automatically)
	mov ecx, paramNum ;//moves the number of parameters to be printed to the ecx
	mov esi, ebp ;//moves the ebp to the esi
L1: ;//this loop simply prints a stack address then what it holds then increments esi which is pointing to the stack
	mov eax, esi ;//moves esi to eax
	mov edx, offset addressMsg  ;//moves the beginnig of the addressMsg to edx for use with WriteString
	call WriteString  ;//prints the contents of the edx register to the screen
	call WriteHex ;// prints the hex value of what is stored in the eax register
	mov edx, offset equalMsg ;//moves the beginnig of the equalMsg to edx for use with WriteString
	call WriteString  ;//prints the contents of the edx register to the screen
	mov eax, [esi] ;// moves to eax what esi is pointing at
	call WriteHex ;//prints the hex value of what is stored in the eax register
	add esi, type dword ;//adds 4 to esi, incrementing it to the next stack address
	call Crlf ;//prints a new line
	loop L1 ;//jumps back to L1 and decrements ecx until ecx == 0
	call Crlf ;//prints a new line
	ret ;//returns to where the procedure was called
ShowParams ENDP ;//ends the ShowParams procedure
END main		; // ends the program
