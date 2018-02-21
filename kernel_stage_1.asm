; ------------------------------------------------------------------------------
[org 0x7c00]
[bits 16]

stage_1:
	; inits
	mov bp, 0x8000	; 0x8000 to 0xa000 - stack for stage_1 and 1/2 of stage_2
	mov sp, bp
	mov [BOOT_DRIVE], dl	; saving the boot drive

	mov bx, STAGE_2_OFFSET	
	mov cl, 3				; we are loading from the third sector
	mov dh, 54				; 54 * 512 = 27648 bytes 
	mov dl, [BOOT_DRIVE]
	call bios_load_memory	; if it fails it will halt 

	; entering protected mode, this will call kernel_2 later on
	call stage_2

	; should never reach here 
	jmp $

BOOT_DRIVE:
	db 0

%include "bios_load_memory.asm"
%include "kernel_stage_2_32_protected.asm"

; we are putting the special number in his place
times  510-($-$$) db 0
dw 0xaa55

; the following string has 48 bytes, including the terminator
db "This is a random string on the drive at pos 512", 0

times 1024-($-$$) db 0
