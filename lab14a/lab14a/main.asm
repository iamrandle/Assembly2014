;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 10 April 2014
;// Lab 10
;// This program takes a text from the user and encrypts it using rol and ror instructions. Which rotation occurs is determined through conditional jumps
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

mWriteInt MACRO num
	push eax
	push ebx
	mov ebx, num
	mov eax, 0
	
	cmp ebx, 0100h
	jl typeB
	cmp ebx, 010000h
	jl wType
	mov eax, ebx
	jmp last
typeB:
	mov al, bl
	jmp last
wType:
	mov ax, bx
last:
	call WriteInt
	pop eax
	
ENDM
mSwap32 MACRO op1, op2

	pushad
	mov edi, op1
	mov esi, op2
	mov edx, [edi]
	xchg edx, [esi]
	xchg edx, [edi]
	popad

ENDM

.data						;// data segment. variables go here 
	
	replacement byte 2 ;//will hold the character to be replaced
	replacer byte 3 ;//will hold the character that will will replace the old one
	numMsg byte "Number of replacements: ",0 ;//null terminated string that will tell the user how many replacements there were
	origMsg byte "Original Text: ",0ah,0dh, 0 ;// null terminated string that tells the user what the original text was
	newMsg byte "Please enter a character to replace the old one: ",0ah,0dh,0 ;//null terminated string that holds the name of the PrintArray procedure
	oldMsg byte "Please enter a character to be replaced: ", 0ah,0dh,0 ;//null terminated string that holds the name of the CalculateElements procedure
	inMsg byte "Please enter a text no longer than 40 characters",0ah,0dh,0 ;//null terminated string that tells the user to enter 10 numbers
	
.code				;// code segment. all the instructions go here

main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mWriteInt 2

	call Dumpregs

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure

END main		; // ends the program

	