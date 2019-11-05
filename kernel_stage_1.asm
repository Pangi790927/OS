; ------------------------------------------------------------------------------
; lba 0
[org 0x7c00]
[bits 16]

stage_1:
	; inits
	mov bp, 0xA000			; 0xA000 - stack for stage_1 and 1/2 of stage_2
	mov sp, bp
	mov [BOOT_DRIVE], dl	; saving the boot drive

	; mov si, STAGE_1_MESSAGE	; stage 1 message
	; call bios_print_const_string
	; call bios_print_end_of_line

	mov bx, STAGE_2_OFFSET	; should retry this 3 fun times, we only try it once
	mov cl, 8				; we are loading from the 7'th sector
	mov dh, 126				; 128 * 512 = 64k bytes, what is DMA error here? 
	mov dl, [BOOT_DRIVE]	; 	are there any computers who might throw it?
	call bios_load_memory	; if it fails it will halt 

	call get_ram_size
	mov word [0x00000500], ax
	mov word [0x00000502], bx

	call get_vesa_info
	call set_vesa_mode

	; entering protected mode, this will call kernel_2 later on
	call stage_2

	; should never reach here 
	jmp $



[bits 16]
%include "get_ram_size.asm"
%include "bios_load_memory.asm"
%include "get_vesa_info.asm"
%include "32_protected_mode.asm"

; For now we don't have enaugh space to have vesa and the printing functions
; so for now we deactivated bios_print
; %include "bios_print.asm"

STAGE_1_MESSAGE:
	db "Stage 1!", 0

BOOT_DRIVE:
	db 0

; 440 to 512 belongs TO MBR
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

; lba 1
; here we are at position 512 and gpt should reside here, till 1024:
gpt_sig:		db "EFI PART"
gpt_rev:		dd 0
gpt_hdr_sz:		dd 92
gpt_hdr_crc:	dd 0
gpt_reserved:	dd 0
gpt_curr:		dq 1
gpt_copy:		dq 1
gpt_first_lba:	dq 3
gpt_last_lba:	dq 0xfffffff
gpt_disk_guid:	dq 0, 0
gpt_start_arr:	dq 2
gpt_part_cnt:	dd 1
gpt_part_sz:	dd 128
gpt_part_crc:	dd 0
gpt_rest:		times 1024-($-$$) db 0 

; lba 2
; first and only partition entry till now
part1_guid:		dq 0, 0	
part1_uniq:		dq 0, 0	
part1_first:	dq 3
part1_last:		dq 0xfffffff	; actually I don't know how big it is
part1_attr:		dq 0
part1_name:		db "Main Partition Name", 0

; lba3
; lba4
; here we have empty space
times 2560-($-$$) db '0'

; lba5
; finaly here our filesystem starts
