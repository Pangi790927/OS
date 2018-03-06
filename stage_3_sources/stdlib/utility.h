#ifndef UTILITY_H
#define UTILITY_H

#include "type_traits.h"

namespace std
{
	template <typename T>
	typename remove_reference<T>::type&& move(T&& arg)
	{
		return static_cast<typename remove_reference<T>::type&&>(arg);
	}	
}

#endif

