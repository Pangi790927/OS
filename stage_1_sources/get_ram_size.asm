; ax, bx - return value
; AX = extended memory between 1M and 16M, in K (max 3C00h = 15MB)
; BX = extended memory above 16M, in 64K blocks 
get_ram_size:
	xor cx, cx
	xor dx, dx
	mov ax, 0xE801
	int 0x15
	jc .err

	cmp ah, 0x86	; unsupported function
	je .err

	cmp ah, 0x80	; invalid command
	je .err

	jcxz .use_eax	; was the CX result invalid?
		
		mov ax, cx
		mov bx, dx

	.use_eax:

	jmp .done
	.err:
	.done:

	ret