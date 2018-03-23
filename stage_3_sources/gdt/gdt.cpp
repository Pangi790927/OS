#include "gdt.h"
#include "ostream.h"

extern void callLGDT (uint32 gdtPtr) asm ("callLGDT");

void gdt::Descriptor::zero() {
	limitLo = 0;
	baseLo = 0;
	baseMi = 0;
	access = 0;
	flags_limitHi = 0;
	baseHi = 0;
}

void gdt::Descriptor::init() {
	limitLo = 0;
	baseLo = 0;
	baseMi = 0;
	access = 0;
	flags_limitHi = 0;
	baseHi = 0;
	
	access |= 0b1001'0000;
}

void gdt::Descriptor::setLimit (uint32 limit) {
	limitLo = limit & 0xffff;
	flags_limitHi = flags_limitHi & 0xf0;
	flags_limitHi = flags_limitHi | ((limit >> 16) & 0xf);
}

void gdt::Descriptor::setBase (uint32 base) {
	baseLo = base & 0xffff;
	baseMi = (base >> 16) & 0xff;
	baseHi = (base >> 24) & 0xff;
}

void gdt::Descriptor::setPrivilege (uint8 value) {
	access = access & 0b1001'1111;
	access = access | ((value & 0x03) << 5);
}

void gdt::Descriptor::setTss (bool value) {
	access = access & 0b1110'1111;
	access = access | (((uint8)!value) << 4);
}

void gdt::Descriptor::setExecutable (bool value) {
	access = access & 0b1111'0111;
	access = access | (((uint8)value) << 3);
}

void gdt::Descriptor::setConfDir (bool value) {
	access = access & 0b1111'1011;
	access = access | (((uint8)value) << 2);
}

void gdt::Descriptor::setReadWrite (bool value) {
	access = access & 0b1111'1101;
	access = access | (((uint8)value) << 1);
}

void gdt::Descriptor::setAccessBit (bool value) {
	access = access & 0b1111'1110;
	access = access | ((uint8)value);
}

void gdt::Descriptor::setAccess (uint8 access) {
	this->access = access;
}

uint32 gdt::Descriptor::getLimit() const {
	return limitLo | ((flags_limitHi & 0b0000'1111) << 16);
}

uint32 gdt::Descriptor::getBase() const {
	return baseLo | (baseMi << 16) | (baseHi << 24);
}

uint8 gdt::Descriptor::getPrivilege() const {
	return ((access & 0b0110'0000) >> 5);
}

bool gdt::Descriptor::getTss() const {
	return !((access & 0b0001'0000) >> 4);
}

bool gdt::Descriptor::getExecutable() const {
	return ((access & 0b0000'1000) >> 3);
}

bool gdt::Descriptor::getConfDir() const {
	return ((access & 0b0000'0100) >> 2);
}

bool gdt::Descriptor::getReadWrite() const {
	return ((access & 0b0000'0010) >> 1);
}

bool gdt::Descriptor::getAccessBit() const {
	return ((access & 0b0000'0001));
}

uint8 gdt::Descriptor::getAccess() const {
	return access;
}

void gdt::Descriptor::setGranularity (bool paging) {
	flags_limitHi = flags_limitHi & 0b0111'1111;
	flags_limitHi = flags_limitHi | ((uint8)paging << 7);
}

void gdt::Descriptor::setMode (bool mode) {
	flags_limitHi = flags_limitHi & 0b1011'1111;
	flags_limitHi = flags_limitHi | ((uint8)mode << 6);
}

bool gdt::Descriptor::getGranularity() const {
	return flags_limitHi & 0b1000'0000;
}

bool gdt::Descriptor::getMode() const {
	return flags_limitHi & 0b0100'0000;
}

std::ostream& operator << (std::ostream& stream, const gdt::Descriptor& arg) {
	stream << "base: " << arg.getBase() << std::endl;
	stream << "limit: " << arg.getLimit() << std::endl;
	stream << "Priv: " << arg.getPrivilege() 
			<< " Exec: " << arg.getExecutable() 
			<< " CoDi: " << arg.getConfDir() 
			<< " AccesedBit: " << arg.getAccessBit() << std::endl;
	stream << "Gran: " << arg.getGranularity()
 			<< " Mode: " << arg.getMode() << std::endl;
	return stream;
}

void gdt::DescriptorPtr::pointTo (Descriptor *start, uint32 count) {
	addr = (uint32)start;
	size = count * sizeof(Descriptor) - 1;
}

void gdt::DescriptorPtr::loadDescriptorTable() {
	callLGDT((uint32)this);
}