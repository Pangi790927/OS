#include "vbe.h"
#include "boot_data.h"
#include "Types.h"
#include "kerndiag.h"
#include "global_defines.h"
#include "paging.h"

void vesa_print_data() {
	int mode_cnt = boot::get_vesa_modes_cnt();
	uint8 *base_ptr = (uint8 *)boot::get_vesa_info_ptr();
	vbe_info_t &vbe_info = *(vbe_info_t *)base_ptr;
	vbe_mode_info_t *vbe_mode_info = (vbe_mode_info_t *)
			(base_ptr + sizeof(vbe_info_t));


	KDBG("sig[%c%c%c%c], ver[%d.%d], modes: ",
			vbe_info.sig[0], vbe_info.sig[1], vbe_info.sig[2], vbe_info.sig[3],
			(vbe_info.ver & 0xff00) >> 8, vbe_info.ver & 0xff);
	for (int i = 0; i < mode_cnt; i++)
		KDBG("(%dx%d, md: %x), ",
				int(vbe_mode_info[i].width), int(vbe_mode_info[i].height),
				int(vbe_mode_info[i].mode));
	KDBG("\n");

	int mode = boot::get_vesa_curr_mode();
	int index = 0;
	for (int i = 0; i < mode_cnt; i++)
		if (vbe_mode_info[i].mode == mode)
			index = i;
	KDBG("test: %dx%d, bpp: %d", int(vbe_mode_info[index].width),
			int(vbe_mode_info[index].height), int(vbe_mode_info[index].bpp));
	KDBG("%x", V_VBE_MEM_BASE);

	size_t total_size = vbe_mode_info[index].bpp / 8 *
			vbe_mode_info[index].width * vbe_mode_info[index].height +
			vbe_mode_info[index].off_screen_mem_size;
	for (size_t i = 0; i < total_size / 0x1000 + 1; i++) {
		paging::registerPageK((uint32 *)(vbe_mode_info[index].framebuffer +
				i * 0x1000), (uint32 *)(V_VBE_MEM_BASE + i * 0x1000),
				(uint32 *)K_PAGING);
	}
	char *vbuff = (char *)(uint32 *)V_VBE_MEM_BASE;
	for (int i = 0; i < 600 * 400 * vbe_mode_info[index].bpp / 8; i++)
		vbuff[i] = 0xff;
}
