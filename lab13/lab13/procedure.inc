INCLUDE Irvine32.inc			;//includes irvine's library

max = 40						;//max number in the array

replaceChar PROTO,				;//prototype for replaceChar
	String : ptr byte,			;//points to the offset of the array that will be searched
	oldChar: byte,				;//holds the character to be searched for
	newChar: byte				;//holds the character that will replace the old one
printText PROTO,				;//prototype for printText
	String: ptr byte			;//points to the offset of the array that will be printed
