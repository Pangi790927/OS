#ifndef FILE_H
#define FILE_H

#include <fstream>
#include <sstream>
#include "except.h"

std::vector<uint8_t> read_config(std::string path) {
	std::ifstream file(path.c_str(), std::ios::binary);
	if (!file.good()) {
		EXCEPTION("No such file or directory %s", path.c_str());
	}
	std::string buff{
		std::istreambuf_iterator<char>(file),
		std::istreambuf_iterator<char>()
	};
	std::stringstream ss(buff);
	std::string line;
	std::vector<uint8_t> data;
	while (std::getline(ss, line)) {
		int i = 0;
		while (i < line.size() && isspace(line[i]))
			i++;
		if (i != line.size() && line[i] != '#') {
			line += "\n";
			std::copy(line.begin(), line.end(), std::back_inserter(data));
		}
	}
	return data;
}

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