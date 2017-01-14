INCLUDE procedure.inc		;//includes everything in the procedure.inc file
.code						;// code segment. all the instructions go here

replaceChar PROC,			;//user defined procedure that will replace the first instance of a character with another character
String : ptr byte,			;//points to the offset of the array that will be searched
oldChar: byte,				;//holds the character to be searched for
newChar: byte				;//holds the character that will replace the old one
	push eax				;//pushes eax onto the stack
	push ecx				;//pushes ecx onto the stack
	push edi				;//pushes edi onto the stack
	push edx				;//pushes edx onto the stack
	
	mov ecx, max			;//move the max string size to the ecx for scasb
	mov edi, String			;//moves the array offset to the edi
	mov bl, newChar			;//moves the new character to the bl
	mov al, oldChar			;//moves the oldChar to al
	cld						;//moves forward
	repne scasb				;//scans the array until oldChar is found or end of the string is reached
	sub edi, type oldChar	;//subtract 1 (since it is a byte array) to access the oldChar (if found)
	mov dl, [edi]			;//moves contents of edi to dl
	cmp dl, oldChar			;//ensures that the old character was found
	jne NOREPLACE			;//if not, then jump to NOREPLACE
	mov [edi], bl			;//otherwise move the newChar where the oldChar was

	mov ebx, 1				;//moves to the ebx 1 since a replacement occurs

NOREPLACE:					;//a jump occurs here if no replacement is made

	pop edx					;//pops edx off the stack
	pop edi					;//pops edi off the stack
	pop ecx					;//pops ecx off the stack
	pop eax					;//pops eax off the stack
	
	ret						;//returns to where it was called
	
replaceChar ENDP			;//ends the replaceChar procedure
END							;//ends the file