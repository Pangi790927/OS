#include "timer.h"
#include "edi.h"
#include "c_asm_func.h"
#include "stdio.h"

using namespace EDI;

ChannelRegisters channels[2]; 
u_int_8 ide_buff[2048] = {0};
static u_int_8 ide_irq_invoked = 0;
static u_int_8 atapi_packet[12] = {0xA8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
Device ide_devices[4];

u_int_8 EDI::getFirstATA() {
	for (int i = 0; i < 4; i++) {
		if (ide_devices[i].type == InterfaceType::Interface_ATA)
			return i;
	}
	return -1;
}

u_int_8 EDI::read (u_int_8 channel, u_int_8 reg) {
	u_int_8 result;

	if (reg > 0x07 && reg < 0x0c)
		write (channel, ATA::Registers::Control, ATA::Status::Busy | channels[channel].noInterrupt);

	if (reg < 0x08) {
		result = port_byte_in(channels[channel].ioBase + reg - 0x00);
	}
	else if (reg < 0x0c) {
		result = port_byte_in(channels[channel].ioBase + reg - 0x06);
	}
	else if (reg < 0x0e) {
		result = port_byte_in(channels[channel].controlBase + reg - 0x0A);
	}
	else if (reg < 0x16) {
		result = port_byte_in(channels[channel].busMasterIDE + reg - 0x0E);
	}

	if (reg > 0x07 && reg < 0x0c)
		write (channel, ATA::Registers::Control, channels[channel].noInterrupt);

	return result;
}

void EDI::write (u_int_8 channel, u_int_8 reg, u_int_8 data) {
	if (reg > 0x07 && reg < 0x0c)
		write (channel, ATA::Registers::Control, ATA::Status::Busy | channels[channel].noInterrupt);

	if (reg < 0x08) {
		port_byte_out(channels[channel].ioBase + reg - 0x00, data);
	}
	else if (reg < 0x0c) {
		port_byte_out(channels[channel].ioBase + reg - 0x06, data);
	}
	else if (reg < 0x0e) {
		port_byte_out(channels[channel].controlBase + reg - 0x0A, data);
	}
	else if (reg < 0x16) {
		port_byte_out(channels[channel].busMasterIDE + reg - 0x0E, data);
	}

	if (reg > 0x07 && reg < 0x0c)
		write (channel, ATA::Registers::Control, channels[channel].noInterrupt);
}

void EDI::read_buffer (u_int_8 channel, u_int_8 reg, u_int_32 buffer_addr, u_int_32 size) {
	/* WARNING: This code may contain a serious bug. The inline assembly trashes ES and
    *           ESP for all of the code the compiler generates between the inline
    *           assembly blocks.
    */

	if (reg > 0x07 && reg < 0x0c)
		write (channel, ATA::Registers::Control, ATA::Status::Busy | channels[channel].noInterrupt);

	asm volatile ("pushw %es; pushw %ax; movw %ds, %ax; movw %ax, %es; popw %ax;");

	if (reg < 0x08) {
		port_words_in(channels[channel].ioBase + reg - 0x00, buffer_addr, size);
	}
	else if (reg < 0x0c) {
		port_words_in(channels[channel].ioBase + reg - 0x06, buffer_addr, size);
	}
	else if (reg < 0x0e) {
		port_words_in(channels[channel].controlBase + reg - 0x0A, buffer_addr, size);
	}
	else if (reg < 0x16) {
		port_words_in(channels[channel].busMasterIDE + reg - 0x0E, buffer_addr, size);
	}

	asm volatile ("popw %es;");

	if (reg > 0x07 && reg < 0x0c)
		write (channel, ATA::Registers::Control, channels[channel].noInterrupt);
}


u_int_8 EDI::polling (u_int_8 channel, bool advanced_check) {
	sleep(1);
	long long start_time = get_timer();

	while (((read(channel, ATA::Registers::Status)) & ATA::Status::Busy)) {
		if (get_timer() - start_time > POLLING_TIMEOUT) {
			return 5;
		}
		asm volatile ("");
	}

	if (advanced_check) {
		u_int_8 state = read(channel, ATA::Registers::Status);
		
		if (state & ATA::Status::Error)
			return 2;

		if (state & ATA::Status::DriveWriteFault)
			return 1;

		if (state & ATA::Status::DataRequestReady)
			return 3;
	}

	return 0;	// no error
}

u_int_8 EDI::printError (u_int_32 drive, u_int_8 error) {
	if (error == 0)
		return 0;

	printf("IDE:\n");

	if (error == 1) {
		printf("Device fault\n");
		error = 19;
	}
	else if (error == 2) {
		u_int_8 status = read(ide_devices[drive].channel, ATA::Registers::Reg_Error);

		if (status & (ATA::Errors::NoAddressMark)) {
			printf("No Address Mark Found ... \n");
			error = 7;
		}

		if (status & (ATA::Errors::NoMediaR | ATA::Errors::Track0NotFound | ATA::Errors::NoMedia)) {
			printf("No Media Or Media Error ... \n");
			error = 3;
		}

		if (status & (ATA::Errors::CommandAborted)) {
			printf("Command Aborted ... \n");
			error = 20;
		}

		if (status & (ATA::Errors::IDMarkNotFound)) {
			printf("ID Mark Not Found ... \n");
			error = 21;
		}

		if (status & (ATA::Errors::UncorectableData)) {
			printf("Uncorectable Data Error ... \n");
			error = 22;
		}

		if (status & (ATA::Errors::BadSector)) {
			printf("Bad Sectors ... \n");
			error = 13;
		}
	}
	else if (error == 3) {
		printf("Reads Nothing ... \n");
		error = 23;
	}
	else if (error == 4) {
		printf("Write Protected ... \n");
		error = 8;
	}
	else if (error == 5) {
		printf("Pooling Timeout ... \n");
		error = 80;
	}

	printf("[%s, %s] %s\n", 
		(const char *[]){"Primary", "Secondary"}[ide_devices[drive].channel],
		(const char *[]){"Master", "Slave"}[ide_devices[drive].drive],
		ide_devices[drive].model
	);

	return error;
}

void EDI::init_edi (u_int_32 BAR0, u_int_32 BAR1, u_int_32 BAR2, u_int_32 BAR3, u_int_32 BAR4) {
	channels[ATA::Primary].ioBase = 
			(BAR0 & 0xfffffffc) + 0x1F0 * (BAR0 == 0x0 || BAR0 == 0x1);
	
	channels[ATA::Primary].controlBase = 
			(BAR1 & 0xfffffffc) + 0x3F6 * (BAR1 == 0x0 || BAR1 == 0x1);
	
	channels[ATA::Secondary].ioBase = 
			(BAR2 & 0xfffffffc) + 0x170 * (BAR2 == 0x0 || BAR2 == 0x1);
	
	channels[ATA::Secondary].controlBase = 
			(BAR3 & 0xfffffffc) + 0x376 * (BAR3 == 0x0 || BAR3 == 0x1);
	
	channels[ATA::Primary].busMasterIDE = 
			(BAR4 & 0xfffffffc) + 0;	// Bus Master IDE

	channels[ATA::Secondary].busMasterIDE = 
			(BAR4 & 0xfffffffc) + 8;	// Bus Master IDE

	write(ATA::Primary, ATA::Registers::Control, 2);	// disable irq Primary
	write(ATA::Secondary, ATA::Registers::Control, 2);	// disable irq Secondary

	int deviceCount = 0;

	for (int channel = 0; channel < 2; channel++) {
		for (int device = 0; device < 2; device++) {
			u_int_8 type = InterfaceType::Interface_ATA;

			// we select slave or master drive
			write(channel, ATA::Registers::HDDEvalSel, ATA::Commands::Packet | (device << 4));
			sleep(10);

			write(channel, ATA::Registers::Command, ATA::Commands::Identify);
			sleep(10);

			if (read(channel, ATA::Registers::Status) == 0)
				continue;

			long long start_timer = get_timer();
			bool done = false;
			u_int_8 error = 5;	/// we asume timeout

			while (get_timer() - start_timer < POLLING_TIMEOUT && !done) {
				u_int_8 status = read(channel, ATA::Registers::Status);

				if (status & ATA::Status::Error) {
					error = 1;
					done = true;
				}
				if (!(status & ATA::Status::Busy) && (status & ATA::Status::DataRequestReady)) {
					error = 0;	// back to no error
					done = true;
				}
			}

			if (error != 0) {
				u_int_8 cl = read(channel, ATA::Registers::LBA1);
				u_int_8 ch = read(channel, ATA::Registers::LBA2);

				if (cl == 0x14 && ch ==0xEB)
	               type = InterfaceType::Interface_ATAPI;
	            else if (cl == 0x69 && ch == 0x96)
	               type = InterfaceType::Interface_ATAPI;
	            else
	               type = InterfaceType::Interface_UNKNOWN;
				
				write(channel, ATA::Registers::Command, ATA::Commands::IdentifyPacket);
				sleep(1);
			}

			if (type != InterfaceType::Interface_UNKNOWN) {
				read_buffer(channel, ATA::Registers::Data, (u_int_32)ide_buff, 128);

				ide_devices[deviceCount].reserved 	= 1;
				ide_devices[deviceCount].type 		= type;
				ide_devices[deviceCount].channel 	= channel;
				ide_devices[deviceCount].drive 		= device;
				
				ide_devices[deviceCount].signature	= 
						*((u_int_16*)ide_buff + ATA::IdentifSpace::DeviceType);
				
				ide_devices[deviceCount].capabilities = 
						*((u_int_16*)ide_buff + ATA::IdentifSpace::Capabilities);
				
				ide_devices[deviceCount].commandSets = 
						*((u_int_32*)ide_buff + ATA::IdentifSpace::CommandSets);

				if (ide_devices[deviceCount].commandSets & (1 << 26))
					// Device uses 48-Bit Addressing:
					ide_devices[deviceCount].size = *((u_int_32*)ide_buff + ATA::IdentifSpace::MaxLBA_EXT);
				else
					// Device uses CHS or 28-bit Addressing:
					ide_devices[deviceCount].size = *((u_int_32*)ide_buff + ATA::IdentifSpace::MaxLBA);

				for (int k = 0; k < 40; k += 2) {
					ide_devices[deviceCount].model[k] = ide_buff[ATA::IdentifSpace::Model + k + 1];
        			ide_devices[deviceCount].model[k + 1] = ide_buff[ATA::IdentifSpace::Model + k];
				}
				ide_devices[deviceCount].model[40] = '\0';

				deviceCount++;
			}
		}
	}

	printf("Found %d devices: \n", deviceCount);
	for (int device = 0; device < deviceCount; device++) {
		printf("Found: %s Size: %d Model: %s \n", 
			(const char *[]){"ATA", "ATAPI"}[ide_devices[device].type],
			ide_devices[device].size / 1024 / 1024 / 2,
			ide_devices[device].model
		);
	}
}

int EDI::ATA::access_pio (u_int_8 mode, u_int_8 drive, u_int_32 lba, 
				u_int_8 sector_count, u_int_16 segment_selector, u_int_32 segment_offset ) {
	u_int_8 lba_mode = LBA_MODE::LBA28;	/// we only use LBA28, at least for kernel loading we will
	u_int_8 lba_io[6];

	u_int_32 channel = ide_devices[drive].channel;
	u_int_32 slaveBit = ide_devices[drive].drive;	// slave or master
	u_int_32 bus = channels[channel].ioBase;

	u_int_8 head, sector, error;
	/// disable irqs
	// ide_irq_invoked = 0
	write(channel, Registers::Control, channels[channel].noInterrupt = 0x02);

	if (ide_devices[drive].capabilities & 0x200) { // suports LBA ?
		lba_io[0] = (lba & 0x00000FF) >> 0;
		lba_io[1] = (lba & 0x000FF00) >> 8;
		lba_io[2] = (lba & 0x0FF0000) >> 16;
		lba_io[3] = 0; // These Registers are not used here.
		lba_io[4] = 0; // These Registers are not used here.
		lba_io[5] = 0; // These Registers are not used here.
		head      = (lba & 0xF000000) >> 24;
	}
	else {
		printf("No ATA reading/writing for you (LBA not supported) ... \n");
		printf("Device Name: %s\n", ide_devices[drive].model);
		printf("Device Cap: %x\n", ide_devices[drive].model);
		printf("Device ---: %x\n", 0x200);
	}

	u_int_8 dma = 0;	// we are not upporting dma yet

	if (polling(channel, false)) {
		printf("Timed out ... \n");
		return 5;
	}

	// dont forget lba28 mode

	write(channel, HDDEvalSel, 0xE0 | (slaveBit << 4) | head);	// drive and LBA  

	write(channel, Registers::SectorCount0, sector_count);
	write(channel, Registers::LBA0,   lba_io[0]);
	write(channel, Registers::LBA1,   lba_io[1]);
	write(channel, Registers::LBA2,   lba_io[2]);

	if (mode == Mode::Read && dma) 
		write(channel, Registers::Command, Commands::ReadDMA);
	if (mode == Mode::Write && dma) 
		write(channel, Registers::Command, Commands::WrtieDMA);
	
	if (mode == Mode::Read && !dma) 
		write(channel, Registers::Command, Commands::ReadPIO);
	if (mode == Mode::Write && !dma) 
		write(channel, Registers::Command, Commands::WritePIO);

	if (dma) {

	}
	else {
		if (mode == Mode::Read) {
			for (int i = 0; i < sector_count; i++) {
				if ((error = polling(channel, true)))
					return error;
				u_int_32 words = 256;
				u_int_32 bytes = words * 2;
				
				asm volatile ("pushw %es");
				asm volatile ("pushw %ax");
				asm volatile ("mov %%ax, %%es" : : "a"(segment_selector));
				asm volatile ("rep insw" : : "c"(words), "d"(bus), "D"(segment_offset)); 
																	// Receive Data.
				asm volatile ("popw %ax");
				asm volatile ("popw %es");
				
				segment_offset += (words * 2);
			}
		}
		else { // mode == Write
			for (int i = 0; i < sector_count; i++) {
				if ((error = polling(channel, true)))
					return error;
				u_int_32 words = 256;
				u_int_32 bytes = words * 2;
				
				asm volatile ("pushw %es");
				asm volatile ("pushw %ax");
				asm volatile ("mov %%ax, %%es" : : "a"(segment_selector));
				asm volatile ("rep outsw" : : "c"(words), "d"(bus), "D"(segment_offset)); 
																	// Receive Data.
				asm volatile ("popw %ax");
				asm volatile ("popw %es");
				
				segment_offset += (words * 2);	
			}
		}
		return 0;
	}
}