#ifndef OSTREAM_H
#define OSTREAM_H

#include "streambuf.h"

namespace std
{
	class ostream {
	public:
		std::streambuf<char> &buff;

		ostream (std::streambuf<char> &buff) : buff(buff) {}

		void putString (std::string str) {
			for (int i = 0; i < str.size(); i++)
				buff.put(str[i]);
		}

		void putInt (int value) {
			putString(std::to_string(value));
		}

		void put (char c) {
			buff.put(c);
		}

		void flush() {
			buff.flush();
		}

		friend ostream& operator << (ostream& stream, int value) {
			stream.putInt(value);
			stream.putString(":> int\n");
			return stream;
		}

		friend ostream& operator << (ostream& stream, char c) {
			stream.putString(":> char\n");

			return stream;
		}

		friend ostream& operator << (ostream& stream, const char* c) {
			stream.putString(std::string(c));
			stream.putString(":> c string\n");

			return stream;	
		}
	};

	class EndlClass {
	public:
		friend ostream& operator << (ostream& stream, const EndlClass& obj) {
			stream.putString(":> endl\n");
			stream.put('\n');
			stream.flush();
			return stream;
		}
	};

	EndlClass endl;
}

#endif
