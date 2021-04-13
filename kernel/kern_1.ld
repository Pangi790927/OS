ENTRY(kernel1)
SECTIONS
{
	.text.start(0x100000) : {
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
