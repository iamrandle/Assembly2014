;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 22 March 2014
;// Lab 8
;// This program uses conditional jumps to create a menu driven program that will will ask the user which boolean operation they want to execute until they choose to exit the program
INCLUDE Irvine32.inc		;// Irvine's library that contains WriteString, WriteInt, and ReadInt

.data						;// data segment. variables go here 
	menu byte "-------Boolean Calculator-------",0dh,0ah,"1.X AND Y",0dh,0ah,"2.X OR Y",0dh,0ah,"3.NOT X",0dh,0ah,"4.X XOR Y",0dh,0ah,"5.Exit",0dh,0ah,0dh,0ah,"Choose an expression by entering an intereger 1-5",0dh,0ah,0 ;//null terminated string that outputs the choices the user has
	inMsg byte "Please input the first 32-bit hexadecimal value: ",09,0 ;//null terminated string that prompts the user for the first 32-bit hex value
	inMsg2 byte "Please input the second 32-bit hexidecimal value: ",09, 0 ;//null terminated string that prompts the user for the second 32-bit hex value
	outMsg byte "The 32-bit hexidecimal result is:",09,09,09,0 ;//null terminate string that tells the user what the result of the operation is
	andMsg byte "Boolean AND",0dh,0ah,0 ;//null terminated string informing the user they have chose the AND operation
	orMsg byte "Boolean OR",0dh,0ah,0 ;//null terminated string informing the user they have chose the OR operation
	notMsg byte "Boolean NOT",0dh,0ah,0 ;//null terminated string informing the user they have chose the NOT operation
	xorMsg byte "Boolean XOR",0dh,0ah,0 ;//null terminated string informing the user they have chose the XOR operation
	.code				;// code segment. all the instructions go here
main PROC			;// main procedure or start point of the program
	call Clrscr ;// clears whatever content is on the screen
	call GetChoice ;//calls the userdefined GetChoice Procedure which loops until the user chooses to exit


    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure
DisplayMenu PROC ;//user defined procedure that displays the menu string
	push edx ;// pushes the edx to the top of the stack
	mov edx, offset menu ;//moves the begining of the menu string to the edx for use with WriteString
	call WriteString ;//Prints the contents of the edx register to the screen ;//Prints the contents of the edx register to the screen ;//Prints the contents of the edx register to the screen
	pop edx ;// pops the edx from the top of the stack
	ret ;// returns to where the function was called
DisplayMenu ENDP ;//ends the DisplayMenu procedure

GetChoice PROC ;// user defined procedure that will use DisplayMenu to give the user options of what to do, retrieves the option using ReadInt, and calls the appropriate procedure using conditional jumps. Then loops over until the user chooses to exit
push eax ;//pushes the eax to the top of the stack
top: ;//label signifying the begining of the procedure
	call DisplayMenu ;//calls the user defined DisplayMenu procedure to display the menu
	call ReadInt ;//calls Irvines ReadInt funtion to retrieve an int from the user and store it in the eax register
	cmp eax, 1 ;//performs a compare subtraction on eax and sets the appropriate flags without editing the content of the register
	je and1 ;//jumps to and1 label if the cmp set the zero flag
	cmp eax, 2 ;//performs a compare subtraction on eax and sets the appropriate flags without editing the content of the register
	je or2 ;//jumps to or2 label if the cmp set the zero flag
	cmp eax, 3 ;//performs a compare subtraction on eax and sets the appropriate flags without editing the content of the register
	je not3 ;//jumps to not3 label if the cmp set the zero flag
	cmp eax, 4 ;//performs a compare subtraction on eax and sets the appropriate flags without editing the content of the register
	je xor4 ;//jumps to xor4 label if the cmp set the zero flag
	cmp eax, 5 ;//performs a compare subtraction on eax and sets the appropriate flags without editing the content of the register
	ja top ;//jumps to the top label if the cmp set the carry flag
	jmp exit5 ;//if none of the other jumps occur then the number must be 5; jumps to the exit5 label
and1: ;// a jump to this label will call XYAnd, then jump back to the top, again asking the user to enter a choice, effectivly causing a loop
	call XYAnd ;// calls the user defined XYAnd procedure
	jmp top ;//jumps to the top label, prompting the user to make another choice
or2: ;// a jump to this label will call XYOr, then jump back to the top, again asking the user to enter a choice, effectivly causing a loop
	call XYOr ;// calls the user defined XYOr procedure
	jmp top ;//jumps to the top label, prompting the user to make another choice
not3: ;// a jump to this label will call XNot, then jump back to the top, again asking the user to enter a choice, effectivly causing a loop
	call XNot ;// calls the user defined XNot procedure
	jmp top ;//jumps to the top label, prompting the user to make another choice
xor4: ;// a jump to this label will call XYXOr, then jump back to the top, again asking the user to enter a choice, effectivly causing a loop
	call XYXor ;// calls the user defined XYOr procedure
	jmp top ;//jumps to the top label, prompting the user to make another choice
exit5: ;// a jump to this label will exit the procedure (loop) and then the program
pop eax ;// pops the eax from the top of the stack
ret ;// returns to where the function was called
GetChoice ENDP ;//ends the GetChoice procedure

GetOperand PROC ;//user defined procedure that will retrieve the operands required for the operations
push edx ;// pushes edx to the top of the stack
mov ebx, eax ;//moves the contents of eax (holding the choice the user made) to the ebx register
mov edx, offset inMsg ;//moves the begining of the inMsg string to the edx for use with WriteStringinMsg
call WriteString ;//Prints the contents of the edx register to the screen
call ReadHex ;//Irvine function that retrieves a hex value from the keyboard
cmp ebx, 3 ;//perfoms a compare subtraction on the ebx (which holds the choice the user made); 3 is the only option that has one operand
je back ;//jumps to the back label if cmp set the zero flag
mov ebx, eax ;//moves the contents of eax (the first hex value) to the ebx
mov edx, offset inMsg2 ;//moves the begining of the inMsg2 string to the edx for use with WriteStringinMsg2
call WriteString ;//Prints the contents of the edx register to the screen
call ReadHex ;//Irvine function that retrieves a hex value from the keyboard
back: ;//a jump to this label will simply just retrun
pop edx;// pops edx from the top of the stack
ret ;// returns to where the function was called
GetOperand ENDP ;//ends the GetOperand procedure

XYAnd PROC ;// user defined procedure that performs the AND operation on the operands retrieved in GetOperand
push eax ;// pushes the eax to the top of the stack
push ebx ;// pushes the ebx to the top of the stack
push edx ;// pushes the edx to the top of the stack

mov edx, offset andMsg ;//moves the begining of the andMsg string to the edx for use with WriteStringandMsg
call WriteString ;//Prints the contents of the edx register to the screen
call GetOperand ;// calls the user defined GetOperand procedure ;// calls the user defined GetOperand procedure
and eax, ebx ;// ANDs eax with ebx
call PrintResult ;// calls the user defined PrintResult procedure ;// callls the user defied PrintResult procedure

pop edx ;// pops the edx from the top of the stack
pop ebx ;// pops the ebx from the top of the stack
pop eax ;// pops the eax from the top of the stack
ret ;// returns to where the function was called
XYAnd ENDP ;// ends the XYAnd procedure

XYOr PROC ;// user defined procedure that performs the OR operation on the operands retrieved in GetOperand
push eax ;// pushes the eax to the top of the stack
push ebx ;// pushes the ebx to the top of the stack
push edx ;// pushes the edx to the top of the stack

mov edx, offset orMsg ;//moves the begining of the orMsg string to the edx for use with WriteStringorMsg
call WriteString ;//Prints the contents of the edx register to the screen
call GetOperand ;// calls the user defined GetOperand procedure
or eax, ebx;// ORs eax with ebx
call PrintResult ;// calls the user defined PrintResult procedure

pop edx ;// pops the edx from the top of the stack
pop ebx ;// pops the ebx from the top of the stack
pop eax ;// pops the eax from the top of the stack
ret ;// returns to where the function was called
XYOr ENDP ;//ends the XYor procedure

XNot PROC ;// user defined procedure that performs the NOT operation on the operand retrieved in GetOperand
push eax ;// pushes the eax to the top of the stack
push edx ;// pushes the edx to the top of the stack

mov edx, offset notMsg ;//moves the begining of the notMsg string to the edx for use with WriteStringnotMsg
call WriteString ;//Prints the contents of the edx register to the screen
call GetOperand ;// calls the user defined GetOperand procedure
not eax ;// performs the NOT operation on the eax register
call PrintResult ;// calls the user defined PrintResult procedure

pop edx ;// pops the edx from the top of the stack
pop eax ;// pops the eax from the top of the stack
ret ;// returns to where the function was called
XNot ENDP ;// ends the XNot procedure

XYXor PROC ;// user defined procedure that performs the XOR operation on the operands retrieved in GetOperand
push eax ;// pushes the eax to the top of the stack
push ebx ;// pushes the ebx to the top of the stack
push edx ;// pushes the edx to the top of the stack

mov edx, offset xorMsg ;//moves the begining of the xorMsg string to the edx for use with WriteStringxorMsg
call WriteString ;//Prints the contents of the edx register to the screen
call GetOperand ;// calls the user defined GetOperand procedure
xor eax, ebx;// XORs eax with ebx
call PrintResult ;// calls the user defined PrintResult procedure

pop edx ;// pops the edx from the top of the stack
pop ebx ;// pops the ebx from the top of the stack
pop eax ;// pops the eax from the top of the stack
ret ;// returns to where the function was called
XYXor ENDP ;// ends the XYXor procedure

PrintResult PROC ;//user defined procedure that will print the result of the given operation
push edx ;// pushes the edx to the top of the stack
push eax ;// pushes the eax to the top of the stack

mov edx, offset outMsg ;//moves the begining of the outMsg string to the edx for use with WriteStringoutMsg
call WriteString ;//Prints the contents of the edx register to the screen
call WriteHex ;//Irvine function that prints the hex value of the eax register
call Crlf ;//prints a carriage return line feed pair (new line)

pop eax ;// pops the eax from the top of the stack
pop edx ;// pops the edx from the top of the stack
ret ;// returns to where the function was called
PrintResult ENDP ;//ends the PrintResult procedure


END main		; // ends the program
