#include "Types.h"

u_int_8		port_byte_in (u_int_16 port);
u_int_16	port_word_in (u_int_16 port);
u_int_32	port_dword_in (u_int_16 port);
void		port_byte_out (u_int_16 port, u_int_8 data);
void		port_word_out (u_int_16 port, u_int_16 data);
void		port_dword_out (u_int_16 port, u_int_32 data);
void		port_words_in (u_int_16 port, u_int_32 buffer, u_int_32 count);

void		io_wait(void);