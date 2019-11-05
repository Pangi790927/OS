; will write vesa information at location 0x1000 in ram
; at 0x1000:0x11FF vesa bios info 
; 0x1200:0x1FFF 8 diffrent modes that this computer supports
; 0x504:0x506 mod count
get_vesa_info:
	pusha
	.get_vesa_bios_info:
		mov ax, 0x4F00		; set function code
		mov di, 0x1000		
		int 0x10			; call the interupt

		cmp ax, 0x4f		; check for errors
		jne .err

		mov ax, [di + 14]	; save both offset
		mov si, ax
		mov ax, [di + 16]	; and segment location of video modes list
		mov fs, ax

	.get_vesa_mode_info:
		mov di, 0x1200		; the start of info mode blocks
		mov bx, 0

		.loop_body:
			mov dx, [fs:si] 	; get the first video mode
			add si, 2			; prepare for the next video mode
			
			cmp dx, 0xFFFF		; end of modes?
			je .done

			mov ax, 0x4F01		; get vesa mode info function
			mov cx, dx			; move the mode in cx
								; di should already be set
			int 0x10			; call the interrupt

			cmp ax, 0x4f		; check for errors
			jne .err

			and word [di], 0x80	; we are not interested in those modes that are 
			jz .loop_body		; not linear 
			mov [di + 2], dx	; set the mode in the structure as we will need
								; it
			call set_vesa_mode	; in dx we have the mode and we will use it 
								; in this function to set this mode

			add di, 0x100		; increment the saved position
			inc bx

			cmp di, 0x6000		; if we completed all the 8 options
			jne .loop_body

		.done:
		mov [0x504], bx
		jmp .return

	.err:
		mov ax, [vesa_err_code]
		mov bx, [vesa_err_code + 2]
		mov [0x1000], ax
		mov [0x1000 + 2], bx
		jmp .return

	.return:
		mov ax, 0			; restore fs to 0 as it should be
		mov fs, ax
		mov es, ax
		popa
		ret

vesa_err_code:
	db "NONE"

set_vesa_mode:
	pusha
		cmp word [di + 18], 800
		jne .done 
		cmp word [di + 20], 600
		jne .done

		mov [0x506], dx

		mov bx, dx
		or bx, 0x4000
		mov ax, 0x4F02
		int 0x10		
		.done:
	popa
	ret

; this bearly fits here, less then 10 bytes away from the limit 
