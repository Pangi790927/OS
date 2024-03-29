#include "gdtInit.h"
#include "global_defines.h"
#include "tss.h"

gdt::Descriptor descriptorsTable[32];
gdt::DescriptorPtr descriptorsTablePtr;
gdt::tss ktaskStateSegment;

gdt::tss *gdt::get_tss_addr() {
	return &ktaskStateSegment;
}

gdt::Descriptor gdt::getAllRAMSeg() {
	Descriptor segment;

	segment.init();
	segment.setLimit(0xfffff); 	// 0x000fffff
	segment.setBase(0x0);			// starts at 0
	segment.setPrivilege(0);		// kernel privilege
	segment.setExecutable(false);
	segment.setConfDir(false);
	segment.setReadWrite(true);
	segment.setAccessBit(false);	// must be 0
	segment.setGranularity(true);	// page granularity
	segment.set32Mode(true);			// 32 bit mode	

	return segment;
}

gdt::Descriptor gdt::makeTSSSeg (gdt::tss *addr) {
	Descriptor segment;

	segment.init();
	segment.setLimit(sizeof(gdt::tss));
	segment.setBase((uint32)addr);
	segment.setPrivilege(3);
	segment.setTss(true);
	segment.setExecutable(true);
	segment.setConfDir(false);
	segment.setReadWrite(false);		// this sets busy/not for TSS
	segment.setAccessBit(true);			// must be true for TSS
	
	segment.setGranularity(false);
	segment.set32Mode(false);

	return segment;	
}

void gdt::init_gdt() {
	gdt::Descriptor nullDesc;
	gdt::Descriptor kernelCode = getAllRAMSeg();
	gdt::Descriptor kernelData = getAllRAMSeg();
	gdt::Descriptor userCode = getAllRAMSeg();
	gdt::Descriptor userData = getAllRAMSeg();
	gdt::Descriptor tssDesc;

	ktaskStateSegment.init(V_K_INT_STACK_START, KERNEL_DATA_SEL);
	tssDesc = makeTSSSeg(&ktaskStateSegment);

	nullDesc.zero();
	descriptorsTable[0] = nullDesc;

	kernelCode.setExecutable(true);
	descriptorsTable[K_CODE_INDEX] = kernelCode;
	descriptorsTable[K_DATA_INDEX] = kernelData;

	userCode.setPrivilege(3);
	userData.setPrivilege(3);
	userCode.setExecutable(true);
	descriptorsTable[U_CODE_INDEX] = userCode;
	descriptorsTable[U_DATA_INDEX] = userData;

	descriptorsTable[K_TSS_INDEX] = tssDesc;

	// 5 entries for now: null, kcode, kdata, ucode, udata, ktss
	descriptorsTablePtr.pointTo(descriptorsTable, 6);
}

void gdt::load_gdt() {
	descriptorsTablePtr.loadDescriptorTable();
}

gdt::Descriptor& gdt::entry (int entry) {
	return descriptorsTable[entry];
}