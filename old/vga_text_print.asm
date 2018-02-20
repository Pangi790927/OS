[bits 32]

VGA_TEXT_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; esi will store the pointer to the string to be printed
; eax will store the row coord of the screen (0 to 25)
; ebx will store the col coord of the screen (0 to 79)
vga_print_string_at_coords:
	pusha
		mov edi, VGA_TEXT_MEMORY

		mov ecx, 80		;
		mul ecx			; eax = eax * 80	;
		add eax, ebx	; eax = eax + ebx	;	eax = (eax * 80 + ebx) * 2
		mov ecx, 2 		;
		mul ecx 		; eax = eax * 2		;
		
		add edi, eax	; edi = edi = eax

		jmp .while_condition
		.while_start:
			mov al, [esi]
			mov ah, WHITE_ON_BLACK

			mov [edi], ax	; put character on screen
			add edi, 2		; inc ecx to the next character position

			inc esi
		.while_condition:
			mov al, [esi]
			cmp al, 0
			jne .while_start
	popa
	ret
