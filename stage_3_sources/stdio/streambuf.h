#ifndef STREAMBUF_H
#define STREAMBUF_H

#include "vector.h"
#include "deque.h"
// #include "libft.h"

namespace std
{
	template <typename CharT>
	class streambuf {
	public:
		streambuf (size_t size) {
			setWriteSize(size);
			setReadSize(size);
		}

		std::vector<CharT> writeBuff;	// to device
		size_t writeIndex = 0;
		size_t startWriteIndex = 0;

		std::deque<CharT> readBuff;	// from device
		size_t readMax = 256;

		void setWriteSize (size_t size) {
			flush();
			writeBuff = std::vector<CharT> (size);
		}

		void setReadSize (size_t size) {
			readMax = size;
		}

		virtual void put (CharT c) {
			writeBuff[writeIndex++] = c;
			if (writeIndex == writeBuff.size())
				flush();
		}

		virtual CharT get() {
			CharT save = 0;
			if (readBuff.size())
				save = readBuff.front();
			readBuff.pop_front();
			return save;
		}

		virtual CharT peek() {
			if (readBuff.size())
				return readBuff.front();
			return 0;
		}

		virtual void flush() {
			for (size_t i = 0; i < writeBuff.size(); i++)
				writeOut();
			writeIndex = 0;
			startWriteIndex = 0;
		}

		virtual bool readIn (CharT c) {
			readBuff.push_back(c);
			if (readBuff.size() < readMax)
				return false;
			return true;
		}

		virtual bool writeOut () {
			if (startWriteIndex <= writeIndex) {
				// printf("%c", writeBuff[startWriteIndex++]);
				return true;
			}
			return false;
		}
	};
}

#endif
