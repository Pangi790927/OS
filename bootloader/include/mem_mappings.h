#ifndef MEM_MAPPINGS_H
#define MEM_MAPPINGS_H

/* 0x00007BFF under is our stack, over is our program(max 64kb) */

#define VESA_PUTCHAR_BUFF_START (0x00007C00 + 64 * 1024) 
#define VESA_PUTCHAR_BUFF_END (VESA_PUTCHAR_BUFF_START + sizeof(char [84][214]))

#define VESA_PUTCHAR_FONT_START (VESA_PUTCHAR_BUFF_END) 
#define VESA_PUTCHAR_FONT_END (VESA_PUTCHAR_FONT_START + sizeof(uint32_t[96][9 * 14]))

#define EXT2_CACHE_START (VESA_PUTCHAR_FONT_END) 
#define EXT2_CACHE_END (EXT2_CACHE_START + sizeof(char[128 * 512]))

#endif