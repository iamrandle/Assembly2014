;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 18 May 2014
;// Lab 14-15
;// This program takes an array and reverses it, then it prints it, then take another array of characters and prints it too. It uses macros to print the values and swap the values of the reversed array
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

InputArray PROTO, arrayType: dword, arrayOff: dword, arrayLen: dword ;//prototype for the InputArray procedure, lists its parameters
PrintArray PROTO, arrayType: dword, arrayOff:  dword, arrayLen: dword ;//prototype for the PrintArray procedure, lists its parameters
ReverseArray PROTO, arrayType: dword, arrayOff:  dword, arrayLen: dword, arraySize: dword ;//prototype for the ReverseArray procedure, lists its parameters
PrintCharArray PROTO, arrayType:dword, arrayOff: dword, arrayLen:dword ;//prototype for the PrintCharArray procedure, lists its parameters
InputCharArray PROTO, arrayType:dword, arrayOff: dword, arrayLen:dword ;//prototype for the InputCharArray procedure, lists its parameters

mWriteInt MACRO num ;//Macro that takes an interger of any size and prints its signed decimal value
	push edx ;//pushes edx on the stack
	push eax ;//pushes eax on the stack
	mov eax, 0 ;//clears eax
	mov edx, TYPE num ;//moves to the edx, the type of num
	cmp edx, type byte ;//cmps num's type with a byte
	je typeB ;//if its a byte, jumps to typeB label
	cmp edx, TYPE word ;//compares it to a word
	je typeW ;//if its a word jumps to typeW labe 
	cmp edx, TYPE dword ;//compares it to a dword 
	je typeD ;//if its a dword jumps to typeD Label
typeB: ;//for byte data
	mov edx, num ;//moves num to edx
	movsx eax, dl ;//moves and signextends dl to eax
	jmp last ;//jumps to last label
typeW: ;//for word data
	mov edx, num ;//moves num to the edx
	movsx eax, dx ;//moves and sign extends dx to eax
	jmp last ;//jumps to last label
typeD: ;//for dword data
	mov eax, num ;//moves num to the eax
	jmp last ;//jumps to last label
last: ;//end of the macro
	call WriteInt ;//calls irvines WriteInt to print the signed decimal value of the eax
	pop eax ;//pops eax off the stack
	pop edx ;// pops ebx off the stack
	
ENDM ;//ends macro
mSwap32 MACRO op1, op2 ;//macro that swaps the data at 2 addresses

	pushad ;//pushes all registers on the stack
	mov edi, op1 ;//moves the first address to edi
	mov esi, op2 ;//second address to esi
	mov edx, [edi] ;//moves what the first is pointing to, into edx
	xchg edx, [esi] ;//swaps edx with what the second is pointing to
	xchg edx, [edi] ;//swaps edx with what the first is pointing to
	popad ;//pops all registers off the stack

ENDM ;//end macro

.data						;// data segment. variables go here 
	aLength = 10 ;//array length
	myArray dword aLength dup (?) ;//dword array of 10 length, unintialised
	charArray byte aLength dup (0);//character array (or byte) of 10 length, intialised to 0
	inMsg1 byte "Enter 10 numbers for the array",0ah,0dh,0 ;//null terminated string that tells the user to enter 10 numbers
	inMsg2 byte "Enter 10 characters for the array", 0ah, 0dh, 0 ;//null terminated string that tells the user to enter 10 numbers
	reverseMsg byte "Reversed array, using mSwap32 and mWriteInt: ", 0ah, 0dh, 0 ;//null terminated string that tells the ueser that the following values is the array entered in reverse order
	charMsg byte "Decimal values of character array, using mWriteInt: ",0ah,0dh,0 ;//null terminated string that tells the user that the following values  are the decimal values of the character array

	
.code				;// code segment. all the instructions go here

main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov edx, offset inMsg1 ;//moves the beginning of inMsg1 to edx to use with WriteSting
	call WriteString ;//prints the contents of the edx register to the screen
	invoke InputArray, type myArray  , offset myArray, lengthof myArray;// calls the user defined procedure InputArray using invoke to push its parameters
	invoke ReverseArray, type myArray, offset myArray, lengthof myArray, sizeof myArray ;// calls the user defined procedure ReverseArray using invoke to push its parameters
	mov edx, offset reverseMsg ;//moves the beginning of reverseMsg to edx to use with WriteSting
	call WriteString ;//prints the contents of the edx register to the screen
	invoke PrintArray, type myArray, offset myArray, lengthof myArray ;// calls the user defined procedure PrintArray using invoke to push its parameters
	mov edx, offset inMsg2 ;//moves the beginning of inMsg2 to edx to use with WriteSting
	call WriteString ;//prints the contents of the edx register to the screen
	invoke InputCharArray, type charArray, offset charArray, lengthof charArray ;// calls the user defined procedure InputCharArray using invoke to push its parameters
	mov edx, offset charMsg ;//moves the beginning of charMsg to edx to use with WriteSting
	call WriteString ;//prints the contents of the edx register to the screen
	invoke PrintCharArray, type charArray, offset charArray, lengthof charArray ;// calls the user defined procedure PrintCharArray using invoke to push its parameters

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure

InputArray PROC, ;//user defined procedure that will fill an array by calling ReadInt
arrayType:dword, arrayOff: dword, arrayLen:dword ;//parameter list, 3 parameter (using local variables will take care of the stack automatically)

	pushad ;//pushes all the registers onto the stack

	mov esi, arrayOff ;//moves the array offset to the esi
	mov ecx, arrayLen ;//moves the array length to the ecx
L1: ;//this loop uses the number of elements the array holds as a counter and each iteration will add one element to the array
	call ReadInt ;//Irvines function that retrieves a number from the keyboard and stores it into the eax register
	mov [esi], eax ;// puts the number retrieved from ReadInt into the current spot of the Array
	add esi, arrayType ;//adds the size of one array element to the edi register so that the next space in the array can be accessed
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	popad ;//pops all the registers off the stack
	ret ;// returns to where the function was called
InputArray ENDP  ;//ends InputArray Procedure

PrintArray PROC, ;//user defined procedure that will print the elements of an array
arrayType:dword, arrayOff: dword, arrayLen:dword ;//parameter list, 3 parameters (using local variables will take care of the stack automatically)
	
	pushad ;//pushes all the registers onto the stack
	mov esi, arrayOff ;// moves the array offset to the esi 
	mov ecx, arrayLen ;//moves the array length to the ecx
L1:;//This loop simply prints the elements in the array 
	
	mWriteInt [esi];//calls the macro that will print out a signed decimal value
	call Crlf ;//creates a carriage return line feed pair (a new line)
	add esi, arrayType ;//increments the esi to access the next element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	
	popad ;//pops all registers off the stack
	ret ;// returns to where the function was called
PrintArray ENDP ;//ends the PrintArray procedure

ReverseArray PROC, ;//puts an array in reverse order using the swap32 macro
arrayType:dword, arrayOff: dword, arrayLen:dword, arraySize: dword ;//parameter list, 3 parameters (using local variables will take care of the stack automatically)
	pushad ;//pushes all registers on the stack
	mov edx, 0 ;//clears edx
	mov eax, arrayLen ;//moves array length to the eax
	mov ecx, 2 ;//moves 2 to ecx
	div ecx ;// divides arraylength by 2
	mov ebx, arraySize ;//moves the arraysize to the ebx
	sub ebx, arrayType ;//subtracts the array type from the size

	mov edi, arrayOff ;//sets the beginnig of the array to the edi register.
	mov esi, arrayOff ;//sets the beginning of the array to the esi register
	add esi, ebx ;// sets the last spot in the array to the esi register
	mov ecx, eax;//sets the ecx register (the loop counter) to half the size length of the array. If it was set to the full length of the array, everything would be switched twice and the array would be in the same order
L2: ;// this loop exchanges what the esi and the edi registers are pointing at, effectively reversing the order of the array elements
	mSwap32 edi, esi ;// invokes the mSwap32 macro to swap 2 elements
	add edi, arrayType ;//moves forward one element in the array
	sub esi, arrayType ;//moves backward one element in the array
	Loop L2 ;//jumps back to the beginnig of L2 and decrements the ecx register. Loop ends when ecx == 0
	popad ;//pops all registers off the stack
	ret ;// returns to where it was called
ReverseArray ENDP ;//ends ReverseArray procedure

InputCharArray PROC, ;//procedure that fills the byte array with characters
arrayType:dword, arrayOff: dword, arrayLen:dword ;//parameter list, 3 parameter (using local variables will take care of the stack automatically)
	pushad ;//pushes all the registers onto the stack
	mov eax, 0 ;//clears the eax
	mov esi, arrayOff ;//moves the array offset to the esi
	mov ecx, arrayLen ;//moves the array length to the ecx
L1: ;//this loop uses the number of elements the array holds as a counter and each iteration will add one element to the array
	call ReadChar ;//Irvines function that retrieves a number from the keyboard and stores it into the eax register
	call WriteChar ;//shows the character that was typed in ReadChar
	call Crlf ;//prints a new line
	mov [esi], al ;// puts the number retrieved from ReadInt into the current spot of the Array
	add esi, arrayType ;//adds the size of one array element to the edi register so that the next space in the array can be accessed
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	popad ;//pops all the registers off the stack
	ret ;// returns to where it was called
InputCharArray ENDP ;// ends the InputChar array procedure

PrintCharArray PROC, ;//procedure that uses the mWiteInt macro to print the decimal values of the characters in a byte array
arrayType:dword, arrayOff: dword, arrayLen:dword ;//parameter list, 3 parameters (using local variables will take care of the stack automatically)
	
	pushad ;//pushes all the registers onto the stack
	mov esi, arrayOff ;// moves the array offset to the esi 
	mov ecx, arrayLen ;//moves the array length to the ecx
L1:;//This loop simply prints the elements in the array 
	mov edx, 0 ;//clears edx
	mWriteInt [esi];//Prints out the interger value of the eax register
	call Crlf ;//creates a carriage return line feed pair (a new line)
	add esi, arrayType ;//increments the esi to access the next element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	
	popad ;//pops all registers off the stack
	ret ;// returns to where the function was called

PrintCharArray ENDP ;//ends the PrintCharArray procedure

END main		; // ends the program
