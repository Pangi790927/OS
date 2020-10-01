[bits 32]
[extern boot2]

entry_point:

call intern_dump_info

call boot2	; here we enter kernel_2
jmp $	; again, we should never return here 

; DBG SERIAL PRRINT FUNCTIONS
; =============================================================================

serial_putchar:
	push ebp
	mov ebp, esp
		push bx
		push dx
		mov bl, al
		mov dx, 0x3FD 
		.retry:
			in al, dx
			and al, 0x20
			jz .retry
		mov al, bl

		mov dx, 0x3F8 
		out dx, al
		pop dx
		pop bx
	pop ebp
	ret


intern_putchar:
	call serial_putchar
	; call bios_intern_putchr
	ret

; esi - pointer to string
intern_print:
	pusha
		xor ebx, ebx	; ebx = 0
		jmp .while_condition
		.while_start:
			mov al, byte [esi + ebx]
			call intern_putchar

			add ebx, 1
		.while_condition:
			mov cl, byte [esi + ebx]
			cmp cl, 0
			jne .while_start
	popa
	ret

; eax - number
; ebx - base
intern_print_number_base_rec:
	pusha
		cmp eax, 0
		je .if_end; if (ax != 0)
			xor edx, edx ; edx = 0
			; mov ax, ax - number to divide already in ax
			div ebx ; edx:eax / ebx = eax (reminder edx)
			
			call intern_print_number_base_rec

			push eax	; saving ax and printing the character
			mov edi, edx
			mov al, byte [digits + edi]
			call intern_putchar
			pop eax ; returning eax
		.if_end:
	popa
	ret

; eax - number 
; ebx - base
intern_print_number_base:
	pusha
		cmp eax, 0
		jne .if_else ; if (eax == 0)
			mov al, '0'
			call intern_putchar
		jmp .if_end 
		.if_else:
			; eax, ebx already set
			call intern_print_number_base_rec
		.if_end:
	popa
	ret

; eax - number in base 10
intern_putdec:
	pusha
		mov ebx, 10
		call intern_print_number_base
	popa
	ret

; eax - number in base 16
intern_puthex:
	pusha
		mov esi, hex_prefix
		call intern_print
		mov ebx, 16
		call intern_print_number_base
	popa
	ret

intern_putendl:
	pusha
		mov esi, separator
		call intern_print
	popa
	ret

intern_dump_info:
	push esi
	push eax
		mov esi, boot2_addr_str
		call intern_print
		mov eax, boot2
		call intern_puthex
		call intern_putendl

		mov esi, entry_addr_str
		call intern_print
		mov eax, entry_point
		call intern_puthex
		call intern_putendl
	pop eax
	pop esi

	call dump_regs
	ret

[global dump_regs]
dump_regs:
	push eax
	push esi
	push esi

	mov esi, eax_name
	call intern_print
	call intern_puthex
	call intern_putendl

	mov esi, ebx_name
	call intern_print
	mov eax, ebx
	call intern_puthex
	call intern_putendl

	mov esi, ecx_name
	call intern_print
	mov eax, ecx
	call intern_puthex
	call intern_putendl

	mov esi, edx_name
	call intern_print
	mov eax, edx
	call intern_puthex
	call intern_putendl

	mov esi, edi_name
	call intern_print
	mov eax, edi
	call intern_puthex
	call intern_putendl

	mov esi, esi_name
	call intern_print
	pop eax
	call intern_puthex
	call intern_putendl

	mov esi, ebp_name
	call intern_print
	mov eax, ebp
	call intern_puthex
	call intern_putendl

	mov esi, esp_name
	call intern_print
	mov eax, esp
	sub eax, 8
	call intern_puthex
	call intern_putendl

	mov esi, cr0_name
	call intern_print
	mov eax, cr0
	call intern_puthex
	call intern_putendl

	; mov esi, cr1_name
	; call intern_print
	; mov eax, cr1
	; call intern_puthex
	; call intern_putendl

	mov esi, cr2_name
	call intern_print
	mov eax, cr2
	call intern_puthex
	call intern_putendl

	mov esi, cr3_name
	call intern_print
	mov eax, cr3
	call intern_puthex
	call intern_putendl

	mov esi, cr4_name
	call intern_print
	mov eax, cr4
	call intern_puthex
	call intern_putendl

	pop esi
	pop eax
	ret


; INTERN STRUCTURES
; =============================================================================
entry_addr_str: db "entry-addr: ", 0
boot2_addr_str: db "boot2-addr: ", 0
digits: db '0123456789abcdef'
hex_prefix: db "0x", 0
separator: db 0xd, 0xa, 0

eax_name: db "eax: ", 0
ebx_name: db "ebx: ", 0
ecx_name: db "ecx: ", 0
edx_name: db "edx: ", 0
edi_name: db "edi: ", 0
esi_name: db "esi: ", 0
ebp_name: db "ebp: ", 0
esp_name: db "esp: ", 0

cr0_name: db "cr0: ", 0
; cr1_name: db "cr1: ", 0
cr2_name: db "cr2: ", 0
cr3_name: db "cr3: ", 0
cr4_name: db "cr4: ", 0