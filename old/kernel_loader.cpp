#include "intrerupts.h"
#include "stdio.h"
#include "timer.h"
#include "basic.h"
#include "edi.h"

/// !!! this function must be the first function called in main !!!
void kernel_init() {
	clear_screen();
	
	IDT table;
	PIC intControlers(table);
	
	table.sendTable();
	enable_int();

	int i = 100;
	while (i--)
		asm volatile ("");

	init_timer(1000); // 1Kh timer allways
	EDI::init_edi((u_int_32)0x1F0, (u_int_32)0x3F6, (u_int_32)0x170, (u_int_32)0x376, (u_int_32)0x000);
}

int main() 
{	
	kernel_init();

	printf("Welcome to MyOS\nHex: %x Dec: %d Oct: %o Bin: %b\n", 10, 10, 10, 10 );
	
	u_int_8 drive = EDI::getFirstATA();
	u_int_32 sector = 2;
	u_int_32 segment_selector = 0x10;
	u_int_32 loadTo = 0x100000;
	u_int_8 sectorCount = 1;

	EDI::ATA::access_pio (EDI::ATA::Read, drive, sector, sectorCount, segment_selector, loadTo);

	printf("%s\n", (char *)loadTo);
	
	// while (true) {
	// 	printf("Time: %d\n", (int)get_timer());
	// 	sleep(1000);  
	// }

	for(;;) {	/// we stay in kernel
		asm("hlt");
	}
}
