[global __setSegmentRegs]
__setSegmentRegs:
	push ebp
	mov ebp, esp
		mov eax, [ebp + 8]
		mov ss, ax
		mov fs, ax
		mov gs, ax
		mov es, ax
		mov ds, ax
	pop ebp
	ret
