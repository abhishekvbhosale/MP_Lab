%include "macro.nasm"
global _start
_start:

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
	print buff,[abuff_len]

	mov al,[abuff_len]
	mov [cnt1],al
	ol :
	;print msg,len
	mov al,[abuff_len]
	dec al
	mov [cnt2],al
	mov rsi,buff
	mov rdi,buff
	inc rdi
	il :
	mov al,[rsi]
	mov bl,[rdi]
	cmp al,bl
	jbe l1
	call swap
	l1 :
	mov [rsi],al
	mov [rdi],bl
	inc rsi
	inc rdi
	dec byte[cnt2]
	jnz il
	dec byte[cnt1]
	jnz ol
	
	fwrite [filehandel],buff,[abuff_len]
	
	fclose [filename]
	
	mov rax,60
	mov rdi,0
	syscall

	error :
		print msge,lene

	swap :
		mov cl,al
		mov al,bl
		mov bl,cl
		ret

section .data

	msge db "Cannot open file",10
	lene equ $-msge

	msg db "Input from file is",10
	len equ $-msg

section .bss

	filename resb 10
	filehandel resb 10
	buff resb 32
	buff_len resb 10
	abuff_len resb 10
	cnt1 resb 10
	cnt2 resb 10
