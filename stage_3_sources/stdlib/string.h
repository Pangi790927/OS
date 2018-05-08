#ifndef STRING_H
#define STRING_H

#include "libft.h"
#include "vector.h"

namespace std
{
	class string {
	private:
		char *internStr = NULL;
		size_t internSize;

	public:
		string () {
			internStr = strdup("");
			internSize = 0;
		}

		string (const string& str) {
			internStr = strdup(str.internStr);
			internSize = strlen(internStr);
		}

		string (const string& str, size_t pos, size_t npos) {
			internStr = (char *)malloc((npos + 1) * sizeof(char));
			internStr = strncpy(internStr, str.internStr + pos, npos);
			internStr[npos] = '\0';
			internSize = npos;
		}

		string (const char* s) {
			internStr = (char *)malloc((strlen(s) + 1) * sizeof(char));
			strcpy(internStr, s);
			internSize = strlen(s);
		}

		string (const char* s, size_t n) {
			internStr = (char *)malloc((n + 1) * sizeof(char));
			strncpy(internStr, s, n);
			internStr[n] = '\0';
			internSize = n;
		}

		string (size_t n, char c) {
			internStr = (char *)malloc((n + 1) * sizeof(char));
			for (size_t i = 0; i < n; i++)
				internStr[i] = c;
			internStr[n] = '\0';
			internSize = n;
		}

		string (char c) {
			internStr = (char *)malloc((2) * sizeof(char));
			internStr[0] = c;
			internStr[1] = '\0';
			internSize = 1;
		}

		template <typename IteratorType>
		string (IteratorType first, IteratorType last) {
			std::vector<char> strVec;
			for (IteratorType it = first; it != last; it++) {
				strVec.push_back(*it);
			}
			internStr = (char *)malloc((strVec.size() + 1) * sizeof(char));
			strncpy(internStr, &strVec[0], strVec.size());
			internStr[strVec.size()] = '\0';
			internSize = strVec.size();
		}

		string (const string&& str) {
			internStr = strdup(str.internStr);
			internSize = str.internSize;
		}

		~string() {
			free(internStr);
			internSize = 0;
		}

		string& operator = (const string& str) {
			free(internStr);
			internStr = strdup(str.internStr);
			internSize = strlen(str.internStr);
			return (*this);
		}

		string& operator = (const string&& str) {
			if (internStr)
				free(internStr);
			internStr = strdup(str.internStr);
			internSize = str.internSize;
			return (*this);
		}

		string& operator = (const char* s) {
			free(internStr);
			internStr = strdup(s);
			internSize = strlen(s);
			return (*this);
		}

		bool operator == (const string& str) {
			return strcmp(internStr, str.internStr) == 0;
		}

		bool operator <  (const string& str) {
			return strcmp(internStr, str.internStr) < 0;
		}

		bool operator <= (const string& str) {
			return strcmp(internStr, str.internStr) <= 0;
		}

		bool operator >  (const string& str) {
			return strcmp(internStr, str.internStr) > 0;
		}

		bool operator >= (const string& str) {
			return strcmp(internStr, str.internStr) >= 0;
		}

		size_t size() const {
			return internSize;
		}

		char *c_str() {
			return internStr;
		}

		template <typename Type>
		string& operator += (const Type& type) {
			(*this) = (*this) + type;
			return (*this);
		}

		string operator + (const string& str) {
			string newString;

			char *newStr = (char *)malloc((size() + 
					str.size() + 1) * sizeof(char));	
			strncpy(newStr, internStr, size());
			strncpy(newStr + size(), str.internStr, str.size());
			newStr[size() + str.size()] = '\0';

			newString.internSize = size() + str.size();
			free(newString.internStr);
			newString.internStr = newStr;

			return newString;
		}

		string operator + (const char* s) {
			return (*this) + string(s);
		}

		string operator + (char c) {
			return (*this) + string(1, c);
		}

		friend string operator + (const char* s, const string& str) {	
			return string(s) + str;
		}
		
		friend string operator + (char c, const string& str) {
			return string(1, c) + str;
		}

		char& operator [] (size_t pos) {
			return internStr[pos];
		}

		const char& operator [] (size_t pos) const {
			return internStr[pos];
		}
	};

	string to_string (int value, int mod);
	string to_string (long value, int mod);
	string to_string (long long value, int mod);
	string to_string (unsigned value, int mod);
	string to_string (unsigned long value, int mod);
	string to_string (unsigned long long value, int mod);
	string to_string (float value, int mod);
	string to_string (double value, int mod);
	string to_string (long double value, int mod);

	bool has_char (const string &str, char c);
	std::vector<string> tokenize (const string& str, string tokens);
}

#endif