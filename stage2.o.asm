
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
    a013:	c6 44 24 0f 00       	mov    BYTE PTR [esp+0xf],0x0
    a018:	e8 73 10 00 00       	call   b090 <_Z12clear_screenv>
    a01d:	83 ec 0c             	sub    esp,0xc
    a020:	68 dc d0 00 00       	push   0xd0dc
    a025:	e8 f6 10 00 00       	call   b120 <_Z6printfPKc>
    a02a:	e8 d1 00 00 00       	call   a100 <check_A20_on>
    a02f:	83 c4 10             	add    esp,0x10
    a032:	85 c0                	test   eax,eax
    a034:	0f 85 b4 00 00 00    	jne    a0ee <kernel_2+0xde>
    a03a:	83 ec 04             	sub    esp,0x4
    a03d:	6a 00                	push   0x0
    a03f:	8d 44 24 17          	lea    eax,[esp+0x17]
    a043:	50                   	push   eax
    a044:	6a 00                	push   0x0
    a046:	e8 65 06 00 00       	call   a6b0 <_ZN3ata12sendIdentifyEhRbb>
    a04b:	83 c4 10             	add    esp,0x10
    a04e:	84 c0                	test   al,al
    a050:	0f 84 83 00 00 00    	je     a0d9 <kernel_2+0xc9>
    a056:	80 7c 24 0f 00       	cmp    BYTE PTR [esp+0xf],0x0
    a05b:	75 4d                	jne    a0aa <kernel_2+0x9a>
    a05d:	83 ec 0c             	sub    esp,0xc
    a060:	68 84 d1 00 00       	push   0xd184
    a065:	e8 b6 10 00 00       	call   b120 <_Z6printfPKc>
    a06a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    a071:	68 e8 07 00 00       	push   0x7e8
    a076:	6a 00                	push   0x0
    a078:	68 80 00 00 00       	push   0x80
    a07d:	68 00 00 00 01       	push   0x1000000
    a082:	e8 89 05 00 00       	call   a610 <_ZN3ata9lba48ReadEPvyjh>
    a087:	83 c4 20             	add    esp,0x20
    a08a:	84 c0                	test   al,al
    a08c:	75 39                	jne    a0c7 <kernel_2+0xb7>
    a08e:	83 ec 0c             	sub    esp,0xc
    a091:	68 f7 d0 00 00       	push   0xd0f7
    a096:	e8 85 10 00 00       	call   b120 <_Z6printfPKc>
    a09b:	83 c4 10             	add    esp,0x10
    a09e:	e8 5d 09 00 00       	call   aa00 <_ZN6paging18init_kernel_pagingEv>
    a0a3:	e8 58 5f ff c0       	call   c1000000 <VGA_TEXT_MEMORY+0xc0f48000>
    a0a8:	eb fe                	jmp    a0a8 <kernel_2+0x98>
    a0aa:	6a 00                	push   0x0
    a0ac:	68 e8 07 00 00       	push   0x7e8
    a0b1:	68 80 00 00 00       	push   0x80
    a0b6:	68 00 00 00 01       	push   0x1000000
    a0bb:	e8 10 03 00 00       	call   a3d0 <_ZN3ata9lba28ReadEPvjjh>
    a0c0:	83 c4 10             	add    esp,0x10
    a0c3:	84 c0                	test   al,al
    a0c5:	74 c7                	je     a08e <kernel_2+0x7e>
    a0c7:	83 ec 0c             	sub    esp,0xc
    a0ca:	68 04 d1 00 00       	push   0xd104
    a0cf:	e8 4c 10 00 00       	call   b120 <_Z6printfPKc>
    a0d4:	83 c4 10             	add    esp,0x10
    a0d7:	eb c5                	jmp    a09e <kernel_2+0x8e>
    a0d9:	83 ec 0c             	sub    esp,0xc
    a0dc:	68 e6 d0 00 00       	push   0xd0e6
    a0e1:	e8 3a 10 00 00       	call   b120 <_Z6printfPKc>
    a0e6:	83 c4 10             	add    esp,0x10
    a0e9:	e9 68 ff ff ff       	jmp    a056 <kernel_2+0x46>
    a0ee:	e8 2b 00 00 00       	call   a11e <enable_A20>
    a0f3:	e9 42 ff ff ff       	jmp    a03a <kernel_2+0x2a>
    a0f8:	66 90                	xchg   ax,ax
    a0fa:	66 90                	xchg   ax,ax
    a0fc:	66 90                	xchg   ax,ax
    a0fe:	66 90                	xchg   ax,ax

0000a100 <check_A20_on>:
    a100:	60                   	pusha  
    a101:	bf 45 23 11 00       	mov    edi,0x112345
    a106:	be 45 23 01 00       	mov    esi,0x12345
    a10b:	89 36                	mov    DWORD PTR [esi],esi
    a10d:	89 3f                	mov    DWORD PTR [edi],edi
    a10f:	a7                   	cmps   DWORD PTR ds:[esi],DWORD PTR es:[edi]
    a110:	b8 00 00 00 00       	mov    eax,0x0
    a115:	75 05                	jne    a11c <check_A20_on.A20_on>
    a117:	b8 01 00 00 00       	mov    eax,0x1

0000a11c <check_A20_on.A20_on>:
    a11c:	61                   	popa   
    a11d:	c3                   	ret    

0000a11e <enable_A20>:
    a11e:	60                   	pusha  
    a11f:	e4 92                	in     al,0x92
    a121:	0c 02                	or     al,0x2
    a123:	e6 92                	out    0x92,al
    a125:	61                   	popa   
    a126:	c3                   	ret    
    a127:	66 90                	xchg   ax,ax
    a129:	66 90                	xchg   ax,ax
    a12b:	66 90                	xchg   ax,ax
    a12d:	66 90                	xchg   ax,ax
    a12f:	90                   	nop

0000a130 <vga_print_string_at_coords>:
    a130:	60                   	pusha  
    a131:	bf 00 80 0b 00       	mov    edi,0xb8000
    a136:	b9 50 00 00 00       	mov    ecx,0x50
    a13b:	f7 e1                	mul    ecx
    a13d:	01 d8                	add    eax,ebx
    a13f:	b9 02 00 00 00       	mov    ecx,0x2
    a144:	f7 e1                	mul    ecx
    a146:	01 c7                	add    edi,eax
    a148:	eb 0b                	jmp    a155 <vga_print_string_at_coords.while_condition>

0000a14a <vga_print_string_at_coords.while_start>:
    a14a:	8a 06                	mov    al,BYTE PTR [esi]
    a14c:	b4 0f                	mov    ah,0xf
    a14e:	66 89 07             	mov    WORD PTR [edi],ax
    a151:	83 c7 02             	add    edi,0x2
    a154:	46                   	inc    esi

0000a155 <vga_print_string_at_coords.while_condition>:
    a155:	8a 06                	mov    al,BYTE PTR [esi]
    a157:	3c 00                	cmp    al,0x0
    a159:	75 ef                	jne    a14a <vga_print_string_at_coords.while_start>
    a15b:	61                   	popa   
    a15c:	c3                   	ret    
    a15d:	66 90                	xchg   ax,ax
    a15f:	90                   	nop

0000a160 <__setCR4>:
    a160:	55                   	push   ebp
    a161:	89 e5                	mov    ebp,esp
    a163:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a166:	0f 22 e0             	mov    cr4,eax
    a169:	5d                   	pop    ebp
    a16a:	c3                   	ret    

0000a16b <__getCR4>:
    a16b:	0f 20 e0             	mov    eax,cr4
    a16e:	c3                   	ret    

0000a16f <__setCR3>:
    a16f:	55                   	push   ebp
    a170:	89 e5                	mov    ebp,esp
    a172:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a175:	0f 22 d8             	mov    cr3,eax
    a178:	5d                   	pop    ebp
    a179:	c3                   	ret    

0000a17a <__getCR3>:
    a17a:	0f 20 d8             	mov    eax,cr3
    a17d:	c3                   	ret    

0000a17e <__setCR2>:
    a17e:	55                   	push   ebp
    a17f:	89 e5                	mov    ebp,esp
    a181:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a184:	0f 22 d0             	mov    cr2,eax
    a187:	5d                   	pop    ebp
    a188:	c3                   	ret    

0000a189 <__getCR2>:
    a189:	0f 20 d0             	mov    eax,cr2
    a18c:	c3                   	ret    

0000a18d <__setCR0>:
    a18d:	55                   	push   ebp
    a18e:	89 e5                	mov    ebp,esp
    a190:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a193:	0f 22 c0             	mov    cr0,eax
    a196:	5d                   	pop    ebp
    a197:	c3                   	ret    

0000a198 <__getCR0>:
    a198:	0f 20 c0             	mov    eax,cr0
    a19b:	c3                   	ret    
    a19c:	66 90                	xchg   ax,ax
    a19e:	66 90                	xchg   ax,ax

0000a1a0 <__isCpuidSuported>:
    a1a0:	9c                   	pushf  
    a1a1:	9c                   	pushf  
    a1a2:	81 34 24 00 00 20 00 	xor    DWORD PTR [esp],0x200000
    a1a9:	9d                   	popf   
    a1aa:	9c                   	pushf  
    a1ab:	58                   	pop    eax
    a1ac:	33 04 24             	xor    eax,DWORD PTR [esp]
    a1af:	9d                   	popf   
    a1b0:	25 00 00 20 00       	and    eax,0x200000
    a1b5:	c3                   	ret    

0000a1b6 <__getCpuidVendor>:
    a1b6:	55                   	push   ebp
    a1b7:	89 e5                	mov    ebp,esp
    a1b9:	53                   	push   ebx
    a1ba:	51                   	push   ecx
    a1bb:	52                   	push   edx
    a1bc:	b8 00 00 00 00       	mov    eax,0x0
    a1c1:	0f a2                	cpuid  
    a1c3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a1c6:	89 18                	mov    DWORD PTR [eax],ebx
    a1c8:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    a1cb:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    a1ce:	5a                   	pop    edx
    a1cf:	59                   	pop    ecx
    a1d0:	5b                   	pop    ebx
    a1d1:	5d                   	pop    ebp
    a1d2:	c3                   	ret    

0000a1d3 <__getCpuidFeatures>:
    a1d3:	55                   	push   ebp
    a1d4:	89 e5                	mov    ebp,esp
    a1d6:	51                   	push   ecx
    a1d7:	52                   	push   edx
    a1d8:	b8 01 00 00 00       	mov    eax,0x1
    a1dd:	0f a2                	cpuid  
    a1df:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a1e2:	89 10                	mov    DWORD PTR [eax],edx
    a1e4:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
    a1e7:	5a                   	pop    edx
    a1e8:	59                   	pop    ecx
    a1e9:	5d                   	pop    ebp
    a1ea:	c3                   	ret    
    a1eb:	66 90                	xchg   ax,ax
    a1ed:	66 90                	xchg   ax,ax
    a1ef:	90                   	nop

0000a1f0 <_ZN3ata7waitBSYEv>:
    a1f0:	83 ec 0c             	sub    esp,0xc
    a1f3:	90                   	nop
    a1f4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a1f8:	83 ec 0c             	sub    esp,0xc
    a1fb:	68 f7 01 00 00       	push   0x1f7
    a200:	e8 ab 0f 00 00       	call   b1b0 <_Z3inbt>
    a205:	83 c4 10             	add    esp,0x10
    a208:	84 c0                	test   al,al
    a20a:	78 ec                	js     a1f8 <_ZN3ata7waitBSYEv+0x8>
    a20c:	83 c4 0c             	add    esp,0xc
    a20f:	c3                   	ret    

0000a210 <_ZN3ata7waitDSQEv>:
    a210:	83 ec 0c             	sub    esp,0xc
    a213:	eb 07                	jmp    a21c <_ZN3ata7waitDSQEv+0xc>
    a215:	8d 76 00             	lea    esi,[esi+0x0]
    a218:	a8 08                	test   al,0x8
    a21a:	75 24                	jne    a240 <_ZN3ata7waitDSQEv+0x30>
    a21c:	83 ec 0c             	sub    esp,0xc
    a21f:	68 f7 01 00 00       	push   0x1f7
    a224:	e8 87 0f 00 00       	call   b1b0 <_Z3inbt>
    a229:	83 c4 10             	add    esp,0x10
    a22c:	a8 01                	test   al,0x1
    a22e:	74 e8                	je     a218 <_ZN3ata7waitDSQEv+0x8>
    a230:	31 c0                	xor    eax,eax
    a232:	83 c4 0c             	add    esp,0xc
    a235:	c3                   	ret    
    a236:	8d 76 00             	lea    esi,[esi+0x0]
    a239:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    a240:	b8 01 00 00 00       	mov    eax,0x1
    a245:	83 c4 0c             	add    esp,0xc
    a248:	c3                   	ret    
    a249:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000a250 <_ZN3ata12lba28PIOReadEPvjhh>:
    a250:	55                   	push   ebp
    a251:	57                   	push   edi
    a252:	56                   	push   esi
    a253:	53                   	push   ebx
    a254:	83 ec 24             	sub    esp,0x24
    a257:	8b 5c 24 3c          	mov    ebx,DWORD PTR [esp+0x3c]
    a25b:	0f b6 54 24 44       	movzx  edx,BYTE PTR [esp+0x44]
    a260:	8b 7c 24 40          	mov    edi,DWORD PTR [esp+0x40]
    a264:	89 d8                	mov    eax,ebx
    a266:	c1 e8 18             	shr    eax,0x18
    a269:	c1 e2 04             	shl    edx,0x4
    a26c:	83 ca e0             	or     edx,0xffffffe0
    a26f:	83 e0 0f             	and    eax,0xf
    a272:	09 d0                	or     eax,edx
    a274:	0f b6 c0             	movzx  eax,al
    a277:	50                   	push   eax
    a278:	68 f6 01 00 00       	push   0x1f6
    a27d:	e8 de 0e 00 00       	call   b160 <_Z4outbth>
    a282:	58                   	pop    eax
    a283:	5a                   	pop    edx
    a284:	6a 00                	push   0x0
    a286:	68 f1 01 00 00       	push   0x1f1
    a28b:	e8 d0 0e 00 00       	call   b160 <_Z4outbth>
    a290:	59                   	pop    ecx
    a291:	89 f8                	mov    eax,edi
    a293:	5e                   	pop    esi
    a294:	0f b6 f8             	movzx  edi,al
    a297:	57                   	push   edi
    a298:	68 f2 01 00 00       	push   0x1f2
    a29d:	e8 be 0e 00 00       	call   b160 <_Z4outbth>
    a2a2:	5d                   	pop    ebp
    a2a3:	58                   	pop    eax
    a2a4:	0f b6 c3             	movzx  eax,bl
    a2a7:	50                   	push   eax
    a2a8:	68 f3 01 00 00       	push   0x1f3
    a2ad:	e8 ae 0e 00 00       	call   b160 <_Z4outbth>
    a2b2:	58                   	pop    eax
    a2b3:	5a                   	pop    edx
    a2b4:	0f b6 c7             	movzx  eax,bh
    a2b7:	50                   	push   eax
    a2b8:	68 f4 01 00 00       	push   0x1f4
    a2bd:	e8 9e 0e 00 00       	call   b160 <_Z4outbth>
    a2c2:	89 d8                	mov    eax,ebx
    a2c4:	59                   	pop    ecx
    a2c5:	c1 e8 10             	shr    eax,0x10
    a2c8:	5e                   	pop    esi
    a2c9:	0f b6 c0             	movzx  eax,al
    a2cc:	50                   	push   eax
    a2cd:	68 f5 01 00 00       	push   0x1f5
    a2d2:	e8 89 0e 00 00       	call   b160 <_Z4outbth>
    a2d7:	83 c4 10             	add    esp,0x10
    a2da:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a2e0:	83 ec 0c             	sub    esp,0xc
    a2e3:	68 f7 01 00 00       	push   0x1f7
    a2e8:	e8 c3 0e 00 00       	call   b1b0 <_Z3inbt>
    a2ed:	83 c4 10             	add    esp,0x10
    a2f0:	84 c0                	test   al,al
    a2f2:	78 ec                	js     a2e0 <_ZN3ata12lba28PIOReadEPvjhh+0x90>
    a2f4:	83 ec 08             	sub    esp,0x8
    a2f7:	6a 20                	push   0x20
    a2f9:	68 f7 01 00 00       	push   0x1f7
    a2fe:	e8 5d 0e 00 00       	call   b160 <_Z4outbth>
    a303:	83 c4 10             	add    esp,0x10
    a306:	85 ff                	test   edi,edi
    a308:	0f 84 b0 00 00 00    	je     a3be <_ZN3ata12lba28PIOReadEPvjhh+0x16e>
    a30e:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    a312:	31 f6                	xor    esi,esi
    a314:	05 00 02 00 00       	add    eax,0x200
    a319:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a31d:	8d 76 00             	lea    esi,[esi+0x0]
    a320:	83 ec 0c             	sub    esp,0xc
    a323:	68 f7 01 00 00       	push   0x1f7
    a328:	e8 83 0e 00 00       	call   b1b0 <_Z3inbt>
    a32d:	83 c4 10             	add    esp,0x10
    a330:	84 c0                	test   al,al
    a332:	78 ec                	js     a320 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a334:	83 ec 0c             	sub    esp,0xc
    a337:	68 f6 03 00 00       	push   0x3f6
    a33c:	e8 6f 0e 00 00       	call   b1b0 <_Z3inbt>
    a341:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a348:	e8 63 0e 00 00       	call   b1b0 <_Z3inbt>
    a34d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a354:	e8 57 0e 00 00       	call   b1b0 <_Z3inbt>
    a359:	83 c4 10             	add    esp,0x10
    a35c:	eb 06                	jmp    a364 <_ZN3ata12lba28PIOReadEPvjhh+0x114>
    a35e:	66 90                	xchg   ax,ax
    a360:	a8 08                	test   al,0x8
    a362:	75 1e                	jne    a382 <_ZN3ata12lba28PIOReadEPvjhh+0x132>
    a364:	83 ec 0c             	sub    esp,0xc
    a367:	68 f7 01 00 00       	push   0x1f7
    a36c:	e8 3f 0e 00 00       	call   b1b0 <_Z3inbt>
    a371:	83 c4 10             	add    esp,0x10
    a374:	a8 01                	test   al,0x1
    a376:	74 e8                	je     a360 <_ZN3ata12lba28PIOReadEPvjhh+0x110>
    a378:	83 c4 1c             	add    esp,0x1c
    a37b:	31 c0                	xor    eax,eax
    a37d:	5b                   	pop    ebx
    a37e:	5e                   	pop    esi
    a37f:	5f                   	pop    edi
    a380:	5d                   	pop    ebp
    a381:	c3                   	ret    
    a382:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a386:	89 f3                	mov    ebx,esi
    a388:	c1 e3 09             	shl    ebx,0x9
    a38b:	01 dd                	add    ebp,ebx
    a38d:	03 5c 24 0c          	add    ebx,DWORD PTR [esp+0xc]
    a391:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a398:	83 ec 0c             	sub    esp,0xc
    a39b:	83 c5 02             	add    ebp,0x2
    a39e:	68 f0 01 00 00       	push   0x1f0
    a3a3:	e8 18 0e 00 00       	call   b1c0 <_Z3inwt>
    a3a8:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    a3ac:	83 c4 10             	add    esp,0x10
    a3af:	39 dd                	cmp    ebp,ebx
    a3b1:	75 e5                	jne    a398 <_ZN3ata12lba28PIOReadEPvjhh+0x148>
    a3b3:	83 c6 01             	add    esi,0x1
    a3b6:	39 f7                	cmp    edi,esi
    a3b8:	0f 85 62 ff ff ff    	jne    a320 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a3be:	83 c4 1c             	add    esp,0x1c
    a3c1:	b8 01 00 00 00       	mov    eax,0x1
    a3c6:	5b                   	pop    ebx
    a3c7:	5e                   	pop    esi
    a3c8:	5f                   	pop    edi
    a3c9:	5d                   	pop    ebp
    a3ca:	c3                   	ret    
    a3cb:	90                   	nop
    a3cc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000a3d0 <_ZN3ata9lba28ReadEPvjjh>:
    a3d0:	55                   	push   ebp
    a3d1:	57                   	push   edi
    a3d2:	56                   	push   esi
    a3d3:	53                   	push   ebx
    a3d4:	83 ec 1c             	sub    esp,0x1c
    a3d7:	8b 74 24 38          	mov    esi,DWORD PTR [esp+0x38]
    a3db:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a3df:	8b 7c 24 34          	mov    edi,DWORD PTR [esp+0x34]
    a3e3:	8b 44 24 3c          	mov    eax,DWORD PTR [esp+0x3c]
    a3e7:	85 f6                	test   esi,esi
    a3e9:	74 45                	je     a430 <_ZN3ata9lba28ReadEPvjjh+0x60>
    a3eb:	0f b6 c0             	movzx  eax,al
    a3ee:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a3f2:	eb 0f                	jmp    a403 <_ZN3ata9lba28ReadEPvjjh+0x33>
    a3f4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a3f8:	01 df                	add    edi,ebx
    a3fa:	c1 e3 09             	shl    ebx,0x9
    a3fd:	01 dd                	add    ebp,ebx
    a3ff:	85 f6                	test   esi,esi
    a401:	74 2d                	je     a430 <_ZN3ata9lba28ReadEPvjjh+0x60>
    a403:	81 fe ff 00 00 00    	cmp    esi,0xff
    a409:	bb ff 00 00 00       	mov    ebx,0xff
    a40e:	ff 74 24 0c          	push   DWORD PTR [esp+0xc]
    a412:	0f 46 de             	cmovbe ebx,esi
    a415:	53                   	push   ebx
    a416:	57                   	push   edi
    a417:	29 de                	sub    esi,ebx
    a419:	55                   	push   ebp
    a41a:	e8 31 fe ff ff       	call   a250 <_ZN3ata12lba28PIOReadEPvjhh>
    a41f:	83 c4 10             	add    esp,0x10
    a422:	84 c0                	test   al,al
    a424:	75 d2                	jne    a3f8 <_ZN3ata9lba28ReadEPvjjh+0x28>
    a426:	83 c4 1c             	add    esp,0x1c
    a429:	5b                   	pop    ebx
    a42a:	5e                   	pop    esi
    a42b:	5f                   	pop    edi
    a42c:	5d                   	pop    ebp
    a42d:	c3                   	ret    
    a42e:	66 90                	xchg   ax,ax
    a430:	83 c4 1c             	add    esp,0x1c
    a433:	b8 01 00 00 00       	mov    eax,0x1
    a438:	5b                   	pop    ebx
    a439:	5e                   	pop    esi
    a43a:	5f                   	pop    edi
    a43b:	5d                   	pop    ebp
    a43c:	c3                   	ret    
    a43d:	8d 76 00             	lea    esi,[esi+0x0]

0000a440 <_ZN3ata12lba48PIOReadEPvyth>:
    a440:	55                   	push   ebp
    a441:	57                   	push   edi
    a442:	56                   	push   esi
    a443:	53                   	push   ebx
    a444:	83 ec 24             	sub    esp,0x24
    a447:	0f b6 44 24 48       	movzx  eax,BYTE PTR [esp+0x48]
    a44c:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    a450:	8b 7c 24 3c          	mov    edi,DWORD PTR [esp+0x3c]
    a454:	8b 5c 24 44          	mov    ebx,DWORD PTR [esp+0x44]
    a458:	c1 e0 04             	shl    eax,0x4
    a45b:	83 c8 e0             	or     eax,0xffffffe0
    a45e:	0f b6 c0             	movzx  eax,al
    a461:	50                   	push   eax
    a462:	68 f6 01 00 00       	push   0x1f6
    a467:	e8 f4 0c 00 00       	call   b160 <_Z4outbth>
    a46c:	58                   	pop    eax
    a46d:	5a                   	pop    edx
    a46e:	6a 00                	push   0x0
    a470:	68 f1 01 00 00       	push   0x1f1
    a475:	e8 e6 0c 00 00       	call   b160 <_Z4outbth>
    a47a:	59                   	pop    ecx
    a47b:	5e                   	pop    esi
    a47c:	0f b6 c7             	movzx  eax,bh
    a47f:	50                   	push   eax
    a480:	68 f2 01 00 00       	push   0x1f2
    a485:	e8 d6 0c 00 00       	call   b160 <_Z4outbth>
    a48a:	58                   	pop    eax
    a48b:	89 f8                	mov    eax,edi
    a48d:	0f ac e8 18          	shrd   eax,ebp,0x18
    a491:	5a                   	pop    edx
    a492:	0f b6 c0             	movzx  eax,al
    a495:	50                   	push   eax
    a496:	68 f3 01 00 00       	push   0x1f3
    a49b:	e8 c0 0c 00 00       	call   b160 <_Z4outbth>
    a4a0:	5e                   	pop    esi
    a4a1:	58                   	pop    eax
    a4a2:	89 e8                	mov    eax,ebp
    a4a4:	0f b6 c0             	movzx  eax,al
    a4a7:	50                   	push   eax
    a4a8:	68 f4 01 00 00       	push   0x1f4
    a4ad:	e8 ae 0c 00 00       	call   b160 <_Z4outbth>
    a4b2:	58                   	pop    eax
    a4b3:	89 e8                	mov    eax,ebp
    a4b5:	5a                   	pop    edx
    a4b6:	0f b6 c4             	movzx  eax,ah
    a4b9:	50                   	push   eax
    a4ba:	68 f5 01 00 00       	push   0x1f5
    a4bf:	e8 9c 0c 00 00       	call   b160 <_Z4outbth>
    a4c4:	59                   	pop    ecx
    a4c5:	5e                   	pop    esi
    a4c6:	0f b6 c3             	movzx  eax,bl
    a4c9:	50                   	push   eax
    a4ca:	68 f2 01 00 00       	push   0x1f2
    a4cf:	e8 8c 0c 00 00       	call   b160 <_Z4outbth>
    a4d4:	58                   	pop    eax
    a4d5:	89 f8                	mov    eax,edi
    a4d7:	5a                   	pop    edx
    a4d8:	0f b6 c0             	movzx  eax,al
    a4db:	50                   	push   eax
    a4dc:	68 f3 01 00 00       	push   0x1f3
    a4e1:	e8 7a 0c 00 00       	call   b160 <_Z4outbth>
    a4e6:	89 f8                	mov    eax,edi
    a4e8:	0f ac e8 08          	shrd   eax,ebp,0x8
    a4ec:	59                   	pop    ecx
    a4ed:	5e                   	pop    esi
    a4ee:	0f b6 c0             	movzx  eax,al
    a4f1:	50                   	push   eax
    a4f2:	68 f4 01 00 00       	push   0x1f4
    a4f7:	0f ac ef 10          	shrd   edi,ebp,0x10
    a4fb:	e8 60 0c 00 00       	call   b160 <_Z4outbth>
    a500:	5e                   	pop    esi
    a501:	58                   	pop    eax
    a502:	89 f8                	mov    eax,edi
    a504:	0f b6 f0             	movzx  esi,al
    a507:	56                   	push   esi
    a508:	68 f5 01 00 00       	push   0x1f5
    a50d:	e8 4e 0c 00 00       	call   b160 <_Z4outbth>
    a512:	83 c4 10             	add    esp,0x10
    a515:	8d 76 00             	lea    esi,[esi+0x0]
    a518:	83 ec 0c             	sub    esp,0xc
    a51b:	68 f7 01 00 00       	push   0x1f7
    a520:	e8 8b 0c 00 00       	call   b1b0 <_Z3inbt>
    a525:	83 c4 10             	add    esp,0x10
    a528:	84 c0                	test   al,al
    a52a:	78 ec                	js     a518 <_ZN3ata12lba48PIOReadEPvyth+0xd8>
    a52c:	83 ec 08             	sub    esp,0x8
    a52f:	89 df                	mov    edi,ebx
    a531:	6a 24                	push   0x24
    a533:	68 f7 01 00 00       	push   0x1f7
    a538:	e8 23 0c 00 00       	call   b160 <_Z4outbth>
    a53d:	83 c4 10             	add    esp,0x10
    a540:	81 e7 ff ff 00 00    	and    edi,0xffff
    a546:	0f 84 b2 00 00 00    	je     a5fe <_ZN3ata12lba48PIOReadEPvyth+0x1be>
    a54c:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    a550:	31 f6                	xor    esi,esi
    a552:	05 00 02 00 00       	add    eax,0x200
    a557:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a55b:	90                   	nop
    a55c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a560:	83 ec 0c             	sub    esp,0xc
    a563:	68 f7 01 00 00       	push   0x1f7
    a568:	e8 43 0c 00 00       	call   b1b0 <_Z3inbt>
    a56d:	83 c4 10             	add    esp,0x10
    a570:	84 c0                	test   al,al
    a572:	78 ec                	js     a560 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a574:	83 ec 0c             	sub    esp,0xc
    a577:	68 f6 03 00 00       	push   0x3f6
    a57c:	e8 2f 0c 00 00       	call   b1b0 <_Z3inbt>
    a581:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a588:	e8 23 0c 00 00       	call   b1b0 <_Z3inbt>
    a58d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a594:	e8 17 0c 00 00       	call   b1b0 <_Z3inbt>
    a599:	83 c4 10             	add    esp,0x10
    a59c:	eb 06                	jmp    a5a4 <_ZN3ata12lba48PIOReadEPvyth+0x164>
    a59e:	66 90                	xchg   ax,ax
    a5a0:	a8 08                	test   al,0x8
    a5a2:	75 1e                	jne    a5c2 <_ZN3ata12lba48PIOReadEPvyth+0x182>
    a5a4:	83 ec 0c             	sub    esp,0xc
    a5a7:	68 f7 01 00 00       	push   0x1f7
    a5ac:	e8 ff 0b 00 00       	call   b1b0 <_Z3inbt>
    a5b1:	83 c4 10             	add    esp,0x10
    a5b4:	a8 01                	test   al,0x1
    a5b6:	74 e8                	je     a5a0 <_ZN3ata12lba48PIOReadEPvyth+0x160>
    a5b8:	83 c4 1c             	add    esp,0x1c
    a5bb:	31 c0                	xor    eax,eax
    a5bd:	5b                   	pop    ebx
    a5be:	5e                   	pop    esi
    a5bf:	5f                   	pop    edi
    a5c0:	5d                   	pop    ebp
    a5c1:	c3                   	ret    
    a5c2:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a5c6:	89 f3                	mov    ebx,esi
    a5c8:	c1 e3 09             	shl    ebx,0x9
    a5cb:	01 dd                	add    ebp,ebx
    a5cd:	03 5c 24 0c          	add    ebx,DWORD PTR [esp+0xc]
    a5d1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a5d8:	83 ec 0c             	sub    esp,0xc
    a5db:	83 c5 02             	add    ebp,0x2
    a5de:	68 f0 01 00 00       	push   0x1f0
    a5e3:	e8 d8 0b 00 00       	call   b1c0 <_Z3inwt>
    a5e8:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    a5ec:	83 c4 10             	add    esp,0x10
    a5ef:	39 dd                	cmp    ebp,ebx
    a5f1:	75 e5                	jne    a5d8 <_ZN3ata12lba48PIOReadEPvyth+0x198>
    a5f3:	83 c6 01             	add    esi,0x1
    a5f6:	39 fe                	cmp    esi,edi
    a5f8:	0f 85 62 ff ff ff    	jne    a560 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a5fe:	83 c4 1c             	add    esp,0x1c
    a601:	b8 01 00 00 00       	mov    eax,0x1
    a606:	5b                   	pop    ebx
    a607:	5e                   	pop    esi
    a608:	5f                   	pop    edi
    a609:	5d                   	pop    ebp
    a60a:	c3                   	ret    
    a60b:	90                   	nop
    a60c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000a610 <_ZN3ata9lba48ReadEPvyjh>:
    a610:	55                   	push   ebp
    a611:	57                   	push   edi
    a612:	56                   	push   esi
    a613:	53                   	push   ebx
    a614:	83 ec 1c             	sub    esp,0x1c
    a617:	8b 6c 24 3c          	mov    ebp,DWORD PTR [esp+0x3c]
    a61b:	8b 54 24 30          	mov    edx,DWORD PTR [esp+0x30]
    a61f:	8b 74 24 34          	mov    esi,DWORD PTR [esp+0x34]
    a623:	8b 7c 24 38          	mov    edi,DWORD PTR [esp+0x38]
    a627:	8b 44 24 40          	mov    eax,DWORD PTR [esp+0x40]
    a62b:	85 ed                	test   ebp,ebp
    a62d:	74 69                	je     a698 <_ZN3ata9lba48ReadEPvyjh+0x88>
    a62f:	0f b6 c0             	movzx  eax,al
    a632:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a636:	eb 1c                	jmp    a654 <_ZN3ata9lba48ReadEPvyjh+0x44>
    a638:	90                   	nop
    a639:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a640:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    a644:	03 34 24             	add    esi,DWORD PTR [esp]
    a647:	13 7c 24 04          	adc    edi,DWORD PTR [esp+0x4]
    a64b:	c1 e3 09             	shl    ebx,0x9
    a64e:	01 da                	add    edx,ebx
    a650:	85 ed                	test   ebp,ebp
    a652:	74 44                	je     a698 <_ZN3ata9lba48ReadEPvyjh+0x88>
    a654:	81 fd ff ff 00 00    	cmp    ebp,0xffff
    a65a:	bb ff ff 00 00       	mov    ebx,0xffff
    a65f:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    a666:	00 
    a667:	0f 46 dd             	cmovbe ebx,ebp
    a66a:	83 ec 0c             	sub    esp,0xc
    a66d:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    a671:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    a675:	29 dd                	sub    ebp,ebx
    a677:	53                   	push   ebx
    a678:	57                   	push   edi
    a679:	56                   	push   esi
    a67a:	52                   	push   edx
    a67b:	89 54 24 28          	mov    DWORD PTR [esp+0x28],edx
    a67f:	e8 bc fd ff ff       	call   a440 <_ZN3ata12lba48PIOReadEPvyth>
    a684:	83 c4 20             	add    esp,0x20
    a687:	84 c0                	test   al,al
    a689:	75 b5                	jne    a640 <_ZN3ata9lba48ReadEPvyjh+0x30>
    a68b:	83 c4 1c             	add    esp,0x1c
    a68e:	5b                   	pop    ebx
    a68f:	5e                   	pop    esi
    a690:	5f                   	pop    edi
    a691:	5d                   	pop    ebp
    a692:	c3                   	ret    
    a693:	90                   	nop
    a694:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a698:	83 c4 1c             	add    esp,0x1c
    a69b:	b8 01 00 00 00       	mov    eax,0x1
    a6a0:	5b                   	pop    ebx
    a6a1:	5e                   	pop    esi
    a6a2:	5f                   	pop    edi
    a6a3:	5d                   	pop    ebp
    a6a4:	c3                   	ret    
    a6a5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a6a9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000a6b0 <_ZN3ata12sendIdentifyEhRbb>:
    a6b0:	55                   	push   ebp
    a6b1:	57                   	push   edi
    a6b2:	56                   	push   esi
    a6b3:	53                   	push   ebx
    a6b4:	81 ec 38 02 00 00    	sub    esp,0x238
    a6ba:	8b 9c 24 4c 02 00 00 	mov    ebx,DWORD PTR [esp+0x24c]
    a6c1:	8b ac 24 54 02 00 00 	mov    ebp,DWORD PTR [esp+0x254]
    a6c8:	68 f7 01 00 00       	push   0x1f7
    a6cd:	e8 de 0a 00 00       	call   b1b0 <_Z3inbt>
    a6d2:	83 c4 10             	add    esp,0x10
    a6d5:	3c ff                	cmp    al,0xff
    a6d7:	0f 84 e3 00 00 00    	je     a7c0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a6dd:	c1 e3 04             	shl    ebx,0x4
    a6e0:	83 ec 08             	sub    esp,0x8
    a6e3:	83 cb a0             	or     ebx,0xffffffa0
    a6e6:	0f b6 db             	movzx  ebx,bl
    a6e9:	53                   	push   ebx
    a6ea:	68 f6 01 00 00       	push   0x1f6
    a6ef:	e8 6c 0a 00 00       	call   b160 <_Z4outbth>
    a6f4:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a6fb:	e8 b0 0a 00 00       	call   b1b0 <_Z3inbt>
    a700:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a707:	e8 a4 0a 00 00       	call   b1b0 <_Z3inbt>
    a70c:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a713:	e8 98 0a 00 00       	call   b1b0 <_Z3inbt>
    a718:	83 c4 10             	add    esp,0x10
    a71b:	90                   	nop
    a71c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a720:	83 ec 0c             	sub    esp,0xc
    a723:	68 f7 01 00 00       	push   0x1f7
    a728:	e8 83 0a 00 00       	call   b1b0 <_Z3inbt>
    a72d:	83 c4 10             	add    esp,0x10
    a730:	84 c0                	test   al,al
    a732:	78 ec                	js     a720 <_ZN3ata12sendIdentifyEhRbb+0x70>
    a734:	83 ec 08             	sub    esp,0x8
    a737:	6a 00                	push   0x0
    a739:	68 f2 01 00 00       	push   0x1f2
    a73e:	e8 1d 0a 00 00       	call   b160 <_Z4outbth>
    a743:	59                   	pop    ecx
    a744:	5b                   	pop    ebx
    a745:	6a 00                	push   0x0
    a747:	68 f3 01 00 00       	push   0x1f3
    a74c:	e8 0f 0a 00 00       	call   b160 <_Z4outbth>
    a751:	5e                   	pop    esi
    a752:	5f                   	pop    edi
    a753:	6a 00                	push   0x0
    a755:	68 f4 01 00 00       	push   0x1f4
    a75a:	e8 01 0a 00 00       	call   b160 <_Z4outbth>
    a75f:	58                   	pop    eax
    a760:	5a                   	pop    edx
    a761:	6a 00                	push   0x0
    a763:	68 f5 01 00 00       	push   0x1f5
    a768:	e8 f3 09 00 00       	call   b160 <_Z4outbth>
    a76d:	59                   	pop    ecx
    a76e:	5b                   	pop    ebx
    a76f:	68 ec 00 00 00       	push   0xec
    a774:	68 f7 01 00 00       	push   0x1f7
    a779:	e8 e2 09 00 00       	call   b160 <_Z4outbth>
    a77e:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    a785:	e8 26 0a 00 00       	call   b1b0 <_Z3inbt>
    a78a:	83 c4 10             	add    esp,0x10
    a78d:	84 c0                	test   al,al
    a78f:	74 2f                	je     a7c0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a791:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a798:	83 ec 0c             	sub    esp,0xc
    a79b:	68 f7 01 00 00       	push   0x1f7
    a7a0:	e8 0b 0a 00 00       	call   b1b0 <_Z3inbt>
    a7a5:	83 c4 10             	add    esp,0x10
    a7a8:	84 c0                	test   al,al
    a7aa:	78 ec                	js     a798 <_ZN3ata12sendIdentifyEhRbb+0xe8>
    a7ac:	83 ec 0c             	sub    esp,0xc
    a7af:	68 f4 01 00 00       	push   0x1f4
    a7b4:	e8 f7 09 00 00       	call   b1b0 <_Z3inbt>
    a7b9:	83 c4 10             	add    esp,0x10
    a7bc:	84 c0                	test   al,al
    a7be:	74 10                	je     a7d0 <_ZN3ata12sendIdentifyEhRbb+0x120>
    a7c0:	31 c0                	xor    eax,eax
    a7c2:	81 c4 2c 02 00 00    	add    esp,0x22c
    a7c8:	5b                   	pop    ebx
    a7c9:	5e                   	pop    esi
    a7ca:	5f                   	pop    edi
    a7cb:	5d                   	pop    ebp
    a7cc:	c3                   	ret    
    a7cd:	8d 76 00             	lea    esi,[esi+0x0]
    a7d0:	83 ec 0c             	sub    esp,0xc
    a7d3:	68 f5 01 00 00       	push   0x1f5
    a7d8:	e8 d3 09 00 00       	call   b1b0 <_Z3inbt>
    a7dd:	83 c4 10             	add    esp,0x10
    a7e0:	84 c0                	test   al,al
    a7e2:	74 10                	je     a7f4 <_ZN3ata12sendIdentifyEhRbb+0x144>
    a7e4:	eb da                	jmp    a7c0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a7e6:	8d 76 00             	lea    esi,[esi+0x0]
    a7e9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    a7f0:	a8 08                	test   al,0x8
    a7f2:	75 16                	jne    a80a <_ZN3ata12sendIdentifyEhRbb+0x15a>
    a7f4:	83 ec 0c             	sub    esp,0xc
    a7f7:	68 f7 01 00 00       	push   0x1f7
    a7fc:	e8 af 09 00 00       	call   b1b0 <_Z3inbt>
    a801:	83 c4 10             	add    esp,0x10
    a804:	a8 01                	test   al,0x1
    a806:	74 e8                	je     a7f0 <_ZN3ata12sendIdentifyEhRbb+0x140>
    a808:	eb b6                	jmp    a7c0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a80a:	8d 7c 24 20          	lea    edi,[esp+0x20]
    a80e:	b9 80 00 00 00       	mov    ecx,0x80
    a813:	31 c0                	xor    eax,eax
    a815:	8d b4 24 20 02 00 00 	lea    esi,[esp+0x220]
    a81c:	8d 5c 24 20          	lea    ebx,[esp+0x20]
    a820:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    a822:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a828:	83 ec 0c             	sub    esp,0xc
    a82b:	83 c3 02             	add    ebx,0x2
    a82e:	68 f0 01 00 00       	push   0x1f0
    a833:	e8 88 09 00 00       	call   b1c0 <_Z3inwt>
    a838:	66 89 43 fe          	mov    WORD PTR [ebx-0x2],ax
    a83c:	83 c4 10             	add    esp,0x10
    a83f:	39 de                	cmp    esi,ebx
    a841:	75 e5                	jne    a828 <_ZN3ata12sendIdentifyEhRbb+0x178>
    a843:	89 e8                	mov    eax,ebp
    a845:	0f b7 b4 24 c6 00 00 	movzx  esi,WORD PTR [esp+0xc6]
    a84c:	00 
    a84d:	84 c0                	test   al,al
    a84f:	75 1f                	jne    a870 <_ZN3ata12sendIdentifyEhRbb+0x1c0>
    a851:	89 f0                	mov    eax,esi
    a853:	8b 94 24 44 02 00 00 	mov    edx,DWORD PTR [esp+0x244]
    a85a:	66 c1 e8 0a          	shr    ax,0xa
    a85e:	83 f0 01             	xor    eax,0x1
    a861:	83 e0 01             	and    eax,0x1
    a864:	88 02                	mov    BYTE PTR [edx],al
    a866:	b8 01 00 00 00       	mov    eax,0x1
    a86b:	e9 52 ff ff ff       	jmp    a7c2 <_ZN3ata12sendIdentifyEhRbb+0x112>
    a870:	83 ec 0c             	sub    esp,0xc
    a873:	68 12 d1 00 00       	push   0xd112
    a878:	e8 a3 08 00 00       	call   b120 <_Z6printfPKc>
    a87d:	83 c4 10             	add    esp,0x10
    a880:	8d 7c 24 20          	lea    edi,[esp+0x20]
    a884:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a888:	8d 6f 20             	lea    ebp,[edi+0x20]
    a88b:	90                   	nop
    a88c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a890:	0f b7 07             	movzx  eax,WORD PTR [edi]
    a893:	83 ec 08             	sub    esp,0x8
    a896:	83 c7 02             	add    edi,0x2
    a899:	50                   	push   eax
    a89a:	68 25 d1 00 00       	push   0xd125
    a89f:	e8 dc 18 00 00       	call   c180 <_Z6printfItEvPKcT_>
    a8a4:	83 c4 10             	add    esp,0x10
    a8a7:	39 fd                	cmp    ebp,edi
    a8a9:	75 e5                	jne    a890 <_ZN3ata12sendIdentifyEhRbb+0x1e0>
    a8ab:	83 ec 0c             	sub    esp,0xc
    a8ae:	68 82 d1 00 00       	push   0xd182
    a8b3:	e8 68 08 00 00       	call   b120 <_Z6printfPKc>
    a8b8:	83 c4 10             	add    esp,0x10
    a8bb:	39 dd                	cmp    ebp,ebx
    a8bd:	75 c9                	jne    a888 <_ZN3ata12sendIdentifyEhRbb+0x1d8>
    a8bf:	0f b7 84 24 d0 00 00 	movzx  eax,WORD PTR [esp+0xd0]
    a8c6:	00 
    a8c7:	31 ed                	xor    ebp,ebp
    a8c9:	50                   	push   eax
    a8ca:	0f b7 c6             	movzx  eax,si
    a8cd:	50                   	push   eax
    a8ce:	0f b7 44 24 28       	movzx  eax,WORD PTR [esp+0x28]
    a8d3:	50                   	push   eax
    a8d4:	68 29 d1 00 00       	push   0xd129
    a8d9:	e8 62 19 00 00       	call   c240 <_Z6printfItJttEEvPKcT_DpT0_>
    a8de:	58                   	pop    eax
    a8df:	5a                   	pop    edx
    a8e0:	ff b4 24 a0 00 00 00 	push   DWORD PTR [esp+0xa0]
    a8e7:	68 41 d1 00 00       	push   0xd141
    a8ec:	e8 bf 13 00 00       	call   bcb0 <_Z6printfIiEvPKcT_>
    a8f1:	0f b7 84 24 fc 00 00 	movzx  eax,WORD PTR [esp+0xfc]
    a8f8:	00 
    a8f9:	0f b7 bc 24 fe 00 00 	movzx  edi,WORD PTR [esp+0xfe]
    a900:	00 
    a901:	ba 31 00 00 00       	mov    edx,0x31
    a906:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    a90a:	0f b7 84 24 fa 00 00 	movzx  eax,WORD PTR [esp+0xfa]
    a911:	00 
    a912:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    a916:	0f b7 84 24 f8 00 00 	movzx  eax,WORD PTR [esp+0xf8]
    a91d:	00 
    a91e:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    a923:	83 c4 10             	add    esp,0x10
    a926:	eb 1f                	jmp    a947 <_ZN3ata12sendIdentifyEhRbb+0x297>
    a928:	3c 25                	cmp    al,0x25
    a92a:	0f 84 a9 00 00 00    	je     a9d9 <_ZN3ata12sendIdentifyEhRbb+0x329>
    a930:	84 c0                	test   al,al
    a932:	75 7c                	jne    a9b0 <_ZN3ata12sendIdentifyEhRbb+0x300>
    a934:	8d 5d 02             	lea    ebx,[ebp+0x2]
    a937:	0f b6 83 4e d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd14e]
    a93e:	84 c0                	test   al,al
    a940:	74 33                	je     a975 <_ZN3ata12sendIdentifyEhRbb+0x2c5>
    a942:	0f be d0             	movsx  edx,al
    a945:	89 dd                	mov    ebp,ebx
    a947:	8d 5d 01             	lea    ebx,[ebp+0x1]
    a94a:	80 fa 25             	cmp    dl,0x25
    a94d:	0f b6 83 4e d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd14e]
    a954:	8d 8b 4e d1 00 00    	lea    ecx,[ebx+0xd14e]
    a95a:	74 cc                	je     a928 <_ZN3ata12sendIdentifyEhRbb+0x278>
    a95c:	88 44 24 07          	mov    BYTE PTR [esp+0x7],al
    a960:	83 ec 0c             	sub    esp,0xc
    a963:	52                   	push   edx
    a964:	e8 37 07 00 00       	call   b0a0 <_Z7putcharc>
    a969:	83 c4 10             	add    esp,0x10
    a96c:	0f b6 44 24 07       	movzx  eax,BYTE PTR [esp+0x7]
    a971:	84 c0                	test   al,al
    a973:	75 cd                	jne    a942 <_ZN3ata12sendIdentifyEhRbb+0x292>
    a975:	8d 5c 24 56          	lea    ebx,[esp+0x56]
    a979:	8d 7c 24 7e          	lea    edi,[esp+0x7e]
    a97d:	8d 76 00             	lea    esi,[esi+0x0]
    a980:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    a983:	83 ec 08             	sub    esp,0x8
    a986:	83 c3 01             	add    ebx,0x1
    a989:	50                   	push   eax
    a98a:	68 66 d1 00 00       	push   0xd166
    a98f:	e8 ec 14 00 00       	call   be80 <_Z6printfIcEvPKcT_>
    a994:	83 c4 10             	add    esp,0x10
    a997:	39 df                	cmp    edi,ebx
    a999:	75 e5                	jne    a980 <_ZN3ata12sendIdentifyEhRbb+0x2d0>
    a99b:	83 ec 0c             	sub    esp,0xc
    a99e:	68 82 d1 00 00       	push   0xd182
    a9a3:	e8 78 07 00 00       	call   b120 <_Z6printfPKc>
    a9a8:	83 c4 10             	add    esp,0x10
    a9ab:	e9 a1 fe ff ff       	jmp    a851 <_ZN3ata12sendIdentifyEhRbb+0x1a1>
    a9b0:	83 ec 08             	sub    esp,0x8
    a9b3:	8d 44 24 26          	lea    eax,[esp+0x26]
    a9b7:	50                   	push   eax
    a9b8:	51                   	push   ecx
    a9b9:	e8 b2 16 00 00       	call   c070 <_Z14_manage_escapeItEiPKcPT_>
    a9be:	8d 84 03 4e d1 00 00 	lea    eax,[ebx+eax*1+0xd14e]
    a9c5:	57                   	push   edi
    a9c6:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    a9ca:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    a9ce:	50                   	push   eax
    a9cf:	e8 6c 18 00 00       	call   c240 <_Z6printfItJttEEvPKcT_DpT0_>
    a9d4:	83 c4 20             	add    esp,0x20
    a9d7:	eb 9c                	jmp    a975 <_ZN3ata12sendIdentifyEhRbb+0x2c5>
    a9d9:	83 ec 0c             	sub    esp,0xc
    a9dc:	8d 5d 02             	lea    ebx,[ebp+0x2]
    a9df:	6a 25                	push   0x25
    a9e1:	e8 ba 06 00 00       	call   b0a0 <_Z7putcharc>
    a9e6:	0f b6 83 4e d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd14e]
    a9ed:	83 c4 10             	add    esp,0x10
    a9f0:	84 c0                	test   al,al
    a9f2:	0f 85 4a ff ff ff    	jne    a942 <_ZN3ata12sendIdentifyEhRbb+0x292>
    a9f8:	e9 78 ff ff ff       	jmp    a975 <_ZN3ata12sendIdentifyEhRbb+0x2c5>
    a9fd:	66 90                	xchg   ax,ax
    a9ff:	90                   	nop

0000aa00 <_ZN6paging18init_kernel_pagingEv>:
    aa00:	57                   	push   edi
    aa01:	56                   	push   esi
    aa02:	b8 00 00 10 00       	mov    eax,0x100000
    aa07:	53                   	push   ebx
    aa08:	90                   	nop
    aa09:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    aa10:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    aa16:	83 c0 04             	add    eax,0x4
    aa19:	3d 00 10 10 00       	cmp    eax,0x101000
    aa1e:	75 f0                	jne    aa10 <_ZN6paging18init_kernel_pagingEv+0x10>
    aa20:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    aa26:	83 c0 04             	add    eax,0x4
    aa29:	3d 00 10 50 00       	cmp    eax,0x501000
    aa2e:	75 f0                	jne    aa20 <_ZN6paging18init_kernel_pagingEv+0x20>
    aa30:	c7 05 00 00 10 00 87 	mov    DWORD PTR ds:0x100000,0x87
    aa37:	00 00 00 
    aa3a:	c7 05 04 00 10 00 87 	mov    DWORD PTR ds:0x100004,0x400087
    aa41:	00 40 00 
    aa44:	c7 05 08 0c 10 00 87 	mov    DWORD PTR ds:0x100c08,0x800087
    aa4b:	00 80 00 
    aa4e:	c7 05 0c 0c 10 00 87 	mov    DWORD PTR ds:0x100c0c,0xc00087
    aa55:	00 c0 00 
    aa58:	c7 05 10 0c 10 00 87 	mov    DWORD PTR ds:0x100c10,0x1000087
    aa5f:	00 00 01 
    aa62:	c7 05 14 0c 10 00 87 	mov    DWORD PTR ds:0x100c14,0x1400087
    aa69:	00 40 01 
    aa6c:	c7 05 18 0c 10 00 87 	mov    DWORD PTR ds:0x100c18,0x1800087
    aa73:	00 80 01 
    aa76:	c7 05 1c 0c 10 00 87 	mov    DWORD PTR ds:0x100c1c,0x1c00087
    aa7d:	00 c0 01 
    aa80:	c7 05 20 0c 10 00 87 	mov    DWORD PTR ds:0x100c20,0x2000087
    aa87:	00 00 02 
    aa8a:	c7 05 24 0c 10 00 87 	mov    DWORD PTR ds:0x100c24,0x2400087
    aa91:	00 40 02 
    aa94:	c7 05 28 0c 10 00 87 	mov    DWORD PTR ds:0x100c28,0x2800087
    aa9b:	00 80 02 
    aa9e:	c7 05 2c 0c 10 00 87 	mov    DWORD PTR ds:0x100c2c,0x2c00087
    aaa5:	00 c0 02 
    aaa8:	c7 05 30 0c 10 00 87 	mov    DWORD PTR ds:0x100c30,0x3000087
    aaaf:	00 00 03 
    aab2:	c7 05 34 0c 10 00 87 	mov    DWORD PTR ds:0x100c34,0x3400087
    aab9:	00 40 03 
    aabc:	c7 05 38 0c 10 00 87 	mov    DWORD PTR ds:0x100c38,0x3800087
    aac3:	00 80 03 
    aac6:	c7 05 3c 0c 10 00 87 	mov    DWORD PTR ds:0x100c3c,0x3c00087
    aacd:	00 c0 03 
    aad0:	e8 bb 00 00 00       	call   ab90 <_ZN4boot12get_ram_sizeEv>
    aad5:	89 c3                	mov    ebx,eax
    aad7:	c1 eb 16             	shr    ebx,0x16
    aada:	83 eb 10             	sub    ebx,0x10
    aadd:	d1 eb                	shr    ebx,1
    aadf:	e8 ac 00 00 00       	call   ab90 <_ZN4boot12get_ram_sizeEv>
    aae4:	8d 53 10             	lea    edx,[ebx+0x10]
    aae7:	c1 e8 16             	shr    eax,0x16
    aaea:	b9 10 00 00 00       	mov    ecx,0x10
    aaef:	89 c6                	mov    esi,eax
    aaf1:	c1 e2 0a             	shl    edx,0xa
    aaf4:	83 fb 10             	cmp    ebx,0x10
    aaf7:	76 28                	jbe    ab21 <_ZN6paging18init_kernel_pagingEv+0x121>
    aaf9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ab00:	a1 00 00 00 02       	mov    eax,ds:0x2000000
    ab05:	8d 78 01             	lea    edi,[eax+0x1]
    ab08:	89 3d 00 00 00 02    	mov    DWORD PTR ds:0x2000000,edi
    ab0e:	89 cf                	mov    edi,ecx
    ab10:	83 c1 01             	add    ecx,0x1
    ab13:	c1 e7 16             	shl    edi,0x16
    ab16:	39 cb                	cmp    ebx,ecx
    ab18:	89 3c 85 08 00 00 02 	mov    DWORD PTR [eax*4+0x2000008],edi
    ab1f:	75 df                	jne    ab00 <_ZN6paging18init_kernel_pagingEv+0x100>
    ab21:	39 d6                	cmp    esi,edx
    ab23:	76 2a                	jbe    ab4f <_ZN6paging18init_kernel_pagingEv+0x14f>
    ab25:	c1 e2 0c             	shl    edx,0xc
    ab28:	c1 e6 0c             	shl    esi,0xc
    ab2b:	90                   	nop
    ab2c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ab30:	a1 04 00 00 02       	mov    eax,ds:0x2000004
    ab35:	8d 48 01             	lea    ecx,[eax+0x1]
    ab38:	89 0d 04 00 00 02    	mov    DWORD PTR ds:0x2000004,ecx
    ab3e:	89 14 85 08 10 00 02 	mov    DWORD PTR [eax*4+0x2001008],edx
    ab45:	81 c2 00 10 00 00    	add    edx,0x1000
    ab4b:	39 d6                	cmp    esi,edx
    ab4d:	75 e1                	jne    ab30 <_ZN6paging18init_kernel_pagingEv+0x130>
    ab4f:	83 ec 0c             	sub    esp,0xc
    ab52:	68 00 00 10 00       	push   0x100000
    ab57:	e8 13 f6 ff ff       	call   a16f <__setCR3>
    ab5c:	e8 0a f6 ff ff       	call   a16b <__getCR4>
    ab61:	83 c8 10             	or     eax,0x10
    ab64:	89 04 24             	mov    DWORD PTR [esp],eax
    ab67:	e8 f4 f5 ff ff       	call   a160 <__setCR4>
    ab6c:	e8 27 f6 ff ff       	call   a198 <__getCR0>
    ab71:	0d 01 00 00 80       	or     eax,0x80000001
    ab76:	89 04 24             	mov    DWORD PTR [esp],eax
    ab79:	e8 0f f6 ff ff       	call   a18d <__setCR0>
    ab7e:	83 c4 10             	add    esp,0x10
    ab81:	5b                   	pop    ebx
    ab82:	5e                   	pop    esi
    ab83:	5f                   	pop    edi
    ab84:	c3                   	ret    
    ab85:	66 90                	xchg   ax,ax
    ab87:	66 90                	xchg   ax,ax
    ab89:	66 90                	xchg   ax,ax
    ab8b:	66 90                	xchg   ax,ax
    ab8d:	66 90                	xchg   ax,ax
    ab8f:	90                   	nop

0000ab90 <_ZN4boot12get_ram_sizeEv>:
    ab90:	0f b7 05 02 05 00 00 	movzx  eax,WORD PTR ds:0x502
    ab97:	0f b7 15 00 05 00 00 	movzx  edx,WORD PTR ds:0x500
    ab9e:	c1 e0 06             	shl    eax,0x6
    aba1:	01 d0                	add    eax,edx
    aba3:	c1 e0 0a             	shl    eax,0xa
    aba6:	c3                   	ret    
    aba7:	66 90                	xchg   ax,ax
    aba9:	66 90                	xchg   ax,ax
    abab:	66 90                	xchg   ax,ax
    abad:	66 90                	xchg   ax,ax
    abaf:	90                   	nop

0000abb0 <_ZN3VGA17_actualize_cursorEv>:
    abb0:	53                   	push   ebx
    abb1:	83 ec 10             	sub    esp,0x10
    abb4:	8b 1d 04 00 01 00    	mov    ebx,DWORD PTR ds:0x10004
    abba:	6a 0e                	push   0xe
    abbc:	68 d4 03 00 00       	push   0x3d4
    abc1:	8d 1c 9b             	lea    ebx,[ebx+ebx*4]
    abc4:	c1 e3 04             	shl    ebx,0x4
    abc7:	66 03 1d 00 00 01 00 	add    bx,WORD PTR ds:0x10000
    abce:	e8 8d 05 00 00       	call   b160 <_Z4outbth>
    abd3:	58                   	pop    eax
    abd4:	5a                   	pop    edx
    abd5:	0f b6 c7             	movzx  eax,bh
    abd8:	0f b6 db             	movzx  ebx,bl
    abdb:	50                   	push   eax
    abdc:	68 d5 03 00 00       	push   0x3d5
    abe1:	e8 7a 05 00 00       	call   b160 <_Z4outbth>
    abe6:	59                   	pop    ecx
    abe7:	58                   	pop    eax
    abe8:	6a 0f                	push   0xf
    abea:	68 d4 03 00 00       	push   0x3d4
    abef:	e8 6c 05 00 00       	call   b160 <_Z4outbth>
    abf4:	58                   	pop    eax
    abf5:	5a                   	pop    edx
    abf6:	53                   	push   ebx
    abf7:	68 d5 03 00 00       	push   0x3d5
    abfc:	e8 5f 05 00 00       	call   b160 <_Z4outbth>
    ac01:	83 c4 18             	add    esp,0x18
    ac04:	5b                   	pop    ebx
    ac05:	c3                   	ret    
    ac06:	8d 76 00             	lea    esi,[esi+0x0]
    ac09:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ac10 <_ZN3VGA14_pos_in_screenEii>:
    ac10:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    ac14:	8d 04 80             	lea    eax,[eax+eax*4]
    ac17:	c1 e0 04             	shl    eax,0x4
    ac1a:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    ac1e:	01 c0                	add    eax,eax
    ac20:	c3                   	ret    
    ac21:	eb 0d                	jmp    ac30 <_ZN3VGA12_char_val_atEii>
    ac23:	90                   	nop
    ac24:	90                   	nop
    ac25:	90                   	nop
    ac26:	90                   	nop
    ac27:	90                   	nop
    ac28:	90                   	nop
    ac29:	90                   	nop
    ac2a:	90                   	nop
    ac2b:	90                   	nop
    ac2c:	90                   	nop
    ac2d:	90                   	nop
    ac2e:	90                   	nop
    ac2f:	90                   	nop

0000ac30 <_ZN3VGA12_char_val_atEii>:
    ac30:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    ac34:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ac3a:	8d 04 80             	lea    eax,[eax+eax*4]
    ac3d:	c1 e0 04             	shl    eax,0x4
    ac40:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    ac44:	8d 04 42             	lea    eax,[edx+eax*2]
    ac47:	c3                   	ret    
    ac48:	90                   	nop
    ac49:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000ac50 <_ZN3VGA13_char_mode_atEii>:
    ac50:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    ac54:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ac5a:	8d 04 80             	lea    eax,[eax+eax*4]
    ac5d:	c1 e0 04             	shl    eax,0x4
    ac60:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    ac64:	8d 44 42 01          	lea    eax,[edx+eax*2+0x1]
    ac68:	c3                   	ret    
    ac69:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000ac70 <_ZN3VGA6scrollEc>:
    ac70:	55                   	push   ebp
    ac71:	57                   	push   edi
    ac72:	31 ed                	xor    ebp,ebp
    ac74:	56                   	push   esi
    ac75:	53                   	push   ebx
    ac76:	be 40 01 00 00       	mov    esi,0x140
    ac7b:	bf 50 00 00 00       	mov    edi,0x50
    ac80:	83 ec 1c             	sub    esp,0x1c
    ac83:	0f b6 44 24 30       	movzx  eax,BYTE PTR [esp+0x30]
    ac88:	88 44 24 0f          	mov    BYTE PTR [esp+0xf],al
    ac8c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ac90:	89 e9                	mov    ecx,ebp
    ac92:	8d 04 3f             	lea    eax,[edi+edi*1]
    ac95:	29 f9                	sub    ecx,edi
    ac97:	01 c9                	add    ecx,ecx
    ac99:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    aca0:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    aca6:	0f b6 1c 02          	movzx  ebx,BYTE PTR [edx+eax*1]
    acaa:	01 ca                	add    edx,ecx
    acac:	88 1c 02             	mov    BYTE PTR [edx+eax*1],bl
    acaf:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    acb5:	0f b6 5c 02 01       	movzx  ebx,BYTE PTR [edx+eax*1+0x1]
    acba:	01 ca                	add    edx,ecx
    acbc:	83 c0 02             	add    eax,0x2
    acbf:	88 5c 10 ff          	mov    BYTE PTR [eax+edx*1-0x1],bl
    acc3:	39 f0                	cmp    eax,esi
    acc5:	75 d9                	jne    aca0 <_ZN3VGA6scrollEc+0x30>
    acc7:	83 c7 50             	add    edi,0x50
    acca:	83 c5 50             	add    ebp,0x50
    accd:	8d b0 a0 00 00 00    	lea    esi,[eax+0xa0]
    acd3:	81 ff d0 07 00 00    	cmp    edi,0x7d0
    acd9:	75 b5                	jne    ac90 <_ZN3VGA6scrollEc+0x20>
    acdb:	0f b6 4c 24 0f       	movzx  ecx,BYTE PTR [esp+0xf]
    ace0:	b8 00 0f 00 00       	mov    eax,0xf00
    ace5:	8d 76 00             	lea    esi,[esi+0x0]
    ace8:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    acee:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    acf2:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    acf8:	88 4c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],cl
    acfc:	83 c0 02             	add    eax,0x2
    acff:	3d a0 0f 00 00       	cmp    eax,0xfa0
    ad04:	75 e2                	jne    ace8 <_ZN3VGA6scrollEc+0x78>
    ad06:	a1 04 00 01 00       	mov    eax,ds:0x10004
    ad0b:	ba 00 00 00 00       	mov    edx,0x0
    ad10:	83 e8 01             	sub    eax,0x1
    ad13:	0f 48 c2             	cmovs  eax,edx
    ad16:	a3 04 00 01 00       	mov    ds:0x10004,eax
    ad1b:	83 c4 1c             	add    esp,0x1c
    ad1e:	5b                   	pop    ebx
    ad1f:	5e                   	pop    esi
    ad20:	5f                   	pop    edi
    ad21:	5d                   	pop    ebp
    ad22:	e9 89 fe ff ff       	jmp    abb0 <_ZN3VGA17_actualize_cursorEv>
    ad27:	89 f6                	mov    esi,esi
    ad29:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ad30 <_ZN3VGA12clear_screenEc>:
    ad30:	53                   	push   ebx
    ad31:	0f b6 5c 24 08       	movzx  ebx,BYTE PTR [esp+0x8]
    ad36:	31 c0                	xor    eax,eax
    ad38:	90                   	nop
    ad39:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ad40:	8d 88 a0 00 00 00    	lea    ecx,[eax+0xa0]
    ad46:	8d 76 00             	lea    esi,[esi+0x0]
    ad49:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ad50:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad56:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    ad5a:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad60:	88 5c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],bl
    ad64:	83 c0 02             	add    eax,0x2
    ad67:	39 c1                	cmp    ecx,eax
    ad69:	75 e5                	jne    ad50 <_ZN3VGA12clear_screenEc+0x20>
    ad6b:	81 f9 a0 0f 00 00    	cmp    ecx,0xfa0
    ad71:	75 cd                	jne    ad40 <_ZN3VGA12clear_screenEc+0x10>
    ad73:	5b                   	pop    ebx
    ad74:	c7 05 04 00 01 00 00 	mov    DWORD PTR ds:0x10004,0x0
    ad7b:	00 00 00 
    ad7e:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ad85:	00 00 00 
    ad88:	e9 23 fe ff ff       	jmp    abb0 <_ZN3VGA17_actualize_cursorEv>
    ad8d:	8d 76 00             	lea    esi,[esi+0x0]

0000ad90 <_ZN3VGA7putcharEcc>:
    ad90:	55                   	push   ebp
    ad91:	57                   	push   edi
    ad92:	56                   	push   esi
    ad93:	53                   	push   ebx
    ad94:	83 ec 1c             	sub    esp,0x1c
    ad97:	8b 3d 04 00 01 00    	mov    edi,DWORD PTR ds:0x10004
    ad9d:	8b 5c 24 30          	mov    ebx,DWORD PTR [esp+0x30]
    ada1:	8b 4c 24 34          	mov    ecx,DWORD PTR [esp+0x34]
    ada5:	80 fb 0a             	cmp    bl,0xa
    ada8:	0f 84 d2 00 00 00    	je     ae80 <_ZN3VGA7putcharEcc+0xf0>
    adae:	80 fb 09             	cmp    bl,0x9
    adb1:	0f 85 99 00 00 00    	jne    ae50 <_ZN3VGA7putcharEcc+0xc0>
    adb7:	a1 00 00 01 00       	mov    eax,ds:0x10000
    adbc:	31 f6                	xor    esi,esi
    adbe:	8d 50 04             	lea    edx,[eax+0x4]
    adc1:	83 e2 fc             	and    edx,0xfffffffc
    adc4:	83 fa 4f             	cmp    edx,0x4f
    adc7:	89 15 00 00 01 00    	mov    DWORD PTR ds:0x10000,edx
    adcd:	0f 8e 15 01 00 00    	jle    aee8 <_ZN3VGA7putcharEcc+0x158>
    add3:	bd cd cc cc cc       	mov    ebp,0xcccccccd
    add8:	89 d0                	mov    eax,edx
    adda:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ade1:	00 00 00 
    ade4:	f7 e5                	mul    ebp
    ade6:	c1 ea 06             	shr    edx,0x6
    ade9:	01 fa                	add    edx,edi
    adeb:	83 fa 18             	cmp    edx,0x18
    adee:	89 15 04 00 01 00    	mov    DWORD PTR ds:0x10004,edx
    adf4:	0f 8f ce 00 00 00    	jg     aec8 <_ZN3VGA7putcharEcc+0x138>
    adfa:	89 f0                	mov    eax,esi
    adfc:	84 c0                	test   al,al
    adfe:	74 3f                	je     ae3f <_ZN3VGA7putcharEcc+0xaf>
    ae00:	8b 3d 04 00 01 00    	mov    edi,DWORD PTR ds:0x10004
    ae06:	8b 2d 00 00 01 00    	mov    ebp,DWORD PTR ds:0x10000
    ae0c:	8d 04 bf             	lea    eax,[edi+edi*4]
    ae0f:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ae15:	c1 e0 04             	shl    eax,0x4
    ae18:	01 e8                	add    eax,ebp
    ae1a:	88 1c 42             	mov    BYTE PTR [edx+eax*2],bl
    ae1d:	a1 04 00 01 00       	mov    eax,ds:0x10004
    ae22:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ae28:	8d 04 80             	lea    eax,[eax+eax*4]
    ae2b:	c1 e0 04             	shl    eax,0x4
    ae2e:	03 05 00 00 01 00    	add    eax,DWORD PTR ds:0x10000
    ae34:	88 4c 42 01          	mov    BYTE PTR [edx+eax*2+0x1],cl
    ae38:	83 05 00 00 01 00 01 	add    DWORD PTR ds:0x10000,0x1
    ae3f:	83 c4 1c             	add    esp,0x1c
    ae42:	5b                   	pop    ebx
    ae43:	5e                   	pop    esi
    ae44:	5f                   	pop    edi
    ae45:	5d                   	pop    ebp
    ae46:	e9 65 fd ff ff       	jmp    abb0 <_ZN3VGA17_actualize_cursorEv>
    ae4b:	90                   	nop
    ae4c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ae50:	80 fb 0d             	cmp    bl,0xd
    ae53:	75 4f                	jne    aea4 <_ZN3VGA7putcharEcc+0x114>
    ae55:	83 ff 18             	cmp    edi,0x18
    ae58:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ae5f:	00 00 00 
    ae62:	7e db                	jle    ae3f <_ZN3VGA7putcharEcc+0xaf>
    ae64:	83 ec 0c             	sub    esp,0xc
    ae67:	0f be c9             	movsx  ecx,cl
    ae6a:	51                   	push   ecx
    ae6b:	e8 00 fe ff ff       	call   ac70 <_ZN3VGA6scrollEc>
    ae70:	83 c4 10             	add    esp,0x10
    ae73:	83 c4 1c             	add    esp,0x1c
    ae76:	5b                   	pop    ebx
    ae77:	5e                   	pop    esi
    ae78:	5f                   	pop    edi
    ae79:	5d                   	pop    ebp
    ae7a:	e9 31 fd ff ff       	jmp    abb0 <_ZN3VGA17_actualize_cursorEv>
    ae7f:	90                   	nop
    ae80:	8d 57 01             	lea    edx,[edi+0x1]
    ae83:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ae8a:	00 00 00 
    ae8d:	83 fa 18             	cmp    edx,0x18
    ae90:	89 15 04 00 01 00    	mov    DWORD PTR ds:0x10004,edx
    ae96:	7f cc                	jg     ae64 <_ZN3VGA7putcharEcc+0xd4>
    ae98:	83 c4 1c             	add    esp,0x1c
    ae9b:	5b                   	pop    ebx
    ae9c:	5e                   	pop    esi
    ae9d:	5f                   	pop    edi
    ae9e:	5d                   	pop    ebp
    ae9f:	e9 0c fd ff ff       	jmp    abb0 <_ZN3VGA17_actualize_cursorEv>
    aea4:	8b 2d 00 00 01 00    	mov    ebp,DWORD PTR ds:0x10000
    aeaa:	be 01 00 00 00       	mov    esi,0x1
    aeaf:	83 fd 4f             	cmp    ebp,0x4f
    aeb2:	89 ea                	mov    edx,ebp
    aeb4:	0f 8f 19 ff ff ff    	jg     add3 <_ZN3VGA7putcharEcc+0x43>
    aeba:	83 ff 18             	cmp    edi,0x18
    aebd:	0f 8e 49 ff ff ff    	jle    ae0c <_ZN3VGA7putcharEcc+0x7c>
    aec3:	90                   	nop
    aec4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    aec8:	83 ec 0c             	sub    esp,0xc
    aecb:	0f be c1             	movsx  eax,cl
    aece:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    aed2:	50                   	push   eax
    aed3:	e8 98 fd ff ff       	call   ac70 <_ZN3VGA6scrollEc>
    aed8:	83 c4 10             	add    esp,0x10
    aedb:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    aedf:	e9 16 ff ff ff       	jmp    adfa <_ZN3VGA7putcharEcc+0x6a>
    aee4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    aee8:	83 ff 18             	cmp    edi,0x18
    aeeb:	0f 8e 4e ff ff ff    	jle    ae3f <_ZN3VGA7putcharEcc+0xaf>
    aef1:	eb d5                	jmp    aec8 <_ZN3VGA7putcharEcc+0x138>
    aef3:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    aef9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000af00 <_ZN3VGA5printEPKcc>:
    af00:	56                   	push   esi
    af01:	53                   	push   ebx
    af02:	83 ec 04             	sub    esp,0x4
    af05:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    af09:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    af0d:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    af10:	84 c0                	test   al,al
    af12:	74 24                	je     af38 <_ZN3VGA5printEPKcc+0x38>
    af14:	0f be f2             	movsx  esi,dl
    af17:	83 c3 01             	add    ebx,0x1
    af1a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    af20:	83 ec 08             	sub    esp,0x8
    af23:	83 c3 01             	add    ebx,0x1
    af26:	56                   	push   esi
    af27:	50                   	push   eax
    af28:	e8 63 fe ff ff       	call   ad90 <_ZN3VGA7putcharEcc>
    af2d:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    af31:	83 c4 10             	add    esp,0x10
    af34:	84 c0                	test   al,al
    af36:	75 e8                	jne    af20 <_ZN3VGA5printEPKcc+0x20>
    af38:	83 c4 04             	add    esp,0x4
    af3b:	5b                   	pop    ebx
    af3c:	5e                   	pop    esi
    af3d:	c3                   	ret    
    af3e:	66 90                	xchg   ax,ax

0000af40 <_ZN3VGA17_put_nbr_base_recEii>:
    af40:	53                   	push   ebx
    af41:	83 ec 08             	sub    esp,0x8
    af44:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    af48:	8b 4c 24 14          	mov    ecx,DWORD PTR [esp+0x14]
    af4c:	85 c0                	test   eax,eax
    af4e:	75 08                	jne    af58 <_ZN3VGA17_put_nbr_base_recEii+0x18>
    af50:	83 c4 08             	add    esp,0x8
    af53:	5b                   	pop    ebx
    af54:	c3                   	ret    
    af55:	8d 76 00             	lea    esi,[esi+0x0]
    af58:	99                   	cdq    
    af59:	83 ec 08             	sub    esp,0x8
    af5c:	f7 f9                	idiv   ecx
    af5e:	51                   	push   ecx
    af5f:	50                   	push   eax
    af60:	89 d3                	mov    ebx,edx
    af62:	e8 d9 ff ff ff       	call   af40 <_ZN3VGA17_put_nbr_base_recEii>
    af67:	0f be 83 00 f0 00 00 	movsx  eax,BYTE PTR [ebx+0xf000]
    af6e:	c7 44 24 24 0f 00 00 	mov    DWORD PTR [esp+0x24],0xf
    af75:	00 
    af76:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    af7a:	83 c4 18             	add    esp,0x18
    af7d:	5b                   	pop    ebx
    af7e:	e9 0d fe ff ff       	jmp    ad90 <_ZN3VGA7putcharEcc>
    af83:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    af89:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000af90 <_ZN3VGA13_put_nbr_baseEii>:
    af90:	56                   	push   esi
    af91:	53                   	push   ebx
    af92:	83 ec 14             	sub    esp,0x14
    af95:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    af99:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    af9d:	85 c0                	test   eax,eax
    af9f:	78 4f                	js     aff0 <_ZN3VGA13_put_nbr_baseEii+0x60>
    afa1:	74 2d                	je     afd0 <_ZN3VGA13_put_nbr_baseEii+0x40>
    afa3:	99                   	cdq    
    afa4:	83 ec 08             	sub    esp,0x8
    afa7:	f7 fb                	idiv   ebx
    afa9:	53                   	push   ebx
    afaa:	50                   	push   eax
    afab:	89 d6                	mov    esi,edx
    afad:	e8 8e ff ff ff       	call   af40 <_ZN3VGA17_put_nbr_base_recEii>
    afb2:	0f be 86 00 f0 00 00 	movsx  eax,BYTE PTR [esi+0xf000]
    afb9:	c7 44 24 34 0f 00 00 	mov    DWORD PTR [esp+0x34],0xf
    afc0:	00 
    afc1:	89 44 24 30          	mov    DWORD PTR [esp+0x30],eax
    afc5:	83 c4 24             	add    esp,0x24
    afc8:	5b                   	pop    ebx
    afc9:	5e                   	pop    esi
    afca:	e9 c1 fd ff ff       	jmp    ad90 <_ZN3VGA7putcharEcc>
    afcf:	90                   	nop
    afd0:	0f be 05 00 f0 00 00 	movsx  eax,BYTE PTR ds:0xf000
    afd7:	c7 44 24 24 0f 00 00 	mov    DWORD PTR [esp+0x24],0xf
    afde:	00 
    afdf:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    afe3:	83 c4 14             	add    esp,0x14
    afe6:	5b                   	pop    ebx
    afe7:	5e                   	pop    esi
    afe8:	e9 a3 fd ff ff       	jmp    ad90 <_ZN3VGA7putcharEcc>
    afed:	8d 76 00             	lea    esi,[esi+0x0]
    aff0:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    aff4:	83 ec 08             	sub    esp,0x8
    aff7:	6a 0f                	push   0xf
    aff9:	6a 2d                	push   0x2d
    affb:	e8 90 fd ff ff       	call   ad90 <_ZN3VGA7putcharEcc>
    b000:	83 c4 10             	add    esp,0x10
    b003:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b007:	eb 9a                	jmp    afa3 <_ZN3VGA13_put_nbr_baseEii+0x13>
    b009:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b010 <_ZN3VGA6putHexEi>:
    b010:	83 ec 14             	sub    esp,0x14
    b013:	6a 10                	push   0x10
    b015:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b019:	e8 72 ff ff ff       	call   af90 <_ZN3VGA13_put_nbr_baseEii>
    b01e:	83 c4 1c             	add    esp,0x1c
    b021:	c3                   	ret    
    b022:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b029:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b030 <_ZN3VGA6putDecEi>:
    b030:	83 ec 14             	sub    esp,0x14
    b033:	6a 0a                	push   0xa
    b035:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b039:	e8 52 ff ff ff       	call   af90 <_ZN3VGA13_put_nbr_baseEii>
    b03e:	83 c4 1c             	add    esp,0x1c
    b041:	c3                   	ret    
    b042:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b049:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b050 <_ZN3VGA6putOctEi>:
    b050:	83 ec 14             	sub    esp,0x14
    b053:	6a 08                	push   0x8
    b055:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b059:	e8 32 ff ff ff       	call   af90 <_ZN3VGA13_put_nbr_baseEii>
    b05e:	83 c4 1c             	add    esp,0x1c
    b061:	c3                   	ret    
    b062:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b069:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b070 <_ZN3VGA6putBinEi>:
    b070:	83 ec 14             	sub    esp,0x14
    b073:	6a 02                	push   0x2
    b075:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b079:	e8 12 ff ff ff       	call   af90 <_ZN3VGA13_put_nbr_baseEii>
    b07e:	83 c4 1c             	add    esp,0x1c
    b081:	c3                   	ret    
    b082:	66 90                	xchg   ax,ax
    b084:	66 90                	xchg   ax,ax
    b086:	66 90                	xchg   ax,ax
    b088:	66 90                	xchg   ax,ax
    b08a:	66 90                	xchg   ax,ax
    b08c:	66 90                	xchg   ax,ax
    b08e:	66 90                	xchg   ax,ax

0000b090 <_Z12clear_screenv>:
    b090:	83 ec 18             	sub    esp,0x18
    b093:	6a 0f                	push   0xf
    b095:	e8 96 fc ff ff       	call   ad30 <_ZN3VGA12clear_screenEc>
    b09a:	83 c4 1c             	add    esp,0x1c
    b09d:	c3                   	ret    
    b09e:	66 90                	xchg   ax,ax

0000b0a0 <_Z7putcharc>:
    b0a0:	83 ec 14             	sub    esp,0x14
    b0a3:	6a 0f                	push   0xf
    b0a5:	0f be 44 24 1c       	movsx  eax,BYTE PTR [esp+0x1c]
    b0aa:	50                   	push   eax
    b0ab:	e8 e0 fc ff ff       	call   ad90 <_ZN3VGA7putcharEcc>
    b0b0:	83 c4 1c             	add    esp,0x1c
    b0b3:	c3                   	ret    
    b0b4:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b0ba:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000b0c0 <_Z6putdeci>:
    b0c0:	e9 6b ff ff ff       	jmp    b030 <_ZN3VGA6putDecEi>
    b0c5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b0c9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b0d0 <_Z6puthexi>:
    b0d0:	e9 3b ff ff ff       	jmp    b010 <_ZN3VGA6putHexEi>
    b0d5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b0d9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b0e0 <_Z6putocti>:
    b0e0:	e9 6b ff ff ff       	jmp    b050 <_ZN3VGA6putOctEi>
    b0e5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b0e9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b0f0 <_Z6putbini>:
    b0f0:	e9 7b ff ff ff       	jmp    b070 <_ZN3VGA6putBinEi>
    b0f5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b0f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b100 <_Z6putstrPc>:
    b100:	83 ec 14             	sub    esp,0x14
    b103:	6a 0f                	push   0xf
    b105:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b109:	e8 f2 fd ff ff       	call   af00 <_ZN3VGA5printEPKcc>
    b10e:	83 c4 1c             	add    esp,0x1c
    b111:	c3                   	ret    
    b112:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b119:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b120 <_Z6printfPKc>:
    b120:	53                   	push   ebx
    b121:	83 ec 08             	sub    esp,0x8
    b124:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    b128:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    b12b:	84 c0                	test   al,al
    b12d:	74 22                	je     b151 <_Z6printfPKc+0x31>
    b12f:	83 c3 01             	add    ebx,0x1
    b132:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b138:	83 ec 08             	sub    esp,0x8
    b13b:	83 c3 01             	add    ebx,0x1
    b13e:	6a 0f                	push   0xf
    b140:	50                   	push   eax
    b141:	e8 4a fc ff ff       	call   ad90 <_ZN3VGA7putcharEcc>
    b146:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    b14a:	83 c4 10             	add    esp,0x10
    b14d:	84 c0                	test   al,al
    b14f:	75 e7                	jne    b138 <_Z6printfPKc+0x18>
    b151:	83 c4 08             	add    esp,0x8
    b154:	5b                   	pop    ebx
    b155:	c3                   	ret    
    b156:	66 90                	xchg   ax,ax
    b158:	66 90                	xchg   ax,ax
    b15a:	66 90                	xchg   ax,ax
    b15c:	66 90                	xchg   ax,ax
    b15e:	66 90                	xchg   ax,ax

0000b160 <_Z4outbth>:
    b160:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b164:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b168:	ee                   	out    dx,al
    b169:	c3                   	ret    
    b16a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b170 <_Z4outwtt>:
    b170:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b174:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b178:	66 ef                	out    dx,ax
    b17a:	c3                   	ret    
    b17b:	90                   	nop
    b17c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000b180 <_Z4outdtj>:
    b180:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b184:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b188:	ef                   	out    dx,eax
    b189:	c3                   	ret    
    b18a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b190 <_Z4inwstjj>:
    b190:	57                   	push   edi
    b191:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    b195:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    b199:	8b 7c 24 0c          	mov    edi,DWORD PTR [esp+0xc]
    b19d:	fc                   	cld    
    b19e:	f3 6d                	rep ins DWORD PTR es:[edi],dx
    b1a0:	5f                   	pop    edi
    b1a1:	c3                   	ret    
    b1a2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b1a9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b1b0 <_Z3inbt>:
    b1b0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b1b4:	ec                   	in     al,dx
    b1b5:	c3                   	ret    
    b1b6:	8d 76 00             	lea    esi,[esi+0x0]
    b1b9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b1c0 <_Z3inwt>:
    b1c0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b1c4:	66 ed                	in     ax,dx
    b1c6:	c3                   	ret    
    b1c7:	89 f6                	mov    esi,esi
    b1c9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b1d0 <_Z3indt>:
    b1d0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b1d4:	ed                   	in     eax,dx
    b1d5:	c3                   	ret    
    b1d6:	8d 76 00             	lea    esi,[esi+0x0]
    b1d9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b1e0 <_Z7io_waitv>:
    b1e0:	31 c0                	xor    eax,eax
    b1e2:	e6 80                	out    0x80,al
    b1e4:	c3                   	ret    
    b1e5:	66 90                	xchg   ax,ax
    b1e7:	66 90                	xchg   ax,ax
    b1e9:	66 90                	xchg   ax,ax
    b1eb:	66 90                	xchg   ax,ax
    b1ed:	66 90                	xchg   ax,ax
    b1ef:	90                   	nop

0000b1f0 <_ZN3pci13configAddressEhhhh>:
    b1f0:	0f b6 44 24 10       	movzx  eax,BYTE PTR [esp+0x10]
    b1f5:	0f b6 54 24 0c       	movzx  edx,BYTE PTR [esp+0xc]
    b1fa:	c1 e0 02             	shl    eax,0x2
    b1fd:	c1 e2 08             	shl    edx,0x8
    b200:	0f b6 c0             	movzx  eax,al
    b203:	09 d0                	or     eax,edx
    b205:	0f b6 54 24 08       	movzx  edx,BYTE PTR [esp+0x8]
    b20a:	c1 e2 0b             	shl    edx,0xb
    b20d:	09 d0                	or     eax,edx
    b20f:	0f b6 54 24 04       	movzx  edx,BYTE PTR [esp+0x4]
    b214:	c1 e2 10             	shl    edx,0x10
    b217:	09 d0                	or     eax,edx
    b219:	0d 00 00 00 80       	or     eax,0x80000000
    b21e:	c3                   	ret    
    b21f:	90                   	nop

0000b220 <_ZN3pci14configReadByteEhhhhh>:
    b220:	53                   	push   ebx
    b221:	83 ec 10             	sub    esp,0x10
    b224:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b229:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b22e:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    b232:	c1 e2 0b             	shl    edx,0xb
    b235:	c1 e0 10             	shl    eax,0x10
    b238:	09 d0                	or     eax,edx
    b23a:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b23f:	c1 e2 08             	shl    edx,0x8
    b242:	09 d0                	or     eax,edx
    b244:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b249:	c1 e2 02             	shl    edx,0x2
    b24c:	0f b6 d2             	movzx  edx,dl
    b24f:	09 d0                	or     eax,edx
    b251:	0d 00 00 00 80       	or     eax,0x80000000
    b256:	50                   	push   eax
    b257:	68 f8 0c 00 00       	push   0xcf8
    b25c:	e8 1f ff ff ff       	call   b180 <_Z4outdtj>
    b261:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    b268:	e8 63 ff ff ff       	call   b1d0 <_Z3indt>
    b26d:	0f b6 cb             	movzx  ecx,bl
    b270:	83 c4 18             	add    esp,0x18
    b273:	c1 e1 03             	shl    ecx,0x3
    b276:	d3 e8                	shr    eax,cl
    b278:	5b                   	pop    ebx
    b279:	c3                   	ret    
    b27a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b280 <_ZN3pci14configReadWordEhhhhh>:
    b280:	53                   	push   ebx
    b281:	83 ec 10             	sub    esp,0x10
    b284:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b289:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b28e:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    b292:	c1 e2 0b             	shl    edx,0xb
    b295:	c1 e0 10             	shl    eax,0x10
    b298:	09 d0                	or     eax,edx
    b29a:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b29f:	c1 e2 08             	shl    edx,0x8
    b2a2:	09 d0                	or     eax,edx
    b2a4:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b2a9:	c1 e2 02             	shl    edx,0x2
    b2ac:	0f b6 d2             	movzx  edx,dl
    b2af:	09 d0                	or     eax,edx
    b2b1:	0d 00 00 00 80       	or     eax,0x80000000
    b2b6:	50                   	push   eax
    b2b7:	68 f8 0c 00 00       	push   0xcf8
    b2bc:	e8 bf fe ff ff       	call   b180 <_Z4outdtj>
    b2c1:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    b2c8:	e8 03 ff ff ff       	call   b1d0 <_Z3indt>
    b2cd:	0f b6 cb             	movzx  ecx,bl
    b2d0:	83 c4 18             	add    esp,0x18
    b2d3:	c1 e1 04             	shl    ecx,0x4
    b2d6:	d3 e8                	shr    eax,cl
    b2d8:	5b                   	pop    ebx
    b2d9:	c3                   	ret    
    b2da:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b2e0 <_ZN3pci10configReadEhhhh>:
    b2e0:	83 ec 14             	sub    esp,0x14
    b2e3:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b2e8:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b2ed:	c1 e0 10             	shl    eax,0x10
    b2f0:	c1 e2 0b             	shl    edx,0xb
    b2f3:	09 d0                	or     eax,edx
    b2f5:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b2fa:	c1 e2 08             	shl    edx,0x8
    b2fd:	09 d0                	or     eax,edx
    b2ff:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b304:	c1 e2 02             	shl    edx,0x2
    b307:	0f b6 d2             	movzx  edx,dl
    b30a:	09 d0                	or     eax,edx
    b30c:	0d 00 00 00 80       	or     eax,0x80000000
    b311:	50                   	push   eax
    b312:	68 f8 0c 00 00       	push   0xcf8
    b317:	e8 64 fe ff ff       	call   b180 <_Z4outdtj>
    b31c:	c7 44 24 20 fc 0c 00 	mov    DWORD PTR [esp+0x20],0xcfc
    b323:	00 
    b324:	83 c4 1c             	add    esp,0x1c
    b327:	e9 a4 fe ff ff       	jmp    b1d0 <_Z3indt>
    b32c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000b330 <_ZN3pci11checkDeviceEhhh>:
    b330:	83 ec 18             	sub    esp,0x18
    b333:	6a 00                	push   0x0
    b335:	6a 00                	push   0x0
    b337:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b33c:	50                   	push   eax
    b33d:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b342:	50                   	push   eax
    b343:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b348:	50                   	push   eax
    b349:	e8 32 ff ff ff       	call   b280 <_ZN3pci14configReadWordEhhhhh>
    b34e:	66 83 f8 ff          	cmp    ax,0xffff
    b352:	0f 95 c0             	setne  al
    b355:	83 c4 2c             	add    esp,0x2c
    b358:	c3                   	ret    
    b359:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b360 <_ZN3pci11printBussesEv>:
    b360:	55                   	push   ebp
    b361:	57                   	push   edi
    b362:	56                   	push   esi
    b363:	53                   	push   ebx
    b364:	83 ec 4c             	sub    esp,0x4c
    b367:	c7 44 24 10 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    b36e:	00 
    b36f:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    b376:	00 
    b377:	89 f6                	mov    esi,esi
    b379:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b380:	31 f6                	xor    esi,esi
    b382:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b388:	83 ec 0c             	sub    esp,0xc
    b38b:	6a 00                	push   0x0
    b38d:	6a 00                	push   0x0
    b38f:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    b393:	53                   	push   ebx
    b394:	56                   	push   esi
    b395:	8b 7c 24 28          	mov    edi,DWORD PTR [esp+0x28]
    b399:	57                   	push   edi
    b39a:	e8 e1 fe ff ff       	call   b280 <_ZN3pci14configReadWordEhhhhh>
    b39f:	83 c4 20             	add    esp,0x20
    b3a2:	66 83 f8 ff          	cmp    ax,0xffff
    b3a6:	0f 84 6c 01 00 00    	je     b518 <_ZN3pci11printBussesEv+0x1b8>
    b3ac:	83 ec 0c             	sub    esp,0xc
    b3af:	6a 00                	push   0x0
    b3b1:	6a 02                	push   0x2
    b3b3:	53                   	push   ebx
    b3b4:	56                   	push   esi
    b3b5:	57                   	push   edi
    b3b6:	e8 65 fe ff ff       	call   b220 <_ZN3pci14configReadByteEhhhhh>
    b3bb:	88 44 24 38          	mov    BYTE PTR [esp+0x38],al
    b3bf:	83 c4 14             	add    esp,0x14
    b3c2:	6a 01                	push   0x1
    b3c4:	6a 02                	push   0x2
    b3c6:	53                   	push   ebx
    b3c7:	56                   	push   esi
    b3c8:	57                   	push   edi
    b3c9:	e8 52 fe ff ff       	call   b220 <_ZN3pci14configReadByteEhhhhh>
    b3ce:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    b3d2:	83 c4 14             	add    esp,0x14
    b3d5:	6a 02                	push   0x2
    b3d7:	6a 02                	push   0x2
    b3d9:	53                   	push   ebx
    b3da:	56                   	push   esi
    b3db:	57                   	push   edi
    b3dc:	e8 3f fe ff ff       	call   b220 <_ZN3pci14configReadByteEhhhhh>
    b3e1:	83 c4 14             	add    esp,0x14
    b3e4:	89 c5                	mov    ebp,eax
    b3e6:	6a 03                	push   0x3
    b3e8:	6a 02                	push   0x2
    b3ea:	53                   	push   ebx
    b3eb:	56                   	push   esi
    b3ec:	57                   	push   edi
    b3ed:	31 ff                	xor    edi,edi
    b3ef:	e8 2c fe ff ff       	call   b220 <_ZN3pci14configReadByteEhhhhh>
    b3f4:	ba 43 00 00 00       	mov    edx,0x43
    b3f9:	88 44 24 4f          	mov    BYTE PTR [esp+0x4f],al
    b3fd:	83 c4 20             	add    esp,0x20
    b400:	eb 29                	jmp    b42b <_ZN3pci11printBussesEv+0xcb>
    b402:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b408:	3c 25                	cmp    al,0x25
    b40a:	0f 84 90 03 00 00    	je     b7a0 <_ZN3pci11printBussesEv+0x440>
    b410:	84 c0                	test   al,al
    b412:	0f 85 d8 01 00 00    	jne    b5f0 <_ZN3pci11printBussesEv+0x290>
    b418:	8d 5f 02             	lea    ebx,[edi+0x2]
    b41b:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b422:	84 c0                	test   al,al
    b424:	74 3a                	je     b460 <_ZN3pci11printBussesEv+0x100>
    b426:	0f be d0             	movsx  edx,al
    b429:	89 df                	mov    edi,ebx
    b42b:	8d 5f 01             	lea    ebx,[edi+0x1]
    b42e:	80 fa 25             	cmp    dl,0x25
    b431:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b438:	8d 8b a8 d1 00 00    	lea    ecx,[ebx+0xd1a8]
    b43e:	74 c8                	je     b408 <_ZN3pci11printBussesEv+0xa8>
    b440:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    b444:	83 ec 0c             	sub    esp,0xc
    b447:	52                   	push   edx
    b448:	e8 53 fc ff ff       	call   b0a0 <_Z7putcharc>
    b44d:	83 c4 10             	add    esp,0x10
    b450:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    b455:	84 c0                	test   al,al
    b457:	75 cd                	jne    b426 <_ZN3pci11printBussesEv+0xc6>
    b459:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b460:	6a 04                	push   0x4
    b462:	8b 6c 24 14          	mov    ebp,DWORD PTR [esp+0x14]
    b466:	55                   	push   ebp
    b467:	56                   	push   esi
    b468:	8b 5c 24 18          	mov    ebx,DWORD PTR [esp+0x18]
    b46c:	53                   	push   ebx
    b46d:	e8 6e fe ff ff       	call   b2e0 <_ZN3pci10configReadEhhhh>
    b472:	c7 04 24 03 00 00 00 	mov    DWORD PTR [esp],0x3
    b479:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    b47d:	6a 03                	push   0x3
    b47f:	55                   	push   ebp
    b480:	56                   	push   esi
    b481:	53                   	push   ebx
    b482:	e8 99 fd ff ff       	call   b220 <_ZN3pci14configReadByteEhhhhh>
    b487:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    b48b:	83 c4 14             	add    esp,0x14
    b48e:	6a 01                	push   0x1
    b490:	6a 00                	push   0x0
    b492:	55                   	push   ebp
    b493:	56                   	push   esi
    b494:	53                   	push   ebx
    b495:	e8 e6 fd ff ff       	call   b280 <_ZN3pci14configReadWordEhhhhh>
    b49a:	83 c4 14             	add    esp,0x14
    b49d:	89 c7                	mov    edi,eax
    b49f:	6a 00                	push   0x0
    b4a1:	6a 00                	push   0x0
    b4a3:	55                   	push   ebp
    b4a4:	56                   	push   esi
    b4a5:	31 ed                	xor    ebp,ebp
    b4a7:	53                   	push   ebx
    b4a8:	e8 d3 fd ff ff       	call   b280 <_ZN3pci14configReadWordEhhhhh>
    b4ad:	ba 56 00 00 00       	mov    edx,0x56
    b4b2:	66 89 44 24 54       	mov    WORD PTR [esp+0x54],ax
    b4b7:	83 c4 20             	add    esp,0x20
    b4ba:	eb 27                	jmp    b4e3 <_ZN3pci11printBussesEv+0x183>
    b4bc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b4c0:	3c 25                	cmp    al,0x25
    b4c2:	0f 84 00 03 00 00    	je     b7c8 <_ZN3pci11printBussesEv+0x468>
    b4c8:	84 c0                	test   al,al
    b4ca:	0f 85 90 00 00 00    	jne    b560 <_ZN3pci11printBussesEv+0x200>
    b4d0:	8d 5d 02             	lea    ebx,[ebp+0x2]
    b4d3:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b4da:	84 c0                	test   al,al
    b4dc:	74 3a                	je     b518 <_ZN3pci11printBussesEv+0x1b8>
    b4de:	0f be d0             	movsx  edx,al
    b4e1:	89 dd                	mov    ebp,ebx
    b4e3:	8d 5d 01             	lea    ebx,[ebp+0x1]
    b4e6:	80 fa 25             	cmp    dl,0x25
    b4e9:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b4f0:	8d 8b ec d1 00 00    	lea    ecx,[ebx+0xd1ec]
    b4f6:	74 c8                	je     b4c0 <_ZN3pci11printBussesEv+0x160>
    b4f8:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    b4fc:	83 ec 0c             	sub    esp,0xc
    b4ff:	52                   	push   edx
    b500:	e8 9b fb ff ff       	call   b0a0 <_Z7putcharc>
    b505:	83 c4 10             	add    esp,0x10
    b508:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    b50d:	84 c0                	test   al,al
    b50f:	75 cd                	jne    b4de <_ZN3pci11printBussesEv+0x17e>
    b511:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b518:	83 c6 01             	add    esi,0x1
    b51b:	83 fe 20             	cmp    esi,0x20
    b51e:	0f 85 64 fe ff ff    	jne    b388 <_ZN3pci11printBussesEv+0x28>
    b524:	83 44 24 0c 01       	add    DWORD PTR [esp+0xc],0x1
    b529:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b52d:	3d 00 01 00 00       	cmp    eax,0x100
    b532:	0f 85 48 fe ff ff    	jne    b380 <_ZN3pci11printBussesEv+0x20>
    b538:	83 44 24 10 01       	add    DWORD PTR [esp+0x10],0x1
    b53d:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    b541:	83 f8 03             	cmp    eax,0x3
    b544:	0f 85 25 fe ff ff    	jne    b36f <_ZN3pci11printBussesEv+0xf>
    b54a:	83 ec 0c             	sub    esp,0xc
    b54d:	68 69 d1 00 00       	push   0xd169
    b552:	e8 c9 fb ff ff       	call   b120 <_Z6printfPKc>
    b557:	83 c4 5c             	add    esp,0x5c
    b55a:	5b                   	pop    ebx
    b55b:	5e                   	pop    esi
    b55c:	5f                   	pop    edi
    b55d:	5d                   	pop    ebp
    b55e:	c3                   	ret    
    b55f:	90                   	nop
    b560:	83 ec 08             	sub    esp,0x8
    b563:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    b567:	50                   	push   eax
    b568:	51                   	push   ecx
    b569:	e8 02 0b 00 00       	call   c070 <_Z14_manage_escapeItEiPKcPT_>
    b56e:	01 c3                	add    ebx,eax
    b570:	66 89 7c 24 46       	mov    WORD PTR [esp+0x46],di
    b575:	83 c4 10             	add    esp,0x10
    b578:	0f be 83 ec d1 00 00 	movsx  eax,BYTE PTR [ebx+0xd1ec]
    b57f:	8d ab ec d1 00 00    	lea    ebp,[ebx+0xd1ec]
    b585:	84 c0                	test   al,al
    b587:	74 8f                	je     b518 <_ZN3pci11printBussesEv+0x1b8>
    b589:	31 d2                	xor    edx,edx
    b58b:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b58f:	89 ee                	mov    esi,ebp
    b591:	89 d5                	mov    ebp,edx
    b593:	eb 25                	jmp    b5ba <_ZN3pci11printBussesEv+0x25a>
    b595:	8d 76 00             	lea    esi,[esi+0x0]
    b598:	80 fb 25             	cmp    bl,0x25
    b59b:	0f 84 7f 03 00 00    	je     b920 <_ZN3pci11printBussesEv+0x5c0>
    b5a1:	84 db                	test   bl,bl
    b5a3:	0f 85 d7 00 00 00    	jne    b680 <_ZN3pci11printBussesEv+0x320>
    b5a9:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b5ae:	8d 7d 02             	lea    edi,[ebp+0x2]
    b5b1:	84 db                	test   bl,bl
    b5b3:	74 22                	je     b5d7 <_ZN3pci11printBussesEv+0x277>
    b5b5:	0f be c3             	movsx  eax,bl
    b5b8:	89 fd                	mov    ebp,edi
    b5ba:	8d 7d 01             	lea    edi,[ebp+0x1]
    b5bd:	3c 25                	cmp    al,0x25
    b5bf:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b5c2:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b5c5:	74 d1                	je     b598 <_ZN3pci11printBussesEv+0x238>
    b5c7:	83 ec 0c             	sub    esp,0xc
    b5ca:	50                   	push   eax
    b5cb:	e8 d0 fa ff ff       	call   b0a0 <_Z7putcharc>
    b5d0:	83 c4 10             	add    esp,0x10
    b5d3:	84 db                	test   bl,bl
    b5d5:	75 de                	jne    b5b5 <_ZN3pci11printBussesEv+0x255>
    b5d7:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b5db:	83 c6 01             	add    esi,0x1
    b5de:	83 fe 20             	cmp    esi,0x20
    b5e1:	0f 85 a1 fd ff ff    	jne    b388 <_ZN3pci11printBussesEv+0x28>
    b5e7:	e9 38 ff ff ff       	jmp    b524 <_ZN3pci11printBussesEv+0x1c4>
    b5ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b5f0:	83 ec 08             	sub    esp,0x8
    b5f3:	8d 44 24 37          	lea    eax,[esp+0x37]
    b5f7:	50                   	push   eax
    b5f8:	51                   	push   ecx
    b5f9:	e8 d2 0d 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    b5fe:	01 c3                	add    ebx,eax
    b600:	89 e8                	mov    eax,ebp
    b602:	88 44 24 40          	mov    BYTE PTR [esp+0x40],al
    b606:	0f be 83 a8 d1 00 00 	movsx  eax,BYTE PTR [ebx+0xd1a8]
    b60d:	83 c4 10             	add    esp,0x10
    b610:	8d 93 a8 d1 00 00    	lea    edx,[ebx+0xd1a8]
    b616:	84 c0                	test   al,al
    b618:	0f 84 42 fe ff ff    	je     b460 <_ZN3pci11printBussesEv+0x100>
    b61e:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    b622:	31 ed                	xor    ebp,ebp
    b624:	89 d6                	mov    esi,edx
    b626:	eb 2a                	jmp    b652 <_ZN3pci11printBussesEv+0x2f2>
    b628:	90                   	nop
    b629:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b630:	80 fb 25             	cmp    bl,0x25
    b633:	0f 84 17 03 00 00    	je     b950 <_ZN3pci11printBussesEv+0x5f0>
    b639:	84 db                	test   bl,bl
    b63b:	0f 85 cf 00 00 00    	jne    b710 <_ZN3pci11printBussesEv+0x3b0>
    b641:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b646:	8d 7d 02             	lea    edi,[ebp+0x2]
    b649:	84 db                	test   bl,bl
    b64b:	74 22                	je     b66f <_ZN3pci11printBussesEv+0x30f>
    b64d:	0f be c3             	movsx  eax,bl
    b650:	89 fd                	mov    ebp,edi
    b652:	8d 7d 01             	lea    edi,[ebp+0x1]
    b655:	3c 25                	cmp    al,0x25
    b657:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b65a:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b65d:	74 d1                	je     b630 <_ZN3pci11printBussesEv+0x2d0>
    b65f:	83 ec 0c             	sub    esp,0xc
    b662:	50                   	push   eax
    b663:	e8 38 fa ff ff       	call   b0a0 <_Z7putcharc>
    b668:	83 c4 10             	add    esp,0x10
    b66b:	84 db                	test   bl,bl
    b66d:	75 de                	jne    b64d <_ZN3pci11printBussesEv+0x2ed>
    b66f:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    b673:	e9 e8 fd ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    b678:	90                   	nop
    b679:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b680:	83 ec 08             	sub    esp,0x8
    b683:	89 f5                	mov    ebp,esi
    b685:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b689:	8d 44 24 3e          	lea    eax,[esp+0x3e]
    b68d:	50                   	push   eax
    b68e:	51                   	push   ecx
    b68f:	e8 dc 09 00 00       	call   c070 <_Z14_manage_escapeItEiPKcPT_>
    b694:	8d 1c 38             	lea    ebx,[eax+edi*1]
    b697:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    b69c:	01 dd                	add    ebp,ebx
    b69e:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    b6a2:	88 44 24 43          	mov    BYTE PTR [esp+0x43],al
    b6a6:	83 c4 10             	add    esp,0x10
    b6a9:	84 d2                	test   dl,dl
    b6ab:	0f 84 67 fe ff ff    	je     b518 <_ZN3pci11printBussesEv+0x1b8>
    b6b1:	31 ff                	xor    edi,edi
    b6b3:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b6b7:	89 ee                	mov    esi,ebp
    b6b9:	89 fd                	mov    ebp,edi
    b6bb:	eb 29                	jmp    b6e6 <_ZN3pci11printBussesEv+0x386>
    b6bd:	8d 76 00             	lea    esi,[esi+0x0]
    b6c0:	80 fb 25             	cmp    bl,0x25
    b6c3:	0f 84 57 04 00 00    	je     bb20 <_ZN3pci11printBussesEv+0x7c0>
    b6c9:	84 db                	test   bl,bl
    b6cb:	0f 85 2f 01 00 00    	jne    b800 <_ZN3pci11printBussesEv+0x4a0>
    b6d1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b6d6:	8d 7d 02             	lea    edi,[ebp+0x2]
    b6d9:	84 db                	test   bl,bl
    b6db:	0f 84 f6 fe ff ff    	je     b5d7 <_ZN3pci11printBussesEv+0x277>
    b6e1:	0f be d3             	movsx  edx,bl
    b6e4:	89 fd                	mov    ebp,edi
    b6e6:	8d 7d 01             	lea    edi,[ebp+0x1]
    b6e9:	80 fa 25             	cmp    dl,0x25
    b6ec:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b6ef:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b6f2:	74 cc                	je     b6c0 <_ZN3pci11printBussesEv+0x360>
    b6f4:	83 ec 0c             	sub    esp,0xc
    b6f7:	52                   	push   edx
    b6f8:	e8 a3 f9 ff ff       	call   b0a0 <_Z7putcharc>
    b6fd:	83 c4 10             	add    esp,0x10
    b700:	84 db                	test   bl,bl
    b702:	75 dd                	jne    b6e1 <_ZN3pci11printBussesEv+0x381>
    b704:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b708:	e9 ce fe ff ff       	jmp    b5db <_ZN3pci11printBussesEv+0x27b>
    b70d:	8d 76 00             	lea    esi,[esi+0x0]
    b710:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b714:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    b718:	83 ec 08             	sub    esp,0x8
    b71b:	8d 44 24 38          	lea    eax,[esp+0x38]
    b71f:	50                   	push   eax
    b720:	51                   	push   ecx
    b721:	e8 aa 0c 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    b726:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b72a:	01 c7                	add    edi,eax
    b72c:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    b731:	01 fa                	add    edx,edi
    b733:	88 44 24 41          	mov    BYTE PTR [esp+0x41],al
    b737:	0f be 02             	movsx  eax,BYTE PTR [edx]
    b73a:	83 c4 10             	add    esp,0x10
    b73d:	84 c0                	test   al,al
    b73f:	0f 84 1b fd ff ff    	je     b460 <_ZN3pci11printBussesEv+0x100>
    b745:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    b749:	31 ff                	xor    edi,edi
    b74b:	89 d6                	mov    esi,edx
    b74d:	eb 23                	jmp    b772 <_ZN3pci11printBussesEv+0x412>
    b74f:	90                   	nop
    b750:	80 fb 25             	cmp    bl,0x25
    b753:	0f 84 97 03 00 00    	je     baf0 <_ZN3pci11printBussesEv+0x790>
    b759:	84 db                	test   bl,bl
    b75b:	0f 85 27 01 00 00    	jne    b888 <_ZN3pci11printBussesEv+0x528>
    b761:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    b766:	8d 6f 02             	lea    ebp,[edi+0x2]
    b769:	84 db                	test   bl,bl
    b76b:	74 22                	je     b78f <_ZN3pci11printBussesEv+0x42f>
    b76d:	0f be c3             	movsx  eax,bl
    b770:	89 ef                	mov    edi,ebp
    b772:	8d 6f 01             	lea    ebp,[edi+0x1]
    b775:	3c 25                	cmp    al,0x25
    b777:	8d 0c 2e             	lea    ecx,[esi+ebp*1]
    b77a:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b77d:	74 d1                	je     b750 <_ZN3pci11printBussesEv+0x3f0>
    b77f:	83 ec 0c             	sub    esp,0xc
    b782:	50                   	push   eax
    b783:	e8 18 f9 ff ff       	call   b0a0 <_Z7putcharc>
    b788:	83 c4 10             	add    esp,0x10
    b78b:	84 db                	test   bl,bl
    b78d:	75 de                	jne    b76d <_ZN3pci11printBussesEv+0x40d>
    b78f:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b793:	e9 c8 fc ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    b798:	90                   	nop
    b799:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b7a0:	83 ec 0c             	sub    esp,0xc
    b7a3:	8d 5f 02             	lea    ebx,[edi+0x2]
    b7a6:	6a 25                	push   0x25
    b7a8:	e8 f3 f8 ff ff       	call   b0a0 <_Z7putcharc>
    b7ad:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b7b4:	83 c4 10             	add    esp,0x10
    b7b7:	84 c0                	test   al,al
    b7b9:	0f 85 67 fc ff ff    	jne    b426 <_ZN3pci11printBussesEv+0xc6>
    b7bf:	e9 9c fc ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    b7c4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b7c8:	83 ec 0c             	sub    esp,0xc
    b7cb:	8d 5d 02             	lea    ebx,[ebp+0x2]
    b7ce:	6a 25                	push   0x25
    b7d0:	e8 cb f8 ff ff       	call   b0a0 <_Z7putcharc>
    b7d5:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b7dc:	83 c4 10             	add    esp,0x10
    b7df:	84 c0                	test   al,al
    b7e1:	0f 85 f7 fc ff ff    	jne    b4de <_ZN3pci11printBussesEv+0x17e>
    b7e7:	83 c6 01             	add    esi,0x1
    b7ea:	83 fe 20             	cmp    esi,0x20
    b7ed:	0f 85 95 fb ff ff    	jne    b388 <_ZN3pci11printBussesEv+0x28>
    b7f3:	e9 2c fd ff ff       	jmp    b524 <_ZN3pci11printBussesEv+0x1c4>
    b7f8:	90                   	nop
    b7f9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b800:	83 ec 08             	sub    esp,0x8
    b803:	89 f5                	mov    ebp,esi
    b805:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b809:	8d 44 24 3b          	lea    eax,[esp+0x3b]
    b80d:	89 fb                	mov    ebx,edi
    b80f:	50                   	push   eax
    b810:	51                   	push   ecx
    b811:	e8 ba 0b 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    b816:	01 c3                	add    ebx,eax
    b818:	83 c4 10             	add    esp,0x10
    b81b:	01 eb                	add    ebx,ebp
    b81d:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    b820:	84 d2                	test   dl,dl
    b822:	0f 84 f0 fc ff ff    	je     b518 <_ZN3pci11printBussesEv+0x1b8>
    b828:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b82c:	31 ed                	xor    ebp,ebp
    b82e:	89 de                	mov    esi,ebx
    b830:	eb 2c                	jmp    b85e <_ZN3pci11printBussesEv+0x4fe>
    b832:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b838:	80 fb 25             	cmp    bl,0x25
    b83b:	0f 84 bf 03 00 00    	je     bc00 <_ZN3pci11printBussesEv+0x8a0>
    b841:	84 db                	test   bl,bl
    b843:	0f 85 37 01 00 00    	jne    b980 <_ZN3pci11printBussesEv+0x620>
    b849:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b84e:	8d 7d 02             	lea    edi,[ebp+0x2]
    b851:	84 db                	test   bl,bl
    b853:	0f 84 7e fd ff ff    	je     b5d7 <_ZN3pci11printBussesEv+0x277>
    b859:	0f be d3             	movsx  edx,bl
    b85c:	89 fd                	mov    ebp,edi
    b85e:	8d 7d 01             	lea    edi,[ebp+0x1]
    b861:	80 fa 25             	cmp    dl,0x25
    b864:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b867:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b86a:	74 cc                	je     b838 <_ZN3pci11printBussesEv+0x4d8>
    b86c:	83 ec 0c             	sub    esp,0xc
    b86f:	52                   	push   edx
    b870:	e8 2b f8 ff ff       	call   b0a0 <_Z7putcharc>
    b875:	83 c4 10             	add    esp,0x10
    b878:	84 db                	test   bl,bl
    b87a:	75 dd                	jne    b859 <_ZN3pci11printBussesEv+0x4f9>
    b87c:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b880:	e9 56 fd ff ff       	jmp    b5db <_ZN3pci11printBussesEv+0x27b>
    b885:	8d 76 00             	lea    esi,[esi+0x0]
    b888:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b88c:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b890:	83 ec 08             	sub    esp,0x8
    b893:	8d 44 24 39          	lea    eax,[esp+0x39]
    b897:	50                   	push   eax
    b898:	51                   	push   ecx
    b899:	e8 32 0b 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    b89e:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b8a2:	01 c5                	add    ebp,eax
    b8a4:	0f b6 44 24 28       	movzx  eax,BYTE PTR [esp+0x28]
    b8a9:	01 d5                	add    ebp,edx
    b8ab:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    b8af:	88 44 24 42          	mov    BYTE PTR [esp+0x42],al
    b8b3:	83 c4 10             	add    esp,0x10
    b8b6:	84 d2                	test   dl,dl
    b8b8:	0f 84 a2 fb ff ff    	je     b460 <_ZN3pci11printBussesEv+0x100>
    b8be:	31 ff                	xor    edi,edi
    b8c0:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b8c4:	89 ee                	mov    esi,ebp
    b8c6:	89 fd                	mov    ebp,edi
    b8c8:	eb 28                	jmp    b8f2 <_ZN3pci11printBussesEv+0x592>
    b8ca:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b8d0:	80 fb 25             	cmp    bl,0x25
    b8d3:	0f 84 f7 02 00 00    	je     bbd0 <_ZN3pci11printBussesEv+0x870>
    b8d9:	84 db                	test   bl,bl
    b8db:	0f 85 7f 01 00 00    	jne    ba60 <_ZN3pci11printBussesEv+0x700>
    b8e1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b8e6:	8d 7d 02             	lea    edi,[ebp+0x2]
    b8e9:	84 db                	test   bl,bl
    b8eb:	74 23                	je     b910 <_ZN3pci11printBussesEv+0x5b0>
    b8ed:	0f be d3             	movsx  edx,bl
    b8f0:	89 fd                	mov    ebp,edi
    b8f2:	8d 7d 01             	lea    edi,[ebp+0x1]
    b8f5:	80 fa 25             	cmp    dl,0x25
    b8f8:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b8fb:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b8fe:	74 d0                	je     b8d0 <_ZN3pci11printBussesEv+0x570>
    b900:	83 ec 0c             	sub    esp,0xc
    b903:	52                   	push   edx
    b904:	e8 97 f7 ff ff       	call   b0a0 <_Z7putcharc>
    b909:	83 c4 10             	add    esp,0x10
    b90c:	84 db                	test   bl,bl
    b90e:	75 dd                	jne    b8ed <_ZN3pci11printBussesEv+0x58d>
    b910:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b914:	e9 47 fb ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    b919:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b920:	83 ec 0c             	sub    esp,0xc
    b923:	8d 7d 02             	lea    edi,[ebp+0x2]
    b926:	6a 25                	push   0x25
    b928:	e8 73 f7 ff ff       	call   b0a0 <_Z7putcharc>
    b92d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b932:	83 c4 10             	add    esp,0x10
    b935:	84 db                	test   bl,bl
    b937:	0f 85 78 fc ff ff    	jne    b5b5 <_ZN3pci11printBussesEv+0x255>
    b93d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b941:	e9 95 fc ff ff       	jmp    b5db <_ZN3pci11printBussesEv+0x27b>
    b946:	8d 76 00             	lea    esi,[esi+0x0]
    b949:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b950:	83 ec 0c             	sub    esp,0xc
    b953:	8d 7d 02             	lea    edi,[ebp+0x2]
    b956:	6a 25                	push   0x25
    b958:	e8 43 f7 ff ff       	call   b0a0 <_Z7putcharc>
    b95d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b962:	83 c4 10             	add    esp,0x10
    b965:	84 db                	test   bl,bl
    b967:	0f 85 e0 fc ff ff    	jne    b64d <_ZN3pci11printBussesEv+0x2ed>
    b96d:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    b971:	e9 ea fa ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    b976:	8d 76 00             	lea    esi,[esi+0x0]
    b979:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b980:	89 d8                	mov    eax,ebx
    b982:	89 f3                	mov    ebx,esi
    b984:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b988:	83 e8 42             	sub    eax,0x42
    b98b:	3c 36                	cmp    al,0x36
    b98d:	77 21                	ja     b9b0 <_ZN3pci11printBussesEv+0x650>
    b98f:	0f b6 c0             	movzx  eax,al
    b992:	ff 24 85 00 d0 00 00 	jmp    DWORD PTR [eax*4+0xd000]
    b999:	83 ec 0c             	sub    esp,0xc
    b99c:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    b9a0:	e8 5b f7 ff ff       	call   b100 <_Z6putstrPc>
    b9a5:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    b9a9:	83 c4 10             	add    esp,0x10
    b9ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b9b0:	83 ec 0c             	sub    esp,0xc
    b9b3:	83 c6 01             	add    esi,0x1
    b9b6:	51                   	push   ecx
    b9b7:	e8 64 f7 ff ff       	call   b120 <_Z6printfPKc>
    b9bc:	83 c4 10             	add    esp,0x10
    b9bf:	83 fe 20             	cmp    esi,0x20
    b9c2:	0f 85 c0 f9 ff ff    	jne    b388 <_ZN3pci11printBussesEv+0x28>
    b9c8:	e9 57 fb ff ff       	jmp    b524 <_ZN3pci11printBussesEv+0x1c4>
    b9cd:	83 ec 0c             	sub    esp,0xc
    b9d0:	0f be 44 24 24       	movsx  eax,BYTE PTR [esp+0x24]
    b9d5:	50                   	push   eax
    b9d6:	e8 c5 f6 ff ff       	call   b0a0 <_Z7putcharc>
    b9db:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    b9df:	83 c4 10             	add    esp,0x10
    b9e2:	eb cc                	jmp    b9b0 <_ZN3pci11printBussesEv+0x650>
    b9e4:	83 ec 0c             	sub    esp,0xc
    b9e7:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    b9eb:	e8 e0 f6 ff ff       	call   b0d0 <_Z6puthexi>
    b9f0:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    b9f4:	83 c4 10             	add    esp,0x10
    b9f7:	eb b7                	jmp    b9b0 <_ZN3pci11printBussesEv+0x650>
    b9f9:	83 ec 0c             	sub    esp,0xc
    b9fc:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba00:	e8 db f6 ff ff       	call   b0e0 <_Z6putocti>
    ba05:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba09:	83 c4 10             	add    esp,0x10
    ba0c:	eb a2                	jmp    b9b0 <_ZN3pci11printBussesEv+0x650>
    ba0e:	83 ec 0c             	sub    esp,0xc
    ba11:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba15:	e8 d6 f6 ff ff       	call   b0f0 <_Z6putbini>
    ba1a:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba1e:	83 c4 10             	add    esp,0x10
    ba21:	eb 8d                	jmp    b9b0 <_ZN3pci11printBussesEv+0x650>
    ba23:	83 ec 0c             	sub    esp,0xc
    ba26:	68 ec e5 00 00       	push   0xe5ec
    ba2b:	e8 f0 f6 ff ff       	call   b120 <_Z6printfPKc>
    ba30:	58                   	pop    eax
    ba31:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba35:	e8 96 f6 ff ff       	call   b0d0 <_Z6puthexi>
    ba3a:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba3e:	83 c4 10             	add    esp,0x10
    ba41:	e9 6a ff ff ff       	jmp    b9b0 <_ZN3pci11printBussesEv+0x650>
    ba46:	83 ec 0c             	sub    esp,0xc
    ba49:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba4d:	e8 6e f6 ff ff       	call   b0c0 <_Z6putdeci>
    ba52:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba56:	83 c4 10             	add    esp,0x10
    ba59:	e9 52 ff ff ff       	jmp    b9b0 <_ZN3pci11printBussesEv+0x650>
    ba5e:	66 90                	xchg   ax,ax
    ba60:	83 ec 08             	sub    esp,0x8
    ba63:	89 f5                	mov    ebp,esi
    ba65:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    ba69:	8d 44 24 3a          	lea    eax,[esp+0x3a]
    ba6d:	89 fb                	mov    ebx,edi
    ba6f:	50                   	push   eax
    ba70:	51                   	push   ecx
    ba71:	e8 5a 09 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    ba76:	01 c3                	add    ebx,eax
    ba78:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    ba7c:	01 eb                	add    ebx,ebp
    ba7e:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    ba81:	89 44 24 48          	mov    DWORD PTR [esp+0x48],eax
    ba85:	83 c4 10             	add    esp,0x10
    ba88:	84 d2                	test   dl,dl
    ba8a:	0f 84 d0 f9 ff ff    	je     b460 <_ZN3pci11printBussesEv+0x100>
    ba90:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    ba94:	31 ed                	xor    ebp,ebp
    ba96:	89 de                	mov    esi,ebx
    ba98:	eb 2c                	jmp    bac6 <_ZN3pci11printBussesEv+0x766>
    ba9a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    baa0:	80 fb 25             	cmp    bl,0x25
    baa3:	0f 84 af 01 00 00    	je     bc58 <_ZN3pci11printBussesEv+0x8f8>
    baa9:	84 db                	test   bl,bl
    baab:	0f 85 9f 00 00 00    	jne    bb50 <_ZN3pci11printBussesEv+0x7f0>
    bab1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bab6:	8d 7d 02             	lea    edi,[ebp+0x2]
    bab9:	84 db                	test   bl,bl
    babb:	0f 84 4f fe ff ff    	je     b910 <_ZN3pci11printBussesEv+0x5b0>
    bac1:	0f be d3             	movsx  edx,bl
    bac4:	89 fd                	mov    ebp,edi
    bac6:	8d 7d 01             	lea    edi,[ebp+0x1]
    bac9:	80 fa 25             	cmp    dl,0x25
    bacc:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    bacf:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    bad2:	74 cc                	je     baa0 <_ZN3pci11printBussesEv+0x740>
    bad4:	83 ec 0c             	sub    esp,0xc
    bad7:	52                   	push   edx
    bad8:	e8 c3 f5 ff ff       	call   b0a0 <_Z7putcharc>
    badd:	83 c4 10             	add    esp,0x10
    bae0:	84 db                	test   bl,bl
    bae2:	75 dd                	jne    bac1 <_ZN3pci11printBussesEv+0x761>
    bae4:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bae8:	e9 73 f9 ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    baed:	8d 76 00             	lea    esi,[esi+0x0]
    baf0:	83 ec 0c             	sub    esp,0xc
    baf3:	8d 6f 02             	lea    ebp,[edi+0x2]
    baf6:	6a 25                	push   0x25
    baf8:	e8 a3 f5 ff ff       	call   b0a0 <_Z7putcharc>
    bafd:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    bb02:	83 c4 10             	add    esp,0x10
    bb05:	84 db                	test   bl,bl
    bb07:	0f 85 60 fc ff ff    	jne    b76d <_ZN3pci11printBussesEv+0x40d>
    bb0d:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    bb11:	e9 4a f9 ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    bb16:	8d 76 00             	lea    esi,[esi+0x0]
    bb19:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bb20:	83 ec 0c             	sub    esp,0xc
    bb23:	8d 7d 02             	lea    edi,[ebp+0x2]
    bb26:	6a 25                	push   0x25
    bb28:	e8 73 f5 ff ff       	call   b0a0 <_Z7putcharc>
    bb2d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bb32:	83 c4 10             	add    esp,0x10
    bb35:	84 db                	test   bl,bl
    bb37:	0f 85 a4 fb ff ff    	jne    b6e1 <_ZN3pci11printBussesEv+0x381>
    bb3d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bb41:	e9 95 fa ff ff       	jmp    b5db <_ZN3pci11printBussesEv+0x27b>
    bb46:	8d 76 00             	lea    esi,[esi+0x0]
    bb49:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bb50:	83 ec 08             	sub    esp,0x8
    bb53:	89 f3                	mov    ebx,esi
    bb55:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    bb59:	8d 44 24 40          	lea    eax,[esp+0x40]
    bb5d:	50                   	push   eax
    bb5e:	51                   	push   ecx
    bb5f:	e8 7c 09 00 00       	call   c4e0 <_Z14_manage_escapeIiEiPKcPT_>
    bb64:	01 c7                	add    edi,eax
    bb66:	89 74 24 4c          	mov    DWORD PTR [esp+0x4c],esi
    bb6a:	83 c4 10             	add    esp,0x10
    bb6d:	01 df                	add    edi,ebx
    bb6f:	0f be 07             	movsx  eax,BYTE PTR [edi]
    bb72:	84 c0                	test   al,al
    bb74:	0f 84 e6 f8 ff ff    	je     b460 <_ZN3pci11printBussesEv+0x100>
    bb7a:	31 d2                	xor    edx,edx
    bb7c:	eb 28                	jmp    bba6 <_ZN3pci11printBussesEv+0x846>
    bb7e:	66 90                	xchg   ax,ax
    bb80:	80 fb 25             	cmp    bl,0x25
    bb83:	0f 84 f7 00 00 00    	je     bc80 <_ZN3pci11printBussesEv+0x920>
    bb89:	84 db                	test   bl,bl
    bb8b:	0f 85 9f 00 00 00    	jne    bc30 <_ZN3pci11printBussesEv+0x8d0>
    bb91:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    bb96:	8d 6a 02             	lea    ebp,[edx+0x2]
    bb99:	84 db                	test   bl,bl
    bb9b:	0f 84 bf f8 ff ff    	je     b460 <_ZN3pci11printBussesEv+0x100>
    bba1:	0f be c3             	movsx  eax,bl
    bba4:	89 ea                	mov    edx,ebp
    bba6:	8d 6a 01             	lea    ebp,[edx+0x1]
    bba9:	3c 25                	cmp    al,0x25
    bbab:	8d 0c 2f             	lea    ecx,[edi+ebp*1]
    bbae:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    bbb1:	74 cd                	je     bb80 <_ZN3pci11printBussesEv+0x820>
    bbb3:	83 ec 0c             	sub    esp,0xc
    bbb6:	50                   	push   eax
    bbb7:	e8 e4 f4 ff ff       	call   b0a0 <_Z7putcharc>
    bbbc:	83 c4 10             	add    esp,0x10
    bbbf:	84 db                	test   bl,bl
    bbc1:	75 de                	jne    bba1 <_ZN3pci11printBussesEv+0x841>
    bbc3:	e9 98 f8 ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    bbc8:	90                   	nop
    bbc9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bbd0:	83 ec 0c             	sub    esp,0xc
    bbd3:	8d 7d 02             	lea    edi,[ebp+0x2]
    bbd6:	6a 25                	push   0x25
    bbd8:	e8 c3 f4 ff ff       	call   b0a0 <_Z7putcharc>
    bbdd:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bbe2:	83 c4 10             	add    esp,0x10
    bbe5:	84 db                	test   bl,bl
    bbe7:	0f 85 00 fd ff ff    	jne    b8ed <_ZN3pci11printBussesEv+0x58d>
    bbed:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bbf1:	e9 6a f8 ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    bbf6:	8d 76 00             	lea    esi,[esi+0x0]
    bbf9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bc00:	83 ec 0c             	sub    esp,0xc
    bc03:	8d 7d 02             	lea    edi,[ebp+0x2]
    bc06:	6a 25                	push   0x25
    bc08:	e8 93 f4 ff ff       	call   b0a0 <_Z7putcharc>
    bc0d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bc12:	83 c4 10             	add    esp,0x10
    bc15:	84 db                	test   bl,bl
    bc17:	0f 85 3c fc ff ff    	jne    b859 <_ZN3pci11printBussesEv+0x4f9>
    bc1d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bc21:	e9 b5 f9 ff ff       	jmp    b5db <_ZN3pci11printBussesEv+0x27b>
    bc26:	8d 76 00             	lea    esi,[esi+0x0]
    bc29:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bc30:	83 ec 08             	sub    esp,0x8
    bc33:	8d 44 24 44          	lea    eax,[esp+0x44]
    bc37:	50                   	push   eax
    bc38:	51                   	push   ecx
    bc39:	e8 a2 08 00 00       	call   c4e0 <_Z14_manage_escapeIiEiPKcPT_>
    bc3e:	8d 1c 28             	lea    ebx,[eax+ebp*1]
    bc41:	01 fb                	add    ebx,edi
    bc43:	89 1c 24             	mov    DWORD PTR [esp],ebx
    bc46:	e8 d5 f4 ff ff       	call   b120 <_Z6printfPKc>
    bc4b:	83 c4 10             	add    esp,0x10
    bc4e:	e9 0d f8 ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    bc53:	90                   	nop
    bc54:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bc58:	83 ec 0c             	sub    esp,0xc
    bc5b:	8d 7d 02             	lea    edi,[ebp+0x2]
    bc5e:	6a 25                	push   0x25
    bc60:	e8 3b f4 ff ff       	call   b0a0 <_Z7putcharc>
    bc65:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bc6a:	83 c4 10             	add    esp,0x10
    bc6d:	84 db                	test   bl,bl
    bc6f:	0f 85 4c fe ff ff    	jne    bac1 <_ZN3pci11printBussesEv+0x761>
    bc75:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bc79:	e9 e2 f7 ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>
    bc7e:	66 90                	xchg   ax,ax
    bc80:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    bc84:	83 ec 0c             	sub    esp,0xc
    bc87:	6a 25                	push   0x25
    bc89:	e8 12 f4 ff ff       	call   b0a0 <_Z7putcharc>
    bc8e:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    bc92:	83 c4 10             	add    esp,0x10
    bc95:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    bc9a:	8d 6a 02             	lea    ebp,[edx+0x2]
    bc9d:	84 db                	test   bl,bl
    bc9f:	0f 85 fc fe ff ff    	jne    bba1 <_ZN3pci11printBussesEv+0x841>
    bca5:	e9 b6 f7 ff ff       	jmp    b460 <_ZN3pci11printBussesEv+0x100>

Disassembly of section .text._Z6printfIiEvPKcT_:

0000bcb0 <_Z6printfIiEvPKcT_>:
    bcb0:	55                   	push   ebp
    bcb1:	57                   	push   edi
    bcb2:	31 ff                	xor    edi,edi
    bcb4:	56                   	push   esi
    bcb5:	53                   	push   ebx
    bcb6:	83 ec 1c             	sub    esp,0x1c
    bcb9:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    bcbd:	8b 74 24 30          	mov    esi,DWORD PTR [esp+0x30]
    bcc1:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    bcc5:	0f be 06             	movsx  eax,BYTE PTR [esi]
    bcc8:	84 c0                	test   al,al
    bcca:	74 4c                	je     bd18 <_Z6printfIiEvPKcT_+0x68>
    bccc:	8d 5f 01             	lea    ebx,[edi+0x1]
    bccf:	3c 25                	cmp    al,0x25
    bcd1:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    bcd4:	75 2e                	jne    bd04 <_Z6printfIiEvPKcT_+0x54>
    bcd6:	8d 76 00             	lea    esi,[esi+0x0]
    bcd9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bce0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    bce4:	3c 25                	cmp    al,0x25
    bce6:	74 78                	je     bd60 <_Z6printfIiEvPKcT_+0xb0>
    bce8:	84 c0                	test   al,al
    bcea:	75 34                	jne    bd20 <_Z6printfIiEvPKcT_+0x70>
    bcec:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    bcf1:	8d 5f 02             	lea    ebx,[edi+0x2]
    bcf4:	84 c0                	test   al,al
    bcf6:	74 20                	je     bd18 <_Z6printfIiEvPKcT_+0x68>
    bcf8:	89 df                	mov    edi,ebx
    bcfa:	8d 5f 01             	lea    ebx,[edi+0x1]
    bcfd:	3c 25                	cmp    al,0x25
    bcff:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    bd02:	74 dc                	je     bce0 <_Z6printfIiEvPKcT_+0x30>
    bd04:	83 ec 0c             	sub    esp,0xc
    bd07:	50                   	push   eax
    bd08:	e8 93 f3 ff ff       	call   b0a0 <_Z7putcharc>
    bd0d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    bd11:	83 c4 10             	add    esp,0x10
    bd14:	84 c0                	test   al,al
    bd16:	75 e0                	jne    bcf8 <_Z6printfIiEvPKcT_+0x48>
    bd18:	83 c4 1c             	add    esp,0x1c
    bd1b:	5b                   	pop    ebx
    bd1c:	5e                   	pop    esi
    bd1d:	5f                   	pop    edi
    bd1e:	5d                   	pop    ebp
    bd1f:	c3                   	ret    
    bd20:	83 e8 42             	sub    eax,0x42
    bd23:	3c 36                	cmp    al,0x36
    bd25:	77 26                	ja     bd4d <_Z6printfIiEvPKcT_+0x9d>
    bd27:	0f b6 c0             	movzx  eax,al
    bd2a:	ff 24 85 58 e3 00 00 	jmp    DWORD PTR [eax*4+0xe358]
    bd31:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bd38:	83 ec 0c             	sub    esp,0xc
    bd3b:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bd3f:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bd44:	50                   	push   eax
    bd45:	e8 56 f3 ff ff       	call   b0a0 <_Z7putcharc>
    bd4a:	83 c4 10             	add    esp,0x10
    bd4d:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    bd51:	83 c4 1c             	add    esp,0x1c
    bd54:	5b                   	pop    ebx
    bd55:	5e                   	pop    esi
    bd56:	5f                   	pop    edi
    bd57:	5d                   	pop    ebp
    bd58:	e9 c3 f3 ff ff       	jmp    b120 <_Z6printfPKc>
    bd5d:	8d 76 00             	lea    esi,[esi+0x0]
    bd60:	83 ec 0c             	sub    esp,0xc
    bd63:	8d 5f 02             	lea    ebx,[edi+0x2]
    bd66:	6a 25                	push   0x25
    bd68:	e8 33 f3 ff ff       	call   b0a0 <_Z7putcharc>
    bd6d:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    bd72:	83 c4 10             	add    esp,0x10
    bd75:	84 c0                	test   al,al
    bd77:	74 9f                	je     bd18 <_Z6printfIiEvPKcT_+0x68>
    bd79:	89 df                	mov    edi,ebx
    bd7b:	e9 7a ff ff ff       	jmp    bcfa <_Z6printfIiEvPKcT_+0x4a>
    bd80:	83 ec 0c             	sub    esp,0xc
    bd83:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bd87:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bd8b:	e8 70 f3 ff ff       	call   b100 <_Z6putstrPc>
    bd90:	83 c4 10             	add    esp,0x10
    bd93:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    bd97:	83 c4 1c             	add    esp,0x1c
    bd9a:	5b                   	pop    ebx
    bd9b:	5e                   	pop    esi
    bd9c:	5f                   	pop    edi
    bd9d:	5d                   	pop    ebp
    bd9e:	e9 7d f3 ff ff       	jmp    b120 <_Z6printfPKc>
    bda3:	90                   	nop
    bda4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bda8:	83 ec 0c             	sub    esp,0xc
    bdab:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bdaf:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bdb3:	e8 38 f3 ff ff       	call   b0f0 <_Z6putbini>
    bdb8:	83 c4 10             	add    esp,0x10
    bdbb:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    bdbf:	83 c4 1c             	add    esp,0x1c
    bdc2:	5b                   	pop    ebx
    bdc3:	5e                   	pop    esi
    bdc4:	5f                   	pop    edi
    bdc5:	5d                   	pop    ebp
    bdc6:	e9 55 f3 ff ff       	jmp    b120 <_Z6printfPKc>
    bdcb:	90                   	nop
    bdcc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bdd0:	83 ec 0c             	sub    esp,0xc
    bdd3:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bdd7:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bddb:	e8 00 f3 ff ff       	call   b0e0 <_Z6putocti>
    bde0:	83 c4 10             	add    esp,0x10
    bde3:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    bde7:	83 c4 1c             	add    esp,0x1c
    bdea:	5b                   	pop    ebx
    bdeb:	5e                   	pop    esi
    bdec:	5f                   	pop    edi
    bded:	5d                   	pop    ebp
    bdee:	e9 2d f3 ff ff       	jmp    b120 <_Z6printfPKc>
    bdf3:	90                   	nop
    bdf4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bdf8:	83 ec 0c             	sub    esp,0xc
    bdfb:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bdff:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be03:	e8 c8 f2 ff ff       	call   b0d0 <_Z6puthexi>
    be08:	83 c4 10             	add    esp,0x10
    be0b:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be0f:	83 c4 1c             	add    esp,0x1c
    be12:	5b                   	pop    ebx
    be13:	5e                   	pop    esi
    be14:	5f                   	pop    edi
    be15:	5d                   	pop    ebp
    be16:	e9 05 f3 ff ff       	jmp    b120 <_Z6printfPKc>
    be1b:	90                   	nop
    be1c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    be20:	83 ec 0c             	sub    esp,0xc
    be23:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    be27:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be2b:	e8 90 f2 ff ff       	call   b0c0 <_Z6putdeci>
    be30:	83 c4 10             	add    esp,0x10
    be33:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be37:	83 c4 1c             	add    esp,0x1c
    be3a:	5b                   	pop    ebx
    be3b:	5e                   	pop    esi
    be3c:	5f                   	pop    edi
    be3d:	5d                   	pop    ebp
    be3e:	e9 dd f2 ff ff       	jmp    b120 <_Z6printfPKc>
    be43:	90                   	nop
    be44:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    be48:	83 ec 0c             	sub    esp,0xc
    be4b:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    be4f:	68 54 e3 00 00       	push   0xe354
    be54:	e8 c7 f2 ff ff       	call   b120 <_Z6printfPKc>
    be59:	58                   	pop    eax
    be5a:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be5e:	e8 6d f2 ff ff       	call   b0d0 <_Z6puthexi>
    be63:	83 c4 10             	add    esp,0x10
    be66:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be6a:	83 c4 1c             	add    esp,0x1c
    be6d:	5b                   	pop    ebx
    be6e:	5e                   	pop    esi
    be6f:	5f                   	pop    edi
    be70:	5d                   	pop    ebp
    be71:	e9 aa f2 ff ff       	jmp    b120 <_Z6printfPKc>

Disassembly of section .text._Z6printfIcEvPKcT_:

0000be80 <_Z6printfIcEvPKcT_>:
    be80:	55                   	push   ebp
    be81:	57                   	push   edi
    be82:	56                   	push   esi
    be83:	53                   	push   ebx
    be84:	31 f6                	xor    esi,esi
    be86:	83 ec 1c             	sub    esp,0x1c
    be89:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    be8d:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    be91:	88 44 24 0c          	mov    BYTE PTR [esp+0xc],al
    be95:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    be99:	84 c0                	test   al,al
    be9b:	74 4e                	je     beeb <_Z6printfIcEvPKcT_+0x6b>
    be9d:	8d 5e 01             	lea    ebx,[esi+0x1]
    bea0:	3c 25                	cmp    al,0x25
    bea2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    bea6:	75 30                	jne    bed8 <_Z6printfIcEvPKcT_+0x58>
    bea8:	90                   	nop
    bea9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    beb0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    beb3:	3c 25                	cmp    al,0x25
    beb5:	0f 84 85 00 00 00    	je     bf40 <_Z6printfIcEvPKcT_+0xc0>
    bebb:	84 c0                	test   al,al
    bebd:	75 39                	jne    bef8 <_Z6printfIcEvPKcT_+0x78>
    bebf:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    bec4:	8d 5e 02             	lea    ebx,[esi+0x2]
    bec7:	84 c0                	test   al,al
    bec9:	74 20                	je     beeb <_Z6printfIcEvPKcT_+0x6b>
    becb:	89 de                	mov    esi,ebx
    becd:	8d 5e 01             	lea    ebx,[esi+0x1]
    bed0:	3c 25                	cmp    al,0x25
    bed2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    bed6:	74 d8                	je     beb0 <_Z6printfIcEvPKcT_+0x30>
    bed8:	83 ec 0c             	sub    esp,0xc
    bedb:	50                   	push   eax
    bedc:	e8 bf f1 ff ff       	call   b0a0 <_Z7putcharc>
    bee1:	0f be 07             	movsx  eax,BYTE PTR [edi]
    bee4:	83 c4 10             	add    esp,0x10
    bee7:	84 c0                	test   al,al
    bee9:	75 e0                	jne    becb <_Z6printfIcEvPKcT_+0x4b>
    beeb:	83 c4 1c             	add    esp,0x1c
    beee:	5b                   	pop    ebx
    beef:	5e                   	pop    esi
    bef0:	5f                   	pop    edi
    bef1:	5d                   	pop    ebp
    bef2:	c3                   	ret    
    bef3:	90                   	nop
    bef4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bef8:	83 e8 42             	sub    eax,0x42
    befb:	3c 36                	cmp    al,0x36
    befd:	77 26                	ja     bf25 <_Z6printfIcEvPKcT_+0xa5>
    beff:	0f b6 c0             	movzx  eax,al
    bf02:	ff 24 85 34 e4 00 00 	jmp    DWORD PTR [eax*4+0xe434]
    bf09:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bf10:	83 ec 0c             	sub    esp,0xc
    bf13:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bf17:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bf1c:	50                   	push   eax
    bf1d:	e8 7e f1 ff ff       	call   b0a0 <_Z7putcharc>
    bf22:	83 c4 10             	add    esp,0x10
    bf25:	83 ec 0c             	sub    esp,0xc
    bf28:	57                   	push   edi
    bf29:	e8 f2 f1 ff ff       	call   b120 <_Z6printfPKc>
    bf2e:	83 c4 10             	add    esp,0x10
    bf31:	83 c4 1c             	add    esp,0x1c
    bf34:	5b                   	pop    ebx
    bf35:	5e                   	pop    esi
    bf36:	5f                   	pop    edi
    bf37:	5d                   	pop    ebp
    bf38:	c3                   	ret    
    bf39:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bf40:	83 ec 0c             	sub    esp,0xc
    bf43:	8d 5e 02             	lea    ebx,[esi+0x2]
    bf46:	6a 25                	push   0x25
    bf48:	e8 53 f1 ff ff       	call   b0a0 <_Z7putcharc>
    bf4d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    bf52:	83 c4 10             	add    esp,0x10
    bf55:	84 c0                	test   al,al
    bf57:	74 92                	je     beeb <_Z6printfIcEvPKcT_+0x6b>
    bf59:	89 de                	mov    esi,ebx
    bf5b:	e9 6d ff ff ff       	jmp    becd <_Z6printfIcEvPKcT_+0x4d>
    bf60:	83 ec 0c             	sub    esp,0xc
    bf63:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bf67:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bf6b:	e8 90 f1 ff ff       	call   b100 <_Z6putstrPc>
    bf70:	83 c4 10             	add    esp,0x10
    bf73:	83 ec 0c             	sub    esp,0xc
    bf76:	57                   	push   edi
    bf77:	e8 a4 f1 ff ff       	call   b120 <_Z6printfPKc>
    bf7c:	83 c4 10             	add    esp,0x10
    bf7f:	eb b0                	jmp    bf31 <_Z6printfIcEvPKcT_+0xb1>
    bf81:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bf88:	83 ec 0c             	sub    esp,0xc
    bf8b:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bf8f:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bf94:	50                   	push   eax
    bf95:	e8 56 f1 ff ff       	call   b0f0 <_Z6putbini>
    bf9a:	83 c4 10             	add    esp,0x10
    bf9d:	83 ec 0c             	sub    esp,0xc
    bfa0:	57                   	push   edi
    bfa1:	e8 7a f1 ff ff       	call   b120 <_Z6printfPKc>
    bfa6:	83 c4 10             	add    esp,0x10
    bfa9:	eb 86                	jmp    bf31 <_Z6printfIcEvPKcT_+0xb1>
    bfab:	90                   	nop
    bfac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bfb0:	83 ec 0c             	sub    esp,0xc
    bfb3:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bfb7:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bfbc:	50                   	push   eax
    bfbd:	e8 1e f1 ff ff       	call   b0e0 <_Z6putocti>
    bfc2:	83 c4 10             	add    esp,0x10
    bfc5:	83 ec 0c             	sub    esp,0xc
    bfc8:	57                   	push   edi
    bfc9:	e8 52 f1 ff ff       	call   b120 <_Z6printfPKc>
    bfce:	83 c4 10             	add    esp,0x10
    bfd1:	e9 5b ff ff ff       	jmp    bf31 <_Z6printfIcEvPKcT_+0xb1>
    bfd6:	8d 76 00             	lea    esi,[esi+0x0]
    bfd9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bfe0:	83 ec 0c             	sub    esp,0xc
    bfe3:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bfe7:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bfec:	50                   	push   eax
    bfed:	e8 de f0 ff ff       	call   b0d0 <_Z6puthexi>
    bff2:	83 c4 10             	add    esp,0x10
    bff5:	83 ec 0c             	sub    esp,0xc
    bff8:	57                   	push   edi
    bff9:	e8 22 f1 ff ff       	call   b120 <_Z6printfPKc>
    bffe:	83 c4 10             	add    esp,0x10
    c001:	e9 2b ff ff ff       	jmp    bf31 <_Z6printfIcEvPKcT_+0xb1>
    c006:	8d 76 00             	lea    esi,[esi+0x0]
    c009:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c010:	83 ec 0c             	sub    esp,0xc
    c013:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c017:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    c01c:	50                   	push   eax
    c01d:	e8 9e f0 ff ff       	call   b0c0 <_Z6putdeci>
    c022:	83 c4 10             	add    esp,0x10
    c025:	83 ec 0c             	sub    esp,0xc
    c028:	57                   	push   edi
    c029:	e8 f2 f0 ff ff       	call   b120 <_Z6printfPKc>
    c02e:	83 c4 10             	add    esp,0x10
    c031:	e9 fb fe ff ff       	jmp    bf31 <_Z6printfIcEvPKcT_+0xb1>
    c036:	8d 76 00             	lea    esi,[esi+0x0]
    c039:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c040:	83 ec 0c             	sub    esp,0xc
    c043:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c047:	68 54 e3 00 00       	push   0xe354
    c04c:	e8 cf f0 ff ff       	call   b120 <_Z6printfPKc>
    c051:	58                   	pop    eax
    c052:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    c056:	e8 75 f0 ff ff       	call   b0d0 <_Z6puthexi>
    c05b:	83 c4 10             	add    esp,0x10
    c05e:	83 ec 0c             	sub    esp,0xc
    c061:	57                   	push   edi
    c062:	e8 b9 f0 ff ff       	call   b120 <_Z6printfPKc>
    c067:	83 c4 10             	add    esp,0x10
    c06a:	e9 c2 fe ff ff       	jmp    bf31 <_Z6printfIcEvPKcT_+0xb1>

Disassembly of section .text._Z14_manage_escapeItEiPKcPT_:

0000c070 <_Z14_manage_escapeItEiPKcPT_>:
    c070:	83 ec 0c             	sub    esp,0xc
    c073:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c077:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c07a:	83 e8 42             	sub    eax,0x42
    c07d:	3c 36                	cmp    al,0x36
    c07f:	0f 87 f3 00 00 00    	ja     c178 <_Z14_manage_escapeItEiPKcPT_+0x108>
    c085:	0f b6 c0             	movzx  eax,al
    c088:	ff 24 85 10 e5 00 00 	jmp    DWORD PTR [eax*4+0xe510]
    c08f:	90                   	nop
    c090:	83 ec 0c             	sub    esp,0xc
    c093:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c097:	ff 30                	push   DWORD PTR [eax]
    c099:	e8 62 f0 ff ff       	call   b100 <_Z6putstrPc>
    c09e:	83 c4 10             	add    esp,0x10
    c0a1:	b8 01 00 00 00       	mov    eax,0x1
    c0a6:	83 c4 0c             	add    esp,0xc
    c0a9:	c3                   	ret    
    c0aa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c0b0:	83 ec 0c             	sub    esp,0xc
    c0b3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c0b7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c0ba:	50                   	push   eax
    c0bb:	e8 30 f0 ff ff       	call   b0f0 <_Z6putbini>
    c0c0:	83 c4 10             	add    esp,0x10
    c0c3:	b8 01 00 00 00       	mov    eax,0x1
    c0c8:	83 c4 0c             	add    esp,0xc
    c0cb:	c3                   	ret    
    c0cc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c0d0:	83 ec 0c             	sub    esp,0xc
    c0d3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c0d7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c0da:	50                   	push   eax
    c0db:	e8 00 f0 ff ff       	call   b0e0 <_Z6putocti>
    c0e0:	83 c4 10             	add    esp,0x10
    c0e3:	b8 01 00 00 00       	mov    eax,0x1
    c0e8:	83 c4 0c             	add    esp,0xc
    c0eb:	c3                   	ret    
    c0ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c0f0:	83 ec 0c             	sub    esp,0xc
    c0f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c0f7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c0fa:	50                   	push   eax
    c0fb:	e8 d0 ef ff ff       	call   b0d0 <_Z6puthexi>
    c100:	83 c4 10             	add    esp,0x10
    c103:	b8 01 00 00 00       	mov    eax,0x1
    c108:	83 c4 0c             	add    esp,0xc
    c10b:	c3                   	ret    
    c10c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c110:	83 ec 0c             	sub    esp,0xc
    c113:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c117:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c11a:	50                   	push   eax
    c11b:	e8 80 ef ff ff       	call   b0a0 <_Z7putcharc>
    c120:	83 c4 10             	add    esp,0x10
    c123:	b8 01 00 00 00       	mov    eax,0x1
    c128:	83 c4 0c             	add    esp,0xc
    c12b:	c3                   	ret    
    c12c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c130:	83 ec 0c             	sub    esp,0xc
    c133:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c137:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c13a:	50                   	push   eax
    c13b:	e8 80 ef ff ff       	call   b0c0 <_Z6putdeci>
    c140:	83 c4 10             	add    esp,0x10
    c143:	b8 01 00 00 00       	mov    eax,0x1
    c148:	83 c4 0c             	add    esp,0xc
    c14b:	c3                   	ret    
    c14c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c150:	83 ec 0c             	sub    esp,0xc
    c153:	68 54 e3 00 00       	push   0xe354
    c158:	e8 c3 ef ff ff       	call   b120 <_Z6printfPKc>
    c15d:	58                   	pop    eax
    c15e:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c162:	ff 30                	push   DWORD PTR [eax]
    c164:	e8 67 ef ff ff       	call   b0d0 <_Z6puthexi>
    c169:	83 c4 10             	add    esp,0x10
    c16c:	b8 01 00 00 00       	mov    eax,0x1
    c171:	83 c4 0c             	add    esp,0xc
    c174:	c3                   	ret    
    c175:	8d 76 00             	lea    esi,[esi+0x0]
    c178:	31 c0                	xor    eax,eax
    c17a:	e9 27 ff ff ff       	jmp    c0a6 <_Z14_manage_escapeItEiPKcPT_+0x36>

Disassembly of section .text._Z6printfItEvPKcT_:

0000c180 <_Z6printfItEvPKcT_>:
    c180:	55                   	push   ebp
    c181:	57                   	push   edi
    c182:	56                   	push   esi
    c183:	53                   	push   ebx
    c184:	31 f6                	xor    esi,esi
    c186:	83 ec 1c             	sub    esp,0x1c
    c189:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    c18d:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    c191:	66 89 44 24 0c       	mov    WORD PTR [esp+0xc],ax
    c196:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c19a:	84 c0                	test   al,al
    c19c:	74 49                	je     c1e7 <_Z6printfItEvPKcT_+0x67>
    c19e:	8d 5e 01             	lea    ebx,[esi+0x1]
    c1a1:	3c 25                	cmp    al,0x25
    c1a3:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    c1a7:	75 2b                	jne    c1d4 <_Z6printfItEvPKcT_+0x54>
    c1a9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c1b0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    c1b3:	3c 25                	cmp    al,0x25
    c1b5:	74 61                	je     c218 <_Z6printfItEvPKcT_+0x98>
    c1b7:	84 c0                	test   al,al
    c1b9:	75 35                	jne    c1f0 <_Z6printfItEvPKcT_+0x70>
    c1bb:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    c1c0:	8d 5e 02             	lea    ebx,[esi+0x2]
    c1c3:	84 c0                	test   al,al
    c1c5:	74 20                	je     c1e7 <_Z6printfItEvPKcT_+0x67>
    c1c7:	89 de                	mov    esi,ebx
    c1c9:	8d 5e 01             	lea    ebx,[esi+0x1]
    c1cc:	3c 25                	cmp    al,0x25
    c1ce:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    c1d2:	74 dc                	je     c1b0 <_Z6printfItEvPKcT_+0x30>
    c1d4:	83 ec 0c             	sub    esp,0xc
    c1d7:	50                   	push   eax
    c1d8:	e8 c3 ee ff ff       	call   b0a0 <_Z7putcharc>
    c1dd:	0f be 07             	movsx  eax,BYTE PTR [edi]
    c1e0:	83 c4 10             	add    esp,0x10
    c1e3:	84 c0                	test   al,al
    c1e5:	75 e0                	jne    c1c7 <_Z6printfItEvPKcT_+0x47>
    c1e7:	83 c4 1c             	add    esp,0x1c
    c1ea:	5b                   	pop    ebx
    c1eb:	5e                   	pop    esi
    c1ec:	5f                   	pop    edi
    c1ed:	5d                   	pop    ebp
    c1ee:	c3                   	ret    
    c1ef:	90                   	nop
    c1f0:	83 ec 08             	sub    esp,0x8
    c1f3:	8d 44 24 14          	lea    eax,[esp+0x14]
    c1f7:	50                   	push   eax
    c1f8:	57                   	push   edi
    c1f9:	e8 72 fe ff ff       	call   c070 <_Z14_manage_escapeItEiPKcPT_>
    c1fe:	01 c3                	add    ebx,eax
    c200:	01 dd                	add    ebp,ebx
    c202:	89 2c 24             	mov    DWORD PTR [esp],ebp
    c205:	e8 16 ef ff ff       	call   b120 <_Z6printfPKc>
    c20a:	83 c4 10             	add    esp,0x10
    c20d:	83 c4 1c             	add    esp,0x1c
    c210:	5b                   	pop    ebx
    c211:	5e                   	pop    esi
    c212:	5f                   	pop    edi
    c213:	5d                   	pop    ebp
    c214:	c3                   	ret    
    c215:	8d 76 00             	lea    esi,[esi+0x0]
    c218:	83 ec 0c             	sub    esp,0xc
    c21b:	8d 5e 02             	lea    ebx,[esi+0x2]
    c21e:	6a 25                	push   0x25
    c220:	e8 7b ee ff ff       	call   b0a0 <_Z7putcharc>
    c225:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    c22a:	83 c4 10             	add    esp,0x10
    c22d:	84 c0                	test   al,al
    c22f:	74 b6                	je     c1e7 <_Z6printfItEvPKcT_+0x67>
    c231:	89 de                	mov    esi,ebx
    c233:	eb 94                	jmp    c1c9 <_Z6printfItEvPKcT_+0x49>

Disassembly of section .text._Z6printfItJttEEvPKcT_DpT0_:

0000c240 <_Z6printfItJttEEvPKcT_DpT0_>:
    c240:	55                   	push   ebp
    c241:	57                   	push   edi
    c242:	31 c9                	xor    ecx,ecx
    c244:	56                   	push   esi
    c245:	53                   	push   ebx
    c246:	83 ec 2c             	sub    esp,0x2c
    c249:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    c24d:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    c251:	8b 74 24 48          	mov    esi,DWORD PTR [esp+0x48]
    c255:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    c259:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    c25d:	66 89 44 24 0c       	mov    WORD PTR [esp+0xc],ax
    c262:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c266:	84 c0                	test   al,al
    c268:	74 49                	je     c2b3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c26a:	8d 79 01             	lea    edi,[ecx+0x1]
    c26d:	3c 25                	cmp    al,0x25
    c26f:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    c273:	75 2b                	jne    c2a0 <_Z6printfItJttEEvPKcT_DpT0_+0x60>
    c275:	8d 76 00             	lea    esi,[esi+0x0]
    c278:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    c27b:	3c 25                	cmp    al,0x25
    c27d:	0f 84 f5 00 00 00    	je     c378 <_Z6printfItJttEEvPKcT_DpT0_+0x138>
    c283:	84 c0                	test   al,al
    c285:	75 39                	jne    c2c0 <_Z6printfItJttEEvPKcT_DpT0_+0x80>
    c287:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    c28c:	8d 79 02             	lea    edi,[ecx+0x2]
    c28f:	84 c0                	test   al,al
    c291:	74 20                	je     c2b3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c293:	89 f9                	mov    ecx,edi
    c295:	8d 79 01             	lea    edi,[ecx+0x1]
    c298:	3c 25                	cmp    al,0x25
    c29a:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    c29e:	74 d8                	je     c278 <_Z6printfItJttEEvPKcT_DpT0_+0x38>
    c2a0:	83 ec 0c             	sub    esp,0xc
    c2a3:	50                   	push   eax
    c2a4:	e8 f7 ed ff ff       	call   b0a0 <_Z7putcharc>
    c2a9:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    c2ac:	83 c4 10             	add    esp,0x10
    c2af:	84 c0                	test   al,al
    c2b1:	75 e0                	jne    c293 <_Z6printfItJttEEvPKcT_DpT0_+0x53>
    c2b3:	83 c4 2c             	add    esp,0x2c
    c2b6:	5b                   	pop    ebx
    c2b7:	5e                   	pop    esi
    c2b8:	5f                   	pop    edi
    c2b9:	5d                   	pop    ebp
    c2ba:	c3                   	ret    
    c2bb:	90                   	nop
    c2bc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c2c0:	83 ec 08             	sub    esp,0x8
    c2c3:	8d 44 24 14          	lea    eax,[esp+0x14]
    c2c7:	50                   	push   eax
    c2c8:	53                   	push   ebx
    c2c9:	e8 a2 fd ff ff       	call   c070 <_Z14_manage_escapeItEiPKcPT_>
    c2ce:	01 c7                	add    edi,eax
    c2d0:	0f b7 54 24 14       	movzx  edx,WORD PTR [esp+0x14]
    c2d5:	66 89 74 24 2e       	mov    WORD PTR [esp+0x2e],si
    c2da:	01 fd                	add    ebp,edi
    c2dc:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c2e0:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    c2e4:	83 c4 10             	add    esp,0x10
    c2e7:	84 c0                	test   al,al
    c2e9:	74 c8                	je     c2b3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c2eb:	31 ff                	xor    edi,edi
    c2ed:	3c 25                	cmp    al,0x25
    c2ef:	8d 77 01             	lea    esi,[edi+0x1]
    c2f2:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    c2f6:	75 30                	jne    c328 <_Z6printfItJttEEvPKcT_DpT0_+0xe8>
    c2f8:	90                   	nop
    c2f9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c300:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    c303:	3c 25                	cmp    al,0x25
    c305:	0f 84 9d 00 00 00    	je     c3a8 <_Z6printfItJttEEvPKcT_DpT0_+0x168>
    c30b:	84 c0                	test   al,al
    c30d:	75 39                	jne    c348 <_Z6printfItJttEEvPKcT_DpT0_+0x108>
    c30f:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    c314:	8d 77 02             	lea    esi,[edi+0x2]
    c317:	84 c0                	test   al,al
    c319:	74 98                	je     c2b3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c31b:	89 f7                	mov    edi,esi
    c31d:	8d 77 01             	lea    esi,[edi+0x1]
    c320:	3c 25                	cmp    al,0x25
    c322:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    c326:	74 d8                	je     c300 <_Z6printfItJttEEvPKcT_DpT0_+0xc0>
    c328:	83 ec 0c             	sub    esp,0xc
    c32b:	50                   	push   eax
    c32c:	e8 6f ed ff ff       	call   b0a0 <_Z7putcharc>
    c331:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    c334:	83 c4 10             	add    esp,0x10
    c337:	84 c0                	test   al,al
    c339:	0f 84 74 ff ff ff    	je     c2b3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c33f:	89 f7                	mov    edi,esi
    c341:	eb da                	jmp    c31d <_Z6printfItJttEEvPKcT_DpT0_+0xdd>
    c343:	90                   	nop
    c344:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c348:	83 ec 08             	sub    esp,0x8
    c34b:	8d 44 24 26          	lea    eax,[esp+0x26]
    c34f:	50                   	push   eax
    c350:	53                   	push   ebx
    c351:	e8 1a fd ff ff       	call   c070 <_Z14_manage_escapeItEiPKcPT_>
    c356:	5a                   	pop    edx
    c357:	01 c6                	add    esi,eax
    c359:	59                   	pop    ecx
    c35a:	01 f5                	add    ebp,esi
    c35c:	ff 74 24 0c          	push   DWORD PTR [esp+0xc]
    c360:	55                   	push   ebp
    c361:	e8 1a fe ff ff       	call   c180 <_Z6printfItEvPKcT_>
    c366:	83 c4 10             	add    esp,0x10
    c369:	83 c4 2c             	add    esp,0x2c
    c36c:	5b                   	pop    ebx
    c36d:	5e                   	pop    esi
    c36e:	5f                   	pop    edi
    c36f:	5d                   	pop    ebp
    c370:	c3                   	ret    
    c371:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c378:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    c37c:	83 ec 0c             	sub    esp,0xc
    c37f:	6a 25                	push   0x25
    c381:	e8 1a ed ff ff       	call   b0a0 <_Z7putcharc>
    c386:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    c38a:	83 c4 10             	add    esp,0x10
    c38d:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    c392:	8d 79 02             	lea    edi,[ecx+0x2]
    c395:	84 c0                	test   al,al
    c397:	0f 84 16 ff ff ff    	je     c2b3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c39d:	89 f9                	mov    ecx,edi
    c39f:	e9 f1 fe ff ff       	jmp    c295 <_Z6printfItJttEEvPKcT_DpT0_+0x55>
    c3a4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c3a8:	83 ec 0c             	sub    esp,0xc
    c3ab:	8d 77 02             	lea    esi,[edi+0x2]
    c3ae:	6a 25                	push   0x25
    c3b0:	e8 eb ec ff ff       	call   b0a0 <_Z7putcharc>
    c3b5:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    c3ba:	83 c4 10             	add    esp,0x10
    c3bd:	84 c0                	test   al,al
    c3bf:	0f 84 ee fe ff ff    	je     c2b3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c3c5:	89 f7                	mov    edi,esi
    c3c7:	e9 51 ff ff ff       	jmp    c31d <_Z6printfItJttEEvPKcT_DpT0_+0xdd>

Disassembly of section .text._Z14_manage_escapeIhEiPKcPT_:

0000c3d0 <_Z14_manage_escapeIhEiPKcPT_>:
    c3d0:	83 ec 0c             	sub    esp,0xc
    c3d3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c3d7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c3da:	83 e8 42             	sub    eax,0x42
    c3dd:	3c 36                	cmp    al,0x36
    c3df:	0f 87 f3 00 00 00    	ja     c4d8 <_Z14_manage_escapeIhEiPKcPT_+0x108>
    c3e5:	0f b6 c0             	movzx  eax,al
    c3e8:	ff 24 85 f0 e5 00 00 	jmp    DWORD PTR [eax*4+0xe5f0]
    c3ef:	90                   	nop
    c3f0:	83 ec 0c             	sub    esp,0xc
    c3f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c3f7:	ff 30                	push   DWORD PTR [eax]
    c3f9:	e8 02 ed ff ff       	call   b100 <_Z6putstrPc>
    c3fe:	83 c4 10             	add    esp,0x10
    c401:	b8 01 00 00 00       	mov    eax,0x1
    c406:	83 c4 0c             	add    esp,0xc
    c409:	c3                   	ret    
    c40a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c410:	83 ec 0c             	sub    esp,0xc
    c413:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c417:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c41a:	50                   	push   eax
    c41b:	e8 d0 ec ff ff       	call   b0f0 <_Z6putbini>
    c420:	83 c4 10             	add    esp,0x10
    c423:	b8 01 00 00 00       	mov    eax,0x1
    c428:	83 c4 0c             	add    esp,0xc
    c42b:	c3                   	ret    
    c42c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c430:	83 ec 0c             	sub    esp,0xc
    c433:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c437:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c43a:	50                   	push   eax
    c43b:	e8 a0 ec ff ff       	call   b0e0 <_Z6putocti>
    c440:	83 c4 10             	add    esp,0x10
    c443:	b8 01 00 00 00       	mov    eax,0x1
    c448:	83 c4 0c             	add    esp,0xc
    c44b:	c3                   	ret    
    c44c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c450:	83 ec 0c             	sub    esp,0xc
    c453:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c457:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c45a:	50                   	push   eax
    c45b:	e8 70 ec ff ff       	call   b0d0 <_Z6puthexi>
    c460:	83 c4 10             	add    esp,0x10
    c463:	b8 01 00 00 00       	mov    eax,0x1
    c468:	83 c4 0c             	add    esp,0xc
    c46b:	c3                   	ret    
    c46c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c470:	83 ec 0c             	sub    esp,0xc
    c473:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c477:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c47a:	50                   	push   eax
    c47b:	e8 20 ec ff ff       	call   b0a0 <_Z7putcharc>
    c480:	83 c4 10             	add    esp,0x10
    c483:	b8 01 00 00 00       	mov    eax,0x1
    c488:	83 c4 0c             	add    esp,0xc
    c48b:	c3                   	ret    
    c48c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c490:	83 ec 0c             	sub    esp,0xc
    c493:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c497:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c49a:	50                   	push   eax
    c49b:	e8 20 ec ff ff       	call   b0c0 <_Z6putdeci>
    c4a0:	83 c4 10             	add    esp,0x10
    c4a3:	b8 01 00 00 00       	mov    eax,0x1
    c4a8:	83 c4 0c             	add    esp,0xc
    c4ab:	c3                   	ret    
    c4ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c4b0:	83 ec 0c             	sub    esp,0xc
    c4b3:	68 ec e5 00 00       	push   0xe5ec
    c4b8:	e8 63 ec ff ff       	call   b120 <_Z6printfPKc>
    c4bd:	58                   	pop    eax
    c4be:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c4c2:	ff 30                	push   DWORD PTR [eax]
    c4c4:	e8 07 ec ff ff       	call   b0d0 <_Z6puthexi>
    c4c9:	83 c4 10             	add    esp,0x10
    c4cc:	b8 01 00 00 00       	mov    eax,0x1
    c4d1:	83 c4 0c             	add    esp,0xc
    c4d4:	c3                   	ret    
    c4d5:	8d 76 00             	lea    esi,[esi+0x0]
    c4d8:	31 c0                	xor    eax,eax
    c4da:	e9 27 ff ff ff       	jmp    c406 <_Z14_manage_escapeIhEiPKcPT_+0x36>

Disassembly of section .text._Z14_manage_escapeIiEiPKcPT_:

0000c4e0 <_Z14_manage_escapeIiEiPKcPT_>:
    c4e0:	83 ec 0c             	sub    esp,0xc
    c4e3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c4e7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c4ea:	83 e8 42             	sub    eax,0x42
    c4ed:	3c 36                	cmp    al,0x36
    c4ef:	0f 87 db 00 00 00    	ja     c5d0 <_Z14_manage_escapeIiEiPKcPT_+0xf0>
    c4f5:	0f b6 c0             	movzx  eax,al
    c4f8:	ff 24 85 cc e6 00 00 	jmp    DWORD PTR [eax*4+0xe6cc]
    c4ff:	90                   	nop
    c500:	83 ec 0c             	sub    esp,0xc
    c503:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c507:	ff 30                	push   DWORD PTR [eax]
    c509:	e8 f2 eb ff ff       	call   b100 <_Z6putstrPc>
    c50e:	83 c4 10             	add    esp,0x10
    c511:	b8 01 00 00 00       	mov    eax,0x1
    c516:	83 c4 0c             	add    esp,0xc
    c519:	c3                   	ret    
    c51a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c520:	83 ec 0c             	sub    esp,0xc
    c523:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c527:	ff 30                	push   DWORD PTR [eax]
    c529:	e8 c2 eb ff ff       	call   b0f0 <_Z6putbini>
    c52e:	83 c4 10             	add    esp,0x10
    c531:	b8 01 00 00 00       	mov    eax,0x1
    c536:	83 c4 0c             	add    esp,0xc
    c539:	c3                   	ret    
    c53a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c540:	83 ec 0c             	sub    esp,0xc
    c543:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c547:	ff 30                	push   DWORD PTR [eax]
    c549:	e8 92 eb ff ff       	call   b0e0 <_Z6putocti>
    c54e:	83 c4 10             	add    esp,0x10
    c551:	b8 01 00 00 00       	mov    eax,0x1
    c556:	83 c4 0c             	add    esp,0xc
    c559:	c3                   	ret    
    c55a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c560:	83 ec 0c             	sub    esp,0xc
    c563:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c567:	ff 30                	push   DWORD PTR [eax]
    c569:	e8 62 eb ff ff       	call   b0d0 <_Z6puthexi>
    c56e:	83 c4 10             	add    esp,0x10
    c571:	b8 01 00 00 00       	mov    eax,0x1
    c576:	83 c4 0c             	add    esp,0xc
    c579:	c3                   	ret    
    c57a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c580:	83 ec 0c             	sub    esp,0xc
    c583:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c587:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c58a:	50                   	push   eax
    c58b:	e8 10 eb ff ff       	call   b0a0 <_Z7putcharc>
    c590:	83 c4 10             	add    esp,0x10
    c593:	b8 01 00 00 00       	mov    eax,0x1
    c598:	83 c4 0c             	add    esp,0xc
    c59b:	c3                   	ret    
    c59c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c5a0:	83 ec 0c             	sub    esp,0xc
    c5a3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c5a7:	ff 30                	push   DWORD PTR [eax]
    c5a9:	e8 12 eb ff ff       	call   b0c0 <_Z6putdeci>
    c5ae:	83 c4 10             	add    esp,0x10
    c5b1:	b8 01 00 00 00       	mov    eax,0x1
    c5b6:	83 c4 0c             	add    esp,0xc
    c5b9:	c3                   	ret    
    c5ba:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c5c0:	83 ec 0c             	sub    esp,0xc
    c5c3:	68 ec e5 00 00       	push   0xe5ec
    c5c8:	e8 53 eb ff ff       	call   b120 <_Z6printfPKc>
    c5cd:	58                   	pop    eax
    c5ce:	eb 93                	jmp    c563 <_Z14_manage_escapeIiEiPKcPT_+0x83>
    c5d0:	31 c0                	xor    eax,eax
    c5d2:	e9 3f ff ff ff       	jmp    c516 <_Z14_manage_escapeIiEiPKcPT_+0x36>
