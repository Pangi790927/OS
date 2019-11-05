#ifndef SNPRINTF_H
#define SNPRINTF_H

#include "meta_util.h"
#include "libft.h"
#include "serial.h"

/*
		printf has the following specifiers: "diuoxXfFeEgGaAcspn"
		with "hljztL" len specifiers

		this implementation will also force conversions to take place if they
		can take place. for example %d will work like so: (int)param 

		this implementation will add the following specifiers:
		S - for std::strings and anything convertible to std::string
		t - will try to use the member function to_string
		o - will try to use stringstream's << operator
		with the new class Sto and all other specifiers will work like on %s
	*/

	/* % = 1, flag = 1, width = 9, prec = 10, len = 2, spec = 1, '\0' = 1 */
namespace strings {
	const int MAX_FMT_SIZE = 15;

	namespace _lenght {
		enum {
			no, hh, h, l, ll, z, L, enum_len
		};
		const char _len_ch[] = "hljztL";
	}

	namespace _spec {
		enum {
			d, i, u, o, x, X, b, f, F, e, E, g, G, a, A, c, s, p, n, pr,
			enum_len
		};
		const char _spec_ch[] = "diuoxXbfFeEgGaAcspnSto%";
	}

	namespace _spec_cls {
		enum {
			di, uoxXb, fFeEgGaA, c, s, p, n, enum_len
		};
		constexpr int get_cls(int spec) {
			switch (spec) {
				case _spec::d:
				case _spec::i: return di;
				case _spec::u:
				case _spec::o:
				case _spec::x:
				case _spec::X:
				case _spec::b: return uoxXb;
				case _spec::f:
				case _spec::F:
				case _spec::e:
				case _spec::E:
				case _spec::g:
				case _spec::G:
				case _spec::a:
				case _spec::A: return fFeEgGaA;
				case _spec::c: return c;
				case _spec::s: return s;
				case _spec::p: return p;
				case _spec::n: return n;
				default: return enum_len;
			}
		}
	}

	enum {
		NONE,
		INT, SINT, LINT, LLINT, UINT, USINT, ULINT, ULLINT,
		INT_P, SINT_P, LINT_P, LLINT_P,
		SCHAR, UCHAR, CHAR_P, SCHAR_P,
		SIZE, SIZE_P,
		DOUBLE, LDOUBLE,
		VOID_P,
		enum_len
	};

	using _params = util::pack_t<
		void,
		int, short int, long int, unsigned int, unsigned short int,
				unsigned long int, unsigned long long int,
		int *, signed int *, long int *, long long int *,
		signed char, unsigned char, char *, signed char *,
		size_t, size_t *,
		double, long double,
		void *
	>;

	template <size_t pos>
	using param_t = util::get_t<pos, _params>;

	static int len_spec[_lenght::enum_len][_spec_cls::enum_len]
	= {
		{INT,     UINT,    DOUBLE,  INT,  CHAR_P,   VOID_P, INT_P   },
		{SCHAR,   UCHAR,   0,       0,    0,        0,      SCHAR_P },
		{SINT,    USINT,   0,       0,    0,        0,      SINT_P  },
		{LINT,    ULINT,   0,       0,    0,        0,      LINT_P  },
		{LLINT,   ULLINT,  0,       0,    0,        0,      LLINT_P },
		{SIZE,    SIZE,    0,       0,    0,        0,      SIZE_P  },
		{0,       0,       LDOUBLE, 0,    0,        0,      0       },
	};

	[[maybe_unused]] static void make_use() {
		(void)len_spec;
	}

	static const char _flags[] = "-+ #0";

	struct arg_t {
		bool valid			= false;
		bool ex_width		= false;
		bool ex_prec		= false;
		char flag			= 0;
		int width			= 0;
		int prec			= 0;
		int length			= 0;
		int spec			= 0;
		int spec_cls		= 0;
		int len				= 0;
		const char *start_p	= NULL;
		const char *len_p	= NULL;
		const char *width_p	= NULL;
		const char *prec_p	= NULL;
		const char *spec_p	= NULL;
		const char *end_p	= NULL;
	};

	char &buff_at(int len, char *buff, int index);
	int cnt_digits(uint64 num, int base);
	int put_base(arg_t fmt, int len, char *buff, uint64 num, int base);

	constexpr bool is_proc(const char *str) {
		if (!str)
			return false;
		if (*str != '%')
			return false;
		str++;
		if (*str != '%')
			return false;
	}

	constexpr bool is_arg(const char *str) {
		if (!str)
			return false;
		if (*str != '%')
			return false;
		str++;
		if (*str != '%' && *str != '\0')
			return true;
		return false;
	}

	constexpr const char *next_arg(const char *str) {
		while (*str) {
			if (is_arg(str))
				return str;
			str++;
		}
		return NULL;
	}

	constexpr arg_t parse_arg(const char *str) {
		arg_t ret;

		/* arg format: %[flags][width][.precision][length]specifier */

		if (!str)
			return ret;
		
		if (!is_arg(str))
			return ret;
		ret.start_p = str;
		str++;
		/* flags */
		if (util::cstrchr(_flags, *str)) {
			ret.flag = *str;
			str++;
		}

		/* width */
		if (*str == '*') {
			ret.ex_width = true;
			str++;
		}
		else if (isdigit(*str)) {
			ret.width = atoi(str);
			ret.width_p = str;
			while (isdigit(*str))
				str++;
		}

		/* precision */
		if (*str == '.') {
			str++;
			if (*str == '*') {
				ret.ex_prec = true;
				str++;
			}
			else if (isdigit(*str)) {
				ret.prec = atoi(str);
				ret.prec_p = str;
				while (isdigit(*str))
					str++;
			}
		}

		/* length */
		if (util::cstrchr(_lenght::_len_ch, *str)) {
			char first = *str;
			ret.len_p = str;
			str++;
			switch (first) {
				case 'h':
					if (*str == 'h') {
						str++;
						ret.length = _lenght::hh;
					}
					else
						ret.length = _lenght::h;	
					break;
				case 'l':
					if (*str == 'l') {
						str++;
						ret.length = _lenght::ll;
					}
					else
						ret.length = _lenght::l;
					break;
				case 'z': ret.length = _lenght::z; break;
				case 'L': ret.length = _lenght::L; break;
			}
		}

		/* specifier */
		const char *spec_chr = NULL;
		if ((spec_chr = util::cstrchr(_spec::_spec_ch, *str))) {
			ret.spec = spec_chr - _spec::_spec_ch;
			ret.spec_cls = _spec_cls::get_cls(ret.spec);
			ret.spec_p = str;
			ret.end_p = str + 1;
			ret.len = ret.end_p - ret.start_p;
			ret.valid = true;
		}
		else
			ret.valid = false;
		return ret;
	}

	inline int put_hex(arg_t fmt, int len, char *buff, uint64 num) {
		return put_base(fmt, len, buff, num, 16);
	}

	inline int put_dec(arg_t fmt, int len, char *buff, uint64 num) {
		return put_base(fmt, len, buff, num, 10);
	}

	inline int put_oct(arg_t fmt, int len, char *buff, uint64 num) {
		return put_base(fmt, len, buff, num, 8);
	}

	inline int put_bin(arg_t fmt, int len, char *buff, uint64 num){
		return put_base(fmt, len, buff, num, 2);
	}

	inline int put_str(arg_t fmt, int len, char *buff, char *str) {
		(void)fmt;
		int index = 0;
		if (!str)
			return index;
		while (str[index]) {
			buff_at(len, buff, index) = str[index];
			index++;
		}
		return index;
	}

	inline int put_chr(arg_t fmt, int len, char *buff, char chr) {
		(void)fmt;
		buff_at(len, buff, 0) = chr;
		return 1;
	}

	template <typename Arg>
	inline int print_arg(int len, char *buff, arg_t &fmt, Arg&& arg) {
		if (!fmt.valid)
			return fmt.len;
		if (fmt.spec == _spec::c) {
			return put_chr(fmt, len, buff, (char)(uint64)arg);
		}
		if (fmt.spec == _spec::s) {
			return put_str(fmt, len, buff, (char *)(uint64)arg);
		}
		if (fmt.spec_cls == _spec_cls::fFeEgGaA) {
			/* we don't support floats yet */
			return fmt.len;
		}
		if (fmt.spec_cls == _spec_cls::n) {
			/* we don't support %n yet */
			return fmt.len;
		}
		if (fmt.spec == _spec::p) {
			/* we don't support floats yet */
			return put_hex(fmt, len, buff, (uint64)arg);
		}
		if (fmt.spec_cls == _spec_cls::di || fmt.spec_cls == _spec_cls::uoxXb) {
			if (fmt.spec_cls == _spec_cls::di) {
				return put_dec(fmt, len, buff, (int64)arg);
			}
			if (fmt.spec == _spec::u) {
				return put_dec(fmt, len, buff, (uint64)arg);
			}
			if (fmt.spec == _spec::o) {
				return put_oct(fmt, len, buff, (uint64)arg);
			}
			if (fmt.spec == _spec::x || fmt.spec == _spec::X) {
				return put_hex(fmt, len, buff, (uint64)arg);
			}
			if (fmt.spec == _spec::b) {
				return put_bin(fmt, len, buff, (uint64)arg);
			}
		}
		/* if we reach here we ignore the parameter */
		return fmt.len;
	}

	inline int snprintf_help(int len, char *buff, const char* fmt_str) {
		int index = 0;
		while (*fmt_str) {
			buff_at(len, buff, index) = *fmt_str;
			index++;
			fmt_str++;
		}
		return index;
	}

	template <typename Arg, typename ...Args>
	int snprintf_help(int len, char *buff, const char* fmt_str,
			Arg&& arg, Args&& ...args)
	{
		int total_len = 0;
		int index = 0;
		arg_t fmt = parse_arg(next_arg(fmt_str));
		const char *curr = fmt_str;
		while (*curr && curr != fmt.start_p) {
			buff_at(len, buff, index) = *curr;
			index++;
			curr++;
		}
		index += print_arg(len - index, buff + index, fmt, arg);
		total_len = index + snprintf_help(len - index, buff + index, fmt.end_p,
				args...);
		return total_len;
	}

	template <typename ...Args>
	int snprintf(int len, char *buff, const char* fmt_str, Args ...args) {
		int final_len = snprintf_help(len, buff, fmt_str, args...);
		if (final_len > len - 1)
			buff_at(len, buff, len - 1) = '\0';
		return final_len;
	}
}

#endif