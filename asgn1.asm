global _start

_start:

;-----------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------


section .text

%macro print 2	;print - name of macro	;2 - no. of parameters
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro




;to display an array


;point to an array
mov rsi, arr

;to fetch element from an array
l3 : mov rax, [rsi]

;push and pop rsi
;to preserve content of rsi because they change in displayproc

push rsi
call displayproc	;for calling display procedure (funx call for dislay procedure)
pop rsi

;to point to next element'
add rsi, 8

;decrement counter 1
dec byte[cnt1]
jnz l3

;loop finished



;bit test (to count +ve and -ve no.s in array)

;point to an array
mov rsi, arr


l10 : bt qword [rsi],63

;jump if carry flag is set (CF = 1)
jc lnegc

inc byte[pcnt]
jmp next


lnegc : inc byte[ncnt]

;go to next no. in array
next : add rsi, 8

dec byte[cnt2]
jnz l10

;loop finished



;to display count

mov al, byte[pcnt]
call displayproc1

mov al, byte[ncnt]
call displayproc1


;exit
mov rax,60
mov rdi,0
syscall


;-----------------------------------------------------------------------------------------


;procedure to display no. of 16 bits

displayproc :

;pointing array to last index location
mov rsi,disparr + 15

;initializing counter to 16
mov rcx,16



;starting loop

;making msb of no 0  (rdx:rax   ,where rdx = msb, rax = lsb)
l2:mov rdx,0
mov rbx,10h	;we can take any reg in place of rbx for divisor	;making divisor as rbx
div rbx		;it will divide rax by rbx


;compairing remainder to 9 (if less/equal then add 30 and if not then add 37)
cmp  dl,09h
jbe l1	;jump to l1 if l1 below or equal to 9


add dl,7h

l1:add dl,30h


;moving value in dl reg to rsi at array index rcx
mov [rsi],dl

;decrementing array index
dec rsi

;decrementing counter
dec rcx
jnz l2


;after completing loop print no.
print disparr,16

;return from procedure
ret


;-----------------------------------------------------------------------------------------


;display proc for 2 digits

displayproc1 :

;pointing array to last index location
mov rsi,disparr + 1

;initializing counter to 2
mov rcx,2


;starting loop

;making msb of no 0  (rdx:rax   ,where rdx = msb, rax = lsb)
ll2:mov rdx,0
mov rbx,10h		;we can take any reg in place of rbx for divisor	;making divisor as rbx
div rbx		;it will divide rax by rbx


;compairing remainder to 9 (if less/equal then add 30 and if not then add 37)
cmp  dl,09h
jbe ll1	;jump to l1 if l1 below or equal to 9


add dl,7h

ll1:add dl,30h


;moving value in dl reg to rsi at array index rcx
mov [rsi],dl

;decrementing array index
dec rsi

;decrementing counter
dec rcx
jnz ll2



;after completing loop print no.
print disparr,2

;return from procedure
ret



;-----------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------



section .data

arr dq 1212121212121255H, 2323232323232355H, 6767676767676755H, 8989898989898955H, 9898989898989855H

cnt1 db 05
cnt2 db 05


;-----------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------




;for allocating memory for undefined variables

section .bss

disparr resb 50
pcnt resb 02
ncnt resb 02
















