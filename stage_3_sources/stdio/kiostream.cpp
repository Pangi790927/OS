#include "kiostream.h"
#include "ostream.h"
#include "istream.h"
#include "kiobuf.h"

namespace std
{	
	uint8 __container_buff[sizeof(kiobuf<char>)];
	uint8 __container_cout[sizeof(ostream)];
	uint8 __container_cin[sizeof(istream)];

	kiobuf<char>& buff = *((kiobuf<char> *)__container_buff);
	ostream& cout = *((ostream *)__container_cout);
	istream& cin = *((istream *)__container_cin);
}