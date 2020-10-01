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
			call intern_print
			mov word [err_code], 1
			jmp .done
		.err_ext:
			mov esi, ext_error
			call intern_print
			mov word [err_code], 2
			jmp .done
		.done:
	popa
	mov eax, [err_code]
	pop ebp
	ret

err_code: dd 0

; PROTECTED MODE FUNCTIONS
; =============================================================================

; $1 - gdt desc		+ 8
; $2 - code sel		+ 12
; $3 - code addr	+ 16
; $4 - data sel		+ 20
[global load_prot_mode]
load_prot_mode:
	push ebp
	mov ebp, esp
	pusha
		cli

		xor eax, eax
		xor ebx, ebx

		mov edi, [ebp + 8]
		lgdt [edi]

		mov cx, [ebp + 20]			; new DS
		mov bx, [ebp + 12]			; new CS
		mov eax, load_prot_mode32	; new IP

		push bx						; push new CS
		push ax						; push new IP

		mov esi, entry_prot
		call intern_print

		in al, 0x92					; code to disable a20 line
		or al, 2					;
		out 0x92, al				;

		mov eax, cr0				; Protected Mode Enable	
		or eax, 0x1
		mov cr0, eax

		retf						; Sneaky far jump
	popa
	pop ebp
	ret

[bits 32]
load_prot_mode32:
	mov ds, cx
	mov ss, cx
	mov es, cx
	mov fs, cx
	mov gs, cx

	mov edi, [ebp + 16]
	mov esp, edi
	sub esp, 4
	mov ebp, esp

	jmp edi

	jmp $
[bits 16]


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
		call intern_print
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

bios_intern_putchr:
	push ebp
	mov bp, sp
		push eax
		mov ah, 0x0e
		int 0x10
		pop eax
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

; INTERN STRUCTURES
; =============================================================================

digits: db '0123456789abcdef'

; strings:
ext_error: db "Does not have bios load extension", 0xd, 0xa, 0
load_error: db "Failed to load from disk", 0xd, 0xa, 0
ram_error: db "Failed to read ram size", 0xd, 0xa, 0
entry_prot: db "======== Will enter protected mode ========", 0xd, 0xa, 0
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