[org 0x7c00]
[bits 16]

STAGE_2_OFFSET equ 0x1000

stage_1:
	; inits
	mov bp, 0x8000	; 0x8000 to 0xa000 - normal stack
	mov sp, bp
	mov [BOOT_DRIVE], dl	; saving the boot drive

	
	
	; should never reach here 
	jmp $

; we are putting the special number in his place
times  510-($-$$) db 0
dw 0xaa55