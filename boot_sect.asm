[org 0x7c00]
[bits 16]

KERNEL_OFFSET equ 0x1000
	; start of the OS
os:
	; ax, bx, cx - general registers - used as parameters
	; si, di - general pointers - used as parameters
	; dx - byte stack
	; bp, sp - general stack
	; ip - instruction pointer
	; cd, ds, es, ss - used for memory calling
	
	; inits 
	mov bp, 0x8000	; 0x8000 to 0xa000 - normal stack
	mov sp, bp
	mov [BOOT_DRIVE], dl	; saving the boot drive

	; start message
	mov si, bios_os_start_msg
	call bios_print_const_string
	call bios_print_end_of_line

	; proving hdd capabilities
	mov bx, 0x9000	; address to load to
	mov cl, 2		; where to read from
	mov dh, 5		; how much to load 
	mov dl, [BOOT_DRIVE]
	call bios_load_memory

	mov si, 0x9000
	call bios_print_const_string
	call bios_print_end_of_line

	; loading the kernel
	mov si, bios_load_kernel
	call bios_print_const_string
	call bios_print_end_of_line

	mov bx, KERNEL_OFFSET
	mov cl, 3		; the first sector is the boot loader and the second is trash
	mov dh, 54		; 54 * 512 = 27648 bytes (28672 + boot sector and trash)
	mov dl, [BOOT_DRIVE]
	call bios_load_memory

	; start the protected mode and starts the kernel
	call switch_to_protected_mode
	
jmp $ ; halt the OS
	
 	; function definitions
%include "BIOS_print_routines.asm"
%include "gdt_simple_descriptors.asm"
%include "protected_mode.asm"

[bits 16]
switch_to_protected_mode:
	cli

	lgdt [gdt_descriptor]

	mov eax, cr0
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEG:init_protected ; far jump to update cpu cache

[bits 32]
init_protected:
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000
	mov esp, ebp

	call BEGIN_PROTECTED_MODE

; remembers in 'al' pressed keyboard key
; bios_key_wait_input:
; 	push bp
; 	push sp
; 		mov ah, 0x10
; 		int 0x16
; 	pop sp
; 	pop bp
; 	ret

; dh sectors to read
; cl start sector
bios_load_memory:
	push bp
	push sp
		push dx ; reading the disk
			mov ah, 2 	; bios read intrerupt
			mov al, dh 	; sectors to read
			mov ch, 0 	; start from cylinder 0
			mov dh, 0	; use head 0, the 

						; will asume 512 sector size becaus thats what some guy on google said
			;mov cl,para; start reading from sector cl (our sector, boot loader, is 1)

			int 0x13	; isue bios intrerupt

			jc .error	; jump if error is met (it is set in carry flag)
		pop dx

		cmp dh, al	; if it didn't read as many sectors as we wanted
		jne .error

		jmp .end
		.error:
			mov si, bios_load_error_msg
			call bios_print_const_string
			call bios_print_end_of_line			
		.end:
	pop sp
	pop bp
	ret

	; declarations of constants 										
bios_os_start_msg:
	db "Booting the OS ...", 0

bios_load_kernel:
	db "Loading the kernel from disk ...", 0

; bios_hello_msg:
; 	db "Hello user", 0

; bios_separator_msg:
; 	db " - ", 0

bios_load_error_msg:
	db "Could not read sectors from memory", 0

BOOT_DRIVE:
	db 0

	; special number for bios
times  510-($-$$) db 0
dw 0xaa55

db "This string is on the drive ...", 0	; this string has 16 bytes

times  1024-($-$$) db 0
