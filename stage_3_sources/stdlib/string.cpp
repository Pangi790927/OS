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
	return result;	
}

std::string std::to_string (long long value) {
	std::string result;	
	return result;	
}

std::string std::to_string (unsigned value) {
	std::string result;	
	return result;	
}

std::string std::to_string (unsigned long value) {
	std::string result;	
	return result;	
}

std::string std::to_string (unsigned long long value) {
	std::string result;	
	return result;	
}

std::string std::to_string (float value) {
	std::string result;	
	return result;	
}

std::string std::to_string (double value) {
	std::string result;	
	return result;	
}

std::string std::to_string (long double value) {
	std::string result;	
	return result;	
}
