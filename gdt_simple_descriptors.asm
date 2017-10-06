gdt_start:

gdt_null:
	dd 0x0
	dd 0x0

gdt_code_segment:
	dw 0xffff		; limit bits (0 - 15)
	dw 0x0			; base bits (0 - 15)
	db 0x0			; base bits (16 - 23)
	db 10011010b	; flags part 1, type flags 
	db 11001111b	; flags part 2, limit bits (16 - 19)
	db 0x0			; base bits (24 - 31)

gdt_data_segment:
	dw 0x1000		; limit bits (0 - 15)
	dw 0x0			; base bits (0 - 15)
	db 0x0			; base bits (16 - 23)
	db 10010010b	; flags part 1, type flags	-- 	one bit diference to code segment 
	db 11000001b	; flags part 2, limit bits (16 - 19)
	db 0x0			; base bits (24 - 31)
	
gdt_end:

gdt_descriptor:
	dw gdt_end - gdt_start - 1	; size of gdt - 1
	dd gdt_start 				; address of gdt

CODE_SEG equ gdt_code_segment - gdt_start
DATA_SEG equ gdt_data_segment - gdt_start
