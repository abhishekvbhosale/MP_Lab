%include "macro.nasm"
global _start
_start:

section .text

		smsw eax
		mov [cr0data],eax
		bt eax,00
		jc l1
		print mr,lr
		jmp exit
		l1 :
		print mp,lp
		
		print m3,l3
		mov ax,[cr0data+2]
		call displayproc
		mov ax,[cr0data]
		call displayproc
		
		exit :
		mov rax,60
		mov rdi,00
		syscall
		
		displayproc :
		mov rsi,disparr+15
		mov rcx,16
		
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
		print disparr,16
		ret
		
section .data
		mr db "Real Mode",10
		lr equ $- mr
		
		mp db "Protected Mode",10
		lp equ $- mp
		
		m3 db 10,"Contents of MSW--",10
		l3 equ $- m3
		
section .bss

		cr0data resb 64
		disparr resb 32
