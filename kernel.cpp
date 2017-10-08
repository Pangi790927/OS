#include "intrerupts.h"
#include "stdio.h"
#include "timer.h"
#include "keyboard.h"
#include "cpuid.h"
#include "basic.h"

void cpuid_support_print() {
	printf(" cpuid: %b \n", cpuid_suported());

	u_int_32 name[4];
	cpuid_string(0, name);

	unsigned char *str = (unsigned char*)(name + 1);
	swap(name[3], name[2]);

	for (int i = 0; i < 12; i++)
		printf("%c", str[i]);
	printf("\n");
	
	if (cpuid_has_feature(CPUID_FEAT_EDX_APIC, CPUID_FETURE_REG_EDX))
		printf("APIC Feature ... \n");
	else
		printf("NO APIC Feature ... \n");
}

int main() {
	clear_screen();
	printf("Welcome to MyOS\nHex: %x Dec: %d Oct: %o Bin: %b\n", 10, 10, 10, 10 );
	
	IDT table;
	PIC intControlers(table);
	
	table.sendTable();
	enable_int();

	// init_timer(50);
	init_keyboard();

	for(;;) {	/// we stay in kernel
		asm("hlt");
	}
}