SECTIONS
{
	.text.start(0x7E00) : {
		bootcall_1(.text)
	}

	.text BLOCK(4K) : ALIGN(4K) {
		*(.text)
	}

	.data BLOCK(4K) : ALIGN(4K) {
		*(.data)
		*(.bss*)
	}
}
