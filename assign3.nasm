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
	
	menu1 :
	print menu,len
	accept choice,2
	mov al,byte[choice]
	
	cmp al,31h
	je hex
	
	cmp al,32h
	je bcd
	
	cmp al,33h
	je exit
	
	hex :
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
	jmp menu1
	
	bcd :
	print msg2,length2
	
	mov rsi,array1
	ll1:
	push rsi
	accept num,1
	pop rsi
	mov al,byte[num]
	sub al,30h
	mov bx,[rsi]
	mul bx
	add [result],ax
	add rsi,2
	dec byte[cnt2]
	jnz ll1
	mov ax,[result]
	call displayproc2
	
	accept num2,1
	jmp menu1
	
	exit :
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
		
		displayproc2 :
		mov rsi,disparr+3
		mov rcx,4
		
		ll4:
		mov rdx,0
		mov rbx,10H
		div rbx
		cmp dl,09H
		jbe ll5
		add dl,07H
		ll5 : add dl,30H
		mov [rsi],dl
		dec rsi
		dec rcx
		jnz ll4
		print disparr,4
		ret
		
section .data
	msg db "Give a 4 Digit number--",10
	length equ $-msg
	
	msg2 db 10,"Give a BCD number--",10
	length2 equ $-msg2
	
	array1 dw 2710H,03E8H,0064H,000AH,0001H
	cnt db 05H
	
	cnt2 db 05H
	
	menu db 10,"1.Hex to BCD",10
	     db "2.BCD to Hex",10
	     db "3.Exit",10
	len equ $-menu
	
section .bss
	num resb 05
	num2 resb 05
	no1 resb 02
	no2  resb 02
	disparr resb 32
	rem1 resb 2
	result resw 2 
	choice resb 2
		
