#ifndef VESA_BIOS_H
#define VESA_BIOS_H

#include "types.h"

struct vesa_info_t {
	union {
		struct {
			char		sig[4];				// == "VESA"
			uint16_t	version;			// 0x0300 for VBE 3.0
			uint16_t 	oem_str_ptr[2];		// isa vbeFarPtr
			uint8_t		capabilities[4];
			uint16_t	vide_mode_ptr[2];	// isa vbeFarPtr
			uint16_t	total_mem;			// as # of 64KB blocks	
		};
	};
	char data[512];
} __attribute__((packed));

#define VESA_MODE_SUPPORTED		0b0000'0000'0000'0001
#define VESA_TTY_SUPPORTED		0b0000'0000'0000'0100
#define VESA_COLOR_MODE			0b0000'0000'0000'1000
#define VESA_GRAPHICS_MODE		0b0000'0000'0001'0000
#define VESA_NOT_VGA_COMPATIBLE	0b0000'0000'0010'0000
#define VESA_LINEAR_FBUFFER		0b0000'0000'1000'0000

struct vesa_mode_t {
	uint16_t	attr;
	uint8_t		win_a_attr;
	uint8_t		win_b_attr;
	uint16_t 	granularity;
	uint16_t	winsize;
	uint16_t	seg_a;
	uint16_t	seg_b;
	uint16_t	win_fn_ptr[2];
	uint16_t	pitch;			// bytes_per_scan_line

	uint16_t	width;
	uint16_t	height;
	uint8_t		x_char_size;
	uint8_t		y_char_size;
	uint8_t		plane_cnt;
	uint8_t		bpp;
	uint8_t		bank_cnt;
	uint8_t		memory_model;
	uint8_t		bank_size;
	uint8_t		inage_pages_cnt;
	uint8_t		reserved0;

	uint8_t		res_mask;
	uint8_t		red_position;
	uint8_t		green_mask;
	uint8_t		green_position;
	uint8_t		blue_mask;
	uint8_t		blue_position;
	uint8_t		reserved_mask;
	uint8_t		reserved_position;
	uint8_t		directcolor_attr;

	uint32_t	physbase;
	uint32_t	reserved1;
	uint16_t	reserved2;
} __attribute__((packed));

struct vesa_mode_buff_t {
	union {
		vesa_mode_t info;
	};
	char data[256];
} __attribute__((packed));

uint16_t vesa_info_get(vesa_info_t *addr);
uint16_t vesa_mode_get(vesa_mode_buff_t *addr, uint16_t mode);
uint16_t vesa_mode_set(uint16_t mode, bool use_lfb);

inline void vesa_fit_point(vesa_mode_t *mode, int &x, int &y) {
	if (x < 0)
		x = 0;
	if (x >= mode->width)
		x = mode->width - 1;
	if (y < 0)
		y = 0;
	if (y >= mode->height)
		y = mode->height - 1;
}

inline void put_pixel(vesa_mode_t *mode, int x, int y, uint32_t color) {
	vesa_fit_point(mode, x, y);
	uint32_t pixel_offset = y * mode->pitch + (x * (mode->bpp / 8)) +
		mode->physbase;
	*(uint32_t *)pixel_offset = color;
}

// inline void fill_rect(vesa_mode_t *mode, int x, int y, int dx, int dy,
// 		uint32_t color)
// {
// 	int ex = x + dx - 1, ey = y + dy - 1;
// 	vesa_fit_point(mode, x, y);
// 	vesa_fit_point(mode, ex, ey);
// 	if (x > ex)
// 		return ;
// 	if (y > ey)
// 		return ;
// 	uint32_t *base = (uint32_t *)mode->physbase;
// 	uint32_t bypp = mode->bpp / 8;
// 	uint32_t line_width = mode->pitch / bypp;
// 	for (int i = y; i <= ey; i++){
// 		// DBG("i: %d", ex - x + 1);
// 		uint32_memset(base + i * line_width + x, color, ex - x + 1);
// 	}
// }

// inline void move_rect(vesa_mode_t *mode, int x, int y, int nx, int ny,
// 		int dx, int dy)
// {
// 	vesa_fit_point(mode, x, y);
// 	vesa_fit_point(mode, nx, ny);

// 	int end_x = x + dx - 1;
// 	int end_y = y + dy - 1;

// 	vesa_fit_point(mode, end_x, end_y);

// 	dx = end_x - x + 1;
// 	dy = end_y - y + 1;

// 	int end_nx = nx + dx - 1;
// 	int end_ny = ny + dy - 1;
	
// 	vesa_fit_point(mode, end_nx, end_ny);

// 	int dnx = end_nx - nx + 1;
// 	int dny = end_ny - ny + 1;

// 	if (dnx < dx)
// 		dx = dnx;
// 	if (dny < dy)
// 		dy = dny;

// 	// DBG("dx: %d dy: %d", dx, dy);
// 	int i;
// 	uint32_t *base = (uint32_t *)mode->physbase;
// 	uint32_t bypp = mode->bpp / 8;
// 	uint32_t line_width = mode->pitch / bypp;
// 	if (ny > y && ny < y + dy) {
// 		i = dy - 1;
// 		while (i >= ny - y) {
// 			memmove(base + (ny + i) * line_width + nx, 
// 					base + (y + i) * line_width + x, dx);
// 			i--;
// 		}
// 		dy = ny - y;
// 	}
// 	i = 0;
// 	while (i < dy) {
// 		memmove(base + (ny + i) * line_width + nx, 
// 				base + (y + i) * line_width + x, dx);
// 		i++;
// 	}
// }

// inline void copy_rect(vesa_mode_t *mode, int x, int y, int dx, int dy,
// 		uint32_t *src)
// {
// 	vesa_fit_point(mode, x, y);

// 	int ex = x + dx - 1;
// 	int ey = y + dy - 1;

// 	vesa_fit_point(mode, ex, ey);

// 	dx = ex - x + 1;
// 	dy = ey - y + 1;

// 	uint32_t *base_dst = (uint32_t *)mode->physbase;
// 	uint32_t bypp = mode->bpp / 8;
// 	uint32_t line_width = mode->pitch / bypp;

// 	for (int i = y; i <= ey; i++) {
// 		memcpy(base_dst + i * line_width + x, src + (i - y) * dx, dx);
// 	}
// }

#endif