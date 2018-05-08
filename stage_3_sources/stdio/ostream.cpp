#include "ostream.h"

namespace std
{
	ostream& endl (ostream& stream) {
		stream.put('\n');
		stream.flush();
		return stream;
	}

	ostream& hex (ostream& stream) {
		stream.mod = 16;
		return stream;
	}

	ostream& dec (ostream& stream) {
		stream.mod = 10;
		return stream;
	}

	ostream& oct (ostream& stream) {
		stream.mod = 8;
		return stream;
	}
}