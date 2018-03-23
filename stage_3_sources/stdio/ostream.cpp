#include "ostream.h"

std::ostream& std::endl (std::ostream& stream) {
	stream.put('\n');
	stream.flush();
	return stream;
}
