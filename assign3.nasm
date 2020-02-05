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
	
	mov rsi,array1
	mov al,[no2]
	mov ah,[no1]
	l3 : 
	mov dx,0
	mov bx,[rsi]
	div bx
	mov [rem1],dx
	push rsi
	call displayproc
	pop rsi
	mov ax,[rem1]
	add rsi,2
	dec byte[cnt]
	jnz l3
	
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
		mov rsi,disparr
		mov rcx,1
		
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
		print disparr,1
		ret
		
section .data
	msg db "Give a 4 Digit number--",10
	length equ $-msg
	
	array1 dw 2710H,03E8H,0064H,000AH,0001H
	cnt db 05H
	
section .bss
	num resb 05
	no1 resb 02
	no2  resb 02
	disparr resb 32
	rem1 resb 2
		
