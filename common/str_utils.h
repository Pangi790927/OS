#ifndef STR_UTILS_H
#define STR_UTILS_H

template <typename Arg>
auto sformat_arg(Arg&& arg) {
	return std::forward<Arg>(arg);
}

template <>
auto sformat_arg <std::string&> (std::string& str) {
	return str.c_str();
}

template <>
auto sformat_arg <const std::string&> (const std::string& str) {
	return str.c_str();
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wformat-security"
template <typename ...Types>
std::string sformat(const char* fmt, Types ...args) {
	int len = snprintf(NULL, 0, fmt, sformat_arg(args)...);
	if (len <= 0) {
		return "";	
	}
	std::vector<char> vec(len + 1);
	snprintf(&vec[0], vec.size(), fmt, sformat_arg(args)...);
	return &vec[0];
}
#pragma GCC diagnostic pop


#endif