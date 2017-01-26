;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 22 February 2014
;// Practice 5

TITLE Data Transfer Examples (Moves.asm)
INCLUDE Irvine32.inc
.data
	val1 WORD 1000h
	val2 WORD 2000h
	arrayB BYTE 10h,20h,30h,40h,50h
	arrayW WORD 100h,200h,300h
	arrayD DWORD 10000h,20000h
.code
main PROC
	; Demonstrating MOVZX instruction:
	mov bx,0A69Bh
	call WriteInt	;//prints the signed decimal value of eax which contains garbage (no values have been moved there)
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	movzx eax,bx ; 
	call WriteInt	;//prints the signed decimal value of eax. Since bx was moved there using movzx, the last 16 bits will = bx contents and the upper 16 bits all equal 0
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	movzx edx,bl ; 
	mov eax, edx	;//moves the contents of edx to eax so that it can be read with WriteInt
	call WriteInt	;//prints the signed decimal value of eax. Will only print what is in dl (or al) because the rest of the register will be set to 0
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	movzx cx,bl ; 
	mov eax, ecx	;//moves the contents of ecx to eax so that it can be read with WriteInt
	call WriteInt	;//prints the signed decimal value of eax. The 0s will only extend to the end of cx so whatever values are stored above those bits will be added to what is moved
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	
	; Demonstrating MOVSX instruction:
	mov bx,0A69Bh
	mov eax, ebx	;//moves the contents of ebx to eax so that it can be read with WriteInt
	call WriteInt	;//prints the signed decimal value of eax. 
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	movsx eax,bx 
	call WriteInt	;//prints the signed decimal value of eax. The highest bit in bx (1) will be extended to the remaining bits in eax
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	movsx edx,bl 
	mov eax, edx	;//moves the contents of ebx to eax so that it can be read with WriteInt
	call WriteInt	;//prints the signed decimal value of eax. The highest bit in bl (1) will be extended to the remaining bits of edx which is moved to eax 
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	mov bl,7Bh
	mov eax, ebx	;//moves the contents of ebx to eax so that it can be read with WriteInt
	call WriteInt	;//prints the signed decimal value of eax. 
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	movsx cx,bl 
	mov eax, ecx	;//moves the contents of ebx to eax so that it can be read with WriteInt
	call WriteInt	;//prints the signed decimal value of eax. The highest bit in bl (1) will be extended to the remaining bits of cx which is moved to eax
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	; Memory-to-memory exchange:
	mov ax,val1 
	call WriteInt	;//prints the signed decimal value of eax. only ax is updated with val1 so whatever value is in the bits above it will remain
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	xchg ax,val2 
	call WriteInt	;//prints the signed decimal value of eax. the ax portion of eax now equals what val2 was before and val2 == what was in ax
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	mov val1,ax 
	call WriteInt	;//prints the signed decimal value of eax. ax was moved to val1 which means that ax and val1 now hold the same value
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	; Direct-Offset Addressing (byte array):
	mov al,arrayB  
	call WriteInt	;//prints the signed decimal value of eax. since arrayB is moved to al, all the bits above it remain the same. This accesses the first element in the array
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	mov al,[arrayB+1] 
	call WriteInt	;//prints the signed decimal value of eax. by moving [arrayB+1] the array's offset will be incremented by one byte, moving the next value in the array to al which is the only part of eax being updated
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	mov al,[arrayB+2] 
	call WriteInt	;//prints the signed decimal value of eax. by moving [arrayB+2] the array's offset will be incremented by two bytes, moving the third value in the array to al
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	; Direct-Offset Addressing (word array):
	mov ax,arrayW 
	call WriteInt	;//prints the signed decimal value of eax. since arrayw is moved to ax, all the bits above it remain the same. This accesses the first element in the array 
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	mov ax,[arrayW+2] 
	call WriteInt	;//prints the signed decimal value of eax. by moving [arrayW+2] the array's offset will be incremented by 2 bytes, moving the next value in the array to ax (since the type in the array is word) 
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	; Direct-Offset Addressing (doubleword array):
	mov eax,arrayD 
	call WriteInt	;//prints the signed decimal value of eax. arrayD is moved to eax which accesses the first element in the array
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	mov eax,[arrayD+4] 
	call WriteInt	;//prints the signed decimal value of eax. by moving [arrayD+4] the array's offset will be incremented by 4 bytes, moving the next value in the array to eax (since the type in the array is dword) 
	call Crlf		;//prints out a carriage return line feed pair (a new line)
	mov eax,[arrayD+4] 
	call WriteInt	;//prints the signed decimal value of eax. The same value as before is moved to eax since [arrayD+4] adds 4 bytes to the original array offset and not the last memory location accessed
	call Crlf		;//prints out a carriage return line feed pair (a new line)

    exit		; // calls the microsoft exit function
main ENDP		; // ends the main procedure
END main		; // ends the program
