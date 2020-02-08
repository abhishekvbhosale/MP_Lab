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

	print msg,len	
	accept num,3
	call convert
	mov [no1],al
	
	print msg1,len1
	accept num,3
	call convert
	mov [no2],al
	
	
	print msg2,len2
	mov ax,0000h
	ll1 :
	add ax,[no1]
	dec byte[no2]
	jnz ll1
	call displayproc
	
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
		
	displayproc :
		mov rsi,disparr+3
		mov rcx,4
		
		l4:
		mov rdx,0
		mov rbx,10H
		div rbx
		cmp dl,09H
		jbe l5
		add dl,07H
		l5 : add dl,30H
		mov [rsi],dl
		dec rsi
		dec rcx
		jnz l4
		print disparr,4
		ret
		
section .data
		
		msg db "Enter first number--",10
		len equ $-msg
		
		msg1 db "Enter second number--",10
		len1 equ $-msg1
		
		msg2 db "The multiplication is --",10
		len2 equ $-msg2

section .bss
		
		num resb 05
		no1 resb 05
		no2 resb 05
		disparr resb 32
