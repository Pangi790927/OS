ENTRY(kernel_3)

SECTIONS
{
	. = 0xc1000000;

	.text BLOCK(4K) : ALIGN(4K)
	{
		*(.text)
	}

	.rodata BLOCK(4K) : ALIGN(4K)
	{
		*(.rodata)
	}

	.data BLOCK(4K) : ALIGN(4K)
	{
		*(.data)
	}

	.bss BLOCK(4K) : ALIGN(4K)
	{
		*(.bss)
	}

	.ctors BLOCK(4K) : ALIGN(4K)
	{
		*(.ctors)
	}

	.dtors BLOCK(4K) : ALIGN(4K)
	{
		*(.dtors)
	}

	.init_array BLOCK(4K) : ALIGN(4K)
	{
		*(.init)
	}

	.fini_array BLOCK(4K) : ALIGN(4K)
	{
		*(.fini)
	}
}
