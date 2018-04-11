#include "string.h"

std::string std::to_string (int value) {
	std::string result;

	if (value == -2147483648) {
		result += "-2147483648";
	}
	else {
		if (value < 0) {
			result += "-";
			value = value * -1;
		}
		std::string posPart;
		std::string c[] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}; 
		if (value == 0)
			result += "0";
		while (value) {
			posPart = c[value % 10] + posPart;
			value = value / 10;
		}
		result += posPart;
	}

	return result;
}

std::string std::to_string (long value) {
	std::string result;
	kprintf("to_string ::long::\n");
	return result;
}

std::string std::to_string (long long value) {
	std::string result;	
	kprintf("to_string ::long long::\n");
	return result;	
}

std::string std::to_string (unsigned value) {
	std::string result;
	std::string c[] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
	if (value == 0)
		result += "0";
	while (value) {
		result = c[value % 10] + result;
		value = value / 10;
	}
	return result;
}

std::string std::to_string (unsigned long value) {
	std::string result;
	kprintf("to_string ::unsigned long::\n");
	return result;
}

std::string std::to_string (unsigned long long value) {
	std::string result;	
	kprintf("to_string ::unsigned long long::\n");
	return result;	
}

std::string std::to_string (float value) {
	std::string result;	
	kprintf("to_string ::float::\n");
	return result;	
}

std::string std::to_string (double value) {
	std::string result;
	kprintf("to_string ::double::\n");
	return result;
}

std::string std::to_string (long double value) {
	std::string result;
	kprintf("to_string ::long double::\n");
	return result;
}

bool std::has_char (const std::string &str, char c) {
	for (int i = 0; i < str.size(); i++)
		if (str[i] == c)
			return true;
	return false;
}

std::vector<std::string> std::tokenize (const std::string& str, std::string split) {
	std::vector<string> tokens;
	int k = 0;
	int i = 0;
	bool valid = false;

	if (str.size() > 0 && !has_char(split, str[0]))
		valid = true;
	for (i = 0; i < str.size(); i++) {
		if (has_char(split, str[i])) {
			if (valid)
				tokens.push_back(string(str, k, i - k));
			k = i;
			valid = false;
		}
		else {
			valid = true;
		}
	}
	if (valid)
		tokens.push_back(string(str, k, i - k));
	return tokens;
}