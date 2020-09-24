// TO DO: uncoment when ready to move in kernel
// #include "vesa_putchar.h"
// #include "char_pixel_font.h"
// #include "mem_mappings.h"

// using buff_t = char [84][214];
// using font_t = uint32_t[96][9 * 14];

// static bool was_init = 0;
// static int row = 0;
// static int col = 0;
// static int char_x;
// static int char_y;
// static int max_w, max_h;
// static vesa_mode_t mode;
// static buff_t *buff;
// static font_t *font;

// static void	*memcpy(void *dest, const void *src, size_t n)
// {
// 	size_t	i;

// 	i = 0;
// 	while (i < n)
// 	{
// 		*((char *)dest + i) = *((char *)src + i);
// 		i++;
// 	}
// 	return (dest);
// }


// static void init() {
// 	if (was_init)
// 		return ;
// 	was_init = true;
// 	char_x = 9;
// 	char_y = 14;
// 	buff = (buff_t *)VESA_PUTCHAR_BUFF_START;
// 	font = (font_t *)VESA_PUTCHAR_FONT_START;
// 	max_w = mode.width / char_x;
// 	max_h = mode.height / char_y;
// 	for (int i = 0; i < max_h; i++)
// 		for (int j = 0; j < max_w; j++)
// 			(*buff)[i][j] = 0;
// 	for (int c = 0; c < 95; c++) {
// 		for (int i = 0; i < char_y; i++) {
// 			for (uint8_t j = 0; j < char_x; j++) {
// 				bool fill_pixel = false;
// 				if (i < char_y - 1 && j < char_x - 1)
// 					fill_pixel = pixel_chars[c][i] & (1 << j);
// 				(*font)[c][(8 - j) + (13 - i) * char_x] = 0xffffff * fill_pixel;
// 			}
// 		}
// 	}
// }

// static void put_char_at(int row, int col, char c) {
// 	if (c < 32 || c > 126)
// 		return ;
// 	if (row < 0 || row >= max_h || col < 0 || col >= max_w)
// 		return ;
// 	c -= 32;
// 	(*buff)[row][col] = c;
	
// 	int off_h = row * char_y;
// 	int off_w = col * char_x;
// 	char *base = (char *)mode.physbase;
// 	for (int i = 0; i < char_y; i++) {
// 		char *dst_line = base +
// 				((off_h + i) * mode.width + off_w) * sizeof(uint32_t);
// 		char *src_line = (char *)((*font)[(int)c]) +
// 				i * sizeof(uint32_t) * char_x;
// 		// int test_buff[char_x] = {0xffff33};
// 		memcpy(dst_line, src_line, sizeof(uint32_t) * char_x);
// 	}
// 	// for (int i = 0; i < char_y; i++) {
// 	// 	for (uint8_t j = 0; j < char_x; j++) {
// 	// 		bool fill_pixel = false;
// 	// 		if (i < char_y - 1 && j < char_x - 1)
// 	// 			fill_pixel = pixel_chars[(int)c][i] & (1 << j);
// 	// 		put_pixel(&mode, off_w + 8 - j, off_h + 13 - i,
// 	// 				0x00ffffff * fill_pixel);
// 	// 	}
// 	// }
// }

// static void vesa_scroll() {
// 	memcpy((char *)buff, (char *)buff + max_w, max_w * (max_h - 1));
	
// 	uint32_t *base = (uint32_t *)mode.physbase;
// 	memcpy((char *)base, (char *)base + mode.width * char_y * 4, 
// 			(mode.width * mode.height - mode.width * char_y) * 4);
	
// 	for (int j = 0; j < max_w; j++)
// 		put_char_at(max_h - 1, j, ' ');

// 	row--;
// 	if (row < 0)
// 		row = 0;
// }

// void vesa_set_putchar_mode(const vesa_mode_t& _mode) {
// 	mode = _mode;
// }

// uint16_t vesa_putchar(uint16_t c) {
// 	if (!was_init)
// 		init();
// 	bool can_print = true;
		
// 	if (c == '\n') {
// 		row++;
// 		col = 0;
// 		can_print = false;
// 	}

// 	if (c == '\t') {
// 		row = (col + 4) & ~(4 - 1);;
// 		can_print = false;
// 	}

// 	if (c == '\r') {
// 		col = 0;
// 		can_print = false;
// 	}

// 	if (col >= max_w) {
// 		row += col / max_w;
// 		col = 0;
// 	}

// 	while (row >= max_h) {
// 		vesa_scroll();
// 	}
	
// 	if (can_print) {
// 		put_char_at(row, col, c);
// 		col++;
// 	}
// 	return 0;
// }