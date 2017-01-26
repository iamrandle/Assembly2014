;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 25 April 2014
;// Practice 12
;// note: comments for code I added/changed are in green, Irvine's are unedited and in black

TITLE Demonstrate reference parameters   (ArrayFill.asm)

; This program fills an array with 16-bit randomly generated integers.

INCLUDE Irvine32.inc

.data
count = 20 ;//changed from 100 to 20
array WORD count DUP(0)

locationOffset dword 0

inMsg byte "Please input the array element number that defines the first part of the array (0-20)",0dh,0ah,0 ;// null terminated string that tells the user to enter a number for part one of filling the array
outMsg byte "Here is the array with random numbers up to FFFFh in the first part and up to",0dh,0ah,"FFh in the second part", 0dh,0ah,0 ;//null terminatred stringf that tells the user what the array is

.code
main PROC
	mov edx, offset inMsg ;// moves the beginning of the inMsg to the eds
	call WriteString ;//prints the contents of the edx to the screen
	call ReadInt ;//retrieves a number from the keyboard and stores it in eax
	
	push 0FFFFh ;//pushes the max number for part one
	push OFFSET array
	push eax ;//pushes the number of elements to be filled in part one
	call ArrayFill ;// calls user defined ArrayFill
	mov ebx, lengthof array ;//moves the length of the array to ebx
	sub ebx, eax ;//subtracts the number from part one from the length of the array
	mov locationOffset, type array ;//moves the array type value to locationOffset
	mul locationOffset ;//multiplies eax by locationOffset
	mov locationOffset, offset array ;//moves the beginning to the array to locationOffset
	add locationOffset, eax ;//adds the result of the multiplication to locationOffset
	push 0FFh ;//pushes the max number for part two
	push  locationOffset ;//pushes the location of the next element in the array to be modified
	push ebx ;// pushes the number of elements to be filled in part two
	

	call ArrayFill
	push  lengthof array ;//pushes the lengthof array as a parameter
	push offset array ;//pushes the offset of the array as a parameter
	call PrintArray ;// calls the user defined procedure PrintArray
	
	exit

main ENDP


ArrayFill PROC	
	push	ebp
	mov	ebp,esp
	pushad			; save registers
	
	mov	esi,[ebp+12]	; offset of array
	mov	ecx,[ebp+8]	; array size
	mov ebx, [ebp+16] ;//third parameter (max number)
	add ebx, 1 ;//add one to the max number to prepare for RandomRange call
	cmp	ecx,0		; ECX == 0?
	je	L2			; yes: skip over loop

    
L1:
	mov	eax, ebx; get random 0 - FFFFh ;//the max number is now variable
	call	RandomRange	; from the link library
	mov	[esi],ax
	add	esi,TYPE WORD
	loop	L1

L2:	popad			; restore registers
	pop	ebp
	ret	12			; clean up the stack;//changed to 12 because there are now 3 parameters
ArrayFill ENDP

PrintArray PROC ;//user defined procedure that will print the elements of an array
	push ebp ;//push ebp on the stack; save it for later
	mov ebp, esp ;// set ebp equal to esp; base of stack frame
	pushad ;//push all registers on the stack
	mov ecx, [ebp + 12] ;//ecx = first parameter (counter)
	mov esi, [ebp + 8] ;//esi = second parameter (theArray offset)
L1:;//This loop simply prints the elements in the array 
	mov ax,  [esi] ;//copies the value at esi into the eax so that WriteInt can print it out
	call WriteHex ;//Prints out the interger value of the eax register
	call Crlf ;//creates a carriage return line feed pair (a new line)
	add esi, type array ;//increments the esi to access the next element in the array
	loop L1 ;// jumps back to the beginnig of L1 and decrements the ecx register. Loop ends when ecx == 0
	
	popad ;//pop all registers off the stack
	pop ebp ;// pop ebp off the stack

	ret 8;// returns to where the function was called, cleans up the stack
PrintArray ENDP ;//ends the PrintArray procedure

END main

