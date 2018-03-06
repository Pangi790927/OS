#ifndef VGA_STDIO_H
#define VGA_STDIO_H

namespace VGA {
	const int MAX_ROW = 25;
	const int MAX_COL = 80;
	
	const char WHITE_ON_BLACK = 0x0f;

	int 	_pos_in_screen (int row, int col);
	char& 	_char_val_at (int row, int col);
	char& 	_char_mode_at (int row, int col);
	void 	scroll (char mode = WHITE_ON_BLACK);
	void 	clear_screen (char mode = WHITE_ON_BLACK);
	void 	putchar (char c, char mode = WHITE_ON_BLACK);
	void 	print (const char *str, char mode = WHITE_ON_BLACK);
	void 	_put_nbr_base_rec (int number, int base);
	void 	_put_nbr_base (unsigned int number, int base, bool unbase = false);
	void 	putHex (int number);
	void 	putDec (int number);
	void 	putOct (int number);
	void 	putBin (int number);
	void	_actualize_cursor(void);
}

#endif