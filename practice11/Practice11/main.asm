;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 16 April 2014
;// Practice 11
;// note: comments for code I added/changed are in green, Irvine's are unedited and in black

TITLE Demonstrate the AddThree Procedure     (AddThree.asm)

; Demonstrates different procedure call protocols.

INCLUDE Irvine32.inc

.data
	word1 word 1234h
	word2 word 4111h
	word3 word 1111h

.code
main PROC
	movzx eax, word1
	push eax
	movzx eax, word2
	push eax
	movzx eax, word3
	push eax
	call AddThree
	call DumpRegs

	call Example1
	call Example2
	call Example1
	call Example2


exit
main ENDP

; Call the "C" version of AddThree

Example1 PROC
	push 5
	push 6
	push 1 ;//added to add 3 paramters
	call AddThree_C
	add  esp,12		; clean up the stack ;// because there are 3 parameters 12 must be added to esp to clean up the stack (3*type dword = 12)
	call DumpRegs		; sum is in EAX
	ret
Example1 ENDP

; Call the STDCALL version of AddThree

Example2 PROC
	push 5
	push 6
	push 3 ;//added to add 3 parameters
	call AddThree
	call DumpRegs		; sum is in EAX
	ret
Example2 ENDP


AddThree_C PROC
; Adds two integers, return sum in EAX.
; RET does not clean up the stack.
    push ebp
    mov  ebp,esp
    mov  eax,[ebp + 16]   	; first parameter ;// since there are 3 parameter the first one is now at ebp+16
	add eax, [ebp + 12]		;//adds the second parameter to the first (ebp+12 now is now the second parameter)
    add  eax,[ebp + 8]		; second parameter ;// adds the third parameter to the previous 2 (ebp+8 is now the third parameter)
    pop  ebp
    ret					; caller cleans up the stack
AddThree_C ENDP

AddThree PROC
; Adds two integers, returns sum in EAX.
; The RET instruction cleans up the stack.

    push ebp
    mov  ebp,esp
    mov  eax,[ebp + 16]   	; first parameter ;//moves the first parameter (ebp+16) to the eax
	add eax, [ebp + 12]		;//adds the second parameter (ebp+12) to the first
    add  eax,[ebp + 8]		; second parameter ;//adds the third parameter (ebp+8) to the previous 2
    pop  ebp
    ret  12				; clean up the stack ;//since there are 3 parameters, we nust use ret 12 to clean up the stack (3*type dword = 12)
AddThree ENDP

END main