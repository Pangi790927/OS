#ifndef VBE_H
#define VBE_H

#include "Types.h"

/* function 1: get VESA BIOS Information */
struct __attribute__ ((packed)) vbe_info_t {
	char sig[4];				// must be "VESA" to indicate valid VBE support
	uint16 ver;					// VBE ver; high is major version, low minor
	uint32 oem;					// segment:offset pointer to OEM
	uint32 capab;				// bitfield that describes card capabilities
	uint32 vmode;				// segment:offset pointer to list of supported video modes
	uint16 vmem;				// amount of video memory in 64KB blocks
	uint16 rev;					// software revision
	uint32 vendor;				// segment:offset to card vendor string
	uint32 prod_name;			// segment:offset to card model name
	uint32 prod_rev;			// segment:offset pointer to product revision
	char reserved[222];			// reserved for future expansion
	char oem_data[256];			// OEM BIOSes store their strings in this area
};

/* function 1: get VESA mode Information */
struct __attribute__ ((packed)) vbe_mode_info_t {
	uint16 attributes;		// deprecated, only bit 7 should be of interest to you, and it indicates the mode supports a linear frame buffer.
	// uint8 window_a;			// deprecated
	// uint8 window_b;			// deprecated
	uint16 mode;			// we store the mode in it now
	uint16 granularity;		// deprecated; used while calculating bank numbers
	uint16 window_size;
	uint16 segment_a;
	uint16 segment_b;
	uint32 win_func_ptr;		// deprecated; used to switch banks from protected mode without returning to real mode
	uint16 pitch;			// number of bytes per horizontal line
	uint16 width;			// width in pixels
	uint16 height;			// height in pixels
	uint8 w_char;			// unused...
	uint8 y_char;			// ...
	uint8 planes;
	uint8 bpp;			// bits per pixel in this mode
	uint8 banks;			// deprecated; total number of banks in this mode
	uint8 memory_model;
	uint8 bank_size;		// deprecated; size of a bank, almost always 64 KB but may be 16 KB...
	uint8 image_pages;
	uint8 reserved0;
 
	uint8 red_mask;
	uint8 red_position;
	uint8 green_mask;
	uint8 green_position;
	uint8 blue_mask;
	uint8 blue_position;
	uint8 reserved_mask;
	uint8 reserved_position;
	uint8 direct_color_attributes;
 
	uint32 framebuffer;		// physical address of the linear frame buffer; write here to draw to the screen
	uint32 off_screen_mem_off;
	uint16 off_screen_mem_size;	// size of memory in the framebuffer but not being displayed on the screen
	uint8 reserved1[206];
};

void vesa_print_data();

#endif