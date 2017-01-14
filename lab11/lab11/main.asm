;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 16 April 2014
;// Lab 11
;// This program fills an array with numbers 1 - 50 and then sorts them from largest to smallest using a bubble sort technique. This is done by using multiple procedures that take advantage of the stack frame to access their parameters
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

.data						;// data segment. variables go here 
	theArray dword 12 dup (?) ;//the array that will be filled and sorted
	swapCount dword 0 ;//will count how mant swaps occur in the sort

	msg byte "Please enter ", 0 ;//null terminated string that begins telling the user to fill the array
	msg2 byte " numbers with values 0 to 50", 0dh, 0ah, 0 ;// null terminated string that ends msg1
	b4Msg byte "Before Sort", 0dh, 0ah, 0 ;//null terminated string that tells the user that the following is the array before the sort
	afterMsg byte "After Sort", 0dh, 0ah, 0 ;//null terminated string that tells the user that the following is the array after the sort
	swapMsg byte "The number of swaps is: ",0 ;// null terminated string that tells the user how many swaps occured
	
	
	.code		;// code segment. all the instructions go here
main PROC		;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov edx, offset msg ;//moves begnning of msg to edx for use with Write String
	call WriteString ;//prints the contents of the edx register to the screen
	mov eax, lengthof theArray ;//moves the length of theArray to the eax for use with WriteDec
	call WriteDec ;//prints the decimal value of the eax
	mov edx, offset msg2 ;//moves begnning of msg2 to edx for use with Write String
	call WriteString ;//prints the contents of the edx register to the screen
	push eax ;//pushes eax onto the stack as a parameter
	push offset theArray ;//pushes the offset of theArray onto the stack as a parameter
	call FillArray ;//call the user defined procedure FillArray
	mov edx, offset b4Msg ;//moves begnning of b4Msg to edx for use with Write String
	call WriteString ;//prints the contents of the edx register to the screen
	push eax ;//pushes eax onto the stack as a parameter
	push offset theArray ;//pushes the offset of theArray onto the stack as a parameter
	call PrintArray ;//calls the user defined procedure PrintArray
	mov edx, offset afterMsg ;//moves begnning of afterMsg to edx for use with Write String
	call WriteString ;//prints the contents of the edx register to the screen
	push lengthof theArray - 1 ;//pushes one less than the length of theArray onto the stack as a parameter
	push offset theArray ;//pushes the offset of theArray onto the stack as a parameter
	call InBubSort ;//calls the user defined procedure InBubSort
	push eax ;//pushes eax onto the stack as a parameter
	push offset theArray ;//pushes the offset of theArray onto the stack as a parameter
	call PrintArray ;//calls the user defined procedure PrintArray
	mov edx, offset swapMsg ;//moves begnning of swapMsg to edx for use with Write String
	call WriteString ;//prints the contents of the edx register to the screen
	mov eax, swapCount ;//moves swapCount to the eax for use with WriteDec
	call WriteDec ;//prints the decimal value of the eax
	call Crlf ;//prints a new line

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure

FillArray PROC ;//user defined procedure that will fill an array by calling ReadInt
	push ebp ;//push ebp on the stack; save it for later
	mov ebp, esp ;// set ebp equal to esp; base of stack frame
	pushad ;//push all registers on the stack
	mov ecx, [ebp + 12] ;//ecx = first parameter (counter)
	mov esi, [ebp + 8] ;//esi = second parameter (theArray offset)
L1: ;//this loop uses the number of elements the array holds as a counter and each iteration will add one element to the array
	call ReadInt ;//Irvines function that retrieves a number from the keyboard and stores it into the eax register
	mov [esi], eax ;// puts the number retrieved from ReadInt into the current spot of the Array
	add esi, type theArray ;//adds the size of one array element to the edi register so that the next space in the array can be accessed
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0

	popad ;//pop all registers off the stack
	pop ebp ;// pop ebp off the stack

	ret 8 ;// returns to where the function was called, cleans up stack
FillArray ENDP  ;//ends FillArray Procedure

PrintArray PROC ;//user defined procedure that will print the elements of an array
	push ebp ;//push ebp on the stack; save it for later
	mov ebp, esp ;// set ebp equal to esp; base of stack frame
	pushad ;//push all registers on the stack
	mov ecx, [ebp + 12] ;//ecx = first parameter (counter)
	mov esi, [ebp + 8] ;//esi = second parameter (theArray offset)
L1:;//This loop simply prints the elements in the array 
	mov eax, [esi] ;//copies the value at esi into the eax so that WriteInt can print it out
	call WriteInt ;//Prints out the interger value of the eax register
	call Crlf ;//creates a carriage return line feed pair (a new line)
	add esi, type theArray ;//increments the esi to access the next element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	
	popad ;//pop all registers off the stack
	pop ebp ;// pop ebp off the stack

	ret 8;// returns to where the function was called, cleans up the stack
PrintArray ENDP ;//ends the PrintArray procedure

Swap PROC USES eax esi  edi, ;//This procedure swaps 2 values (from lecture notes); USES pushes and pops the registers listed
pValx: ptr dword, ;//esi (parameter 2) ; 
pValy: ptr dword ;//temp (parameter 1) ; The PROC parameter list generates code that sets up and cleans up the stack. 
	   mov esi, pValx ;// moves pValx to esi
	   mov edi, pValy ;// moves pValy to edi
	   mov eax, [esi] ;// moves the value esi is pointing to into eax
	   xchg eax, [edi] ;//exchanges the value at eax with the value edi is pointing at
	   mov [esi], eax ;//changes the value eax esi is pointing at to the value in eax
	   ret ;//returns where the function was called from (once again PROC parameter list takes care of cleaning the stack)

Swap ENDP ;//ends the Swap procedure

InBubSort PROC ;//This procedure sorts the data in array from largest to smallest using the bubble sort technique
	push ebp ;//push ebp on the stack; save it for later
	mov ebp, esp ;// set ebp equal to esp; base of stack frame
	pushad ;//push all the registers onto the stack
	mov ecx, [ebp + 12] ;//ecx = first parameter (counter)
	mov esi, [ebp + 8] ;//esi = second parameter (theArray offset)
L1: ;//Label signifying the big loop. In order to ensure a bubble sort works in the worst case scenario, it must run a number of times equal to the summation of n from 1 to i-1 where i == the number of elements in the array
	   push esi ;//push esi onto the stack; saves the address of the first element which is modified in the small loop (L2)
	   push ecx ;//push ecx onto the stack; saves the counter which is modifed in the small loop
	   
L2:
	   mov ebx, esi;//moves address of the current element into ebx
	   add ebx, type theArray ;//access the next element in the array
	   mov eax, [ebx] ;//moves the value ebx points at into eax
		   
	   cmp [esi], eax ;//compares the current value in the array with the next value in the array
	   jge next ;//if the current element is greater than or equal to the next element in the array skip to next label
	   push ebx ;//pushes ebx onto the stack as a parameter
	   push esi ;//pushes esi onto the stack as a parameter
	   call Swap ;//calls the user defined Swap procedure
	   inc swapCount ;//adds one to the swap count

next:
	   add esi, type theArray ;//accesses the next element in the array
	   
	   loop L2 ;//jumps back to L2 and decrements the ecx until ecx == 0
	   pop ecx ;//pops ecx off the stack; restores ecx for the big loop (L1)
	   pop esi ;//pops esi off the stack; restores esi for the big loop
	   loop L1 ;//jumps back to L1 and decrements the ecx until ecx == 0
	   popad ;//pops all the registers off the stack
	   pop ebp ;// pop ebp off the stack
	   ret  8 ;//returns to where the procedure was called from and cleans up the stack
	   
InBubSort ENDP ;//ends the InBubSort procedure

END main		; // ends the program
