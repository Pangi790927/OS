#include "cpuid.h"
#include "Types.h"

/** issue a single request to CPUID. Fits 'intel features', for instance
 *  note that even if only "eax" and "edx" are of interest, other registers
 *  will be modified by the operation, so we need to tell the compiler about it.
 */
void cpuid(int code, u_int_32 *a, u_int_32 *d) {
	asm volatile ("cpuid":"=a"(*a),"=d"(*d):"a"(code):"ecx","ebx");
}
 
/** issue a complete request, storing general registers output as a string
 */
int cpuid_string(int code, u_int_32 where[4]) {
	asm volatile ("cpuid":"=a"(*where),"=b"(*(where+1)),
			"=c"(*(where+2)),"=d"(*(where+3)):"a"(code));
	return (int)where[0];
}


bool cpuid_has_feature (int feature, int _register){
	u_int_32 regs[4];
	cpuid_string(CPUID_GETFEATURES, regs);

	switch (_register) {
		case CPUID_FETURE_REG_EAX: return (regs[_register] & feature);
		case CPUID_FETURE_REG_EBX: return (regs[_register] & feature);
		case CPUID_FETURE_REG_ECX: return (regs[_register] & feature);
		case CPUID_FETURE_REG_EDX: return (regs[_register] & feature);
		default: return 0;
	}
}