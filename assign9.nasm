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
		
		print m3,l3	;smsw
		mov ax,[cr0data+2]
		call displayproc
		mov ax,[cr0data]
		call displayproc
		
		print m4,ll4 ;TR
		str ebx
		mov [data],ebx
		mov ax,[data]
		call displayproc
		
		print m5,ll5	;LDTR
		sldt eax
		mov [cr0data],eax
		mov ax,[cr0data]
		call displayproc
		
		print m6,ll6	;GDTR
		sgdt [cr0data]
		;mov [cr0data],ecx
		mov ax,[cr0data+4]
		call displayproc
		mov ax,[cr0data+2]
		call displayproc
		mov ax,[cr0data]
		call displayproc
		
		print m7,ll7	;IDTR
		sidt [cr0data]
		mov ax,[cr0data+4]
		call displayproc
		mov ax,[cr0data+2]
		call displayproc
		mov ax,[cr0data]
		call displayproc
		
		exit :
		mov rax,60
		mov rdi,00
		syscall
		
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
		mr db "Real Mode",10
		lr equ $- mr
		
		mp db "Protected Mode",10
		lp equ $- mp
		
		m3 db 10,"Contents of MSW--",10
		l3 equ $- m3
		
		m4 db 10,"Contents of TR--",10
		ll4 equ $- m4
		
		m5 db 10,"Contents of LDTR--",10
		ll5 equ $- m5
		
		m6 db 10,"Contents of GDTR--",10
		ll6 equ $- m6
		
		m7 db 10,"Contents of IDTR--",10
		ll7 equ $- m7
		
section .bss

		cr0data resb 660
		data resb 64
		disparr resb 32
