; ------------------------------------------------------------------------------
[org 0x7c00]
[bits 16]

stage_1:
	; inits
	mov bp, 0xA000			; 0xA000 - stack for stage_1 and 1/2 of stage_2
	mov sp, bp
	mov [BOOT_DRIVE], dl	; saving the boot drive

	mov si, STAGE_1_MESSAGE	; stage 1 message
	call bios_print_const_string
	call bios_print_end_of_line

	mov bx, STAGE_2_OFFSET	; should retry this 3 fun times, we only try it once
	mov cl, 3				; we are loading from the third sector
	mov dh, 126				; 128 * 512 = 64k bytes, what is DMA error here? 
	mov dl, [BOOT_DRIVE]	; 	are there any computers who might throw it?
	call bios_load_memory	; if it fails it will halt 

	call get_ram_size
	mov word [0x00000500], ax
	mov word [0x00000502], bx
	
	; entering protected mode, this will call kernel_2 later on
	call stage_2

	; should never reach here 
	jmp $

BOOT_DRIVE:
	db 0

%include "get_ram_size.asm"
%include "32_protected_mode.asm"

STAGE_1_MESSAGE:
	db "Stage 1!", 0

; from 220 to 223 we need to put the timestamp of the MBR
times 220-($-$$) db 0
db 0x80
db 0x0f
db 0x0f
db 0x0f

[bits 16]
%include "bios_print.asm"
%include "bios_load_memory.asm"

; we are putting the special number in his place
times 510-($-$$) db 0
dw 0xaa55

; the following string has 48 bytes, including the terminator
db "This is a random string on the drive at pos 512", 0

times 1024-($-$$) db 0
