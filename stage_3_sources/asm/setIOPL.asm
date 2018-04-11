[global __setIOPL]
__setIOPL:
	push ebp
	mov ebp, esp
	push ebx
		mov eax, [ebp + 8]
		shl eax, 12
		and eax, 0x3000 
		pushf
		pop ebx
		or ebx, eax
		push ebx
		popf
	pop ebx
	pop ebp
	ret
