#ifndef VESA_PUTCHAR_H
#define VESA_PUTCHAR_H

#include "mbr_post.h"

namespace vesa {
	uint16_t putchar(uint16_t c);
	void init(void *buff, void *font, const vesa_display_t& mode);
}

#endif