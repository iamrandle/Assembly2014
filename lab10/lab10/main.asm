;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 10 April 2014
;// Lab 10
;// This program takes a text from the user and encrypts it using rol and ror instructions. Which rotation occurs is determined through conditional jumps
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

.data						;// data segment. variables go here 
	msg byte "Please enter a text no larger than 40 characters: ",0dh,0ah,0 ;//null terminated string telling the user to enter some text
	keyMsg byte "Please enter a key (8 numbers maximum)",0dh,0ah,0 ;// null terminated string telling the uer to enter a key
	clearMsg byte "This is your text: ",0dh,0ah,0 ;//null terminated string telling the user this is what they entered
	encryptMsg byte "This is the encrypted text: ",0dh,0ah,0 ;//null terminated string telling the user this is their text encrypted
	decryptMsg byte "This is the decrypted text: ",0dh,0ah,0 ;//null terminated string telling the user this is their text decrypted
	text byte 40 dup (0) ;//array of character that will be encrypted and decrypted
	key sdword 8 dup (?) ;//array of signed numbers that will be the key for encryption and decryption
	
	.code		;// code segment. all the instructions go here
main PROC		;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov edx, offset msg ;//moves begnning of msg to edx for use with Write String
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset text ;//moves beginning of the text array to edx for use with ReadString
	mov ecx, sizeof text ;//moves the size of the text array to ecx for use with ReadString
	call ReadString ;//gets a line of text from the keyboard and stores it in the text array
	mov edx, offset keyMsg ;//moves begnning of keyMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov ecx, lengthof key ;//moves the length of the key array to ecx as a counter
	mov esi, offset key ;//moves beginning of the key to esi
L1: ;//loop that will create values for the key array
	call ReadInt ;//retrieves a character from the keyboard and stores it in eax
	mov [esi], eax ;//stores the character retrieved from ReadInt into the specified array spot
	add esi, type key ;//adds key's type to esi in order to access the next element in the array
	loop L1 ;//jumps to L1 label; decrements ecx until ecx == 0
	mov edx, offset clearMsg  ;//moves begnning of clearMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset text  ;//moves begnning of text to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	call Crlf ;//prints a new line
	mov edx, offset encryptMsg ;//moves begnning of encryptMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset text ;//moves the beginning of text to the edx for encryption
	mov esi, offset key ;//moves the beginning of the key to esi for encryption
	mov ebx, 1 ;//move 1 to ebx to keep track of the position of the key
	call Encode ;// call the user defined procedure Encode to encrypt the text
	mov edx, offset text ;//moves begnning of text to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	call Crlf ;//prints an new line
	mov edx, offset decryptMsg  ;//moves begnning of decryptMsg to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset text ;//moves the beginning of text to the edx for decryption
	mov esi, offset key ;//moves the beginning of the key to esi for decryption
	call Decode ;// call the user defined procedure Decode to decrypt the text
	mov edx, offset text ;//moves begnning of text to edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen
	call Crlf ;//prints a new line

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure

Encode PROC ;//this procedure takes a character from the text array[i] and rotates it |key[i%8]| times left if key[i%8] < 0 and right if key[i%8] > 0. This continues until text[i] == NULL character. i starts at 0 and increments +1 each iteration
	push edx ;//pushes edx to the top of the stack
	push ecx ;//pushes ecx to the top of the stack
	push esi ;//pushes esi to the top of the stack
	push eax ;//pushes eax to the top of the stack
	push ebx ;//pushes ebx to the top of the stack
	clc ;//clears the carry flag
top: ;//label signifying the top 
	mov eax, [edx] ;//move the current text char value to eax
	cmp eax, 0 ;//compares the character to null
	je finished ;//if it is null, jumps to finished label
	mov ecx, [esi] ;//moves the current value of the key to ecx
	cmp ecx, 0 ;//compare the value to 0
	jg rightrot ;//if it is positive, jumps to rightrot
	cmp ecx, 0 ;//else compare the value to 0 again
	jl leftrot ;//if it is negative, jumps to leftrot
	cmp ecx, 0 ;//else compare the value to 0 again
	je nextval ;//if it is zero, jump to nextval
leftrot: ;//label signifying left rotations
	neg ecx ;//inverses ecx register (now contains a positive number)
	rol byte ptr[edx], cl ;//rotates the current value at edx cl number of times to the left
	jmp nextval ;//jumps to nextval
rightrot: ;//label signifying right rotations
	ror byte ptr[edx], cl ;//rotates the current value at edx cl number of times to the right
nextval: ;//label signifying moving to the next values
	add edx, type text ;// adds texts's type to edx, accessing the next value in the array
	cmp ebx, lengthof key ;//compares ebx to the length of key array
	je resetKey ;//if they are equal, jumps to resetKey
	add esi, type key ;//adds key's type to esi, accessing the next value in the array
	inc ebx ;//increments ebx by 1
	jmp top ;//jumps to the top
resetKey: ;//label signifying a key reset
	mov ebx, 1 ;//resets ebx to 1
	mov esi, offset key ;//moves the beginning of the key array to esi (reseting the key)
	jmp top ;//jumps to the top
finished: ;//label signifying the end

pop ebx ;//pops ebx off the top of the stack
pop eax ;//pops eax off the top of the stack
pop esi ;//pops esi off the top of the stack
pop ecx ;//pops ecx off the top of the stack
pop edx ;//pops edx off the top of the stack
	
ret ;//returns where it was call from
Encode ENDP ;//ends the encode procedure

;//Note: Decode is simply the same procedure as Encode, its rotations are just opposite.

Decode PROC ;//this procedure takes a character from the text array[i] and rotates it |key[i%8]| times left if key[i%8] > 0 and right if key[i%8] < 0. This continues until text[i] == NULL character. i starts at 0 and increments +1 each iteration
	push edx ;//pushes edx to the top of the stack
	push ecx ;//pushes ecx to the top of the stack
	push esi ;//pushes esi to the top of the stack
	push eax ;//pushes eax to the top of the stack
	push ebx ;//pushes ebx to the top of the stack
	clc ;//clears the carry flag
top: ;//label signifying the top 
	mov eax, [edx] ;//move the current text char value to eax
	cmp eax, 0 ;//compares the character to null
	je finished ;//if it is null, jumps to finished label
	mov ecx, [esi] ;//moves the current value of the key to ecx
	cmp ecx, 0 ;//compare the value to 0
	jl rightrot ;//if it is negative, jumps to rightrot
	cmp ecx, 0 ;//else compare the value to 0 again
	jg leftrot ;//if it is positive, jumps to leftrot
	cmp ecx, 0 ;//else compare the value to 0 again
	je nextval ;//if it is zero, jump to nextval
leftrot: ;//label signifying left rotations
	rol byte ptr[edx], cl ;//rotates the current value at edx cl number of times to the left
	jmp nextval ;//jumps to nextval
rightrot: ;//label signifying right rotations
	neg ecx ;//inverses ecx register (now contains a positive number)
	ror byte ptr[edx], cl ;//rotates the current value at edx cl number of times to the right
nextval: ;//label signifying moving to the next values
	add edx, type text ;// adds texts's type to edx, accessing the next value in the array
	cmp ebx, lengthof key ;//compares ebx to the length of key array
	je resetKey ;//if they are equal, jumps to resetKey
	add esi, type key ;//adds key's type to esi, accessing the next value in the array
	inc ebx ;//increments ebx by 1
	jmp top ;//jumps to the top
resetKey: ;//label signifying a key reset
	mov ebx, 1 ;//resets ebx to 1
	mov esi, offset key ;//moves the beginning of the key array to esi (reseting the key)
	jmp top ;//jumps to the top
finished: ;//label signifying the end

pop ebx ;//pops ebx off the top of the stack
pop eax ;//pops eax off the top of the stack
pop esi ;//pops esi off the top of the stack
pop ecx ;//pops ecx off the top of the stack
pop edx ;//pops edx off the top of the stack
	
ret ;//returns where it was call from
Decode ENDP ;//ends the encode procedure

END main		; // ends the program


leftrot: 
	rol byte ptr[edx], cl 
	jmp nextval
rightrot:
	neg ecx
	ror byte ptr[edx], cl