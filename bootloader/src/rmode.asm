[bits 16]

; DISK FUNCTIONS
; =============================================================================

; $1 - addr off
; $2 - addr seg
; $3 - lba_lo0
; $4 - sect count
; $5 - drive
[global disk_read]
disk_read:
	push bp
	mov bp, sp
	pusha
		; first test for extension presence
		mov ah, 0x41 
		mov bx, 0x55aa
		mov dl, [bp + 14]
		int 0x13
		jc .err_ext

		; now move the data
		mov ax, [bp + 10]
		mov [disk_packet.lba_lo0], ax
		mov ax, [bp + 12]
		mov [disk_packet.numt], ax
		mov ax, [bp + 6]
		mov [disk_packet.off], ax
		mov ax, [bp + 8]
		mov [disk_packet.seg], ax

		mov si, disk_packet
		mov ah, 0x42
		mov dl, [bp + 14]
		int 0x13

		jc .err_load
		jmp .done
		.err_load:
			mov si, load_error
			call bios_print
			jmp .done
		.err_ext:
			mov si, ext_error
			call bios_print
			jmp .done
		.done:
	popa
	pop bp
	ret

; RAM FUNCTIONS
; =============================================================================

; $1 - addr of a ramsize struct
; ramsize - return value
; AX = extended memory between 1M and 16M, in K (max 3C00h = 15MB)
; BX = extended memory above 16M, in 64K blocks 
[global get_ram_size]
get_ram_size:
	; shouldn't I pusha popa?
	push bp
	mov bp, sp
	pusha

	xor cx, cx
	xor dx, dx
	mov ax, 0xE801
	int 0x15
	jc .err

	mov di, [bp + 6]
	cmp ah, 0x86	; unsupported function
	je .err

	cmp ah, 0x80	; invalid command
	je .err

	jcxz .use_eax	; was the CX result invalid?
		
		mov [di], cx
		mov [di + 2], dx

	.use_eax:

	jmp .done
	.err:
		mov word [di], -1
		mov word [di + 2], -2
		mov si, ram_error
		call bios_print
	.done:

	popa
	pop bp
	ret

; PRINT FUNCTIONS
; =============================================================================

; $1 char
[global bios_putchr]
bios_putchr:
	push bp
	mov bp, sp
		push ax
		mov ax, [bp + 6]
		mov ah, 0x0e
		int 0x10
		pop ax
	pop bp
	ret

bios_intern_putchr:
	push bp
	mov bp, sp
		push ax
		mov ah, 0x0e
		int 0x10
		pop ax
	pop bp
	ret

; si - pointer to string
bios_print:
	pusha
		xor bx, bx	; bx = 0
		jmp .while_condition
		.while_start:
			mov al, byte [si + bx]
			call bios_intern_putchr

			add bx, 1
		.while_condition:
			mov cl, byte [si + bx]
			cmp cl, 0
			jne .while_start
	popa
	ret

; ax - number
; bx - base
bios_print_number_base_rec:
	pusha
		cmp ax, 0
		je .if_end; if (ax != 0)
			xor dx, dx ; dx = 0
			; mov ax, ax - number to divide already in ax
			div bx ; dx:ax / bx = ax (reminder dx)
			
			call bios_print_number_base_rec

			push ax	; saving ax and printing the character
			mov di, dx
			mov al, byte [digits + di]
			call bios_intern_putchr
			pop ax ; returning ax
		.if_end:
	popa
	ret

; ax - number 
; bx - base
bios_print_number_base:
	pusha
		cmp ax, 0
		jne .if_else ; if (ax == 0)
			mov al, '0'
			call bios_intern_putchr
		jmp .if_end 
		.if_else:
			; ax, bx already set
			call bios_print_number_base_rec
		.if_end:
	popa
	ret

; ax - number in base 10
bios_putdec:
	pusha
		mov bx, 10
		call bios_print_number_base
	popa
	ret

; ax - number in base 16
bios_puthex:
	pusha
		mov bx, 16
		call bios_print_number_base
	popa
	ret

; INTERN STRUCTURES
; =============================================================================

digits: db '0123456789abcdef'

; error strings:
ext_error: db "Does not have bios load extension", 0xd, 0xa, 0
load_error: db "Failed to load from disk", 0xd, 0xa, 0
ram_error: db "Failed to read ram size", 0xd, 0xa, 0
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