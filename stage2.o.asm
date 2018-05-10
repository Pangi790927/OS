
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
    a018:	e8 93 10 00 00       	call   b0b0 <_Z12clear_screenv>
    a01d:	83 ec 0c             	sub    esp,0xc
    a020:	68 dc d0 00 00       	push   0xd0dc
    a025:	e8 16 11 00 00       	call   b140 <_Z6printfPKc>
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
    a065:	e8 d6 10 00 00       	call   b140 <_Z6printfPKc>
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
    a096:	e8 a5 10 00 00       	call   b140 <_Z6printfPKc>
    a09b:	83 c4 10             	add    esp,0x10
    a09e:	e8 7d 09 00 00       	call   aa20 <_ZN6paging18init_kernel_pagingEv>
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
    a0cf:	e8 6c 10 00 00       	call   b140 <_Z6printfPKc>
    a0d4:	83 c4 10             	add    esp,0x10
    a0d7:	eb c5                	jmp    a09e <kernel_2+0x8e>
    a0d9:	83 ec 0c             	sub    esp,0xc
    a0dc:	68 e6 d0 00 00       	push   0xd0e6
    a0e1:	e8 5a 10 00 00       	call   b140 <_Z6printfPKc>
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
    a200:	e8 cb 0f 00 00       	call   b1d0 <_Z3inbt>
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
    a224:	e8 a7 0f 00 00       	call   b1d0 <_Z3inbt>
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
    a27d:	e8 fe 0e 00 00       	call   b180 <_Z4outbth>
    a282:	58                   	pop    eax
    a283:	5a                   	pop    edx
    a284:	6a 00                	push   0x0
    a286:	68 f1 01 00 00       	push   0x1f1
    a28b:	e8 f0 0e 00 00       	call   b180 <_Z4outbth>
    a290:	59                   	pop    ecx
    a291:	89 f8                	mov    eax,edi
    a293:	5e                   	pop    esi
    a294:	0f b6 f8             	movzx  edi,al
    a297:	57                   	push   edi
    a298:	68 f2 01 00 00       	push   0x1f2
    a29d:	e8 de 0e 00 00       	call   b180 <_Z4outbth>
    a2a2:	5d                   	pop    ebp
    a2a3:	58                   	pop    eax
    a2a4:	0f b6 c3             	movzx  eax,bl
    a2a7:	50                   	push   eax
    a2a8:	68 f3 01 00 00       	push   0x1f3
    a2ad:	e8 ce 0e 00 00       	call   b180 <_Z4outbth>
    a2b2:	58                   	pop    eax
    a2b3:	5a                   	pop    edx
    a2b4:	0f b6 c7             	movzx  eax,bh
    a2b7:	50                   	push   eax
    a2b8:	68 f4 01 00 00       	push   0x1f4
    a2bd:	e8 be 0e 00 00       	call   b180 <_Z4outbth>
    a2c2:	89 d8                	mov    eax,ebx
    a2c4:	59                   	pop    ecx
    a2c5:	c1 e8 10             	shr    eax,0x10
    a2c8:	5e                   	pop    esi
    a2c9:	0f b6 c0             	movzx  eax,al
    a2cc:	50                   	push   eax
    a2cd:	68 f5 01 00 00       	push   0x1f5
    a2d2:	e8 a9 0e 00 00       	call   b180 <_Z4outbth>
    a2d7:	83 c4 10             	add    esp,0x10
    a2da:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a2e0:	83 ec 0c             	sub    esp,0xc
    a2e3:	68 f7 01 00 00       	push   0x1f7
    a2e8:	e8 e3 0e 00 00       	call   b1d0 <_Z3inbt>
    a2ed:	83 c4 10             	add    esp,0x10
    a2f0:	84 c0                	test   al,al
    a2f2:	78 ec                	js     a2e0 <_ZN3ata12lba28PIOReadEPvjhh+0x90>
    a2f4:	83 ec 08             	sub    esp,0x8
    a2f7:	6a 20                	push   0x20
    a2f9:	68 f7 01 00 00       	push   0x1f7
    a2fe:	e8 7d 0e 00 00       	call   b180 <_Z4outbth>
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
    a328:	e8 a3 0e 00 00       	call   b1d0 <_Z3inbt>
    a32d:	83 c4 10             	add    esp,0x10
    a330:	84 c0                	test   al,al
    a332:	78 ec                	js     a320 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a334:	83 ec 0c             	sub    esp,0xc
    a337:	68 f6 03 00 00       	push   0x3f6
    a33c:	e8 8f 0e 00 00       	call   b1d0 <_Z3inbt>
    a341:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a348:	e8 83 0e 00 00       	call   b1d0 <_Z3inbt>
    a34d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a354:	e8 77 0e 00 00       	call   b1d0 <_Z3inbt>
    a359:	83 c4 10             	add    esp,0x10
    a35c:	eb 06                	jmp    a364 <_ZN3ata12lba28PIOReadEPvjhh+0x114>
    a35e:	66 90                	xchg   ax,ax
    a360:	a8 08                	test   al,0x8
    a362:	75 1e                	jne    a382 <_ZN3ata12lba28PIOReadEPvjhh+0x132>
    a364:	83 ec 0c             	sub    esp,0xc
    a367:	68 f7 01 00 00       	push   0x1f7
    a36c:	e8 5f 0e 00 00       	call   b1d0 <_Z3inbt>
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
    a3a3:	e8 38 0e 00 00       	call   b1e0 <_Z3inwt>
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
    a467:	e8 14 0d 00 00       	call   b180 <_Z4outbth>
    a46c:	58                   	pop    eax
    a46d:	5a                   	pop    edx
    a46e:	6a 00                	push   0x0
    a470:	68 f1 01 00 00       	push   0x1f1
    a475:	e8 06 0d 00 00       	call   b180 <_Z4outbth>
    a47a:	59                   	pop    ecx
    a47b:	5e                   	pop    esi
    a47c:	0f b6 c7             	movzx  eax,bh
    a47f:	50                   	push   eax
    a480:	68 f2 01 00 00       	push   0x1f2
    a485:	e8 f6 0c 00 00       	call   b180 <_Z4outbth>
    a48a:	58                   	pop    eax
    a48b:	89 f8                	mov    eax,edi
    a48d:	0f ac e8 18          	shrd   eax,ebp,0x18
    a491:	5a                   	pop    edx
    a492:	0f b6 c0             	movzx  eax,al
    a495:	50                   	push   eax
    a496:	68 f3 01 00 00       	push   0x1f3
    a49b:	e8 e0 0c 00 00       	call   b180 <_Z4outbth>
    a4a0:	5e                   	pop    esi
    a4a1:	58                   	pop    eax
    a4a2:	89 e8                	mov    eax,ebp
    a4a4:	0f b6 c0             	movzx  eax,al
    a4a7:	50                   	push   eax
    a4a8:	68 f4 01 00 00       	push   0x1f4
    a4ad:	e8 ce 0c 00 00       	call   b180 <_Z4outbth>
    a4b2:	58                   	pop    eax
    a4b3:	89 e8                	mov    eax,ebp
    a4b5:	5a                   	pop    edx
    a4b6:	0f b6 c4             	movzx  eax,ah
    a4b9:	50                   	push   eax
    a4ba:	68 f5 01 00 00       	push   0x1f5
    a4bf:	e8 bc 0c 00 00       	call   b180 <_Z4outbth>
    a4c4:	59                   	pop    ecx
    a4c5:	5e                   	pop    esi
    a4c6:	0f b6 c3             	movzx  eax,bl
    a4c9:	50                   	push   eax
    a4ca:	68 f2 01 00 00       	push   0x1f2
    a4cf:	e8 ac 0c 00 00       	call   b180 <_Z4outbth>
    a4d4:	58                   	pop    eax
    a4d5:	89 f8                	mov    eax,edi
    a4d7:	5a                   	pop    edx
    a4d8:	0f b6 c0             	movzx  eax,al
    a4db:	50                   	push   eax
    a4dc:	68 f3 01 00 00       	push   0x1f3
    a4e1:	e8 9a 0c 00 00       	call   b180 <_Z4outbth>
    a4e6:	89 f8                	mov    eax,edi
    a4e8:	0f ac e8 08          	shrd   eax,ebp,0x8
    a4ec:	59                   	pop    ecx
    a4ed:	5e                   	pop    esi
    a4ee:	0f b6 c0             	movzx  eax,al
    a4f1:	50                   	push   eax
    a4f2:	68 f4 01 00 00       	push   0x1f4
    a4f7:	0f ac ef 10          	shrd   edi,ebp,0x10
    a4fb:	e8 80 0c 00 00       	call   b180 <_Z4outbth>
    a500:	5e                   	pop    esi
    a501:	58                   	pop    eax
    a502:	89 f8                	mov    eax,edi
    a504:	0f b6 f0             	movzx  esi,al
    a507:	56                   	push   esi
    a508:	68 f5 01 00 00       	push   0x1f5
    a50d:	e8 6e 0c 00 00       	call   b180 <_Z4outbth>
    a512:	83 c4 10             	add    esp,0x10
    a515:	8d 76 00             	lea    esi,[esi+0x0]
    a518:	83 ec 0c             	sub    esp,0xc
    a51b:	68 f7 01 00 00       	push   0x1f7
    a520:	e8 ab 0c 00 00       	call   b1d0 <_Z3inbt>
    a525:	83 c4 10             	add    esp,0x10
    a528:	84 c0                	test   al,al
    a52a:	78 ec                	js     a518 <_ZN3ata12lba48PIOReadEPvyth+0xd8>
    a52c:	83 ec 08             	sub    esp,0x8
    a52f:	89 df                	mov    edi,ebx
    a531:	6a 24                	push   0x24
    a533:	68 f7 01 00 00       	push   0x1f7
    a538:	e8 43 0c 00 00       	call   b180 <_Z4outbth>
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
    a568:	e8 63 0c 00 00       	call   b1d0 <_Z3inbt>
    a56d:	83 c4 10             	add    esp,0x10
    a570:	84 c0                	test   al,al
    a572:	78 ec                	js     a560 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a574:	83 ec 0c             	sub    esp,0xc
    a577:	68 f6 03 00 00       	push   0x3f6
    a57c:	e8 4f 0c 00 00       	call   b1d0 <_Z3inbt>
    a581:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a588:	e8 43 0c 00 00       	call   b1d0 <_Z3inbt>
    a58d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a594:	e8 37 0c 00 00       	call   b1d0 <_Z3inbt>
    a599:	83 c4 10             	add    esp,0x10
    a59c:	eb 06                	jmp    a5a4 <_ZN3ata12lba48PIOReadEPvyth+0x164>
    a59e:	66 90                	xchg   ax,ax
    a5a0:	a8 08                	test   al,0x8
    a5a2:	75 1e                	jne    a5c2 <_ZN3ata12lba48PIOReadEPvyth+0x182>
    a5a4:	83 ec 0c             	sub    esp,0xc
    a5a7:	68 f7 01 00 00       	push   0x1f7
    a5ac:	e8 1f 0c 00 00       	call   b1d0 <_Z3inbt>
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
    a5e3:	e8 f8 0b 00 00       	call   b1e0 <_Z3inwt>
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
    a6cd:	e8 fe 0a 00 00       	call   b1d0 <_Z3inbt>
    a6d2:	83 c4 10             	add    esp,0x10
    a6d5:	3c ff                	cmp    al,0xff
    a6d7:	0f 84 e3 00 00 00    	je     a7c0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a6dd:	c1 e3 04             	shl    ebx,0x4
    a6e0:	83 ec 08             	sub    esp,0x8
    a6e3:	83 cb a0             	or     ebx,0xffffffa0
    a6e6:	0f b6 c3             	movzx  eax,bl
    a6e9:	50                   	push   eax
    a6ea:	68 f6 01 00 00       	push   0x1f6
    a6ef:	e8 8c 0a 00 00       	call   b180 <_Z4outbth>
    a6f4:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a6fb:	e8 d0 0a 00 00       	call   b1d0 <_Z3inbt>
    a700:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a707:	e8 c4 0a 00 00       	call   b1d0 <_Z3inbt>
    a70c:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a713:	e8 b8 0a 00 00       	call   b1d0 <_Z3inbt>
    a718:	83 c4 10             	add    esp,0x10
    a71b:	90                   	nop
    a71c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a720:	83 ec 0c             	sub    esp,0xc
    a723:	68 f7 01 00 00       	push   0x1f7
    a728:	e8 a3 0a 00 00       	call   b1d0 <_Z3inbt>
    a72d:	83 c4 10             	add    esp,0x10
    a730:	84 c0                	test   al,al
    a732:	78 ec                	js     a720 <_ZN3ata12sendIdentifyEhRbb+0x70>
    a734:	83 ec 08             	sub    esp,0x8
    a737:	6a 00                	push   0x0
    a739:	68 f2 01 00 00       	push   0x1f2
    a73e:	e8 3d 0a 00 00       	call   b180 <_Z4outbth>
    a743:	59                   	pop    ecx
    a744:	5b                   	pop    ebx
    a745:	6a 00                	push   0x0
    a747:	68 f3 01 00 00       	push   0x1f3
    a74c:	e8 2f 0a 00 00       	call   b180 <_Z4outbth>
    a751:	5e                   	pop    esi
    a752:	5f                   	pop    edi
    a753:	6a 00                	push   0x0
    a755:	68 f4 01 00 00       	push   0x1f4
    a75a:	e8 21 0a 00 00       	call   b180 <_Z4outbth>
    a75f:	58                   	pop    eax
    a760:	5a                   	pop    edx
    a761:	6a 00                	push   0x0
    a763:	68 f5 01 00 00       	push   0x1f5
    a768:	e8 13 0a 00 00       	call   b180 <_Z4outbth>
    a76d:	59                   	pop    ecx
    a76e:	5b                   	pop    ebx
    a76f:	68 ec 00 00 00       	push   0xec
    a774:	68 f7 01 00 00       	push   0x1f7
    a779:	e8 02 0a 00 00       	call   b180 <_Z4outbth>
    a77e:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    a785:	e8 46 0a 00 00       	call   b1d0 <_Z3inbt>
    a78a:	83 c4 10             	add    esp,0x10
    a78d:	84 c0                	test   al,al
    a78f:	74 2f                	je     a7c0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a791:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a798:	83 ec 0c             	sub    esp,0xc
    a79b:	68 f7 01 00 00       	push   0x1f7
    a7a0:	e8 2b 0a 00 00       	call   b1d0 <_Z3inbt>
    a7a5:	83 c4 10             	add    esp,0x10
    a7a8:	84 c0                	test   al,al
    a7aa:	78 ec                	js     a798 <_ZN3ata12sendIdentifyEhRbb+0xe8>
    a7ac:	83 ec 0c             	sub    esp,0xc
    a7af:	68 f4 01 00 00       	push   0x1f4
    a7b4:	e8 17 0a 00 00       	call   b1d0 <_Z3inbt>
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
    a7d8:	e8 f3 09 00 00       	call   b1d0 <_Z3inbt>
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
    a7fc:	e8 cf 09 00 00       	call   b1d0 <_Z3inbt>
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
    a833:	e8 a8 09 00 00       	call   b1e0 <_Z3inwt>
    a838:	66 89 43 fe          	mov    WORD PTR [ebx-0x2],ax
    a83c:	83 c4 10             	add    esp,0x10
    a83f:	39 de                	cmp    esi,ebx
    a841:	75 e5                	jne    a828 <_ZN3ata12sendIdentifyEhRbb+0x178>
    a843:	0f b7 84 24 c6 00 00 	movzx  eax,WORD PTR [esp+0xc6]
    a84a:	00 
    a84b:	66 89 44 24 0a       	mov    WORD PTR [esp+0xa],ax
    a850:	89 e8                	mov    eax,ebp
    a852:	84 c0                	test   al,al
    a854:	75 22                	jne    a878 <_ZN3ata12sendIdentifyEhRbb+0x1c8>
    a856:	0f b7 44 24 0a       	movzx  eax,WORD PTR [esp+0xa]
    a85b:	8b 94 24 44 02 00 00 	mov    edx,DWORD PTR [esp+0x244]
    a862:	66 c1 e8 0a          	shr    ax,0xa
    a866:	83 f0 01             	xor    eax,0x1
    a869:	83 e0 01             	and    eax,0x1
    a86c:	88 02                	mov    BYTE PTR [edx],al
    a86e:	b8 01 00 00 00       	mov    eax,0x1
    a873:	e9 4a ff ff ff       	jmp    a7c2 <_ZN3ata12sendIdentifyEhRbb+0x112>
    a878:	83 ec 0c             	sub    esp,0xc
    a87b:	68 12 d1 00 00       	push   0xd112
    a880:	e8 bb 08 00 00       	call   b140 <_Z6printfPKc>
    a885:	83 c4 10             	add    esp,0x10
    a888:	8d 74 24 20          	lea    esi,[esp+0x20]
    a88c:	8d 6c 24 1c          	lea    ebp,[esp+0x1c]
    a890:	8d 7e 20             	lea    edi,[esi+0x20]
    a893:	90                   	nop
    a894:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a898:	0f b7 06             	movzx  eax,WORD PTR [esi]
    a89b:	83 ec 08             	sub    esp,0x8
    a89e:	83 c6 02             	add    esi,0x2
    a8a1:	66 89 44 24 24       	mov    WORD PTR [esp+0x24],ax
    a8a6:	55                   	push   ebp
    a8a7:	68 26 d1 00 00       	push   0xd126
    a8ac:	e8 df 17 00 00       	call   c090 <_Z14_manage_escapeItEiPKcPT_>
    a8b1:	05 26 d1 00 00       	add    eax,0xd126
    a8b6:	89 04 24             	mov    DWORD PTR [esp],eax
    a8b9:	e8 82 08 00 00       	call   b140 <_Z6printfPKc>
    a8be:	83 c4 10             	add    esp,0x10
    a8c1:	39 f7                	cmp    edi,esi
    a8c3:	75 d3                	jne    a898 <_ZN3ata12sendIdentifyEhRbb+0x1e8>
    a8c5:	83 ec 0c             	sub    esp,0xc
    a8c8:	68 82 d1 00 00       	push   0xd182
    a8cd:	e8 6e 08 00 00       	call   b140 <_Z6printfPKc>
    a8d2:	83 c4 10             	add    esp,0x10
    a8d5:	39 fb                	cmp    ebx,edi
    a8d7:	75 b7                	jne    a890 <_ZN3ata12sendIdentifyEhRbb+0x1e0>
    a8d9:	0f b7 84 24 d0 00 00 	movzx  eax,WORD PTR [esp+0xd0]
    a8e0:	00 
    a8e1:	31 ed                	xor    ebp,ebp
    a8e3:	50                   	push   eax
    a8e4:	0f b7 44 24 0e       	movzx  eax,WORD PTR [esp+0xe]
    a8e9:	50                   	push   eax
    a8ea:	0f b7 44 24 28       	movzx  eax,WORD PTR [esp+0x28]
    a8ef:	50                   	push   eax
    a8f0:	68 29 d1 00 00       	push   0xd129
    a8f5:	e8 a6 18 00 00       	call   c1a0 <_Z6printfItJttEEvPKcT_DpT0_>
    a8fa:	58                   	pop    eax
    a8fb:	5a                   	pop    edx
    a8fc:	ff b4 24 a0 00 00 00 	push   DWORD PTR [esp+0xa0]
    a903:	68 41 d1 00 00       	push   0xd141
    a908:	e8 c3 13 00 00       	call   bcd0 <_Z6printfIiEvPKcT_>
    a90d:	0f b7 84 24 fc 00 00 	movzx  eax,WORD PTR [esp+0xfc]
    a914:	00 
    a915:	0f b7 bc 24 fe 00 00 	movzx  edi,WORD PTR [esp+0xfe]
    a91c:	00 
    a91d:	ba 31 00 00 00       	mov    edx,0x31
    a922:	89 c6                	mov    esi,eax
    a924:	0f b7 84 24 fa 00 00 	movzx  eax,WORD PTR [esp+0xfa]
    a92b:	00 
    a92c:	66 89 44 24 1c       	mov    WORD PTR [esp+0x1c],ax
    a931:	0f b7 84 24 f8 00 00 	movzx  eax,WORD PTR [esp+0xf8]
    a938:	00 
    a939:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    a93e:	83 c4 10             	add    esp,0x10
    a941:	8d 5d 01             	lea    ebx,[ebp+0x1]
    a944:	80 fa 25             	cmp    dl,0x25
    a947:	0f b6 83 4e d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd14e]
    a94e:	8d 8b 4e d1 00 00    	lea    ecx,[ebx+0xd14e]
    a954:	75 21                	jne    a977 <_ZN3ata12sendIdentifyEhRbb+0x2c7>
    a956:	3c 25                	cmp    al,0x25
    a958:	0f 84 9d 00 00 00    	je     a9fb <_ZN3ata12sendIdentifyEhRbb+0x34b>
    a95e:	84 c0                	test   al,al
    a960:	75 6e                	jne    a9d0 <_ZN3ata12sendIdentifyEhRbb+0x320>
    a962:	8d 5d 02             	lea    ebx,[ebp+0x2]
    a965:	0f b6 83 4e d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd14e]
    a96c:	84 c0                	test   al,al
    a96e:	74 20                	je     a990 <_ZN3ata12sendIdentifyEhRbb+0x2e0>
    a970:	0f be d0             	movsx  edx,al
    a973:	89 dd                	mov    ebp,ebx
    a975:	eb ca                	jmp    a941 <_ZN3ata12sendIdentifyEhRbb+0x291>
    a977:	88 44 24 0f          	mov    BYTE PTR [esp+0xf],al
    a97b:	83 ec 0c             	sub    esp,0xc
    a97e:	52                   	push   edx
    a97f:	e8 3c 07 00 00       	call   b0c0 <_Z7putcharc>
    a984:	83 c4 10             	add    esp,0x10
    a987:	0f b6 44 24 0f       	movzx  eax,BYTE PTR [esp+0xf]
    a98c:	84 c0                	test   al,al
    a98e:	75 e0                	jne    a970 <_ZN3ata12sendIdentifyEhRbb+0x2c0>
    a990:	8d 5c 24 56          	lea    ebx,[esp+0x56]
    a994:	8d 7c 24 7e          	lea    edi,[esp+0x7e]
    a998:	90                   	nop
    a999:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a9a0:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    a9a3:	83 ec 08             	sub    esp,0x8
    a9a6:	83 c3 01             	add    ebx,0x1
    a9a9:	50                   	push   eax
    a9aa:	68 66 d1 00 00       	push   0xd166
    a9af:	e8 ec 14 00 00       	call   bea0 <_Z6printfIcEvPKcT_>
    a9b4:	83 c4 10             	add    esp,0x10
    a9b7:	39 df                	cmp    edi,ebx
    a9b9:	75 e5                	jne    a9a0 <_ZN3ata12sendIdentifyEhRbb+0x2f0>
    a9bb:	83 ec 0c             	sub    esp,0xc
    a9be:	68 82 d1 00 00       	push   0xd182
    a9c3:	e8 78 07 00 00       	call   b140 <_Z6printfPKc>
    a9c8:	83 c4 10             	add    esp,0x10
    a9cb:	e9 86 fe ff ff       	jmp    a856 <_ZN3ata12sendIdentifyEhRbb+0x1a6>
    a9d0:	83 ec 08             	sub    esp,0x8
    a9d3:	8d 44 24 26          	lea    eax,[esp+0x26]
    a9d7:	50                   	push   eax
    a9d8:	51                   	push   ecx
    a9d9:	e8 b2 16 00 00       	call   c090 <_Z14_manage_escapeItEiPKcPT_>
    a9de:	0f b7 d6             	movzx  edx,si
    a9e1:	57                   	push   edi
    a9e2:	8d 84 03 4e d1 00 00 	lea    eax,[ebx+eax*1+0xd14e]
    a9e9:	52                   	push   edx
    a9ea:	0f b7 54 24 24       	movzx  edx,WORD PTR [esp+0x24]
    a9ef:	52                   	push   edx
    a9f0:	50                   	push   eax
    a9f1:	e8 aa 17 00 00       	call   c1a0 <_Z6printfItJttEEvPKcT_DpT0_>
    a9f6:	83 c4 20             	add    esp,0x20
    a9f9:	eb 95                	jmp    a990 <_ZN3ata12sendIdentifyEhRbb+0x2e0>
    a9fb:	83 ec 0c             	sub    esp,0xc
    a9fe:	8d 5d 02             	lea    ebx,[ebp+0x2]
    aa01:	6a 25                	push   0x25
    aa03:	e8 b8 06 00 00       	call   b0c0 <_Z7putcharc>
    aa08:	0f b6 83 4e d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd14e]
    aa0f:	83 c4 10             	add    esp,0x10
    aa12:	84 c0                	test   al,al
    aa14:	0f 85 56 ff ff ff    	jne    a970 <_ZN3ata12sendIdentifyEhRbb+0x2c0>
    aa1a:	e9 71 ff ff ff       	jmp    a990 <_ZN3ata12sendIdentifyEhRbb+0x2e0>
    aa1f:	90                   	nop

0000aa20 <_ZN6paging18init_kernel_pagingEv>:
    aa20:	57                   	push   edi
    aa21:	56                   	push   esi
    aa22:	b8 00 00 10 00       	mov    eax,0x100000
    aa27:	53                   	push   ebx
    aa28:	90                   	nop
    aa29:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    aa30:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    aa36:	83 c0 04             	add    eax,0x4
    aa39:	3d 00 10 10 00       	cmp    eax,0x101000
    aa3e:	75 f0                	jne    aa30 <_ZN6paging18init_kernel_pagingEv+0x10>
    aa40:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    aa46:	83 c0 04             	add    eax,0x4
    aa49:	3d 00 10 50 00       	cmp    eax,0x501000
    aa4e:	75 f0                	jne    aa40 <_ZN6paging18init_kernel_pagingEv+0x20>
    aa50:	c7 05 00 00 10 00 87 	mov    DWORD PTR ds:0x100000,0x87
    aa57:	00 00 00 
    aa5a:	c7 05 04 00 10 00 87 	mov    DWORD PTR ds:0x100004,0x400087
    aa61:	00 40 00 
    aa64:	c7 05 08 0c 10 00 87 	mov    DWORD PTR ds:0x100c08,0x800087
    aa6b:	00 80 00 
    aa6e:	c7 05 0c 0c 10 00 87 	mov    DWORD PTR ds:0x100c0c,0xc00087
    aa75:	00 c0 00 
    aa78:	c7 05 10 0c 10 00 87 	mov    DWORD PTR ds:0x100c10,0x1000087
    aa7f:	00 00 01 
    aa82:	c7 05 14 0c 10 00 87 	mov    DWORD PTR ds:0x100c14,0x1400087
    aa89:	00 40 01 
    aa8c:	c7 05 18 0c 10 00 87 	mov    DWORD PTR ds:0x100c18,0x1800087
    aa93:	00 80 01 
    aa96:	c7 05 1c 0c 10 00 87 	mov    DWORD PTR ds:0x100c1c,0x1c00087
    aa9d:	00 c0 01 
    aaa0:	c7 05 20 0c 10 00 87 	mov    DWORD PTR ds:0x100c20,0x2000087
    aaa7:	00 00 02 
    aaaa:	c7 05 24 0c 10 00 87 	mov    DWORD PTR ds:0x100c24,0x2400087
    aab1:	00 40 02 
    aab4:	c7 05 28 0c 10 00 87 	mov    DWORD PTR ds:0x100c28,0x2800087
    aabb:	00 80 02 
    aabe:	c7 05 2c 0c 10 00 87 	mov    DWORD PTR ds:0x100c2c,0x2c00087
    aac5:	00 c0 02 
    aac8:	c7 05 30 0c 10 00 87 	mov    DWORD PTR ds:0x100c30,0x3000087
    aacf:	00 00 03 
    aad2:	c7 05 34 0c 10 00 87 	mov    DWORD PTR ds:0x100c34,0x3400087
    aad9:	00 40 03 
    aadc:	c7 05 38 0c 10 00 87 	mov    DWORD PTR ds:0x100c38,0x3800087
    aae3:	00 80 03 
    aae6:	c7 05 3c 0c 10 00 87 	mov    DWORD PTR ds:0x100c3c,0x3c00087
    aaed:	00 c0 03 
    aaf0:	e8 bb 00 00 00       	call   abb0 <_ZN4boot12get_ram_sizeEv>
    aaf5:	89 c3                	mov    ebx,eax
    aaf7:	c1 eb 16             	shr    ebx,0x16
    aafa:	83 eb 10             	sub    ebx,0x10
    aafd:	d1 eb                	shr    ebx,1
    aaff:	e8 ac 00 00 00       	call   abb0 <_ZN4boot12get_ram_sizeEv>
    ab04:	8d 53 10             	lea    edx,[ebx+0x10]
    ab07:	c1 e8 16             	shr    eax,0x16
    ab0a:	b9 10 00 00 00       	mov    ecx,0x10
    ab0f:	89 c6                	mov    esi,eax
    ab11:	c1 e2 0a             	shl    edx,0xa
    ab14:	83 fb 10             	cmp    ebx,0x10
    ab17:	76 28                	jbe    ab41 <_ZN6paging18init_kernel_pagingEv+0x121>
    ab19:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ab20:	a1 00 00 00 02       	mov    eax,ds:0x2000000
    ab25:	8d 78 01             	lea    edi,[eax+0x1]
    ab28:	89 3d 00 00 00 02    	mov    DWORD PTR ds:0x2000000,edi
    ab2e:	89 cf                	mov    edi,ecx
    ab30:	83 c1 01             	add    ecx,0x1
    ab33:	c1 e7 16             	shl    edi,0x16
    ab36:	39 cb                	cmp    ebx,ecx
    ab38:	89 3c 85 08 00 00 02 	mov    DWORD PTR [eax*4+0x2000008],edi
    ab3f:	75 df                	jne    ab20 <_ZN6paging18init_kernel_pagingEv+0x100>
    ab41:	39 d6                	cmp    esi,edx
    ab43:	76 2a                	jbe    ab6f <_ZN6paging18init_kernel_pagingEv+0x14f>
    ab45:	c1 e2 0c             	shl    edx,0xc
    ab48:	c1 e6 0c             	shl    esi,0xc
    ab4b:	90                   	nop
    ab4c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ab50:	a1 04 00 00 02       	mov    eax,ds:0x2000004
    ab55:	8d 48 01             	lea    ecx,[eax+0x1]
    ab58:	89 0d 04 00 00 02    	mov    DWORD PTR ds:0x2000004,ecx
    ab5e:	89 14 85 08 10 00 02 	mov    DWORD PTR [eax*4+0x2001008],edx
    ab65:	81 c2 00 10 00 00    	add    edx,0x1000
    ab6b:	39 d6                	cmp    esi,edx
    ab6d:	75 e1                	jne    ab50 <_ZN6paging18init_kernel_pagingEv+0x130>
    ab6f:	83 ec 0c             	sub    esp,0xc
    ab72:	68 00 00 10 00       	push   0x100000
    ab77:	e8 f3 f5 ff ff       	call   a16f <__setCR3>
    ab7c:	e8 ea f5 ff ff       	call   a16b <__getCR4>
    ab81:	83 c8 10             	or     eax,0x10
    ab84:	89 04 24             	mov    DWORD PTR [esp],eax
    ab87:	e8 d4 f5 ff ff       	call   a160 <__setCR4>
    ab8c:	e8 07 f6 ff ff       	call   a198 <__getCR0>
    ab91:	0d 01 00 00 80       	or     eax,0x80000001
    ab96:	89 04 24             	mov    DWORD PTR [esp],eax
    ab99:	e8 ef f5 ff ff       	call   a18d <__setCR0>
    ab9e:	83 c4 10             	add    esp,0x10
    aba1:	5b                   	pop    ebx
    aba2:	5e                   	pop    esi
    aba3:	5f                   	pop    edi
    aba4:	c3                   	ret    
    aba5:	66 90                	xchg   ax,ax
    aba7:	66 90                	xchg   ax,ax
    aba9:	66 90                	xchg   ax,ax
    abab:	66 90                	xchg   ax,ax
    abad:	66 90                	xchg   ax,ax
    abaf:	90                   	nop

0000abb0 <_ZN4boot12get_ram_sizeEv>:
    abb0:	0f b7 05 02 05 00 00 	movzx  eax,WORD PTR ds:0x502
    abb7:	0f b7 15 00 05 00 00 	movzx  edx,WORD PTR ds:0x500
    abbe:	c1 e0 06             	shl    eax,0x6
    abc1:	01 d0                	add    eax,edx
    abc3:	c1 e0 0a             	shl    eax,0xa
    abc6:	c3                   	ret    
    abc7:	66 90                	xchg   ax,ax
    abc9:	66 90                	xchg   ax,ax
    abcb:	66 90                	xchg   ax,ax
    abcd:	66 90                	xchg   ax,ax
    abcf:	90                   	nop

0000abd0 <_ZN3VGA17_actualize_cursorEv>:
    abd0:	53                   	push   ebx
    abd1:	83 ec 10             	sub    esp,0x10
    abd4:	8b 1d 04 00 01 00    	mov    ebx,DWORD PTR ds:0x10004
    abda:	6a 0e                	push   0xe
    abdc:	68 d4 03 00 00       	push   0x3d4
    abe1:	8d 1c 9b             	lea    ebx,[ebx+ebx*4]
    abe4:	c1 e3 04             	shl    ebx,0x4
    abe7:	66 03 1d 00 00 01 00 	add    bx,WORD PTR ds:0x10000
    abee:	e8 8d 05 00 00       	call   b180 <_Z4outbth>
    abf3:	58                   	pop    eax
    abf4:	5a                   	pop    edx
    abf5:	0f b6 c7             	movzx  eax,bh
    abf8:	0f b6 db             	movzx  ebx,bl
    abfb:	50                   	push   eax
    abfc:	68 d5 03 00 00       	push   0x3d5
    ac01:	e8 7a 05 00 00       	call   b180 <_Z4outbth>
    ac06:	59                   	pop    ecx
    ac07:	58                   	pop    eax
    ac08:	6a 0f                	push   0xf
    ac0a:	68 d4 03 00 00       	push   0x3d4
    ac0f:	e8 6c 05 00 00       	call   b180 <_Z4outbth>
    ac14:	58                   	pop    eax
    ac15:	5a                   	pop    edx
    ac16:	53                   	push   ebx
    ac17:	68 d5 03 00 00       	push   0x3d5
    ac1c:	e8 5f 05 00 00       	call   b180 <_Z4outbth>
    ac21:	83 c4 18             	add    esp,0x18
    ac24:	5b                   	pop    ebx
    ac25:	c3                   	ret    
    ac26:	8d 76 00             	lea    esi,[esi+0x0]
    ac29:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ac30 <_ZN3VGA14_pos_in_screenEii>:
    ac30:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    ac34:	8d 04 80             	lea    eax,[eax+eax*4]
    ac37:	c1 e0 04             	shl    eax,0x4
    ac3a:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    ac3e:	01 c0                	add    eax,eax
    ac40:	c3                   	ret    
    ac41:	eb 0d                	jmp    ac50 <_ZN3VGA12_char_val_atEii>
    ac43:	90                   	nop
    ac44:	90                   	nop
    ac45:	90                   	nop
    ac46:	90                   	nop
    ac47:	90                   	nop
    ac48:	90                   	nop
    ac49:	90                   	nop
    ac4a:	90                   	nop
    ac4b:	90                   	nop
    ac4c:	90                   	nop
    ac4d:	90                   	nop
    ac4e:	90                   	nop
    ac4f:	90                   	nop

0000ac50 <_ZN3VGA12_char_val_atEii>:
    ac50:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    ac54:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ac5a:	8d 04 80             	lea    eax,[eax+eax*4]
    ac5d:	c1 e0 04             	shl    eax,0x4
    ac60:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    ac64:	8d 04 42             	lea    eax,[edx+eax*2]
    ac67:	c3                   	ret    
    ac68:	90                   	nop
    ac69:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000ac70 <_ZN3VGA13_char_mode_atEii>:
    ac70:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    ac74:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ac7a:	8d 04 80             	lea    eax,[eax+eax*4]
    ac7d:	c1 e0 04             	shl    eax,0x4
    ac80:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    ac84:	8d 44 42 01          	lea    eax,[edx+eax*2+0x1]
    ac88:	c3                   	ret    
    ac89:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000ac90 <_ZN3VGA6scrollEc>:
    ac90:	55                   	push   ebp
    ac91:	57                   	push   edi
    ac92:	31 ed                	xor    ebp,ebp
    ac94:	56                   	push   esi
    ac95:	53                   	push   ebx
    ac96:	be 40 01 00 00       	mov    esi,0x140
    ac9b:	bf 50 00 00 00       	mov    edi,0x50
    aca0:	83 ec 1c             	sub    esp,0x1c
    aca3:	0f b6 44 24 30       	movzx  eax,BYTE PTR [esp+0x30]
    aca8:	88 44 24 0f          	mov    BYTE PTR [esp+0xf],al
    acac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    acb0:	89 e9                	mov    ecx,ebp
    acb2:	8d 04 3f             	lea    eax,[edi+edi*1]
    acb5:	29 f9                	sub    ecx,edi
    acb7:	01 c9                	add    ecx,ecx
    acb9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    acc0:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    acc6:	0f b6 1c 02          	movzx  ebx,BYTE PTR [edx+eax*1]
    acca:	01 ca                	add    edx,ecx
    accc:	88 1c 02             	mov    BYTE PTR [edx+eax*1],bl
    accf:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    acd5:	0f b6 5c 02 01       	movzx  ebx,BYTE PTR [edx+eax*1+0x1]
    acda:	01 ca                	add    edx,ecx
    acdc:	83 c0 02             	add    eax,0x2
    acdf:	88 5c 10 ff          	mov    BYTE PTR [eax+edx*1-0x1],bl
    ace3:	39 f0                	cmp    eax,esi
    ace5:	75 d9                	jne    acc0 <_ZN3VGA6scrollEc+0x30>
    ace7:	83 c7 50             	add    edi,0x50
    acea:	83 c5 50             	add    ebp,0x50
    aced:	8d b0 a0 00 00 00    	lea    esi,[eax+0xa0]
    acf3:	81 ff d0 07 00 00    	cmp    edi,0x7d0
    acf9:	75 b5                	jne    acb0 <_ZN3VGA6scrollEc+0x20>
    acfb:	0f b6 4c 24 0f       	movzx  ecx,BYTE PTR [esp+0xf]
    ad00:	b8 00 0f 00 00       	mov    eax,0xf00
    ad05:	8d 76 00             	lea    esi,[esi+0x0]
    ad08:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad0e:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    ad12:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad18:	88 4c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],cl
    ad1c:	83 c0 02             	add    eax,0x2
    ad1f:	3d a0 0f 00 00       	cmp    eax,0xfa0
    ad24:	75 e2                	jne    ad08 <_ZN3VGA6scrollEc+0x78>
    ad26:	a1 04 00 01 00       	mov    eax,ds:0x10004
    ad2b:	ba 00 00 00 00       	mov    edx,0x0
    ad30:	83 e8 01             	sub    eax,0x1
    ad33:	0f 48 c2             	cmovs  eax,edx
    ad36:	a3 04 00 01 00       	mov    ds:0x10004,eax
    ad3b:	83 c4 1c             	add    esp,0x1c
    ad3e:	5b                   	pop    ebx
    ad3f:	5e                   	pop    esi
    ad40:	5f                   	pop    edi
    ad41:	5d                   	pop    ebp
    ad42:	e9 89 fe ff ff       	jmp    abd0 <_ZN3VGA17_actualize_cursorEv>
    ad47:	89 f6                	mov    esi,esi
    ad49:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ad50 <_ZN3VGA12clear_screenEc>:
    ad50:	53                   	push   ebx
    ad51:	0f b6 5c 24 08       	movzx  ebx,BYTE PTR [esp+0x8]
    ad56:	31 c0                	xor    eax,eax
    ad58:	90                   	nop
    ad59:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ad60:	8d 88 a0 00 00 00    	lea    ecx,[eax+0xa0]
    ad66:	8d 76 00             	lea    esi,[esi+0x0]
    ad69:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ad70:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad76:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    ad7a:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad80:	88 5c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],bl
    ad84:	83 c0 02             	add    eax,0x2
    ad87:	39 c1                	cmp    ecx,eax
    ad89:	75 e5                	jne    ad70 <_ZN3VGA12clear_screenEc+0x20>
    ad8b:	81 f9 a0 0f 00 00    	cmp    ecx,0xfa0
    ad91:	75 cd                	jne    ad60 <_ZN3VGA12clear_screenEc+0x10>
    ad93:	5b                   	pop    ebx
    ad94:	c7 05 04 00 01 00 00 	mov    DWORD PTR ds:0x10004,0x0
    ad9b:	00 00 00 
    ad9e:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ada5:	00 00 00 
    ada8:	e9 23 fe ff ff       	jmp    abd0 <_ZN3VGA17_actualize_cursorEv>
    adad:	8d 76 00             	lea    esi,[esi+0x0]

0000adb0 <_ZN3VGA7putcharEcc>:
    adb0:	55                   	push   ebp
    adb1:	57                   	push   edi
    adb2:	56                   	push   esi
    adb3:	53                   	push   ebx
    adb4:	83 ec 1c             	sub    esp,0x1c
    adb7:	8b 3d 04 00 01 00    	mov    edi,DWORD PTR ds:0x10004
    adbd:	8b 5c 24 30          	mov    ebx,DWORD PTR [esp+0x30]
    adc1:	8b 4c 24 34          	mov    ecx,DWORD PTR [esp+0x34]
    adc5:	80 fb 0a             	cmp    bl,0xa
    adc8:	0f 84 d2 00 00 00    	je     aea0 <_ZN3VGA7putcharEcc+0xf0>
    adce:	80 fb 09             	cmp    bl,0x9
    add1:	0f 85 99 00 00 00    	jne    ae70 <_ZN3VGA7putcharEcc+0xc0>
    add7:	a1 00 00 01 00       	mov    eax,ds:0x10000
    addc:	31 f6                	xor    esi,esi
    adde:	8d 50 04             	lea    edx,[eax+0x4]
    ade1:	83 e2 fc             	and    edx,0xfffffffc
    ade4:	83 fa 4f             	cmp    edx,0x4f
    ade7:	89 15 00 00 01 00    	mov    DWORD PTR ds:0x10000,edx
    aded:	0f 8e 15 01 00 00    	jle    af08 <_ZN3VGA7putcharEcc+0x158>
    adf3:	bd cd cc cc cc       	mov    ebp,0xcccccccd
    adf8:	89 d0                	mov    eax,edx
    adfa:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ae01:	00 00 00 
    ae04:	f7 e5                	mul    ebp
    ae06:	c1 ea 06             	shr    edx,0x6
    ae09:	01 fa                	add    edx,edi
    ae0b:	83 fa 18             	cmp    edx,0x18
    ae0e:	89 15 04 00 01 00    	mov    DWORD PTR ds:0x10004,edx
    ae14:	0f 8f ce 00 00 00    	jg     aee8 <_ZN3VGA7putcharEcc+0x138>
    ae1a:	89 f0                	mov    eax,esi
    ae1c:	84 c0                	test   al,al
    ae1e:	74 3f                	je     ae5f <_ZN3VGA7putcharEcc+0xaf>
    ae20:	8b 3d 04 00 01 00    	mov    edi,DWORD PTR ds:0x10004
    ae26:	8b 2d 00 00 01 00    	mov    ebp,DWORD PTR ds:0x10000
    ae2c:	8d 04 bf             	lea    eax,[edi+edi*4]
    ae2f:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ae35:	c1 e0 04             	shl    eax,0x4
    ae38:	01 e8                	add    eax,ebp
    ae3a:	88 1c 42             	mov    BYTE PTR [edx+eax*2],bl
    ae3d:	a1 04 00 01 00       	mov    eax,ds:0x10004
    ae42:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ae48:	8d 04 80             	lea    eax,[eax+eax*4]
    ae4b:	c1 e0 04             	shl    eax,0x4
    ae4e:	03 05 00 00 01 00    	add    eax,DWORD PTR ds:0x10000
    ae54:	88 4c 42 01          	mov    BYTE PTR [edx+eax*2+0x1],cl
    ae58:	83 05 00 00 01 00 01 	add    DWORD PTR ds:0x10000,0x1
    ae5f:	83 c4 1c             	add    esp,0x1c
    ae62:	5b                   	pop    ebx
    ae63:	5e                   	pop    esi
    ae64:	5f                   	pop    edi
    ae65:	5d                   	pop    ebp
    ae66:	e9 65 fd ff ff       	jmp    abd0 <_ZN3VGA17_actualize_cursorEv>
    ae6b:	90                   	nop
    ae6c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ae70:	80 fb 0d             	cmp    bl,0xd
    ae73:	75 4f                	jne    aec4 <_ZN3VGA7putcharEcc+0x114>
    ae75:	83 ff 18             	cmp    edi,0x18
    ae78:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ae7f:	00 00 00 
    ae82:	7e db                	jle    ae5f <_ZN3VGA7putcharEcc+0xaf>
    ae84:	83 ec 0c             	sub    esp,0xc
    ae87:	0f be c9             	movsx  ecx,cl
    ae8a:	51                   	push   ecx
    ae8b:	e8 00 fe ff ff       	call   ac90 <_ZN3VGA6scrollEc>
    ae90:	83 c4 10             	add    esp,0x10
    ae93:	83 c4 1c             	add    esp,0x1c
    ae96:	5b                   	pop    ebx
    ae97:	5e                   	pop    esi
    ae98:	5f                   	pop    edi
    ae99:	5d                   	pop    ebp
    ae9a:	e9 31 fd ff ff       	jmp    abd0 <_ZN3VGA17_actualize_cursorEv>
    ae9f:	90                   	nop
    aea0:	8d 57 01             	lea    edx,[edi+0x1]
    aea3:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    aeaa:	00 00 00 
    aead:	83 fa 18             	cmp    edx,0x18
    aeb0:	89 15 04 00 01 00    	mov    DWORD PTR ds:0x10004,edx
    aeb6:	7f cc                	jg     ae84 <_ZN3VGA7putcharEcc+0xd4>
    aeb8:	83 c4 1c             	add    esp,0x1c
    aebb:	5b                   	pop    ebx
    aebc:	5e                   	pop    esi
    aebd:	5f                   	pop    edi
    aebe:	5d                   	pop    ebp
    aebf:	e9 0c fd ff ff       	jmp    abd0 <_ZN3VGA17_actualize_cursorEv>
    aec4:	8b 2d 00 00 01 00    	mov    ebp,DWORD PTR ds:0x10000
    aeca:	be 01 00 00 00       	mov    esi,0x1
    aecf:	83 fd 4f             	cmp    ebp,0x4f
    aed2:	89 ea                	mov    edx,ebp
    aed4:	0f 8f 19 ff ff ff    	jg     adf3 <_ZN3VGA7putcharEcc+0x43>
    aeda:	83 ff 18             	cmp    edi,0x18
    aedd:	0f 8e 49 ff ff ff    	jle    ae2c <_ZN3VGA7putcharEcc+0x7c>
    aee3:	90                   	nop
    aee4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    aee8:	83 ec 0c             	sub    esp,0xc
    aeeb:	0f be c1             	movsx  eax,cl
    aeee:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    aef2:	50                   	push   eax
    aef3:	e8 98 fd ff ff       	call   ac90 <_ZN3VGA6scrollEc>
    aef8:	83 c4 10             	add    esp,0x10
    aefb:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    aeff:	e9 16 ff ff ff       	jmp    ae1a <_ZN3VGA7putcharEcc+0x6a>
    af04:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    af08:	83 ff 18             	cmp    edi,0x18
    af0b:	0f 8e 4e ff ff ff    	jle    ae5f <_ZN3VGA7putcharEcc+0xaf>
    af11:	eb d5                	jmp    aee8 <_ZN3VGA7putcharEcc+0x138>
    af13:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    af19:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000af20 <_ZN3VGA5printEPKcc>:
    af20:	56                   	push   esi
    af21:	53                   	push   ebx
    af22:	83 ec 04             	sub    esp,0x4
    af25:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    af29:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    af2d:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    af30:	84 c0                	test   al,al
    af32:	74 24                	je     af58 <_ZN3VGA5printEPKcc+0x38>
    af34:	0f be f2             	movsx  esi,dl
    af37:	83 c3 01             	add    ebx,0x1
    af3a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    af40:	83 ec 08             	sub    esp,0x8
    af43:	83 c3 01             	add    ebx,0x1
    af46:	56                   	push   esi
    af47:	50                   	push   eax
    af48:	e8 63 fe ff ff       	call   adb0 <_ZN3VGA7putcharEcc>
    af4d:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    af51:	83 c4 10             	add    esp,0x10
    af54:	84 c0                	test   al,al
    af56:	75 e8                	jne    af40 <_ZN3VGA5printEPKcc+0x20>
    af58:	83 c4 04             	add    esp,0x4
    af5b:	5b                   	pop    ebx
    af5c:	5e                   	pop    esi
    af5d:	c3                   	ret    
    af5e:	66 90                	xchg   ax,ax

0000af60 <_ZN3VGA17_put_nbr_base_recEii>:
    af60:	53                   	push   ebx
    af61:	83 ec 08             	sub    esp,0x8
    af64:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    af68:	8b 4c 24 14          	mov    ecx,DWORD PTR [esp+0x14]
    af6c:	85 c0                	test   eax,eax
    af6e:	75 08                	jne    af78 <_ZN3VGA17_put_nbr_base_recEii+0x18>
    af70:	83 c4 08             	add    esp,0x8
    af73:	5b                   	pop    ebx
    af74:	c3                   	ret    
    af75:	8d 76 00             	lea    esi,[esi+0x0]
    af78:	99                   	cdq    
    af79:	83 ec 08             	sub    esp,0x8
    af7c:	f7 f9                	idiv   ecx
    af7e:	51                   	push   ecx
    af7f:	50                   	push   eax
    af80:	89 d3                	mov    ebx,edx
    af82:	e8 d9 ff ff ff       	call   af60 <_ZN3VGA17_put_nbr_base_recEii>
    af87:	0f be 83 00 f0 00 00 	movsx  eax,BYTE PTR [ebx+0xf000]
    af8e:	c7 44 24 24 0f 00 00 	mov    DWORD PTR [esp+0x24],0xf
    af95:	00 
    af96:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    af9a:	83 c4 18             	add    esp,0x18
    af9d:	5b                   	pop    ebx
    af9e:	e9 0d fe ff ff       	jmp    adb0 <_ZN3VGA7putcharEcc>
    afa3:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    afa9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000afb0 <_ZN3VGA13_put_nbr_baseEii>:
    afb0:	56                   	push   esi
    afb1:	53                   	push   ebx
    afb2:	83 ec 14             	sub    esp,0x14
    afb5:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    afb9:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    afbd:	85 c0                	test   eax,eax
    afbf:	78 4f                	js     b010 <_ZN3VGA13_put_nbr_baseEii+0x60>
    afc1:	74 2d                	je     aff0 <_ZN3VGA13_put_nbr_baseEii+0x40>
    afc3:	99                   	cdq    
    afc4:	83 ec 08             	sub    esp,0x8
    afc7:	f7 fb                	idiv   ebx
    afc9:	53                   	push   ebx
    afca:	50                   	push   eax
    afcb:	89 d6                	mov    esi,edx
    afcd:	e8 8e ff ff ff       	call   af60 <_ZN3VGA17_put_nbr_base_recEii>
    afd2:	0f be 86 00 f0 00 00 	movsx  eax,BYTE PTR [esi+0xf000]
    afd9:	c7 44 24 34 0f 00 00 	mov    DWORD PTR [esp+0x34],0xf
    afe0:	00 
    afe1:	89 44 24 30          	mov    DWORD PTR [esp+0x30],eax
    afe5:	83 c4 24             	add    esp,0x24
    afe8:	5b                   	pop    ebx
    afe9:	5e                   	pop    esi
    afea:	e9 c1 fd ff ff       	jmp    adb0 <_ZN3VGA7putcharEcc>
    afef:	90                   	nop
    aff0:	0f be 05 00 f0 00 00 	movsx  eax,BYTE PTR ds:0xf000
    aff7:	c7 44 24 24 0f 00 00 	mov    DWORD PTR [esp+0x24],0xf
    affe:	00 
    afff:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    b003:	83 c4 14             	add    esp,0x14
    b006:	5b                   	pop    ebx
    b007:	5e                   	pop    esi
    b008:	e9 a3 fd ff ff       	jmp    adb0 <_ZN3VGA7putcharEcc>
    b00d:	8d 76 00             	lea    esi,[esi+0x0]
    b010:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    b014:	83 ec 08             	sub    esp,0x8
    b017:	6a 0f                	push   0xf
    b019:	6a 2d                	push   0x2d
    b01b:	e8 90 fd ff ff       	call   adb0 <_ZN3VGA7putcharEcc>
    b020:	83 c4 10             	add    esp,0x10
    b023:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b027:	eb 9a                	jmp    afc3 <_ZN3VGA13_put_nbr_baseEii+0x13>
    b029:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b030 <_ZN3VGA6putHexEi>:
    b030:	83 ec 14             	sub    esp,0x14
    b033:	6a 10                	push   0x10
    b035:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b039:	e8 72 ff ff ff       	call   afb0 <_ZN3VGA13_put_nbr_baseEii>
    b03e:	83 c4 1c             	add    esp,0x1c
    b041:	c3                   	ret    
    b042:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b049:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b050 <_ZN3VGA6putDecEi>:
    b050:	83 ec 14             	sub    esp,0x14
    b053:	6a 0a                	push   0xa
    b055:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b059:	e8 52 ff ff ff       	call   afb0 <_ZN3VGA13_put_nbr_baseEii>
    b05e:	83 c4 1c             	add    esp,0x1c
    b061:	c3                   	ret    
    b062:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b069:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b070 <_ZN3VGA6putOctEi>:
    b070:	83 ec 14             	sub    esp,0x14
    b073:	6a 08                	push   0x8
    b075:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b079:	e8 32 ff ff ff       	call   afb0 <_ZN3VGA13_put_nbr_baseEii>
    b07e:	83 c4 1c             	add    esp,0x1c
    b081:	c3                   	ret    
    b082:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b089:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b090 <_ZN3VGA6putBinEi>:
    b090:	83 ec 14             	sub    esp,0x14
    b093:	6a 02                	push   0x2
    b095:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b099:	e8 12 ff ff ff       	call   afb0 <_ZN3VGA13_put_nbr_baseEii>
    b09e:	83 c4 1c             	add    esp,0x1c
    b0a1:	c3                   	ret    
    b0a2:	66 90                	xchg   ax,ax
    b0a4:	66 90                	xchg   ax,ax
    b0a6:	66 90                	xchg   ax,ax
    b0a8:	66 90                	xchg   ax,ax
    b0aa:	66 90                	xchg   ax,ax
    b0ac:	66 90                	xchg   ax,ax
    b0ae:	66 90                	xchg   ax,ax

0000b0b0 <_Z12clear_screenv>:
    b0b0:	83 ec 18             	sub    esp,0x18
    b0b3:	6a 0f                	push   0xf
    b0b5:	e8 96 fc ff ff       	call   ad50 <_ZN3VGA12clear_screenEc>
    b0ba:	83 c4 1c             	add    esp,0x1c
    b0bd:	c3                   	ret    
    b0be:	66 90                	xchg   ax,ax

0000b0c0 <_Z7putcharc>:
    b0c0:	83 ec 14             	sub    esp,0x14
    b0c3:	6a 0f                	push   0xf
    b0c5:	0f be 44 24 1c       	movsx  eax,BYTE PTR [esp+0x1c]
    b0ca:	50                   	push   eax
    b0cb:	e8 e0 fc ff ff       	call   adb0 <_ZN3VGA7putcharEcc>
    b0d0:	83 c4 1c             	add    esp,0x1c
    b0d3:	c3                   	ret    
    b0d4:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b0da:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000b0e0 <_Z6putdeci>:
    b0e0:	e9 6b ff ff ff       	jmp    b050 <_ZN3VGA6putDecEi>
    b0e5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b0e9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b0f0 <_Z6puthexi>:
    b0f0:	e9 3b ff ff ff       	jmp    b030 <_ZN3VGA6putHexEi>
    b0f5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b0f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b100 <_Z6putocti>:
    b100:	e9 6b ff ff ff       	jmp    b070 <_ZN3VGA6putOctEi>
    b105:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b109:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b110 <_Z6putbini>:
    b110:	e9 7b ff ff ff       	jmp    b090 <_ZN3VGA6putBinEi>
    b115:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b119:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b120 <_Z6putstrPc>:
    b120:	83 ec 14             	sub    esp,0x14
    b123:	6a 0f                	push   0xf
    b125:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b129:	e8 f2 fd ff ff       	call   af20 <_ZN3VGA5printEPKcc>
    b12e:	83 c4 1c             	add    esp,0x1c
    b131:	c3                   	ret    
    b132:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b139:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b140 <_Z6printfPKc>:
    b140:	53                   	push   ebx
    b141:	83 ec 08             	sub    esp,0x8
    b144:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    b148:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    b14b:	84 c0                	test   al,al
    b14d:	74 22                	je     b171 <_Z6printfPKc+0x31>
    b14f:	83 c3 01             	add    ebx,0x1
    b152:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b158:	83 ec 08             	sub    esp,0x8
    b15b:	83 c3 01             	add    ebx,0x1
    b15e:	6a 0f                	push   0xf
    b160:	50                   	push   eax
    b161:	e8 4a fc ff ff       	call   adb0 <_ZN3VGA7putcharEcc>
    b166:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    b16a:	83 c4 10             	add    esp,0x10
    b16d:	84 c0                	test   al,al
    b16f:	75 e7                	jne    b158 <_Z6printfPKc+0x18>
    b171:	83 c4 08             	add    esp,0x8
    b174:	5b                   	pop    ebx
    b175:	c3                   	ret    
    b176:	66 90                	xchg   ax,ax
    b178:	66 90                	xchg   ax,ax
    b17a:	66 90                	xchg   ax,ax
    b17c:	66 90                	xchg   ax,ax
    b17e:	66 90                	xchg   ax,ax

0000b180 <_Z4outbth>:
    b180:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b184:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b188:	ee                   	out    dx,al
    b189:	c3                   	ret    
    b18a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b190 <_Z4outwtt>:
    b190:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b194:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b198:	66 ef                	out    dx,ax
    b19a:	c3                   	ret    
    b19b:	90                   	nop
    b19c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000b1a0 <_Z4outdtj>:
    b1a0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b1a4:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b1a8:	ef                   	out    dx,eax
    b1a9:	c3                   	ret    
    b1aa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b1b0 <_Z4inwstjj>:
    b1b0:	57                   	push   edi
    b1b1:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    b1b5:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    b1b9:	8b 7c 24 0c          	mov    edi,DWORD PTR [esp+0xc]
    b1bd:	fc                   	cld    
    b1be:	f3 6d                	rep ins DWORD PTR es:[edi],dx
    b1c0:	5f                   	pop    edi
    b1c1:	c3                   	ret    
    b1c2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b1c9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b1d0 <_Z3inbt>:
    b1d0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b1d4:	ec                   	in     al,dx
    b1d5:	c3                   	ret    
    b1d6:	8d 76 00             	lea    esi,[esi+0x0]
    b1d9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b1e0 <_Z3inwt>:
    b1e0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b1e4:	66 ed                	in     ax,dx
    b1e6:	c3                   	ret    
    b1e7:	89 f6                	mov    esi,esi
    b1e9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b1f0 <_Z3indt>:
    b1f0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b1f4:	ed                   	in     eax,dx
    b1f5:	c3                   	ret    
    b1f6:	8d 76 00             	lea    esi,[esi+0x0]
    b1f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b200 <_Z7io_waitv>:
    b200:	31 c0                	xor    eax,eax
    b202:	e6 80                	out    0x80,al
    b204:	c3                   	ret    
    b205:	66 90                	xchg   ax,ax
    b207:	66 90                	xchg   ax,ax
    b209:	66 90                	xchg   ax,ax
    b20b:	66 90                	xchg   ax,ax
    b20d:	66 90                	xchg   ax,ax
    b20f:	90                   	nop

0000b210 <_ZN3pci13configAddressEhhhh>:
    b210:	0f b6 44 24 10       	movzx  eax,BYTE PTR [esp+0x10]
    b215:	0f b6 54 24 0c       	movzx  edx,BYTE PTR [esp+0xc]
    b21a:	c1 e0 02             	shl    eax,0x2
    b21d:	c1 e2 08             	shl    edx,0x8
    b220:	0f b6 c0             	movzx  eax,al
    b223:	09 d0                	or     eax,edx
    b225:	0f b6 54 24 08       	movzx  edx,BYTE PTR [esp+0x8]
    b22a:	c1 e2 0b             	shl    edx,0xb
    b22d:	09 d0                	or     eax,edx
    b22f:	0f b6 54 24 04       	movzx  edx,BYTE PTR [esp+0x4]
    b234:	c1 e2 10             	shl    edx,0x10
    b237:	09 d0                	or     eax,edx
    b239:	0d 00 00 00 80       	or     eax,0x80000000
    b23e:	c3                   	ret    
    b23f:	90                   	nop

0000b240 <_ZN3pci14configReadByteEhhhhh>:
    b240:	53                   	push   ebx
    b241:	83 ec 10             	sub    esp,0x10
    b244:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b249:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b24e:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    b252:	c1 e2 0b             	shl    edx,0xb
    b255:	c1 e0 10             	shl    eax,0x10
    b258:	09 d0                	or     eax,edx
    b25a:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b25f:	c1 e2 08             	shl    edx,0x8
    b262:	09 d0                	or     eax,edx
    b264:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b269:	c1 e2 02             	shl    edx,0x2
    b26c:	0f b6 d2             	movzx  edx,dl
    b26f:	09 d0                	or     eax,edx
    b271:	0d 00 00 00 80       	or     eax,0x80000000
    b276:	50                   	push   eax
    b277:	68 f8 0c 00 00       	push   0xcf8
    b27c:	e8 1f ff ff ff       	call   b1a0 <_Z4outdtj>
    b281:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    b288:	e8 63 ff ff ff       	call   b1f0 <_Z3indt>
    b28d:	0f b6 cb             	movzx  ecx,bl
    b290:	83 c4 18             	add    esp,0x18
    b293:	c1 e1 03             	shl    ecx,0x3
    b296:	d3 e8                	shr    eax,cl
    b298:	5b                   	pop    ebx
    b299:	c3                   	ret    
    b29a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b2a0 <_ZN3pci14configReadWordEhhhhh>:
    b2a0:	53                   	push   ebx
    b2a1:	83 ec 10             	sub    esp,0x10
    b2a4:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b2a9:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b2ae:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    b2b2:	c1 e2 0b             	shl    edx,0xb
    b2b5:	c1 e0 10             	shl    eax,0x10
    b2b8:	09 d0                	or     eax,edx
    b2ba:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b2bf:	c1 e2 08             	shl    edx,0x8
    b2c2:	09 d0                	or     eax,edx
    b2c4:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b2c9:	c1 e2 02             	shl    edx,0x2
    b2cc:	0f b6 d2             	movzx  edx,dl
    b2cf:	09 d0                	or     eax,edx
    b2d1:	0d 00 00 00 80       	or     eax,0x80000000
    b2d6:	50                   	push   eax
    b2d7:	68 f8 0c 00 00       	push   0xcf8
    b2dc:	e8 bf fe ff ff       	call   b1a0 <_Z4outdtj>
    b2e1:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    b2e8:	e8 03 ff ff ff       	call   b1f0 <_Z3indt>
    b2ed:	0f b6 cb             	movzx  ecx,bl
    b2f0:	83 c4 18             	add    esp,0x18
    b2f3:	c1 e1 04             	shl    ecx,0x4
    b2f6:	d3 e8                	shr    eax,cl
    b2f8:	5b                   	pop    ebx
    b2f9:	c3                   	ret    
    b2fa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b300 <_ZN3pci10configReadEhhhh>:
    b300:	83 ec 14             	sub    esp,0x14
    b303:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b308:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b30d:	c1 e0 10             	shl    eax,0x10
    b310:	c1 e2 0b             	shl    edx,0xb
    b313:	09 d0                	or     eax,edx
    b315:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b31a:	c1 e2 08             	shl    edx,0x8
    b31d:	09 d0                	or     eax,edx
    b31f:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b324:	c1 e2 02             	shl    edx,0x2
    b327:	0f b6 d2             	movzx  edx,dl
    b32a:	09 d0                	or     eax,edx
    b32c:	0d 00 00 00 80       	or     eax,0x80000000
    b331:	50                   	push   eax
    b332:	68 f8 0c 00 00       	push   0xcf8
    b337:	e8 64 fe ff ff       	call   b1a0 <_Z4outdtj>
    b33c:	c7 44 24 20 fc 0c 00 	mov    DWORD PTR [esp+0x20],0xcfc
    b343:	00 
    b344:	83 c4 1c             	add    esp,0x1c
    b347:	e9 a4 fe ff ff       	jmp    b1f0 <_Z3indt>
    b34c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000b350 <_ZN3pci11checkDeviceEhhh>:
    b350:	83 ec 18             	sub    esp,0x18
    b353:	6a 00                	push   0x0
    b355:	6a 00                	push   0x0
    b357:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b35c:	50                   	push   eax
    b35d:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b362:	50                   	push   eax
    b363:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b368:	50                   	push   eax
    b369:	e8 32 ff ff ff       	call   b2a0 <_ZN3pci14configReadWordEhhhhh>
    b36e:	66 83 f8 ff          	cmp    ax,0xffff
    b372:	0f 95 c0             	setne  al
    b375:	83 c4 2c             	add    esp,0x2c
    b378:	c3                   	ret    
    b379:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b380 <_ZN3pci11printBussesEv>:
    b380:	55                   	push   ebp
    b381:	57                   	push   edi
    b382:	56                   	push   esi
    b383:	53                   	push   ebx
    b384:	83 ec 4c             	sub    esp,0x4c
    b387:	c7 44 24 10 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    b38e:	00 
    b38f:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    b396:	00 
    b397:	89 f6                	mov    esi,esi
    b399:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b3a0:	31 f6                	xor    esi,esi
    b3a2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b3a8:	83 ec 0c             	sub    esp,0xc
    b3ab:	6a 00                	push   0x0
    b3ad:	6a 00                	push   0x0
    b3af:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    b3b3:	53                   	push   ebx
    b3b4:	56                   	push   esi
    b3b5:	8b 7c 24 28          	mov    edi,DWORD PTR [esp+0x28]
    b3b9:	57                   	push   edi
    b3ba:	e8 e1 fe ff ff       	call   b2a0 <_ZN3pci14configReadWordEhhhhh>
    b3bf:	83 c4 20             	add    esp,0x20
    b3c2:	66 83 f8 ff          	cmp    ax,0xffff
    b3c6:	0f 84 6c 01 00 00    	je     b538 <_ZN3pci11printBussesEv+0x1b8>
    b3cc:	83 ec 0c             	sub    esp,0xc
    b3cf:	6a 00                	push   0x0
    b3d1:	6a 02                	push   0x2
    b3d3:	53                   	push   ebx
    b3d4:	56                   	push   esi
    b3d5:	57                   	push   edi
    b3d6:	e8 65 fe ff ff       	call   b240 <_ZN3pci14configReadByteEhhhhh>
    b3db:	88 44 24 38          	mov    BYTE PTR [esp+0x38],al
    b3df:	83 c4 14             	add    esp,0x14
    b3e2:	6a 01                	push   0x1
    b3e4:	6a 02                	push   0x2
    b3e6:	53                   	push   ebx
    b3e7:	56                   	push   esi
    b3e8:	57                   	push   edi
    b3e9:	e8 52 fe ff ff       	call   b240 <_ZN3pci14configReadByteEhhhhh>
    b3ee:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    b3f2:	83 c4 14             	add    esp,0x14
    b3f5:	6a 02                	push   0x2
    b3f7:	6a 02                	push   0x2
    b3f9:	53                   	push   ebx
    b3fa:	56                   	push   esi
    b3fb:	57                   	push   edi
    b3fc:	e8 3f fe ff ff       	call   b240 <_ZN3pci14configReadByteEhhhhh>
    b401:	83 c4 14             	add    esp,0x14
    b404:	89 c5                	mov    ebp,eax
    b406:	6a 03                	push   0x3
    b408:	6a 02                	push   0x2
    b40a:	53                   	push   ebx
    b40b:	56                   	push   esi
    b40c:	57                   	push   edi
    b40d:	31 ff                	xor    edi,edi
    b40f:	e8 2c fe ff ff       	call   b240 <_ZN3pci14configReadByteEhhhhh>
    b414:	ba 43 00 00 00       	mov    edx,0x43
    b419:	88 44 24 4f          	mov    BYTE PTR [esp+0x4f],al
    b41d:	83 c4 20             	add    esp,0x20
    b420:	eb 29                	jmp    b44b <_ZN3pci11printBussesEv+0xcb>
    b422:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b428:	3c 25                	cmp    al,0x25
    b42a:	0f 84 90 03 00 00    	je     b7c0 <_ZN3pci11printBussesEv+0x440>
    b430:	84 c0                	test   al,al
    b432:	0f 85 d8 01 00 00    	jne    b610 <_ZN3pci11printBussesEv+0x290>
    b438:	8d 5f 02             	lea    ebx,[edi+0x2]
    b43b:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b442:	84 c0                	test   al,al
    b444:	74 3a                	je     b480 <_ZN3pci11printBussesEv+0x100>
    b446:	0f be d0             	movsx  edx,al
    b449:	89 df                	mov    edi,ebx
    b44b:	8d 5f 01             	lea    ebx,[edi+0x1]
    b44e:	80 fa 25             	cmp    dl,0x25
    b451:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b458:	8d 8b a8 d1 00 00    	lea    ecx,[ebx+0xd1a8]
    b45e:	74 c8                	je     b428 <_ZN3pci11printBussesEv+0xa8>
    b460:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    b464:	83 ec 0c             	sub    esp,0xc
    b467:	52                   	push   edx
    b468:	e8 53 fc ff ff       	call   b0c0 <_Z7putcharc>
    b46d:	83 c4 10             	add    esp,0x10
    b470:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    b475:	84 c0                	test   al,al
    b477:	75 cd                	jne    b446 <_ZN3pci11printBussesEv+0xc6>
    b479:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b480:	6a 04                	push   0x4
    b482:	8b 6c 24 14          	mov    ebp,DWORD PTR [esp+0x14]
    b486:	55                   	push   ebp
    b487:	56                   	push   esi
    b488:	8b 5c 24 18          	mov    ebx,DWORD PTR [esp+0x18]
    b48c:	53                   	push   ebx
    b48d:	e8 6e fe ff ff       	call   b300 <_ZN3pci10configReadEhhhh>
    b492:	c7 04 24 03 00 00 00 	mov    DWORD PTR [esp],0x3
    b499:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    b49d:	6a 03                	push   0x3
    b49f:	55                   	push   ebp
    b4a0:	56                   	push   esi
    b4a1:	53                   	push   ebx
    b4a2:	e8 99 fd ff ff       	call   b240 <_ZN3pci14configReadByteEhhhhh>
    b4a7:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    b4ab:	83 c4 14             	add    esp,0x14
    b4ae:	6a 01                	push   0x1
    b4b0:	6a 00                	push   0x0
    b4b2:	55                   	push   ebp
    b4b3:	56                   	push   esi
    b4b4:	53                   	push   ebx
    b4b5:	e8 e6 fd ff ff       	call   b2a0 <_ZN3pci14configReadWordEhhhhh>
    b4ba:	83 c4 14             	add    esp,0x14
    b4bd:	89 c7                	mov    edi,eax
    b4bf:	6a 00                	push   0x0
    b4c1:	6a 00                	push   0x0
    b4c3:	55                   	push   ebp
    b4c4:	56                   	push   esi
    b4c5:	31 ed                	xor    ebp,ebp
    b4c7:	53                   	push   ebx
    b4c8:	e8 d3 fd ff ff       	call   b2a0 <_ZN3pci14configReadWordEhhhhh>
    b4cd:	ba 56 00 00 00       	mov    edx,0x56
    b4d2:	66 89 44 24 54       	mov    WORD PTR [esp+0x54],ax
    b4d7:	83 c4 20             	add    esp,0x20
    b4da:	eb 27                	jmp    b503 <_ZN3pci11printBussesEv+0x183>
    b4dc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b4e0:	3c 25                	cmp    al,0x25
    b4e2:	0f 84 00 03 00 00    	je     b7e8 <_ZN3pci11printBussesEv+0x468>
    b4e8:	84 c0                	test   al,al
    b4ea:	0f 85 90 00 00 00    	jne    b580 <_ZN3pci11printBussesEv+0x200>
    b4f0:	8d 5d 02             	lea    ebx,[ebp+0x2]
    b4f3:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b4fa:	84 c0                	test   al,al
    b4fc:	74 3a                	je     b538 <_ZN3pci11printBussesEv+0x1b8>
    b4fe:	0f be d0             	movsx  edx,al
    b501:	89 dd                	mov    ebp,ebx
    b503:	8d 5d 01             	lea    ebx,[ebp+0x1]
    b506:	80 fa 25             	cmp    dl,0x25
    b509:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b510:	8d 8b ec d1 00 00    	lea    ecx,[ebx+0xd1ec]
    b516:	74 c8                	je     b4e0 <_ZN3pci11printBussesEv+0x160>
    b518:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    b51c:	83 ec 0c             	sub    esp,0xc
    b51f:	52                   	push   edx
    b520:	e8 9b fb ff ff       	call   b0c0 <_Z7putcharc>
    b525:	83 c4 10             	add    esp,0x10
    b528:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    b52d:	84 c0                	test   al,al
    b52f:	75 cd                	jne    b4fe <_ZN3pci11printBussesEv+0x17e>
    b531:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b538:	83 c6 01             	add    esi,0x1
    b53b:	83 fe 20             	cmp    esi,0x20
    b53e:	0f 85 64 fe ff ff    	jne    b3a8 <_ZN3pci11printBussesEv+0x28>
    b544:	83 44 24 0c 01       	add    DWORD PTR [esp+0xc],0x1
    b549:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b54d:	3d 00 01 00 00       	cmp    eax,0x100
    b552:	0f 85 48 fe ff ff    	jne    b3a0 <_ZN3pci11printBussesEv+0x20>
    b558:	83 44 24 10 01       	add    DWORD PTR [esp+0x10],0x1
    b55d:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    b561:	83 f8 08             	cmp    eax,0x8
    b564:	0f 85 25 fe ff ff    	jne    b38f <_ZN3pci11printBussesEv+0xf>
    b56a:	83 ec 0c             	sub    esp,0xc
    b56d:	68 69 d1 00 00       	push   0xd169
    b572:	e8 c9 fb ff ff       	call   b140 <_Z6printfPKc>
    b577:	83 c4 5c             	add    esp,0x5c
    b57a:	5b                   	pop    ebx
    b57b:	5e                   	pop    esi
    b57c:	5f                   	pop    edi
    b57d:	5d                   	pop    ebp
    b57e:	c3                   	ret    
    b57f:	90                   	nop
    b580:	83 ec 08             	sub    esp,0x8
    b583:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    b587:	50                   	push   eax
    b588:	51                   	push   ecx
    b589:	e8 02 0b 00 00       	call   c090 <_Z14_manage_escapeItEiPKcPT_>
    b58e:	01 c3                	add    ebx,eax
    b590:	66 89 7c 24 46       	mov    WORD PTR [esp+0x46],di
    b595:	83 c4 10             	add    esp,0x10
    b598:	0f be 83 ec d1 00 00 	movsx  eax,BYTE PTR [ebx+0xd1ec]
    b59f:	8d ab ec d1 00 00    	lea    ebp,[ebx+0xd1ec]
    b5a5:	84 c0                	test   al,al
    b5a7:	74 8f                	je     b538 <_ZN3pci11printBussesEv+0x1b8>
    b5a9:	31 d2                	xor    edx,edx
    b5ab:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b5af:	89 ee                	mov    esi,ebp
    b5b1:	89 d5                	mov    ebp,edx
    b5b3:	eb 25                	jmp    b5da <_ZN3pci11printBussesEv+0x25a>
    b5b5:	8d 76 00             	lea    esi,[esi+0x0]
    b5b8:	80 fb 25             	cmp    bl,0x25
    b5bb:	0f 84 7f 03 00 00    	je     b940 <_ZN3pci11printBussesEv+0x5c0>
    b5c1:	84 db                	test   bl,bl
    b5c3:	0f 85 d7 00 00 00    	jne    b6a0 <_ZN3pci11printBussesEv+0x320>
    b5c9:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b5ce:	8d 7d 02             	lea    edi,[ebp+0x2]
    b5d1:	84 db                	test   bl,bl
    b5d3:	74 22                	je     b5f7 <_ZN3pci11printBussesEv+0x277>
    b5d5:	0f be c3             	movsx  eax,bl
    b5d8:	89 fd                	mov    ebp,edi
    b5da:	8d 7d 01             	lea    edi,[ebp+0x1]
    b5dd:	3c 25                	cmp    al,0x25
    b5df:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b5e2:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b5e5:	74 d1                	je     b5b8 <_ZN3pci11printBussesEv+0x238>
    b5e7:	83 ec 0c             	sub    esp,0xc
    b5ea:	50                   	push   eax
    b5eb:	e8 d0 fa ff ff       	call   b0c0 <_Z7putcharc>
    b5f0:	83 c4 10             	add    esp,0x10
    b5f3:	84 db                	test   bl,bl
    b5f5:	75 de                	jne    b5d5 <_ZN3pci11printBussesEv+0x255>
    b5f7:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b5fb:	83 c6 01             	add    esi,0x1
    b5fe:	83 fe 20             	cmp    esi,0x20
    b601:	0f 85 a1 fd ff ff    	jne    b3a8 <_ZN3pci11printBussesEv+0x28>
    b607:	e9 38 ff ff ff       	jmp    b544 <_ZN3pci11printBussesEv+0x1c4>
    b60c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b610:	83 ec 08             	sub    esp,0x8
    b613:	8d 44 24 37          	lea    eax,[esp+0x37]
    b617:	50                   	push   eax
    b618:	51                   	push   ecx
    b619:	e8 b2 0d 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    b61e:	01 c3                	add    ebx,eax
    b620:	89 e8                	mov    eax,ebp
    b622:	88 44 24 40          	mov    BYTE PTR [esp+0x40],al
    b626:	0f be 83 a8 d1 00 00 	movsx  eax,BYTE PTR [ebx+0xd1a8]
    b62d:	83 c4 10             	add    esp,0x10
    b630:	8d 93 a8 d1 00 00    	lea    edx,[ebx+0xd1a8]
    b636:	84 c0                	test   al,al
    b638:	0f 84 42 fe ff ff    	je     b480 <_ZN3pci11printBussesEv+0x100>
    b63e:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    b642:	31 ed                	xor    ebp,ebp
    b644:	89 d6                	mov    esi,edx
    b646:	eb 2a                	jmp    b672 <_ZN3pci11printBussesEv+0x2f2>
    b648:	90                   	nop
    b649:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b650:	80 fb 25             	cmp    bl,0x25
    b653:	0f 84 17 03 00 00    	je     b970 <_ZN3pci11printBussesEv+0x5f0>
    b659:	84 db                	test   bl,bl
    b65b:	0f 85 cf 00 00 00    	jne    b730 <_ZN3pci11printBussesEv+0x3b0>
    b661:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b666:	8d 7d 02             	lea    edi,[ebp+0x2]
    b669:	84 db                	test   bl,bl
    b66b:	74 22                	je     b68f <_ZN3pci11printBussesEv+0x30f>
    b66d:	0f be c3             	movsx  eax,bl
    b670:	89 fd                	mov    ebp,edi
    b672:	8d 7d 01             	lea    edi,[ebp+0x1]
    b675:	3c 25                	cmp    al,0x25
    b677:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b67a:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b67d:	74 d1                	je     b650 <_ZN3pci11printBussesEv+0x2d0>
    b67f:	83 ec 0c             	sub    esp,0xc
    b682:	50                   	push   eax
    b683:	e8 38 fa ff ff       	call   b0c0 <_Z7putcharc>
    b688:	83 c4 10             	add    esp,0x10
    b68b:	84 db                	test   bl,bl
    b68d:	75 de                	jne    b66d <_ZN3pci11printBussesEv+0x2ed>
    b68f:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    b693:	e9 e8 fd ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    b698:	90                   	nop
    b699:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b6a0:	83 ec 08             	sub    esp,0x8
    b6a3:	89 f5                	mov    ebp,esi
    b6a5:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b6a9:	8d 44 24 3e          	lea    eax,[esp+0x3e]
    b6ad:	50                   	push   eax
    b6ae:	51                   	push   ecx
    b6af:	e8 dc 09 00 00       	call   c090 <_Z14_manage_escapeItEiPKcPT_>
    b6b4:	8d 1c 38             	lea    ebx,[eax+edi*1]
    b6b7:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    b6bc:	01 dd                	add    ebp,ebx
    b6be:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    b6c2:	88 44 24 43          	mov    BYTE PTR [esp+0x43],al
    b6c6:	83 c4 10             	add    esp,0x10
    b6c9:	84 d2                	test   dl,dl
    b6cb:	0f 84 67 fe ff ff    	je     b538 <_ZN3pci11printBussesEv+0x1b8>
    b6d1:	31 ff                	xor    edi,edi
    b6d3:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b6d7:	89 ee                	mov    esi,ebp
    b6d9:	89 fd                	mov    ebp,edi
    b6db:	eb 29                	jmp    b706 <_ZN3pci11printBussesEv+0x386>
    b6dd:	8d 76 00             	lea    esi,[esi+0x0]
    b6e0:	80 fb 25             	cmp    bl,0x25
    b6e3:	0f 84 57 04 00 00    	je     bb40 <_ZN3pci11printBussesEv+0x7c0>
    b6e9:	84 db                	test   bl,bl
    b6eb:	0f 85 2f 01 00 00    	jne    b820 <_ZN3pci11printBussesEv+0x4a0>
    b6f1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b6f6:	8d 7d 02             	lea    edi,[ebp+0x2]
    b6f9:	84 db                	test   bl,bl
    b6fb:	0f 84 f6 fe ff ff    	je     b5f7 <_ZN3pci11printBussesEv+0x277>
    b701:	0f be d3             	movsx  edx,bl
    b704:	89 fd                	mov    ebp,edi
    b706:	8d 7d 01             	lea    edi,[ebp+0x1]
    b709:	80 fa 25             	cmp    dl,0x25
    b70c:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b70f:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b712:	74 cc                	je     b6e0 <_ZN3pci11printBussesEv+0x360>
    b714:	83 ec 0c             	sub    esp,0xc
    b717:	52                   	push   edx
    b718:	e8 a3 f9 ff ff       	call   b0c0 <_Z7putcharc>
    b71d:	83 c4 10             	add    esp,0x10
    b720:	84 db                	test   bl,bl
    b722:	75 dd                	jne    b701 <_ZN3pci11printBussesEv+0x381>
    b724:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b728:	e9 ce fe ff ff       	jmp    b5fb <_ZN3pci11printBussesEv+0x27b>
    b72d:	8d 76 00             	lea    esi,[esi+0x0]
    b730:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b734:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    b738:	83 ec 08             	sub    esp,0x8
    b73b:	8d 44 24 38          	lea    eax,[esp+0x38]
    b73f:	50                   	push   eax
    b740:	51                   	push   ecx
    b741:	e8 8a 0c 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    b746:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b74a:	01 c7                	add    edi,eax
    b74c:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    b751:	01 fa                	add    edx,edi
    b753:	88 44 24 41          	mov    BYTE PTR [esp+0x41],al
    b757:	0f be 02             	movsx  eax,BYTE PTR [edx]
    b75a:	83 c4 10             	add    esp,0x10
    b75d:	84 c0                	test   al,al
    b75f:	0f 84 1b fd ff ff    	je     b480 <_ZN3pci11printBussesEv+0x100>
    b765:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    b769:	31 ff                	xor    edi,edi
    b76b:	89 d6                	mov    esi,edx
    b76d:	eb 23                	jmp    b792 <_ZN3pci11printBussesEv+0x412>
    b76f:	90                   	nop
    b770:	80 fb 25             	cmp    bl,0x25
    b773:	0f 84 97 03 00 00    	je     bb10 <_ZN3pci11printBussesEv+0x790>
    b779:	84 db                	test   bl,bl
    b77b:	0f 85 27 01 00 00    	jne    b8a8 <_ZN3pci11printBussesEv+0x528>
    b781:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    b786:	8d 6f 02             	lea    ebp,[edi+0x2]
    b789:	84 db                	test   bl,bl
    b78b:	74 22                	je     b7af <_ZN3pci11printBussesEv+0x42f>
    b78d:	0f be c3             	movsx  eax,bl
    b790:	89 ef                	mov    edi,ebp
    b792:	8d 6f 01             	lea    ebp,[edi+0x1]
    b795:	3c 25                	cmp    al,0x25
    b797:	8d 0c 2e             	lea    ecx,[esi+ebp*1]
    b79a:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b79d:	74 d1                	je     b770 <_ZN3pci11printBussesEv+0x3f0>
    b79f:	83 ec 0c             	sub    esp,0xc
    b7a2:	50                   	push   eax
    b7a3:	e8 18 f9 ff ff       	call   b0c0 <_Z7putcharc>
    b7a8:	83 c4 10             	add    esp,0x10
    b7ab:	84 db                	test   bl,bl
    b7ad:	75 de                	jne    b78d <_ZN3pci11printBussesEv+0x40d>
    b7af:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b7b3:	e9 c8 fc ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    b7b8:	90                   	nop
    b7b9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b7c0:	83 ec 0c             	sub    esp,0xc
    b7c3:	8d 5f 02             	lea    ebx,[edi+0x2]
    b7c6:	6a 25                	push   0x25
    b7c8:	e8 f3 f8 ff ff       	call   b0c0 <_Z7putcharc>
    b7cd:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b7d4:	83 c4 10             	add    esp,0x10
    b7d7:	84 c0                	test   al,al
    b7d9:	0f 85 67 fc ff ff    	jne    b446 <_ZN3pci11printBussesEv+0xc6>
    b7df:	e9 9c fc ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    b7e4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b7e8:	83 ec 0c             	sub    esp,0xc
    b7eb:	8d 5d 02             	lea    ebx,[ebp+0x2]
    b7ee:	6a 25                	push   0x25
    b7f0:	e8 cb f8 ff ff       	call   b0c0 <_Z7putcharc>
    b7f5:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b7fc:	83 c4 10             	add    esp,0x10
    b7ff:	84 c0                	test   al,al
    b801:	0f 85 f7 fc ff ff    	jne    b4fe <_ZN3pci11printBussesEv+0x17e>
    b807:	83 c6 01             	add    esi,0x1
    b80a:	83 fe 20             	cmp    esi,0x20
    b80d:	0f 85 95 fb ff ff    	jne    b3a8 <_ZN3pci11printBussesEv+0x28>
    b813:	e9 2c fd ff ff       	jmp    b544 <_ZN3pci11printBussesEv+0x1c4>
    b818:	90                   	nop
    b819:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b820:	83 ec 08             	sub    esp,0x8
    b823:	89 f5                	mov    ebp,esi
    b825:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b829:	8d 44 24 3b          	lea    eax,[esp+0x3b]
    b82d:	89 fb                	mov    ebx,edi
    b82f:	50                   	push   eax
    b830:	51                   	push   ecx
    b831:	e8 9a 0b 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    b836:	01 c3                	add    ebx,eax
    b838:	83 c4 10             	add    esp,0x10
    b83b:	01 eb                	add    ebx,ebp
    b83d:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    b840:	84 d2                	test   dl,dl
    b842:	0f 84 f0 fc ff ff    	je     b538 <_ZN3pci11printBussesEv+0x1b8>
    b848:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b84c:	31 ed                	xor    ebp,ebp
    b84e:	89 de                	mov    esi,ebx
    b850:	eb 2c                	jmp    b87e <_ZN3pci11printBussesEv+0x4fe>
    b852:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b858:	80 fb 25             	cmp    bl,0x25
    b85b:	0f 84 bf 03 00 00    	je     bc20 <_ZN3pci11printBussesEv+0x8a0>
    b861:	84 db                	test   bl,bl
    b863:	0f 85 37 01 00 00    	jne    b9a0 <_ZN3pci11printBussesEv+0x620>
    b869:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b86e:	8d 7d 02             	lea    edi,[ebp+0x2]
    b871:	84 db                	test   bl,bl
    b873:	0f 84 7e fd ff ff    	je     b5f7 <_ZN3pci11printBussesEv+0x277>
    b879:	0f be d3             	movsx  edx,bl
    b87c:	89 fd                	mov    ebp,edi
    b87e:	8d 7d 01             	lea    edi,[ebp+0x1]
    b881:	80 fa 25             	cmp    dl,0x25
    b884:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b887:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b88a:	74 cc                	je     b858 <_ZN3pci11printBussesEv+0x4d8>
    b88c:	83 ec 0c             	sub    esp,0xc
    b88f:	52                   	push   edx
    b890:	e8 2b f8 ff ff       	call   b0c0 <_Z7putcharc>
    b895:	83 c4 10             	add    esp,0x10
    b898:	84 db                	test   bl,bl
    b89a:	75 dd                	jne    b879 <_ZN3pci11printBussesEv+0x4f9>
    b89c:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b8a0:	e9 56 fd ff ff       	jmp    b5fb <_ZN3pci11printBussesEv+0x27b>
    b8a5:	8d 76 00             	lea    esi,[esi+0x0]
    b8a8:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b8ac:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b8b0:	83 ec 08             	sub    esp,0x8
    b8b3:	8d 44 24 39          	lea    eax,[esp+0x39]
    b8b7:	50                   	push   eax
    b8b8:	51                   	push   ecx
    b8b9:	e8 12 0b 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    b8be:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b8c2:	01 c5                	add    ebp,eax
    b8c4:	0f b6 44 24 28       	movzx  eax,BYTE PTR [esp+0x28]
    b8c9:	01 d5                	add    ebp,edx
    b8cb:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    b8cf:	88 44 24 42          	mov    BYTE PTR [esp+0x42],al
    b8d3:	83 c4 10             	add    esp,0x10
    b8d6:	84 d2                	test   dl,dl
    b8d8:	0f 84 a2 fb ff ff    	je     b480 <_ZN3pci11printBussesEv+0x100>
    b8de:	31 ff                	xor    edi,edi
    b8e0:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b8e4:	89 ee                	mov    esi,ebp
    b8e6:	89 fd                	mov    ebp,edi
    b8e8:	eb 28                	jmp    b912 <_ZN3pci11printBussesEv+0x592>
    b8ea:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b8f0:	80 fb 25             	cmp    bl,0x25
    b8f3:	0f 84 f7 02 00 00    	je     bbf0 <_ZN3pci11printBussesEv+0x870>
    b8f9:	84 db                	test   bl,bl
    b8fb:	0f 85 7f 01 00 00    	jne    ba80 <_ZN3pci11printBussesEv+0x700>
    b901:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b906:	8d 7d 02             	lea    edi,[ebp+0x2]
    b909:	84 db                	test   bl,bl
    b90b:	74 23                	je     b930 <_ZN3pci11printBussesEv+0x5b0>
    b90d:	0f be d3             	movsx  edx,bl
    b910:	89 fd                	mov    ebp,edi
    b912:	8d 7d 01             	lea    edi,[ebp+0x1]
    b915:	80 fa 25             	cmp    dl,0x25
    b918:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b91b:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b91e:	74 d0                	je     b8f0 <_ZN3pci11printBussesEv+0x570>
    b920:	83 ec 0c             	sub    esp,0xc
    b923:	52                   	push   edx
    b924:	e8 97 f7 ff ff       	call   b0c0 <_Z7putcharc>
    b929:	83 c4 10             	add    esp,0x10
    b92c:	84 db                	test   bl,bl
    b92e:	75 dd                	jne    b90d <_ZN3pci11printBussesEv+0x58d>
    b930:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b934:	e9 47 fb ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    b939:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b940:	83 ec 0c             	sub    esp,0xc
    b943:	8d 7d 02             	lea    edi,[ebp+0x2]
    b946:	6a 25                	push   0x25
    b948:	e8 73 f7 ff ff       	call   b0c0 <_Z7putcharc>
    b94d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b952:	83 c4 10             	add    esp,0x10
    b955:	84 db                	test   bl,bl
    b957:	0f 85 78 fc ff ff    	jne    b5d5 <_ZN3pci11printBussesEv+0x255>
    b95d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b961:	e9 95 fc ff ff       	jmp    b5fb <_ZN3pci11printBussesEv+0x27b>
    b966:	8d 76 00             	lea    esi,[esi+0x0]
    b969:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b970:	83 ec 0c             	sub    esp,0xc
    b973:	8d 7d 02             	lea    edi,[ebp+0x2]
    b976:	6a 25                	push   0x25
    b978:	e8 43 f7 ff ff       	call   b0c0 <_Z7putcharc>
    b97d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b982:	83 c4 10             	add    esp,0x10
    b985:	84 db                	test   bl,bl
    b987:	0f 85 e0 fc ff ff    	jne    b66d <_ZN3pci11printBussesEv+0x2ed>
    b98d:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    b991:	e9 ea fa ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    b996:	8d 76 00             	lea    esi,[esi+0x0]
    b999:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b9a0:	89 d8                	mov    eax,ebx
    b9a2:	89 f3                	mov    ebx,esi
    b9a4:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b9a8:	83 e8 42             	sub    eax,0x42
    b9ab:	3c 36                	cmp    al,0x36
    b9ad:	77 21                	ja     b9d0 <_ZN3pci11printBussesEv+0x650>
    b9af:	0f b6 c0             	movzx  eax,al
    b9b2:	ff 24 85 00 d0 00 00 	jmp    DWORD PTR [eax*4+0xd000]
    b9b9:	83 ec 0c             	sub    esp,0xc
    b9bc:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    b9c0:	e8 5b f7 ff ff       	call   b120 <_Z6putstrPc>
    b9c5:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    b9c9:	83 c4 10             	add    esp,0x10
    b9cc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b9d0:	83 ec 0c             	sub    esp,0xc
    b9d3:	83 c6 01             	add    esi,0x1
    b9d6:	51                   	push   ecx
    b9d7:	e8 64 f7 ff ff       	call   b140 <_Z6printfPKc>
    b9dc:	83 c4 10             	add    esp,0x10
    b9df:	83 fe 20             	cmp    esi,0x20
    b9e2:	0f 85 c0 f9 ff ff    	jne    b3a8 <_ZN3pci11printBussesEv+0x28>
    b9e8:	e9 57 fb ff ff       	jmp    b544 <_ZN3pci11printBussesEv+0x1c4>
    b9ed:	83 ec 0c             	sub    esp,0xc
    b9f0:	0f be 44 24 24       	movsx  eax,BYTE PTR [esp+0x24]
    b9f5:	50                   	push   eax
    b9f6:	e8 c5 f6 ff ff       	call   b0c0 <_Z7putcharc>
    b9fb:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    b9ff:	83 c4 10             	add    esp,0x10
    ba02:	eb cc                	jmp    b9d0 <_ZN3pci11printBussesEv+0x650>
    ba04:	83 ec 0c             	sub    esp,0xc
    ba07:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba0b:	e8 e0 f6 ff ff       	call   b0f0 <_Z6puthexi>
    ba10:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba14:	83 c4 10             	add    esp,0x10
    ba17:	eb b7                	jmp    b9d0 <_ZN3pci11printBussesEv+0x650>
    ba19:	83 ec 0c             	sub    esp,0xc
    ba1c:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba20:	e8 db f6 ff ff       	call   b100 <_Z6putocti>
    ba25:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba29:	83 c4 10             	add    esp,0x10
    ba2c:	eb a2                	jmp    b9d0 <_ZN3pci11printBussesEv+0x650>
    ba2e:	83 ec 0c             	sub    esp,0xc
    ba31:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba35:	e8 d6 f6 ff ff       	call   b110 <_Z6putbini>
    ba3a:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba3e:	83 c4 10             	add    esp,0x10
    ba41:	eb 8d                	jmp    b9d0 <_ZN3pci11printBussesEv+0x650>
    ba43:	83 ec 0c             	sub    esp,0xc
    ba46:	68 8c e5 00 00       	push   0xe58c
    ba4b:	e8 f0 f6 ff ff       	call   b140 <_Z6printfPKc>
    ba50:	58                   	pop    eax
    ba51:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba55:	e8 96 f6 ff ff       	call   b0f0 <_Z6puthexi>
    ba5a:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba5e:	83 c4 10             	add    esp,0x10
    ba61:	e9 6a ff ff ff       	jmp    b9d0 <_ZN3pci11printBussesEv+0x650>
    ba66:	83 ec 0c             	sub    esp,0xc
    ba69:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba6d:	e8 6e f6 ff ff       	call   b0e0 <_Z6putdeci>
    ba72:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba76:	83 c4 10             	add    esp,0x10
    ba79:	e9 52 ff ff ff       	jmp    b9d0 <_ZN3pci11printBussesEv+0x650>
    ba7e:	66 90                	xchg   ax,ax
    ba80:	83 ec 08             	sub    esp,0x8
    ba83:	89 f5                	mov    ebp,esi
    ba85:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    ba89:	8d 44 24 3a          	lea    eax,[esp+0x3a]
    ba8d:	89 fb                	mov    ebx,edi
    ba8f:	50                   	push   eax
    ba90:	51                   	push   ecx
    ba91:	e8 3a 09 00 00       	call   c3d0 <_Z14_manage_escapeIhEiPKcPT_>
    ba96:	01 c3                	add    ebx,eax
    ba98:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    ba9c:	01 eb                	add    ebx,ebp
    ba9e:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    baa1:	89 44 24 48          	mov    DWORD PTR [esp+0x48],eax
    baa5:	83 c4 10             	add    esp,0x10
    baa8:	84 d2                	test   dl,dl
    baaa:	0f 84 d0 f9 ff ff    	je     b480 <_ZN3pci11printBussesEv+0x100>
    bab0:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    bab4:	31 ed                	xor    ebp,ebp
    bab6:	89 de                	mov    esi,ebx
    bab8:	eb 2c                	jmp    bae6 <_ZN3pci11printBussesEv+0x766>
    baba:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bac0:	80 fb 25             	cmp    bl,0x25
    bac3:	0f 84 af 01 00 00    	je     bc78 <_ZN3pci11printBussesEv+0x8f8>
    bac9:	84 db                	test   bl,bl
    bacb:	0f 85 9f 00 00 00    	jne    bb70 <_ZN3pci11printBussesEv+0x7f0>
    bad1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bad6:	8d 7d 02             	lea    edi,[ebp+0x2]
    bad9:	84 db                	test   bl,bl
    badb:	0f 84 4f fe ff ff    	je     b930 <_ZN3pci11printBussesEv+0x5b0>
    bae1:	0f be d3             	movsx  edx,bl
    bae4:	89 fd                	mov    ebp,edi
    bae6:	8d 7d 01             	lea    edi,[ebp+0x1]
    bae9:	80 fa 25             	cmp    dl,0x25
    baec:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    baef:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    baf2:	74 cc                	je     bac0 <_ZN3pci11printBussesEv+0x740>
    baf4:	83 ec 0c             	sub    esp,0xc
    baf7:	52                   	push   edx
    baf8:	e8 c3 f5 ff ff       	call   b0c0 <_Z7putcharc>
    bafd:	83 c4 10             	add    esp,0x10
    bb00:	84 db                	test   bl,bl
    bb02:	75 dd                	jne    bae1 <_ZN3pci11printBussesEv+0x761>
    bb04:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bb08:	e9 73 f9 ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    bb0d:	8d 76 00             	lea    esi,[esi+0x0]
    bb10:	83 ec 0c             	sub    esp,0xc
    bb13:	8d 6f 02             	lea    ebp,[edi+0x2]
    bb16:	6a 25                	push   0x25
    bb18:	e8 a3 f5 ff ff       	call   b0c0 <_Z7putcharc>
    bb1d:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    bb22:	83 c4 10             	add    esp,0x10
    bb25:	84 db                	test   bl,bl
    bb27:	0f 85 60 fc ff ff    	jne    b78d <_ZN3pci11printBussesEv+0x40d>
    bb2d:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    bb31:	e9 4a f9 ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    bb36:	8d 76 00             	lea    esi,[esi+0x0]
    bb39:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bb40:	83 ec 0c             	sub    esp,0xc
    bb43:	8d 7d 02             	lea    edi,[ebp+0x2]
    bb46:	6a 25                	push   0x25
    bb48:	e8 73 f5 ff ff       	call   b0c0 <_Z7putcharc>
    bb4d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bb52:	83 c4 10             	add    esp,0x10
    bb55:	84 db                	test   bl,bl
    bb57:	0f 85 a4 fb ff ff    	jne    b701 <_ZN3pci11printBussesEv+0x381>
    bb5d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bb61:	e9 95 fa ff ff       	jmp    b5fb <_ZN3pci11printBussesEv+0x27b>
    bb66:	8d 76 00             	lea    esi,[esi+0x0]
    bb69:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bb70:	83 ec 08             	sub    esp,0x8
    bb73:	89 f3                	mov    ebx,esi
    bb75:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    bb79:	8d 44 24 40          	lea    eax,[esp+0x40]
    bb7d:	50                   	push   eax
    bb7e:	51                   	push   ecx
    bb7f:	e8 5c 09 00 00       	call   c4e0 <_Z14_manage_escapeIiEiPKcPT_>
    bb84:	01 c7                	add    edi,eax
    bb86:	89 74 24 4c          	mov    DWORD PTR [esp+0x4c],esi
    bb8a:	83 c4 10             	add    esp,0x10
    bb8d:	01 df                	add    edi,ebx
    bb8f:	0f be 07             	movsx  eax,BYTE PTR [edi]
    bb92:	84 c0                	test   al,al
    bb94:	0f 84 e6 f8 ff ff    	je     b480 <_ZN3pci11printBussesEv+0x100>
    bb9a:	31 d2                	xor    edx,edx
    bb9c:	eb 28                	jmp    bbc6 <_ZN3pci11printBussesEv+0x846>
    bb9e:	66 90                	xchg   ax,ax
    bba0:	80 fb 25             	cmp    bl,0x25
    bba3:	0f 84 f7 00 00 00    	je     bca0 <_ZN3pci11printBussesEv+0x920>
    bba9:	84 db                	test   bl,bl
    bbab:	0f 85 9f 00 00 00    	jne    bc50 <_ZN3pci11printBussesEv+0x8d0>
    bbb1:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    bbb6:	8d 6a 02             	lea    ebp,[edx+0x2]
    bbb9:	84 db                	test   bl,bl
    bbbb:	0f 84 bf f8 ff ff    	je     b480 <_ZN3pci11printBussesEv+0x100>
    bbc1:	0f be c3             	movsx  eax,bl
    bbc4:	89 ea                	mov    edx,ebp
    bbc6:	8d 6a 01             	lea    ebp,[edx+0x1]
    bbc9:	3c 25                	cmp    al,0x25
    bbcb:	8d 0c 2f             	lea    ecx,[edi+ebp*1]
    bbce:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    bbd1:	74 cd                	je     bba0 <_ZN3pci11printBussesEv+0x820>
    bbd3:	83 ec 0c             	sub    esp,0xc
    bbd6:	50                   	push   eax
    bbd7:	e8 e4 f4 ff ff       	call   b0c0 <_Z7putcharc>
    bbdc:	83 c4 10             	add    esp,0x10
    bbdf:	84 db                	test   bl,bl
    bbe1:	75 de                	jne    bbc1 <_ZN3pci11printBussesEv+0x841>
    bbe3:	e9 98 f8 ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    bbe8:	90                   	nop
    bbe9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bbf0:	83 ec 0c             	sub    esp,0xc
    bbf3:	8d 7d 02             	lea    edi,[ebp+0x2]
    bbf6:	6a 25                	push   0x25
    bbf8:	e8 c3 f4 ff ff       	call   b0c0 <_Z7putcharc>
    bbfd:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bc02:	83 c4 10             	add    esp,0x10
    bc05:	84 db                	test   bl,bl
    bc07:	0f 85 00 fd ff ff    	jne    b90d <_ZN3pci11printBussesEv+0x58d>
    bc0d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bc11:	e9 6a f8 ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    bc16:	8d 76 00             	lea    esi,[esi+0x0]
    bc19:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bc20:	83 ec 0c             	sub    esp,0xc
    bc23:	8d 7d 02             	lea    edi,[ebp+0x2]
    bc26:	6a 25                	push   0x25
    bc28:	e8 93 f4 ff ff       	call   b0c0 <_Z7putcharc>
    bc2d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bc32:	83 c4 10             	add    esp,0x10
    bc35:	84 db                	test   bl,bl
    bc37:	0f 85 3c fc ff ff    	jne    b879 <_ZN3pci11printBussesEv+0x4f9>
    bc3d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bc41:	e9 b5 f9 ff ff       	jmp    b5fb <_ZN3pci11printBussesEv+0x27b>
    bc46:	8d 76 00             	lea    esi,[esi+0x0]
    bc49:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bc50:	83 ec 08             	sub    esp,0x8
    bc53:	8d 44 24 44          	lea    eax,[esp+0x44]
    bc57:	50                   	push   eax
    bc58:	51                   	push   ecx
    bc59:	e8 82 08 00 00       	call   c4e0 <_Z14_manage_escapeIiEiPKcPT_>
    bc5e:	8d 1c 28             	lea    ebx,[eax+ebp*1]
    bc61:	01 fb                	add    ebx,edi
    bc63:	89 1c 24             	mov    DWORD PTR [esp],ebx
    bc66:	e8 d5 f4 ff ff       	call   b140 <_Z6printfPKc>
    bc6b:	83 c4 10             	add    esp,0x10
    bc6e:	e9 0d f8 ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    bc73:	90                   	nop
    bc74:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bc78:	83 ec 0c             	sub    esp,0xc
    bc7b:	8d 7d 02             	lea    edi,[ebp+0x2]
    bc7e:	6a 25                	push   0x25
    bc80:	e8 3b f4 ff ff       	call   b0c0 <_Z7putcharc>
    bc85:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bc8a:	83 c4 10             	add    esp,0x10
    bc8d:	84 db                	test   bl,bl
    bc8f:	0f 85 4c fe ff ff    	jne    bae1 <_ZN3pci11printBussesEv+0x761>
    bc95:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bc99:	e9 e2 f7 ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>
    bc9e:	66 90                	xchg   ax,ax
    bca0:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    bca4:	83 ec 0c             	sub    esp,0xc
    bca7:	6a 25                	push   0x25
    bca9:	e8 12 f4 ff ff       	call   b0c0 <_Z7putcharc>
    bcae:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    bcb2:	83 c4 10             	add    esp,0x10
    bcb5:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    bcba:	8d 6a 02             	lea    ebp,[edx+0x2]
    bcbd:	84 db                	test   bl,bl
    bcbf:	0f 85 fc fe ff ff    	jne    bbc1 <_ZN3pci11printBussesEv+0x841>
    bcc5:	e9 b6 f7 ff ff       	jmp    b480 <_ZN3pci11printBussesEv+0x100>

Disassembly of section .text._Z6printfIiEvPKcT_:

0000bcd0 <_Z6printfIiEvPKcT_>:
    bcd0:	55                   	push   ebp
    bcd1:	57                   	push   edi
    bcd2:	31 ff                	xor    edi,edi
    bcd4:	56                   	push   esi
    bcd5:	53                   	push   ebx
    bcd6:	83 ec 1c             	sub    esp,0x1c
    bcd9:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    bcdd:	8b 74 24 30          	mov    esi,DWORD PTR [esp+0x30]
    bce1:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    bce5:	0f be 06             	movsx  eax,BYTE PTR [esi]
    bce8:	84 c0                	test   al,al
    bcea:	74 4c                	je     bd38 <_Z6printfIiEvPKcT_+0x68>
    bcec:	8d 5f 01             	lea    ebx,[edi+0x1]
    bcef:	3c 25                	cmp    al,0x25
    bcf1:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    bcf4:	75 2e                	jne    bd24 <_Z6printfIiEvPKcT_+0x54>
    bcf6:	8d 76 00             	lea    esi,[esi+0x0]
    bcf9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bd00:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    bd04:	3c 25                	cmp    al,0x25
    bd06:	74 78                	je     bd80 <_Z6printfIiEvPKcT_+0xb0>
    bd08:	84 c0                	test   al,al
    bd0a:	75 34                	jne    bd40 <_Z6printfIiEvPKcT_+0x70>
    bd0c:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    bd11:	8d 5f 02             	lea    ebx,[edi+0x2]
    bd14:	84 c0                	test   al,al
    bd16:	74 20                	je     bd38 <_Z6printfIiEvPKcT_+0x68>
    bd18:	89 df                	mov    edi,ebx
    bd1a:	8d 5f 01             	lea    ebx,[edi+0x1]
    bd1d:	3c 25                	cmp    al,0x25
    bd1f:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    bd22:	74 dc                	je     bd00 <_Z6printfIiEvPKcT_+0x30>
    bd24:	83 ec 0c             	sub    esp,0xc
    bd27:	50                   	push   eax
    bd28:	e8 93 f3 ff ff       	call   b0c0 <_Z7putcharc>
    bd2d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    bd31:	83 c4 10             	add    esp,0x10
    bd34:	84 c0                	test   al,al
    bd36:	75 e0                	jne    bd18 <_Z6printfIiEvPKcT_+0x48>
    bd38:	83 c4 1c             	add    esp,0x1c
    bd3b:	5b                   	pop    ebx
    bd3c:	5e                   	pop    esi
    bd3d:	5f                   	pop    edi
    bd3e:	5d                   	pop    ebp
    bd3f:	c3                   	ret    
    bd40:	83 e8 42             	sub    eax,0x42
    bd43:	3c 36                	cmp    al,0x36
    bd45:	77 26                	ja     bd6d <_Z6printfIiEvPKcT_+0x9d>
    bd47:	0f b6 c0             	movzx  eax,al
    bd4a:	ff 24 85 f8 e2 00 00 	jmp    DWORD PTR [eax*4+0xe2f8]
    bd51:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bd58:	83 ec 0c             	sub    esp,0xc
    bd5b:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bd5f:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bd64:	50                   	push   eax
    bd65:	e8 56 f3 ff ff       	call   b0c0 <_Z7putcharc>
    bd6a:	83 c4 10             	add    esp,0x10
    bd6d:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    bd71:	83 c4 1c             	add    esp,0x1c
    bd74:	5b                   	pop    ebx
    bd75:	5e                   	pop    esi
    bd76:	5f                   	pop    edi
    bd77:	5d                   	pop    ebp
    bd78:	e9 c3 f3 ff ff       	jmp    b140 <_Z6printfPKc>
    bd7d:	8d 76 00             	lea    esi,[esi+0x0]
    bd80:	83 ec 0c             	sub    esp,0xc
    bd83:	8d 5f 02             	lea    ebx,[edi+0x2]
    bd86:	6a 25                	push   0x25
    bd88:	e8 33 f3 ff ff       	call   b0c0 <_Z7putcharc>
    bd8d:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    bd92:	83 c4 10             	add    esp,0x10
    bd95:	84 c0                	test   al,al
    bd97:	74 9f                	je     bd38 <_Z6printfIiEvPKcT_+0x68>
    bd99:	89 df                	mov    edi,ebx
    bd9b:	e9 7a ff ff ff       	jmp    bd1a <_Z6printfIiEvPKcT_+0x4a>
    bda0:	83 ec 0c             	sub    esp,0xc
    bda3:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bda7:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bdab:	e8 70 f3 ff ff       	call   b120 <_Z6putstrPc>
    bdb0:	83 c4 10             	add    esp,0x10
    bdb3:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    bdb7:	83 c4 1c             	add    esp,0x1c
    bdba:	5b                   	pop    ebx
    bdbb:	5e                   	pop    esi
    bdbc:	5f                   	pop    edi
    bdbd:	5d                   	pop    ebp
    bdbe:	e9 7d f3 ff ff       	jmp    b140 <_Z6printfPKc>
    bdc3:	90                   	nop
    bdc4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bdc8:	83 ec 0c             	sub    esp,0xc
    bdcb:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bdcf:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bdd3:	e8 38 f3 ff ff       	call   b110 <_Z6putbini>
    bdd8:	83 c4 10             	add    esp,0x10
    bddb:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    bddf:	83 c4 1c             	add    esp,0x1c
    bde2:	5b                   	pop    ebx
    bde3:	5e                   	pop    esi
    bde4:	5f                   	pop    edi
    bde5:	5d                   	pop    ebp
    bde6:	e9 55 f3 ff ff       	jmp    b140 <_Z6printfPKc>
    bdeb:	90                   	nop
    bdec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bdf0:	83 ec 0c             	sub    esp,0xc
    bdf3:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bdf7:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bdfb:	e8 00 f3 ff ff       	call   b100 <_Z6putocti>
    be00:	83 c4 10             	add    esp,0x10
    be03:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be07:	83 c4 1c             	add    esp,0x1c
    be0a:	5b                   	pop    ebx
    be0b:	5e                   	pop    esi
    be0c:	5f                   	pop    edi
    be0d:	5d                   	pop    ebp
    be0e:	e9 2d f3 ff ff       	jmp    b140 <_Z6printfPKc>
    be13:	90                   	nop
    be14:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    be18:	83 ec 0c             	sub    esp,0xc
    be1b:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    be1f:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be23:	e8 c8 f2 ff ff       	call   b0f0 <_Z6puthexi>
    be28:	83 c4 10             	add    esp,0x10
    be2b:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be2f:	83 c4 1c             	add    esp,0x1c
    be32:	5b                   	pop    ebx
    be33:	5e                   	pop    esi
    be34:	5f                   	pop    edi
    be35:	5d                   	pop    ebp
    be36:	e9 05 f3 ff ff       	jmp    b140 <_Z6printfPKc>
    be3b:	90                   	nop
    be3c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    be40:	83 ec 0c             	sub    esp,0xc
    be43:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    be47:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be4b:	e8 90 f2 ff ff       	call   b0e0 <_Z6putdeci>
    be50:	83 c4 10             	add    esp,0x10
    be53:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be57:	83 c4 1c             	add    esp,0x1c
    be5a:	5b                   	pop    ebx
    be5b:	5e                   	pop    esi
    be5c:	5f                   	pop    edi
    be5d:	5d                   	pop    ebp
    be5e:	e9 dd f2 ff ff       	jmp    b140 <_Z6printfPKc>
    be63:	90                   	nop
    be64:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    be68:	83 ec 0c             	sub    esp,0xc
    be6b:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    be6f:	68 f4 e2 00 00       	push   0xe2f4
    be74:	e8 c7 f2 ff ff       	call   b140 <_Z6printfPKc>
    be79:	58                   	pop    eax
    be7a:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be7e:	e8 6d f2 ff ff       	call   b0f0 <_Z6puthexi>
    be83:	83 c4 10             	add    esp,0x10
    be86:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be8a:	83 c4 1c             	add    esp,0x1c
    be8d:	5b                   	pop    ebx
    be8e:	5e                   	pop    esi
    be8f:	5f                   	pop    edi
    be90:	5d                   	pop    ebp
    be91:	e9 aa f2 ff ff       	jmp    b140 <_Z6printfPKc>

Disassembly of section .text._Z6printfIcEvPKcT_:

0000bea0 <_Z6printfIcEvPKcT_>:
    bea0:	55                   	push   ebp
    bea1:	57                   	push   edi
    bea2:	56                   	push   esi
    bea3:	53                   	push   ebx
    bea4:	31 f6                	xor    esi,esi
    bea6:	83 ec 1c             	sub    esp,0x1c
    bea9:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    bead:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    beb1:	88 44 24 0c          	mov    BYTE PTR [esp+0xc],al
    beb5:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    beb9:	84 c0                	test   al,al
    bebb:	74 4e                	je     bf0b <_Z6printfIcEvPKcT_+0x6b>
    bebd:	8d 5e 01             	lea    ebx,[esi+0x1]
    bec0:	3c 25                	cmp    al,0x25
    bec2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    bec6:	75 30                	jne    bef8 <_Z6printfIcEvPKcT_+0x58>
    bec8:	90                   	nop
    bec9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bed0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    bed3:	3c 25                	cmp    al,0x25
    bed5:	0f 84 85 00 00 00    	je     bf60 <_Z6printfIcEvPKcT_+0xc0>
    bedb:	84 c0                	test   al,al
    bedd:	75 39                	jne    bf18 <_Z6printfIcEvPKcT_+0x78>
    bedf:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    bee4:	8d 5e 02             	lea    ebx,[esi+0x2]
    bee7:	84 c0                	test   al,al
    bee9:	74 20                	je     bf0b <_Z6printfIcEvPKcT_+0x6b>
    beeb:	89 de                	mov    esi,ebx
    beed:	8d 5e 01             	lea    ebx,[esi+0x1]
    bef0:	3c 25                	cmp    al,0x25
    bef2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    bef6:	74 d8                	je     bed0 <_Z6printfIcEvPKcT_+0x30>
    bef8:	83 ec 0c             	sub    esp,0xc
    befb:	50                   	push   eax
    befc:	e8 bf f1 ff ff       	call   b0c0 <_Z7putcharc>
    bf01:	0f be 07             	movsx  eax,BYTE PTR [edi]
    bf04:	83 c4 10             	add    esp,0x10
    bf07:	84 c0                	test   al,al
    bf09:	75 e0                	jne    beeb <_Z6printfIcEvPKcT_+0x4b>
    bf0b:	83 c4 1c             	add    esp,0x1c
    bf0e:	5b                   	pop    ebx
    bf0f:	5e                   	pop    esi
    bf10:	5f                   	pop    edi
    bf11:	5d                   	pop    ebp
    bf12:	c3                   	ret    
    bf13:	90                   	nop
    bf14:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bf18:	83 e8 42             	sub    eax,0x42
    bf1b:	3c 36                	cmp    al,0x36
    bf1d:	77 26                	ja     bf45 <_Z6printfIcEvPKcT_+0xa5>
    bf1f:	0f b6 c0             	movzx  eax,al
    bf22:	ff 24 85 d4 e3 00 00 	jmp    DWORD PTR [eax*4+0xe3d4]
    bf29:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bf30:	83 ec 0c             	sub    esp,0xc
    bf33:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bf37:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bf3c:	50                   	push   eax
    bf3d:	e8 7e f1 ff ff       	call   b0c0 <_Z7putcharc>
    bf42:	83 c4 10             	add    esp,0x10
    bf45:	83 ec 0c             	sub    esp,0xc
    bf48:	57                   	push   edi
    bf49:	e8 f2 f1 ff ff       	call   b140 <_Z6printfPKc>
    bf4e:	83 c4 10             	add    esp,0x10
    bf51:	83 c4 1c             	add    esp,0x1c
    bf54:	5b                   	pop    ebx
    bf55:	5e                   	pop    esi
    bf56:	5f                   	pop    edi
    bf57:	5d                   	pop    ebp
    bf58:	c3                   	ret    
    bf59:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bf60:	83 ec 0c             	sub    esp,0xc
    bf63:	8d 5e 02             	lea    ebx,[esi+0x2]
    bf66:	6a 25                	push   0x25
    bf68:	e8 53 f1 ff ff       	call   b0c0 <_Z7putcharc>
    bf6d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    bf72:	83 c4 10             	add    esp,0x10
    bf75:	84 c0                	test   al,al
    bf77:	74 92                	je     bf0b <_Z6printfIcEvPKcT_+0x6b>
    bf79:	89 de                	mov    esi,ebx
    bf7b:	e9 6d ff ff ff       	jmp    beed <_Z6printfIcEvPKcT_+0x4d>
    bf80:	83 ec 0c             	sub    esp,0xc
    bf83:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bf87:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bf8b:	e8 90 f1 ff ff       	call   b120 <_Z6putstrPc>
    bf90:	83 c4 10             	add    esp,0x10
    bf93:	83 ec 0c             	sub    esp,0xc
    bf96:	57                   	push   edi
    bf97:	e8 a4 f1 ff ff       	call   b140 <_Z6printfPKc>
    bf9c:	83 c4 10             	add    esp,0x10
    bf9f:	eb b0                	jmp    bf51 <_Z6printfIcEvPKcT_+0xb1>
    bfa1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bfa8:	83 ec 0c             	sub    esp,0xc
    bfab:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bfaf:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bfb4:	50                   	push   eax
    bfb5:	e8 56 f1 ff ff       	call   b110 <_Z6putbini>
    bfba:	83 c4 10             	add    esp,0x10
    bfbd:	83 ec 0c             	sub    esp,0xc
    bfc0:	57                   	push   edi
    bfc1:	e8 7a f1 ff ff       	call   b140 <_Z6printfPKc>
    bfc6:	83 c4 10             	add    esp,0x10
    bfc9:	eb 86                	jmp    bf51 <_Z6printfIcEvPKcT_+0xb1>
    bfcb:	90                   	nop
    bfcc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bfd0:	83 ec 0c             	sub    esp,0xc
    bfd3:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bfd7:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bfdc:	50                   	push   eax
    bfdd:	e8 1e f1 ff ff       	call   b100 <_Z6putocti>
    bfe2:	83 c4 10             	add    esp,0x10
    bfe5:	83 ec 0c             	sub    esp,0xc
    bfe8:	57                   	push   edi
    bfe9:	e8 52 f1 ff ff       	call   b140 <_Z6printfPKc>
    bfee:	83 c4 10             	add    esp,0x10
    bff1:	e9 5b ff ff ff       	jmp    bf51 <_Z6printfIcEvPKcT_+0xb1>
    bff6:	8d 76 00             	lea    esi,[esi+0x0]
    bff9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c000:	83 ec 0c             	sub    esp,0xc
    c003:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c007:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    c00c:	50                   	push   eax
    c00d:	e8 de f0 ff ff       	call   b0f0 <_Z6puthexi>
    c012:	83 c4 10             	add    esp,0x10
    c015:	83 ec 0c             	sub    esp,0xc
    c018:	57                   	push   edi
    c019:	e8 22 f1 ff ff       	call   b140 <_Z6printfPKc>
    c01e:	83 c4 10             	add    esp,0x10
    c021:	e9 2b ff ff ff       	jmp    bf51 <_Z6printfIcEvPKcT_+0xb1>
    c026:	8d 76 00             	lea    esi,[esi+0x0]
    c029:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c030:	83 ec 0c             	sub    esp,0xc
    c033:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c037:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    c03c:	50                   	push   eax
    c03d:	e8 9e f0 ff ff       	call   b0e0 <_Z6putdeci>
    c042:	83 c4 10             	add    esp,0x10
    c045:	83 ec 0c             	sub    esp,0xc
    c048:	57                   	push   edi
    c049:	e8 f2 f0 ff ff       	call   b140 <_Z6printfPKc>
    c04e:	83 c4 10             	add    esp,0x10
    c051:	e9 fb fe ff ff       	jmp    bf51 <_Z6printfIcEvPKcT_+0xb1>
    c056:	8d 76 00             	lea    esi,[esi+0x0]
    c059:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c060:	83 ec 0c             	sub    esp,0xc
    c063:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c067:	68 f4 e2 00 00       	push   0xe2f4
    c06c:	e8 cf f0 ff ff       	call   b140 <_Z6printfPKc>
    c071:	58                   	pop    eax
    c072:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    c076:	e8 75 f0 ff ff       	call   b0f0 <_Z6puthexi>
    c07b:	83 c4 10             	add    esp,0x10
    c07e:	83 ec 0c             	sub    esp,0xc
    c081:	57                   	push   edi
    c082:	e8 b9 f0 ff ff       	call   b140 <_Z6printfPKc>
    c087:	83 c4 10             	add    esp,0x10
    c08a:	e9 c2 fe ff ff       	jmp    bf51 <_Z6printfIcEvPKcT_+0xb1>

Disassembly of section .text._Z14_manage_escapeItEiPKcPT_:

0000c090 <_Z14_manage_escapeItEiPKcPT_>:
    c090:	83 ec 0c             	sub    esp,0xc
    c093:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c097:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c09a:	83 e8 42             	sub    eax,0x42
    c09d:	3c 36                	cmp    al,0x36
    c09f:	0f 87 f3 00 00 00    	ja     c198 <_Z14_manage_escapeItEiPKcPT_+0x108>
    c0a5:	0f b6 c0             	movzx  eax,al
    c0a8:	ff 24 85 b0 e4 00 00 	jmp    DWORD PTR [eax*4+0xe4b0]
    c0af:	90                   	nop
    c0b0:	83 ec 0c             	sub    esp,0xc
    c0b3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c0b7:	ff 30                	push   DWORD PTR [eax]
    c0b9:	e8 62 f0 ff ff       	call   b120 <_Z6putstrPc>
    c0be:	83 c4 10             	add    esp,0x10
    c0c1:	b8 01 00 00 00       	mov    eax,0x1
    c0c6:	83 c4 0c             	add    esp,0xc
    c0c9:	c3                   	ret    
    c0ca:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c0d0:	83 ec 0c             	sub    esp,0xc
    c0d3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c0d7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c0da:	50                   	push   eax
    c0db:	e8 30 f0 ff ff       	call   b110 <_Z6putbini>
    c0e0:	83 c4 10             	add    esp,0x10
    c0e3:	b8 01 00 00 00       	mov    eax,0x1
    c0e8:	83 c4 0c             	add    esp,0xc
    c0eb:	c3                   	ret    
    c0ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c0f0:	83 ec 0c             	sub    esp,0xc
    c0f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c0f7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c0fa:	50                   	push   eax
    c0fb:	e8 00 f0 ff ff       	call   b100 <_Z6putocti>
    c100:	83 c4 10             	add    esp,0x10
    c103:	b8 01 00 00 00       	mov    eax,0x1
    c108:	83 c4 0c             	add    esp,0xc
    c10b:	c3                   	ret    
    c10c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c110:	83 ec 0c             	sub    esp,0xc
    c113:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c117:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c11a:	50                   	push   eax
    c11b:	e8 d0 ef ff ff       	call   b0f0 <_Z6puthexi>
    c120:	83 c4 10             	add    esp,0x10
    c123:	b8 01 00 00 00       	mov    eax,0x1
    c128:	83 c4 0c             	add    esp,0xc
    c12b:	c3                   	ret    
    c12c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c130:	83 ec 0c             	sub    esp,0xc
    c133:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c137:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c13a:	50                   	push   eax
    c13b:	e8 80 ef ff ff       	call   b0c0 <_Z7putcharc>
    c140:	83 c4 10             	add    esp,0x10
    c143:	b8 01 00 00 00       	mov    eax,0x1
    c148:	83 c4 0c             	add    esp,0xc
    c14b:	c3                   	ret    
    c14c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c150:	83 ec 0c             	sub    esp,0xc
    c153:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c157:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c15a:	50                   	push   eax
    c15b:	e8 80 ef ff ff       	call   b0e0 <_Z6putdeci>
    c160:	83 c4 10             	add    esp,0x10
    c163:	b8 01 00 00 00       	mov    eax,0x1
    c168:	83 c4 0c             	add    esp,0xc
    c16b:	c3                   	ret    
    c16c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c170:	83 ec 0c             	sub    esp,0xc
    c173:	68 f4 e2 00 00       	push   0xe2f4
    c178:	e8 c3 ef ff ff       	call   b140 <_Z6printfPKc>
    c17d:	58                   	pop    eax
    c17e:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c182:	ff 30                	push   DWORD PTR [eax]
    c184:	e8 67 ef ff ff       	call   b0f0 <_Z6puthexi>
    c189:	83 c4 10             	add    esp,0x10
    c18c:	b8 01 00 00 00       	mov    eax,0x1
    c191:	83 c4 0c             	add    esp,0xc
    c194:	c3                   	ret    
    c195:	8d 76 00             	lea    esi,[esi+0x0]
    c198:	31 c0                	xor    eax,eax
    c19a:	e9 27 ff ff ff       	jmp    c0c6 <_Z14_manage_escapeItEiPKcPT_+0x36>

Disassembly of section .text._Z6printfItJttEEvPKcT_DpT0_:

0000c1a0 <_Z6printfItJttEEvPKcT_DpT0_>:
    c1a0:	55                   	push   ebp
    c1a1:	57                   	push   edi
    c1a2:	31 c9                	xor    ecx,ecx
    c1a4:	56                   	push   esi
    c1a5:	53                   	push   ebx
    c1a6:	83 ec 2c             	sub    esp,0x2c
    c1a9:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    c1ad:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    c1b1:	8b 74 24 48          	mov    esi,DWORD PTR [esp+0x48]
    c1b5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    c1b9:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    c1bd:	66 89 44 24 0c       	mov    WORD PTR [esp+0xc],ax
    c1c2:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c1c6:	84 c0                	test   al,al
    c1c8:	74 49                	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c1ca:	8d 79 01             	lea    edi,[ecx+0x1]
    c1cd:	3c 25                	cmp    al,0x25
    c1cf:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    c1d3:	75 2b                	jne    c200 <_Z6printfItJttEEvPKcT_DpT0_+0x60>
    c1d5:	8d 76 00             	lea    esi,[esi+0x0]
    c1d8:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    c1db:	3c 25                	cmp    al,0x25
    c1dd:	0f 84 3d 01 00 00    	je     c320 <_Z6printfItJttEEvPKcT_DpT0_+0x180>
    c1e3:	84 c0                	test   al,al
    c1e5:	75 39                	jne    c220 <_Z6printfItJttEEvPKcT_DpT0_+0x80>
    c1e7:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    c1ec:	8d 79 02             	lea    edi,[ecx+0x2]
    c1ef:	84 c0                	test   al,al
    c1f1:	74 20                	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c1f3:	89 f9                	mov    ecx,edi
    c1f5:	8d 79 01             	lea    edi,[ecx+0x1]
    c1f8:	3c 25                	cmp    al,0x25
    c1fa:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    c1fe:	74 d8                	je     c1d8 <_Z6printfItJttEEvPKcT_DpT0_+0x38>
    c200:	83 ec 0c             	sub    esp,0xc
    c203:	50                   	push   eax
    c204:	e8 b7 ee ff ff       	call   b0c0 <_Z7putcharc>
    c209:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    c20c:	83 c4 10             	add    esp,0x10
    c20f:	84 c0                	test   al,al
    c211:	75 e0                	jne    c1f3 <_Z6printfItJttEEvPKcT_DpT0_+0x53>
    c213:	83 c4 2c             	add    esp,0x2c
    c216:	5b                   	pop    ebx
    c217:	5e                   	pop    esi
    c218:	5f                   	pop    edi
    c219:	5d                   	pop    ebp
    c21a:	c3                   	ret    
    c21b:	90                   	nop
    c21c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c220:	83 ec 08             	sub    esp,0x8
    c223:	8d 44 24 14          	lea    eax,[esp+0x14]
    c227:	50                   	push   eax
    c228:	53                   	push   ebx
    c229:	e8 62 fe ff ff       	call   c090 <_Z14_manage_escapeItEiPKcPT_>
    c22e:	01 c7                	add    edi,eax
    c230:	66 89 74 24 2c       	mov    WORD PTR [esp+0x2c],si
    c235:	83 c4 10             	add    esp,0x10
    c238:	01 fd                	add    ebp,edi
    c23a:	31 ff                	xor    edi,edi
    c23c:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c240:	84 c0                	test   al,al
    c242:	74 cf                	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c244:	8d 77 01             	lea    esi,[edi+0x1]
    c247:	3c 25                	cmp    al,0x25
    c249:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    c24d:	75 29                	jne    c278 <_Z6printfItJttEEvPKcT_DpT0_+0xd8>
    c24f:	90                   	nop
    c250:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    c253:	3c 25                	cmp    al,0x25
    c255:	0f 84 1d 01 00 00    	je     c378 <_Z6printfItJttEEvPKcT_DpT0_+0x1d8>
    c25b:	84 c0                	test   al,al
    c25d:	75 31                	jne    c290 <_Z6printfItJttEEvPKcT_DpT0_+0xf0>
    c25f:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    c264:	8d 77 02             	lea    esi,[edi+0x2]
    c267:	84 c0                	test   al,al
    c269:	74 a8                	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c26b:	89 f7                	mov    edi,esi
    c26d:	8d 77 01             	lea    esi,[edi+0x1]
    c270:	3c 25                	cmp    al,0x25
    c272:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    c276:	74 d8                	je     c250 <_Z6printfItJttEEvPKcT_DpT0_+0xb0>
    c278:	83 ec 0c             	sub    esp,0xc
    c27b:	50                   	push   eax
    c27c:	e8 3f ee ff ff       	call   b0c0 <_Z7putcharc>
    c281:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    c284:	83 c4 10             	add    esp,0x10
    c287:	84 c0                	test   al,al
    c289:	74 88                	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c28b:	89 f7                	mov    edi,esi
    c28d:	eb de                	jmp    c26d <_Z6printfItJttEEvPKcT_DpT0_+0xcd>
    c28f:	90                   	nop
    c290:	83 ec 08             	sub    esp,0x8
    c293:	8d 44 24 24          	lea    eax,[esp+0x24]
    c297:	50                   	push   eax
    c298:	53                   	push   ebx
    c299:	e8 f2 fd ff ff       	call   c090 <_Z14_manage_escapeItEiPKcPT_>
    c29e:	01 c6                	add    esi,eax
    c2a0:	0f b7 44 24 14       	movzx  eax,WORD PTR [esp+0x14]
    c2a5:	01 f5                	add    ebp,esi
    c2a7:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    c2ac:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c2b0:	83 c4 10             	add    esp,0x10
    c2b3:	84 c0                	test   al,al
    c2b5:	0f 84 58 ff ff ff    	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c2bb:	31 f6                	xor    esi,esi
    c2bd:	3c 25                	cmp    al,0x25
    c2bf:	8d 5e 01             	lea    ebx,[esi+0x1]
    c2c2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    c2c6:	75 34                	jne    c2fc <_Z6printfItJttEEvPKcT_DpT0_+0x15c>
    c2c8:	90                   	nop
    c2c9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c2d0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    c2d3:	3c 25                	cmp    al,0x25
    c2d5:	0f 84 c5 00 00 00    	je     c3a0 <_Z6printfItJttEEvPKcT_DpT0_+0x200>
    c2db:	84 c0                	test   al,al
    c2dd:	75 71                	jne    c350 <_Z6printfItJttEEvPKcT_DpT0_+0x1b0>
    c2df:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    c2e4:	8d 5e 02             	lea    ebx,[esi+0x2]
    c2e7:	84 c0                	test   al,al
    c2e9:	0f 84 24 ff ff ff    	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c2ef:	89 de                	mov    esi,ebx
    c2f1:	8d 5e 01             	lea    ebx,[esi+0x1]
    c2f4:	3c 25                	cmp    al,0x25
    c2f6:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    c2fa:	74 d4                	je     c2d0 <_Z6printfItJttEEvPKcT_DpT0_+0x130>
    c2fc:	83 ec 0c             	sub    esp,0xc
    c2ff:	50                   	push   eax
    c300:	e8 bb ed ff ff       	call   b0c0 <_Z7putcharc>
    c305:	0f be 07             	movsx  eax,BYTE PTR [edi]
    c308:	83 c4 10             	add    esp,0x10
    c30b:	84 c0                	test   al,al
    c30d:	0f 84 00 ff ff ff    	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c313:	89 de                	mov    esi,ebx
    c315:	eb da                	jmp    c2f1 <_Z6printfItJttEEvPKcT_DpT0_+0x151>
    c317:	89 f6                	mov    esi,esi
    c319:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c320:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    c324:	83 ec 0c             	sub    esp,0xc
    c327:	6a 25                	push   0x25
    c329:	e8 92 ed ff ff       	call   b0c0 <_Z7putcharc>
    c32e:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    c332:	83 c4 10             	add    esp,0x10
    c335:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    c33a:	8d 79 02             	lea    edi,[ecx+0x2]
    c33d:	84 c0                	test   al,al
    c33f:	0f 84 ce fe ff ff    	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c345:	89 f9                	mov    ecx,edi
    c347:	e9 a9 fe ff ff       	jmp    c1f5 <_Z6printfItJttEEvPKcT_DpT0_+0x55>
    c34c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c350:	83 ec 08             	sub    esp,0x8
    c353:	8d 44 24 26          	lea    eax,[esp+0x26]
    c357:	50                   	push   eax
    c358:	57                   	push   edi
    c359:	e8 32 fd ff ff       	call   c090 <_Z14_manage_escapeItEiPKcPT_>
    c35e:	01 c3                	add    ebx,eax
    c360:	01 dd                	add    ebp,ebx
    c362:	89 2c 24             	mov    DWORD PTR [esp],ebp
    c365:	e8 d6 ed ff ff       	call   b140 <_Z6printfPKc>
    c36a:	83 c4 10             	add    esp,0x10
    c36d:	83 c4 2c             	add    esp,0x2c
    c370:	5b                   	pop    ebx
    c371:	5e                   	pop    esi
    c372:	5f                   	pop    edi
    c373:	5d                   	pop    ebp
    c374:	c3                   	ret    
    c375:	8d 76 00             	lea    esi,[esi+0x0]
    c378:	83 ec 0c             	sub    esp,0xc
    c37b:	8d 77 02             	lea    esi,[edi+0x2]
    c37e:	6a 25                	push   0x25
    c380:	e8 3b ed ff ff       	call   b0c0 <_Z7putcharc>
    c385:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    c38a:	83 c4 10             	add    esp,0x10
    c38d:	84 c0                	test   al,al
    c38f:	0f 84 7e fe ff ff    	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c395:	89 f7                	mov    edi,esi
    c397:	e9 d1 fe ff ff       	jmp    c26d <_Z6printfItJttEEvPKcT_DpT0_+0xcd>
    c39c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c3a0:	83 ec 0c             	sub    esp,0xc
    c3a3:	8d 5e 02             	lea    ebx,[esi+0x2]
    c3a6:	6a 25                	push   0x25
    c3a8:	e8 13 ed ff ff       	call   b0c0 <_Z7putcharc>
    c3ad:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    c3b2:	83 c4 10             	add    esp,0x10
    c3b5:	84 c0                	test   al,al
    c3b7:	0f 84 56 fe ff ff    	je     c213 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c3bd:	89 de                	mov    esi,ebx
    c3bf:	e9 2d ff ff ff       	jmp    c2f1 <_Z6printfItJttEEvPKcT_DpT0_+0x151>

Disassembly of section .text._Z14_manage_escapeIhEiPKcPT_:

0000c3d0 <_Z14_manage_escapeIhEiPKcPT_>:
    c3d0:	83 ec 0c             	sub    esp,0xc
    c3d3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c3d7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c3da:	83 e8 42             	sub    eax,0x42
    c3dd:	3c 36                	cmp    al,0x36
    c3df:	0f 87 f3 00 00 00    	ja     c4d8 <_Z14_manage_escapeIhEiPKcPT_+0x108>
    c3e5:	0f b6 c0             	movzx  eax,al
    c3e8:	ff 24 85 90 e5 00 00 	jmp    DWORD PTR [eax*4+0xe590]
    c3ef:	90                   	nop
    c3f0:	83 ec 0c             	sub    esp,0xc
    c3f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c3f7:	ff 30                	push   DWORD PTR [eax]
    c3f9:	e8 22 ed ff ff       	call   b120 <_Z6putstrPc>
    c3fe:	83 c4 10             	add    esp,0x10
    c401:	b8 01 00 00 00       	mov    eax,0x1
    c406:	83 c4 0c             	add    esp,0xc
    c409:	c3                   	ret    
    c40a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c410:	83 ec 0c             	sub    esp,0xc
    c413:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c417:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c41a:	50                   	push   eax
    c41b:	e8 f0 ec ff ff       	call   b110 <_Z6putbini>
    c420:	83 c4 10             	add    esp,0x10
    c423:	b8 01 00 00 00       	mov    eax,0x1
    c428:	83 c4 0c             	add    esp,0xc
    c42b:	c3                   	ret    
    c42c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c430:	83 ec 0c             	sub    esp,0xc
    c433:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c437:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c43a:	50                   	push   eax
    c43b:	e8 c0 ec ff ff       	call   b100 <_Z6putocti>
    c440:	83 c4 10             	add    esp,0x10
    c443:	b8 01 00 00 00       	mov    eax,0x1
    c448:	83 c4 0c             	add    esp,0xc
    c44b:	c3                   	ret    
    c44c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c450:	83 ec 0c             	sub    esp,0xc
    c453:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c457:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c45a:	50                   	push   eax
    c45b:	e8 90 ec ff ff       	call   b0f0 <_Z6puthexi>
    c460:	83 c4 10             	add    esp,0x10
    c463:	b8 01 00 00 00       	mov    eax,0x1
    c468:	83 c4 0c             	add    esp,0xc
    c46b:	c3                   	ret    
    c46c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c470:	83 ec 0c             	sub    esp,0xc
    c473:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c477:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c47a:	50                   	push   eax
    c47b:	e8 40 ec ff ff       	call   b0c0 <_Z7putcharc>
    c480:	83 c4 10             	add    esp,0x10
    c483:	b8 01 00 00 00       	mov    eax,0x1
    c488:	83 c4 0c             	add    esp,0xc
    c48b:	c3                   	ret    
    c48c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c490:	83 ec 0c             	sub    esp,0xc
    c493:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c497:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c49a:	50                   	push   eax
    c49b:	e8 40 ec ff ff       	call   b0e0 <_Z6putdeci>
    c4a0:	83 c4 10             	add    esp,0x10
    c4a3:	b8 01 00 00 00       	mov    eax,0x1
    c4a8:	83 c4 0c             	add    esp,0xc
    c4ab:	c3                   	ret    
    c4ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c4b0:	83 ec 0c             	sub    esp,0xc
    c4b3:	68 8c e5 00 00       	push   0xe58c
    c4b8:	e8 83 ec ff ff       	call   b140 <_Z6printfPKc>
    c4bd:	58                   	pop    eax
    c4be:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c4c2:	ff 30                	push   DWORD PTR [eax]
    c4c4:	e8 27 ec ff ff       	call   b0f0 <_Z6puthexi>
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
    c4f8:	ff 24 85 6c e6 00 00 	jmp    DWORD PTR [eax*4+0xe66c]
    c4ff:	90                   	nop
    c500:	83 ec 0c             	sub    esp,0xc
    c503:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c507:	ff 30                	push   DWORD PTR [eax]
    c509:	e8 12 ec ff ff       	call   b120 <_Z6putstrPc>
    c50e:	83 c4 10             	add    esp,0x10
    c511:	b8 01 00 00 00       	mov    eax,0x1
    c516:	83 c4 0c             	add    esp,0xc
    c519:	c3                   	ret    
    c51a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c520:	83 ec 0c             	sub    esp,0xc
    c523:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c527:	ff 30                	push   DWORD PTR [eax]
    c529:	e8 e2 eb ff ff       	call   b110 <_Z6putbini>
    c52e:	83 c4 10             	add    esp,0x10
    c531:	b8 01 00 00 00       	mov    eax,0x1
    c536:	83 c4 0c             	add    esp,0xc
    c539:	c3                   	ret    
    c53a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c540:	83 ec 0c             	sub    esp,0xc
    c543:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c547:	ff 30                	push   DWORD PTR [eax]
    c549:	e8 b2 eb ff ff       	call   b100 <_Z6putocti>
    c54e:	83 c4 10             	add    esp,0x10
    c551:	b8 01 00 00 00       	mov    eax,0x1
    c556:	83 c4 0c             	add    esp,0xc
    c559:	c3                   	ret    
    c55a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c560:	83 ec 0c             	sub    esp,0xc
    c563:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c567:	ff 30                	push   DWORD PTR [eax]
    c569:	e8 82 eb ff ff       	call   b0f0 <_Z6puthexi>
    c56e:	83 c4 10             	add    esp,0x10
    c571:	b8 01 00 00 00       	mov    eax,0x1
    c576:	83 c4 0c             	add    esp,0xc
    c579:	c3                   	ret    
    c57a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c580:	83 ec 0c             	sub    esp,0xc
    c583:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c587:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c58a:	50                   	push   eax
    c58b:	e8 30 eb ff ff       	call   b0c0 <_Z7putcharc>
    c590:	83 c4 10             	add    esp,0x10
    c593:	b8 01 00 00 00       	mov    eax,0x1
    c598:	83 c4 0c             	add    esp,0xc
    c59b:	c3                   	ret    
    c59c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c5a0:	83 ec 0c             	sub    esp,0xc
    c5a3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c5a7:	ff 30                	push   DWORD PTR [eax]
    c5a9:	e8 32 eb ff ff       	call   b0e0 <_Z6putdeci>
    c5ae:	83 c4 10             	add    esp,0x10
    c5b1:	b8 01 00 00 00       	mov    eax,0x1
    c5b6:	83 c4 0c             	add    esp,0xc
    c5b9:	c3                   	ret    
    c5ba:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c5c0:	83 ec 0c             	sub    esp,0xc
    c5c3:	68 8c e5 00 00       	push   0xe58c
    c5c8:	e8 73 eb ff ff       	call   b140 <_Z6printfPKc>
    c5cd:	58                   	pop    eax
    c5ce:	eb 93                	jmp    c563 <_Z14_manage_escapeIiEiPKcPT_+0x83>
    c5d0:	31 c0                	xor    eax,eax
    c5d2:	e9 3f ff ff ff       	jmp    c516 <_Z14_manage_escapeIiEiPKcPT_+0x36>
