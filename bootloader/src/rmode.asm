[bits 16]

; DISK FUNCTIONS
; =============================================================================

; $1 - addr off		+ 8
; $2 - addr seg		+ 12
; $3 - lba_lo0		+ 16
; $4 - sect count	+ 20
; $5 - drive		+ 24
[global disk_read]
disk_read:
	push ebp
	mov ebp, esp
	pusha
		; first test for extension presence
		mov ah, 0x41 
		mov bx, 0x55aa
		mov dl, [ebp + 24]
		or dl, 0x80
		int 0x13
		jc .err_ext

		; now move the data
		mov ax, [ebp + 16]
		mov [disk_packet.lba_lo0], ax
		mov ax, [ebp + 20]
		mov [disk_packet.numt], ax
		mov ax, [ebp + 8]
		mov [disk_packet.off], ax
		mov ax, [ebp + 12]
		mov [disk_packet.seg], ax

		mov esi, disk_packet
		mov ah, 0x42
		mov dl, [ebp + 24]
		int 0x13

		jc .err_load

		mov word [err_code], 0
		jmp .done
		.err_load:
			mov esi, load_error
			call bios_print
			mov word [err_code], 1
			jmp .done
		.err_ext:
			mov esi, ext_error
			call bios_print
			mov word [err_code], 2
			jmp .done
		.done:
	popa
	mov eax, [err_code]
	pop ebp
	ret

err_code: dd 0

; RAM FUNCTIONS
; =============================================================================

; $1 - addr of a ramsize struct
; ramsize - return value
; AX = extended memory between 1M and 16M, in K (max 3C00h = 15MB)
; BX = extended memory above 16M, in 64K blocks 
[global get_ram_size]
get_ram_size:
	; shouldn't I pusha popa?
	push ebp
	mov ebp, esp
	pusha

	xor cx, cx
	xor dx, dx
	mov ax, 0xE801
	int 0x15
	jc .err

	mov edi, [ebp + 8]
	cmp ah, 0x86	; unsupported function
	je .err

	cmp ah, 0x80	; invalid command
	je .err

	jcxz .use_eax	; was the CX result invalid?
		
		mov [edi], cx
		mov [edi + 2], dx

	.use_eax:

	jmp .done
	.err:
		mov word [di], -1
		mov word [di + 2], -2
		mov esi, ram_error
		call bios_print
		jmp $
	.done:

	popa
	pop ebp
	ret

; PRINT FUNCTIONS
; =============================================================================

; $1 char
[global bios_putchr]
bios_putchr:
	push ebp
	mov ebp, esp
		push eax
		mov ax, [ebp + 8]
		mov ah, 0x0e
		int 0x10
		pop eax
	pop ebp
	ret

bios_intern_putchr:
	push ebp
	mov bp, sp
		push eax
		mov ah, 0x0e
		int 0x10
		pop eax
	pop ebp
	ret

; esi - pointer to string
bios_print:
	pusha
		xor ebx, ebx	; ebx = 0
		jmp .while_condition
		.while_start:
			mov al, byte [esi + ebx]
			call bios_intern_putchr

			add ebx, 1
		.while_condition:
			mov cl, byte [esi + ebx]
			cmp cl, 0
			jne .while_start
	popa
	ret

; eax - number
; ebx - base
bios_print_number_base_rec:
	pusha
		cmp eax, 0
		je .if_end; if (ax != 0)
			xor edx, edx ; edx = 0
			; mov ax, ax - number to divide already in ax
			div ebx ; edx:eax / ebx = eax (reminder edx)
			
			call bios_print_number_base_rec

			push eax	; saving ax and printing the character
			mov edi, edx
			mov al, byte [digits + edi]
			call bios_intern_putchr
			pop eax ; returning eax
		.if_end:
	popa
	ret

; eax - number 
; ebx - base
bios_print_number_base:
	pusha
		cmp eax, 0
		jne .if_else ; if (eax == 0)
			mov al, '0'
			call bios_intern_putchr
		jmp .if_end 
		.if_else:
			; eax, ebx already set
			call bios_print_number_base_rec
		.if_end:
	popa
	ret

; eax - number in base 10
bios_putdec:
	pusha
		mov ebx, 10
		call bios_print_number_base
	popa
	ret

; eax - number in base 16
bios_puthex:
	pusha
		mov esi, hex_prefix
		call bios_print
		mov ebx, 16
		call bios_print_number_base
	popa
	ret

bios_putendl:
	pusha
		mov esi, separator
		call bios_print
	popa
	ret

; INTERN STRUCTURES
; =============================================================================

digits: db '0123456789abcdef'

; error strings:
ext_error: db "Does not have bios load extension", 0xd, 0xa, 0
load_error: db "Failed to load from disk", 0xd, 0xa, 0
ram_error: db "Failed to read ram size", 0xd, 0xa, 0
hex_prefix: db "0x", 0
separator: db 0xd, 0xa, 0

disk_packet:
	.size:		db 16	; size of packet
	.zero:		db 0	; always 0
	.numt:		dw 0	; number of sectors to transfer(max 127?)
	.off:		dw 0	; addr offset
	.seg:		dw 0	; addr segment
	.lba_lo0:	dw 0	; start lba low
	.lba_lo1:	dw 0	; start lba low
	.lba_hi0:	dw 0	; start lba high
	.lba_hi1:	dw 0	; start lba high