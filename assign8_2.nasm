%include "macro.nasm"
global _main
_main :

	global proc
	extern buff,abuff_len
	
	proc:
		print buff,[abuff_len]
		ret
