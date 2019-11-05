; ------------------------------------------------------------------------------
[bits 16]

STAGE_2_OFFSET equ 0xA000

stage_2:
	cli							; stop intrerupts

	lgdt [GDT_DESCRIPTOR]		; load the global descriptor table 

	mov eax, cr0				; Protected Mode Enable	
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEG:init_protected	; a far jump 

%include "global_descriptor_table.asm"

[bits 32]
init_protected:			; a far jump..., it looks prety close to me
						; flushes CPU pipeline, sets the CS reg
	; I really don't know why I can't set the cs reg manualy
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	call STAGE_2_OFFSET	; here we enter kernel_2

	jmp $	; again, we should never return here 
