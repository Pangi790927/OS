[bits 32]
BEGIN_PROTECTED_MODE:

	mov esi, PROTECTED_HELLO
	mov eax, 2	; row
	mov ebx, 0	; col
	call vga_print_string_at_coords

	jmp $	; inf loop in protected mode (we don't want to ever get out of here)

%include "vga_text_print.asm"

; string definitions
;---------------------------------------------------------------
PROTECTED_HELLO:
	db "Hello, I am now in protected mode", 0