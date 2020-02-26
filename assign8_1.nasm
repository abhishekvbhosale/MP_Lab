%include "macro.nasm"
global _start
_start:

global buff,abuff_len

extern proc

section .text

	print msg,len
	
	pop rcx
	pop rcx
	pop rcx
	
	mov [filename],rcx
	
	fopen [filename]
	cmp rax,-1h
	je error
	
	mov [filehandel],rax
	
	fread [filehandel],buff,buff_len
	dec rax
	mov[abuff_len],rax
	call proc
	
	mov rax,60
	mov rdi,0
	syscall
	
	error :
	print msge,lene
	
section .data

	msge db "Cannot open file",10
	lene equ $-msge
	
	msg db "Input of file is",10
	len equ $-msg
	

section .bss

	filename resb 10
	filehandel resb 10
	buff resb 32
	buff_len resb 10
	abuff_len resb 10

