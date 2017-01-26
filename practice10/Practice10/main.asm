;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 12 April 2014
;// Practice 10
;// note: comments for code I added/changed are in green, Irvine's are unedited and in black

INCLUDE Irvine32.inc

.data
op1 WORD 1234h,7498h,0A406h,0A2B2h ;//changed to word values
op2 WORD 4502h,23h,8700h,8010h ;//changed to word values
sum WORD 5 dup(0) ;//changed to a word array
offLength dword ?;//added so that Display_Sum could print all 3 arrays


.code
main PROC
mov esi,OFFSET op1 ; first operand
mov edi,OFFSET op2 ; second operand
mov ebx,OFFSET sum ; sum operand
mov ecx,LENGTHOF op1 ; number of bytes
call Extended_Add
; Display the sum.

mov esi,OFFSET sum
mov ecx,LENGTHOF sum
mov offLength, sizeof sum ;//moves size of sum to offLength
call Display_Sum
call Crlf ;//prints a new line
mov esi, offset op1 ;//moves beginning of op1 to esi
mov ecx, lengthof op1 ;// moves lengthof op1 to ecx as a counter
mov offLength, sizeof op1 ;// moves size of op1 to offLength
call Display_Sum ;//calls Display_Sum to print op1
call Crlf ;// prints a new line

mov esi, offset op2 ;//moves beginning of op2 to esi
mov ecx, lengthof op2 ;//moves lengthof op2 to ecx as a counter
mov offLength, sizeof op2 ;//moves size of op2 to offLength
call Display_Sum ;//calls Display_Sum to print op2
call Crlf ;//prints a new line
exit
main ENDP

Extended_Add PROC

pushad
clc ; clear the Carry flag
L1: mov ax,[esi] ; get the first integer ;//changed al to ax
adc ax,[edi] ; add the second integer ;//changed al to ax
pushfd ; save the Carry flag
mov [ebx],ax ; store partial sum ;// changed al to ax
add esi,type word ; advance all three pointers // changed 1 to type word (which is 2)
add edi,type word ;// changed 1 to type word (which is 2)
add ebx,type word ;//changed 1 to type word (which is 2)
popfd ; restore the Carry flag
loop L1 ; repeat the loop
mov word ptr [ebx],0 ; clear high byte of sum //changed byte to word
adc word ptr [ebx],0 ; add any leftover carry //changed byte to word
popad
ret
Extended_Add ENDP

Display_Sum PROC
pushad
; point to the last array element
add esi, offLength;//jumps to end of array by adding offLength to the offset of esi
sub esi,TYPE word ;//point at the last element; changed byte to word
mov ebx,TYPE word;//changed byte to word
L1: mov ax,[esi] ; get an array byte ;//changed al to ax
call WriteHexB ; display it
sub esi,TYPE word ; point to previous byte ;//changed byte to word
loop L1
popad
ret
Display_Sum ENDP

END main