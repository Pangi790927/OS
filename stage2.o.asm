
stage2.elf:     file format elf32-i386


Disassembly of section .text:

0000a000 <kernel_2-0x10>:
    a000:	bd 00 00 80 00       	mov    ebp,0x800000
    a005:	89 ec                	mov    esp,ebp
    a007:	e8 04 00 00 00       	call   a010 <kernel_2>
    a00c:	eb fe                	jmp    a00c <WHITE_ON_BLACK+0x9ffd>
    a00e:	66 90                	xchg   ax,ax

0000a010 <kernel_2>:
    a010:	83 ec 1c             	sub    esp,0x1c
    a013:	e8 88 1b 00 00       	call   bba0 <_Z12clear_screenv>
    a018:	83 ec 0c             	sub    esp,0xc
    a01b:	68 d4 e1 00 00       	push   0xe1d4
    a020:	e8 0b 1c 00 00       	call   bc30 <_Z6printfPKc>
    a025:	e8 46 1c 00 00       	call   bc70 <_ZN6serial4initEv>
    a02a:	c7 04 24 de e1 00 00 	mov    DWORD PTR [esp],0xe1de
    a031:	e8 ba 1c 00 00       	call   bcf0 <_ZN6serial7sendstrEPc>
    a036:	e8 b5 00 00 00       	call   a0f0 <check_A20_on>
    a03b:	83 c4 10             	add    esp,0x10
    a03e:	85 c0                	test   eax,eax
    a040:	0f 85 92 00 00 00    	jne    a0d8 <kernel_2+0xc8>
    a046:	e8 c5 0c 00 00       	call   ad10 <_ZN6paging18init_kernel_pagingEv>
    a04b:	c6 44 24 0f 00       	mov    BYTE PTR [esp+0xf],0x0
    a050:	83 ec 04             	sub    esp,0x4
    a053:	6a 00                	push   0x0
    a055:	8d 44 24 17          	lea    eax,[esp+0x17]
    a059:	50                   	push   eax
    a05a:	6a 00                	push   0x0
    a05c:	e8 3f 09 00 00       	call   a9a0 <_ZN3ata12sendIdentifyEhRbb>
    a061:	83 c4 10             	add    esp,0x10
    a064:	84 c0                	test   al,al
    a066:	74 5e                	je     a0c6 <kernel_2+0xb6>
    a068:	0f b6 44 24 0f       	movzx  eax,BYTE PTR [esp+0xf]
    a06d:	84 c0                	test   al,al
    a06f:	75 3e                	jne    a0af <kernel_2+0x9f>
    a071:	83 ec 08             	sub    esp,0x8
    a074:	50                   	push   eax
    a075:	6a 00                	push   0x0
    a077:	68 00 00 20 00       	push   0x200000
    a07c:	6a 00                	push   0x0
    a07e:	68 00 00 01 00       	push   0x10000
    a083:	68 00 00 00 c1       	push   0xc1000000
    a088:	e8 33 06 00 00       	call   a6c0 <_ZN3ata4readEPvyjhb>
    a08d:	83 c4 20             	add    esp,0x20
    a090:	84 c0                	test   al,al
    a092:	74 09                	je     a09d <kernel_2+0x8d>
    a094:	b8 00 00 00 c1       	mov    eax,0xc1000000
    a099:	ff d0                	call   eax
    a09b:	eb fe                	jmp    a09b <kernel_2+0x8b>
    a09d:	83 ec 0c             	sub    esp,0xc
    a0a0:	68 fc e2 00 00       	push   0xe2fc
    a0a5:	e8 86 1b 00 00       	call   bc30 <_Z6printfPKc>
    a0aa:	83 c4 10             	add    esp,0x10
    a0ad:	eb fe                	jmp    a0ad <kernel_2+0x9d>
    a0af:	83 ec 0c             	sub    esp,0xc
    a0b2:	68 d8 e2 00 00       	push   0xe2d8
    a0b7:	e8 74 1b 00 00       	call   bc30 <_Z6printfPKc>
    a0bc:	0f b6 44 24 1f       	movzx  eax,BYTE PTR [esp+0x1f]
    a0c1:	83 c4 10             	add    esp,0x10
    a0c4:	eb ab                	jmp    a071 <kernel_2+0x61>
    a0c6:	83 ec 0c             	sub    esp,0xc
    a0c9:	68 f9 e1 00 00       	push   0xe1f9
    a0ce:	e8 5d 1b 00 00       	call   bc30 <_Z6printfPKc>
    a0d3:	83 c4 10             	add    esp,0x10
    a0d6:	eb 90                	jmp    a068 <kernel_2+0x58>
    a0d8:	e8 31 00 00 00       	call   a10e <enable_A20>
    a0dd:	e9 64 ff ff ff       	jmp    a046 <kernel_2+0x36>
    a0e2:	66 90                	xchg   ax,ax
    a0e4:	66 90                	xchg   ax,ax
    a0e6:	66 90                	xchg   ax,ax
    a0e8:	66 90                	xchg   ax,ax
    a0ea:	66 90                	xchg   ax,ax
    a0ec:	66 90                	xchg   ax,ax
    a0ee:	66 90                	xchg   ax,ax

0000a0f0 <check_A20_on>:
    a0f0:	60                   	pusha  
    a0f1:	bf 45 23 11 00       	mov    edi,0x112345
    a0f6:	be 45 23 01 00       	mov    esi,0x12345
    a0fb:	89 36                	mov    DWORD PTR [esi],esi
    a0fd:	89 3f                	mov    DWORD PTR [edi],edi
    a0ff:	a7                   	cmps   DWORD PTR ds:[esi],DWORD PTR es:[edi]
    a100:	b8 00 00 00 00       	mov    eax,0x0
    a105:	75 05                	jne    a10c <check_A20_on.A20_on>
    a107:	b8 01 00 00 00       	mov    eax,0x1

0000a10c <check_A20_on.A20_on>:
    a10c:	61                   	popa   
    a10d:	c3                   	ret    

0000a10e <enable_A20>:
    a10e:	60                   	pusha  
    a10f:	e4 92                	in     al,0x92
    a111:	0c 02                	or     al,0x2
    a113:	e6 92                	out    0x92,al
    a115:	61                   	popa   
    a116:	c3                   	ret    
    a117:	66 90                	xchg   ax,ax
    a119:	66 90                	xchg   ax,ax
    a11b:	66 90                	xchg   ax,ax
    a11d:	66 90                	xchg   ax,ax
    a11f:	90                   	nop

0000a120 <vga_print_string_at_coords>:
    a120:	60                   	pusha  
    a121:	bf 00 80 0b 00       	mov    edi,0xb8000
    a126:	b9 50 00 00 00       	mov    ecx,0x50
    a12b:	f7 e1                	mul    ecx
    a12d:	01 d8                	add    eax,ebx
    a12f:	b9 02 00 00 00       	mov    ecx,0x2
    a134:	f7 e1                	mul    ecx
    a136:	01 c7                	add    edi,eax
    a138:	eb 0b                	jmp    a145 <vga_print_string_at_coords.while_condition>

0000a13a <vga_print_string_at_coords.while_start>:
    a13a:	8a 06                	mov    al,BYTE PTR [esi]
    a13c:	b4 0f                	mov    ah,0xf
    a13e:	66 89 07             	mov    WORD PTR [edi],ax
    a141:	83 c7 02             	add    edi,0x2
    a144:	46                   	inc    esi

0000a145 <vga_print_string_at_coords.while_condition>:
    a145:	8a 06                	mov    al,BYTE PTR [esi]
    a147:	3c 00                	cmp    al,0x0
    a149:	75 ef                	jne    a13a <vga_print_string_at_coords.while_start>
    a14b:	61                   	popa   
    a14c:	c3                   	ret    
    a14d:	66 90                	xchg   ax,ax
    a14f:	90                   	nop

0000a150 <__setCR4>:
    a150:	55                   	push   ebp
    a151:	89 e5                	mov    ebp,esp
    a153:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a156:	0f 22 e0             	mov    cr4,eax
    a159:	5d                   	pop    ebp
    a15a:	c3                   	ret    

0000a15b <__getCR4>:
    a15b:	0f 20 e0             	mov    eax,cr4
    a15e:	c3                   	ret    

0000a15f <__setCR3>:
    a15f:	55                   	push   ebp
    a160:	89 e5                	mov    ebp,esp
    a162:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a165:	0f 22 d8             	mov    cr3,eax
    a168:	5d                   	pop    ebp
    a169:	c3                   	ret    

0000a16a <__getCR3>:
    a16a:	0f 20 d8             	mov    eax,cr3
    a16d:	c3                   	ret    

0000a16e <__setCR2>:
    a16e:	55                   	push   ebp
    a16f:	89 e5                	mov    ebp,esp
    a171:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a174:	0f 22 d0             	mov    cr2,eax
    a177:	5d                   	pop    ebp
    a178:	c3                   	ret    

0000a179 <__getCR2>:
    a179:	0f 20 d0             	mov    eax,cr2
    a17c:	c3                   	ret    

0000a17d <__setCR0>:
    a17d:	55                   	push   ebp
    a17e:	89 e5                	mov    ebp,esp
    a180:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a183:	0f 22 c0             	mov    cr0,eax
    a186:	5d                   	pop    ebp
    a187:	c3                   	ret    

0000a188 <__getCR0>:
    a188:	0f 20 c0             	mov    eax,cr0
    a18b:	c3                   	ret    
    a18c:	66 90                	xchg   ax,ax
    a18e:	66 90                	xchg   ax,ax

0000a190 <__isCpuidSuported>:
    a190:	9c                   	pushf  
    a191:	9c                   	pushf  
    a192:	81 34 24 00 00 20 00 	xor    DWORD PTR [esp],0x200000
    a199:	9d                   	popf   
    a19a:	9c                   	pushf  
    a19b:	58                   	pop    eax
    a19c:	33 04 24             	xor    eax,DWORD PTR [esp]
    a19f:	9d                   	popf   
    a1a0:	25 00 00 20 00       	and    eax,0x200000
    a1a5:	c3                   	ret    

0000a1a6 <__getCpuidVendor>:
    a1a6:	55                   	push   ebp
    a1a7:	89 e5                	mov    ebp,esp
    a1a9:	53                   	push   ebx
    a1aa:	51                   	push   ecx
    a1ab:	52                   	push   edx
    a1ac:	b8 00 00 00 00       	mov    eax,0x0
    a1b1:	0f a2                	cpuid  
    a1b3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a1b6:	89 18                	mov    DWORD PTR [eax],ebx
    a1b8:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    a1bb:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    a1be:	5a                   	pop    edx
    a1bf:	59                   	pop    ecx
    a1c0:	5b                   	pop    ebx
    a1c1:	5d                   	pop    ebp
    a1c2:	c3                   	ret    

0000a1c3 <__getCpuidFeatures>:
    a1c3:	55                   	push   ebp
    a1c4:	89 e5                	mov    ebp,esp
    a1c6:	51                   	push   ecx
    a1c7:	52                   	push   edx
    a1c8:	b8 01 00 00 00       	mov    eax,0x1
    a1cd:	0f a2                	cpuid  
    a1cf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a1d2:	89 10                	mov    DWORD PTR [eax],edx
    a1d4:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
    a1d7:	5a                   	pop    edx
    a1d8:	59                   	pop    ecx
    a1d9:	5d                   	pop    ebp
    a1da:	c3                   	ret    
    a1db:	66 90                	xchg   ax,ax
    a1dd:	66 90                	xchg   ax,ax
    a1df:	90                   	nop

0000a1e0 <_ZN3ata7waitBSYEv>:
    a1e0:	83 ec 0c             	sub    esp,0xc
    a1e3:	90                   	nop
    a1e4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a1e8:	83 ec 0c             	sub    esp,0xc
    a1eb:	68 f7 01 00 00       	push   0x1f7
    a1f0:	e8 bb 1b 00 00       	call   bdb0 <_Z3inbt>
    a1f5:	83 c4 10             	add    esp,0x10
    a1f8:	84 c0                	test   al,al
    a1fa:	78 ec                	js     a1e8 <_ZN3ata7waitBSYEv+0x8>
    a1fc:	83 c4 0c             	add    esp,0xc
    a1ff:	c3                   	ret    

0000a200 <_ZN3ata7waitDSQEv>:
    a200:	83 ec 0c             	sub    esp,0xc
    a203:	eb 07                	jmp    a20c <_ZN3ata7waitDSQEv+0xc>
    a205:	8d 76 00             	lea    esi,[esi+0x0]
    a208:	a8 08                	test   al,0x8
    a20a:	75 24                	jne    a230 <_ZN3ata7waitDSQEv+0x30>
    a20c:	83 ec 0c             	sub    esp,0xc
    a20f:	68 f7 01 00 00       	push   0x1f7
    a214:	e8 97 1b 00 00       	call   bdb0 <_Z3inbt>
    a219:	83 c4 10             	add    esp,0x10
    a21c:	a8 01                	test   al,0x1
    a21e:	74 e8                	je     a208 <_ZN3ata7waitDSQEv+0x8>
    a220:	31 c0                	xor    eax,eax
    a222:	83 c4 0c             	add    esp,0xc
    a225:	c3                   	ret    
    a226:	8d 76 00             	lea    esi,[esi+0x0]
    a229:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    a230:	b8 01 00 00 00       	mov    eax,0x1
    a235:	83 c4 0c             	add    esp,0xc
    a238:	c3                   	ret    
    a239:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000a240 <_ZN3ata12lba28PIOReadEPvjhh>:
    a240:	55                   	push   ebp
    a241:	57                   	push   edi
    a242:	56                   	push   esi
    a243:	53                   	push   ebx
    a244:	83 ec 24             	sub    esp,0x24
    a247:	8b 5c 24 3c          	mov    ebx,DWORD PTR [esp+0x3c]
    a24b:	0f b6 54 24 44       	movzx  edx,BYTE PTR [esp+0x44]
    a250:	8b 7c 24 40          	mov    edi,DWORD PTR [esp+0x40]
    a254:	89 d8                	mov    eax,ebx
    a256:	c1 e8 18             	shr    eax,0x18
    a259:	c1 e2 04             	shl    edx,0x4
    a25c:	83 ca e0             	or     edx,0xffffffe0
    a25f:	83 e0 0f             	and    eax,0xf
    a262:	09 d0                	or     eax,edx
    a264:	0f b6 c0             	movzx  eax,al
    a267:	50                   	push   eax
    a268:	68 f6 01 00 00       	push   0x1f6
    a26d:	e8 ee 1a 00 00       	call   bd60 <_Z4outbth>
    a272:	58                   	pop    eax
    a273:	5a                   	pop    edx
    a274:	6a 00                	push   0x0
    a276:	68 f1 01 00 00       	push   0x1f1
    a27b:	e8 e0 1a 00 00       	call   bd60 <_Z4outbth>
    a280:	59                   	pop    ecx
    a281:	89 f8                	mov    eax,edi
    a283:	5e                   	pop    esi
    a284:	0f b6 f8             	movzx  edi,al
    a287:	57                   	push   edi
    a288:	68 f2 01 00 00       	push   0x1f2
    a28d:	e8 ce 1a 00 00       	call   bd60 <_Z4outbth>
    a292:	5d                   	pop    ebp
    a293:	58                   	pop    eax
    a294:	0f b6 c3             	movzx  eax,bl
    a297:	50                   	push   eax
    a298:	68 f3 01 00 00       	push   0x1f3
    a29d:	e8 be 1a 00 00       	call   bd60 <_Z4outbth>
    a2a2:	58                   	pop    eax
    a2a3:	5a                   	pop    edx
    a2a4:	0f b6 c7             	movzx  eax,bh
    a2a7:	50                   	push   eax
    a2a8:	68 f4 01 00 00       	push   0x1f4
    a2ad:	e8 ae 1a 00 00       	call   bd60 <_Z4outbth>
    a2b2:	89 d8                	mov    eax,ebx
    a2b4:	59                   	pop    ecx
    a2b5:	c1 e8 10             	shr    eax,0x10
    a2b8:	5e                   	pop    esi
    a2b9:	0f b6 c0             	movzx  eax,al
    a2bc:	50                   	push   eax
    a2bd:	68 f5 01 00 00       	push   0x1f5
    a2c2:	e8 99 1a 00 00       	call   bd60 <_Z4outbth>
    a2c7:	83 c4 10             	add    esp,0x10
    a2ca:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a2d0:	83 ec 0c             	sub    esp,0xc
    a2d3:	68 f7 01 00 00       	push   0x1f7
    a2d8:	e8 d3 1a 00 00       	call   bdb0 <_Z3inbt>
    a2dd:	83 c4 10             	add    esp,0x10
    a2e0:	84 c0                	test   al,al
    a2e2:	78 ec                	js     a2d0 <_ZN3ata12lba28PIOReadEPvjhh+0x90>
    a2e4:	83 ec 08             	sub    esp,0x8
    a2e7:	6a 20                	push   0x20
    a2e9:	68 f7 01 00 00       	push   0x1f7
    a2ee:	e8 6d 1a 00 00       	call   bd60 <_Z4outbth>
    a2f3:	83 c4 10             	add    esp,0x10
    a2f6:	85 ff                	test   edi,edi
    a2f8:	0f 84 b0 00 00 00    	je     a3ae <_ZN3ata12lba28PIOReadEPvjhh+0x16e>
    a2fe:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    a302:	31 f6                	xor    esi,esi
    a304:	05 00 02 00 00       	add    eax,0x200
    a309:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a30d:	8d 76 00             	lea    esi,[esi+0x0]
    a310:	83 ec 0c             	sub    esp,0xc
    a313:	68 f7 01 00 00       	push   0x1f7
    a318:	e8 93 1a 00 00       	call   bdb0 <_Z3inbt>
    a31d:	83 c4 10             	add    esp,0x10
    a320:	84 c0                	test   al,al
    a322:	78 ec                	js     a310 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a324:	83 ec 0c             	sub    esp,0xc
    a327:	68 f6 03 00 00       	push   0x3f6
    a32c:	e8 7f 1a 00 00       	call   bdb0 <_Z3inbt>
    a331:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a338:	e8 73 1a 00 00       	call   bdb0 <_Z3inbt>
    a33d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a344:	e8 67 1a 00 00       	call   bdb0 <_Z3inbt>
    a349:	83 c4 10             	add    esp,0x10
    a34c:	eb 06                	jmp    a354 <_ZN3ata12lba28PIOReadEPvjhh+0x114>
    a34e:	66 90                	xchg   ax,ax
    a350:	a8 08                	test   al,0x8
    a352:	75 1e                	jne    a372 <_ZN3ata12lba28PIOReadEPvjhh+0x132>
    a354:	83 ec 0c             	sub    esp,0xc
    a357:	68 f7 01 00 00       	push   0x1f7
    a35c:	e8 4f 1a 00 00       	call   bdb0 <_Z3inbt>
    a361:	83 c4 10             	add    esp,0x10
    a364:	a8 01                	test   al,0x1
    a366:	74 e8                	je     a350 <_ZN3ata12lba28PIOReadEPvjhh+0x110>
    a368:	83 c4 1c             	add    esp,0x1c
    a36b:	31 c0                	xor    eax,eax
    a36d:	5b                   	pop    ebx
    a36e:	5e                   	pop    esi
    a36f:	5f                   	pop    edi
    a370:	5d                   	pop    ebp
    a371:	c3                   	ret    
    a372:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a376:	89 f3                	mov    ebx,esi
    a378:	c1 e3 09             	shl    ebx,0x9
    a37b:	01 dd                	add    ebp,ebx
    a37d:	03 5c 24 0c          	add    ebx,DWORD PTR [esp+0xc]
    a381:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a388:	83 ec 0c             	sub    esp,0xc
    a38b:	83 c5 02             	add    ebp,0x2
    a38e:	68 f0 01 00 00       	push   0x1f0
    a393:	e8 28 1a 00 00       	call   bdc0 <_Z3inwt>
    a398:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    a39c:	83 c4 10             	add    esp,0x10
    a39f:	39 dd                	cmp    ebp,ebx
    a3a1:	75 e5                	jne    a388 <_ZN3ata12lba28PIOReadEPvjhh+0x148>
    a3a3:	83 c6 01             	add    esi,0x1
    a3a6:	39 f7                	cmp    edi,esi
    a3a8:	0f 85 62 ff ff ff    	jne    a310 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a3ae:	83 c4 1c             	add    esp,0x1c
    a3b1:	b8 01 00 00 00       	mov    eax,0x1
    a3b6:	5b                   	pop    ebx
    a3b7:	5e                   	pop    esi
    a3b8:	5f                   	pop    edi
    a3b9:	5d                   	pop    ebp
    a3ba:	c3                   	ret    
    a3bb:	90                   	nop
    a3bc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000a3c0 <_ZN3ata9lba28ReadEPvyjh>:
    a3c0:	55                   	push   ebp
    a3c1:	57                   	push   edi
    a3c2:	56                   	push   esi
    a3c3:	53                   	push   ebx
    a3c4:	83 ec 1c             	sub    esp,0x1c
    a3c7:	8b 74 24 3c          	mov    esi,DWORD PTR [esp+0x3c]
    a3cb:	8b 4c 24 30          	mov    ecx,DWORD PTR [esp+0x30]
    a3cf:	8b 7c 24 34          	mov    edi,DWORD PTR [esp+0x34]
    a3d3:	8b 6c 24 38          	mov    ebp,DWORD PTR [esp+0x38]
    a3d7:	8b 44 24 40          	mov    eax,DWORD PTR [esp+0x40]
    a3db:	85 f6                	test   esi,esi
    a3dd:	74 59                	je     a438 <_ZN3ata9lba28ReadEPvyjh+0x78>
    a3df:	0f b6 c0             	movzx  eax,al
    a3e2:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a3e6:	eb 1b                	jmp    a403 <_ZN3ata9lba28ReadEPvyjh+0x43>
    a3e8:	90                   	nop
    a3e9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a3f0:	8b 4c 24 08          	mov    ecx,DWORD PTR [esp+0x8]
    a3f4:	31 d2                	xor    edx,edx
    a3f6:	01 df                	add    edi,ebx
    a3f8:	11 d5                	adc    ebp,edx
    a3fa:	c1 e3 09             	shl    ebx,0x9
    a3fd:	01 d9                	add    ecx,ebx
    a3ff:	85 f6                	test   esi,esi
    a401:	74 35                	je     a438 <_ZN3ata9lba28ReadEPvyjh+0x78>
    a403:	81 fe ff 00 00 00    	cmp    esi,0xff
    a409:	bb ff 00 00 00       	mov    ebx,0xff
    a40e:	ff 74 24 0c          	push   DWORD PTR [esp+0xc]
    a412:	0f 46 de             	cmovbe ebx,esi
    a415:	53                   	push   ebx
    a416:	57                   	push   edi
    a417:	29 de                	sub    esi,ebx
    a419:	51                   	push   ecx
    a41a:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    a41e:	e8 1d fe ff ff       	call   a240 <_ZN3ata12lba28PIOReadEPvjhh>
    a423:	83 c4 10             	add    esp,0x10
    a426:	84 c0                	test   al,al
    a428:	75 c6                	jne    a3f0 <_ZN3ata9lba28ReadEPvyjh+0x30>
    a42a:	83 c4 1c             	add    esp,0x1c
    a42d:	5b                   	pop    ebx
    a42e:	5e                   	pop    esi
    a42f:	5f                   	pop    edi
    a430:	5d                   	pop    ebp
    a431:	c3                   	ret    
    a432:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a438:	83 c4 1c             	add    esp,0x1c
    a43b:	b8 01 00 00 00       	mov    eax,0x1
    a440:	5b                   	pop    ebx
    a441:	5e                   	pop    esi
    a442:	5f                   	pop    edi
    a443:	5d                   	pop    ebp
    a444:	c3                   	ret    
    a445:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a449:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000a450 <_ZN3ata12lba48PIOReadEPvyth>:
    a450:	55                   	push   ebp
    a451:	57                   	push   edi
    a452:	56                   	push   esi
    a453:	53                   	push   ebx
    a454:	83 ec 24             	sub    esp,0x24
    a457:	0f b6 44 24 48       	movzx  eax,BYTE PTR [esp+0x48]
    a45c:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    a460:	8b 7c 24 3c          	mov    edi,DWORD PTR [esp+0x3c]
    a464:	8b 5c 24 44          	mov    ebx,DWORD PTR [esp+0x44]
    a468:	c1 e0 04             	shl    eax,0x4
    a46b:	83 c8 e0             	or     eax,0xffffffe0
    a46e:	0f b6 c0             	movzx  eax,al
    a471:	50                   	push   eax
    a472:	68 f6 01 00 00       	push   0x1f6
    a477:	e8 e4 18 00 00       	call   bd60 <_Z4outbth>
    a47c:	58                   	pop    eax
    a47d:	5a                   	pop    edx
    a47e:	6a 00                	push   0x0
    a480:	68 f1 01 00 00       	push   0x1f1
    a485:	e8 d6 18 00 00       	call   bd60 <_Z4outbth>
    a48a:	59                   	pop    ecx
    a48b:	5e                   	pop    esi
    a48c:	0f b6 c7             	movzx  eax,bh
    a48f:	50                   	push   eax
    a490:	68 f2 01 00 00       	push   0x1f2
    a495:	e8 c6 18 00 00       	call   bd60 <_Z4outbth>
    a49a:	58                   	pop    eax
    a49b:	89 f8                	mov    eax,edi
    a49d:	0f ac e8 18          	shrd   eax,ebp,0x18
    a4a1:	5a                   	pop    edx
    a4a2:	0f b6 c0             	movzx  eax,al
    a4a5:	50                   	push   eax
    a4a6:	68 f3 01 00 00       	push   0x1f3
    a4ab:	e8 b0 18 00 00       	call   bd60 <_Z4outbth>
    a4b0:	5e                   	pop    esi
    a4b1:	58                   	pop    eax
    a4b2:	89 e8                	mov    eax,ebp
    a4b4:	0f b6 c0             	movzx  eax,al
    a4b7:	50                   	push   eax
    a4b8:	68 f4 01 00 00       	push   0x1f4
    a4bd:	e8 9e 18 00 00       	call   bd60 <_Z4outbth>
    a4c2:	58                   	pop    eax
    a4c3:	89 e8                	mov    eax,ebp
    a4c5:	5a                   	pop    edx
    a4c6:	0f b6 c4             	movzx  eax,ah
    a4c9:	50                   	push   eax
    a4ca:	68 f5 01 00 00       	push   0x1f5
    a4cf:	e8 8c 18 00 00       	call   bd60 <_Z4outbth>
    a4d4:	59                   	pop    ecx
    a4d5:	5e                   	pop    esi
    a4d6:	0f b6 c3             	movzx  eax,bl
    a4d9:	50                   	push   eax
    a4da:	68 f2 01 00 00       	push   0x1f2
    a4df:	e8 7c 18 00 00       	call   bd60 <_Z4outbth>
    a4e4:	58                   	pop    eax
    a4e5:	89 f8                	mov    eax,edi
    a4e7:	5a                   	pop    edx
    a4e8:	0f b6 c0             	movzx  eax,al
    a4eb:	50                   	push   eax
    a4ec:	68 f3 01 00 00       	push   0x1f3
    a4f1:	e8 6a 18 00 00       	call   bd60 <_Z4outbth>
    a4f6:	89 f8                	mov    eax,edi
    a4f8:	0f ac e8 08          	shrd   eax,ebp,0x8
    a4fc:	59                   	pop    ecx
    a4fd:	5e                   	pop    esi
    a4fe:	0f b6 c0             	movzx  eax,al
    a501:	50                   	push   eax
    a502:	68 f4 01 00 00       	push   0x1f4
    a507:	0f ac ef 10          	shrd   edi,ebp,0x10
    a50b:	e8 50 18 00 00       	call   bd60 <_Z4outbth>
    a510:	5e                   	pop    esi
    a511:	58                   	pop    eax
    a512:	89 f8                	mov    eax,edi
    a514:	0f b6 f0             	movzx  esi,al
    a517:	56                   	push   esi
    a518:	68 f5 01 00 00       	push   0x1f5
    a51d:	e8 3e 18 00 00       	call   bd60 <_Z4outbth>
    a522:	83 c4 10             	add    esp,0x10
    a525:	8d 76 00             	lea    esi,[esi+0x0]
    a528:	83 ec 0c             	sub    esp,0xc
    a52b:	68 f7 01 00 00       	push   0x1f7
    a530:	e8 7b 18 00 00       	call   bdb0 <_Z3inbt>
    a535:	83 c4 10             	add    esp,0x10
    a538:	84 c0                	test   al,al
    a53a:	78 ec                	js     a528 <_ZN3ata12lba48PIOReadEPvyth+0xd8>
    a53c:	83 ec 08             	sub    esp,0x8
    a53f:	89 df                	mov    edi,ebx
    a541:	6a 24                	push   0x24
    a543:	68 f7 01 00 00       	push   0x1f7
    a548:	e8 13 18 00 00       	call   bd60 <_Z4outbth>
    a54d:	83 c4 10             	add    esp,0x10
    a550:	81 e7 ff ff 00 00    	and    edi,0xffff
    a556:	0f 84 b2 00 00 00    	je     a60e <_ZN3ata12lba48PIOReadEPvyth+0x1be>
    a55c:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    a560:	31 f6                	xor    esi,esi
    a562:	05 00 02 00 00       	add    eax,0x200
    a567:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a56b:	90                   	nop
    a56c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a570:	83 ec 0c             	sub    esp,0xc
    a573:	68 f7 01 00 00       	push   0x1f7
    a578:	e8 33 18 00 00       	call   bdb0 <_Z3inbt>
    a57d:	83 c4 10             	add    esp,0x10
    a580:	84 c0                	test   al,al
    a582:	78 ec                	js     a570 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a584:	83 ec 0c             	sub    esp,0xc
    a587:	68 f6 03 00 00       	push   0x3f6
    a58c:	e8 1f 18 00 00       	call   bdb0 <_Z3inbt>
    a591:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a598:	e8 13 18 00 00       	call   bdb0 <_Z3inbt>
    a59d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a5a4:	e8 07 18 00 00       	call   bdb0 <_Z3inbt>
    a5a9:	83 c4 10             	add    esp,0x10
    a5ac:	eb 06                	jmp    a5b4 <_ZN3ata12lba48PIOReadEPvyth+0x164>
    a5ae:	66 90                	xchg   ax,ax
    a5b0:	a8 08                	test   al,0x8
    a5b2:	75 1e                	jne    a5d2 <_ZN3ata12lba48PIOReadEPvyth+0x182>
    a5b4:	83 ec 0c             	sub    esp,0xc
    a5b7:	68 f7 01 00 00       	push   0x1f7
    a5bc:	e8 ef 17 00 00       	call   bdb0 <_Z3inbt>
    a5c1:	83 c4 10             	add    esp,0x10
    a5c4:	a8 01                	test   al,0x1
    a5c6:	74 e8                	je     a5b0 <_ZN3ata12lba48PIOReadEPvyth+0x160>
    a5c8:	83 c4 1c             	add    esp,0x1c
    a5cb:	31 c0                	xor    eax,eax
    a5cd:	5b                   	pop    ebx
    a5ce:	5e                   	pop    esi
    a5cf:	5f                   	pop    edi
    a5d0:	5d                   	pop    ebp
    a5d1:	c3                   	ret    
    a5d2:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a5d6:	89 f3                	mov    ebx,esi
    a5d8:	c1 e3 09             	shl    ebx,0x9
    a5db:	01 dd                	add    ebp,ebx
    a5dd:	03 5c 24 0c          	add    ebx,DWORD PTR [esp+0xc]
    a5e1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a5e8:	83 ec 0c             	sub    esp,0xc
    a5eb:	83 c5 02             	add    ebp,0x2
    a5ee:	68 f0 01 00 00       	push   0x1f0
    a5f3:	e8 c8 17 00 00       	call   bdc0 <_Z3inwt>
    a5f8:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    a5fc:	83 c4 10             	add    esp,0x10
    a5ff:	39 dd                	cmp    ebp,ebx
    a601:	75 e5                	jne    a5e8 <_ZN3ata12lba48PIOReadEPvyth+0x198>
    a603:	83 c6 01             	add    esi,0x1
    a606:	39 fe                	cmp    esi,edi
    a608:	0f 85 62 ff ff ff    	jne    a570 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a60e:	83 c4 1c             	add    esp,0x1c
    a611:	b8 01 00 00 00       	mov    eax,0x1
    a616:	5b                   	pop    ebx
    a617:	5e                   	pop    esi
    a618:	5f                   	pop    edi
    a619:	5d                   	pop    ebp
    a61a:	c3                   	ret    
    a61b:	90                   	nop
    a61c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000a620 <_ZN3ata9lba48ReadEPvyjh>:
    a620:	55                   	push   ebp
    a621:	57                   	push   edi
    a622:	56                   	push   esi
    a623:	53                   	push   ebx
    a624:	83 ec 1c             	sub    esp,0x1c
    a627:	8b 6c 24 3c          	mov    ebp,DWORD PTR [esp+0x3c]
    a62b:	8b 54 24 30          	mov    edx,DWORD PTR [esp+0x30]
    a62f:	8b 74 24 34          	mov    esi,DWORD PTR [esp+0x34]
    a633:	8b 7c 24 38          	mov    edi,DWORD PTR [esp+0x38]
    a637:	8b 44 24 40          	mov    eax,DWORD PTR [esp+0x40]
    a63b:	85 ed                	test   ebp,ebp
    a63d:	74 69                	je     a6a8 <_ZN3ata9lba48ReadEPvyjh+0x88>
    a63f:	0f b6 c0             	movzx  eax,al
    a642:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a646:	eb 1c                	jmp    a664 <_ZN3ata9lba48ReadEPvyjh+0x44>
    a648:	90                   	nop
    a649:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a650:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    a654:	03 34 24             	add    esi,DWORD PTR [esp]
    a657:	13 7c 24 04          	adc    edi,DWORD PTR [esp+0x4]
    a65b:	c1 e3 09             	shl    ebx,0x9
    a65e:	01 da                	add    edx,ebx
    a660:	85 ed                	test   ebp,ebp
    a662:	74 44                	je     a6a8 <_ZN3ata9lba48ReadEPvyjh+0x88>
    a664:	81 fd ff ff 00 00    	cmp    ebp,0xffff
    a66a:	bb ff ff 00 00       	mov    ebx,0xffff
    a66f:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    a676:	00 
    a677:	0f 46 dd             	cmovbe ebx,ebp
    a67a:	83 ec 0c             	sub    esp,0xc
    a67d:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    a681:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    a685:	29 dd                	sub    ebp,ebx
    a687:	53                   	push   ebx
    a688:	57                   	push   edi
    a689:	56                   	push   esi
    a68a:	52                   	push   edx
    a68b:	89 54 24 28          	mov    DWORD PTR [esp+0x28],edx
    a68f:	e8 bc fd ff ff       	call   a450 <_ZN3ata12lba48PIOReadEPvyth>
    a694:	83 c4 20             	add    esp,0x20
    a697:	84 c0                	test   al,al
    a699:	75 b5                	jne    a650 <_ZN3ata9lba48ReadEPvyjh+0x30>
    a69b:	83 c4 1c             	add    esp,0x1c
    a69e:	5b                   	pop    ebx
    a69f:	5e                   	pop    esi
    a6a0:	5f                   	pop    edi
    a6a1:	5d                   	pop    ebp
    a6a2:	c3                   	ret    
    a6a3:	90                   	nop
    a6a4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a6a8:	83 c4 1c             	add    esp,0x1c
    a6ab:	b8 01 00 00 00       	mov    eax,0x1
    a6b0:	5b                   	pop    ebx
    a6b1:	5e                   	pop    esi
    a6b2:	5f                   	pop    edi
    a6b3:	5d                   	pop    ebp
    a6b4:	c3                   	ret    
    a6b5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a6b9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000a6c0 <_ZN3ata4readEPvyjhb>:
    a6c0:	55                   	push   ebp
    a6c1:	57                   	push   edi
    a6c2:	bd c0 a3 00 00       	mov    ebp,0xa3c0
    a6c7:	56                   	push   esi
    a6c8:	53                   	push   ebx
    a6c9:	81 ec 3c 02 00 00    	sub    esp,0x23c
    a6cf:	80 bc 24 64 02 00 00 	cmp    BYTE PTR [esp+0x264],0x0
    a6d6:	00 
    a6d7:	8b 84 24 60 02 00 00 	mov    eax,DWORD PTR [esp+0x260]
    a6de:	8b b4 24 54 02 00 00 	mov    esi,DWORD PTR [esp+0x254]
    a6e5:	8b bc 24 58 02 00 00 	mov    edi,DWORD PTR [esp+0x258]
    a6ec:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    a6f0:	b8 20 a6 00 00       	mov    eax,0xa620
    a6f5:	0f 44 e8             	cmove  ebp,eax
    a6f8:	8b 84 24 5c 02 00 00 	mov    eax,DWORD PTR [esp+0x25c]
    a6ff:	31 d2                	xor    edx,edx
    a701:	89 6c 24 0c          	mov    DWORD PTR [esp+0xc],ebp
    a705:	01 f0                	add    eax,esi
    a707:	11 fa                	adc    edx,edi
    a709:	89 c3                	mov    ebx,eax
    a70b:	89 04 24             	mov    DWORD PTR [esp],eax
    a70e:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    a712:	31 f3                	xor    ebx,esi
    a714:	31 fa                	xor    edx,edi
    a716:	09 da                	or     edx,ebx
    a718:	0f 84 c2 00 00 00    	je     a7e0 <_ZN3ata4readEPvyjhb+0x120>
    a71e:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    a722:	8b 04 24             	mov    eax,DWORD PTR [esp]
    a725:	39 d7                	cmp    edi,edx
    a727:	76 17                	jbe    a740 <_ZN3ata4readEPvyjhb+0x80>
    a729:	31 c0                	xor    eax,eax
    a72b:	81 c4 3c 02 00 00    	add    esp,0x23c
    a731:	5b                   	pop    ebx
    a732:	5e                   	pop    esi
    a733:	5f                   	pop    edi
    a734:	5d                   	pop    ebp
    a735:	c3                   	ret    
    a736:	8d 76 00             	lea    esi,[esi+0x0]
    a739:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    a740:	0f 83 aa 00 00 00    	jae    a7f0 <_ZN3ata4readEPvyjhb+0x130>
    a746:	8b 5c 24 04          	mov    ebx,DWORD PTR [esp+0x4]
    a74a:	89 fa                	mov    edx,edi
    a74c:	8b 0c 24             	mov    ecx,DWORD PTR [esp]
    a74f:	c1 ea 09             	shr    edx,0x9
    a752:	89 f0                	mov    eax,esi
    a754:	0f b6 6c 24 10       	movzx  ebp,BYTE PTR [esp+0x10]
    a759:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    a75d:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    a761:	0f ac d9 09          	shrd   ecx,ebx,0x9
    a765:	0f ac f8 09          	shrd   eax,edi,0x9
    a769:	c1 eb 09             	shr    ebx,0x9
    a76c:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    a770:	89 6c 24 20          	mov    DWORD PTR [esp+0x20],ebp
    a774:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    a778:	31 da                	xor    edx,ebx
    a77a:	31 c8                	xor    eax,ecx
    a77c:	09 c2                	or     edx,eax
    a77e:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    a782:	75 7c                	jne    a800 <_ZN3ata4readEPvyjhb+0x140>
    a784:	83 ec 0c             	sub    esp,0xc
    a787:	55                   	push   ebp
    a788:	6a 01                	push   0x1
    a78a:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    a78e:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    a792:	8d 5c 24 4c          	lea    ebx,[esp+0x4c]
    a796:	53                   	push   ebx
    a797:	8b 44 24 2c          	mov    eax,DWORD PTR [esp+0x2c]
    a79b:	ff d0                	call   eax
    a79d:	83 c4 20             	add    esp,0x20
    a7a0:	84 c0                	test   al,al
    a7a2:	74 87                	je     a72b <_ZN3ata4readEPvyjhb+0x6b>
    a7a4:	8b 0c 24             	mov    ecx,DWORD PTR [esp]
    a7a7:	81 e6 ff 01 00 00    	and    esi,0x1ff
    a7ad:	81 e1 ff 01 00 00    	and    ecx,0x1ff
    a7b3:	39 ce                	cmp    esi,ecx
    a7b5:	0f 83 70 ff ff ff    	jae    a72b <_ZN3ata4readEPvyjhb+0x6b>
    a7bb:	8b bc 24 50 02 00 00 	mov    edi,DWORD PTR [esp+0x250]
    a7c2:	29 f7                	sub    edi,esi
    a7c4:	0f b6 14 33          	movzx  edx,BYTE PTR [ebx+esi*1]
    a7c8:	88 14 37             	mov    BYTE PTR [edi+esi*1],dl
    a7cb:	83 c6 01             	add    esi,0x1
    a7ce:	39 ce                	cmp    esi,ecx
    a7d0:	72 f2                	jb     a7c4 <_ZN3ata4readEPvyjhb+0x104>
    a7d2:	81 c4 3c 02 00 00    	add    esp,0x23c
    a7d8:	5b                   	pop    ebx
    a7d9:	5e                   	pop    esi
    a7da:	5f                   	pop    edi
    a7db:	5d                   	pop    ebp
    a7dc:	c3                   	ret    
    a7dd:	8d 76 00             	lea    esi,[esi+0x0]
    a7e0:	81 c4 3c 02 00 00    	add    esp,0x23c
    a7e6:	b8 01 00 00 00       	mov    eax,0x1
    a7eb:	5b                   	pop    ebx
    a7ec:	5e                   	pop    esi
    a7ed:	5f                   	pop    edi
    a7ee:	5d                   	pop    ebp
    a7ef:	c3                   	ret    
    a7f0:	39 c6                	cmp    esi,eax
    a7f2:	0f 87 31 ff ff ff    	ja     a729 <_ZN3ata4readEPvyjhb+0x69>
    a7f8:	e9 49 ff ff ff       	jmp    a746 <_ZN3ata4readEPvyjhb+0x86>
    a7fd:	8d 76 00             	lea    esi,[esi+0x0]
    a800:	89 f0                	mov    eax,esi
    a802:	25 ff 01 00 00       	and    eax,0x1ff
    a807:	89 c5                	mov    ebp,eax
    a809:	89 44 24 24          	mov    DWORD PTR [esp+0x24],eax
    a80d:	0f 84 6d 01 00 00    	je     a980 <_ZN3ata4readEPvyjhb+0x2c0>
    a813:	83 ec 0c             	sub    esp,0xc
    a816:	ff 74 24 2c          	push   DWORD PTR [esp+0x2c]
    a81a:	6a 01                	push   0x1
    a81c:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    a820:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    a824:	8d 5c 24 4c          	lea    ebx,[esp+0x4c]
    a828:	53                   	push   ebx
    a829:	8b 44 24 2c          	mov    eax,DWORD PTR [esp+0x2c]
    a82d:	ff d0                	call   eax
    a82f:	83 c4 20             	add    esp,0x20
    a832:	84 c0                	test   al,al
    a834:	0f 84 f1 fe ff ff    	je     a72b <_ZN3ata4readEPvyjhb+0x6b>
    a83a:	8b 94 24 50 02 00 00 	mov    edx,DWORD PTR [esp+0x250]
    a841:	89 e8                	mov    eax,ebp
    a843:	89 6c 24 2c          	mov    DWORD PTR [esp+0x2c],ebp
    a847:	29 ea                	sub    edx,ebp
    a849:	8b 6c 24 0c          	mov    ebp,DWORD PTR [esp+0xc]
    a84d:	8d 76 00             	lea    esi,[esi+0x0]
    a850:	0f b6 0c 03          	movzx  ecx,BYTE PTR [ebx+eax*1]
    a854:	88 0c 02             	mov    BYTE PTR [edx+eax*1],cl
    a857:	83 c0 01             	add    eax,0x1
    a85a:	3d 00 02 00 00       	cmp    eax,0x200
    a85f:	75 ef                	jne    a850 <_ZN3ata4readEPvyjhb+0x190>
    a861:	8b 04 24             	mov    eax,DWORD PTR [esp]
    a864:	83 44 24 10 01       	add    DWORD PTR [esp+0x10],0x1
    a869:	83 54 24 14 00       	adc    DWORD PTR [esp+0x14],0x0
    a86e:	89 6c 24 0c          	mov    DWORD PTR [esp+0xc],ebp
    a872:	25 ff 01 00 00       	and    eax,0x1ff
    a877:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    a87b:	0f 84 ea 00 00 00    	je     a96b <_ZN3ata4readEPvyjhb+0x2ab>
    a881:	83 ec 0c             	sub    esp,0xc
    a884:	ff 74 24 2c          	push   DWORD PTR [esp+0x2c]
    a888:	6a 01                	push   0x1
    a88a:	8b 44 24 2c          	mov    eax,DWORD PTR [esp+0x2c]
    a88e:	8b 54 24 30          	mov    edx,DWORD PTR [esp+0x30]
    a892:	83 c0 01             	add    eax,0x1
    a895:	83 d2 00             	adc    edx,0x0
    a898:	52                   	push   edx
    a899:	50                   	push   eax
    a89a:	53                   	push   ebx
    a89b:	8b 44 24 2c          	mov    eax,DWORD PTR [esp+0x2c]
    a89f:	ff d0                	call   eax
    a8a1:	83 c4 20             	add    esp,0x20
    a8a4:	84 c0                	test   al,al
    a8a6:	0f 84 7f fe ff ff    	je     a72b <_ZN3ata4readEPvyjhb+0x6b>
    a8ac:	8b 04 24             	mov    eax,DWORD PTR [esp]
    a8af:	8b 94 24 5c 02 00 00 	mov    edx,DWORD PTR [esp+0x25c]
    a8b6:	8b 8c 24 50 02 00 00 	mov    ecx,DWORD PTR [esp+0x250]
    a8bd:	89 34 24             	mov    DWORD PTR [esp],esi
    a8c0:	89 7c 24 04          	mov    DWORD PTR [esp+0x4],edi
    a8c4:	8b 6c 24 0c          	mov    ebp,DWORD PTR [esp+0xc]
    a8c8:	25 ff 01 00 00       	and    eax,0x1ff
    a8cd:	8b 7c 24 20          	mov    edi,DWORD PTR [esp+0x20]
    a8d1:	8b 74 24 28          	mov    esi,DWORD PTR [esp+0x28]
    a8d5:	29 c2                	sub    edx,eax
    a8d7:	89 d0                	mov    eax,edx
    a8d9:	31 d2                	xor    edx,edx
    a8db:	01 c8                	add    eax,ecx
    a8dd:	89 c1                	mov    ecx,eax
    a8df:	90                   	nop
    a8e0:	0f b6 04 13          	movzx  eax,BYTE PTR [ebx+edx*1]
    a8e4:	88 04 11             	mov    BYTE PTR [ecx+edx*1],al
    a8e7:	83 c2 01             	add    edx,0x1
    a8ea:	39 f2                	cmp    edx,esi
    a8ec:	75 f2                	jne    a8e0 <_ZN3ata4readEPvyjhb+0x220>
    a8ee:	8b 54 24 24          	mov    edx,DWORD PTR [esp+0x24]
    a8f2:	83 44 24 18 ff       	add    DWORD PTR [esp+0x18],0xffffffff
    a8f7:	83 54 24 1c ff       	adc    DWORD PTR [esp+0x1c],0xffffffff
    a8fc:	31 c0                	xor    eax,eax
    a8fe:	89 6c 24 0c          	mov    DWORD PTR [esp+0xc],ebp
    a902:	89 7c 24 20          	mov    DWORD PTR [esp+0x20],edi
    a906:	8b 34 24             	mov    esi,DWORD PTR [esp]
    a909:	85 d2                	test   edx,edx
    a90b:	75 53                	jne    a960 <_ZN3ata4readEPvyjhb+0x2a0>
    a90d:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    a911:	8b 5c 24 14          	mov    ebx,DWORD PTR [esp+0x14]
    a915:	8b 74 24 18          	mov    esi,DWORD PTR [esp+0x18]
    a919:	8b 7c 24 1c          	mov    edi,DWORD PTR [esp+0x1c]
    a91d:	89 ca                	mov    edx,ecx
    a91f:	31 f2                	xor    edx,esi
    a921:	31 fb                	xor    ebx,edi
    a923:	09 d3                	or     ebx,edx
    a925:	0f 84 b5 fe ff ff    	je     a7e0 <_ZN3ata4readEPvyjhb+0x120>
    a92b:	01 84 24 50 02 00 00 	add    DWORD PTR [esp+0x250],eax
    a932:	83 ec 0c             	sub    esp,0xc
    a935:	ff 74 24 2c          	push   DWORD PTR [esp+0x2c]
    a939:	8b 44 24 28          	mov    eax,DWORD PTR [esp+0x28]
    a93d:	8b 4c 24 20          	mov    ecx,DWORD PTR [esp+0x20]
    a941:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    a945:	29 c8                	sub    eax,ecx
    a947:	50                   	push   eax
    a948:	53                   	push   ebx
    a949:	51                   	push   ecx
    a94a:	ff b4 24 6c 02 00 00 	push   DWORD PTR [esp+0x26c]
    a951:	8b 44 24 2c          	mov    eax,DWORD PTR [esp+0x2c]
    a955:	ff d0                	call   eax
    a957:	83 c4 20             	add    esp,0x20
    a95a:	e9 cc fd ff ff       	jmp    a72b <_ZN3ata4readEPvyjhb+0x6b>
    a95f:	90                   	nop
    a960:	89 f0                	mov    eax,esi
    a962:	25 ff 01 00 00       	and    eax,0x1ff
    a967:	89 44 24 2c          	mov    DWORD PTR [esp+0x2c],eax
    a96b:	b8 00 02 00 00       	mov    eax,0x200
    a970:	2b 44 24 2c          	sub    eax,DWORD PTR [esp+0x2c]
    a974:	eb 97                	jmp    a90d <_ZN3ata4readEPvyjhb+0x24d>
    a976:	8d 76 00             	lea    esi,[esi+0x0]
    a979:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    a980:	8b 04 24             	mov    eax,DWORD PTR [esp]
    a983:	25 ff 01 00 00       	and    eax,0x1ff
    a988:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    a98c:	74 a4                	je     a932 <_ZN3ata4readEPvyjhb+0x272>
    a98e:	8d 5c 24 30          	lea    ebx,[esp+0x30]
    a992:	e9 ea fe ff ff       	jmp    a881 <_ZN3ata4readEPvyjhb+0x1c1>
    a997:	89 f6                	mov    esi,esi
    a999:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000a9a0 <_ZN3ata12sendIdentifyEhRbb>:
    a9a0:	55                   	push   ebp
    a9a1:	57                   	push   edi
    a9a2:	56                   	push   esi
    a9a3:	53                   	push   ebx
    a9a4:	81 ec 38 02 00 00    	sub    esp,0x238
    a9aa:	8b 9c 24 4c 02 00 00 	mov    ebx,DWORD PTR [esp+0x24c]
    a9b1:	8b ac 24 54 02 00 00 	mov    ebp,DWORD PTR [esp+0x254]
    a9b8:	68 f7 01 00 00       	push   0x1f7
    a9bd:	e8 ee 13 00 00       	call   bdb0 <_Z3inbt>
    a9c2:	83 c4 10             	add    esp,0x10
    a9c5:	3c ff                	cmp    al,0xff
    a9c7:	0f 84 e3 00 00 00    	je     aab0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a9cd:	c1 e3 04             	shl    ebx,0x4
    a9d0:	83 ec 08             	sub    esp,0x8
    a9d3:	83 cb a0             	or     ebx,0xffffffa0
    a9d6:	0f b6 c3             	movzx  eax,bl
    a9d9:	50                   	push   eax
    a9da:	68 f6 01 00 00       	push   0x1f6
    a9df:	e8 7c 13 00 00       	call   bd60 <_Z4outbth>
    a9e4:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a9eb:	e8 c0 13 00 00       	call   bdb0 <_Z3inbt>
    a9f0:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a9f7:	e8 b4 13 00 00       	call   bdb0 <_Z3inbt>
    a9fc:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    aa03:	e8 a8 13 00 00       	call   bdb0 <_Z3inbt>
    aa08:	83 c4 10             	add    esp,0x10
    aa0b:	90                   	nop
    aa0c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    aa10:	83 ec 0c             	sub    esp,0xc
    aa13:	68 f7 01 00 00       	push   0x1f7
    aa18:	e8 93 13 00 00       	call   bdb0 <_Z3inbt>
    aa1d:	83 c4 10             	add    esp,0x10
    aa20:	84 c0                	test   al,al
    aa22:	78 ec                	js     aa10 <_ZN3ata12sendIdentifyEhRbb+0x70>
    aa24:	83 ec 08             	sub    esp,0x8
    aa27:	6a 00                	push   0x0
    aa29:	68 f2 01 00 00       	push   0x1f2
    aa2e:	e8 2d 13 00 00       	call   bd60 <_Z4outbth>
    aa33:	59                   	pop    ecx
    aa34:	5b                   	pop    ebx
    aa35:	6a 00                	push   0x0
    aa37:	68 f3 01 00 00       	push   0x1f3
    aa3c:	e8 1f 13 00 00       	call   bd60 <_Z4outbth>
    aa41:	5e                   	pop    esi
    aa42:	5f                   	pop    edi
    aa43:	6a 00                	push   0x0
    aa45:	68 f4 01 00 00       	push   0x1f4
    aa4a:	e8 11 13 00 00       	call   bd60 <_Z4outbth>
    aa4f:	58                   	pop    eax
    aa50:	5a                   	pop    edx
    aa51:	6a 00                	push   0x0
    aa53:	68 f5 01 00 00       	push   0x1f5
    aa58:	e8 03 13 00 00       	call   bd60 <_Z4outbth>
    aa5d:	59                   	pop    ecx
    aa5e:	5b                   	pop    ebx
    aa5f:	68 ec 00 00 00       	push   0xec
    aa64:	68 f7 01 00 00       	push   0x1f7
    aa69:	e8 f2 12 00 00       	call   bd60 <_Z4outbth>
    aa6e:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    aa75:	e8 36 13 00 00       	call   bdb0 <_Z3inbt>
    aa7a:	83 c4 10             	add    esp,0x10
    aa7d:	84 c0                	test   al,al
    aa7f:	74 2f                	je     aab0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    aa81:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    aa88:	83 ec 0c             	sub    esp,0xc
    aa8b:	68 f7 01 00 00       	push   0x1f7
    aa90:	e8 1b 13 00 00       	call   bdb0 <_Z3inbt>
    aa95:	83 c4 10             	add    esp,0x10
    aa98:	84 c0                	test   al,al
    aa9a:	78 ec                	js     aa88 <_ZN3ata12sendIdentifyEhRbb+0xe8>
    aa9c:	83 ec 0c             	sub    esp,0xc
    aa9f:	68 f4 01 00 00       	push   0x1f4
    aaa4:	e8 07 13 00 00       	call   bdb0 <_Z3inbt>
    aaa9:	83 c4 10             	add    esp,0x10
    aaac:	84 c0                	test   al,al
    aaae:	74 10                	je     aac0 <_ZN3ata12sendIdentifyEhRbb+0x120>
    aab0:	31 c0                	xor    eax,eax
    aab2:	81 c4 2c 02 00 00    	add    esp,0x22c
    aab8:	5b                   	pop    ebx
    aab9:	5e                   	pop    esi
    aaba:	5f                   	pop    edi
    aabb:	5d                   	pop    ebp
    aabc:	c3                   	ret    
    aabd:	8d 76 00             	lea    esi,[esi+0x0]
    aac0:	83 ec 0c             	sub    esp,0xc
    aac3:	68 f5 01 00 00       	push   0x1f5
    aac8:	e8 e3 12 00 00       	call   bdb0 <_Z3inbt>
    aacd:	83 c4 10             	add    esp,0x10
    aad0:	84 c0                	test   al,al
    aad2:	74 10                	je     aae4 <_ZN3ata12sendIdentifyEhRbb+0x144>
    aad4:	eb da                	jmp    aab0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    aad6:	8d 76 00             	lea    esi,[esi+0x0]
    aad9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    aae0:	a8 08                	test   al,0x8
    aae2:	75 16                	jne    aafa <_ZN3ata12sendIdentifyEhRbb+0x15a>
    aae4:	83 ec 0c             	sub    esp,0xc
    aae7:	68 f7 01 00 00       	push   0x1f7
    aaec:	e8 bf 12 00 00       	call   bdb0 <_Z3inbt>
    aaf1:	83 c4 10             	add    esp,0x10
    aaf4:	a8 01                	test   al,0x1
    aaf6:	74 e8                	je     aae0 <_ZN3ata12sendIdentifyEhRbb+0x140>
    aaf8:	eb b6                	jmp    aab0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    aafa:	8d 7c 24 20          	lea    edi,[esp+0x20]
    aafe:	b9 80 00 00 00       	mov    ecx,0x80
    ab03:	31 c0                	xor    eax,eax
    ab05:	8d b4 24 20 02 00 00 	lea    esi,[esp+0x220]
    ab0c:	8d 5c 24 20          	lea    ebx,[esp+0x20]
    ab10:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    ab12:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ab18:	83 ec 0c             	sub    esp,0xc
    ab1b:	83 c3 02             	add    ebx,0x2
    ab1e:	68 f0 01 00 00       	push   0x1f0
    ab23:	e8 98 12 00 00       	call   bdc0 <_Z3inwt>
    ab28:	66 89 43 fe          	mov    WORD PTR [ebx-0x2],ax
    ab2c:	83 c4 10             	add    esp,0x10
    ab2f:	39 de                	cmp    esi,ebx
    ab31:	75 e5                	jne    ab18 <_ZN3ata12sendIdentifyEhRbb+0x178>
    ab33:	0f b7 84 24 c6 00 00 	movzx  eax,WORD PTR [esp+0xc6]
    ab3a:	00 
    ab3b:	66 89 44 24 0a       	mov    WORD PTR [esp+0xa],ax
    ab40:	89 e8                	mov    eax,ebp
    ab42:	84 c0                	test   al,al
    ab44:	75 22                	jne    ab68 <_ZN3ata12sendIdentifyEhRbb+0x1c8>
    ab46:	0f b7 44 24 0a       	movzx  eax,WORD PTR [esp+0xa]
    ab4b:	8b 94 24 44 02 00 00 	mov    edx,DWORD PTR [esp+0x244]
    ab52:	66 c1 e8 0a          	shr    ax,0xa
    ab56:	83 f0 01             	xor    eax,0x1
    ab59:	83 e0 01             	and    eax,0x1
    ab5c:	88 02                	mov    BYTE PTR [edx],al
    ab5e:	b8 01 00 00 00       	mov    eax,0x1
    ab63:	e9 4a ff ff ff       	jmp    aab2 <_ZN3ata12sendIdentifyEhRbb+0x112>
    ab68:	83 ec 0c             	sub    esp,0xc
    ab6b:	68 0a e2 00 00       	push   0xe20a
    ab70:	e8 bb 10 00 00       	call   bc30 <_Z6printfPKc>
    ab75:	83 c4 10             	add    esp,0x10
    ab78:	8d 74 24 20          	lea    esi,[esp+0x20]
    ab7c:	8d 6c 24 1c          	lea    ebp,[esp+0x1c]
    ab80:	8d 7e 20             	lea    edi,[esi+0x20]
    ab83:	90                   	nop
    ab84:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ab88:	0f b7 06             	movzx  eax,WORD PTR [esi]
    ab8b:	83 ec 08             	sub    esp,0x8
    ab8e:	83 c6 02             	add    esi,0x2
    ab91:	66 89 44 24 24       	mov    WORD PTR [esp+0x24],ax
    ab96:	55                   	push   ebp
    ab97:	68 1e e2 00 00       	push   0xe21e
    ab9c:	e8 cf 20 00 00       	call   cc70 <_Z14_manage_escapeItEiPKcPT_>
    aba1:	05 1e e2 00 00       	add    eax,0xe21e
    aba6:	89 04 24             	mov    DWORD PTR [esp],eax
    aba9:	e8 82 10 00 00       	call   bc30 <_Z6printfPKc>
    abae:	83 c4 10             	add    esp,0x10
    abb1:	39 f7                	cmp    edi,esi
    abb3:	75 d3                	jne    ab88 <_ZN3ata12sendIdentifyEhRbb+0x1e8>
    abb5:	83 ec 0c             	sub    esp,0xc
    abb8:	68 d3 e2 00 00       	push   0xe2d3
    abbd:	e8 6e 10 00 00       	call   bc30 <_Z6printfPKc>
    abc2:	83 c4 10             	add    esp,0x10
    abc5:	39 fb                	cmp    ebx,edi
    abc7:	75 b7                	jne    ab80 <_ZN3ata12sendIdentifyEhRbb+0x1e0>
    abc9:	0f b7 84 24 d0 00 00 	movzx  eax,WORD PTR [esp+0xd0]
    abd0:	00 
    abd1:	31 ed                	xor    ebp,ebp
    abd3:	50                   	push   eax
    abd4:	0f b7 44 24 0e       	movzx  eax,WORD PTR [esp+0xe]
    abd9:	50                   	push   eax
    abda:	0f b7 44 24 28       	movzx  eax,WORD PTR [esp+0x28]
    abdf:	50                   	push   eax
    abe0:	68 21 e2 00 00       	push   0xe221
    abe5:	e8 96 21 00 00       	call   cd80 <_Z6printfItJttEEvPKcT_DpT0_>
    abea:	58                   	pop    eax
    abeb:	5a                   	pop    edx
    abec:	ff b4 24 a0 00 00 00 	push   DWORD PTR [esp+0xa0]
    abf3:	68 39 e2 00 00       	push   0xe239
    abf8:	e8 b3 1c 00 00       	call   c8b0 <_Z6printfIiEvPKcT_>
    abfd:	0f b7 84 24 fc 00 00 	movzx  eax,WORD PTR [esp+0xfc]
    ac04:	00 
    ac05:	0f b7 bc 24 fe 00 00 	movzx  edi,WORD PTR [esp+0xfe]
    ac0c:	00 
    ac0d:	ba 31 00 00 00       	mov    edx,0x31
    ac12:	89 c6                	mov    esi,eax
    ac14:	0f b7 84 24 fa 00 00 	movzx  eax,WORD PTR [esp+0xfa]
    ac1b:	00 
    ac1c:	66 89 44 24 1c       	mov    WORD PTR [esp+0x1c],ax
    ac21:	0f b7 84 24 f8 00 00 	movzx  eax,WORD PTR [esp+0xf8]
    ac28:	00 
    ac29:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    ac2e:	83 c4 10             	add    esp,0x10
    ac31:	8d 5d 01             	lea    ebx,[ebp+0x1]
    ac34:	80 fa 25             	cmp    dl,0x25
    ac37:	0f b6 83 46 e2 00 00 	movzx  eax,BYTE PTR [ebx+0xe246]
    ac3e:	8d 8b 46 e2 00 00    	lea    ecx,[ebx+0xe246]
    ac44:	75 21                	jne    ac67 <_ZN3ata12sendIdentifyEhRbb+0x2c7>
    ac46:	3c 25                	cmp    al,0x25
    ac48:	0f 84 9d 00 00 00    	je     aceb <_ZN3ata12sendIdentifyEhRbb+0x34b>
    ac4e:	84 c0                	test   al,al
    ac50:	75 6e                	jne    acc0 <_ZN3ata12sendIdentifyEhRbb+0x320>
    ac52:	8d 5d 02             	lea    ebx,[ebp+0x2]
    ac55:	0f b6 83 46 e2 00 00 	movzx  eax,BYTE PTR [ebx+0xe246]
    ac5c:	84 c0                	test   al,al
    ac5e:	74 20                	je     ac80 <_ZN3ata12sendIdentifyEhRbb+0x2e0>
    ac60:	0f be d0             	movsx  edx,al
    ac63:	89 dd                	mov    ebp,ebx
    ac65:	eb ca                	jmp    ac31 <_ZN3ata12sendIdentifyEhRbb+0x291>
    ac67:	88 44 24 0f          	mov    BYTE PTR [esp+0xf],al
    ac6b:	83 ec 0c             	sub    esp,0xc
    ac6e:	52                   	push   edx
    ac6f:	e8 3c 0f 00 00       	call   bbb0 <_Z7putcharc>
    ac74:	83 c4 10             	add    esp,0x10
    ac77:	0f b6 44 24 0f       	movzx  eax,BYTE PTR [esp+0xf]
    ac7c:	84 c0                	test   al,al
    ac7e:	75 e0                	jne    ac60 <_ZN3ata12sendIdentifyEhRbb+0x2c0>
    ac80:	8d 5c 24 56          	lea    ebx,[esp+0x56]
    ac84:	8d 7c 24 7e          	lea    edi,[esp+0x7e]
    ac88:	90                   	nop
    ac89:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ac90:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    ac93:	83 ec 08             	sub    esp,0x8
    ac96:	83 c3 01             	add    ebx,0x1
    ac99:	50                   	push   eax
    ac9a:	68 5e e2 00 00       	push   0xe25e
    ac9f:	e8 dc 1d 00 00       	call   ca80 <_Z6printfIcEvPKcT_>
    aca4:	83 c4 10             	add    esp,0x10
    aca7:	39 df                	cmp    edi,ebx
    aca9:	75 e5                	jne    ac90 <_ZN3ata12sendIdentifyEhRbb+0x2f0>
    acab:	83 ec 0c             	sub    esp,0xc
    acae:	68 d3 e2 00 00       	push   0xe2d3
    acb3:	e8 78 0f 00 00       	call   bc30 <_Z6printfPKc>
    acb8:	83 c4 10             	add    esp,0x10
    acbb:	e9 86 fe ff ff       	jmp    ab46 <_ZN3ata12sendIdentifyEhRbb+0x1a6>
    acc0:	83 ec 08             	sub    esp,0x8
    acc3:	8d 44 24 26          	lea    eax,[esp+0x26]
    acc7:	50                   	push   eax
    acc8:	51                   	push   ecx
    acc9:	e8 a2 1f 00 00       	call   cc70 <_Z14_manage_escapeItEiPKcPT_>
    acce:	0f b7 d6             	movzx  edx,si
    acd1:	57                   	push   edi
    acd2:	8d 84 03 46 e2 00 00 	lea    eax,[ebx+eax*1+0xe246]
    acd9:	52                   	push   edx
    acda:	0f b7 54 24 24       	movzx  edx,WORD PTR [esp+0x24]
    acdf:	52                   	push   edx
    ace0:	50                   	push   eax
    ace1:	e8 9a 20 00 00       	call   cd80 <_Z6printfItJttEEvPKcT_DpT0_>
    ace6:	83 c4 20             	add    esp,0x20
    ace9:	eb 95                	jmp    ac80 <_ZN3ata12sendIdentifyEhRbb+0x2e0>
    aceb:	83 ec 0c             	sub    esp,0xc
    acee:	8d 5d 02             	lea    ebx,[ebp+0x2]
    acf1:	6a 25                	push   0x25
    acf3:	e8 b8 0e 00 00       	call   bbb0 <_Z7putcharc>
    acf8:	0f b6 83 46 e2 00 00 	movzx  eax,BYTE PTR [ebx+0xe246]
    acff:	83 c4 10             	add    esp,0x10
    ad02:	84 c0                	test   al,al
    ad04:	0f 85 56 ff ff ff    	jne    ac60 <_ZN3ata12sendIdentifyEhRbb+0x2c0>
    ad0a:	e9 71 ff ff ff       	jmp    ac80 <_ZN3ata12sendIdentifyEhRbb+0x2e0>
    ad0f:	90                   	nop

0000ad10 <_ZN6paging18init_kernel_pagingEv>:
    ad10:	57                   	push   edi
    ad11:	56                   	push   esi
    ad12:	b8 00 00 10 00       	mov    eax,0x100000
    ad17:	53                   	push   ebx
    ad18:	90                   	nop
    ad19:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ad20:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    ad26:	83 c0 04             	add    eax,0x4
    ad29:	3d 00 10 10 00       	cmp    eax,0x101000
    ad2e:	75 f0                	jne    ad20 <_ZN6paging18init_kernel_pagingEv+0x10>
    ad30:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    ad36:	83 c0 04             	add    eax,0x4
    ad39:	3d 00 10 50 00       	cmp    eax,0x501000
    ad3e:	75 f0                	jne    ad30 <_ZN6paging18init_kernel_pagingEv+0x20>
    ad40:	c7 05 00 00 10 00 87 	mov    DWORD PTR ds:0x100000,0x87
    ad47:	00 00 00 
    ad4a:	c7 05 04 00 10 00 87 	mov    DWORD PTR ds:0x100004,0x400087
    ad51:	00 40 00 
    ad54:	31 c0                	xor    eax,eax
    ad56:	c7 05 08 0c 10 00 87 	mov    DWORD PTR ds:0x100c08,0x800087
    ad5d:	00 80 00 
    ad60:	c7 05 0c 0c 10 00 87 	mov    DWORD PTR ds:0x100c0c,0xc00087
    ad67:	00 c0 00 
    ad6a:	c7 05 10 0c 10 00 87 	mov    DWORD PTR ds:0x100c10,0x1000087
    ad71:	00 00 01 
    ad74:	c7 05 14 0c 10 00 87 	mov    DWORD PTR ds:0x100c14,0x1400087
    ad7b:	00 40 01 
    ad7e:	c7 05 18 0c 10 00 87 	mov    DWORD PTR ds:0x100c18,0x1800087
    ad85:	00 80 01 
    ad88:	c7 05 1c 0c 10 00 87 	mov    DWORD PTR ds:0x100c1c,0x1c00087
    ad8f:	00 c0 01 
    ad92:	c7 05 20 0c 10 00 87 	mov    DWORD PTR ds:0x100c20,0x2000087
    ad99:	00 00 02 
    ad9c:	c7 05 24 0c 10 00 87 	mov    DWORD PTR ds:0x100c24,0x2400087
    ada3:	00 40 02 
    ada6:	c7 05 28 0c 10 00 87 	mov    DWORD PTR ds:0x100c28,0x2800087
    adad:	00 80 02 
    adb0:	c7 05 2c 0c 10 00 87 	mov    DWORD PTR ds:0x100c2c,0x2c00087
    adb7:	00 c0 02 
    adba:	c7 05 30 0c 10 00 87 	mov    DWORD PTR ds:0x100c30,0x3000087
    adc1:	00 00 03 
    adc4:	c7 05 34 0c 10 00 87 	mov    DWORD PTR ds:0x100c34,0x3400087
    adcb:	00 40 03 
    adce:	c7 05 38 0c 10 00 87 	mov    DWORD PTR ds:0x100c38,0x3800087
    add5:	00 80 03 
    add8:	c7 05 3c 0c 10 00 87 	mov    DWORD PTR ds:0x100c3c,0x3c00087
    addf:	00 c0 03 
    ade2:	c7 05 00 00 00 02 00 	mov    DWORD PTR ds:0x2000000,0x0
    ade9:	00 00 00 
    adec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    adf0:	c7 04 85 04 00 00 02 	mov    DWORD PTR [eax*4+0x2000004],0x0
    adf7:	00 00 00 00 
    adfb:	83 c0 01             	add    eax,0x1
    adfe:	3d 00 80 00 00       	cmp    eax,0x8000
    ae03:	75 eb                	jne    adf0 <_ZN6paging18init_kernel_pagingEv+0xe0>
    ae05:	e8 f6 00 00 00       	call   af00 <_ZN4boot12get_ram_sizeEv>
    ae0a:	c1 e8 0c             	shr    eax,0xc
    ae0d:	3d 00 40 00 00       	cmp    eax,0x4000
    ae12:	76 4b                	jbe    ae5f <_ZN6paging18init_kernel_pagingEv+0x14f>
    ae14:	8b 15 00 00 00 02    	mov    edx,DWORD PTR ds:0x2000000
    ae1a:	b9 00 40 00 00       	mov    ecx,0x4000
    ae1f:	be 01 00 00 00       	mov    esi,0x1
    ae24:	8d 9a 00 c0 ff ff    	lea    ebx,[edx-0x4000]
    ae2a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ae30:	8d bc 19 00 80 00 00 	lea    edi,[ecx+ebx*1+0x8000]
    ae37:	89 ca                	mov    edx,ecx
    ae39:	c1 e2 0c             	shl    edx,0xc
    ae3c:	89 14 bd 04 00 00 02 	mov    DWORD PTR [edi*4+0x2000004],edx
    ae43:	89 f7                	mov    edi,esi
    ae45:	c1 ea 11             	shr    edx,0x11
    ae48:	d3 e7                	shl    edi,cl
    ae4a:	83 c1 01             	add    ecx,0x1
    ae4d:	09 3c 95 04 00 00 02 	or     DWORD PTR [edx*4+0x2000004],edi
    ae54:	39 c8                	cmp    eax,ecx
    ae56:	75 d8                	jne    ae30 <_ZN6paging18init_kernel_pagingEv+0x120>
    ae58:	01 d8                	add    eax,ebx
    ae5a:	a3 00 00 00 02       	mov    ds:0x2000000,eax
    ae5f:	83 ec 0c             	sub    esp,0xc
    ae62:	68 00 00 10 00       	push   0x100000
    ae67:	e8 f3 f2 ff ff       	call   a15f <__setCR3>
    ae6c:	e8 ea f2 ff ff       	call   a15b <__getCR4>
    ae71:	83 c8 10             	or     eax,0x10
    ae74:	89 04 24             	mov    DWORD PTR [esp],eax
    ae77:	e8 d4 f2 ff ff       	call   a150 <__setCR4>
    ae7c:	e8 07 f3 ff ff       	call   a188 <__getCR0>
    ae81:	0d 01 00 00 80       	or     eax,0x80000001
    ae86:	89 04 24             	mov    DWORD PTR [esp],eax
    ae89:	e8 ef f2 ff ff       	call   a17d <__setCR0>
    ae8e:	83 c4 10             	add    esp,0x10
    ae91:	5b                   	pop    ebx
    ae92:	5e                   	pop    esi
    ae93:	5f                   	pop    edi
    ae94:	c3                   	ret    
    ae95:	90                   	nop
    ae96:	8d 76 00             	lea    esi,[esi+0x0]
    ae99:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000aea0 <_ZN9PhysPages4initEv>:
    aea0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    aea4:	c7 02 00 00 00 00    	mov    DWORD PTR [edx],0x0
    aeaa:	8d 42 04             	lea    eax,[edx+0x4]
    aead:	81 c2 04 00 02 00    	add    edx,0x20004
    aeb3:	90                   	nop
    aeb4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    aeb8:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    aebe:	83 c0 04             	add    eax,0x4
    aec1:	39 d0                	cmp    eax,edx
    aec3:	75 f3                	jne    aeb8 <_ZN9PhysPages4initEv+0x18>
    aec5:	f3 c3                	repz ret 
    aec7:	90                   	nop
    aec8:	90                   	nop
    aec9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000aed0 <_ZN9PhysPages8add_pageEj>:
    aed0:	53                   	push   ebx
    aed1:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    aed5:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    aed9:	8b 10                	mov    edx,DWORD PTR [eax]
    aedb:	8d 5a 01             	lea    ebx,[edx+0x1]
    aede:	89 18                	mov    DWORD PTR [eax],ebx
    aee0:	89 cb                	mov    ebx,ecx
    aee2:	89 8c 90 04 00 02 00 	mov    DWORD PTR [eax+edx*4+0x20004],ecx
    aee9:	c1 eb 11             	shr    ebx,0x11
    aeec:	c1 e9 0c             	shr    ecx,0xc
    aeef:	ba 01 00 00 00       	mov    edx,0x1
    aef4:	d3 e2                	shl    edx,cl
    aef6:	09 54 98 04          	or     DWORD PTR [eax+ebx*4+0x4],edx
    aefa:	5b                   	pop    ebx
    aefb:	c3                   	ret    
    aefc:	66 90                	xchg   ax,ax
    aefe:	66 90                	xchg   ax,ax

0000af00 <_ZN4boot12get_ram_sizeEv>:
    af00:	0f b7 05 02 05 00 00 	movzx  eax,WORD PTR ds:0x502
    af07:	0f b7 15 00 05 00 00 	movzx  edx,WORD PTR ds:0x500
    af0e:	c1 e0 06             	shl    eax,0x6
    af11:	01 d0                	add    eax,edx
    af13:	c1 e0 0a             	shl    eax,0xa
    af16:	c3                   	ret    
    af17:	66 90                	xchg   ax,ax
    af19:	66 90                	xchg   ax,ax
    af1b:	66 90                	xchg   ax,ax
    af1d:	66 90                	xchg   ax,ax
    af1f:	90                   	nop

0000af20 <_ZN3elf13load_file_hdrEjPFiPvjjS0_ES0_>:
    af20:	57                   	push   edi
    af21:	53                   	push   ebx
    af22:	83 ec 44             	sub    esp,0x44
    af25:	8b 5c 24 50          	mov    ebx,DWORD PTR [esp+0x50]
    af29:	ff 74 24 5c          	push   DWORD PTR [esp+0x5c]
    af2d:	6a 34                	push   0x34
    af2f:	ff 74 24 5c          	push   DWORD PTR [esp+0x5c]
    af33:	8d 44 24 18          	lea    eax,[esp+0x18]
    af37:	50                   	push   eax
    af38:	ff 54 24 68          	call   DWORD PTR [esp+0x68]
    af3c:	83 c4 10             	add    esp,0x10
    af3f:	85 c0                	test   eax,eax
    af41:	75 6d                	jne    afb0 <_ZN3elf13load_file_hdrEjPFiPvjjS0_ES0_+0x90>
    af43:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    af47:	89 03                	mov    DWORD PTR [ebx],eax
    af49:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    af4d:	89 43 04             	mov    DWORD PTR [ebx+0x4],eax
    af50:	8b 44 24 14          	mov    eax,DWORD PTR [esp+0x14]
    af54:	89 43 08             	mov    DWORD PTR [ebx+0x8],eax
    af57:	8b 44 24 18          	mov    eax,DWORD PTR [esp+0x18]
    af5b:	89 43 0c             	mov    DWORD PTR [ebx+0xc],eax
    af5e:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    af62:	89 43 10             	mov    DWORD PTR [ebx+0x10],eax
    af65:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    af69:	89 43 14             	mov    DWORD PTR [ebx+0x14],eax
    af6c:	8b 44 24 24          	mov    eax,DWORD PTR [esp+0x24]
    af70:	89 43 18             	mov    DWORD PTR [ebx+0x18],eax
    af73:	8b 44 24 28          	mov    eax,DWORD PTR [esp+0x28]
    af77:	89 43 1c             	mov    DWORD PTR [ebx+0x1c],eax
    af7a:	8b 44 24 2c          	mov    eax,DWORD PTR [esp+0x2c]
    af7e:	89 43 20             	mov    DWORD PTR [ebx+0x20],eax
    af81:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    af85:	89 43 24             	mov    DWORD PTR [ebx+0x24],eax
    af88:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    af8c:	89 43 28             	mov    DWORD PTR [ebx+0x28],eax
    af8f:	8b 44 24 38          	mov    eax,DWORD PTR [esp+0x38]
    af93:	89 43 2c             	mov    DWORD PTR [ebx+0x2c],eax
    af96:	8b 44 24 3c          	mov    eax,DWORD PTR [esp+0x3c]
    af9a:	89 43 30             	mov    DWORD PTR [ebx+0x30],eax
    af9d:	83 c4 44             	add    esp,0x44
    afa0:	89 d8                	mov    eax,ebx
    afa2:	5b                   	pop    ebx
    afa3:	5f                   	pop    edi
    afa4:	c2 04 00             	ret    0x4
    afa7:	89 f6                	mov    esi,esi
    afa9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    afb0:	8d 7b 04             	lea    edi,[ebx+0x4]
    afb3:	89 d9                	mov    ecx,ebx
    afb5:	31 c0                	xor    eax,eax
    afb7:	c7 03 00 00 00 00    	mov    DWORD PTR [ebx],0x0
    afbd:	c7 43 30 00 00 00 00 	mov    DWORD PTR [ebx+0x30],0x0
    afc4:	83 e7 fc             	and    edi,0xfffffffc
    afc7:	29 f9                	sub    ecx,edi
    afc9:	83 c1 34             	add    ecx,0x34
    afcc:	c1 e9 02             	shr    ecx,0x2
    afcf:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    afd1:	83 c4 44             	add    esp,0x44
    afd4:	89 d8                	mov    eax,ebx
    afd6:	5b                   	pop    ebx
    afd7:	5f                   	pop    edi
    afd8:	c2 04 00             	ret    0x4
    afdb:	90                   	nop
    afdc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000afe0 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_>:
    afe0:	56                   	push   esi
    afe1:	53                   	push   ebx
    afe2:	83 ec 24             	sub    esp,0x24
    afe5:	8b 44 24 38          	mov    eax,DWORD PTR [esp+0x38]
    afe9:	8b 5c 24 30          	mov    ebx,DWORD PTR [esp+0x30]
    afed:	ff 74 24 44          	push   DWORD PTR [esp+0x44]
    aff1:	50                   	push   eax
    aff2:	0f af 44 24 44       	imul   eax,DWORD PTR [esp+0x44]
    aff7:	03 44 24 3c          	add    eax,DWORD PTR [esp+0x3c]
    affb:	50                   	push   eax
    affc:	8d 44 24 0c          	lea    eax,[esp+0xc]
    b000:	50                   	push   eax
    b001:	ff 54 24 50          	call   DWORD PTR [esp+0x50]
    b005:	83 c4 10             	add    esp,0x10
    b008:	85 c0                	test   eax,eax
    b00a:	75 44                	jne    b050 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_+0x70>
    b00c:	8b 04 24             	mov    eax,DWORD PTR [esp]
    b00f:	89 03                	mov    DWORD PTR [ebx],eax
    b011:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    b015:	89 43 04             	mov    DWORD PTR [ebx+0x4],eax
    b018:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b01c:	89 43 08             	mov    DWORD PTR [ebx+0x8],eax
    b01f:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b023:	89 43 0c             	mov    DWORD PTR [ebx+0xc],eax
    b026:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    b02a:	89 43 10             	mov    DWORD PTR [ebx+0x10],eax
    b02d:	8b 44 24 14          	mov    eax,DWORD PTR [esp+0x14]
    b031:	89 43 14             	mov    DWORD PTR [ebx+0x14],eax
    b034:	8b 44 24 18          	mov    eax,DWORD PTR [esp+0x18]
    b038:	89 43 18             	mov    DWORD PTR [ebx+0x18],eax
    b03b:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    b03f:	89 43 1c             	mov    DWORD PTR [ebx+0x1c],eax
    b042:	83 c4 24             	add    esp,0x24
    b045:	89 d8                	mov    eax,ebx
    b047:	5b                   	pop    ebx
    b048:	5e                   	pop    esi
    b049:	c2 04 00             	ret    0x4
    b04c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b050:	8d 4b 04             	lea    ecx,[ebx+0x4]
    b053:	89 d8                	mov    eax,ebx
    b055:	31 f6                	xor    esi,esi
    b057:	c7 03 00 00 00 00    	mov    DWORD PTR [ebx],0x0
    b05d:	c7 43 1c 00 00 00 00 	mov    DWORD PTR [ebx+0x1c],0x0
    b064:	31 d2                	xor    edx,edx
    b066:	83 e1 fc             	and    ecx,0xfffffffc
    b069:	29 c8                	sub    eax,ecx
    b06b:	83 c0 20             	add    eax,0x20
    b06e:	83 e0 fc             	and    eax,0xfffffffc
    b071:	89 34 11             	mov    DWORD PTR [ecx+edx*1],esi
    b074:	83 c2 04             	add    edx,0x4
    b077:	39 c2                	cmp    edx,eax
    b079:	72 f6                	jb     b071 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_+0x91>
    b07b:	eb c5                	jmp    b042 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_+0x62>
    b07d:	8d 76 00             	lea    esi,[esi+0x0]

0000b080 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_>:
    b080:	55                   	push   ebp
    b081:	57                   	push   edi
    b082:	56                   	push   esi
    b083:	53                   	push   ebx
    b084:	81 ec 9c 00 00 00    	sub    esp,0x9c
    b08a:	8d 44 24 5c          	lea    eax,[esp+0x5c]
    b08e:	ff b4 24 b8 00 00 00 	push   DWORD PTR [esp+0xb8]
    b095:	ff b4 24 b8 00 00 00 	push   DWORD PTR [esp+0xb8]
    b09c:	ff b4 24 b8 00 00 00 	push   DWORD PTR [esp+0xb8]
    b0a3:	50                   	push   eax
    b0a4:	e8 77 fe ff ff       	call   af20 <_ZN3elf13load_file_hdrEjPFiPvjjS0_ES0_>
    b0a9:	0f b6 44 24 6b       	movzx  eax,BYTE PTR [esp+0x6b]
    b0ae:	0f b6 4c 24 6a       	movzx  ecx,BYTE PTR [esp+0x6a]
    b0b3:	0f b6 54 24 69       	movzx  edx,BYTE PTR [esp+0x69]
    b0b8:	8b bc 24 84 00 00 00 	mov    edi,DWORD PTR [esp+0x84]
    b0bf:	0f b7 ac 24 92 00 00 	movzx  ebp,WORD PTR [esp+0x92]
    b0c6:	00 
    b0c7:	0f b7 b4 24 94 00 00 	movzx  esi,WORD PTR [esp+0x94]
    b0ce:	00 
    b0cf:	50                   	push   eax
    b0d0:	89 c3                	mov    ebx,eax
    b0d2:	0f b6 c1             	movzx  eax,cl
    b0d5:	88 4c 24 18          	mov    BYTE PTR [esp+0x18],cl
    b0d9:	50                   	push   eax
    b0da:	0f b6 c2             	movzx  eax,dl
    b0dd:	88 54 24 18          	mov    BYTE PTR [esp+0x18],dl
    b0e1:	50                   	push   eax
    b0e2:	0f b6 44 24 74       	movzx  eax,BYTE PTR [esp+0x74]
    b0e7:	50                   	push   eax
    b0e8:	68 61 e2 00 00       	push   0xe261
    b0ed:	e8 8e 25 00 00       	call   d680 <_Z6printfIhJhhhEEvPKcT_DpT0_>
    b0f2:	83 c4 20             	add    esp,0x20
    b0f5:	0f b6 4c 24 08       	movzx  ecx,BYTE PTR [esp+0x8]
    b0fa:	0f b6 54 24 04       	movzx  edx,BYTE PTR [esp+0x4]
    b0ff:	80 f9 4c             	cmp    cl,0x4c
    b102:	0f 95 c0             	setne  al
    b105:	80 fa 45             	cmp    dl,0x45
    b108:	0f 95 c2             	setne  dl
    b10b:	09 d0                	or     eax,edx
    b10d:	80 fb 46             	cmp    bl,0x46
    b110:	0f 95 c2             	setne  dl
    b113:	08 d0                	or     al,dl
    b115:	0f 85 15 02 00 00    	jne    b330 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x2b0>
    b11b:	0f b7 c6             	movzx  eax,si
    b11e:	83 ec 08             	sub    esp,0x8
    b121:	31 f6                	xor    esi,esi
    b123:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    b127:	50                   	push   eax
    b128:	68 76 e2 00 00       	push   0xe276
    b12d:	e8 7e 1e 00 00       	call   cfb0 <_Z6printfItEvPKcT_>
    b132:	89 7c 24 40          	mov    DWORD PTR [esp+0x40],edi
    b136:	ba 70 00 00 00       	mov    edx,0x70
    b13b:	83 c4 10             	add    esp,0x10
    b13e:	66 90                	xchg   ax,ax
    b140:	8d 5e 01             	lea    ebx,[esi+0x1]
    b143:	80 fa 25             	cmp    dl,0x25
    b146:	0f b6 83 83 e2 00 00 	movzx  eax,BYTE PTR [ebx+0xe283]
    b14d:	8d 8b 83 e2 00 00    	lea    ecx,[ebx+0xe283]
    b153:	75 2b                	jne    b180 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x100>
    b155:	3c 25                	cmp    al,0x25
    b157:	0f 84 50 02 00 00    	je     b3ad <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x32d>
    b15d:	84 c0                	test   al,al
    b15f:	0f 85 23 02 00 00    	jne    b388 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x308>
    b165:	8d 5e 02             	lea    ebx,[esi+0x2]
    b168:	0f b6 83 83 e2 00 00 	movzx  eax,BYTE PTR [ebx+0xe283]
    b16f:	84 c0                	test   al,al
    b171:	74 2d                	je     b1a0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x120>
    b173:	0f be d0             	movsx  edx,al
    b176:	89 de                	mov    esi,ebx
    b178:	eb c6                	jmp    b140 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xc0>
    b17a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b180:	88 44 24 04          	mov    BYTE PTR [esp+0x4],al
    b184:	83 ec 0c             	sub    esp,0xc
    b187:	52                   	push   edx
    b188:	e8 23 0a 00 00       	call   bbb0 <_Z7putcharc>
    b18d:	83 c4 10             	add    esp,0x10
    b190:	0f b6 44 24 04       	movzx  eax,BYTE PTR [esp+0x4]
    b195:	84 c0                	test   al,al
    b197:	75 da                	jne    b173 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xf3>
    b199:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b1a0:	83 ec 08             	sub    esp,0x8
    b1a3:	0f b7 c5             	movzx  eax,bp
    b1a6:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    b1aa:	50                   	push   eax
    b1ab:	68 90 e2 00 00       	push   0xe290
    b1b0:	e8 fb 1d 00 00       	call   cfb0 <_Z6printfItEvPKcT_>
    b1b5:	83 c4 10             	add    esp,0x10
    b1b8:	8b 54 24 10          	mov    edx,DWORD PTR [esp+0x10]
    b1bc:	85 d2                	test   edx,edx
    b1be:	0f 84 82 00 00 00    	je     b246 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x1c6>
    b1c4:	03 bc 24 b0 00 00 00 	add    edi,DWORD PTR [esp+0xb0]
    b1cb:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    b1d2:	00 
    b1d3:	89 7c 24 18          	mov    DWORD PTR [esp+0x18],edi
    b1d7:	bf 01 00 00 00       	mov    edi,0x1
    b1dc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b1e0:	83 ec 08             	sub    esp,0x8
    b1e3:	ff b4 24 c0 00 00 00 	push   DWORD PTR [esp+0xc0]
    b1ea:	ff b4 24 c0 00 00 00 	push   DWORD PTR [esp+0xc0]
    b1f1:	ff 74 24 14          	push   DWORD PTR [esp+0x14]
    b1f5:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    b1f9:	ff 74 24 30          	push   DWORD PTR [esp+0x30]
    b1fd:	8d 44 24 58          	lea    eax,[esp+0x58]
    b201:	50                   	push   eax
    b202:	e8 d9 fd ff ff       	call   afe0 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_>
    b207:	8b 5c 24 58          	mov    ebx,DWORD PTR [esp+0x58]
    b20b:	b8 e0 e0 00 00       	mov    eax,0xe0e0
    b210:	31 d2                	xor    edx,edx
    b212:	31 c9                	xor    ecx,ecx
    b214:	89 5c 24 28          	mov    DWORD PTR [esp+0x28],ebx
    b218:	83 c4 1c             	add    esp,0x1c
    b21b:	eb 08                	jmp    b225 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x1a5>
    b21d:	8d 76 00             	lea    esi,[esi+0x0]
    b220:	8b 08                	mov    ecx,DWORD PTR [eax]
    b222:	83 c0 04             	add    eax,0x4
    b225:	39 cb                	cmp    ebx,ecx
    b227:	be f8 e0 00 00       	mov    esi,0xe0f8
    b22c:	0f 44 d7             	cmove  edx,edi
    b22f:	39 c6                	cmp    esi,eax
    b231:	75 ed                	jne    b220 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x1a0>
    b233:	84 d2                	test   dl,dl
    b235:	75 21                	jne    b258 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x1d8>
    b237:	83 44 24 04 01       	add    DWORD PTR [esp+0x4],0x1
    b23c:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    b240:	39 44 24 10          	cmp    DWORD PTR [esp+0x10],eax
    b244:	75 9a                	jne    b1e0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x160>
    b246:	81 c4 9c 00 00 00    	add    esp,0x9c
    b24c:	31 c0                	xor    eax,eax
    b24e:	5b                   	pop    ebx
    b24f:	5e                   	pop    esi
    b250:	5f                   	pop    edi
    b251:	5d                   	pop    ebp
    b252:	c3                   	ret    
    b253:	90                   	nop
    b254:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b258:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    b25c:	83 ec 0c             	sub    esp,0xc
    b25f:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    b263:	8b 44 24 5c          	mov    eax,DWORD PTR [esp+0x5c]
    b267:	89 44 24 2c          	mov    DWORD PTR [esp+0x2c],eax
    b26b:	68 20 e3 00 00       	push   0xe320
    b270:	e8 bb 09 00 00       	call   bc30 <_Z6printfPKc>
    b275:	8b 44 24 5c          	mov    eax,DWORD PTR [esp+0x5c]
    b279:	31 d2                	xor    edx,edx
    b27b:	89 44 24 38          	mov    DWORD PTR [esp+0x38],eax
    b27f:	8b 44 24 68          	mov    eax,DWORD PTR [esp+0x68]
    b283:	89 44 24 3c          	mov    DWORD PTR [esp+0x3c],eax
    b287:	8b 44 24 58          	mov    eax,DWORD PTR [esp+0x58]
    b28b:	89 44 24 34          	mov    DWORD PTR [esp+0x34],eax
    b28f:	83 c4 10             	add    esp,0x10
    b292:	b8 70 00 00 00       	mov    eax,0x70
    b297:	eb 2b                	jmp    b2c4 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x244>
    b299:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b2a0:	80 fb 25             	cmp    bl,0x25
    b2a3:	0f 84 af 00 00 00    	je     b358 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x2d8>
    b2a9:	84 db                	test   bl,bl
    b2ab:	0f 85 8f 00 00 00    	jne    b340 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x2c0>
    b2b1:	8d 72 02             	lea    esi,[edx+0x2]
    b2b4:	0f b6 9e 58 e3 00 00 	movzx  ebx,BYTE PTR [esi+0xe358]
    b2bb:	84 db                	test   bl,bl
    b2bd:	74 31                	je     b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b2bf:	0f be c3             	movsx  eax,bl
    b2c2:	89 f2                	mov    edx,esi
    b2c4:	8d 72 01             	lea    esi,[edx+0x1]
    b2c7:	3c 25                	cmp    al,0x25
    b2c9:	0f b6 9e 58 e3 00 00 	movzx  ebx,BYTE PTR [esi+0xe358]
    b2d0:	8d ae 58 e3 00 00    	lea    ebp,[esi+0xe358]
    b2d6:	74 c8                	je     b2a0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x220>
    b2d8:	83 ec 0c             	sub    esp,0xc
    b2db:	50                   	push   eax
    b2dc:	e8 cf 08 00 00       	call   bbb0 <_Z7putcharc>
    b2e1:	83 c4 10             	add    esp,0x10
    b2e4:	84 db                	test   bl,bl
    b2e6:	75 d7                	jne    b2bf <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x23f>
    b2e8:	90                   	nop
    b2e9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b2f0:	83 ec 04             	sub    esp,0x4
    b2f3:	ff 74 24 10          	push   DWORD PTR [esp+0x10]
    b2f7:	8b 74 24 28          	mov    esi,DWORD PTR [esp+0x28]
    b2fb:	56                   	push   esi
    b2fc:	68 a2 e2 00 00       	push   0xe2a2
    b301:	e8 aa 20 00 00       	call   d3b0 <_Z6printfIjJjEEvPKcT_DpT0_>
    b306:	ff b4 24 c8 00 00 00 	push   DWORD PTR [esp+0xc8]
    b30d:	56                   	push   esi
    b30e:	8b 84 24 c8 00 00 00 	mov    eax,DWORD PTR [esp+0xc8]
    b315:	03 44 24 58          	add    eax,DWORD PTR [esp+0x58]
    b319:	50                   	push   eax
    b31a:	ff 74 24 38          	push   DWORD PTR [esp+0x38]
    b31e:	ff 94 24 d4 00 00 00 	call   DWORD PTR [esp+0xd4]
    b325:	83 c4 20             	add    esp,0x20
    b328:	85 c0                	test   eax,eax
    b32a:	0f 84 07 ff ff ff    	je     b237 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x1b7>
    b330:	81 c4 9c 00 00 00    	add    esp,0x9c
    b336:	b8 ff ff ff ff       	mov    eax,0xffffffff
    b33b:	5b                   	pop    ebx
    b33c:	5e                   	pop    esi
    b33d:	5f                   	pop    edi
    b33e:	5d                   	pop    ebp
    b33f:	c3                   	ret    
    b340:	8d 43 be             	lea    eax,[ebx-0x42]
    b343:	3c 36                	cmp    al,0x36
    b345:	0f 87 38 01 00 00    	ja     b483 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x403>
    b34b:	0f b6 c0             	movzx  eax,al
    b34e:	ff 24 85 00 e0 00 00 	jmp    DWORD PTR [eax*4+0xe000]
    b355:	8d 76 00             	lea    esi,[esi+0x0]
    b358:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b35c:	83 ec 0c             	sub    esp,0xc
    b35f:	6a 25                	push   0x25
    b361:	e8 4a 08 00 00       	call   bbb0 <_Z7putcharc>
    b366:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b36a:	83 c4 10             	add    esp,0x10
    b36d:	8d 72 02             	lea    esi,[edx+0x2]
    b370:	0f b6 9e 58 e3 00 00 	movzx  ebx,BYTE PTR [esi+0xe358]
    b377:	84 db                	test   bl,bl
    b379:	0f 85 40 ff ff ff    	jne    b2bf <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x23f>
    b37f:	e9 6c ff ff ff       	jmp    b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b384:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b388:	83 ec 08             	sub    esp,0x8
    b38b:	8d 44 24 38          	lea    eax,[esp+0x38]
    b38f:	50                   	push   eax
    b390:	51                   	push   ecx
    b391:	e8 1a 1f 00 00       	call   d2b0 <_Z14_manage_escapeIjEiPKcPT_>
    b396:	8d 84 18 83 e2 00 00 	lea    eax,[eax+ebx*1+0xe283]
    b39d:	89 04 24             	mov    DWORD PTR [esp],eax
    b3a0:	e8 8b 08 00 00       	call   bc30 <_Z6printfPKc>
    b3a5:	83 c4 10             	add    esp,0x10
    b3a8:	e9 f3 fd ff ff       	jmp    b1a0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x120>
    b3ad:	83 ec 0c             	sub    esp,0xc
    b3b0:	8d 5e 02             	lea    ebx,[esi+0x2]
    b3b3:	6a 25                	push   0x25
    b3b5:	e8 f6 07 00 00       	call   bbb0 <_Z7putcharc>
    b3ba:	0f b6 83 83 e2 00 00 	movzx  eax,BYTE PTR [ebx+0xe283]
    b3c1:	83 c4 10             	add    esp,0x10
    b3c4:	84 c0                	test   al,al
    b3c6:	0f 85 a7 fd ff ff    	jne    b173 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xf3>
    b3cc:	e9 cf fd ff ff       	jmp    b1a0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x120>
    b3d1:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b3d5:	83 ec 0c             	sub    esp,0xc
    b3d8:	ff 74 24 10          	push   DWORD PTR [esp+0x10]
    b3dc:	e8 2f 08 00 00       	call   bc10 <_Z6putstrPc>
    b3e1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b3e8:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b3ec:	83 c4 10             	add    esp,0x10
    b3ef:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    b3f3:	0f b6 9a 5a e3 00 00 	movzx  ebx,BYTE PTR [edx+0xe35a]
    b3fa:	8d aa 5a e3 00 00    	lea    ebp,[edx+0xe35a]
    b400:	89 44 24 34          	mov    DWORD PTR [esp+0x34],eax
    b404:	84 db                	test   bl,bl
    b406:	0f 84 e4 fe ff ff    	je     b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b40c:	eb 7d                	jmp    b48b <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x40b>
    b40e:	66 90                	xchg   ax,ax
    b410:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b414:	83 ec 0c             	sub    esp,0xc
    b417:	68 1c ff 00 00       	push   0xff1c
    b41c:	e8 0f 08 00 00       	call   bc30 <_Z6printfPKc>
    b421:	58                   	pop    eax
    b422:	ff 74 24 10          	push   DWORD PTR [esp+0x10]
    b426:	e8 b5 07 00 00       	call   bbe0 <_Z6puthexi>
    b42b:	eb bb                	jmp    b3e8 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x368>
    b42d:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b431:	83 ec 0c             	sub    esp,0xc
    b434:	ff 74 24 10          	push   DWORD PTR [esp+0x10]
    b438:	e8 b3 07 00 00       	call   bbf0 <_Z6putocti>
    b43d:	eb a9                	jmp    b3e8 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x368>
    b43f:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b443:	83 ec 0c             	sub    esp,0xc
    b446:	ff 74 24 10          	push   DWORD PTR [esp+0x10]
    b44a:	e8 b1 07 00 00       	call   bc00 <_Z6putbini>
    b44f:	eb 97                	jmp    b3e8 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x368>
    b451:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b455:	83 ec 0c             	sub    esp,0xc
    b458:	0f be 44 24 10       	movsx  eax,BYTE PTR [esp+0x10]
    b45d:	50                   	push   eax
    b45e:	e8 4d 07 00 00       	call   bbb0 <_Z7putcharc>
    b463:	eb 83                	jmp    b3e8 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x368>
    b465:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b469:	83 ec 0c             	sub    esp,0xc
    b46c:	eb b4                	jmp    b422 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x3a2>
    b46e:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b472:	83 ec 0c             	sub    esp,0xc
    b475:	ff 74 24 10          	push   DWORD PTR [esp+0x10]
    b479:	e8 52 07 00 00       	call   bbd0 <_Z6putdeci>
    b47e:	e9 65 ff ff ff       	jmp    b3e8 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x368>
    b483:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    b487:	89 44 24 34          	mov    DWORD PTR [esp+0x34],eax
    b48b:	31 d2                	xor    edx,edx
    b48d:	0f be c3             	movsx  eax,bl
    b490:	89 d1                	mov    ecx,edx
    b492:	89 ea                	mov    edx,ebp
    b494:	89 cd                	mov    ebp,ecx
    b496:	eb 2a                	jmp    b4c2 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x442>
    b498:	90                   	nop
    b499:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b4a0:	80 fb 25             	cmp    bl,0x25
    b4a3:	0f 84 ef 00 00 00    	je     b598 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x518>
    b4a9:	84 db                	test   bl,bl
    b4ab:	75 43                	jne    b4f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x470>
    b4ad:	0f b6 5c 2a 02       	movzx  ebx,BYTE PTR [edx+ebp*1+0x2]
    b4b2:	8d 75 02             	lea    esi,[ebp+0x2]
    b4b5:	84 db                	test   bl,bl
    b4b7:	0f 84 33 fe ff ff    	je     b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b4bd:	0f be c3             	movsx  eax,bl
    b4c0:	89 f5                	mov    ebp,esi
    b4c2:	8d 75 01             	lea    esi,[ebp+0x1]
    b4c5:	3c 25                	cmp    al,0x25
    b4c7:	8d 0c 32             	lea    ecx,[edx+esi*1]
    b4ca:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b4cd:	74 d1                	je     b4a0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x420>
    b4cf:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b4d3:	83 ec 0c             	sub    esp,0xc
    b4d6:	50                   	push   eax
    b4d7:	e8 d4 06 00 00       	call   bbb0 <_Z7putcharc>
    b4dc:	83 c4 10             	add    esp,0x10
    b4df:	84 db                	test   bl,bl
    b4e1:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    b4e5:	75 d6                	jne    b4bd <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x43d>
    b4e7:	e9 04 fe ff ff       	jmp    b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b4ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b4f0:	83 ec 08             	sub    esp,0x8
    b4f3:	89 d5                	mov    ebp,edx
    b4f5:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    b4f9:	50                   	push   eax
    b4fa:	51                   	push   ecx
    b4fb:	e8 b0 1d 00 00       	call   d2b0 <_Z14_manage_escapeIjEiPKcPT_>
    b500:	01 c6                	add    esi,eax
    b502:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    b506:	01 f5                	add    ebp,esi
    b508:	89 44 24 48          	mov    DWORD PTR [esp+0x48],eax
    b50c:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    b510:	83 c4 10             	add    esp,0x10
    b513:	84 c0                	test   al,al
    b515:	0f 84 d5 fd ff ff    	je     b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b51b:	31 d2                	xor    edx,edx
    b51d:	eb 23                	jmp    b542 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x4c2>
    b51f:	90                   	nop
    b520:	80 fb 25             	cmp    bl,0x25
    b523:	0f 84 9f 00 00 00    	je     b5c8 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x548>
    b529:	84 db                	test   bl,bl
    b52b:	75 3b                	jne    b568 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x4e8>
    b52d:	0f b6 5c 15 02       	movzx  ebx,BYTE PTR [ebp+edx*1+0x2]
    b532:	8d 72 02             	lea    esi,[edx+0x2]
    b535:	84 db                	test   bl,bl
    b537:	0f 84 b3 fd ff ff    	je     b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b53d:	0f be c3             	movsx  eax,bl
    b540:	89 f2                	mov    edx,esi
    b542:	8d 72 01             	lea    esi,[edx+0x1]
    b545:	3c 25                	cmp    al,0x25
    b547:	8d 4c 35 00          	lea    ecx,[ebp+esi*1+0x0]
    b54b:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b54e:	74 d0                	je     b520 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x4a0>
    b550:	83 ec 0c             	sub    esp,0xc
    b553:	50                   	push   eax
    b554:	e8 57 06 00 00       	call   bbb0 <_Z7putcharc>
    b559:	83 c4 10             	add    esp,0x10
    b55c:	84 db                	test   bl,bl
    b55e:	75 dd                	jne    b53d <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x4bd>
    b560:	e9 8b fd ff ff       	jmp    b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b565:	8d 76 00             	lea    esi,[esi+0x0]
    b568:	83 ec 08             	sub    esp,0x8
    b56b:	8d 44 24 40          	lea    eax,[esp+0x40]
    b56f:	50                   	push   eax
    b570:	51                   	push   ecx
    b571:	e8 3a 1d 00 00       	call   d2b0 <_Z14_manage_escapeIjEiPKcPT_>
    b576:	01 c6                	add    esi,eax
    b578:	83 c4 0c             	add    esp,0xc
    b57b:	01 f5                	add    ebp,esi
    b57d:	ff 74 24 2c          	push   DWORD PTR [esp+0x2c]
    b581:	ff 74 24 34          	push   DWORD PTR [esp+0x34]
    b585:	55                   	push   ebp
    b586:	e8 25 1e 00 00       	call   d3b0 <_Z6printfIjJjEEvPKcT_DpT0_>
    b58b:	83 c4 10             	add    esp,0x10
    b58e:	e9 5d fd ff ff       	jmp    b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b593:	90                   	nop
    b594:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b598:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b59c:	83 ec 0c             	sub    esp,0xc
    b59f:	8d 75 02             	lea    esi,[ebp+0x2]
    b5a2:	6a 25                	push   0x25
    b5a4:	e8 07 06 00 00       	call   bbb0 <_Z7putcharc>
    b5a9:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b5ad:	83 c4 10             	add    esp,0x10
    b5b0:	0f b6 5c 2a 02       	movzx  ebx,BYTE PTR [edx+ebp*1+0x2]
    b5b5:	84 db                	test   bl,bl
    b5b7:	0f 85 00 ff ff ff    	jne    b4bd <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x43d>
    b5bd:	e9 2e fd ff ff       	jmp    b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b5c2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b5c8:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    b5cc:	83 ec 0c             	sub    esp,0xc
    b5cf:	6a 25                	push   0x25
    b5d1:	e8 da 05 00 00       	call   bbb0 <_Z7putcharc>
    b5d6:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b5da:	83 c4 10             	add    esp,0x10
    b5dd:	0f b6 5c 15 02       	movzx  ebx,BYTE PTR [ebp+edx*1+0x2]
    b5e2:	8d 72 02             	lea    esi,[edx+0x2]
    b5e5:	84 db                	test   bl,bl
    b5e7:	0f 85 50 ff ff ff    	jne    b53d <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x4bd>
    b5ed:	e9 fe fc ff ff       	jmp    b2f0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x270>
    b5f2:	66 90                	xchg   ax,ax
    b5f4:	66 90                	xchg   ax,ax
    b5f6:	66 90                	xchg   ax,ax
    b5f8:	66 90                	xchg   ax,ax
    b5fa:	66 90                	xchg   ax,ax
    b5fc:	66 90                	xchg   ax,ax
    b5fe:	66 90                	xchg   ax,ax

0000b600 <_ZN3VGA17_actualize_cursorEv>:
    b600:	53                   	push   ebx
    b601:	83 ec 10             	sub    esp,0x10
    b604:	8b 1d 04 20 01 00    	mov    ebx,DWORD PTR ds:0x12004
    b60a:	6a 0e                	push   0xe
    b60c:	68 d4 03 00 00       	push   0x3d4
    b611:	8d 1c 9b             	lea    ebx,[ebx+ebx*4]
    b614:	c1 e3 04             	shl    ebx,0x4
    b617:	66 03 1d 00 20 01 00 	add    bx,WORD PTR ds:0x12000
    b61e:	e8 3d 07 00 00       	call   bd60 <_Z4outbth>
    b623:	58                   	pop    eax
    b624:	5a                   	pop    edx
    b625:	0f b6 c7             	movzx  eax,bh
    b628:	0f b6 db             	movzx  ebx,bl
    b62b:	50                   	push   eax
    b62c:	68 d5 03 00 00       	push   0x3d5
    b631:	e8 2a 07 00 00       	call   bd60 <_Z4outbth>
    b636:	59                   	pop    ecx
    b637:	58                   	pop    eax
    b638:	6a 0f                	push   0xf
    b63a:	68 d4 03 00 00       	push   0x3d4
    b63f:	e8 1c 07 00 00       	call   bd60 <_Z4outbth>
    b644:	58                   	pop    eax
    b645:	5a                   	pop    edx
    b646:	53                   	push   ebx
    b647:	68 d5 03 00 00       	push   0x3d5
    b64c:	e8 0f 07 00 00       	call   bd60 <_Z4outbth>
    b651:	83 c4 18             	add    esp,0x18
    b654:	5b                   	pop    ebx
    b655:	c3                   	ret    
    b656:	8d 76 00             	lea    esi,[esi+0x0]
    b659:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b660 <_ZN3VGA14_pos_in_screenEii>:
    b660:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    b664:	8d 04 80             	lea    eax,[eax+eax*4]
    b667:	c1 e0 04             	shl    eax,0x4
    b66a:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    b66e:	01 c0                	add    eax,eax
    b670:	c3                   	ret    
    b671:	eb 0d                	jmp    b680 <_ZN3VGA12_char_val_atEii>
    b673:	90                   	nop
    b674:	90                   	nop
    b675:	90                   	nop
    b676:	90                   	nop
    b677:	90                   	nop
    b678:	90                   	nop
    b679:	90                   	nop
    b67a:	90                   	nop
    b67b:	90                   	nop
    b67c:	90                   	nop
    b67d:	90                   	nop
    b67e:	90                   	nop
    b67f:	90                   	nop

0000b680 <_ZN3VGA12_char_val_atEii>:
    b680:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    b684:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b68a:	8d 04 80             	lea    eax,[eax+eax*4]
    b68d:	c1 e0 04             	shl    eax,0x4
    b690:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    b694:	8d 04 42             	lea    eax,[edx+eax*2]
    b697:	c3                   	ret    
    b698:	90                   	nop
    b699:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b6a0 <_ZN3VGA13_char_mode_atEii>:
    b6a0:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    b6a4:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b6aa:	8d 04 80             	lea    eax,[eax+eax*4]
    b6ad:	c1 e0 04             	shl    eax,0x4
    b6b0:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    b6b4:	8d 44 42 01          	lea    eax,[edx+eax*2+0x1]
    b6b8:	c3                   	ret    
    b6b9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b6c0 <_ZN3VGA6scrollEc>:
    b6c0:	55                   	push   ebp
    b6c1:	57                   	push   edi
    b6c2:	31 ed                	xor    ebp,ebp
    b6c4:	56                   	push   esi
    b6c5:	53                   	push   ebx
    b6c6:	be 40 01 00 00       	mov    esi,0x140
    b6cb:	bf 50 00 00 00       	mov    edi,0x50
    b6d0:	83 ec 1c             	sub    esp,0x1c
    b6d3:	0f b6 44 24 30       	movzx  eax,BYTE PTR [esp+0x30]
    b6d8:	88 44 24 0f          	mov    BYTE PTR [esp+0xf],al
    b6dc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b6e0:	89 e9                	mov    ecx,ebp
    b6e2:	8d 04 3f             	lea    eax,[edi+edi*1]
    b6e5:	29 f9                	sub    ecx,edi
    b6e7:	01 c9                	add    ecx,ecx
    b6e9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b6f0:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b6f6:	0f b6 1c 02          	movzx  ebx,BYTE PTR [edx+eax*1]
    b6fa:	01 ca                	add    edx,ecx
    b6fc:	88 1c 02             	mov    BYTE PTR [edx+eax*1],bl
    b6ff:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b705:	0f b6 5c 02 01       	movzx  ebx,BYTE PTR [edx+eax*1+0x1]
    b70a:	01 ca                	add    edx,ecx
    b70c:	83 c0 02             	add    eax,0x2
    b70f:	88 5c 10 ff          	mov    BYTE PTR [eax+edx*1-0x1],bl
    b713:	39 f0                	cmp    eax,esi
    b715:	75 d9                	jne    b6f0 <_ZN3VGA6scrollEc+0x30>
    b717:	83 c7 50             	add    edi,0x50
    b71a:	83 c5 50             	add    ebp,0x50
    b71d:	8d b0 a0 00 00 00    	lea    esi,[eax+0xa0]
    b723:	81 ff d0 07 00 00    	cmp    edi,0x7d0
    b729:	75 b5                	jne    b6e0 <_ZN3VGA6scrollEc+0x20>
    b72b:	0f b6 4c 24 0f       	movzx  ecx,BYTE PTR [esp+0xf]
    b730:	b8 00 0f 00 00       	mov    eax,0xf00
    b735:	8d 76 00             	lea    esi,[esi+0x0]
    b738:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b73e:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    b742:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b748:	88 4c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],cl
    b74c:	83 c0 02             	add    eax,0x2
    b74f:	3d a0 0f 00 00       	cmp    eax,0xfa0
    b754:	75 e2                	jne    b738 <_ZN3VGA6scrollEc+0x78>
    b756:	a1 04 20 01 00       	mov    eax,ds:0x12004
    b75b:	ba 00 00 00 00       	mov    edx,0x0
    b760:	83 e8 01             	sub    eax,0x1
    b763:	0f 48 c2             	cmovs  eax,edx
    b766:	a3 04 20 01 00       	mov    ds:0x12004,eax
    b76b:	83 c4 1c             	add    esp,0x1c
    b76e:	5b                   	pop    ebx
    b76f:	5e                   	pop    esi
    b770:	5f                   	pop    edi
    b771:	5d                   	pop    ebp
    b772:	e9 89 fe ff ff       	jmp    b600 <_ZN3VGA17_actualize_cursorEv>
    b777:	89 f6                	mov    esi,esi
    b779:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b780 <_ZN3VGA12clear_screenEc>:
    b780:	53                   	push   ebx
    b781:	0f b6 5c 24 08       	movzx  ebx,BYTE PTR [esp+0x8]
    b786:	31 c0                	xor    eax,eax
    b788:	90                   	nop
    b789:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b790:	8d 88 a0 00 00 00    	lea    ecx,[eax+0xa0]
    b796:	8d 76 00             	lea    esi,[esi+0x0]
    b799:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b7a0:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b7a6:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    b7aa:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b7b0:	88 5c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],bl
    b7b4:	83 c0 02             	add    eax,0x2
    b7b7:	39 c1                	cmp    ecx,eax
    b7b9:	75 e5                	jne    b7a0 <_ZN3VGA12clear_screenEc+0x20>
    b7bb:	81 f9 a0 0f 00 00    	cmp    ecx,0xfa0
    b7c1:	75 cd                	jne    b790 <_ZN3VGA12clear_screenEc+0x10>
    b7c3:	5b                   	pop    ebx
    b7c4:	c7 05 04 20 01 00 00 	mov    DWORD PTR ds:0x12004,0x0
    b7cb:	00 00 00 
    b7ce:	c7 05 00 20 01 00 00 	mov    DWORD PTR ds:0x12000,0x0
    b7d5:	00 00 00 
    b7d8:	e9 23 fe ff ff       	jmp    b600 <_ZN3VGA17_actualize_cursorEv>
    b7dd:	8d 76 00             	lea    esi,[esi+0x0]

0000b7e0 <_ZN3VGA7putcharEcc>:
    b7e0:	55                   	push   ebp
    b7e1:	57                   	push   edi
    b7e2:	56                   	push   esi
    b7e3:	53                   	push   ebx
    b7e4:	83 ec 1c             	sub    esp,0x1c
    b7e7:	8b 3d 04 20 01 00    	mov    edi,DWORD PTR ds:0x12004
    b7ed:	8b 5c 24 30          	mov    ebx,DWORD PTR [esp+0x30]
    b7f1:	8b 4c 24 34          	mov    ecx,DWORD PTR [esp+0x34]
    b7f5:	80 fb 0a             	cmp    bl,0xa
    b7f8:	0f 84 d2 00 00 00    	je     b8d0 <_ZN3VGA7putcharEcc+0xf0>
    b7fe:	80 fb 09             	cmp    bl,0x9
    b801:	0f 85 99 00 00 00    	jne    b8a0 <_ZN3VGA7putcharEcc+0xc0>
    b807:	a1 00 20 01 00       	mov    eax,ds:0x12000
    b80c:	31 f6                	xor    esi,esi
    b80e:	8d 50 04             	lea    edx,[eax+0x4]
    b811:	83 e2 fc             	and    edx,0xfffffffc
    b814:	83 fa 4f             	cmp    edx,0x4f
    b817:	89 15 00 20 01 00    	mov    DWORD PTR ds:0x12000,edx
    b81d:	0f 8e 15 01 00 00    	jle    b938 <_ZN3VGA7putcharEcc+0x158>
    b823:	bd cd cc cc cc       	mov    ebp,0xcccccccd
    b828:	89 d0                	mov    eax,edx
    b82a:	c7 05 00 20 01 00 00 	mov    DWORD PTR ds:0x12000,0x0
    b831:	00 00 00 
    b834:	f7 e5                	mul    ebp
    b836:	c1 ea 06             	shr    edx,0x6
    b839:	01 fa                	add    edx,edi
    b83b:	83 fa 18             	cmp    edx,0x18
    b83e:	89 15 04 20 01 00    	mov    DWORD PTR ds:0x12004,edx
    b844:	0f 8f ce 00 00 00    	jg     b918 <_ZN3VGA7putcharEcc+0x138>
    b84a:	89 f0                	mov    eax,esi
    b84c:	84 c0                	test   al,al
    b84e:	74 3f                	je     b88f <_ZN3VGA7putcharEcc+0xaf>
    b850:	8b 3d 04 20 01 00    	mov    edi,DWORD PTR ds:0x12004
    b856:	8b 2d 00 20 01 00    	mov    ebp,DWORD PTR ds:0x12000
    b85c:	8d 04 bf             	lea    eax,[edi+edi*4]
    b85f:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b865:	c1 e0 04             	shl    eax,0x4
    b868:	01 e8                	add    eax,ebp
    b86a:	88 1c 42             	mov    BYTE PTR [edx+eax*2],bl
    b86d:	a1 04 20 01 00       	mov    eax,ds:0x12004
    b872:	8b 15 14 10 01 00    	mov    edx,DWORD PTR ds:0x11014
    b878:	8d 04 80             	lea    eax,[eax+eax*4]
    b87b:	c1 e0 04             	shl    eax,0x4
    b87e:	03 05 00 20 01 00    	add    eax,DWORD PTR ds:0x12000
    b884:	88 4c 42 01          	mov    BYTE PTR [edx+eax*2+0x1],cl
    b888:	83 05 00 20 01 00 01 	add    DWORD PTR ds:0x12000,0x1
    b88f:	83 c4 1c             	add    esp,0x1c
    b892:	5b                   	pop    ebx
    b893:	5e                   	pop    esi
    b894:	5f                   	pop    edi
    b895:	5d                   	pop    ebp
    b896:	e9 65 fd ff ff       	jmp    b600 <_ZN3VGA17_actualize_cursorEv>
    b89b:	90                   	nop
    b89c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b8a0:	80 fb 0d             	cmp    bl,0xd
    b8a3:	75 4f                	jne    b8f4 <_ZN3VGA7putcharEcc+0x114>
    b8a5:	83 ff 18             	cmp    edi,0x18
    b8a8:	c7 05 00 20 01 00 00 	mov    DWORD PTR ds:0x12000,0x0
    b8af:	00 00 00 
    b8b2:	7e db                	jle    b88f <_ZN3VGA7putcharEcc+0xaf>
    b8b4:	83 ec 0c             	sub    esp,0xc
    b8b7:	0f be c9             	movsx  ecx,cl
    b8ba:	51                   	push   ecx
    b8bb:	e8 00 fe ff ff       	call   b6c0 <_ZN3VGA6scrollEc>
    b8c0:	83 c4 10             	add    esp,0x10
    b8c3:	83 c4 1c             	add    esp,0x1c
    b8c6:	5b                   	pop    ebx
    b8c7:	5e                   	pop    esi
    b8c8:	5f                   	pop    edi
    b8c9:	5d                   	pop    ebp
    b8ca:	e9 31 fd ff ff       	jmp    b600 <_ZN3VGA17_actualize_cursorEv>
    b8cf:	90                   	nop
    b8d0:	8d 57 01             	lea    edx,[edi+0x1]
    b8d3:	c7 05 00 20 01 00 00 	mov    DWORD PTR ds:0x12000,0x0
    b8da:	00 00 00 
    b8dd:	83 fa 18             	cmp    edx,0x18
    b8e0:	89 15 04 20 01 00    	mov    DWORD PTR ds:0x12004,edx
    b8e6:	7f cc                	jg     b8b4 <_ZN3VGA7putcharEcc+0xd4>
    b8e8:	83 c4 1c             	add    esp,0x1c
    b8eb:	5b                   	pop    ebx
    b8ec:	5e                   	pop    esi
    b8ed:	5f                   	pop    edi
    b8ee:	5d                   	pop    ebp
    b8ef:	e9 0c fd ff ff       	jmp    b600 <_ZN3VGA17_actualize_cursorEv>
    b8f4:	8b 2d 00 20 01 00    	mov    ebp,DWORD PTR ds:0x12000
    b8fa:	be 01 00 00 00       	mov    esi,0x1
    b8ff:	83 fd 4f             	cmp    ebp,0x4f
    b902:	89 ea                	mov    edx,ebp
    b904:	0f 8f 19 ff ff ff    	jg     b823 <_ZN3VGA7putcharEcc+0x43>
    b90a:	83 ff 18             	cmp    edi,0x18
    b90d:	0f 8e 49 ff ff ff    	jle    b85c <_ZN3VGA7putcharEcc+0x7c>
    b913:	90                   	nop
    b914:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b918:	83 ec 0c             	sub    esp,0xc
    b91b:	0f be c1             	movsx  eax,cl
    b91e:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    b922:	50                   	push   eax
    b923:	e8 98 fd ff ff       	call   b6c0 <_ZN3VGA6scrollEc>
    b928:	83 c4 10             	add    esp,0x10
    b92b:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    b92f:	e9 16 ff ff ff       	jmp    b84a <_ZN3VGA7putcharEcc+0x6a>
    b934:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b938:	83 ff 18             	cmp    edi,0x18
    b93b:	0f 8e 4e ff ff ff    	jle    b88f <_ZN3VGA7putcharEcc+0xaf>
    b941:	eb d5                	jmp    b918 <_ZN3VGA7putcharEcc+0x138>
    b943:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b949:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b950 <_ZN3VGA5printEPKcc>:
    b950:	56                   	push   esi
    b951:	53                   	push   ebx
    b952:	83 ec 04             	sub    esp,0x4
    b955:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    b959:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    b95d:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    b960:	84 c0                	test   al,al
    b962:	74 24                	je     b988 <_ZN3VGA5printEPKcc+0x38>
    b964:	0f be f2             	movsx  esi,dl
    b967:	83 c3 01             	add    ebx,0x1
    b96a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b970:	83 ec 08             	sub    esp,0x8
    b973:	83 c3 01             	add    ebx,0x1
    b976:	56                   	push   esi
    b977:	50                   	push   eax
    b978:	e8 63 fe ff ff       	call   b7e0 <_ZN3VGA7putcharEcc>
    b97d:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    b981:	83 c4 10             	add    esp,0x10
    b984:	84 c0                	test   al,al
    b986:	75 e8                	jne    b970 <_ZN3VGA5printEPKcc+0x20>
    b988:	83 c4 04             	add    esp,0x4
    b98b:	5b                   	pop    ebx
    b98c:	5e                   	pop    esi
    b98d:	c3                   	ret    
    b98e:	66 90                	xchg   ax,ax

0000b990 <_ZN3VGA17_put_nbr_base_recEii>:
    b990:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    b994:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    b998:	85 c0                	test   eax,eax
    b99a:	75 04                	jne    b9a0 <_ZN3VGA17_put_nbr_base_recEii+0x10>
    b99c:	f3 c3                	repz ret 
    b99e:	66 90                	xchg   ax,ax
    b9a0:	eb 0e                	jmp    b9b0 <_ZN3VGA17_put_nbr_base_recEii.part.0>
    b9a2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b9a9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b9b0 <_ZN3VGA17_put_nbr_base_recEii.part.0>:
    b9b0:	89 d1                	mov    ecx,edx
    b9b2:	99                   	cdq    
    b9b3:	53                   	push   ebx
    b9b4:	f7 f9                	idiv   ecx
    b9b6:	83 ec 10             	sub    esp,0x10
    b9b9:	51                   	push   ecx
    b9ba:	50                   	push   eax
    b9bb:	89 d3                	mov    ebx,edx
    b9bd:	e8 ce ff ff ff       	call   b990 <_ZN3VGA17_put_nbr_base_recEii>
    b9c2:	58                   	pop    eax
    b9c3:	0f be 83 00 10 01 00 	movsx  eax,BYTE PTR [ebx+0x11000]
    b9ca:	5a                   	pop    edx
    b9cb:	6a 0f                	push   0xf
    b9cd:	50                   	push   eax
    b9ce:	e8 0d fe ff ff       	call   b7e0 <_ZN3VGA7putcharEcc>
    b9d3:	83 c4 18             	add    esp,0x18
    b9d6:	5b                   	pop    ebx
    b9d7:	c3                   	ret    
    b9d8:	90                   	nop
    b9d9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b9e0 <_ZN3VGA13_put_nbr_baseEjib>:
    b9e0:	56                   	push   esi
    b9e1:	53                   	push   ebx
    b9e2:	83 ec 04             	sub    esp,0x4
    b9e5:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    b9e9:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b9ed:	8b 44 24 18          	mov    eax,DWORD PTR [esp+0x18]
    b9f1:	85 db                	test   ebx,ebx
    b9f3:	79 04                	jns    b9f9 <_ZN3VGA13_put_nbr_baseEjib+0x19>
    b9f5:	3c 01                	cmp    al,0x1
    b9f7:	75 37                	jne    ba30 <_ZN3VGA13_put_nbr_baseEjib+0x50>
    b9f9:	85 db                	test   ebx,ebx
    b9fb:	74 7b                	je     ba78 <_ZN3VGA13_put_nbr_baseEjib+0x98>
    b9fd:	89 d8                	mov    eax,ebx
    b9ff:	31 d2                	xor    edx,edx
    ba01:	f7 f6                	div    esi
    ba03:	85 c0                	test   eax,eax
    ba05:	89 d3                	mov    ebx,edx
    ba07:	0f 85 8b 00 00 00    	jne    ba98 <_ZN3VGA13_put_nbr_baseEjib+0xb8>
    ba0d:	0f be 83 00 10 01 00 	movsx  eax,BYTE PTR [ebx+0x11000]
    ba14:	c7 44 24 14 0f 00 00 	mov    DWORD PTR [esp+0x14],0xf
    ba1b:	00 
    ba1c:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    ba20:	83 c4 04             	add    esp,0x4
    ba23:	5b                   	pop    ebx
    ba24:	5e                   	pop    esi
    ba25:	e9 b6 fd ff ff       	jmp    b7e0 <_ZN3VGA7putcharEcc>
    ba2a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ba30:	83 ec 08             	sub    esp,0x8
    ba33:	6a 0f                	push   0xf
    ba35:	6a 2d                	push   0x2d
    ba37:	e8 a4 fd ff ff       	call   b7e0 <_ZN3VGA7putcharEcc>
    ba3c:	89 d8                	mov    eax,ebx
    ba3e:	83 c4 10             	add    esp,0x10
    ba41:	99                   	cdq    
    ba42:	f7 fe                	idiv   esi
    ba44:	85 c0                	test   eax,eax
    ba46:	74 09                	je     ba51 <_ZN3VGA13_put_nbr_baseEjib+0x71>
    ba48:	f7 d8                	neg    eax
    ba4a:	89 f2                	mov    edx,esi
    ba4c:	e8 5f ff ff ff       	call   b9b0 <_ZN3VGA17_put_nbr_base_recEii.part.0>
    ba51:	89 d8                	mov    eax,ebx
    ba53:	c7 44 24 14 0f 00 00 	mov    DWORD PTR [esp+0x14],0xf
    ba5a:	00 
    ba5b:	f7 d8                	neg    eax
    ba5d:	99                   	cdq    
    ba5e:	f7 fe                	idiv   esi
    ba60:	0f be 82 00 10 01 00 	movsx  eax,BYTE PTR [edx+0x11000]
    ba67:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    ba6b:	83 c4 04             	add    esp,0x4
    ba6e:	5b                   	pop    ebx
    ba6f:	5e                   	pop    esi
    ba70:	e9 6b fd ff ff       	jmp    b7e0 <_ZN3VGA7putcharEcc>
    ba75:	8d 76 00             	lea    esi,[esi+0x0]
    ba78:	0f be 05 00 10 01 00 	movsx  eax,BYTE PTR ds:0x11000
    ba7f:	c7 44 24 14 0f 00 00 	mov    DWORD PTR [esp+0x14],0xf
    ba86:	00 
    ba87:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    ba8b:	83 c4 04             	add    esp,0x4
    ba8e:	5b                   	pop    ebx
    ba8f:	5e                   	pop    esi
    ba90:	e9 4b fd ff ff       	jmp    b7e0 <_ZN3VGA7putcharEcc>
    ba95:	8d 76 00             	lea    esi,[esi+0x0]
    ba98:	89 f2                	mov    edx,esi
    ba9a:	e8 11 ff ff ff       	call   b9b0 <_ZN3VGA17_put_nbr_base_recEii.part.0>
    ba9f:	e9 69 ff ff ff       	jmp    ba0d <_ZN3VGA13_put_nbr_baseEjib+0x2d>
    baa4:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    baaa:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000bab0 <_ZN3VGA6putHexEi>:
    bab0:	83 ec 10             	sub    esp,0x10
    bab3:	6a 01                	push   0x1
    bab5:	6a 10                	push   0x10
    bab7:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    babb:	e8 20 ff ff ff       	call   b9e0 <_ZN3VGA13_put_nbr_baseEjib>
    bac0:	83 c4 1c             	add    esp,0x1c
    bac3:	c3                   	ret    
    bac4:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    baca:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000bad0 <_ZN3VGA6putDecEi>:
    bad0:	83 ec 10             	sub    esp,0x10
    bad3:	6a 00                	push   0x0
    bad5:	6a 0a                	push   0xa
    bad7:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    badb:	e8 00 ff ff ff       	call   b9e0 <_ZN3VGA13_put_nbr_baseEjib>
    bae0:	83 c4 1c             	add    esp,0x1c
    bae3:	c3                   	ret    
    bae4:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    baea:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000baf0 <_ZN3VGA6putOctEi>:
    baf0:	83 ec 10             	sub    esp,0x10
    baf3:	6a 00                	push   0x0
    baf5:	6a 08                	push   0x8
    baf7:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    bafb:	e8 e0 fe ff ff       	call   b9e0 <_ZN3VGA13_put_nbr_baseEjib>
    bb00:	83 c4 1c             	add    esp,0x1c
    bb03:	c3                   	ret    
    bb04:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bb0a:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000bb10 <_ZN3VGA6putBinEi>:
    bb10:	57                   	push   edi
    bb11:	56                   	push   esi
    bb12:	be 00 00 00 80       	mov    esi,0x80000000
    bb17:	53                   	push   ebx
    bb18:	8b 7c 24 10          	mov    edi,DWORD PTR [esp+0x10]
    bb1c:	31 db                	xor    ebx,ebx
    bb1e:	66 90                	xchg   ax,ax
    bb20:	85 f7                	test   edi,esi
    bb22:	74 2c                	je     bb50 <_ZN3VGA6putBinEi+0x40>
    bb24:	0f be 05 01 10 01 00 	movsx  eax,BYTE PTR ds:0x11001
    bb2b:	83 ec 08             	sub    esp,0x8
    bb2e:	83 c3 01             	add    ebx,0x1
    bb31:	6a 0f                	push   0xf
    bb33:	d1 ee                	shr    esi,1
    bb35:	50                   	push   eax
    bb36:	e8 a5 fc ff ff       	call   b7e0 <_ZN3VGA7putcharEcc>
    bb3b:	83 c4 10             	add    esp,0x10
    bb3e:	f6 c3 07             	test   bl,0x7
    bb41:	75 2c                	jne    bb6f <_ZN3VGA6putBinEi+0x5f>
    bb43:	83 fb 20             	cmp    ebx,0x20
    bb46:	75 38                	jne    bb80 <_ZN3VGA6putBinEi+0x70>
    bb48:	5b                   	pop    ebx
    bb49:	5e                   	pop    esi
    bb4a:	5f                   	pop    edi
    bb4b:	c3                   	ret    
    bb4c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bb50:	0f be 05 00 10 01 00 	movsx  eax,BYTE PTR ds:0x11000
    bb57:	83 ec 08             	sub    esp,0x8
    bb5a:	83 c3 01             	add    ebx,0x1
    bb5d:	6a 0f                	push   0xf
    bb5f:	d1 ee                	shr    esi,1
    bb61:	50                   	push   eax
    bb62:	e8 79 fc ff ff       	call   b7e0 <_ZN3VGA7putcharEcc>
    bb67:	83 c4 10             	add    esp,0x10
    bb6a:	f6 c3 07             	test   bl,0x7
    bb6d:	74 d4                	je     bb43 <_ZN3VGA6putBinEi+0x33>
    bb6f:	83 fb 20             	cmp    ebx,0x20
    bb72:	75 ac                	jne    bb20 <_ZN3VGA6putBinEi+0x10>
    bb74:	eb d2                	jmp    bb48 <_ZN3VGA6putBinEi+0x38>
    bb76:	8d 76 00             	lea    esi,[esi+0x0]
    bb79:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bb80:	83 ec 08             	sub    esp,0x8
    bb83:	6a 0f                	push   0xf
    bb85:	6a 27                	push   0x27
    bb87:	e8 54 fc ff ff       	call   b7e0 <_ZN3VGA7putcharEcc>
    bb8c:	83 c4 10             	add    esp,0x10
    bb8f:	eb 8f                	jmp    bb20 <_ZN3VGA6putBinEi+0x10>
    bb91:	66 90                	xchg   ax,ax
    bb93:	66 90                	xchg   ax,ax
    bb95:	66 90                	xchg   ax,ax
    bb97:	66 90                	xchg   ax,ax
    bb99:	66 90                	xchg   ax,ax
    bb9b:	66 90                	xchg   ax,ax
    bb9d:	66 90                	xchg   ax,ax
    bb9f:	90                   	nop

0000bba0 <_Z12clear_screenv>:
    bba0:	83 ec 18             	sub    esp,0x18
    bba3:	6a 0f                	push   0xf
    bba5:	e8 d6 fb ff ff       	call   b780 <_ZN3VGA12clear_screenEc>
    bbaa:	83 c4 1c             	add    esp,0x1c
    bbad:	c3                   	ret    
    bbae:	66 90                	xchg   ax,ax

0000bbb0 <_Z7putcharc>:
    bbb0:	83 ec 14             	sub    esp,0x14
    bbb3:	6a 0f                	push   0xf
    bbb5:	0f be 44 24 1c       	movsx  eax,BYTE PTR [esp+0x1c]
    bbba:	50                   	push   eax
    bbbb:	e8 20 fc ff ff       	call   b7e0 <_ZN3VGA7putcharEcc>
    bbc0:	83 c4 1c             	add    esp,0x1c
    bbc3:	c3                   	ret    
    bbc4:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bbca:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000bbd0 <_Z6putdeci>:
    bbd0:	e9 fb fe ff ff       	jmp    bad0 <_ZN3VGA6putDecEi>
    bbd5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bbd9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bbe0 <_Z6puthexi>:
    bbe0:	e9 cb fe ff ff       	jmp    bab0 <_ZN3VGA6putHexEi>
    bbe5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bbe9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bbf0 <_Z6putocti>:
    bbf0:	e9 fb fe ff ff       	jmp    baf0 <_ZN3VGA6putOctEi>
    bbf5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bbf9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bc00 <_Z6putbini>:
    bc00:	e9 0b ff ff ff       	jmp    bb10 <_ZN3VGA6putBinEi>
    bc05:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bc09:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bc10 <_Z6putstrPc>:
    bc10:	83 ec 14             	sub    esp,0x14
    bc13:	6a 0f                	push   0xf
    bc15:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    bc19:	e8 32 fd ff ff       	call   b950 <_ZN3VGA5printEPKcc>
    bc1e:	83 c4 1c             	add    esp,0x1c
    bc21:	c3                   	ret    
    bc22:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bc29:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bc30 <_Z6printfPKc>:
    bc30:	53                   	push   ebx
    bc31:	83 ec 08             	sub    esp,0x8
    bc34:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    bc38:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    bc3b:	84 c0                	test   al,al
    bc3d:	74 22                	je     bc61 <_Z6printfPKc+0x31>
    bc3f:	83 c3 01             	add    ebx,0x1
    bc42:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bc48:	83 ec 08             	sub    esp,0x8
    bc4b:	83 c3 01             	add    ebx,0x1
    bc4e:	6a 0f                	push   0xf
    bc50:	50                   	push   eax
    bc51:	e8 8a fb ff ff       	call   b7e0 <_ZN3VGA7putcharEcc>
    bc56:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    bc5a:	83 c4 10             	add    esp,0x10
    bc5d:	84 c0                	test   al,al
    bc5f:	75 e7                	jne    bc48 <_Z6printfPKc+0x18>
    bc61:	83 c4 08             	add    esp,0x8
    bc64:	5b                   	pop    ebx
    bc65:	c3                   	ret    
    bc66:	66 90                	xchg   ax,ax
    bc68:	66 90                	xchg   ax,ax
    bc6a:	66 90                	xchg   ax,ax
    bc6c:	66 90                	xchg   ax,ax
    bc6e:	66 90                	xchg   ax,ax

0000bc70 <_ZN6serial4initEv>:
    bc70:	83 ec 14             	sub    esp,0x14
    bc73:	6a 00                	push   0x0
    bc75:	68 fb 03 00 00       	push   0x3fb
    bc7a:	e8 e1 00 00 00       	call   bd60 <_Z4outbth>
    bc7f:	58                   	pop    eax
    bc80:	5a                   	pop    edx
    bc81:	6a 00                	push   0x0
    bc83:	68 f9 03 00 00       	push   0x3f9
    bc88:	e8 d3 00 00 00       	call   bd60 <_Z4outbth>
    bc8d:	59                   	pop    ecx
    bc8e:	58                   	pop    eax
    bc8f:	68 80 00 00 00       	push   0x80
    bc94:	68 fb 03 00 00       	push   0x3fb
    bc99:	e8 c2 00 00 00       	call   bd60 <_Z4outbth>
    bc9e:	58                   	pop    eax
    bc9f:	5a                   	pop    edx
    bca0:	6a 01                	push   0x1
    bca2:	68 f8 03 00 00       	push   0x3f8
    bca7:	e8 b4 00 00 00       	call   bd60 <_Z4outbth>
    bcac:	59                   	pop    ecx
    bcad:	58                   	pop    eax
    bcae:	6a 00                	push   0x0
    bcb0:	68 f9 03 00 00       	push   0x3f9
    bcb5:	e8 a6 00 00 00       	call   bd60 <_Z4outbth>
    bcba:	58                   	pop    eax
    bcbb:	5a                   	pop    edx
    bcbc:	6a 03                	push   0x3
    bcbe:	68 fb 03 00 00       	push   0x3fb
    bcc3:	e8 98 00 00 00       	call   bd60 <_Z4outbth>
    bcc8:	59                   	pop    ecx
    bcc9:	58                   	pop    eax
    bcca:	68 c7 00 00 00       	push   0xc7
    bccf:	68 fa 03 00 00       	push   0x3fa
    bcd4:	e8 87 00 00 00       	call   bd60 <_Z4outbth>
    bcd9:	83 c4 1c             	add    esp,0x1c
    bcdc:	c3                   	ret    
    bcdd:	8d 76 00             	lea    esi,[esi+0x0]

0000bce0 <_ZN6serial6uninitEv>:
    bce0:	f3 c3                	repz ret 
    bce2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bce9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bcf0 <_ZN6serial7sendstrEPc>:
    bcf0:	53                   	push   ebx
    bcf1:	83 ec 14             	sub    esp,0x14
    bcf4:	8b 5c 24 1c          	mov    ebx,DWORD PTR [esp+0x1c]
    bcf8:	53                   	push   ebx
    bcf9:	e8 12 ff ff ff       	call   bc10 <_Z6putstrPc>
    bcfe:	c7 04 24 b8 e2 00 00 	mov    DWORD PTR [esp],0xe2b8
    bd05:	e8 26 ff ff ff       	call   bc30 <_Z6printfPKc>
    bd0a:	83 c4 10             	add    esp,0x10
    bd0d:	85 db                	test   ebx,ebx
    bd0f:	74 3f                	je     bd50 <_ZN6serial7sendstrEPc+0x60>
    bd11:	80 3b 00             	cmp    BYTE PTR [ebx],0x0
    bd14:	74 3a                	je     bd50 <_ZN6serial7sendstrEPc+0x60>
    bd16:	8d 76 00             	lea    esi,[esi+0x0]
    bd19:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bd20:	83 ec 0c             	sub    esp,0xc
    bd23:	68 fd 03 00 00       	push   0x3fd
    bd28:	e8 83 00 00 00       	call   bdb0 <_Z3inbt>
    bd2d:	83 c4 10             	add    esp,0x10
    bd30:	a8 20                	test   al,0x20
    bd32:	74 ec                	je     bd20 <_ZN6serial7sendstrEPc+0x30>
    bd34:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    bd37:	83 ec 08             	sub    esp,0x8
    bd3a:	83 c3 01             	add    ebx,0x1
    bd3d:	50                   	push   eax
    bd3e:	68 f8 03 00 00       	push   0x3f8
    bd43:	e8 18 00 00 00       	call   bd60 <_Z4outbth>
    bd48:	83 c4 10             	add    esp,0x10
    bd4b:	80 3b 00             	cmp    BYTE PTR [ebx],0x0
    bd4e:	75 d0                	jne    bd20 <_ZN6serial7sendstrEPc+0x30>
    bd50:	83 c4 08             	add    esp,0x8
    bd53:	5b                   	pop    ebx
    bd54:	c3                   	ret    
    bd55:	66 90                	xchg   ax,ax
    bd57:	66 90                	xchg   ax,ax
    bd59:	66 90                	xchg   ax,ax
    bd5b:	66 90                	xchg   ax,ax
    bd5d:	66 90                	xchg   ax,ax
    bd5f:	90                   	nop

0000bd60 <_Z4outbth>:
    bd60:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bd64:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    bd68:	ee                   	out    dx,al
    bd69:	c3                   	ret    
    bd6a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000bd70 <_Z4outwtt>:
    bd70:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bd74:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    bd78:	66 ef                	out    dx,ax
    bd7a:	c3                   	ret    
    bd7b:	90                   	nop
    bd7c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000bd80 <_Z4outdtj>:
    bd80:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bd84:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    bd88:	ef                   	out    dx,eax
    bd89:	c3                   	ret    
    bd8a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000bd90 <_Z4inwstjj>:
    bd90:	57                   	push   edi
    bd91:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    bd95:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    bd99:	8b 7c 24 0c          	mov    edi,DWORD PTR [esp+0xc]
    bd9d:	fc                   	cld    
    bd9e:	f3 6d                	rep ins DWORD PTR es:[edi],dx
    bda0:	5f                   	pop    edi
    bda1:	c3                   	ret    
    bda2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bda9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bdb0 <_Z3inbt>:
    bdb0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bdb4:	ec                   	in     al,dx
    bdb5:	c3                   	ret    
    bdb6:	8d 76 00             	lea    esi,[esi+0x0]
    bdb9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bdc0 <_Z3inwt>:
    bdc0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bdc4:	66 ed                	in     ax,dx
    bdc6:	c3                   	ret    
    bdc7:	89 f6                	mov    esi,esi
    bdc9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bdd0 <_Z3indt>:
    bdd0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bdd4:	ed                   	in     eax,dx
    bdd5:	c3                   	ret    
    bdd6:	8d 76 00             	lea    esi,[esi+0x0]
    bdd9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bde0 <_Z7io_waitv>:
    bde0:	31 c0                	xor    eax,eax
    bde2:	e6 80                	out    0x80,al
    bde4:	c3                   	ret    
    bde5:	66 90                	xchg   ax,ax
    bde7:	66 90                	xchg   ax,ax
    bde9:	66 90                	xchg   ax,ax
    bdeb:	66 90                	xchg   ax,ax
    bded:	66 90                	xchg   ax,ax
    bdef:	90                   	nop

0000bdf0 <_ZN3pci13configAddressEhhhh>:
    bdf0:	0f b6 44 24 10       	movzx  eax,BYTE PTR [esp+0x10]
    bdf5:	0f b6 54 24 0c       	movzx  edx,BYTE PTR [esp+0xc]
    bdfa:	c1 e0 02             	shl    eax,0x2
    bdfd:	c1 e2 08             	shl    edx,0x8
    be00:	0f b6 c0             	movzx  eax,al
    be03:	09 d0                	or     eax,edx
    be05:	0f b6 54 24 08       	movzx  edx,BYTE PTR [esp+0x8]
    be0a:	c1 e2 0b             	shl    edx,0xb
    be0d:	09 d0                	or     eax,edx
    be0f:	0f b6 54 24 04       	movzx  edx,BYTE PTR [esp+0x4]
    be14:	c1 e2 10             	shl    edx,0x10
    be17:	09 d0                	or     eax,edx
    be19:	0d 00 00 00 80       	or     eax,0x80000000
    be1e:	c3                   	ret    
    be1f:	90                   	nop

0000be20 <_ZN3pci14configReadByteEhhhhh>:
    be20:	53                   	push   ebx
    be21:	83 ec 10             	sub    esp,0x10
    be24:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    be29:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    be2e:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    be32:	c1 e2 0b             	shl    edx,0xb
    be35:	c1 e0 10             	shl    eax,0x10
    be38:	09 d0                	or     eax,edx
    be3a:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    be3f:	c1 e2 08             	shl    edx,0x8
    be42:	09 d0                	or     eax,edx
    be44:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    be49:	c1 e2 02             	shl    edx,0x2
    be4c:	0f b6 d2             	movzx  edx,dl
    be4f:	09 d0                	or     eax,edx
    be51:	0d 00 00 00 80       	or     eax,0x80000000
    be56:	50                   	push   eax
    be57:	68 f8 0c 00 00       	push   0xcf8
    be5c:	e8 1f ff ff ff       	call   bd80 <_Z4outdtj>
    be61:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    be68:	e8 63 ff ff ff       	call   bdd0 <_Z3indt>
    be6d:	0f b6 cb             	movzx  ecx,bl
    be70:	83 c4 18             	add    esp,0x18
    be73:	c1 e1 03             	shl    ecx,0x3
    be76:	d3 e8                	shr    eax,cl
    be78:	5b                   	pop    ebx
    be79:	c3                   	ret    
    be7a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000be80 <_ZN3pci14configReadWordEhhhhh>:
    be80:	53                   	push   ebx
    be81:	83 ec 10             	sub    esp,0x10
    be84:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    be89:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    be8e:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    be92:	c1 e2 0b             	shl    edx,0xb
    be95:	c1 e0 10             	shl    eax,0x10
    be98:	09 d0                	or     eax,edx
    be9a:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    be9f:	c1 e2 08             	shl    edx,0x8
    bea2:	09 d0                	or     eax,edx
    bea4:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    bea9:	c1 e2 02             	shl    edx,0x2
    beac:	0f b6 d2             	movzx  edx,dl
    beaf:	09 d0                	or     eax,edx
    beb1:	0d 00 00 00 80       	or     eax,0x80000000
    beb6:	50                   	push   eax
    beb7:	68 f8 0c 00 00       	push   0xcf8
    bebc:	e8 bf fe ff ff       	call   bd80 <_Z4outdtj>
    bec1:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    bec8:	e8 03 ff ff ff       	call   bdd0 <_Z3indt>
    becd:	0f b6 cb             	movzx  ecx,bl
    bed0:	83 c4 18             	add    esp,0x18
    bed3:	c1 e1 04             	shl    ecx,0x4
    bed6:	d3 e8                	shr    eax,cl
    bed8:	5b                   	pop    ebx
    bed9:	c3                   	ret    
    beda:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000bee0 <_ZN3pci10configReadEhhhh>:
    bee0:	83 ec 14             	sub    esp,0x14
    bee3:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    bee8:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    beed:	c1 e0 10             	shl    eax,0x10
    bef0:	c1 e2 0b             	shl    edx,0xb
    bef3:	09 d0                	or     eax,edx
    bef5:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    befa:	c1 e2 08             	shl    edx,0x8
    befd:	09 d0                	or     eax,edx
    beff:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    bf04:	c1 e2 02             	shl    edx,0x2
    bf07:	0f b6 d2             	movzx  edx,dl
    bf0a:	09 d0                	or     eax,edx
    bf0c:	0d 00 00 00 80       	or     eax,0x80000000
    bf11:	50                   	push   eax
    bf12:	68 f8 0c 00 00       	push   0xcf8
    bf17:	e8 64 fe ff ff       	call   bd80 <_Z4outdtj>
    bf1c:	c7 44 24 20 fc 0c 00 	mov    DWORD PTR [esp+0x20],0xcfc
    bf23:	00 
    bf24:	83 c4 1c             	add    esp,0x1c
    bf27:	e9 a4 fe ff ff       	jmp    bdd0 <_Z3indt>
    bf2c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000bf30 <_ZN3pci11checkDeviceEhhh>:
    bf30:	83 ec 18             	sub    esp,0x18
    bf33:	6a 00                	push   0x0
    bf35:	6a 00                	push   0x0
    bf37:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    bf3c:	50                   	push   eax
    bf3d:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    bf42:	50                   	push   eax
    bf43:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    bf48:	50                   	push   eax
    bf49:	e8 32 ff ff ff       	call   be80 <_ZN3pci14configReadWordEhhhhh>
    bf4e:	66 83 f8 ff          	cmp    ax,0xffff
    bf52:	0f 95 c0             	setne  al
    bf55:	83 c4 2c             	add    esp,0x2c
    bf58:	c3                   	ret    
    bf59:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000bf60 <_ZN3pci11printBussesEv>:
    bf60:	55                   	push   ebp
    bf61:	57                   	push   edi
    bf62:	56                   	push   esi
    bf63:	53                   	push   ebx
    bf64:	83 ec 4c             	sub    esp,0x4c
    bf67:	c7 44 24 10 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    bf6e:	00 
    bf6f:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    bf76:	00 
    bf77:	89 f6                	mov    esi,esi
    bf79:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bf80:	31 f6                	xor    esi,esi
    bf82:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bf88:	83 ec 0c             	sub    esp,0xc
    bf8b:	6a 00                	push   0x0
    bf8d:	6a 00                	push   0x0
    bf8f:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    bf93:	53                   	push   ebx
    bf94:	56                   	push   esi
    bf95:	8b 7c 24 28          	mov    edi,DWORD PTR [esp+0x28]
    bf99:	57                   	push   edi
    bf9a:	e8 e1 fe ff ff       	call   be80 <_ZN3pci14configReadWordEhhhhh>
    bf9f:	83 c4 20             	add    esp,0x20
    bfa2:	66 83 f8 ff          	cmp    ax,0xffff
    bfa6:	0f 84 6c 01 00 00    	je     c118 <_ZN3pci11printBussesEv+0x1b8>
    bfac:	83 ec 0c             	sub    esp,0xc
    bfaf:	6a 00                	push   0x0
    bfb1:	6a 02                	push   0x2
    bfb3:	53                   	push   ebx
    bfb4:	56                   	push   esi
    bfb5:	57                   	push   edi
    bfb6:	e8 65 fe ff ff       	call   be20 <_ZN3pci14configReadByteEhhhhh>
    bfbb:	88 44 24 38          	mov    BYTE PTR [esp+0x38],al
    bfbf:	83 c4 14             	add    esp,0x14
    bfc2:	6a 01                	push   0x1
    bfc4:	6a 02                	push   0x2
    bfc6:	53                   	push   ebx
    bfc7:	56                   	push   esi
    bfc8:	57                   	push   edi
    bfc9:	e8 52 fe ff ff       	call   be20 <_ZN3pci14configReadByteEhhhhh>
    bfce:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    bfd2:	83 c4 14             	add    esp,0x14
    bfd5:	6a 02                	push   0x2
    bfd7:	6a 02                	push   0x2
    bfd9:	53                   	push   ebx
    bfda:	56                   	push   esi
    bfdb:	57                   	push   edi
    bfdc:	e8 3f fe ff ff       	call   be20 <_ZN3pci14configReadByteEhhhhh>
    bfe1:	83 c4 14             	add    esp,0x14
    bfe4:	89 c5                	mov    ebp,eax
    bfe6:	6a 03                	push   0x3
    bfe8:	6a 02                	push   0x2
    bfea:	53                   	push   ebx
    bfeb:	56                   	push   esi
    bfec:	57                   	push   edi
    bfed:	31 ff                	xor    edi,edi
    bfef:	e8 2c fe ff ff       	call   be20 <_ZN3pci14configReadByteEhhhhh>
    bff4:	ba 43 00 00 00       	mov    edx,0x43
    bff9:	88 44 24 4f          	mov    BYTE PTR [esp+0x4f],al
    bffd:	83 c4 20             	add    esp,0x20
    c000:	eb 29                	jmp    c02b <_ZN3pci11printBussesEv+0xcb>
    c002:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c008:	3c 25                	cmp    al,0x25
    c00a:	0f 84 90 03 00 00    	je     c3a0 <_ZN3pci11printBussesEv+0x440>
    c010:	84 c0                	test   al,al
    c012:	0f 85 d8 01 00 00    	jne    c1f0 <_ZN3pci11printBussesEv+0x290>
    c018:	8d 5f 02             	lea    ebx,[edi+0x2]
    c01b:	0f b6 83 90 e3 00 00 	movzx  eax,BYTE PTR [ebx+0xe390]
    c022:	84 c0                	test   al,al
    c024:	74 3a                	je     c060 <_ZN3pci11printBussesEv+0x100>
    c026:	0f be d0             	movsx  edx,al
    c029:	89 df                	mov    edi,ebx
    c02b:	8d 5f 01             	lea    ebx,[edi+0x1]
    c02e:	80 fa 25             	cmp    dl,0x25
    c031:	0f b6 83 90 e3 00 00 	movzx  eax,BYTE PTR [ebx+0xe390]
    c038:	8d 8b 90 e3 00 00    	lea    ecx,[ebx+0xe390]
    c03e:	74 c8                	je     c008 <_ZN3pci11printBussesEv+0xa8>
    c040:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    c044:	83 ec 0c             	sub    esp,0xc
    c047:	52                   	push   edx
    c048:	e8 63 fb ff ff       	call   bbb0 <_Z7putcharc>
    c04d:	83 c4 10             	add    esp,0x10
    c050:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    c055:	84 c0                	test   al,al
    c057:	75 cd                	jne    c026 <_ZN3pci11printBussesEv+0xc6>
    c059:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c060:	6a 04                	push   0x4
    c062:	8b 6c 24 14          	mov    ebp,DWORD PTR [esp+0x14]
    c066:	55                   	push   ebp
    c067:	56                   	push   esi
    c068:	8b 5c 24 18          	mov    ebx,DWORD PTR [esp+0x18]
    c06c:	53                   	push   ebx
    c06d:	e8 6e fe ff ff       	call   bee0 <_ZN3pci10configReadEhhhh>
    c072:	c7 04 24 03 00 00 00 	mov    DWORD PTR [esp],0x3
    c079:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    c07d:	6a 03                	push   0x3
    c07f:	55                   	push   ebp
    c080:	56                   	push   esi
    c081:	53                   	push   ebx
    c082:	e8 99 fd ff ff       	call   be20 <_ZN3pci14configReadByteEhhhhh>
    c087:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    c08b:	83 c4 14             	add    esp,0x14
    c08e:	6a 01                	push   0x1
    c090:	6a 00                	push   0x0
    c092:	55                   	push   ebp
    c093:	56                   	push   esi
    c094:	53                   	push   ebx
    c095:	e8 e6 fd ff ff       	call   be80 <_ZN3pci14configReadWordEhhhhh>
    c09a:	83 c4 14             	add    esp,0x14
    c09d:	89 c7                	mov    edi,eax
    c09f:	6a 00                	push   0x0
    c0a1:	6a 00                	push   0x0
    c0a3:	55                   	push   ebp
    c0a4:	56                   	push   esi
    c0a5:	31 ed                	xor    ebp,ebp
    c0a7:	53                   	push   ebx
    c0a8:	e8 d3 fd ff ff       	call   be80 <_ZN3pci14configReadWordEhhhhh>
    c0ad:	ba 56 00 00 00       	mov    edx,0x56
    c0b2:	66 89 44 24 54       	mov    WORD PTR [esp+0x54],ax
    c0b7:	83 c4 20             	add    esp,0x20
    c0ba:	eb 27                	jmp    c0e3 <_ZN3pci11printBussesEv+0x183>
    c0bc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c0c0:	3c 25                	cmp    al,0x25
    c0c2:	0f 84 00 03 00 00    	je     c3c8 <_ZN3pci11printBussesEv+0x468>
    c0c8:	84 c0                	test   al,al
    c0ca:	0f 85 90 00 00 00    	jne    c160 <_ZN3pci11printBussesEv+0x200>
    c0d0:	8d 5d 02             	lea    ebx,[ebp+0x2]
    c0d3:	0f b6 83 d4 e3 00 00 	movzx  eax,BYTE PTR [ebx+0xe3d4]
    c0da:	84 c0                	test   al,al
    c0dc:	74 3a                	je     c118 <_ZN3pci11printBussesEv+0x1b8>
    c0de:	0f be d0             	movsx  edx,al
    c0e1:	89 dd                	mov    ebp,ebx
    c0e3:	8d 5d 01             	lea    ebx,[ebp+0x1]
    c0e6:	80 fa 25             	cmp    dl,0x25
    c0e9:	0f b6 83 d4 e3 00 00 	movzx  eax,BYTE PTR [ebx+0xe3d4]
    c0f0:	8d 8b d4 e3 00 00    	lea    ecx,[ebx+0xe3d4]
    c0f6:	74 c8                	je     c0c0 <_ZN3pci11printBussesEv+0x160>
    c0f8:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    c0fc:	83 ec 0c             	sub    esp,0xc
    c0ff:	52                   	push   edx
    c100:	e8 ab fa ff ff       	call   bbb0 <_Z7putcharc>
    c105:	83 c4 10             	add    esp,0x10
    c108:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    c10d:	84 c0                	test   al,al
    c10f:	75 cd                	jne    c0de <_ZN3pci11printBussesEv+0x17e>
    c111:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c118:	83 c6 01             	add    esi,0x1
    c11b:	83 fe 20             	cmp    esi,0x20
    c11e:	0f 85 64 fe ff ff    	jne    bf88 <_ZN3pci11printBussesEv+0x28>
    c124:	83 44 24 0c 01       	add    DWORD PTR [esp+0xc],0x1
    c129:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    c12d:	3d 00 01 00 00       	cmp    eax,0x100
    c132:	0f 85 48 fe ff ff    	jne    bf80 <_ZN3pci11printBussesEv+0x20>
    c138:	83 44 24 10 01       	add    DWORD PTR [esp+0x10],0x1
    c13d:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c141:	83 f8 08             	cmp    eax,0x8
    c144:	0f 85 25 fe ff ff    	jne    bf6f <_ZN3pci11printBussesEv+0xf>
    c14a:	83 ec 0c             	sub    esp,0xc
    c14d:	68 ba e2 00 00       	push   0xe2ba
    c152:	e8 d9 fa ff ff       	call   bc30 <_Z6printfPKc>
    c157:	83 c4 5c             	add    esp,0x5c
    c15a:	5b                   	pop    ebx
    c15b:	5e                   	pop    esi
    c15c:	5f                   	pop    edi
    c15d:	5d                   	pop    ebp
    c15e:	c3                   	ret    
    c15f:	90                   	nop
    c160:	83 ec 08             	sub    esp,0x8
    c163:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    c167:	50                   	push   eax
    c168:	51                   	push   ecx
    c169:	e8 02 0b 00 00       	call   cc70 <_Z14_manage_escapeItEiPKcPT_>
    c16e:	01 c3                	add    ebx,eax
    c170:	66 89 7c 24 46       	mov    WORD PTR [esp+0x46],di
    c175:	83 c4 10             	add    esp,0x10
    c178:	0f be 83 d4 e3 00 00 	movsx  eax,BYTE PTR [ebx+0xe3d4]
    c17f:	8d ab d4 e3 00 00    	lea    ebp,[ebx+0xe3d4]
    c185:	84 c0                	test   al,al
    c187:	74 8f                	je     c118 <_ZN3pci11printBussesEv+0x1b8>
    c189:	31 d2                	xor    edx,edx
    c18b:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    c18f:	89 ee                	mov    esi,ebp
    c191:	89 d5                	mov    ebp,edx
    c193:	eb 25                	jmp    c1ba <_ZN3pci11printBussesEv+0x25a>
    c195:	8d 76 00             	lea    esi,[esi+0x0]
    c198:	80 fb 25             	cmp    bl,0x25
    c19b:	0f 84 7f 03 00 00    	je     c520 <_ZN3pci11printBussesEv+0x5c0>
    c1a1:	84 db                	test   bl,bl
    c1a3:	0f 85 d7 00 00 00    	jne    c280 <_ZN3pci11printBussesEv+0x320>
    c1a9:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c1ae:	8d 7d 02             	lea    edi,[ebp+0x2]
    c1b1:	84 db                	test   bl,bl
    c1b3:	74 22                	je     c1d7 <_ZN3pci11printBussesEv+0x277>
    c1b5:	0f be c3             	movsx  eax,bl
    c1b8:	89 fd                	mov    ebp,edi
    c1ba:	8d 7d 01             	lea    edi,[ebp+0x1]
    c1bd:	3c 25                	cmp    al,0x25
    c1bf:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c1c2:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c1c5:	74 d1                	je     c198 <_ZN3pci11printBussesEv+0x238>
    c1c7:	83 ec 0c             	sub    esp,0xc
    c1ca:	50                   	push   eax
    c1cb:	e8 e0 f9 ff ff       	call   bbb0 <_Z7putcharc>
    c1d0:	83 c4 10             	add    esp,0x10
    c1d3:	84 db                	test   bl,bl
    c1d5:	75 de                	jne    c1b5 <_ZN3pci11printBussesEv+0x255>
    c1d7:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c1db:	83 c6 01             	add    esi,0x1
    c1de:	83 fe 20             	cmp    esi,0x20
    c1e1:	0f 85 a1 fd ff ff    	jne    bf88 <_ZN3pci11printBussesEv+0x28>
    c1e7:	e9 38 ff ff ff       	jmp    c124 <_ZN3pci11printBussesEv+0x1c4>
    c1ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c1f0:	83 ec 08             	sub    esp,0x8
    c1f3:	8d 44 24 37          	lea    eax,[esp+0x37]
    c1f7:	50                   	push   eax
    c1f8:	51                   	push   ecx
    c1f9:	e8 a2 0f 00 00       	call   d1a0 <_Z14_manage_escapeIhEiPKcPT_>
    c1fe:	01 c3                	add    ebx,eax
    c200:	89 e8                	mov    eax,ebp
    c202:	88 44 24 40          	mov    BYTE PTR [esp+0x40],al
    c206:	0f be 83 90 e3 00 00 	movsx  eax,BYTE PTR [ebx+0xe390]
    c20d:	83 c4 10             	add    esp,0x10
    c210:	8d 93 90 e3 00 00    	lea    edx,[ebx+0xe390]
    c216:	84 c0                	test   al,al
    c218:	0f 84 42 fe ff ff    	je     c060 <_ZN3pci11printBussesEv+0x100>
    c21e:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    c222:	31 ed                	xor    ebp,ebp
    c224:	89 d6                	mov    esi,edx
    c226:	eb 2a                	jmp    c252 <_ZN3pci11printBussesEv+0x2f2>
    c228:	90                   	nop
    c229:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c230:	80 fb 25             	cmp    bl,0x25
    c233:	0f 84 17 03 00 00    	je     c550 <_ZN3pci11printBussesEv+0x5f0>
    c239:	84 db                	test   bl,bl
    c23b:	0f 85 cf 00 00 00    	jne    c310 <_ZN3pci11printBussesEv+0x3b0>
    c241:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c246:	8d 7d 02             	lea    edi,[ebp+0x2]
    c249:	84 db                	test   bl,bl
    c24b:	74 22                	je     c26f <_ZN3pci11printBussesEv+0x30f>
    c24d:	0f be c3             	movsx  eax,bl
    c250:	89 fd                	mov    ebp,edi
    c252:	8d 7d 01             	lea    edi,[ebp+0x1]
    c255:	3c 25                	cmp    al,0x25
    c257:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c25a:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c25d:	74 d1                	je     c230 <_ZN3pci11printBussesEv+0x2d0>
    c25f:	83 ec 0c             	sub    esp,0xc
    c262:	50                   	push   eax
    c263:	e8 48 f9 ff ff       	call   bbb0 <_Z7putcharc>
    c268:	83 c4 10             	add    esp,0x10
    c26b:	84 db                	test   bl,bl
    c26d:	75 de                	jne    c24d <_ZN3pci11printBussesEv+0x2ed>
    c26f:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c273:	e9 e8 fd ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c278:	90                   	nop
    c279:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c280:	83 ec 08             	sub    esp,0x8
    c283:	89 f5                	mov    ebp,esi
    c285:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    c289:	8d 44 24 3e          	lea    eax,[esp+0x3e]
    c28d:	50                   	push   eax
    c28e:	51                   	push   ecx
    c28f:	e8 dc 09 00 00       	call   cc70 <_Z14_manage_escapeItEiPKcPT_>
    c294:	8d 1c 38             	lea    ebx,[eax+edi*1]
    c297:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    c29c:	01 dd                	add    ebp,ebx
    c29e:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    c2a2:	88 44 24 43          	mov    BYTE PTR [esp+0x43],al
    c2a6:	83 c4 10             	add    esp,0x10
    c2a9:	84 d2                	test   dl,dl
    c2ab:	0f 84 67 fe ff ff    	je     c118 <_ZN3pci11printBussesEv+0x1b8>
    c2b1:	31 ff                	xor    edi,edi
    c2b3:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    c2b7:	89 ee                	mov    esi,ebp
    c2b9:	89 fd                	mov    ebp,edi
    c2bb:	eb 29                	jmp    c2e6 <_ZN3pci11printBussesEv+0x386>
    c2bd:	8d 76 00             	lea    esi,[esi+0x0]
    c2c0:	80 fb 25             	cmp    bl,0x25
    c2c3:	0f 84 57 04 00 00    	je     c720 <_ZN3pci11printBussesEv+0x7c0>
    c2c9:	84 db                	test   bl,bl
    c2cb:	0f 85 2f 01 00 00    	jne    c400 <_ZN3pci11printBussesEv+0x4a0>
    c2d1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c2d6:	8d 7d 02             	lea    edi,[ebp+0x2]
    c2d9:	84 db                	test   bl,bl
    c2db:	0f 84 f6 fe ff ff    	je     c1d7 <_ZN3pci11printBussesEv+0x277>
    c2e1:	0f be d3             	movsx  edx,bl
    c2e4:	89 fd                	mov    ebp,edi
    c2e6:	8d 7d 01             	lea    edi,[ebp+0x1]
    c2e9:	80 fa 25             	cmp    dl,0x25
    c2ec:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c2ef:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c2f2:	74 cc                	je     c2c0 <_ZN3pci11printBussesEv+0x360>
    c2f4:	83 ec 0c             	sub    esp,0xc
    c2f7:	52                   	push   edx
    c2f8:	e8 b3 f8 ff ff       	call   bbb0 <_Z7putcharc>
    c2fd:	83 c4 10             	add    esp,0x10
    c300:	84 db                	test   bl,bl
    c302:	75 dd                	jne    c2e1 <_ZN3pci11printBussesEv+0x381>
    c304:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c308:	e9 ce fe ff ff       	jmp    c1db <_ZN3pci11printBussesEv+0x27b>
    c30d:	8d 76 00             	lea    esi,[esi+0x0]
    c310:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    c314:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c318:	83 ec 08             	sub    esp,0x8
    c31b:	8d 44 24 38          	lea    eax,[esp+0x38]
    c31f:	50                   	push   eax
    c320:	51                   	push   ecx
    c321:	e8 7a 0e 00 00       	call   d1a0 <_Z14_manage_escapeIhEiPKcPT_>
    c326:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    c32a:	01 c7                	add    edi,eax
    c32c:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    c331:	01 fa                	add    edx,edi
    c333:	88 44 24 41          	mov    BYTE PTR [esp+0x41],al
    c337:	0f be 02             	movsx  eax,BYTE PTR [edx]
    c33a:	83 c4 10             	add    esp,0x10
    c33d:	84 c0                	test   al,al
    c33f:	0f 84 1b fd ff ff    	je     c060 <_ZN3pci11printBussesEv+0x100>
    c345:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    c349:	31 ff                	xor    edi,edi
    c34b:	89 d6                	mov    esi,edx
    c34d:	eb 23                	jmp    c372 <_ZN3pci11printBussesEv+0x412>
    c34f:	90                   	nop
    c350:	80 fb 25             	cmp    bl,0x25
    c353:	0f 84 97 03 00 00    	je     c6f0 <_ZN3pci11printBussesEv+0x790>
    c359:	84 db                	test   bl,bl
    c35b:	0f 85 27 01 00 00    	jne    c488 <_ZN3pci11printBussesEv+0x528>
    c361:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    c366:	8d 6f 02             	lea    ebp,[edi+0x2]
    c369:	84 db                	test   bl,bl
    c36b:	74 22                	je     c38f <_ZN3pci11printBussesEv+0x42f>
    c36d:	0f be c3             	movsx  eax,bl
    c370:	89 ef                	mov    edi,ebp
    c372:	8d 6f 01             	lea    ebp,[edi+0x1]
    c375:	3c 25                	cmp    al,0x25
    c377:	8d 0c 2e             	lea    ecx,[esi+ebp*1]
    c37a:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c37d:	74 d1                	je     c350 <_ZN3pci11printBussesEv+0x3f0>
    c37f:	83 ec 0c             	sub    esp,0xc
    c382:	50                   	push   eax
    c383:	e8 28 f8 ff ff       	call   bbb0 <_Z7putcharc>
    c388:	83 c4 10             	add    esp,0x10
    c38b:	84 db                	test   bl,bl
    c38d:	75 de                	jne    c36d <_ZN3pci11printBussesEv+0x40d>
    c38f:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    c393:	e9 c8 fc ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c398:	90                   	nop
    c399:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c3a0:	83 ec 0c             	sub    esp,0xc
    c3a3:	8d 5f 02             	lea    ebx,[edi+0x2]
    c3a6:	6a 25                	push   0x25
    c3a8:	e8 03 f8 ff ff       	call   bbb0 <_Z7putcharc>
    c3ad:	0f b6 83 90 e3 00 00 	movzx  eax,BYTE PTR [ebx+0xe390]
    c3b4:	83 c4 10             	add    esp,0x10
    c3b7:	84 c0                	test   al,al
    c3b9:	0f 85 67 fc ff ff    	jne    c026 <_ZN3pci11printBussesEv+0xc6>
    c3bf:	e9 9c fc ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c3c4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c3c8:	83 ec 0c             	sub    esp,0xc
    c3cb:	8d 5d 02             	lea    ebx,[ebp+0x2]
    c3ce:	6a 25                	push   0x25
    c3d0:	e8 db f7 ff ff       	call   bbb0 <_Z7putcharc>
    c3d5:	0f b6 83 d4 e3 00 00 	movzx  eax,BYTE PTR [ebx+0xe3d4]
    c3dc:	83 c4 10             	add    esp,0x10
    c3df:	84 c0                	test   al,al
    c3e1:	0f 85 f7 fc ff ff    	jne    c0de <_ZN3pci11printBussesEv+0x17e>
    c3e7:	83 c6 01             	add    esi,0x1
    c3ea:	83 fe 20             	cmp    esi,0x20
    c3ed:	0f 85 95 fb ff ff    	jne    bf88 <_ZN3pci11printBussesEv+0x28>
    c3f3:	e9 2c fd ff ff       	jmp    c124 <_ZN3pci11printBussesEv+0x1c4>
    c3f8:	90                   	nop
    c3f9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c400:	83 ec 08             	sub    esp,0x8
    c403:	89 f5                	mov    ebp,esi
    c405:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    c409:	8d 44 24 3b          	lea    eax,[esp+0x3b]
    c40d:	89 fb                	mov    ebx,edi
    c40f:	50                   	push   eax
    c410:	51                   	push   ecx
    c411:	e8 8a 0d 00 00       	call   d1a0 <_Z14_manage_escapeIhEiPKcPT_>
    c416:	01 c3                	add    ebx,eax
    c418:	83 c4 10             	add    esp,0x10
    c41b:	01 eb                	add    ebx,ebp
    c41d:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    c420:	84 d2                	test   dl,dl
    c422:	0f 84 f0 fc ff ff    	je     c118 <_ZN3pci11printBussesEv+0x1b8>
    c428:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    c42c:	31 ed                	xor    ebp,ebp
    c42e:	89 de                	mov    esi,ebx
    c430:	eb 2c                	jmp    c45e <_ZN3pci11printBussesEv+0x4fe>
    c432:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c438:	80 fb 25             	cmp    bl,0x25
    c43b:	0f 84 bf 03 00 00    	je     c800 <_ZN3pci11printBussesEv+0x8a0>
    c441:	84 db                	test   bl,bl
    c443:	0f 85 37 01 00 00    	jne    c580 <_ZN3pci11printBussesEv+0x620>
    c449:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c44e:	8d 7d 02             	lea    edi,[ebp+0x2]
    c451:	84 db                	test   bl,bl
    c453:	0f 84 7e fd ff ff    	je     c1d7 <_ZN3pci11printBussesEv+0x277>
    c459:	0f be d3             	movsx  edx,bl
    c45c:	89 fd                	mov    ebp,edi
    c45e:	8d 7d 01             	lea    edi,[ebp+0x1]
    c461:	80 fa 25             	cmp    dl,0x25
    c464:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c467:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c46a:	74 cc                	je     c438 <_ZN3pci11printBussesEv+0x4d8>
    c46c:	83 ec 0c             	sub    esp,0xc
    c46f:	52                   	push   edx
    c470:	e8 3b f7 ff ff       	call   bbb0 <_Z7putcharc>
    c475:	83 c4 10             	add    esp,0x10
    c478:	84 db                	test   bl,bl
    c47a:	75 dd                	jne    c459 <_ZN3pci11printBussesEv+0x4f9>
    c47c:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c480:	e9 56 fd ff ff       	jmp    c1db <_ZN3pci11printBussesEv+0x27b>
    c485:	8d 76 00             	lea    esi,[esi+0x0]
    c488:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    c48c:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    c490:	83 ec 08             	sub    esp,0x8
    c493:	8d 44 24 39          	lea    eax,[esp+0x39]
    c497:	50                   	push   eax
    c498:	51                   	push   ecx
    c499:	e8 02 0d 00 00       	call   d1a0 <_Z14_manage_escapeIhEiPKcPT_>
    c49e:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    c4a2:	01 c5                	add    ebp,eax
    c4a4:	0f b6 44 24 28       	movzx  eax,BYTE PTR [esp+0x28]
    c4a9:	01 d5                	add    ebp,edx
    c4ab:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    c4af:	88 44 24 42          	mov    BYTE PTR [esp+0x42],al
    c4b3:	83 c4 10             	add    esp,0x10
    c4b6:	84 d2                	test   dl,dl
    c4b8:	0f 84 a2 fb ff ff    	je     c060 <_ZN3pci11printBussesEv+0x100>
    c4be:	31 ff                	xor    edi,edi
    c4c0:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    c4c4:	89 ee                	mov    esi,ebp
    c4c6:	89 fd                	mov    ebp,edi
    c4c8:	eb 28                	jmp    c4f2 <_ZN3pci11printBussesEv+0x592>
    c4ca:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c4d0:	80 fb 25             	cmp    bl,0x25
    c4d3:	0f 84 f7 02 00 00    	je     c7d0 <_ZN3pci11printBussesEv+0x870>
    c4d9:	84 db                	test   bl,bl
    c4db:	0f 85 7f 01 00 00    	jne    c660 <_ZN3pci11printBussesEv+0x700>
    c4e1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c4e6:	8d 7d 02             	lea    edi,[ebp+0x2]
    c4e9:	84 db                	test   bl,bl
    c4eb:	74 23                	je     c510 <_ZN3pci11printBussesEv+0x5b0>
    c4ed:	0f be d3             	movsx  edx,bl
    c4f0:	89 fd                	mov    ebp,edi
    c4f2:	8d 7d 01             	lea    edi,[ebp+0x1]
    c4f5:	80 fa 25             	cmp    dl,0x25
    c4f8:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c4fb:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c4fe:	74 d0                	je     c4d0 <_ZN3pci11printBussesEv+0x570>
    c500:	83 ec 0c             	sub    esp,0xc
    c503:	52                   	push   edx
    c504:	e8 a7 f6 ff ff       	call   bbb0 <_Z7putcharc>
    c509:	83 c4 10             	add    esp,0x10
    c50c:	84 db                	test   bl,bl
    c50e:	75 dd                	jne    c4ed <_ZN3pci11printBussesEv+0x58d>
    c510:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c514:	e9 47 fb ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c519:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c520:	83 ec 0c             	sub    esp,0xc
    c523:	8d 7d 02             	lea    edi,[ebp+0x2]
    c526:	6a 25                	push   0x25
    c528:	e8 83 f6 ff ff       	call   bbb0 <_Z7putcharc>
    c52d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c532:	83 c4 10             	add    esp,0x10
    c535:	84 db                	test   bl,bl
    c537:	0f 85 78 fc ff ff    	jne    c1b5 <_ZN3pci11printBussesEv+0x255>
    c53d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c541:	e9 95 fc ff ff       	jmp    c1db <_ZN3pci11printBussesEv+0x27b>
    c546:	8d 76 00             	lea    esi,[esi+0x0]
    c549:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c550:	83 ec 0c             	sub    esp,0xc
    c553:	8d 7d 02             	lea    edi,[ebp+0x2]
    c556:	6a 25                	push   0x25
    c558:	e8 53 f6 ff ff       	call   bbb0 <_Z7putcharc>
    c55d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c562:	83 c4 10             	add    esp,0x10
    c565:	84 db                	test   bl,bl
    c567:	0f 85 e0 fc ff ff    	jne    c24d <_ZN3pci11printBussesEv+0x2ed>
    c56d:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c571:	e9 ea fa ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c576:	8d 76 00             	lea    esi,[esi+0x0]
    c579:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c580:	89 d8                	mov    eax,ebx
    c582:	89 f3                	mov    ebx,esi
    c584:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c588:	83 e8 42             	sub    eax,0x42
    c58b:	3c 36                	cmp    al,0x36
    c58d:	77 21                	ja     c5b0 <_ZN3pci11printBussesEv+0x650>
    c58f:	0f b6 c0             	movzx  eax,al
    c592:	ff 24 85 f8 e0 00 00 	jmp    DWORD PTR [eax*4+0xe0f8]
    c599:	83 ec 0c             	sub    esp,0xc
    c59c:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    c5a0:	e8 6b f6 ff ff       	call   bc10 <_Z6putstrPc>
    c5a5:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    c5a9:	83 c4 10             	add    esp,0x10
    c5ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c5b0:	83 ec 0c             	sub    esp,0xc
    c5b3:	83 c6 01             	add    esi,0x1
    c5b6:	51                   	push   ecx
    c5b7:	e8 74 f6 ff ff       	call   bc30 <_Z6printfPKc>
    c5bc:	83 c4 10             	add    esp,0x10
    c5bf:	83 fe 20             	cmp    esi,0x20
    c5c2:	0f 85 c0 f9 ff ff    	jne    bf88 <_ZN3pci11printBussesEv+0x28>
    c5c8:	e9 57 fb ff ff       	jmp    c124 <_ZN3pci11printBussesEv+0x1c4>
    c5cd:	83 ec 0c             	sub    esp,0xc
    c5d0:	0f be 44 24 24       	movsx  eax,BYTE PTR [esp+0x24]
    c5d5:	50                   	push   eax
    c5d6:	e8 d5 f5 ff ff       	call   bbb0 <_Z7putcharc>
    c5db:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    c5df:	83 c4 10             	add    esp,0x10
    c5e2:	eb cc                	jmp    c5b0 <_ZN3pci11printBussesEv+0x650>
    c5e4:	83 ec 0c             	sub    esp,0xc
    c5e7:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    c5eb:	e8 f0 f5 ff ff       	call   bbe0 <_Z6puthexi>
    c5f0:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    c5f4:	83 c4 10             	add    esp,0x10
    c5f7:	eb b7                	jmp    c5b0 <_ZN3pci11printBussesEv+0x650>
    c5f9:	83 ec 0c             	sub    esp,0xc
    c5fc:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    c600:	e8 eb f5 ff ff       	call   bbf0 <_Z6putocti>
    c605:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    c609:	83 c4 10             	add    esp,0x10
    c60c:	eb a2                	jmp    c5b0 <_ZN3pci11printBussesEv+0x650>
    c60e:	83 ec 0c             	sub    esp,0xc
    c611:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    c615:	e8 e6 f5 ff ff       	call   bc00 <_Z6putbini>
    c61a:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    c61e:	83 c4 10             	add    esp,0x10
    c621:	eb 8d                	jmp    c5b0 <_ZN3pci11printBussesEv+0x650>
    c623:	83 ec 0c             	sub    esp,0xc
    c626:	68 b4 01 01 00       	push   0x101b4
    c62b:	e8 00 f6 ff ff       	call   bc30 <_Z6printfPKc>
    c630:	58                   	pop    eax
    c631:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    c635:	e8 a6 f5 ff ff       	call   bbe0 <_Z6puthexi>
    c63a:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    c63e:	83 c4 10             	add    esp,0x10
    c641:	e9 6a ff ff ff       	jmp    c5b0 <_ZN3pci11printBussesEv+0x650>
    c646:	83 ec 0c             	sub    esp,0xc
    c649:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    c64d:	e8 7e f5 ff ff       	call   bbd0 <_Z6putdeci>
    c652:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    c656:	83 c4 10             	add    esp,0x10
    c659:	e9 52 ff ff ff       	jmp    c5b0 <_ZN3pci11printBussesEv+0x650>
    c65e:	66 90                	xchg   ax,ax
    c660:	83 ec 08             	sub    esp,0x8
    c663:	89 f5                	mov    ebp,esi
    c665:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    c669:	8d 44 24 3a          	lea    eax,[esp+0x3a]
    c66d:	89 fb                	mov    ebx,edi
    c66f:	50                   	push   eax
    c670:	51                   	push   ecx
    c671:	e8 2a 0b 00 00       	call   d1a0 <_Z14_manage_escapeIhEiPKcPT_>
    c676:	01 c3                	add    ebx,eax
    c678:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    c67c:	01 eb                	add    ebx,ebp
    c67e:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    c681:	89 44 24 48          	mov    DWORD PTR [esp+0x48],eax
    c685:	83 c4 10             	add    esp,0x10
    c688:	84 d2                	test   dl,dl
    c68a:	0f 84 d0 f9 ff ff    	je     c060 <_ZN3pci11printBussesEv+0x100>
    c690:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    c694:	31 ed                	xor    ebp,ebp
    c696:	89 de                	mov    esi,ebx
    c698:	eb 2c                	jmp    c6c6 <_ZN3pci11printBussesEv+0x766>
    c69a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c6a0:	80 fb 25             	cmp    bl,0x25
    c6a3:	0f 84 af 01 00 00    	je     c858 <_ZN3pci11printBussesEv+0x8f8>
    c6a9:	84 db                	test   bl,bl
    c6ab:	0f 85 9f 00 00 00    	jne    c750 <_ZN3pci11printBussesEv+0x7f0>
    c6b1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c6b6:	8d 7d 02             	lea    edi,[ebp+0x2]
    c6b9:	84 db                	test   bl,bl
    c6bb:	0f 84 4f fe ff ff    	je     c510 <_ZN3pci11printBussesEv+0x5b0>
    c6c1:	0f be d3             	movsx  edx,bl
    c6c4:	89 fd                	mov    ebp,edi
    c6c6:	8d 7d 01             	lea    edi,[ebp+0x1]
    c6c9:	80 fa 25             	cmp    dl,0x25
    c6cc:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c6cf:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c6d2:	74 cc                	je     c6a0 <_ZN3pci11printBussesEv+0x740>
    c6d4:	83 ec 0c             	sub    esp,0xc
    c6d7:	52                   	push   edx
    c6d8:	e8 d3 f4 ff ff       	call   bbb0 <_Z7putcharc>
    c6dd:	83 c4 10             	add    esp,0x10
    c6e0:	84 db                	test   bl,bl
    c6e2:	75 dd                	jne    c6c1 <_ZN3pci11printBussesEv+0x761>
    c6e4:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c6e8:	e9 73 f9 ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c6ed:	8d 76 00             	lea    esi,[esi+0x0]
    c6f0:	83 ec 0c             	sub    esp,0xc
    c6f3:	8d 6f 02             	lea    ebp,[edi+0x2]
    c6f6:	6a 25                	push   0x25
    c6f8:	e8 b3 f4 ff ff       	call   bbb0 <_Z7putcharc>
    c6fd:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    c702:	83 c4 10             	add    esp,0x10
    c705:	84 db                	test   bl,bl
    c707:	0f 85 60 fc ff ff    	jne    c36d <_ZN3pci11printBussesEv+0x40d>
    c70d:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    c711:	e9 4a f9 ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c716:	8d 76 00             	lea    esi,[esi+0x0]
    c719:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c720:	83 ec 0c             	sub    esp,0xc
    c723:	8d 7d 02             	lea    edi,[ebp+0x2]
    c726:	6a 25                	push   0x25
    c728:	e8 83 f4 ff ff       	call   bbb0 <_Z7putcharc>
    c72d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c732:	83 c4 10             	add    esp,0x10
    c735:	84 db                	test   bl,bl
    c737:	0f 85 a4 fb ff ff    	jne    c2e1 <_ZN3pci11printBussesEv+0x381>
    c73d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c741:	e9 95 fa ff ff       	jmp    c1db <_ZN3pci11printBussesEv+0x27b>
    c746:	8d 76 00             	lea    esi,[esi+0x0]
    c749:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c750:	83 ec 08             	sub    esp,0x8
    c753:	89 f3                	mov    ebx,esi
    c755:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    c759:	8d 44 24 40          	lea    eax,[esp+0x40]
    c75d:	50                   	push   eax
    c75e:	51                   	push   ecx
    c75f:	e8 bc 10 00 00       	call   d820 <_Z14_manage_escapeIiEiPKcPT_>
    c764:	01 c7                	add    edi,eax
    c766:	89 74 24 4c          	mov    DWORD PTR [esp+0x4c],esi
    c76a:	83 c4 10             	add    esp,0x10
    c76d:	01 df                	add    edi,ebx
    c76f:	0f be 07             	movsx  eax,BYTE PTR [edi]
    c772:	84 c0                	test   al,al
    c774:	0f 84 e6 f8 ff ff    	je     c060 <_ZN3pci11printBussesEv+0x100>
    c77a:	31 d2                	xor    edx,edx
    c77c:	eb 28                	jmp    c7a6 <_ZN3pci11printBussesEv+0x846>
    c77e:	66 90                	xchg   ax,ax
    c780:	80 fb 25             	cmp    bl,0x25
    c783:	0f 84 f7 00 00 00    	je     c880 <_ZN3pci11printBussesEv+0x920>
    c789:	84 db                	test   bl,bl
    c78b:	0f 85 9f 00 00 00    	jne    c830 <_ZN3pci11printBussesEv+0x8d0>
    c791:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    c796:	8d 6a 02             	lea    ebp,[edx+0x2]
    c799:	84 db                	test   bl,bl
    c79b:	0f 84 bf f8 ff ff    	je     c060 <_ZN3pci11printBussesEv+0x100>
    c7a1:	0f be c3             	movsx  eax,bl
    c7a4:	89 ea                	mov    edx,ebp
    c7a6:	8d 6a 01             	lea    ebp,[edx+0x1]
    c7a9:	3c 25                	cmp    al,0x25
    c7ab:	8d 0c 2f             	lea    ecx,[edi+ebp*1]
    c7ae:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c7b1:	74 cd                	je     c780 <_ZN3pci11printBussesEv+0x820>
    c7b3:	83 ec 0c             	sub    esp,0xc
    c7b6:	50                   	push   eax
    c7b7:	e8 f4 f3 ff ff       	call   bbb0 <_Z7putcharc>
    c7bc:	83 c4 10             	add    esp,0x10
    c7bf:	84 db                	test   bl,bl
    c7c1:	75 de                	jne    c7a1 <_ZN3pci11printBussesEv+0x841>
    c7c3:	e9 98 f8 ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c7c8:	90                   	nop
    c7c9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c7d0:	83 ec 0c             	sub    esp,0xc
    c7d3:	8d 7d 02             	lea    edi,[ebp+0x2]
    c7d6:	6a 25                	push   0x25
    c7d8:	e8 d3 f3 ff ff       	call   bbb0 <_Z7putcharc>
    c7dd:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c7e2:	83 c4 10             	add    esp,0x10
    c7e5:	84 db                	test   bl,bl
    c7e7:	0f 85 00 fd ff ff    	jne    c4ed <_ZN3pci11printBussesEv+0x58d>
    c7ed:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c7f1:	e9 6a f8 ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c7f6:	8d 76 00             	lea    esi,[esi+0x0]
    c7f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c800:	83 ec 0c             	sub    esp,0xc
    c803:	8d 7d 02             	lea    edi,[ebp+0x2]
    c806:	6a 25                	push   0x25
    c808:	e8 a3 f3 ff ff       	call   bbb0 <_Z7putcharc>
    c80d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c812:	83 c4 10             	add    esp,0x10
    c815:	84 db                	test   bl,bl
    c817:	0f 85 3c fc ff ff    	jne    c459 <_ZN3pci11printBussesEv+0x4f9>
    c81d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c821:	e9 b5 f9 ff ff       	jmp    c1db <_ZN3pci11printBussesEv+0x27b>
    c826:	8d 76 00             	lea    esi,[esi+0x0]
    c829:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c830:	83 ec 08             	sub    esp,0x8
    c833:	8d 44 24 44          	lea    eax,[esp+0x44]
    c837:	50                   	push   eax
    c838:	51                   	push   ecx
    c839:	e8 e2 0f 00 00       	call   d820 <_Z14_manage_escapeIiEiPKcPT_>
    c83e:	8d 1c 28             	lea    ebx,[eax+ebp*1]
    c841:	01 fb                	add    ebx,edi
    c843:	89 1c 24             	mov    DWORD PTR [esp],ebx
    c846:	e8 e5 f3 ff ff       	call   bc30 <_Z6printfPKc>
    c84b:	83 c4 10             	add    esp,0x10
    c84e:	e9 0d f8 ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c853:	90                   	nop
    c854:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c858:	83 ec 0c             	sub    esp,0xc
    c85b:	8d 7d 02             	lea    edi,[ebp+0x2]
    c85e:	6a 25                	push   0x25
    c860:	e8 4b f3 ff ff       	call   bbb0 <_Z7putcharc>
    c865:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c86a:	83 c4 10             	add    esp,0x10
    c86d:	84 db                	test   bl,bl
    c86f:	0f 85 4c fe ff ff    	jne    c6c1 <_ZN3pci11printBussesEv+0x761>
    c875:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    c879:	e9 e2 f7 ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>
    c87e:	66 90                	xchg   ax,ax
    c880:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    c884:	83 ec 0c             	sub    esp,0xc
    c887:	6a 25                	push   0x25
    c889:	e8 22 f3 ff ff       	call   bbb0 <_Z7putcharc>
    c88e:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    c892:	83 c4 10             	add    esp,0x10
    c895:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    c89a:	8d 6a 02             	lea    ebp,[edx+0x2]
    c89d:	84 db                	test   bl,bl
    c89f:	0f 85 fc fe ff ff    	jne    c7a1 <_ZN3pci11printBussesEv+0x841>
    c8a5:	e9 b6 f7 ff ff       	jmp    c060 <_ZN3pci11printBussesEv+0x100>

Disassembly of section .text._Z6printfIiEvPKcT_:

0000c8b0 <_Z6printfIiEvPKcT_>:
    c8b0:	55                   	push   ebp
    c8b1:	57                   	push   edi
    c8b2:	31 ff                	xor    edi,edi
    c8b4:	56                   	push   esi
    c8b5:	53                   	push   ebx
    c8b6:	83 ec 1c             	sub    esp,0x1c
    c8b9:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    c8bd:	8b 74 24 30          	mov    esi,DWORD PTR [esp+0x30]
    c8c1:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    c8c5:	0f be 06             	movsx  eax,BYTE PTR [esi]
    c8c8:	84 c0                	test   al,al
    c8ca:	74 4c                	je     c918 <_Z6printfIiEvPKcT_+0x68>
    c8cc:	8d 5f 01             	lea    ebx,[edi+0x1]
    c8cf:	3c 25                	cmp    al,0x25
    c8d1:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    c8d4:	75 2e                	jne    c904 <_Z6printfIiEvPKcT_+0x54>
    c8d6:	8d 76 00             	lea    esi,[esi+0x0]
    c8d9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c8e0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    c8e4:	3c 25                	cmp    al,0x25
    c8e6:	74 78                	je     c960 <_Z6printfIiEvPKcT_+0xb0>
    c8e8:	84 c0                	test   al,al
    c8ea:	75 34                	jne    c920 <_Z6printfIiEvPKcT_+0x70>
    c8ec:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    c8f1:	8d 5f 02             	lea    ebx,[edi+0x2]
    c8f4:	84 c0                	test   al,al
    c8f6:	74 20                	je     c918 <_Z6printfIiEvPKcT_+0x68>
    c8f8:	89 df                	mov    edi,ebx
    c8fa:	8d 5f 01             	lea    ebx,[edi+0x1]
    c8fd:	3c 25                	cmp    al,0x25
    c8ff:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    c902:	74 dc                	je     c8e0 <_Z6printfIiEvPKcT_+0x30>
    c904:	83 ec 0c             	sub    esp,0xc
    c907:	50                   	push   eax
    c908:	e8 a3 f2 ff ff       	call   bbb0 <_Z7putcharc>
    c90d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c911:	83 c4 10             	add    esp,0x10
    c914:	84 c0                	test   al,al
    c916:	75 e0                	jne    c8f8 <_Z6printfIiEvPKcT_+0x48>
    c918:	83 c4 1c             	add    esp,0x1c
    c91b:	5b                   	pop    ebx
    c91c:	5e                   	pop    esi
    c91d:	5f                   	pop    edi
    c91e:	5d                   	pop    ebp
    c91f:	c3                   	ret    
    c920:	83 e8 42             	sub    eax,0x42
    c923:	3c 36                	cmp    al,0x36
    c925:	77 26                	ja     c94d <_Z6printfIiEvPKcT_+0x9d>
    c927:	0f b6 c0             	movzx  eax,al
    c92a:	ff 24 85 88 fc 00 00 	jmp    DWORD PTR [eax*4+0xfc88]
    c931:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c938:	83 ec 0c             	sub    esp,0xc
    c93b:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    c93f:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    c944:	50                   	push   eax
    c945:	e8 66 f2 ff ff       	call   bbb0 <_Z7putcharc>
    c94a:	83 c4 10             	add    esp,0x10
    c94d:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    c951:	83 c4 1c             	add    esp,0x1c
    c954:	5b                   	pop    ebx
    c955:	5e                   	pop    esi
    c956:	5f                   	pop    edi
    c957:	5d                   	pop    ebp
    c958:	e9 d3 f2 ff ff       	jmp    bc30 <_Z6printfPKc>
    c95d:	8d 76 00             	lea    esi,[esi+0x0]
    c960:	83 ec 0c             	sub    esp,0xc
    c963:	8d 5f 02             	lea    ebx,[edi+0x2]
    c966:	6a 25                	push   0x25
    c968:	e8 43 f2 ff ff       	call   bbb0 <_Z7putcharc>
    c96d:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    c972:	83 c4 10             	add    esp,0x10
    c975:	84 c0                	test   al,al
    c977:	74 9f                	je     c918 <_Z6printfIiEvPKcT_+0x68>
    c979:	89 df                	mov    edi,ebx
    c97b:	e9 7a ff ff ff       	jmp    c8fa <_Z6printfIiEvPKcT_+0x4a>
    c980:	83 ec 0c             	sub    esp,0xc
    c983:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    c987:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    c98b:	e8 80 f2 ff ff       	call   bc10 <_Z6putstrPc>
    c990:	83 c4 10             	add    esp,0x10
    c993:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    c997:	83 c4 1c             	add    esp,0x1c
    c99a:	5b                   	pop    ebx
    c99b:	5e                   	pop    esi
    c99c:	5f                   	pop    edi
    c99d:	5d                   	pop    ebp
    c99e:	e9 8d f2 ff ff       	jmp    bc30 <_Z6printfPKc>
    c9a3:	90                   	nop
    c9a4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c9a8:	83 ec 0c             	sub    esp,0xc
    c9ab:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    c9af:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    c9b3:	e8 48 f2 ff ff       	call   bc00 <_Z6putbini>
    c9b8:	83 c4 10             	add    esp,0x10
    c9bb:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    c9bf:	83 c4 1c             	add    esp,0x1c
    c9c2:	5b                   	pop    ebx
    c9c3:	5e                   	pop    esi
    c9c4:	5f                   	pop    edi
    c9c5:	5d                   	pop    ebp
    c9c6:	e9 65 f2 ff ff       	jmp    bc30 <_Z6printfPKc>
    c9cb:	90                   	nop
    c9cc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c9d0:	83 ec 0c             	sub    esp,0xc
    c9d3:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    c9d7:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    c9db:	e8 10 f2 ff ff       	call   bbf0 <_Z6putocti>
    c9e0:	83 c4 10             	add    esp,0x10
    c9e3:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    c9e7:	83 c4 1c             	add    esp,0x1c
    c9ea:	5b                   	pop    ebx
    c9eb:	5e                   	pop    esi
    c9ec:	5f                   	pop    edi
    c9ed:	5d                   	pop    ebp
    c9ee:	e9 3d f2 ff ff       	jmp    bc30 <_Z6printfPKc>
    c9f3:	90                   	nop
    c9f4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c9f8:	83 ec 0c             	sub    esp,0xc
    c9fb:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    c9ff:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    ca03:	e8 d8 f1 ff ff       	call   bbe0 <_Z6puthexi>
    ca08:	83 c4 10             	add    esp,0x10
    ca0b:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    ca0f:	83 c4 1c             	add    esp,0x1c
    ca12:	5b                   	pop    ebx
    ca13:	5e                   	pop    esi
    ca14:	5f                   	pop    edi
    ca15:	5d                   	pop    ebp
    ca16:	e9 15 f2 ff ff       	jmp    bc30 <_Z6printfPKc>
    ca1b:	90                   	nop
    ca1c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ca20:	83 ec 0c             	sub    esp,0xc
    ca23:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    ca27:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    ca2b:	e8 a0 f1 ff ff       	call   bbd0 <_Z6putdeci>
    ca30:	83 c4 10             	add    esp,0x10
    ca33:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    ca37:	83 c4 1c             	add    esp,0x1c
    ca3a:	5b                   	pop    ebx
    ca3b:	5e                   	pop    esi
    ca3c:	5f                   	pop    edi
    ca3d:	5d                   	pop    ebp
    ca3e:	e9 ed f1 ff ff       	jmp    bc30 <_Z6printfPKc>
    ca43:	90                   	nop
    ca44:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ca48:	83 ec 0c             	sub    esp,0xc
    ca4b:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    ca4f:	68 84 fc 00 00       	push   0xfc84
    ca54:	e8 d7 f1 ff ff       	call   bc30 <_Z6printfPKc>
    ca59:	58                   	pop    eax
    ca5a:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    ca5e:	e8 7d f1 ff ff       	call   bbe0 <_Z6puthexi>
    ca63:	83 c4 10             	add    esp,0x10
    ca66:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    ca6a:	83 c4 1c             	add    esp,0x1c
    ca6d:	5b                   	pop    ebx
    ca6e:	5e                   	pop    esi
    ca6f:	5f                   	pop    edi
    ca70:	5d                   	pop    ebp
    ca71:	e9 ba f1 ff ff       	jmp    bc30 <_Z6printfPKc>

Disassembly of section .text._Z6printfIcEvPKcT_:

0000ca80 <_Z6printfIcEvPKcT_>:
    ca80:	55                   	push   ebp
    ca81:	57                   	push   edi
    ca82:	56                   	push   esi
    ca83:	53                   	push   ebx
    ca84:	31 f6                	xor    esi,esi
    ca86:	83 ec 1c             	sub    esp,0x1c
    ca89:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    ca8d:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    ca91:	88 44 24 0c          	mov    BYTE PTR [esp+0xc],al
    ca95:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    ca99:	84 c0                	test   al,al
    ca9b:	74 4e                	je     caeb <_Z6printfIcEvPKcT_+0x6b>
    ca9d:	8d 5e 01             	lea    ebx,[esi+0x1]
    caa0:	3c 25                	cmp    al,0x25
    caa2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    caa6:	75 30                	jne    cad8 <_Z6printfIcEvPKcT_+0x58>
    caa8:	90                   	nop
    caa9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    cab0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    cab3:	3c 25                	cmp    al,0x25
    cab5:	0f 84 85 00 00 00    	je     cb40 <_Z6printfIcEvPKcT_+0xc0>
    cabb:	84 c0                	test   al,al
    cabd:	75 39                	jne    caf8 <_Z6printfIcEvPKcT_+0x78>
    cabf:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    cac4:	8d 5e 02             	lea    ebx,[esi+0x2]
    cac7:	84 c0                	test   al,al
    cac9:	74 20                	je     caeb <_Z6printfIcEvPKcT_+0x6b>
    cacb:	89 de                	mov    esi,ebx
    cacd:	8d 5e 01             	lea    ebx,[esi+0x1]
    cad0:	3c 25                	cmp    al,0x25
    cad2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    cad6:	74 d8                	je     cab0 <_Z6printfIcEvPKcT_+0x30>
    cad8:	83 ec 0c             	sub    esp,0xc
    cadb:	50                   	push   eax
    cadc:	e8 cf f0 ff ff       	call   bbb0 <_Z7putcharc>
    cae1:	0f be 07             	movsx  eax,BYTE PTR [edi]
    cae4:	83 c4 10             	add    esp,0x10
    cae7:	84 c0                	test   al,al
    cae9:	75 e0                	jne    cacb <_Z6printfIcEvPKcT_+0x4b>
    caeb:	83 c4 1c             	add    esp,0x1c
    caee:	5b                   	pop    ebx
    caef:	5e                   	pop    esi
    caf0:	5f                   	pop    edi
    caf1:	5d                   	pop    ebp
    caf2:	c3                   	ret    
    caf3:	90                   	nop
    caf4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    caf8:	83 e8 42             	sub    eax,0x42
    cafb:	3c 36                	cmp    al,0x36
    cafd:	77 26                	ja     cb25 <_Z6printfIcEvPKcT_+0xa5>
    caff:	0f b6 c0             	movzx  eax,al
    cb02:	ff 24 85 64 fd 00 00 	jmp    DWORD PTR [eax*4+0xfd64]
    cb09:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    cb10:	83 ec 0c             	sub    esp,0xc
    cb13:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    cb17:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    cb1c:	50                   	push   eax
    cb1d:	e8 8e f0 ff ff       	call   bbb0 <_Z7putcharc>
    cb22:	83 c4 10             	add    esp,0x10
    cb25:	83 ec 0c             	sub    esp,0xc
    cb28:	57                   	push   edi
    cb29:	e8 02 f1 ff ff       	call   bc30 <_Z6printfPKc>
    cb2e:	83 c4 10             	add    esp,0x10
    cb31:	83 c4 1c             	add    esp,0x1c
    cb34:	5b                   	pop    ebx
    cb35:	5e                   	pop    esi
    cb36:	5f                   	pop    edi
    cb37:	5d                   	pop    ebp
    cb38:	c3                   	ret    
    cb39:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    cb40:	83 ec 0c             	sub    esp,0xc
    cb43:	8d 5e 02             	lea    ebx,[esi+0x2]
    cb46:	6a 25                	push   0x25
    cb48:	e8 63 f0 ff ff       	call   bbb0 <_Z7putcharc>
    cb4d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    cb52:	83 c4 10             	add    esp,0x10
    cb55:	84 c0                	test   al,al
    cb57:	74 92                	je     caeb <_Z6printfIcEvPKcT_+0x6b>
    cb59:	89 de                	mov    esi,ebx
    cb5b:	e9 6d ff ff ff       	jmp    cacd <_Z6printfIcEvPKcT_+0x4d>
    cb60:	83 ec 0c             	sub    esp,0xc
    cb63:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    cb67:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    cb6b:	e8 a0 f0 ff ff       	call   bc10 <_Z6putstrPc>
    cb70:	83 c4 10             	add    esp,0x10
    cb73:	83 ec 0c             	sub    esp,0xc
    cb76:	57                   	push   edi
    cb77:	e8 b4 f0 ff ff       	call   bc30 <_Z6printfPKc>
    cb7c:	83 c4 10             	add    esp,0x10
    cb7f:	eb b0                	jmp    cb31 <_Z6printfIcEvPKcT_+0xb1>
    cb81:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    cb88:	83 ec 0c             	sub    esp,0xc
    cb8b:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    cb8f:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    cb94:	50                   	push   eax
    cb95:	e8 66 f0 ff ff       	call   bc00 <_Z6putbini>
    cb9a:	83 c4 10             	add    esp,0x10
    cb9d:	83 ec 0c             	sub    esp,0xc
    cba0:	57                   	push   edi
    cba1:	e8 8a f0 ff ff       	call   bc30 <_Z6printfPKc>
    cba6:	83 c4 10             	add    esp,0x10
    cba9:	eb 86                	jmp    cb31 <_Z6printfIcEvPKcT_+0xb1>
    cbab:	90                   	nop
    cbac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    cbb0:	83 ec 0c             	sub    esp,0xc
    cbb3:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    cbb7:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    cbbc:	50                   	push   eax
    cbbd:	e8 2e f0 ff ff       	call   bbf0 <_Z6putocti>
    cbc2:	83 c4 10             	add    esp,0x10
    cbc5:	83 ec 0c             	sub    esp,0xc
    cbc8:	57                   	push   edi
    cbc9:	e8 62 f0 ff ff       	call   bc30 <_Z6printfPKc>
    cbce:	83 c4 10             	add    esp,0x10
    cbd1:	e9 5b ff ff ff       	jmp    cb31 <_Z6printfIcEvPKcT_+0xb1>
    cbd6:	8d 76 00             	lea    esi,[esi+0x0]
    cbd9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    cbe0:	83 ec 0c             	sub    esp,0xc
    cbe3:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    cbe7:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    cbec:	50                   	push   eax
    cbed:	e8 ee ef ff ff       	call   bbe0 <_Z6puthexi>
    cbf2:	83 c4 10             	add    esp,0x10
    cbf5:	83 ec 0c             	sub    esp,0xc
    cbf8:	57                   	push   edi
    cbf9:	e8 32 f0 ff ff       	call   bc30 <_Z6printfPKc>
    cbfe:	83 c4 10             	add    esp,0x10
    cc01:	e9 2b ff ff ff       	jmp    cb31 <_Z6printfIcEvPKcT_+0xb1>
    cc06:	8d 76 00             	lea    esi,[esi+0x0]
    cc09:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    cc10:	83 ec 0c             	sub    esp,0xc
    cc13:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    cc17:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    cc1c:	50                   	push   eax
    cc1d:	e8 ae ef ff ff       	call   bbd0 <_Z6putdeci>
    cc22:	83 c4 10             	add    esp,0x10
    cc25:	83 ec 0c             	sub    esp,0xc
    cc28:	57                   	push   edi
    cc29:	e8 02 f0 ff ff       	call   bc30 <_Z6printfPKc>
    cc2e:	83 c4 10             	add    esp,0x10
    cc31:	e9 fb fe ff ff       	jmp    cb31 <_Z6printfIcEvPKcT_+0xb1>
    cc36:	8d 76 00             	lea    esi,[esi+0x0]
    cc39:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    cc40:	83 ec 0c             	sub    esp,0xc
    cc43:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    cc47:	68 84 fc 00 00       	push   0xfc84
    cc4c:	e8 df ef ff ff       	call   bc30 <_Z6printfPKc>
    cc51:	58                   	pop    eax
    cc52:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    cc56:	e8 85 ef ff ff       	call   bbe0 <_Z6puthexi>
    cc5b:	83 c4 10             	add    esp,0x10
    cc5e:	83 ec 0c             	sub    esp,0xc
    cc61:	57                   	push   edi
    cc62:	e8 c9 ef ff ff       	call   bc30 <_Z6printfPKc>
    cc67:	83 c4 10             	add    esp,0x10
    cc6a:	e9 c2 fe ff ff       	jmp    cb31 <_Z6printfIcEvPKcT_+0xb1>

Disassembly of section .text._Z14_manage_escapeItEiPKcPT_:

0000cc70 <_Z14_manage_escapeItEiPKcPT_>:
    cc70:	83 ec 0c             	sub    esp,0xc
    cc73:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    cc77:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    cc7a:	83 e8 42             	sub    eax,0x42
    cc7d:	3c 36                	cmp    al,0x36
    cc7f:	0f 87 f3 00 00 00    	ja     cd78 <_Z14_manage_escapeItEiPKcPT_+0x108>
    cc85:	0f b6 c0             	movzx  eax,al
    cc88:	ff 24 85 40 fe 00 00 	jmp    DWORD PTR [eax*4+0xfe40]
    cc8f:	90                   	nop
    cc90:	83 ec 0c             	sub    esp,0xc
    cc93:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cc97:	ff 30                	push   DWORD PTR [eax]
    cc99:	e8 72 ef ff ff       	call   bc10 <_Z6putstrPc>
    cc9e:	83 c4 10             	add    esp,0x10
    cca1:	b8 01 00 00 00       	mov    eax,0x1
    cca6:	83 c4 0c             	add    esp,0xc
    cca9:	c3                   	ret    
    ccaa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ccb0:	83 ec 0c             	sub    esp,0xc
    ccb3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    ccb7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    ccba:	50                   	push   eax
    ccbb:	e8 40 ef ff ff       	call   bc00 <_Z6putbini>
    ccc0:	83 c4 10             	add    esp,0x10
    ccc3:	b8 01 00 00 00       	mov    eax,0x1
    ccc8:	83 c4 0c             	add    esp,0xc
    cccb:	c3                   	ret    
    cccc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ccd0:	83 ec 0c             	sub    esp,0xc
    ccd3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    ccd7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    ccda:	50                   	push   eax
    ccdb:	e8 10 ef ff ff       	call   bbf0 <_Z6putocti>
    cce0:	83 c4 10             	add    esp,0x10
    cce3:	b8 01 00 00 00       	mov    eax,0x1
    cce8:	83 c4 0c             	add    esp,0xc
    cceb:	c3                   	ret    
    ccec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ccf0:	83 ec 0c             	sub    esp,0xc
    ccf3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    ccf7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    ccfa:	50                   	push   eax
    ccfb:	e8 e0 ee ff ff       	call   bbe0 <_Z6puthexi>
    cd00:	83 c4 10             	add    esp,0x10
    cd03:	b8 01 00 00 00       	mov    eax,0x1
    cd08:	83 c4 0c             	add    esp,0xc
    cd0b:	c3                   	ret    
    cd0c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    cd10:	83 ec 0c             	sub    esp,0xc
    cd13:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cd17:	0f be 00             	movsx  eax,BYTE PTR [eax]
    cd1a:	50                   	push   eax
    cd1b:	e8 90 ee ff ff       	call   bbb0 <_Z7putcharc>
    cd20:	83 c4 10             	add    esp,0x10
    cd23:	b8 01 00 00 00       	mov    eax,0x1
    cd28:	83 c4 0c             	add    esp,0xc
    cd2b:	c3                   	ret    
    cd2c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    cd30:	83 ec 0c             	sub    esp,0xc
    cd33:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cd37:	0f b7 00             	movzx  eax,WORD PTR [eax]
    cd3a:	50                   	push   eax
    cd3b:	e8 90 ee ff ff       	call   bbd0 <_Z6putdeci>
    cd40:	83 c4 10             	add    esp,0x10
    cd43:	b8 01 00 00 00       	mov    eax,0x1
    cd48:	83 c4 0c             	add    esp,0xc
    cd4b:	c3                   	ret    
    cd4c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    cd50:	83 ec 0c             	sub    esp,0xc
    cd53:	68 84 fc 00 00       	push   0xfc84
    cd58:	e8 d3 ee ff ff       	call   bc30 <_Z6printfPKc>
    cd5d:	58                   	pop    eax
    cd5e:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cd62:	ff 30                	push   DWORD PTR [eax]
    cd64:	e8 77 ee ff ff       	call   bbe0 <_Z6puthexi>
    cd69:	83 c4 10             	add    esp,0x10
    cd6c:	b8 01 00 00 00       	mov    eax,0x1
    cd71:	83 c4 0c             	add    esp,0xc
    cd74:	c3                   	ret    
    cd75:	8d 76 00             	lea    esi,[esi+0x0]
    cd78:	31 c0                	xor    eax,eax
    cd7a:	e9 27 ff ff ff       	jmp    cca6 <_Z14_manage_escapeItEiPKcPT_+0x36>

Disassembly of section .text._Z6printfItJttEEvPKcT_DpT0_:

0000cd80 <_Z6printfItJttEEvPKcT_DpT0_>:
    cd80:	55                   	push   ebp
    cd81:	57                   	push   edi
    cd82:	31 c9                	xor    ecx,ecx
    cd84:	56                   	push   esi
    cd85:	53                   	push   ebx
    cd86:	83 ec 2c             	sub    esp,0x2c
    cd89:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    cd8d:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    cd91:	8b 74 24 48          	mov    esi,DWORD PTR [esp+0x48]
    cd95:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    cd99:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    cd9d:	66 89 44 24 0c       	mov    WORD PTR [esp+0xc],ax
    cda2:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    cda6:	84 c0                	test   al,al
    cda8:	74 49                	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    cdaa:	8d 79 01             	lea    edi,[ecx+0x1]
    cdad:	3c 25                	cmp    al,0x25
    cdaf:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    cdb3:	75 2b                	jne    cde0 <_Z6printfItJttEEvPKcT_DpT0_+0x60>
    cdb5:	8d 76 00             	lea    esi,[esi+0x0]
    cdb8:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    cdbb:	3c 25                	cmp    al,0x25
    cdbd:	0f 84 3d 01 00 00    	je     cf00 <_Z6printfItJttEEvPKcT_DpT0_+0x180>
    cdc3:	84 c0                	test   al,al
    cdc5:	75 39                	jne    ce00 <_Z6printfItJttEEvPKcT_DpT0_+0x80>
    cdc7:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    cdcc:	8d 79 02             	lea    edi,[ecx+0x2]
    cdcf:	84 c0                	test   al,al
    cdd1:	74 20                	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    cdd3:	89 f9                	mov    ecx,edi
    cdd5:	8d 79 01             	lea    edi,[ecx+0x1]
    cdd8:	3c 25                	cmp    al,0x25
    cdda:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    cdde:	74 d8                	je     cdb8 <_Z6printfItJttEEvPKcT_DpT0_+0x38>
    cde0:	83 ec 0c             	sub    esp,0xc
    cde3:	50                   	push   eax
    cde4:	e8 c7 ed ff ff       	call   bbb0 <_Z7putcharc>
    cde9:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    cdec:	83 c4 10             	add    esp,0x10
    cdef:	84 c0                	test   al,al
    cdf1:	75 e0                	jne    cdd3 <_Z6printfItJttEEvPKcT_DpT0_+0x53>
    cdf3:	83 c4 2c             	add    esp,0x2c
    cdf6:	5b                   	pop    ebx
    cdf7:	5e                   	pop    esi
    cdf8:	5f                   	pop    edi
    cdf9:	5d                   	pop    ebp
    cdfa:	c3                   	ret    
    cdfb:	90                   	nop
    cdfc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ce00:	83 ec 08             	sub    esp,0x8
    ce03:	8d 44 24 14          	lea    eax,[esp+0x14]
    ce07:	50                   	push   eax
    ce08:	53                   	push   ebx
    ce09:	e8 62 fe ff ff       	call   cc70 <_Z14_manage_escapeItEiPKcPT_>
    ce0e:	01 c7                	add    edi,eax
    ce10:	66 89 74 24 2c       	mov    WORD PTR [esp+0x2c],si
    ce15:	83 c4 10             	add    esp,0x10
    ce18:	01 fd                	add    ebp,edi
    ce1a:	31 ff                	xor    edi,edi
    ce1c:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    ce20:	84 c0                	test   al,al
    ce22:	74 cf                	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    ce24:	8d 77 01             	lea    esi,[edi+0x1]
    ce27:	3c 25                	cmp    al,0x25
    ce29:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    ce2d:	75 29                	jne    ce58 <_Z6printfItJttEEvPKcT_DpT0_+0xd8>
    ce2f:	90                   	nop
    ce30:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    ce33:	3c 25                	cmp    al,0x25
    ce35:	0f 84 1d 01 00 00    	je     cf58 <_Z6printfItJttEEvPKcT_DpT0_+0x1d8>
    ce3b:	84 c0                	test   al,al
    ce3d:	75 31                	jne    ce70 <_Z6printfItJttEEvPKcT_DpT0_+0xf0>
    ce3f:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    ce44:	8d 77 02             	lea    esi,[edi+0x2]
    ce47:	84 c0                	test   al,al
    ce49:	74 a8                	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    ce4b:	89 f7                	mov    edi,esi
    ce4d:	8d 77 01             	lea    esi,[edi+0x1]
    ce50:	3c 25                	cmp    al,0x25
    ce52:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    ce56:	74 d8                	je     ce30 <_Z6printfItJttEEvPKcT_DpT0_+0xb0>
    ce58:	83 ec 0c             	sub    esp,0xc
    ce5b:	50                   	push   eax
    ce5c:	e8 4f ed ff ff       	call   bbb0 <_Z7putcharc>
    ce61:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    ce64:	83 c4 10             	add    esp,0x10
    ce67:	84 c0                	test   al,al
    ce69:	74 88                	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    ce6b:	89 f7                	mov    edi,esi
    ce6d:	eb de                	jmp    ce4d <_Z6printfItJttEEvPKcT_DpT0_+0xcd>
    ce6f:	90                   	nop
    ce70:	83 ec 08             	sub    esp,0x8
    ce73:	8d 44 24 24          	lea    eax,[esp+0x24]
    ce77:	50                   	push   eax
    ce78:	53                   	push   ebx
    ce79:	e8 f2 fd ff ff       	call   cc70 <_Z14_manage_escapeItEiPKcPT_>
    ce7e:	01 c6                	add    esi,eax
    ce80:	0f b7 44 24 14       	movzx  eax,WORD PTR [esp+0x14]
    ce85:	01 f5                	add    ebp,esi
    ce87:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    ce8c:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    ce90:	83 c4 10             	add    esp,0x10
    ce93:	84 c0                	test   al,al
    ce95:	0f 84 58 ff ff ff    	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    ce9b:	31 f6                	xor    esi,esi
    ce9d:	3c 25                	cmp    al,0x25
    ce9f:	8d 5e 01             	lea    ebx,[esi+0x1]
    cea2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    cea6:	75 34                	jne    cedc <_Z6printfItJttEEvPKcT_DpT0_+0x15c>
    cea8:	90                   	nop
    cea9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ceb0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    ceb3:	3c 25                	cmp    al,0x25
    ceb5:	0f 84 c5 00 00 00    	je     cf80 <_Z6printfItJttEEvPKcT_DpT0_+0x200>
    cebb:	84 c0                	test   al,al
    cebd:	75 71                	jne    cf30 <_Z6printfItJttEEvPKcT_DpT0_+0x1b0>
    cebf:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    cec4:	8d 5e 02             	lea    ebx,[esi+0x2]
    cec7:	84 c0                	test   al,al
    cec9:	0f 84 24 ff ff ff    	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    cecf:	89 de                	mov    esi,ebx
    ced1:	8d 5e 01             	lea    ebx,[esi+0x1]
    ced4:	3c 25                	cmp    al,0x25
    ced6:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    ceda:	74 d4                	je     ceb0 <_Z6printfItJttEEvPKcT_DpT0_+0x130>
    cedc:	83 ec 0c             	sub    esp,0xc
    cedf:	50                   	push   eax
    cee0:	e8 cb ec ff ff       	call   bbb0 <_Z7putcharc>
    cee5:	0f be 07             	movsx  eax,BYTE PTR [edi]
    cee8:	83 c4 10             	add    esp,0x10
    ceeb:	84 c0                	test   al,al
    ceed:	0f 84 00 ff ff ff    	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    cef3:	89 de                	mov    esi,ebx
    cef5:	eb da                	jmp    ced1 <_Z6printfItJttEEvPKcT_DpT0_+0x151>
    cef7:	89 f6                	mov    esi,esi
    cef9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    cf00:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    cf04:	83 ec 0c             	sub    esp,0xc
    cf07:	6a 25                	push   0x25
    cf09:	e8 a2 ec ff ff       	call   bbb0 <_Z7putcharc>
    cf0e:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    cf12:	83 c4 10             	add    esp,0x10
    cf15:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    cf1a:	8d 79 02             	lea    edi,[ecx+0x2]
    cf1d:	84 c0                	test   al,al
    cf1f:	0f 84 ce fe ff ff    	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    cf25:	89 f9                	mov    ecx,edi
    cf27:	e9 a9 fe ff ff       	jmp    cdd5 <_Z6printfItJttEEvPKcT_DpT0_+0x55>
    cf2c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    cf30:	83 ec 08             	sub    esp,0x8
    cf33:	8d 44 24 26          	lea    eax,[esp+0x26]
    cf37:	50                   	push   eax
    cf38:	57                   	push   edi
    cf39:	e8 32 fd ff ff       	call   cc70 <_Z14_manage_escapeItEiPKcPT_>
    cf3e:	01 c3                	add    ebx,eax
    cf40:	01 dd                	add    ebp,ebx
    cf42:	89 2c 24             	mov    DWORD PTR [esp],ebp
    cf45:	e8 e6 ec ff ff       	call   bc30 <_Z6printfPKc>
    cf4a:	83 c4 10             	add    esp,0x10
    cf4d:	83 c4 2c             	add    esp,0x2c
    cf50:	5b                   	pop    ebx
    cf51:	5e                   	pop    esi
    cf52:	5f                   	pop    edi
    cf53:	5d                   	pop    ebp
    cf54:	c3                   	ret    
    cf55:	8d 76 00             	lea    esi,[esi+0x0]
    cf58:	83 ec 0c             	sub    esp,0xc
    cf5b:	8d 77 02             	lea    esi,[edi+0x2]
    cf5e:	6a 25                	push   0x25
    cf60:	e8 4b ec ff ff       	call   bbb0 <_Z7putcharc>
    cf65:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    cf6a:	83 c4 10             	add    esp,0x10
    cf6d:	84 c0                	test   al,al
    cf6f:	0f 84 7e fe ff ff    	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    cf75:	89 f7                	mov    edi,esi
    cf77:	e9 d1 fe ff ff       	jmp    ce4d <_Z6printfItJttEEvPKcT_DpT0_+0xcd>
    cf7c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    cf80:	83 ec 0c             	sub    esp,0xc
    cf83:	8d 5e 02             	lea    ebx,[esi+0x2]
    cf86:	6a 25                	push   0x25
    cf88:	e8 23 ec ff ff       	call   bbb0 <_Z7putcharc>
    cf8d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    cf92:	83 c4 10             	add    esp,0x10
    cf95:	84 c0                	test   al,al
    cf97:	0f 84 56 fe ff ff    	je     cdf3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    cf9d:	89 de                	mov    esi,ebx
    cf9f:	e9 2d ff ff ff       	jmp    ced1 <_Z6printfItJttEEvPKcT_DpT0_+0x151>

Disassembly of section .text._Z6printfItEvPKcT_:

0000cfb0 <_Z6printfItEvPKcT_>:
    cfb0:	55                   	push   ebp
    cfb1:	57                   	push   edi
    cfb2:	56                   	push   esi
    cfb3:	53                   	push   ebx
    cfb4:	31 f6                	xor    esi,esi
    cfb6:	83 ec 1c             	sub    esp,0x1c
    cfb9:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    cfbd:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    cfc1:	66 89 44 24 0c       	mov    WORD PTR [esp+0xc],ax
    cfc6:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    cfca:	84 c0                	test   al,al
    cfcc:	74 4d                	je     d01b <_Z6printfItEvPKcT_+0x6b>
    cfce:	8d 5e 01             	lea    ebx,[esi+0x1]
    cfd1:	3c 25                	cmp    al,0x25
    cfd3:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    cfd7:	75 2f                	jne    d008 <_Z6printfItEvPKcT_+0x58>
    cfd9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    cfe0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    cfe3:	3c 25                	cmp    al,0x25
    cfe5:	0f 84 85 00 00 00    	je     d070 <_Z6printfItEvPKcT_+0xc0>
    cfeb:	84 c0                	test   al,al
    cfed:	75 39                	jne    d028 <_Z6printfItEvPKcT_+0x78>
    cfef:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    cff4:	8d 5e 02             	lea    ebx,[esi+0x2]
    cff7:	84 c0                	test   al,al
    cff9:	74 20                	je     d01b <_Z6printfItEvPKcT_+0x6b>
    cffb:	89 de                	mov    esi,ebx
    cffd:	8d 5e 01             	lea    ebx,[esi+0x1]
    d000:	3c 25                	cmp    al,0x25
    d002:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d006:	74 d8                	je     cfe0 <_Z6printfItEvPKcT_+0x30>
    d008:	83 ec 0c             	sub    esp,0xc
    d00b:	50                   	push   eax
    d00c:	e8 9f eb ff ff       	call   bbb0 <_Z7putcharc>
    d011:	0f be 07             	movsx  eax,BYTE PTR [edi]
    d014:	83 c4 10             	add    esp,0x10
    d017:	84 c0                	test   al,al
    d019:	75 e0                	jne    cffb <_Z6printfItEvPKcT_+0x4b>
    d01b:	83 c4 1c             	add    esp,0x1c
    d01e:	5b                   	pop    ebx
    d01f:	5e                   	pop    esi
    d020:	5f                   	pop    edi
    d021:	5d                   	pop    ebp
    d022:	c3                   	ret    
    d023:	90                   	nop
    d024:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d028:	83 e8 42             	sub    eax,0x42
    d02b:	3c 36                	cmp    al,0x36
    d02d:	77 26                	ja     d055 <_Z6printfItEvPKcT_+0xa5>
    d02f:	0f b6 c0             	movzx  eax,al
    d032:	ff 24 85 20 ff 00 00 	jmp    DWORD PTR [eax*4+0xff20]
    d039:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d040:	83 ec 0c             	sub    esp,0xc
    d043:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    d047:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    d04c:	50                   	push   eax
    d04d:	e8 5e eb ff ff       	call   bbb0 <_Z7putcharc>
    d052:	83 c4 10             	add    esp,0x10
    d055:	83 ec 0c             	sub    esp,0xc
    d058:	57                   	push   edi
    d059:	e8 d2 eb ff ff       	call   bc30 <_Z6printfPKc>
    d05e:	83 c4 10             	add    esp,0x10
    d061:	83 c4 1c             	add    esp,0x1c
    d064:	5b                   	pop    ebx
    d065:	5e                   	pop    esi
    d066:	5f                   	pop    edi
    d067:	5d                   	pop    ebp
    d068:	c3                   	ret    
    d069:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d070:	83 ec 0c             	sub    esp,0xc
    d073:	8d 5e 02             	lea    ebx,[esi+0x2]
    d076:	6a 25                	push   0x25
    d078:	e8 33 eb ff ff       	call   bbb0 <_Z7putcharc>
    d07d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d082:	83 c4 10             	add    esp,0x10
    d085:	84 c0                	test   al,al
    d087:	74 92                	je     d01b <_Z6printfItEvPKcT_+0x6b>
    d089:	89 de                	mov    esi,ebx
    d08b:	e9 6d ff ff ff       	jmp    cffd <_Z6printfItEvPKcT_+0x4d>
    d090:	83 ec 0c             	sub    esp,0xc
    d093:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    d097:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    d09b:	e8 70 eb ff ff       	call   bc10 <_Z6putstrPc>
    d0a0:	83 c4 10             	add    esp,0x10
    d0a3:	83 ec 0c             	sub    esp,0xc
    d0a6:	57                   	push   edi
    d0a7:	e8 84 eb ff ff       	call   bc30 <_Z6printfPKc>
    d0ac:	83 c4 10             	add    esp,0x10
    d0af:	eb b0                	jmp    d061 <_Z6printfItEvPKcT_+0xb1>
    d0b1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d0b8:	83 ec 0c             	sub    esp,0xc
    d0bb:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    d0bf:	0f b7 44 24 18       	movzx  eax,WORD PTR [esp+0x18]
    d0c4:	50                   	push   eax
    d0c5:	e8 36 eb ff ff       	call   bc00 <_Z6putbini>
    d0ca:	83 c4 10             	add    esp,0x10
    d0cd:	83 ec 0c             	sub    esp,0xc
    d0d0:	57                   	push   edi
    d0d1:	e8 5a eb ff ff       	call   bc30 <_Z6printfPKc>
    d0d6:	83 c4 10             	add    esp,0x10
    d0d9:	eb 86                	jmp    d061 <_Z6printfItEvPKcT_+0xb1>
    d0db:	90                   	nop
    d0dc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d0e0:	83 ec 0c             	sub    esp,0xc
    d0e3:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    d0e7:	0f b7 44 24 18       	movzx  eax,WORD PTR [esp+0x18]
    d0ec:	50                   	push   eax
    d0ed:	e8 fe ea ff ff       	call   bbf0 <_Z6putocti>
    d0f2:	83 c4 10             	add    esp,0x10
    d0f5:	83 ec 0c             	sub    esp,0xc
    d0f8:	57                   	push   edi
    d0f9:	e8 32 eb ff ff       	call   bc30 <_Z6printfPKc>
    d0fe:	83 c4 10             	add    esp,0x10
    d101:	e9 5b ff ff ff       	jmp    d061 <_Z6printfItEvPKcT_+0xb1>
    d106:	8d 76 00             	lea    esi,[esi+0x0]
    d109:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    d110:	83 ec 0c             	sub    esp,0xc
    d113:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    d117:	0f b7 44 24 18       	movzx  eax,WORD PTR [esp+0x18]
    d11c:	50                   	push   eax
    d11d:	e8 be ea ff ff       	call   bbe0 <_Z6puthexi>
    d122:	83 c4 10             	add    esp,0x10
    d125:	83 ec 0c             	sub    esp,0xc
    d128:	57                   	push   edi
    d129:	e8 02 eb ff ff       	call   bc30 <_Z6printfPKc>
    d12e:	83 c4 10             	add    esp,0x10
    d131:	e9 2b ff ff ff       	jmp    d061 <_Z6printfItEvPKcT_+0xb1>
    d136:	8d 76 00             	lea    esi,[esi+0x0]
    d139:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    d140:	83 ec 0c             	sub    esp,0xc
    d143:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    d147:	0f b7 44 24 18       	movzx  eax,WORD PTR [esp+0x18]
    d14c:	50                   	push   eax
    d14d:	e8 7e ea ff ff       	call   bbd0 <_Z6putdeci>
    d152:	83 c4 10             	add    esp,0x10
    d155:	83 ec 0c             	sub    esp,0xc
    d158:	57                   	push   edi
    d159:	e8 d2 ea ff ff       	call   bc30 <_Z6printfPKc>
    d15e:	83 c4 10             	add    esp,0x10
    d161:	e9 fb fe ff ff       	jmp    d061 <_Z6printfItEvPKcT_+0xb1>
    d166:	8d 76 00             	lea    esi,[esi+0x0]
    d169:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    d170:	83 ec 0c             	sub    esp,0xc
    d173:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    d177:	68 1c ff 00 00       	push   0xff1c
    d17c:	e8 af ea ff ff       	call   bc30 <_Z6printfPKc>
    d181:	58                   	pop    eax
    d182:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    d186:	e8 55 ea ff ff       	call   bbe0 <_Z6puthexi>
    d18b:	83 c4 10             	add    esp,0x10
    d18e:	83 ec 0c             	sub    esp,0xc
    d191:	57                   	push   edi
    d192:	e8 99 ea ff ff       	call   bc30 <_Z6printfPKc>
    d197:	83 c4 10             	add    esp,0x10
    d19a:	e9 c2 fe ff ff       	jmp    d061 <_Z6printfItEvPKcT_+0xb1>

Disassembly of section .text._Z14_manage_escapeIhEiPKcPT_:

0000d1a0 <_Z14_manage_escapeIhEiPKcPT_>:
    d1a0:	83 ec 0c             	sub    esp,0xc
    d1a3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    d1a7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    d1aa:	83 e8 42             	sub    eax,0x42
    d1ad:	3c 36                	cmp    al,0x36
    d1af:	0f 87 f3 00 00 00    	ja     d2a8 <_Z14_manage_escapeIhEiPKcPT_+0x108>
    d1b5:	0f b6 c0             	movzx  eax,al
    d1b8:	ff 24 85 fc ff 00 00 	jmp    DWORD PTR [eax*4+0xfffc]
    d1bf:	90                   	nop
    d1c0:	83 ec 0c             	sub    esp,0xc
    d1c3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d1c7:	ff 30                	push   DWORD PTR [eax]
    d1c9:	e8 42 ea ff ff       	call   bc10 <_Z6putstrPc>
    d1ce:	83 c4 10             	add    esp,0x10
    d1d1:	b8 01 00 00 00       	mov    eax,0x1
    d1d6:	83 c4 0c             	add    esp,0xc
    d1d9:	c3                   	ret    
    d1da:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d1e0:	83 ec 0c             	sub    esp,0xc
    d1e3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d1e7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    d1ea:	50                   	push   eax
    d1eb:	e8 10 ea ff ff       	call   bc00 <_Z6putbini>
    d1f0:	83 c4 10             	add    esp,0x10
    d1f3:	b8 01 00 00 00       	mov    eax,0x1
    d1f8:	83 c4 0c             	add    esp,0xc
    d1fb:	c3                   	ret    
    d1fc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d200:	83 ec 0c             	sub    esp,0xc
    d203:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d207:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    d20a:	50                   	push   eax
    d20b:	e8 e0 e9 ff ff       	call   bbf0 <_Z6putocti>
    d210:	83 c4 10             	add    esp,0x10
    d213:	b8 01 00 00 00       	mov    eax,0x1
    d218:	83 c4 0c             	add    esp,0xc
    d21b:	c3                   	ret    
    d21c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d220:	83 ec 0c             	sub    esp,0xc
    d223:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d227:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    d22a:	50                   	push   eax
    d22b:	e8 b0 e9 ff ff       	call   bbe0 <_Z6puthexi>
    d230:	83 c4 10             	add    esp,0x10
    d233:	b8 01 00 00 00       	mov    eax,0x1
    d238:	83 c4 0c             	add    esp,0xc
    d23b:	c3                   	ret    
    d23c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d240:	83 ec 0c             	sub    esp,0xc
    d243:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d247:	0f be 00             	movsx  eax,BYTE PTR [eax]
    d24a:	50                   	push   eax
    d24b:	e8 60 e9 ff ff       	call   bbb0 <_Z7putcharc>
    d250:	83 c4 10             	add    esp,0x10
    d253:	b8 01 00 00 00       	mov    eax,0x1
    d258:	83 c4 0c             	add    esp,0xc
    d25b:	c3                   	ret    
    d25c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d260:	83 ec 0c             	sub    esp,0xc
    d263:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d267:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    d26a:	50                   	push   eax
    d26b:	e8 60 e9 ff ff       	call   bbd0 <_Z6putdeci>
    d270:	83 c4 10             	add    esp,0x10
    d273:	b8 01 00 00 00       	mov    eax,0x1
    d278:	83 c4 0c             	add    esp,0xc
    d27b:	c3                   	ret    
    d27c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d280:	83 ec 0c             	sub    esp,0xc
    d283:	68 1c ff 00 00       	push   0xff1c
    d288:	e8 a3 e9 ff ff       	call   bc30 <_Z6printfPKc>
    d28d:	58                   	pop    eax
    d28e:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d292:	ff 30                	push   DWORD PTR [eax]
    d294:	e8 47 e9 ff ff       	call   bbe0 <_Z6puthexi>
    d299:	83 c4 10             	add    esp,0x10
    d29c:	b8 01 00 00 00       	mov    eax,0x1
    d2a1:	83 c4 0c             	add    esp,0xc
    d2a4:	c3                   	ret    
    d2a5:	8d 76 00             	lea    esi,[esi+0x0]
    d2a8:	31 c0                	xor    eax,eax
    d2aa:	e9 27 ff ff ff       	jmp    d1d6 <_Z14_manage_escapeIhEiPKcPT_+0x36>

Disassembly of section .text._Z14_manage_escapeIjEiPKcPT_:

0000d2b0 <_Z14_manage_escapeIjEiPKcPT_>:
    d2b0:	83 ec 0c             	sub    esp,0xc
    d2b3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    d2b7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    d2ba:	83 e8 42             	sub    eax,0x42
    d2bd:	3c 36                	cmp    al,0x36
    d2bf:	0f 87 db 00 00 00    	ja     d3a0 <_Z14_manage_escapeIjEiPKcPT_+0xf0>
    d2c5:	0f b6 c0             	movzx  eax,al
    d2c8:	ff 24 85 d8 00 01 00 	jmp    DWORD PTR [eax*4+0x100d8]
    d2cf:	90                   	nop
    d2d0:	83 ec 0c             	sub    esp,0xc
    d2d3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d2d7:	ff 30                	push   DWORD PTR [eax]
    d2d9:	e8 32 e9 ff ff       	call   bc10 <_Z6putstrPc>
    d2de:	83 c4 10             	add    esp,0x10
    d2e1:	b8 01 00 00 00       	mov    eax,0x1
    d2e6:	83 c4 0c             	add    esp,0xc
    d2e9:	c3                   	ret    
    d2ea:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d2f0:	83 ec 0c             	sub    esp,0xc
    d2f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d2f7:	ff 30                	push   DWORD PTR [eax]
    d2f9:	e8 02 e9 ff ff       	call   bc00 <_Z6putbini>
    d2fe:	83 c4 10             	add    esp,0x10
    d301:	b8 01 00 00 00       	mov    eax,0x1
    d306:	83 c4 0c             	add    esp,0xc
    d309:	c3                   	ret    
    d30a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d310:	83 ec 0c             	sub    esp,0xc
    d313:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d317:	ff 30                	push   DWORD PTR [eax]
    d319:	e8 d2 e8 ff ff       	call   bbf0 <_Z6putocti>
    d31e:	83 c4 10             	add    esp,0x10
    d321:	b8 01 00 00 00       	mov    eax,0x1
    d326:	83 c4 0c             	add    esp,0xc
    d329:	c3                   	ret    
    d32a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d330:	83 ec 0c             	sub    esp,0xc
    d333:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d337:	ff 30                	push   DWORD PTR [eax]
    d339:	e8 a2 e8 ff ff       	call   bbe0 <_Z6puthexi>
    d33e:	83 c4 10             	add    esp,0x10
    d341:	b8 01 00 00 00       	mov    eax,0x1
    d346:	83 c4 0c             	add    esp,0xc
    d349:	c3                   	ret    
    d34a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d350:	83 ec 0c             	sub    esp,0xc
    d353:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d357:	0f be 00             	movsx  eax,BYTE PTR [eax]
    d35a:	50                   	push   eax
    d35b:	e8 50 e8 ff ff       	call   bbb0 <_Z7putcharc>
    d360:	83 c4 10             	add    esp,0x10
    d363:	b8 01 00 00 00       	mov    eax,0x1
    d368:	83 c4 0c             	add    esp,0xc
    d36b:	c3                   	ret    
    d36c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d370:	83 ec 0c             	sub    esp,0xc
    d373:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d377:	ff 30                	push   DWORD PTR [eax]
    d379:	e8 52 e8 ff ff       	call   bbd0 <_Z6putdeci>
    d37e:	83 c4 10             	add    esp,0x10
    d381:	b8 01 00 00 00       	mov    eax,0x1
    d386:	83 c4 0c             	add    esp,0xc
    d389:	c3                   	ret    
    d38a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d390:	83 ec 0c             	sub    esp,0xc
    d393:	68 1c ff 00 00       	push   0xff1c
    d398:	e8 93 e8 ff ff       	call   bc30 <_Z6printfPKc>
    d39d:	58                   	pop    eax
    d39e:	eb 93                	jmp    d333 <_Z14_manage_escapeIjEiPKcPT_+0x83>
    d3a0:	31 c0                	xor    eax,eax
    d3a2:	e9 3f ff ff ff       	jmp    d2e6 <_Z14_manage_escapeIjEiPKcPT_+0x36>

Disassembly of section .text._Z6printfIjJjEEvPKcT_DpT0_:

0000d3b0 <_Z6printfIjJjEEvPKcT_DpT0_>:
    d3b0:	55                   	push   ebp
    d3b1:	57                   	push   edi
    d3b2:	56                   	push   esi
    d3b3:	53                   	push   ebx
    d3b4:	31 f6                	xor    esi,esi
    d3b6:	83 ec 1c             	sub    esp,0x1c
    d3b9:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    d3bd:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d3c1:	84 c0                	test   al,al
    d3c3:	74 46                	je     d40b <_Z6printfIjJjEEvPKcT_DpT0_+0x5b>
    d3c5:	8d 5e 01             	lea    ebx,[esi+0x1]
    d3c8:	3c 25                	cmp    al,0x25
    d3ca:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d3ce:	75 28                	jne    d3f8 <_Z6printfIjJjEEvPKcT_DpT0_+0x48>
    d3d0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    d3d3:	3c 25                	cmp    al,0x25
    d3d5:	0f 84 e5 00 00 00    	je     d4c0 <_Z6printfIjJjEEvPKcT_DpT0_+0x110>
    d3db:	84 c0                	test   al,al
    d3dd:	75 39                	jne    d418 <_Z6printfIjJjEEvPKcT_DpT0_+0x68>
    d3df:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d3e4:	8d 5e 02             	lea    ebx,[esi+0x2]
    d3e7:	84 c0                	test   al,al
    d3e9:	74 20                	je     d40b <_Z6printfIjJjEEvPKcT_DpT0_+0x5b>
    d3eb:	89 de                	mov    esi,ebx
    d3ed:	8d 5e 01             	lea    ebx,[esi+0x1]
    d3f0:	3c 25                	cmp    al,0x25
    d3f2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d3f6:	74 d8                	je     d3d0 <_Z6printfIjJjEEvPKcT_DpT0_+0x20>
    d3f8:	83 ec 0c             	sub    esp,0xc
    d3fb:	50                   	push   eax
    d3fc:	e8 af e7 ff ff       	call   bbb0 <_Z7putcharc>
    d401:	0f be 07             	movsx  eax,BYTE PTR [edi]
    d404:	83 c4 10             	add    esp,0x10
    d407:	84 c0                	test   al,al
    d409:	75 e0                	jne    d3eb <_Z6printfIjJjEEvPKcT_DpT0_+0x3b>
    d40b:	83 c4 1c             	add    esp,0x1c
    d40e:	5b                   	pop    ebx
    d40f:	5e                   	pop    esi
    d410:	5f                   	pop    edi
    d411:	5d                   	pop    ebp
    d412:	c3                   	ret    
    d413:	90                   	nop
    d414:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d418:	83 ec 08             	sub    esp,0x8
    d41b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    d41f:	50                   	push   eax
    d420:	57                   	push   edi
    d421:	e8 8a fe ff ff       	call   d2b0 <_Z14_manage_escapeIjEiPKcPT_>
    d426:	01 c3                	add    ebx,eax
    d428:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    d42c:	01 eb                	add    ebx,ebp
    d42e:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    d432:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    d435:	83 c4 10             	add    esp,0x10
    d438:	84 c0                	test   al,al
    d43a:	74 cf                	je     d40b <_Z6printfIjJjEEvPKcT_DpT0_+0x5b>
    d43c:	31 ff                	xor    edi,edi
    d43e:	3c 25                	cmp    al,0x25
    d440:	8d 77 01             	lea    esi,[edi+0x1]
    d443:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d446:	75 30                	jne    d478 <_Z6printfIjJjEEvPKcT_DpT0_+0xc8>
    d448:	90                   	nop
    d449:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d450:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    d454:	3c 25                	cmp    al,0x25
    d456:	0f 84 8c 00 00 00    	je     d4e8 <_Z6printfIjJjEEvPKcT_DpT0_+0x138>
    d45c:	84 c0                	test   al,al
    d45e:	75 38                	jne    d498 <_Z6printfIjJjEEvPKcT_DpT0_+0xe8>
    d460:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    d465:	8d 77 02             	lea    esi,[edi+0x2]
    d468:	84 c0                	test   al,al
    d46a:	74 9f                	je     d40b <_Z6printfIjJjEEvPKcT_DpT0_+0x5b>
    d46c:	89 f7                	mov    edi,esi
    d46e:	8d 77 01             	lea    esi,[edi+0x1]
    d471:	3c 25                	cmp    al,0x25
    d473:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d476:	74 d8                	je     d450 <_Z6printfIjJjEEvPKcT_DpT0_+0xa0>
    d478:	83 ec 0c             	sub    esp,0xc
    d47b:	50                   	push   eax
    d47c:	e8 2f e7 ff ff       	call   bbb0 <_Z7putcharc>
    d481:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d485:	83 c4 10             	add    esp,0x10
    d488:	84 c0                	test   al,al
    d48a:	0f 84 7b ff ff ff    	je     d40b <_Z6printfIjJjEEvPKcT_DpT0_+0x5b>
    d490:	89 f7                	mov    edi,esi
    d492:	eb da                	jmp    d46e <_Z6printfIjJjEEvPKcT_DpT0_+0xbe>
    d494:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d498:	83 ec 08             	sub    esp,0x8
    d49b:	8d 44 24 14          	lea    eax,[esp+0x14]
    d49f:	50                   	push   eax
    d4a0:	55                   	push   ebp
    d4a1:	e8 0a fe ff ff       	call   d2b0 <_Z14_manage_escapeIjEiPKcPT_>
    d4a6:	01 c6                	add    esi,eax
    d4a8:	01 f3                	add    ebx,esi
    d4aa:	89 1c 24             	mov    DWORD PTR [esp],ebx
    d4ad:	e8 7e e7 ff ff       	call   bc30 <_Z6printfPKc>
    d4b2:	83 c4 10             	add    esp,0x10
    d4b5:	83 c4 1c             	add    esp,0x1c
    d4b8:	5b                   	pop    ebx
    d4b9:	5e                   	pop    esi
    d4ba:	5f                   	pop    edi
    d4bb:	5d                   	pop    ebp
    d4bc:	c3                   	ret    
    d4bd:	8d 76 00             	lea    esi,[esi+0x0]
    d4c0:	83 ec 0c             	sub    esp,0xc
    d4c3:	8d 5e 02             	lea    ebx,[esi+0x2]
    d4c6:	6a 25                	push   0x25
    d4c8:	e8 e3 e6 ff ff       	call   bbb0 <_Z7putcharc>
    d4cd:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d4d2:	83 c4 10             	add    esp,0x10
    d4d5:	84 c0                	test   al,al
    d4d7:	0f 84 2e ff ff ff    	je     d40b <_Z6printfIjJjEEvPKcT_DpT0_+0x5b>
    d4dd:	89 de                	mov    esi,ebx
    d4df:	e9 09 ff ff ff       	jmp    d3ed <_Z6printfIjJjEEvPKcT_DpT0_+0x3d>
    d4e4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d4e8:	83 ec 0c             	sub    esp,0xc
    d4eb:	8d 77 02             	lea    esi,[edi+0x2]
    d4ee:	6a 25                	push   0x25
    d4f0:	e8 bb e6 ff ff       	call   bbb0 <_Z7putcharc>
    d4f5:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    d4fa:	83 c4 10             	add    esp,0x10
    d4fd:	84 c0                	test   al,al
    d4ff:	0f 84 06 ff ff ff    	je     d40b <_Z6printfIjJjEEvPKcT_DpT0_+0x5b>
    d505:	89 f7                	mov    edi,esi
    d507:	e9 62 ff ff ff       	jmp    d46e <_Z6printfIjJjEEvPKcT_DpT0_+0xbe>

Disassembly of section .text._Z6printfIhJhEEvPKcT_DpT0_:

0000d510 <_Z6printfIhJhEEvPKcT_DpT0_>:
    d510:	55                   	push   ebp
    d511:	57                   	push   edi
    d512:	31 ff                	xor    edi,edi
    d514:	56                   	push   esi
    d515:	53                   	push   ebx
    d516:	83 ec 2c             	sub    esp,0x2c
    d519:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    d51d:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    d521:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    d525:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    d529:	88 44 24 0c          	mov    BYTE PTR [esp+0xc],al
    d52d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d531:	84 c0                	test   al,al
    d533:	74 46                	je     d57b <_Z6printfIhJhEEvPKcT_DpT0_+0x6b>
    d535:	8d 5f 01             	lea    ebx,[edi+0x1]
    d538:	3c 25                	cmp    al,0x25
    d53a:	8d 74 1d 00          	lea    esi,[ebp+ebx*1+0x0]
    d53e:	75 28                	jne    d568 <_Z6printfIhJhEEvPKcT_DpT0_+0x58>
    d540:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    d543:	3c 25                	cmp    al,0x25
    d545:	0f 84 e5 00 00 00    	je     d630 <_Z6printfIhJhEEvPKcT_DpT0_+0x120>
    d54b:	84 c0                	test   al,al
    d54d:	75 39                	jne    d588 <_Z6printfIhJhEEvPKcT_DpT0_+0x78>
    d54f:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    d554:	8d 5f 02             	lea    ebx,[edi+0x2]
    d557:	84 c0                	test   al,al
    d559:	74 20                	je     d57b <_Z6printfIhJhEEvPKcT_DpT0_+0x6b>
    d55b:	89 df                	mov    edi,ebx
    d55d:	8d 5f 01             	lea    ebx,[edi+0x1]
    d560:	3c 25                	cmp    al,0x25
    d562:	8d 74 1d 00          	lea    esi,[ebp+ebx*1+0x0]
    d566:	74 d8                	je     d540 <_Z6printfIhJhEEvPKcT_DpT0_+0x30>
    d568:	83 ec 0c             	sub    esp,0xc
    d56b:	50                   	push   eax
    d56c:	e8 3f e6 ff ff       	call   bbb0 <_Z7putcharc>
    d571:	0f be 06             	movsx  eax,BYTE PTR [esi]
    d574:	83 c4 10             	add    esp,0x10
    d577:	84 c0                	test   al,al
    d579:	75 e0                	jne    d55b <_Z6printfIhJhEEvPKcT_DpT0_+0x4b>
    d57b:	83 c4 2c             	add    esp,0x2c
    d57e:	5b                   	pop    ebx
    d57f:	5e                   	pop    esi
    d580:	5f                   	pop    edi
    d581:	5d                   	pop    ebp
    d582:	c3                   	ret    
    d583:	90                   	nop
    d584:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d588:	83 ec 08             	sub    esp,0x8
    d58b:	8d 44 24 14          	lea    eax,[esp+0x14]
    d58f:	50                   	push   eax
    d590:	56                   	push   esi
    d591:	e8 0a fc ff ff       	call   d1a0 <_Z14_manage_escapeIhEiPKcPT_>
    d596:	01 c3                	add    ebx,eax
    d598:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    d59d:	01 eb                	add    ebx,ebp
    d59f:	88 44 24 2f          	mov    BYTE PTR [esp+0x2f],al
    d5a3:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    d5a6:	83 c4 10             	add    esp,0x10
    d5a9:	84 c0                	test   al,al
    d5ab:	74 ce                	je     d57b <_Z6printfIhJhEEvPKcT_DpT0_+0x6b>
    d5ad:	31 ff                	xor    edi,edi
    d5af:	3c 25                	cmp    al,0x25
    d5b1:	8d 77 01             	lea    esi,[edi+0x1]
    d5b4:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d5b7:	75 2f                	jne    d5e8 <_Z6printfIhJhEEvPKcT_DpT0_+0xd8>
    d5b9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d5c0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    d5c4:	3c 25                	cmp    al,0x25
    d5c6:	0f 84 8c 00 00 00    	je     d658 <_Z6printfIhJhEEvPKcT_DpT0_+0x148>
    d5cc:	84 c0                	test   al,al
    d5ce:	75 38                	jne    d608 <_Z6printfIhJhEEvPKcT_DpT0_+0xf8>
    d5d0:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    d5d5:	8d 77 02             	lea    esi,[edi+0x2]
    d5d8:	84 c0                	test   al,al
    d5da:	74 9f                	je     d57b <_Z6printfIhJhEEvPKcT_DpT0_+0x6b>
    d5dc:	89 f7                	mov    edi,esi
    d5de:	8d 77 01             	lea    esi,[edi+0x1]
    d5e1:	3c 25                	cmp    al,0x25
    d5e3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d5e6:	74 d8                	je     d5c0 <_Z6printfIhJhEEvPKcT_DpT0_+0xb0>
    d5e8:	83 ec 0c             	sub    esp,0xc
    d5eb:	50                   	push   eax
    d5ec:	e8 bf e5 ff ff       	call   bbb0 <_Z7putcharc>
    d5f1:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d5f5:	83 c4 10             	add    esp,0x10
    d5f8:	84 c0                	test   al,al
    d5fa:	0f 84 7b ff ff ff    	je     d57b <_Z6printfIhJhEEvPKcT_DpT0_+0x6b>
    d600:	89 f7                	mov    edi,esi
    d602:	eb da                	jmp    d5de <_Z6printfIhJhEEvPKcT_DpT0_+0xce>
    d604:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d608:	83 ec 08             	sub    esp,0x8
    d60b:	8d 44 24 27          	lea    eax,[esp+0x27]
    d60f:	50                   	push   eax
    d610:	55                   	push   ebp
    d611:	e8 8a fb ff ff       	call   d1a0 <_Z14_manage_escapeIhEiPKcPT_>
    d616:	01 c6                	add    esi,eax
    d618:	01 f3                	add    ebx,esi
    d61a:	89 1c 24             	mov    DWORD PTR [esp],ebx
    d61d:	e8 0e e6 ff ff       	call   bc30 <_Z6printfPKc>
    d622:	83 c4 10             	add    esp,0x10
    d625:	83 c4 2c             	add    esp,0x2c
    d628:	5b                   	pop    ebx
    d629:	5e                   	pop    esi
    d62a:	5f                   	pop    edi
    d62b:	5d                   	pop    ebp
    d62c:	c3                   	ret    
    d62d:	8d 76 00             	lea    esi,[esi+0x0]
    d630:	83 ec 0c             	sub    esp,0xc
    d633:	8d 5f 02             	lea    ebx,[edi+0x2]
    d636:	6a 25                	push   0x25
    d638:	e8 73 e5 ff ff       	call   bbb0 <_Z7putcharc>
    d63d:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    d642:	83 c4 10             	add    esp,0x10
    d645:	84 c0                	test   al,al
    d647:	0f 84 2e ff ff ff    	je     d57b <_Z6printfIhJhEEvPKcT_DpT0_+0x6b>
    d64d:	89 df                	mov    edi,ebx
    d64f:	e9 09 ff ff ff       	jmp    d55d <_Z6printfIhJhEEvPKcT_DpT0_+0x4d>
    d654:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d658:	83 ec 0c             	sub    esp,0xc
    d65b:	8d 77 02             	lea    esi,[edi+0x2]
    d65e:	6a 25                	push   0x25
    d660:	e8 4b e5 ff ff       	call   bbb0 <_Z7putcharc>
    d665:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    d66a:	83 c4 10             	add    esp,0x10
    d66d:	84 c0                	test   al,al
    d66f:	0f 84 06 ff ff ff    	je     d57b <_Z6printfIhJhEEvPKcT_DpT0_+0x6b>
    d675:	89 f7                	mov    edi,esi
    d677:	e9 62 ff ff ff       	jmp    d5de <_Z6printfIhJhEEvPKcT_DpT0_+0xce>

Disassembly of section .text._Z6printfIhJhhhEEvPKcT_DpT0_:

0000d680 <_Z6printfIhJhhhEEvPKcT_DpT0_>:
    d680:	55                   	push   ebp
    d681:	57                   	push   edi
    d682:	31 ed                	xor    ebp,ebp
    d684:	56                   	push   esi
    d685:	53                   	push   ebx
    d686:	83 ec 2c             	sub    esp,0x2c
    d689:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    d68d:	8b 7c 24 40          	mov    edi,DWORD PTR [esp+0x40]
    d691:	89 04 24             	mov    DWORD PTR [esp],eax
    d694:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    d698:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    d69c:	8b 44 24 50          	mov    eax,DWORD PTR [esp+0x50]
    d6a0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    d6a4:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    d6a8:	88 44 24 0c          	mov    BYTE PTR [esp+0xc],al
    d6ac:	0f be 07             	movsx  eax,BYTE PTR [edi]
    d6af:	84 c0                	test   al,al
    d6b1:	74 47                	je     d6fa <_Z6printfIhJhhhEEvPKcT_DpT0_+0x7a>
    d6b3:	8d 5d 01             	lea    ebx,[ebp+0x1]
    d6b6:	3c 25                	cmp    al,0x25
    d6b8:	8d 34 1f             	lea    esi,[edi+ebx*1]
    d6bb:	75 2a                	jne    d6e7 <_Z6printfIhJhhhEEvPKcT_DpT0_+0x67>
    d6bd:	8d 76 00             	lea    esi,[esi+0x0]
    d6c0:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    d6c3:	3c 25                	cmp    al,0x25
    d6c5:	0f 84 05 01 00 00    	je     d7d0 <_Z6printfIhJhhhEEvPKcT_DpT0_+0x150>
    d6cb:	84 c0                	test   al,al
    d6cd:	75 39                	jne    d708 <_Z6printfIhJhhhEEvPKcT_DpT0_+0x88>
    d6cf:	0f be 44 2f 02       	movsx  eax,BYTE PTR [edi+ebp*1+0x2]
    d6d4:	8d 5d 02             	lea    ebx,[ebp+0x2]
    d6d7:	84 c0                	test   al,al
    d6d9:	74 1f                	je     d6fa <_Z6printfIhJhhhEEvPKcT_DpT0_+0x7a>
    d6db:	89 dd                	mov    ebp,ebx
    d6dd:	8d 5d 01             	lea    ebx,[ebp+0x1]
    d6e0:	3c 25                	cmp    al,0x25
    d6e2:	8d 34 1f             	lea    esi,[edi+ebx*1]
    d6e5:	74 d9                	je     d6c0 <_Z6printfIhJhhhEEvPKcT_DpT0_+0x40>
    d6e7:	83 ec 0c             	sub    esp,0xc
    d6ea:	50                   	push   eax
    d6eb:	e8 c0 e4 ff ff       	call   bbb0 <_Z7putcharc>
    d6f0:	0f be 06             	movsx  eax,BYTE PTR [esi]
    d6f3:	83 c4 10             	add    esp,0x10
    d6f6:	84 c0                	test   al,al
    d6f8:	75 e1                	jne    d6db <_Z6printfIhJhhhEEvPKcT_DpT0_+0x5b>
    d6fa:	83 c4 2c             	add    esp,0x2c
    d6fd:	5b                   	pop    ebx
    d6fe:	5e                   	pop    esi
    d6ff:	5f                   	pop    edi
    d700:	5d                   	pop    ebp
    d701:	c3                   	ret    
    d702:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d708:	83 ec 08             	sub    esp,0x8
    d70b:	8d 44 24 14          	lea    eax,[esp+0x14]
    d70f:	50                   	push   eax
    d710:	56                   	push   esi
    d711:	e8 8a fa ff ff       	call   d1a0 <_Z14_manage_escapeIhEiPKcPT_>
    d716:	01 c3                	add    ebx,eax
    d718:	0f b6 44 24 10       	movzx  eax,BYTE PTR [esp+0x10]
    d71d:	0f b6 54 24 14       	movzx  edx,BYTE PTR [esp+0x14]
    d722:	01 fb                	add    ebx,edi
    d724:	0f b6 74 24 18       	movzx  esi,BYTE PTR [esp+0x18]
    d729:	88 44 24 2f          	mov    BYTE PTR [esp+0x2f],al
    d72d:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    d730:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    d734:	83 c4 10             	add    esp,0x10
    d737:	84 c0                	test   al,al
    d739:	74 bf                	je     d6fa <_Z6printfIhJhhhEEvPKcT_DpT0_+0x7a>
    d73b:	31 c9                	xor    ecx,ecx
    d73d:	89 34 24             	mov    DWORD PTR [esp],esi
    d740:	3c 25                	cmp    al,0x25
    d742:	89 cd                	mov    ebp,ecx
    d744:	89 de                	mov    esi,ebx
    d746:	8d 7d 01             	lea    edi,[ebp+0x1]
    d749:	8d 1c 3e             	lea    ebx,[esi+edi*1]
    d74c:	75 29                	jne    d777 <_Z6printfIhJhhhEEvPKcT_DpT0_+0xf7>
    d74e:	66 90                	xchg   ax,ax
    d750:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    d753:	3c 25                	cmp    al,0x25
    d755:	0f 84 9d 00 00 00    	je     d7f8 <_Z6printfIhJhhhEEvPKcT_DpT0_+0x178>
    d75b:	84 c0                	test   al,al
    d75d:	75 39                	jne    d798 <_Z6printfIhJhhhEEvPKcT_DpT0_+0x118>
    d75f:	0f be 44 2e 02       	movsx  eax,BYTE PTR [esi+ebp*1+0x2]
    d764:	8d 7d 02             	lea    edi,[ebp+0x2]
    d767:	84 c0                	test   al,al
    d769:	74 8f                	je     d6fa <_Z6printfIhJhhhEEvPKcT_DpT0_+0x7a>
    d76b:	89 fd                	mov    ebp,edi
    d76d:	8d 7d 01             	lea    edi,[ebp+0x1]
    d770:	3c 25                	cmp    al,0x25
    d772:	8d 1c 3e             	lea    ebx,[esi+edi*1]
    d775:	74 d9                	je     d750 <_Z6printfIhJhhhEEvPKcT_DpT0_+0xd0>
    d777:	83 ec 0c             	sub    esp,0xc
    d77a:	50                   	push   eax
    d77b:	e8 30 e4 ff ff       	call   bbb0 <_Z7putcharc>
    d780:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    d783:	83 c4 10             	add    esp,0x10
    d786:	84 c0                	test   al,al
    d788:	0f 84 6c ff ff ff    	je     d6fa <_Z6printfIhJhhhEEvPKcT_DpT0_+0x7a>
    d78e:	89 fd                	mov    ebp,edi
    d790:	eb db                	jmp    d76d <_Z6printfIhJhhhEEvPKcT_DpT0_+0xed>
    d792:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d798:	83 ec 08             	sub    esp,0x8
    d79b:	89 dd                	mov    ebp,ebx
    d79d:	89 f3                	mov    ebx,esi
    d79f:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    d7a3:	8d 44 24 27          	lea    eax,[esp+0x27]
    d7a7:	50                   	push   eax
    d7a8:	55                   	push   ebp
    d7a9:	e8 f2 f9 ff ff       	call   d1a0 <_Z14_manage_escapeIhEiPKcPT_>
    d7ae:	01 c7                	add    edi,eax
    d7b0:	83 c4 0c             	add    esp,0xc
    d7b3:	01 fb                	add    ebx,edi
    d7b5:	56                   	push   esi
    d7b6:	ff 74 24 0c          	push   DWORD PTR [esp+0xc]
    d7ba:	53                   	push   ebx
    d7bb:	e8 50 fd ff ff       	call   d510 <_Z6printfIhJhEEvPKcT_DpT0_>
    d7c0:	83 c4 10             	add    esp,0x10
    d7c3:	83 c4 2c             	add    esp,0x2c
    d7c6:	5b                   	pop    ebx
    d7c7:	5e                   	pop    esi
    d7c8:	5f                   	pop    edi
    d7c9:	5d                   	pop    ebp
    d7ca:	c3                   	ret    
    d7cb:	90                   	nop
    d7cc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d7d0:	83 ec 0c             	sub    esp,0xc
    d7d3:	8d 5d 02             	lea    ebx,[ebp+0x2]
    d7d6:	6a 25                	push   0x25
    d7d8:	e8 d3 e3 ff ff       	call   bbb0 <_Z7putcharc>
    d7dd:	0f be 44 2f 02       	movsx  eax,BYTE PTR [edi+ebp*1+0x2]
    d7e2:	83 c4 10             	add    esp,0x10
    d7e5:	84 c0                	test   al,al
    d7e7:	0f 84 0d ff ff ff    	je     d6fa <_Z6printfIhJhhhEEvPKcT_DpT0_+0x7a>
    d7ed:	89 dd                	mov    ebp,ebx
    d7ef:	e9 e9 fe ff ff       	jmp    d6dd <_Z6printfIhJhhhEEvPKcT_DpT0_+0x5d>
    d7f4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d7f8:	83 ec 0c             	sub    esp,0xc
    d7fb:	8d 7d 02             	lea    edi,[ebp+0x2]
    d7fe:	6a 25                	push   0x25
    d800:	e8 ab e3 ff ff       	call   bbb0 <_Z7putcharc>
    d805:	0f be 44 2e 02       	movsx  eax,BYTE PTR [esi+ebp*1+0x2]
    d80a:	83 c4 10             	add    esp,0x10
    d80d:	84 c0                	test   al,al
    d80f:	0f 84 e5 fe ff ff    	je     d6fa <_Z6printfIhJhhhEEvPKcT_DpT0_+0x7a>
    d815:	89 fd                	mov    ebp,edi
    d817:	e9 51 ff ff ff       	jmp    d76d <_Z6printfIhJhhhEEvPKcT_DpT0_+0xed>

Disassembly of section .text._Z14_manage_escapeIiEiPKcPT_:

0000d820 <_Z14_manage_escapeIiEiPKcPT_>:
    d820:	83 ec 0c             	sub    esp,0xc
    d823:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    d827:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    d82a:	83 e8 42             	sub    eax,0x42
    d82d:	3c 36                	cmp    al,0x36
    d82f:	0f 87 db 00 00 00    	ja     d910 <_Z14_manage_escapeIiEiPKcPT_+0xf0>
    d835:	0f b6 c0             	movzx  eax,al
    d838:	ff 24 85 b8 01 01 00 	jmp    DWORD PTR [eax*4+0x101b8]
    d83f:	90                   	nop
    d840:	83 ec 0c             	sub    esp,0xc
    d843:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d847:	ff 30                	push   DWORD PTR [eax]
    d849:	e8 c2 e3 ff ff       	call   bc10 <_Z6putstrPc>
    d84e:	83 c4 10             	add    esp,0x10
    d851:	b8 01 00 00 00       	mov    eax,0x1
    d856:	83 c4 0c             	add    esp,0xc
    d859:	c3                   	ret    
    d85a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d860:	83 ec 0c             	sub    esp,0xc
    d863:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d867:	ff 30                	push   DWORD PTR [eax]
    d869:	e8 92 e3 ff ff       	call   bc00 <_Z6putbini>
    d86e:	83 c4 10             	add    esp,0x10
    d871:	b8 01 00 00 00       	mov    eax,0x1
    d876:	83 c4 0c             	add    esp,0xc
    d879:	c3                   	ret    
    d87a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d880:	83 ec 0c             	sub    esp,0xc
    d883:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d887:	ff 30                	push   DWORD PTR [eax]
    d889:	e8 62 e3 ff ff       	call   bbf0 <_Z6putocti>
    d88e:	83 c4 10             	add    esp,0x10
    d891:	b8 01 00 00 00       	mov    eax,0x1
    d896:	83 c4 0c             	add    esp,0xc
    d899:	c3                   	ret    
    d89a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d8a0:	83 ec 0c             	sub    esp,0xc
    d8a3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d8a7:	ff 30                	push   DWORD PTR [eax]
    d8a9:	e8 32 e3 ff ff       	call   bbe0 <_Z6puthexi>
    d8ae:	83 c4 10             	add    esp,0x10
    d8b1:	b8 01 00 00 00       	mov    eax,0x1
    d8b6:	83 c4 0c             	add    esp,0xc
    d8b9:	c3                   	ret    
    d8ba:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d8c0:	83 ec 0c             	sub    esp,0xc
    d8c3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d8c7:	0f be 00             	movsx  eax,BYTE PTR [eax]
    d8ca:	50                   	push   eax
    d8cb:	e8 e0 e2 ff ff       	call   bbb0 <_Z7putcharc>
    d8d0:	83 c4 10             	add    esp,0x10
    d8d3:	b8 01 00 00 00       	mov    eax,0x1
    d8d8:	83 c4 0c             	add    esp,0xc
    d8db:	c3                   	ret    
    d8dc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d8e0:	83 ec 0c             	sub    esp,0xc
    d8e3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d8e7:	ff 30                	push   DWORD PTR [eax]
    d8e9:	e8 e2 e2 ff ff       	call   bbd0 <_Z6putdeci>
    d8ee:	83 c4 10             	add    esp,0x10
    d8f1:	b8 01 00 00 00       	mov    eax,0x1
    d8f6:	83 c4 0c             	add    esp,0xc
    d8f9:	c3                   	ret    
    d8fa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d900:	83 ec 0c             	sub    esp,0xc
    d903:	68 b4 01 01 00       	push   0x101b4
    d908:	e8 23 e3 ff ff       	call   bc30 <_Z6printfPKc>
    d90d:	58                   	pop    eax
    d90e:	eb 93                	jmp    d8a3 <_Z14_manage_escapeIiEiPKcPT_+0x83>
    d910:	31 c0                	xor    eax,eax
    d912:	e9 3f ff ff ff       	jmp    d856 <_Z14_manage_escapeIiEiPKcPT_+0x36>
