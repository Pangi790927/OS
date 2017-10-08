#include "Types.h"

u_int_8		port_byte_in (u_int_16 port);
u_int_16	port_word_in (u_int_16 port);
void		port_byte_out (u_int_16 port, u_int_8 data);
void		port_word_out (u_int_16 port, u_int_16 data);
void		io_wait(void);