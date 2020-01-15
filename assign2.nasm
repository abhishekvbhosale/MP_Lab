global _start
_start:

section .text
	%macro print 2
	mov rax,1
	mov rdi,1
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro

	%macro accept 2
	mov rax,0
	mov rdi,0
	mov rsi,%1
	mov rdx,%2
	syscall
	%endmacro

	menu:
		print menu1,le5
		accept choice1,2
		mov al,byte[choice1]
		cmp al,31H
		je ch1
		cmp al,32H
		je ch2
		cmp al,33H
		je ch3
	ch1: mov rsi,oarr
	mov rdi,oarr
	add rsi,9
	add rdi,13

	l1:mov al,[rsi]
	mov [rdi],al
	dec rsi
	dec rdi	
	dec byte[cnt1]
	jnz l1

	;Display oarr
	print msg1,lg1
	mov rsi,oarr
	l2: mov al,[rsi]
	push rsi
	call disproc1
	pop rsi
	inc rsi
	dec byte[cnt2]
	jnz l2
	jmp menu

	ch2: mov rsi,oarr1
	mov rdi,oarr1
	add rsi,9
	add rdi,13
	std
	mov rcx,10
	rep movsb
	;Display oarr1
	print msg1,lg1
	mov rsi,oarr1
	l3: mov al,[rsi]
	push rsi
	call disproc1
	pop rsi
	inc rsi
	dec byte[cnt3]
	jnz l3
	jmp menu
	
	ch3: mov rax,60
	mov rdi,0
	syscall
	jmp menu

disproc1 :
		mov rsi, disparr + 1
		mov rcx,2
	
	ll2 :   mov rdx, 0
		mov rbx, 10H
		div rbx
		cmp dl, 09H
		jbe ll1
		add dl, 07H
	
	ll1 :   add dl, 30H
		mov [rsi],dl
		dec rsi
		dec rcx
		jnz ll2
		print disparr, 2
		print  m,l
	ret

section .data

	oarr db 01H, 02H, 03H, 04H, 05H, 06H, 07H, 08H, 09H, 0AH, 0BH, 0CH, 0DH, 0EH, 0FH
	oarr1 db 01H, 02H, 03H, 04H, 05H, 06H, 07H, 08H, 09H, 0AH, 0BH, 0CH, 0DH, 0EH, 0FH
	
	msg1 db "Before Copying Source array",10
	lg1 equ $-msg1

	m db " ",10
	l equ $-m

	menu1 db "1.Overlap",10
	      db "2.overlap using string",10
	      db "3.Exit",10
	      db "Enter Choice",10
	le5 equ $-menu1
	
	cnt1 db 10
	cnt2 db 15
	cnt3 db 15

section .bss
	disparr resb 32
	choice1 resb 02	

