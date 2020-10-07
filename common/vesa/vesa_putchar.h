#ifndef VESA_PUTCHAR_H
#define VESA_PUTCHAR_H

#include "mbr_post.h"

namespace vesa {
	using buff_t = char [84][214];
	using font_t = uint32_t[96][9 * 14];

	uint16_t putchar(uint16_t c);
	void init(void *buff, void *font, const vesa_display_t& mode);
}

#endif