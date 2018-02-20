#ifndef EDI_H
#define EDI_H

namespace EDI
{
	enum InterfaceType {
		Interface_ATA = 0x00,
		Interface_ATAPI = 0x01,
		Interface_UNKNOWN = 0x02
	};

	namespace ATA {

		enum Status {
			Busy = 0x80,
			DriveReady = 0x40,
			DriveWriteFault = 0x20,
			DriveSeekComplete = 0x10,
			DataRequestReady = 0x08,
			CorectData = 0x04,
			Inlex = 0x02,
			Error = 0x01
		};

		enum Errors {
			BadSector = 0x80,
			UncorectableData = 0x40,
			NoMedia = 0x20,
			IDMarkNotFound = 0x10,
			NoMediaR = 0x08, /// ????
			CommandAborted = 0x04,
			Track0NotFound = 0x02,
			NoAddressMark = 0x01
		};

		enum Commands {
			ReadPIO = 0x20,
			ReadPIO_EXT = 0x24,
			ReadDMA = 0xc8,
			ReadDMA_EXT = 0x25,
			WritePIO = 0x30,
			WritePIO_EXT = 0x34,
			WrtieDMA = 0xCA,
			WriteDMA_EXT = 0x35,
			CacheFlush = 0xE7,
			CacheFlushEXT = 0xEA,
			Packet = 0xA0,
			IdentifyPacket = 0xA1,
			Identify = 0xEC
		};

		enum IdentifSpace {
			DeviceType = 0,
			Cylinders = 2,
			Heads = 6,
			Sectors = 12,
			Serial = 20,
			Model = 54,
			Capabilities = 98,
			FieldValid = 106,
			MaxLBA = 120,
			CommandSets = 164,
			MaxLBA_EXT = 200
		};

		enum {
			Master = 0x0,
			Slave = 0x1
		};

		enum Registers {
			Data = 0x00,
			Reg_Error = 0x01,
			Features = 0x01,
			SectorCount0 = 0x02,
			LBA0 = 0x03,
			LBA1 = 0x04,
			LBA2 = 0x05,
			HDDEvalSel = 0x06,
			Command = 0x07,
			Status = 0x07,
			LBA3 = 0x09,
			LBA4 = 0x0A,
			LBA5 = 0x0B,
			SectorCount1 = 0x08,
			Control = 0x0C,
			AltStatus = 0x0C,
			DeviceAddress = 0x0D
		};

		enum Channel {
			Primary = 0x0,
			Secondary = 0x1
		};

		enum Mode {
			Read = 0,
			Write = 1
		};

		enum LBA_MODE {
			CHS = 0x0,
			LBA28 = 0x1,
			LBA48 = 0x2
		};

		int access_pio (u_int_8 mode, u_int_8 drive, u_int_32 lba, 
				u_int_8 sector_count, u_int_16 segment_selector, u_int_32 segment_offset );
	};

	namespace ATAPI {
		enum Commands {
			Read = 0xA8,
			Eject = 0x1B
		};
	};

	const long long POLLING_TIMEOUT = 5000;	/// 5 sec 

	struct ChannelRegisters {
		u_int_16 ioBase;
		u_int_16 controlBase;
		u_int_16 busMasterIDE;
		u_int_8  noInterrupt;
	};

	struct Device {
		u_int_8  reserved;		// signals driver existence
		u_int_8  channel;		// primary/secondary
		u_int_8  drive; 		// master/slave 	
		u_int_16 type;			// ATA/ATAPI
		u_int_16 signature;		// Drive Signature
		u_int_16 capabilities;	// features
		u_int_32 commandSets;	// Command Sets Suported 
		u_int_32 size;			// Size in sectors
		u_int_8  model[41];		// model name as string  
	};

	u_int_8 getFirstATA();
	u_int_8 read (u_int_8 channel, u_int_8 reg);
	void write (u_int_8 channel, u_int_8 reg, u_int_8 data);
	void read_buffer (u_int_8 channel, u_int_8 reg, u_int_32 buffer_addr, u_int_32 size);
	u_int_8 polling (u_int_8 channel, bool advanced_check);
	u_int_8 printError (u_int_32 drive, u_int_8 error);
	void init_edi (u_int_32 BAR0, u_int_32 BAR1, u_int_32 BAR2, u_int_32 BAR3, u_int_32 BAR4);
}

#endif