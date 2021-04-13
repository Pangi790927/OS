ENTRY(kernel2)
SECTIONS
{
	.text.start(0xc0000000) : {
		*(.text)
	}

	.text BLOCK(4K) : ALIGN(4K) {
		*(.text)
	}

	.data BLOCK(4K) : ALIGN(4K) {
		*(.data)
		*(.bss*)
	}
}
