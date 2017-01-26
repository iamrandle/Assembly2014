;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 22 February 2014
;// Practice 7

TITLE Copying a String (CopyStr.asm)
INCLUDE Irvine32.inc
.data
array DWORD 1,2,3,4,5,6,7,8,9,10 ;//modified version of the array from the text that holds new, decimal values
array2 DWORD 10,20,30,40,50,60,70,80,90,100 ;//another array of dword type similar to the first
theSum DWORD ?
msg1 byte "The elements of the first array are:", 0dh,0ah,0 ;//null terminated string that will states that the next values are the values in the first array.
msg2 byte "The sum of the first array is: ",0 ;//null terminated string that will states that the next value is the sum of the first array.
msg3 byte "The elements of the second array are:", 0dh,0ah,0 ;//null terminated string that will states that the next values are the values in the second array.
msg4 byte "The sum of the second array is: ",0 ;//null terminated string that will states that the next value is the sum of the second array.
msg5 byte "The sum of the both arrays is: ",0 ;//null terminated string that will states that the next value is the sum of the both arrays.
ttab byte 09h
.code
main PROC
mov ecx, lengthof array ;// moves the length of the array as a counter into ecx in preperation of the PrintArray procedure
mov esi, offset array ;//set the beginnig of the array to the esi register.
mov edx, offset msg1 ;//moves the first message to the edx so that it can be displayed with WriteString
call WriteString ;//Irvines function that will print out the message stored in the edx register
call PrintArray ;// calls the user defined procedure PrintArray that will print the elements of the first array

mov esi,OFFSET array ; ESI points to array
mov ecx,LENGTHOF array ; ECX = array count
call ArraySum ; calculate the sum
mov edx, offset msg2 ;//moves the second message to the edx so that it can be displayed with WriteString
call WriteString ;//Irvines function that will print out the message stored in the edx register
call WriteInt ;//Prints out the signed decimal value that is stored in the eax which is the sum of the first array at this point
mov edx, offset ttab
call WriteString
call WriteInt
call Crlf ;//creates a carriage return line feed pair (a new line )

mov theSum, eax ;//moves the sum of the first array into theSum variabl
mov esi, offset array2  ;//set the beginnig of the second array to the esi register.
mov ecx, lengthof array2 ;//moves the length of the array as a counter into ecx in preperation of the PrintArray procedure
mov edx, offset msg3 ;//moves the third message to the edx so that it can be displayed with WriteString
call WriteString ;//Irvines function that will print out the message stored in the edx register
call PrintArray ;// calls the user defined procedure PrintArray that will print the elements of the second array

mov esi, offset array2  ;//set the beginnig of the second array to the esi register.
mov ecx, lengthof array2 ;//moves the length of the array as a counter into ecx in preperation of the ArraySum procedure
call ArraySum ;//procedure from the text that claculates the sum of all the elements of an array
mov edx, offset msg4 ;//moves the fouth message to the edx so that it can be displayed with WriteString
call WriteString ;//Irvines function that will print out the message stored in the edx register
call WriteInt ;//Prints out the signed decimal value that is stored in the eax which is the sum of the second array at this point
call Crlf ;//creates a carriage return line feed pair (a new line)
add eax, theSum ;//adds the sum of the first array to eax which holds the sum of the second array
mov edx, offset msg5 ;//moves the fouth message to the edx so that it can be displayed with WriteString
call WriteString ;//Irvines function that will print out the message stored in the edx register
call WriteInt ;//Prints out the signed decimal value that is stored in the eax which is the sum of both arrays at this point
call Crlf ;//creates a carriage return line feed pair (a new line)
	 
exit
main ENDP

ArraySum PROC
push esi ; save ESI, ECX
push ecx
mov eax,0 ; set the sum to zero
L1: add eax,[esi] ; add each integer to sum
add esi,TYPE DWORD ; point to next integer
loop L1 ; repeat for array size
pop ecx
pop esi
ret
ArraySum ENDP

PrintArray PROC ;//user defined procedure that will print the elements of an array
	push esi ;//pushes the esi onto the stack
	push ecx ;//pushes the ecx onto the stack
L1:;//This loop simply prints the elements in the array 
	mov eax, [esi] ;//copies the value at esi into the eax so that WriteInt can print it out
	call WriteInt ;//Prints out the interger value of the eax register
	call Crlf ;//creates a carriage return line feed pair (a new line)
	add esi, type DWORD ;//increments the esi to access the next element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0

	pop ecx ;// pops ecx off the top of the stack
	pop esi ;// pops esi off the top of the stack
	ret ;// returns to where the function was called

PrintArray ENDP ;//ends the PrintArray procedure

END main
