#ifndef IOBUFF_H
#define IOBUFF_H

#include "streambuf.h"

namespace iobuf
{
	template <typename CharT>
	class iobuf : public std::streambuf<CharT> {
	public:

		iobuf (size_t size) : std::streambuf<CharT>(size) {}

		virtual bool writeOut () {
			if (std::streambuf<CharT>::startWriteIndex <= 
					std::streambuf<CharT>::writeIndex)
			{
				printf("%c", std::streambuf<CharT>::writeBuff[
						std::streambuf<CharT>::startWriteIndex++]);
				return true;
			}
			return false;
		}
	};
}

#endif
