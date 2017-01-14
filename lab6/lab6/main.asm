;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 1 March 2014
;// Lab 6
;// This program create an array of numbers and then use loops to reverse the order of the array
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

.data						;// data segment. variables go here 
	myArray dword 10 dup(?)	;// an array that will hold the numbers the user enters (up to 30 numbers)
.code				;// code segment. all the instructions go here
main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov edi, offset myArray ;//set the beginnig of the array to the edi register.
	mov ecx, lengthof myArray ;// sets the number of elements the array holds to the ecx register
L1: ;// this loop uses the number of elements the array holds as a counter and each iteration will add one element to the array
	call ReadInt ;//obtains an interger value from the keyboard and stores it in the eax register
	mov [edi], eax ;// moves the number retrieved from ReadInt to the next spot in the array
	add edi, type myArray ;//adds the size of one array element to the edi register so that the next space in the array can be accessed
	Loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	mov edi, offset myArray ;//sets the beginnig of the array to the edi register.
	mov esi, offset myArray + (sizeof myArray - type myArray) ;// sets the last spot in the array to the esi register
	mov ecx, lengthof myArray / 2 ;//sets the ecx register (the loop counter) to half the size length of the array. If it was set to the full length of the array, everything would be switched twice and the array would be in the same order
L2: ;// this loop exchanges what the esi and the edi registers are pointing at, effectively reversing the order of the array elements
	mov eax, [edi] ;// moves the specified value in the array to eax because [edi] and [esi] cannot be directly exchanged. eax == [edi]
	xchg eax, [esi] ;// swaps the value moved from [edi] with [esi]. eax == [esi] before the swap [esi] == eax before the swap which is the value at [edi]
	xchg eax, [edi] ;// swaps the value moved from [esi] with [edi]. eax == eax before the loop [edi] == [esi] before the loop
	add edi, type myArray ;//moves forward one element in the array
	sub esi, type myArray ;//moves backward one element in the array
	Loop L2 ;//jumps back to the beginnig of L2 and decrements the ecx register. Loop ends when ecx == 0
	mov edi, offset myArray ;//sets the beginnig of the array to the edi register.
	mov ecx, lengthof myArray ;// sets the number of elements the array holds to the ecx register
L3: ;//This loop simply prints the elements in the array in the new reversed order
	mov eax, [edi] ;// moves the specified array value to the eax register to be displayed using WriteInt
	call WriteInt ;// displays the current integer of the eax register to the screen
	call crlf ;// creates a carriage return line feed pair (a new line)
	add edi, type myArray ;//adds the size of one array element to the edi register so that the next space in the array can be accessed
	Loop L3 ;//jumps back to the beginnig of L3 and decrements the ecx register. Loop ends when ecx == 0

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure
END main		; // ends the program
