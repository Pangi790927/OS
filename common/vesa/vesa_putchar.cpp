#include "vesa_putchar.h"
#include "char_pixel_font.h"
#include "mem_mappings.h"
#include "dbg.h"

namespace vesa {

static bool was_init = 0;
static int row = 0;
static int col = 0;
static int char_x;
static int char_y;
static int max_w, max_h;
static vesa_display_t mode;
static buff_t *buff;
static font_t *font;
static uint32_t line_buff[14 * 1920];

inline static void	*memset(void *s, int c, size_t n)
{
	size_t	i;

	i = 0;
	while (i < n)
	{
		*((char *)s + i) = c;
		i++;
	}
	return (s);
}



inline static void	*memcpy(void *dest, const void *src, size_t n)
{
	size_t	i;

	i = 0;
	while (i < n)
	{
		*((char *)dest + i) = *((char *)src + i);
		i++;
	}
	return (dest);
}


void init(void *buff_mem, void *font_mem, const vesa_display_t& _mode) {
	if (was_init)
		return ;
	mode = _mode;
	DBG("Init vesa: WxH: %dx%d, bpp %d, pitch: %d",
			mode.width, mode.height, mode.bpp, mode.pitch);
	was_init = true;
	char_x = 9;
	char_y = 14;

	buff = (buff_t *)buff_mem;
	font = (font_t *)font_mem;

	max_w = mode.width / char_x;
	max_h = mode.height / char_y;
	memset(buff, 0, sizeof(buff_t));
	memset(line_buff, 0, sizeof(line_buff));
	for (int c = 0; c < 95; c++) {
		for (int i = 0; i < char_y; i++) {
			for (uint8_t j = 0; j < char_x; j++) {
				bool fill_pixel = false;
				if (i < char_y - 1 && j < char_x - 1)
					fill_pixel = pixel_chars[c][i] & (1 << j);
				(*font)[c][(8 - j) + (13 - i) * char_x] = 0xffffff * fill_pixel;
			}
		}
	}
}

static void put_char(int row, int col, char c) {
	if (c < 32 || c > 126)
		return ;
	if (row < 0 || row >= max_h || col < 0 || col >= max_w)
		return ;
	c -= 32;
	(*buff)[row][col] = c;
	int off_w = col * char_x;
	char *base = (char *)line_buff;
	for (int i = 0; i < char_y; i++) {
		char *dst_line = base +
				(i * mode.width + off_w) * sizeof(uint32_t);
		char *src_line = (char *)((*font)[(int)c]) +
				i * sizeof(uint32_t) * char_x;
		memcpy(dst_line, src_line, sizeof(uint32_t) * char_x);
	}
}

static void flush_line() {
	int off_h = row * char_y;
	char *dst = (char *)mode.physbase + off_h * mode.width * sizeof(uint32_t);
	memcpy(dst, line_buff, mode.width * char_y * sizeof(uint32_t));
	memset(line_buff, 0, sizeof(line_buff));
}

static void scroll() {
	memcpy((char *)buff, (char *)buff + max_w, max_w * (max_h - 1));
	
	uint32_t *base = (uint32_t *)mode.physbase;
	memcpy((char *)base, (char *)base + mode.width * char_y * 4, 
			(mode.width * mode.height - mode.width * char_y) * 4);

	memset((char *)base + (mode.width * mode.height - mode.width * char_y) * 4,
			0, mode.width * char_y * 4);
	memset(line_buff, 0, sizeof(line_buff));

	row--;
	if (row < 0)
		row = 0;
}

uint16_t putchar(uint16_t c) {
	bool can_print = true;
		
	if (c == '\n') {
		flush_line();
		row++;
		col = 0;
		can_print = false;
	}

	if (c == '\t') {
		row = (col + 4) & ~(4 - 1);;
		can_print = false;
	}

	if (c == '\r') {
		col = 0;
		can_print = false;
	}

	if (col >= max_w) {
		flush_line();
		row += col / max_w;
		col = 0;
	}

	while (row >= max_h) {
		scroll();
	}
	
	if (can_print) {
		put_char(row, col, c);
		col++;
	}
	return 0;
}

} // namespace vesa