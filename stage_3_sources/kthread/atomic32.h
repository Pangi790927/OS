#ifndef ATOMIC32_H
#define ATOMIC32_H

#include "Types.h"

namespace kthread
{
	class Atomic32 {
	public:
		uint32 container __attribute__ ((aligned (16)));

		Atomic32 (uint32 value = 0);
		Atomic32 (const Atomic32&) = delete;

		uint32 operator = (uint32 desired) noexcept;
		uint32 operator = (uint32 desired) volatile noexcept;
		
		Atomic32& operator = (const Atomic32&) = delete;
		Atomic32& operator = (const Atomic32&) volatile = delete;
	
		void store(uint32 desired) noexcept;
		void store(uint32 desired) volatile noexcept;

		uint32 load() noexcept;
		uint32 load() volatile noexcept;

		operator uint32() noexcept;
		operator uint32() volatile noexcept;

		uint32 operator ++ ();
		uint32 operator ++ (int);
		uint32 operator -- ();
		uint32 operator -- (int);

		uint32 operator += (uint32 desired);
		uint32 operator -= (uint32 desired);
		uint32 operator |= (uint32 desired);
		uint32 operator &= (uint32 desired);
		uint32 operator ^= (uint32 desired);
	};
}

#endif