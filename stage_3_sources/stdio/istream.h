#ifndef ISTREAM_H
#define ISTREAM_H

#include "streambuf.h"

namespace istream
{
	class istream {
	public:
		std::streambuf<char> &buff;

		istream (std::streambuf<char> &buff) : buff(buff) {}

		int getNextInt() {
			char c = buff.peek();
			// if (isdigit(c))
			return 13;
		}

		char getNextChar() {
			return buff.get();
		}

		friend istream& operator >> (istream& stream, int& value) {
			value = stream.getNextInt();
			printf(":> wrote into int\n");

			return stream;
		}

		friend istream& operator >> (istream& stream, char& value) {
			value = stream.getNextChar();
			printf(":> wrote into char\n");

			return stream;
		}
	};
}

#endif