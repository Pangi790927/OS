; al - character
bios_print_character:		
	pusha
		mov ah, 0x0e
		int 0x10
	popa
	ret 

; si - pointer to string
bios_print_const_string:
	pusha
		xor bx, bx	; bx = 0
		jmp .while_condition
		.while_start:
			mov al, byte [si + bx]
			call bios_print_character

			add bx, 1
		.while_condition:
			mov cl, byte [si + bx]
			cmp cl, 0
			jne .while_start
	popa
	ret

; ax - number
; bx - base
bios_print_number_base_rec:
	pusha
		cmp ax, 0
		je .if_end; if (ax != 0)
			xor dx, dx ; dx = 0
			; mov ax, ax - number to divide already in ax
			div bx ; dx:ax / bx = ax (reminder dx)
			
			call bios_print_number_base_rec

			push ax	; saving ax and printing the character
			mov di, dx
			mov al, byte [digits + di]
			call bios_print_character
			pop ax ; returning ax
		.if_end:
	popa
	ret

; ax - number 
; bx - base
bios_print_number_base:
	pusha
		cmp ax, 0
		jne .if_else ; if (ax == 0)
			mov al, '0'
			call bios_print_character
		jmp .if_end 
		.if_else:
			; ax, bx already set
			call bios_print_number_base_rec
		.if_end:
	popa
	ret

; ax - number in base 10
bios_print_number:
	pusha
		mov bx, 10
		call bios_print_number_base
	popa
	ret

bios_print_end_of_line:
	pusha
		mov si, end_of_line
		call bios_print_const_string
	popa
	ret

end_of_line:
	db 0x0d, 0x0a, 0

digits:
	db '0123456789abcdef'
