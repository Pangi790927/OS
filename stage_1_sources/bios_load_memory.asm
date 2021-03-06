; ------------------------------------------------------------------------------
; dh - sectors to read
; cl - the starting sector 
; ch - cylinder number
; bx - where to read the data to
; dl - the boot drive 
bios_load_memory:
	push bp
	mov bp, sp
	pusha
		push dx		;	reading the disk
			mov ah, 2	;	bios read interupt
			mov al, dh	;	sectors to read
			mov dh, 0	;	use head 0

			; will asume 512 sector size because that's what some 
			; guy on google said (i feel a litle deja vu)

			int 0x13	;	isue BIOS interupt
			jc .error	;	if carry flag set error occured 
		pop dx

		cmp dh, al		;	if it didn't read as many sectors as we wanted
		jne .error
		jmp .end

		.error:
			; mov si, LOAD_ERROR_MESSAGE
			; call bios_print_const_string
			; call bios_print_end_of_line
			
			jmp $		;	halt
		.end:
	popa
	pop bp
	ret

LOAD_ERROR_MESSAGE:
	db "Could not read sectors from memory", 0

