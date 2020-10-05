#ifndef DEV_LAYOUT_H
#define DEV_LAYOUT_H

#include <exception>
#include <iostream>
#include <fstream>

#include "json.h"
#include "except.h"

#include <filesystem>

namespace fs = std::filesystem;

/* every path you find in the dev config file is relative to the location of
the config file */
struct DevLayout {
	nlohmann::json jconf;
	fs::path confpath;
	fs::path confdir;

	DevLayout(std::string confpath) : confpath(confpath) {
		confdir = fs::absolute(this->confpath.parent_path());
		std::ifstream file(confpath.c_str());
		if (!file.good()) {
			EXCEPTION("Couldn't open file: %s\n", confpath.c_str());
			return ;
		}
		try {
			file >> jconf;
		}
		catch (std::exception& ex) {
			std::cout << ex.what() << std::endl;
		}
	}

	auto operator [] (std::string opt_name) {
		if (jconf.find(opt_name) == jconf.end())
			EXCEPTION("%s not found", opt_name.c_str());
		return jconf[opt_name];
	}

	std::string path(std::string src_dst, std::string opt_name) {
		if (jconf.find(opt_name) == jconf.end())
			EXCEPTION("Path not found: %s", opt_name.c_str());
		if (src_dst == "src_path")
			return rel_to_conf(jconf[opt_name][src_dst].get<std::string>());
		else if (src_dst == "dst_path")
			return jconf[opt_name][src_dst].get<std::string>();
		else
			return "";
	}

	fs::path rel_to_conf(fs::path p) {
		if (p.is_absolute())
			return p;
		return fs::canonical(confdir / p);
	}
};

#endif