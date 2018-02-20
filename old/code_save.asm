	; mov ax, 0xfff
	; mov bx, 0x10
	; call print_number_base
	; call print_end_of_line

	; mov di, dx	; save the start of stack
	; ; while start
	; jmp .while_condition
	; .while_start:
	; 	call key_wait_input

	; 	; mov ah, 0
	; 	; call print_number

	; 	; mov si, separator_msg
	; 	; call print_const_string
	; 	call push_byte
	; 	call print_character
	; 	;
	; .while_condition:
	; 	cmp al, 13
	; 	jne .while_start
	; ; while end
	; push 0

	; mov al, 0
	; call push_byte

	; call print_end_of_line

	; mov si, di
	; call print_const_string
	; call print_end_of_line

	; mov si, input_msg
	; call print_const_string	
	; call print_end_of_line

	; mov si, end_input_msg
	; call print_const_string
	; call print_end_of_line
push_byte:
	push bp
	push sp
		mov si, dx
		mov byte [si], al
		inc dx
	pop sp
	pop bp
	ret

pop_byte:
	push bp
	push sp
		dec dx
		mov si, dx
		mov al, byte [si]
	pop sp
	pop bp
	ret

end_input_msg:
	db "End of input phase", 0
	
input_msg:
	db "Input msg", 0
mov sp, bp
	mov dx, 0xa000	; 0xa000 to 0xc000 - secondary byte stack

byte_stack_start:
	dw 0xa000

