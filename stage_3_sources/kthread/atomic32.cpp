#include "atomic32.h"
#include "atomic32.h"

#include "primitives.h"

namespace kthread
{
	Atomic32::Atomic32 (uint32 desired) : container(desired) {}

	uint32 Atomic32::operator = (uint32 desired) noexcept {
		uint32 expected = desired;
		while (!compare_exchange32(&container, &expected, desired))
			asm volatile ("pause");
		return expected;
	}

	uint32 Atomic32::operator = (uint32 desired) volatile noexcept {
		return (*this = desired);
	}

	void Atomic32::store(uint32 desired) noexcept {
		*this = desired;
	}

	void Atomic32::store(uint32 desired) volatile noexcept {
		*this = desired;
	}

	uint32 Atomic32::load() noexcept {
		uint32 expected = 0;
		compare_exchange32(&container, &expected, expected);
		return expected;
	}

	uint32 Atomic32::load() volatile noexcept {
		return this->load();
	}

	Atomic32::operator uint32() noexcept {
		return this->load();
	}

	Atomic32::operator uint32() volatile noexcept {
		return this->load();
	}

	uint32 Atomic32::operator ++ () {
		uint32 expected = load();
		while (!compare_exchange32(&container, &expected, expected + 1))
			asm volatile ("pause");
		return expected;
	}

	uint32 Atomic32::operator ++ (int) {
		uint32 expected = load();
		while (!compare_exchange32(&container, &expected, expected + 1))
			asm volatile ("pause");
		return expected + 1;
	}

	uint32 Atomic32::operator -- () {
		uint32 expected = load();
		while (!compare_exchange32(&container, &expected, expected - 1))
			asm volatile ("pause");
		return expected;
	}

	uint32 Atomic32::operator -- (int) {
		uint32 expected = load();
		while (!compare_exchange32(&container, &expected, expected - 1))
			asm volatile ("pause");
		return expected - 1;
	}

	uint32 Atomic32::operator += (uint32 desired) {
		uint32 expected = load();
		while (!compare_exchange32(&container, &expected, expected + desired))
			asm volatile ("pause");
		return expected + desired;
	}

	uint32 Atomic32::operator -= (uint32 desired) {
		uint32 expected = load();
		while (!compare_exchange32(&container, &expected, expected - desired))
			asm volatile ("pause");
		return expected - desired;
	}

	uint32 Atomic32::operator |= (uint32 desired) {
		uint32 expected = load();
		while (!compare_exchange32(&container, &expected, expected | desired))
			asm volatile ("pause");
		return expected | desired;
	}

	uint32 Atomic32::operator &= (uint32 desired) {
		uint32 expected = load();
		while (!compare_exchange32(&container, &expected, expected & desired))
			asm volatile ("pause");
		return expected & desired;
	}

	uint32 Atomic32::operator ^= (uint32 desired) {
		uint32 expected = load();
		while (!compare_exchange32(&container, &expected, expected ^ desired))
			asm volatile ("pause");
		return expected ^ desired;
	}
}
