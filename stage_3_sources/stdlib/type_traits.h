#ifndef TYPE_TRAITS_H
#define TYPE_TRAITS_H

namespace std
{
	template <class T>
	struct remove_reference { typedef T type; };

	template <class T>
	struct remove_reference<T&> { typedef T type; };

	template <class T>
	struct remove_reference<T&&> { typedef T type; };
}

#endif