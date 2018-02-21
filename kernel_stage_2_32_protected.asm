; ------------------------------------------------------------------------------
[bits 16]

STAGE_2_OFFSET equ 0x1000

stage_2:
	cli							; stop intrerupts

	lgdt [GDT_DESCRIPTOR]		; load the global descriptor table 

	mov eax, cr0				; Protected Mode Enable	
	or eax, 0x1
	mov cr0, eax

	jmp CODE_SEG:init_protected	; a far jump 

[bits 32]
init_protected:			; a far jump..., it looks prety close to me
	mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	; finaly ebp, this also means that our stack moved 
	mov ebp 0x90000
	mov esp, ebp

	call STAGE_2_OFFSET	; here we enter kernel_2

	jmp $	; again, we should never return here 