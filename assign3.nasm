global _start

_start :
    
section .text 	
	%macro accept 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
	
	%macro print 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro
	
	print msg,length		;"input the digit"
	accept num,2
	
	call convert
	mov [no1],al
	
	accept num,3
	call convert
	mov [no2],al
	
	mov rax,60
	mov rdi,0
	syscall
	
	convert :
		mov rsi,num
		mov al,[rsi]
		cmp al,39h
		jbe l1
		sub al,7h
		l1:
		sub al,30h
		rol al,04
		mov bl,al
		inc rsi
		mov al,[rsi]
		cmp al,39h
		jbe l2
		sub al,7h
		l2 :
		sub al,30h
		add al,bl
		ret
		
		
section .data
	msg db "Give a 4 Digit number--",10
	length equ $-msg
	
section .bss
	num resb 05
	no1 resb 02
	no2  resb 02
		
