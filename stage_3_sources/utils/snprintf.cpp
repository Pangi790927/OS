#include "Types.h"
#include "snprintf.h"

namespace strings
{
	struct div_res_t {
		uint64 res;
		uint64 rem;
	};

	div_res_t divmod(uint64 a, uint64 b) {
		if (b == 0) {
			/* I should panic here or something, not ignore it, but it happens that
			this operation is used indirectly in the code that prints panics so...*/
			return { .res = 0, .rem = 0 };
		}

		uint64 it = 63;
		uint64 bpow = b;
		while (bpow >> 1) {
			it--;
			bpow >>= 1;
		}

		uint64 res = 0;
		uint64 rem = a;
		while (true) {
			if (rem >= (1ULL << it) * b) {
				rem -= (1ULL << it) * b;
				res += (1ULL << it);
			}
			if (it-- == 0)
				break;
		}

		return { .res = res, .rem = rem };
	}

	char &buff_at(int len, char *buff, int index) {
		static char reserve;
		if (!buff)
			return reserve;
		if (len < 0)
			return reserve;
		if (index < 0)
			return reserve;
		if (index >= len)
			return reserve;
		return buff[index];
	}

	/* all those return how many characters they put */
	int cnt_digits(uint64 num, int base) {
		if (num == 0)
			return 1;
		int cnt = 0;
		while (num) {
			num = divmod(num, base).res;
			cnt++;
		}
		return cnt;
	}

	int put_base(arg_t fmt, int len, char *buff, uint64 num, int base) {
		static const char digits[] = "0123456789ABCDEF"; 
		int index = 0;
		if (fmt.spec_cls == _spec_cls::di) {
			int64 signed_int = num;
			if (signed_int < 0) {
				buff_at(len, buff, index) = '-'; 
				index++;
				num = (uint64)-signed_int;
			}
		}
		if (base < 0 || base > 16)
			return 0;
		int digit_cnt = cnt_digits(num, base);
		int rev_it = digit_cnt - 1;
		while (true) {
			buff_at(len, buff, index + rev_it) = digits[divmod(num, base).rem];
			num = divmod(num, base).res;
			if (!rev_it--)
				break;
		}
		index += digit_cnt;
		return index;
	}	
}
