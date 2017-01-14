INCLUDE procedure.inc			;//includes everything in the procedure.inc file
.code							;// code segment. all the instructions go here

printText PROC,					;//user defined procedure that will print a character array and a new line
String: ptr byte				;//points to the offset of the array that will be printed
	mov edx, String				;//moves beginning of the array to edx for WriteString
	call WriteString			;//prints the contents of the edx register to the screen
	call Crlf					;//prints a new line
	ret							;//returns to where it was called
printText ENDP					;//ends the procedure
END								;//ends the file