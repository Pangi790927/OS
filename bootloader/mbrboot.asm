; this file is the first thing that the computer runs
; it's structure is:
; 	- code [0:x]
; 	- mbr_opts [x:440]
; 	- normal_mbr [440:512]

; MAIN
; ==============================================================================

[org 0x7c00]
[bits 16]

mov ax, 0x0
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax
jmp 0x0:start

start:

; inits
mov bp, 0x7BF0			; stack for stage_1 and 1/2 of stage_2
mov sp, bp
mov [boot_drive], dl	; saving the boot drive

mov si, printhdr
call bios_print

; print phy address of bootloader after load
mov ax, [boot1_addr]
call bios_puthex
mov si, line_break
call bios_print

; print start lba of bootloader
mov ax, [boot1_lba]
call bios_puthex
mov si, line_break
call bios_print

; print lba count of bootloader
mov ax, [boot1_cnt]
call bios_print_number
mov si, line_break
call bios_print

; print boot drive
xor ax, ax
mov al, [boot_drive]
call bios_puthex
mov si, line_break
call bios_print

mov si, init_str
call bios_print

; load bootloader
call bios_load_memory

mov si, start_boot
call bios_print

; start bootloader
call [boot1_addr]

mov si, cont_err
call bios_print

; should never reach here 
jmp $

; FUNCTIONS
; ==============================================================================

bios_print_char:
	pusha
		mov ah, 0x0e
		int 0x10
	popa
	ret 

; si - pointer to string
bios_print:
	pusha
		xor bx, bx	; bx = 0
		jmp .while_condition
		.while_start:
			mov al, byte [si + bx]
			call bios_print_char

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
			call bios_print_char
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
			call bios_print_char
		jmp .if_end 
		.if_else:
			; ax, bx already set
			call bios_print_number_base_rec
		.if_end:
	popa
	ret

; ax - number in base 10
bios_print_number:
	pusha
		mov bx, 10
		call bios_print_number_base
	popa
	ret

; ax - number in base 10
bios_puthex:
	pusha
		mov bx, 16
		call bios_print_number_base
	popa
	ret

bios_load_memory:
	pusha
		; first test for extension presence
		mov ah, 0x41 
		mov bx, 0x55aa
		mov dl, [boot_drive]
		int 0x13
		jc .err_ext

		; now move the data
		mov ax, [boot1_lba]
		mov [transf_packet.lba_lo0], ax
		mov ax, [boot1_cnt]
		mov [transf_packet.numt], ax
		mov ax, [boot1_addr]
		mov [transf_packet.off], ax

		mov si, transf_packet
		mov ah, 0x42
		mov dl, [boot_drive]
		int 0x13

		jc .err_load
		jmp .done
		.err_load:
			mov si, load_error
			call bios_print
			jmp $
		.err_ext:
			mov si, ext_error
			call bios_print
			jmp $
		.done:
	popa
	ret

; INTERN DATA
; ==============================================================================

digits:		db '0123456789abcdef'

transf_packet:
	.size:		db 16	; size of packet
	.zero:		db 0	; always 0
	.numt:		dw 0	; number of sectors to transfer(max 127?)
	.off:		dw 0	; addr offset
	.seg:		dw 0	; addr segment
	.lba_lo0:	dw 0	; start lba low
	.lba_lo1:	dw 0	; start lba low
	.lba_hi0:	dw 0	; start lba high
	.lba_hi1:	dw 0	; start lba high

printhdr:
	db "================================"
	db 0xd, 0xa, 0x0
line_break:	db 0xd, 0xa, 0x0
load_error:	db "err_load", 0xd, 0xa, 0x0
ext_error:	db "err_ext", 0xd, 0xa, 0x0
init_str:	db "loading_mbr", 0xd, 0xa, 0x0
start_boot:	db "booting", 0xd, 0xa, 0x0
cont_err:	db "error_exit", 0xd, 0xa, 0x0

; EXTERN DATA
; ==============================================================================

; there are some restrictions, bootloader has max 127 sectors
; start address should be an 16bit unsigned
times 400-($-$$) db 0
; mbr_opts (40 bytes max)
boot_drive:		db 0
boot_uid:		dd 0xffbadadd
boot1_addr:		dw 0x7E00
boot2_addr:		dd 0x17E00
boot1_lba:		dw 1
boot1_cnt:		dw 127
boot1_crc:		dd 0
boot2_lba:		dw 128
boot2_cnt:		dw 512
boot2_crc:		dd 0
conf_lba:		dw 640
conf_cnt:		dw 1

; mbr
times 440-($-$$) db 0
mbr_signature1: dd 0x0
mbr_signature2: dw 0x0
mbr_partition1: 
	.bit_field:	db 0
	.sig1:		db 0x14
	.hi_start:	dw 0
	.sys_id:	db 0xEE
	.sig2:		db 0xeb
	.hi_len:	dw 0
	.lo_start:	dd 0
	.lo_len:	dd 0xffffffff
mbr_partition2: times 16 db 0x0
mbr_partition3: times 16 db 0x0
mbr_partition4: times 16 db 0x0
; we are putting the special number in his place
mbr_boot_sig: dw 0xaa55