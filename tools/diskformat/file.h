#ifndef FILE_H
#define FILE_H

#include <fstream>
#include "except.h"

std::vector<uint8_t> read_file(std::string path) {
	std::ifstream file(path.c_str(), std::ios::binary);
	if (!file.good()) {
		EXCEPTION("No such file or directory %s", path.c_str());
	}
	std::vector<uint8_t> buff{
		std::istreambuf_iterator<char>(file),
		std::istreambuf_iterator<char>()
	};
	return buff;
}

void write_file(std::string path, const std::vector<uint8_t>& buff) {
	std::ofstream file(path.c_str(), std::ios::binary);
	if (!file.good()) {
		EXCEPTION("No such file or directory %s", path.c_str());
	}
	file.write((char *)&buff[0], buff.size());
}

#endif