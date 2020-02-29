%include "macro.nasm"
global _main
_main :

	global proc
	extern buff,abuff_len
	
	proc:
		print buff,[abuff_len]
		print char_,char_len
		accept num,2
		mov bl,byte[num]
		mov rsi,buff
		loop1:
		mov al,[rsi]
		cmp al,0Ah ;hex value for enter
		je label_enter
		cmp al,20h ;hex value for space
		je label_space
		cmp al,bl
		je label_char
		jmp break
		
		label_enter:
			inc byte[cnt_enter]
			jmp break
		label_space:
			inc byte[cnt_space]
			jmp break
		label_char:
			inc byte[cnt_char]
			jmp break
		
		break:
			inc rsi
			dec byte[abuff_len]
			jnz loop1
			
		print enter_,nenter_
		mov al,byte[cnt_enter]
		call displayproc  ;for two variables
		
		print space_,nspace_
		mov al,byte[cnt_space]
		call displayproc  
		
		print pchar_,nchar_
		mov al,byte[cnt_char]
		call displayproc  
		
		ret
		
		displayproc :
		mov rsi,disparr+1
		mov rcx,2
		
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
		print disparr,2
		ret
	
section .data
		
		char_ db 10,"Enter the character to be found",10
		char_len equ $-char_
		
		enter_ db 10,"Total number of lines left--",10
		nenter_ equ $-enter_
		
		space_ db 10,"Total number of space given--",10
		nspace_ equ $-space_
		
		pchar_ db 10,"The character is repeated---",10
		nchar_ equ $-pchar_
		
section .bss

		num resb 04
		cnt_enter resb 10
		cnt_space resb 10
		cnt_char resb 10
		disparr resb 32
