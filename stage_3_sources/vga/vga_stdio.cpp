#include "vga_stdio.h"
#include "c_asm_func.h"

namespace VGA {
	int _row = 0;
	int _col = 0;

	char *_video_memory_address = (char *) 0xb8000;
	char _digits[] = "0123456789abcdef";

	void	_actualize_cursor(void) {
		u_int_16 cursorLocation = _row * 80 + _col;

	    outb(0x3D4, 14);                  // Tell the VGA board we are setting the high cursor byte.
	    outb(0x3D5, cursorLocation >> 8); // Send the high cursor byte.
	    outb(0x3D4, 15);                  // Tell the VGA board we are setting the low cursor byte.
	    outb(0x3D5, cursorLocation);      // Send the low cursor byte.
	}

	int _pos_in_screen (int row, int col) {
		return (row * MAX_COL + col) * 2;
	}

	char& _char_val_at (int row, int col) {
		return _video_memory_address[_pos_in_screen(row, col) + 0];
	}

	char& _char_mode_at (int row, int col) {
		return _video_memory_address[_pos_in_screen(row, col) + 1];
	}

	void scroll (char mode) {
		for (int i = 1; i < MAX_ROW; i++) {
			for (int j = 0; j < MAX_COL; j++) {
				_char_val_at(i - 1, j) = _char_val_at(i, j);
				_char_mode_at(i - 1, j) = _char_mode_at(i, j);
			}
		}
		
		for (int j = 0; j < MAX_COL; j++) {
			_char_val_at(MAX_ROW - 1, j) = ' ';
			_char_mode_at(MAX_ROW - 1, j) = mode;
		}

		_row--;
		if (_row < 0)
			_row = 0;
		_actualize_cursor();
	}

	void clear_screen(char mode)
	{
		for (int row = 0; row < MAX_ROW; row++) {
			for (int col = 0; col < MAX_COL; col++)
			{
				_char_val_at(row, col) = ' ';
				_char_mode_at(row, col) = mode;
			}
		}
		_row = 0;
		_col = 0;
		_actualize_cursor();
	}

	void backspace (char mode) {
		if (_col > 0) {
			_col--;
			_char_val_at(_row, _col) = ' ';
			_char_mode_at(_row, _col) = mode;
		}
		_actualize_cursor();
	}

	void putchar (char c, char mode) {
		bool can_print = true;
		
		if (c == '\n') {
			_row++;
			_col = 0;
			can_print = false;
		}

		if (c == '\t') {
			_col = (_col + 4) & ~(4 - 1);;
			can_print = false;
		}

		if (c == '\r') {
			_col = 0;
			can_print = false;
		}

		if (_col >= MAX_COL) {
			_row += _col / MAX_COL;
			_col = 0;
		}

		if (_row >= MAX_ROW) {
			scroll(mode);
		}
		
		if (can_print) {
			_char_val_at(_row, _col) = c;
			_char_mode_at(_row, _col) = mode;
			_col++;
		}
		_actualize_cursor();
	}

	void print (const char *str, char mode) {
		for (int i = 0; str[i]; i++)
			putchar(str[i], mode);
	}

	void _put_nbr_base_rec (int number, int base) {
		if (number) {
			_put_nbr_base_rec(number / base, base);
			putchar(_digits[number % base]);
		}
	}
	
	void _put_nbr_base (unsigned int number, int base, bool unsign) {
		if ((number & 0x80000000) && !unsign)
			putchar('-');
		
		if (!number)
			putchar(_digits[0]);
		else {
			if ((number & 0x80000000) && !unsign) {
				_put_nbr_base_rec((int)number / base * -1, base);
				putchar(_digits[((int)number * -1) % base]);
			}	
			else {
				_put_nbr_base_rec(number / base, base);
				putchar(_digits[number % base]);
			}
		}
	}

	void putHex (int number) {
		_put_nbr_base(number, 16, true);
	}

	void putDec (int number) {
		_put_nbr_base(number, 10);
	}

	void putOct (int number) {
		_put_nbr_base(number, 8);
	}

	void putBin (int number) {
		unsigned int nb = number;
		unsigned int mask = 0x8000'0000;

		int i = 0;
		while (mask) {
			if (mask & nb)
				putchar(_digits[1]);
			else
				putchar(_digits[0]);
			mask = (mask >> 1);
			if ((++i) % 8 == 0 && i != 32)
				putchar('\'');
		}
	}
}
