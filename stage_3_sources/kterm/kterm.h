#ifndef KTERM_H
#define KTERM_H

#include "Types.h"
#include "vector.h"
#include "string.h"
#include "deque.h"

struct command_t {
	char *name;
	char *help;
	char *help_ex;
	int (*comm)(char **argv, int argc);
};

struct cursor_t {
	uint16 x;
	uint16 y;
};

struct Terminal {
	std::vector<command_t> commands;
	std::deque<std::string> history;
	std::string curr_comm;

	Terminal ();
	Terminal (command_t *comms, uint32 cnt);

	void add_command (command_t comm);
	cursor_t ins_key (int key, cursor_t last);
	/*
		key: enter => execute curr_comm
		key: del => delete last char, move cursor

		return cursor advancement 
	*/
};

#endif