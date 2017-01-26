;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 22 March 2014
;// Practice 8
;// note: comments for code I added/changed are in green, Irvine's are not

TITLE Scanning an Array (ArryScan.asm)
; Scan an array for the first nonzero value.
INCLUDE Irvine32.inc
.data
	intArray sword 30 DUP (?) ;// an array that will hold a maximum of 30 (will be specified by the user)
	;intArray SWORD 0,0,0,0,1,20,35,-12,66,4,0
	;intArray SWORD 1,0,0,0 ; alternate test data
	;intArray SWORD 0,0,0,0 ; alternate test data
	;intArray SWORD 0,0,0,1 ; alternate test data
	;noneMsg BYTE "A non-zero value was not found",0
	numMsg byte "Number ",0 ;//null terminated string that begins both output messages
	noneMsg byte " not found in this array",0dh,0ah,0 ;//null terminated string that will be outputed if the number the user is searching for is not in the array
	howMany byte "How many numbers would you like to enter?",0dh,0ah,0 ;// null terminated string prompting the user for how many number they want to put into the array
	fillMsg byte "Please fill the array with ",0 ;//null terminated string that tells the user to fill the array with the number of integers they specified
	numMsg2 byte " numbers", 0dh, 0ah, 0 ;// null terminated string that ends the fillMsg
	searchMsg byte "What number would you like to search for?",0dh,0ah,0 ;//null terminated string asking the user what number they want to search for
	foundMsg byte " found at position ", 0 ;//null terminated sting that tells the user their number was found
	foundMsg2 byte " in the array",0dh,0ah,0 ;//null terminated string that ends the foundMsg
	arrayLength dword ? ;//integer that will hold the length of the array specified by the user
.code
	main PROC
	mov edx, offset howMany ;//moves the begining of the howMany string to the edx register for use with WriteString
	call WriteString ;// Irvines function; Prints the contents of the edx register to the screen
	call ReadInt ;//calls Irvines ReadInt funtion to retrieve an int from the user and store it in the eax register
	mov edx, offset fillMsg ;//moves the begining of the fillMsg string to the edx register for use with WriteString
	call WriteString ;// Irvines function; Prints the contents of the edx register to the screen
	call WriteInt ;//Irvine function that prints the signed decimal value of the eax register
	mov edx, offset numMsg2 ;//moves the begining of the numMsg2 string to the edx register for use with WriteString
	call WriteString ;// Irvines function; Prints the contents of the edx register to the screen
	mov arrayLength, eax ;//moves the specified length to the arrayLength variable
	mov ecx, arrayLength ;// moves the length of the array to the ecx as a loop counter
	mov esi, offset intArray ;//moves the beginning of the array to the esi
fill: 
	call ReadInt ;//calls Irvines ReadInt funtion to retrieve an int from the user and store it in the eax register
	mov [esi], eax ;//move the contents of eax into the specified spot in the array
	add esi, type intArray ;//adds the type to esi so that the next element of the array can be accessed
	loop fill ;//jumps back to the fill label until ecx == 0 als decrements ecx by 1 every iteration
	mov edx, offset searchMsg ;//moves the begining of the searchMsg string to the edx register for use with WriteString
	call WriteString ;// Irvines function; Prints the contents of the edx register to the screen
	call ReadInt ;//calls Irvines ReadInt funtion to retrieve an int from the user and store it in the eax register

	mov edi, 1 ;// moves 1 to the edi because the position of the array will start at 1
	mov ebx,OFFSET intArray ; point to the array
	mov ecx, arrayLength;// moves arrayLength variable to ecx as a loop counter
L1:	cmp WORD PTR [ebx], ax ;// compare value to zero
	je found ;// jumps to found label if the zero flag is set by cmp
	add ebx,2 ; point to next
	inc edi ;//increments the edi register to hold the position in the array
	loop L1 ; continue the loop
	jmp notFound ; none found
found: ; display the value
	mov edx, offset numMsg ;//moves the begining of the numMsg string to the edx register for use with WriteString
	call WriteString ;// Irvines function; Prints the contents of the edx register to the screen
	movsx eax,WORD PTR[ebx] ; sign-extend into EAX
	call WriteInt
	mov edx, offset foundMsg ;//moves the begining of the foundMsg string to the edx register for use with WriteString
	call WriteString ;// Irvines function; Prints the contents of the edx register to the screen
	mov eax, edi ;// move to eax the contents of edi (which holds position of the array)
	call WriteInt ;//Irvine function that prints the signed decimal value of the eax register
	mov edx, offset foundMsg2 ;//moves the begining of the foundMsg2 string to the edx register for use with WriteString
	call WriteString ;// Irvines function; Prints the contents of the edx register to the screen
	jmp quit
notFound: ; display "not found" message
	mov edx, offset numMsg;//moves the begining of the numMsg2 string to the edx register for use with WriteString
	call WriteString ;// Irvines function; Prints the contents of the edx register to the screen
	call WriteInt ;//Irvine function that prints the signed decimal value of the eax register
	mov edx,OFFSET noneMsg
	call WriteString
quit:
	call Crlf
	exit
main ENDP
END main
