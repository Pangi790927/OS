; a special folder and a special file for a line
[global check_A20_on]
check_A20_on: 
	pushad
		mov edi, 0x112345	;odd megabyte address.
		mov esi, 0x012345	;even megabyte address.
		
		mov [esi],esi		;making sure that both addresses contain diffrent values.
		mov [edi],edi		;(if A20 line is cleared the two pointers would point to the address 0x012345 that would contain 0x112345 (edi)) 
		
		cmpsd				;compare addresses to see if the're equivalent.
		mov eax, 0
		jne .A20_on			;if not equivalent , A20 line is set.
			mov eax, 1
		.A20_on:
	popad
	ret

[global enable_A20]
enable_A20:
	pushad
		in al, 0x92
		or al, 2
		out 0x92, al
	popad
	ret