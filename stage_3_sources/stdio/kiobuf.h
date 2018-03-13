#ifndef KIOBUF_H
#define KIOBUF_H

#include "streambuf.h"
#include "kstdio.h"

namespace std
{
	template <typename CharT>
	class kiobuf : public std::streambuf<CharT> {
	public:

		kiobuf (size_t size) : std::streambuf<CharT>(size) {}

		virtual bool writeOut () {
			if (std::streambuf<CharT>::startWriteIndex <
					std::streambuf<CharT>::writeIndex)
			{
				kputchar(std::streambuf<CharT>::writeBuff[
						std::streambuf<CharT>::startWriteIndex++]);
				return true;
			}
			return false;
		}
	};
}

#endif