;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 29 May 2014
;// FINAL
;// This program takes a string entered by the user and prints out the characters in a chessboard with dimensions defined in the data section. Empty spaces are filled with '*'s and there is also an option to remove characters. All characters will be capitalised befor printing
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

removeChars PROTO, String : ptr byte, numChar: dword, pos: dword ;//prototype for removeChars, lists its parameters
capitalise PROTO, String: ptr byte ;//prototype for capitalise, lists its parameters
concatenate PROTO, String : ptr byte, Stars: ptr byte, sMax: dword ;//prototype for concatenate, lists its parameters
printRow PROTO, String : ptr byte, charsPerRow: dword, color1: dword, color2: dword, rSize: dword ;//prototype for printRow, lists its parameters
WriteColorChar PROTO, String: ptr byte, fore: dword, back: dword ;//prototype for WriteColorChar, lists its parameters
SetColor PROTO, fore:dword, back:dword ;//prototype for SetColor, lists its parameters

.data						;// data segment. variables go here 

	max = 128 ;//max number for the array
	squares = 8; //number of squares in the chess board
	horizCharsPerSquare = 2; //number of characters per square

	enterMsg byte "Please enter a string no longer than 128 characters",0ah,0dh,0 ;//null terminated string telling the user to enter a sentence
	replaceMsg byte "Do you want to remove some characters? (y/n) ",0 ;//null terminated string asking the user if they want to remove characters from their string
	howMany byte "How many characters would you like to remove? ", 0 ;//null terminated string asking the user how many characters they would like to remove 
	startingMsg byte "Starting at which position? ",0 ;//null terminated string asking the user what position theyed like to start removing characters
	lengthMsg byte "The length of then entered text is: ",0 ;//null terminated string telling the user how long the entered text is
	lengthMsg2 byte "The length of the added text is: ",0;//null terminated string telling the user how long the added text is
	boardMsg byte "Here is the chess board: ",0ah,0dh,0 ;//null terminated string presenting the chess board

	inputText byte max+1 dup (0) ;//input text array
	addText byte max+1 dup (0) ;//added text array, will be filled with stars
	rPos dword ? ;//position to where to start removing characters
	rNum dword ? ;//number of characters to remove

.code				;// code segment. all the instructions go here
main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	mov edx, offset enterMsg ;// moves the offset of enterFirst message to the edx for use with WriteString
	call WriteString ;//prints the contents of the edx register to the screen 
	mov ecx, max ;//moves the max number of the array to the ecx
	mov edx, offset inputText ;//moves the begining of inputText to edx
	call ReadString ;//retrieves a string from the keyboard
	mov edx, offset replaceMsg;//moves the begining of replaceMsg to edx
	call WriteString ;//prints the contents of the edx register to the screen
	call ReadChar ;//retrieves a char from the keyboard, stores it in eax
	call WriteChar ;//prints the character value of al
	call Crlf ;//prints a new line
	cmp al, 'y' ;//cmp al to 'y'
	jne noremove ;//if not equal to 'y' jump to noremove label
	mov edx, offset howMany ;//moves the begining of howMany to edx
	call WriteString ;//prints the contents of the edx register to the screen
	call ReadInt ;//retrieve an int from the keyboard
	mov rNum, eax ;//moves the contents of eax to rNum
	mov edx, offset startingMsg ;//moves the begining of startingMsg to edx
	call WriteString ;//prints the contents of the edx register to the screen
	call ReadInt ;//retrieves an int from the keyboard
	mov rPos, eax ;//moves the contents of eax to rPos
	invoke removeChars, addr inputText, rNum, rPos  ;//calls removeChars passing 3 parameters
	
noremove:
	mov edx, offset inputText ;//moves the begining of inputText to edx
	call StrLength ;//returns the length of whatever array is in edx to eax
	invoke capitalise, addr inputText ;//calls capitalise passing 1 parameter
	invoke concatenate, addr inputText, addr addText, max ;//calls concatenate passing 2 parameters
	mov edx, offset lengthMsg ;//moves the begining of lengthMsg to edx
	call WriteString ;//prints the contents of the edx register to the screen
	call WriteInt ;//prints signed decimal value of eax
	call Crlf ;//prints a new line
	mov edx, offset lengthMsg2 ;//moves the begining of lengthMsg2 to edx
	call WriteString ;//prints the contents of the edx register to the screen
	mov edx, offset addText ;//moves the begining of addText to edx
	call StrLength ;//returns teh length of whatever array is in edx to eax
	call WriteInt ;//prints signed decimal value of eax
	call Crlf ;//prints a new line
	mov edx, offset boardMsg ;//moves the begining of boardMsg to edx
	call WriteString ;//prints the contents of the edx register to the screen
	mov eax, squares ;//moves the value squares to eax
	mov ebx, horizCharsPerSquare ;// movesthe value horizCharsPerSquare to ebx
	mov edx, 0 ;//clears edx
	div ebx ;//divides eax by ebx
	mov ecx, eax ;//moves contents of eax to ecx
	mov eax, squares ;//moves the value squares to eax
	mov ebx, 2 ;//moves 2 to ebx
	mul ebx ;//multiplies eax by ebx
	mov edx, offset inputText ;//moves the begining of inputText to edx
L1:
	push ecx ;//saves ecx
	push eax ;//saves eas
	mov eax, horizCharsPerSquare ;// movesthe value horizCharsPerSquare to eax
	mov ebx, 2 ;//moves 2 to ebx
	push edx ;//saves edx
	mov edx, 0 ;//clears edx
	div ebx ;//divides eax by ebx
	mov ecx, eax ;//moves contents of eax to ecx
	pop edx ;//restores edx
	pop eax ;//restores eax
L2:
	invoke printRow, edx, horizCharsPerSquare, lightGray, white, squares ;//calls printRow passing 5 parameters
	add edx, eax ;//adds contents of eax to edx
	loop L2 ;//jumps to L2 label, decrements ecx until ecx == 0
	push eax ;//saves eax
	mov eax, horizCharsPerSquare ;// movesthe value horizCharsPerSquare to eax
	mov ebx, 2 ;//moves 2 to ebx
	push edx ;//saves edx
	mov edx, 0 ;//clears edx
	div ebx ;//divides eax by ebx
	mov ecx, eax ;//moves contents of eax to ecx
	pop edx ;//restores edx
	pop eax ;//restores eax
L3:
	invoke printRow, edx, horizCharsPerSquare, white, lightGray, squares ;//calls printRow passing 5 parameters
	add edx, eax ;//adds contents of eax to edx
	loop L3 ;//jumps to L3 label, decrements ecx until ecx == 0
	pop ecx ;//restores ecx
	loop L1 ;//jumps to L1 label, decrements ecx until ecx == 0
	invoke SetColor, lightGray, black ;//calls SetColor passing 2 parameters
    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure

removeChars PROC, String : ptr byte, numChar: dword, pos: dword ;//begins procedure, lists parameters
	pushad ;//pushes all registers onto the stack
	mov edi, String			;//moves the array offset to the edi
	add edi, pos ;//adds pos to edi
	mov esi, edi ;//moves contents of edi to esi
	add esi, numChar ;//adds numChar to edi
	mov edx, String ;//moves the array offset to the edi
	call StrLength ;//returns the length of whatever array is in the edx
	mov ecx, eax ;//moves contents of eax to ecx
	sub ecx, pos ;//subtracts pos from ecx
	sub ecx, numChar ;//subtracts numChar from ecx
L1:
	mov edx, [esi]			;//moves edx what esi is pointing at
	mov [edi], dl ;//moves whats in dl to what edi is pointing at
	inc edi ;//increments edi
	inc esi ;//increments esi
	loop L1 ;//jumps to L1 label, decrements ecx until ecx == 0
	mov ecx, numChar ;//moves numChar to ecx
	mov eax, 0 ;//clears eax
L2:
	mov [edi], al ;//moves whats in al to what edi is pointing at
	inc edi ;//increments edi
	loop L2 ;//jumps to L2 label, decrements ecx until ecx == 0

	popad ;//pops all registers onto the stack
	ret ;// returns to where the procedure was called
removeChars ENDP ;//ends the procedure
capitalise PROC, String: ptr byte ;//begins procedure, lists parameters
	pushad ;//pushes all registers onto the stack

	mov edx, String ;//moves the array offset to the edi
	call StrLength ;//returns the length of whatever array is in edx to eax
	mov ecx, eax ;//moves contents of eax to ecx
L1:
	mov bl, [edx] ;//moves to the bl what edx is pointing at
	cmp bl, 96 ;//compares bl to 'a'
	jb skip ;//if its less than 96 skip it
	cmp bl, 122 ;//compares bl to 'z'
	ja skip ;//if its greater than 122 skip it
	sub bl, 32 ;//subtracts 32 from bl
	mov [edx], bl ;//moves whats in bl to what edx is pointing at
skip:
	inc edx ;//increments edx
	loop L1 ;//jumps to L1 label, decrements ecx until ecx == 0

	popad ;//pops all registers onto the stack
	ret ;// returns to where the procedure was called
capitalise ENDP ;//ends the procedure

concatenate PROC, String : ptr byte, Stars: ptr byte, sMax: dword ;//begins procedure, lists parameters
	pushad ;//pushes all registers onto the stack
	mov edx, String ;//moves the array offset to the edi
	call StrLength ;//returns the length of whatever array is in edx to eax
	mov ecx, eax ;//moves contents of eax to ecx
	cmp ecx, sMax ;//cmps ecx to sMax
	jge done ;//if its greater than or equal to sMax then we are done
	push eax ;//saves eax
	mov eax, sMax;//moves sMax to the eax
	sub eax, ecx ;//subtracts ecx from eax
	mov ecx, eax ;//moves contents of eax to ecx
	mov ebx, Stars ;//moves the offset of Stars to ebx
	push ecx ;// saves ecx
	mov al, '*' ;//moves '*' to the al
L1:
	mov [ebx], al ;//move whats in the al to what ebx is pointing at
	inc ebx ;//increments ebx
	loop L1 ;//jumps to L1 label, decrements ecx until ecx == 0
	mov ebx, Stars ;//moves the offset of Stars to ebx
	pop ecx ;//restores ecx
	pop eax ;//restores eax
	add edx, eax ;// adds eax to edx
L2:
	mov al, [ebx] ;// moves to the al what ebx is pointing at
	mov [edx], al ;// moves to what edx is pointing whats in the al
	inc ebx ;//increments ebx
	inc edx ;//increments edx
	loop L2 ;//jumps to L2 label, decrements ecx until ecx == 0
done:
	popad ;//pops all registers onto the stack
	ret ;// returns to where the procedure was called
concatenate ENDP ;//ends the procedure

printRow PROC, String : ptr byte, charsPerRow: dword, color1: dword, color2: dword, rSize: dword ;//begins procedure, lists parameters
	pushad ;//pushes all registers onto the stack
	mov eax, rSize ;//moves rSize to the eax
	mov edx, 0 ;//clears edx
	div charsPerRow ;//divides eax by charsPerRow
	mov ecx, eax ;//moves contents of eax to ecx  
	mov edx, String ;//moves the array offset to the edi
L1:
	push ecx ;//saves ecx
	mov ecx, charsPerRow ;//moves charsPerRow to the ecx
L2:
	invoke WriteColorChar, edx, color1, color2 ;//calls WriteColorChar passing 3 parameters
	inc edx ;//increments edx
	loop L2 ;//jumps to L2 label, decrements ecx until ecx == 0
	mov ecx, charsPerRow ;//moves CharsPerRow to the ecx
L3:
	invoke WriteColorChar, edx, color2, color1 ;//calls WriteColorChar passing 3 parameters
	inc edx ;//increments edx
	loop L3 ;//jumps to L3 label, decrements ecx until ecx == 0
	pop ecx ;//restores ecx
	loop L1 ;//jumps to L1 label, decrements ecx until ecx == 0
	call Crlf ;//prints a new line
	
	popad ;//pops all registers onto the stack
	ret ;// returns to where the procedure was called
printRow ENDP ;//ends the procedure
WriteColorChar PROC, String: ptr byte, fore: dword, back: dword ;//begins procedure, lists parameters
	pushad ;//pushes all registers onto the stack
	mov edx, String ;//moves the array offset to the edi
	invoke SetColor, fore, back ;//calls SetColor passing 2 parameters
	mov al, [edx] ;//moves what edx is pointing at to the al
	call WriteChar ;//prints a character to the screen

	popad ;//pops all registers onto the stack
	ret ;// returns to where the procedure was called
WriteColorChar ENDP ;//ends the procedure
SetColor PROC, fore:dword, back:dword ;//begins procedure, lists parameters
	 pushad ;//pushes all registers onto the stack
	 mov eax, back ;//moves back to the eax
	 mov ebx, 16 ;//moves 16 to the ebx
	 mul ebx ;//multipies eax by ebx
	 add eax, fore ;//adds fore to the eax
	 call SetTextColor ;//sets the foreground and background color of texts output to the screeen
	 
	 popad ;//pops all registers onto the stack
   	 ret ;// returns to where the procedure was called
SetColor ENDP ;//ends the procedure

END main		; // ends the program
