[global __getIOPL]
__getIOPL:
	pushf
	pop eax
	push eax
	popf
	and eax, 0x3000
	shr eax, 12
	ret
