SECTIONS
{
	.text.start(0x17E00) : {
		bootcall_2(.text)
	}

	.text BLOCK(4K) : ALIGN(4K) {
		*(.text)
	}

	.data BLOCK(4K) : ALIGN(4K) {
		*(.data)
		*(.bss*)
	}
}
