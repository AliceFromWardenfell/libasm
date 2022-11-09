section.data:
	str1 db "Greg!", 0xA
	len equ $ - str1

section.text:
	global _start
	
	_start:
		mov eax, 4
		mov ebx, 1
		mov ecx, str1
		mov edx, len
		int 0x80;
		
		mov eax, 1
		int 0x80
