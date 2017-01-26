;// Tyler Bradley
;// CSIS-118BComp Org & Assem Lang Section 3888
;// 9 February 2014
;// Lab 3

INCLUDE Irvine32.inc

.data 
    
;// no variables
.code
main PROC 
	call Clrscr ;// clears whatever content is on the screen
	call DumpRegs ;// displays all of the CPU registers and the values they hold
	mov al, 11h ;// updates the al register to 11hex. al refers to only the lowest 8bits of the ax register which refers to the lower 16bits of the eax register therefore every bit above bit 8 is unaffected but the lowest 8 bits of the eax register are changed
	call DumpRegs ;//displays all of the CPU registers and the values they hold
	mov ax, 1111h ;// updates the ax register to 1111hex. As stated above, ax refers to the lowest 16 bits of the eax register and thus the upper 16 bits remain untouched while the lower 16bits (that is the ax register) are changed
	call DumpRegs ;//displays all of the CPU registers and the values they hold
	mov eax, 1111h ;// updates the eax register to 1111hex. The upper 16 bits are all set to zero because a 16 bit number, 1111h, is being moved into a 32 bit space, the eax register. If the upper bits were anything other than zero, then 1111h would not be the number being moved. 1111h = 00001111h.  
	call DumpRegs ;//displays all of the CPU registers and the values they hold


    exit
main ENDP
END main
