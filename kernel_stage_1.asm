; ------------------------------------------------------------------------------
[org 0x7c00]
[bits 16]

stage_1:
	; inits
	mov bp, 0xa000			; 0xa000 - stack for stage_1 and 1/2 of stage_2
	mov sp, bp
	mov [BOOT_DRIVE], dl	; saving the boot drive

	mov si, STAGE_1_MESSAGE	; stage 1 message
	call bios_print_const_string
	call bios_print_end_of_line

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
%include "32_protected_mode.asm"

STAGE_1_MESSAGE:
	db "Stage 1!", 0

; from 220 to 223 we need to put the timestamp
times 220-($-$$) db 0
db 0x80
db 0x0f
db 0x0f
db 0x0f

[bits 16]
%include "bios_print.asm"

; we are putting the special number in his place
times 510-($-$$) db 0
dw 0xaa55

; the following string has 48 bytes, including the terminator
db "This is a random string on the drive at pos 512", 0

times 1024-($-$$) db 0
