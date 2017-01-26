;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 22 February 2014
;// Practice 6

TITLE Copying a String (CopyStr.asm)
INCLUDE Irvine32.inc
.data
source BYTE "This is the source string",0
target BYTE SIZEOF source DUP(0)
.code
main PROC
mov esi,0 ;// index register
mov ecx,SIZEOF source ;// loop counter
mov edx, offset source ;//moves the offset of the source string to the edx so that WriteString will print it out
call WriteString ;//prints out the source string
call Crlf ;// creates a carriage return line feed pair (a new line)
L1:
mov al,source[esi] ;// get a character from source
mov target[esi],al ;// store it in the target
inc esi ;// move to next character
mov edx, offset target ;//moves the offset of the target string to the edx so that WriteString will print it out
call WriteString ;//prints out the target string. Each loop will copy an additional character to the target string to be outputed. (note the remaining characters of the string are null characters therefore the string is not getting any larger, the characters are merely being changed)
call Crlf ;//creates a carriage return line feed pair (a new line)
loop L1 ;// repeat for entire string
exit
main ENDP
END main
