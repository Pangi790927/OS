#ifndef UTIL_H
#define UTIL_H

/* this util section must be moved in it's apropiate section */

/* general */
namespace util {
	constexpr int cstrlen(const char *str) {
		int len = 0;
		while (*str) {
			len++;
			str++;
		}
		return len;
	}

	constexpr const char *cstrchr(const char *str, int chr) {
		while (*str) {
			if (chr == *str)
				return str;
			str++;
		}
		return NULL;
	}
}

/* templates */
namespace util {
	template <typename ...>
	struct pack_t {};

	template <typename P = pack_t<>, typename...>
	struct concat_s {
		using type = P;
	};

	template <typename ...T1, typename ...T2, typename ...Ts>
	struct concat_s<pack_t<T1...>, pack_t<T2...>, Ts...> :
			concat_s<pack_t<T1..., T2...>, Ts...> {};

	template <typename ...Ps>
	using concat_t = typename concat_s<Ps...>::type;

	template <size_t, typename P>
	struct get_s {};

	template <typename T, typename ...Ts>
	struct get_s<0, pack_t<T, Ts...>> {
		using type = T;
	};

	template <size_t t, typename T, typename ...Ts>
	struct get_s<t, pack_t<T, Ts...>> : get_s<t - 1, pack_t<T, Ts...>> {};

	template <size_t pos, typename P>
	using get_t = typename get_s<pos, P>::type;
}


#endif