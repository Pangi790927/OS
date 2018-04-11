#include "istream.h"
#include "string.h"

std::istream& std::getline (std::istream& stream, std::string& str) {
	str = "";
	char next = stream.buff.peek();
	while (next != '\n' && next != '\0') {
		str += stream.buff.get();
		next = stream.buff.peek();
	}
	if (next == '\n')
		stream.buff.get();
	return stream;
}

std::istream& std::getline (std::istream& stream, std::string& str, char delim) {
	str = "";
	char next = stream.buff.peek();
	while (next != '\n' && next != '\0' && next != delim) {
		str += stream.buff.get();
		next = stream.buff.peek();
	}
	if (next == '\n' || next == delim)
		stream.buff.get();
	return stream;
}