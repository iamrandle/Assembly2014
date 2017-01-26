;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 3 May 2014
;// Practice 13
;// note: comments for code I added/changed are in green, Irvine's are unedited and in black

TITLE Column Sum Calculation               (ColSum.asm)	;//chnaged title and filename

; This program demonstrates the use of Base-Index addressing 
; with a two-dimensional table array of bytes (a byte matrix).

INCLUDE Irvine32.inc

.data
tableB  BYTE  10h,  20h,  30h,  40h,  50h
        BYTE  60h,  70h,  80h,  90h,  0A0h
        BYTE  0B0h, 0C0h, 0D0h, 0E0h, 0F0h
RowSize = 5
ColSize = 3 ;//added, size of each column in the table
msg1	BYTE "Enter column number <0-4>: ",0 ;//tells the user valid column numbers to enter
msg2 BYTE "The sum is ",0
msg3 byte " for column " ;//added to specify which column is selected

.code
main PROC

; Demonstrate Base-Index mode:

	mov	edx,OFFSET msg1		; "Enter row number:"
	call	WriteString
	call	Readint				; EAX = row number
	push eax					;//save the colom number

	mov	ebx,OFFSET tableB
	mov	ecx, ColSize				;//moves ColSize instead of RowSize
	call	calc_col_sum			; EAX = sum;//now call calc_col_sum instead of calc_row_sum
   
	mov	edx,OFFSET msg2		; "The sum is:"
	call	WriteString
	call	WriteHex				; write sum in EAX
	mov edx, offset msg3		;//move beginning of msg3 to edx
	call WriteString			;//print contents of edx
	pop eax						;//restore the column number
	call WriteDec				;//print unsigned decimal value in eax
	call	Crlf

	exit
main ENDP


;------------------------------------------------------------
calc_col_sum PROC uses ebx ecx edx esi
;
; Calculates the sum of a column in a byte matrix. //works on columns now, not rows
; Receives: EBX = table offset, EAX = row index, 
;		  ECX = column size, in bytes. //coloumn instead of row
; Returns:  EAX holds the sum.
;------------------------------------------------------------
	;mul ecx		; row index * row size	//instruction removed, it is not needed
	add	ebx,eax		; row offset //column offset
	mov	eax,0		; accumulator
	mov	esi,0		; column index

L1:	movzx edx,BYTE PTR[ebx + esi]		; get a byte
	add	eax,edx					; add to accumulator
	add esi, RowSize						; next byte in row
	loop	L1

	ret
calc_col_sum ENDP

END main