#ifndef SERIAL_H
#define SERIAL_H

namespace serial
{
	void init();
	void uninit();

	void sendchr (char chr);
	void sendstr (const char *str);
}

#endif