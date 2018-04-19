#ifndef ISTREAM_H
#define ISTREAM_H

#include "streambuf.h"
#include "libft.h"
#include "string.h"

namespace std
{
	class istream {
	public:
		std::streambuf<char> &buff;

		istream (std::streambuf<char> &buff) : buff(buff) {}

		int getNextInt() {
			char minus = buff.peek();
			if (minus == '-' || minus == '+')
				buff.get();

			std::string number;
			while (isdigit(buff.peek())) {
				number += buff.get();
			}
			return atoi(number.c_str()) * (-1 * (minus == '-'));
		}

		std::string getNextString() {
			std::string ret;
			while (!iswhitespace(buff.peek())) {
				ret += buff.get();
			}
			return ret;
		}

		char getNextChar() {
			return buff.get();
		}

		void advanceWhitSpace() {
			while (iswhitespace(buff.peek())) {
				buff.get();
			}
		}

		friend istream& operator >> (istream& stream, int& value) {
			stream.advanceWhitSpace();
			value = stream.getNextInt();

			return stream;
		}

		friend istream& operator >> (istream& stream, char& value) {
			value = stream.getNextChar();

			return stream;
		}

		friend istream& operator >> (istream& stream, std::string& value) {
			stream.advanceWhitSpace();
			value = stream.getNextString();

			return stream;
		}
	};

	istream& getline (istream& stream, std::string& str);
	istream& getline (istream& stream, std::string& str, char delim);
}

#endif