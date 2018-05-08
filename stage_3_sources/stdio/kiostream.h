#ifndef KIOSTREAM_H
#define KIOSTREAM_H

#include "ostream.h"
#include "istream.h"
#include "kiobuf.h"

namespace std
{
	extern kiobuf<char>& buff;
	extern ostream& cout;
	extern istream& cin;
}

#endif