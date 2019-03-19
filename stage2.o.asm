
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
    a018:	e8 f3 10 00 00       	call   b110 <_Z12clear_screenv>
    a01d:	83 ec 0c             	sub    esp,0xc
    a020:	68 dc d0 00 00       	push   0xd0dc
    a025:	e8 76 11 00 00       	call   b1a0 <_Z6printfPKc>
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
    a065:	e8 36 11 00 00       	call   b1a0 <_Z6printfPKc>
    a06a:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    a071:	68 00 10 00 00       	push   0x1000
    a076:	6a 00                	push   0x0
    a078:	68 80 00 00 00       	push   0x80
    a07d:	68 00 00 00 01       	push   0x1000000
    a082:	e8 89 05 00 00       	call   a610 <_ZN3ata9lba48ReadEPvyjh>
    a087:	83 c4 20             	add    esp,0x20
    a08a:	84 c0                	test   al,al
    a08c:	75 39                	jne    a0c7 <kernel_2+0xb7>
    a08e:	83 ec 0c             	sub    esp,0xc
    a091:	68 f7 d0 00 00       	push   0xd0f7
    a096:	e8 05 11 00 00       	call   b1a0 <_Z6printfPKc>
    a09b:	83 c4 10             	add    esp,0x10
    a09e:	e8 7d 09 00 00       	call   aa20 <_ZN6paging18init_kernel_pagingEv>
    a0a3:	e8 58 5f ff c0       	call   c1000000 <VGA_TEXT_MEMORY+0xc0f48000>
    a0a8:	eb fe                	jmp    a0a8 <kernel_2+0x98>
    a0aa:	6a 00                	push   0x0
    a0ac:	68 00 10 00 00       	push   0x1000
    a0b1:	68 80 00 00 00       	push   0x80
    a0b6:	68 00 00 00 01       	push   0x1000000
    a0bb:	e8 10 03 00 00       	call   a3d0 <_ZN3ata9lba28ReadEPvjjh>
    a0c0:	83 c4 10             	add    esp,0x10
    a0c3:	84 c0                	test   al,al
    a0c5:	74 c7                	je     a08e <kernel_2+0x7e>
    a0c7:	83 ec 0c             	sub    esp,0xc
    a0ca:	68 04 d1 00 00       	push   0xd104
    a0cf:	e8 cc 10 00 00       	call   b1a0 <_Z6printfPKc>
    a0d4:	83 c4 10             	add    esp,0x10
    a0d7:	eb c5                	jmp    a09e <kernel_2+0x8e>
    a0d9:	83 ec 0c             	sub    esp,0xc
    a0dc:	68 e6 d0 00 00       	push   0xd0e6
    a0e1:	e8 ba 10 00 00       	call   b1a0 <_Z6printfPKc>
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
    a200:	e8 2b 10 00 00       	call   b230 <_Z3inbt>
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
    a224:	e8 07 10 00 00       	call   b230 <_Z3inbt>
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
    a27d:	e8 5e 0f 00 00       	call   b1e0 <_Z4outbth>
    a282:	58                   	pop    eax
    a283:	5a                   	pop    edx
    a284:	6a 00                	push   0x0
    a286:	68 f1 01 00 00       	push   0x1f1
    a28b:	e8 50 0f 00 00       	call   b1e0 <_Z4outbth>
    a290:	59                   	pop    ecx
    a291:	89 f8                	mov    eax,edi
    a293:	5e                   	pop    esi
    a294:	0f b6 f8             	movzx  edi,al
    a297:	57                   	push   edi
    a298:	68 f2 01 00 00       	push   0x1f2
    a29d:	e8 3e 0f 00 00       	call   b1e0 <_Z4outbth>
    a2a2:	5d                   	pop    ebp
    a2a3:	58                   	pop    eax
    a2a4:	0f b6 c3             	movzx  eax,bl
    a2a7:	50                   	push   eax
    a2a8:	68 f3 01 00 00       	push   0x1f3
    a2ad:	e8 2e 0f 00 00       	call   b1e0 <_Z4outbth>
    a2b2:	58                   	pop    eax
    a2b3:	5a                   	pop    edx
    a2b4:	0f b6 c7             	movzx  eax,bh
    a2b7:	50                   	push   eax
    a2b8:	68 f4 01 00 00       	push   0x1f4
    a2bd:	e8 1e 0f 00 00       	call   b1e0 <_Z4outbth>
    a2c2:	89 d8                	mov    eax,ebx
    a2c4:	59                   	pop    ecx
    a2c5:	c1 e8 10             	shr    eax,0x10
    a2c8:	5e                   	pop    esi
    a2c9:	0f b6 c0             	movzx  eax,al
    a2cc:	50                   	push   eax
    a2cd:	68 f5 01 00 00       	push   0x1f5
    a2d2:	e8 09 0f 00 00       	call   b1e0 <_Z4outbth>
    a2d7:	83 c4 10             	add    esp,0x10
    a2da:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a2e0:	83 ec 0c             	sub    esp,0xc
    a2e3:	68 f7 01 00 00       	push   0x1f7
    a2e8:	e8 43 0f 00 00       	call   b230 <_Z3inbt>
    a2ed:	83 c4 10             	add    esp,0x10
    a2f0:	84 c0                	test   al,al
    a2f2:	78 ec                	js     a2e0 <_ZN3ata12lba28PIOReadEPvjhh+0x90>
    a2f4:	83 ec 08             	sub    esp,0x8
    a2f7:	6a 20                	push   0x20
    a2f9:	68 f7 01 00 00       	push   0x1f7
    a2fe:	e8 dd 0e 00 00       	call   b1e0 <_Z4outbth>
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
    a328:	e8 03 0f 00 00       	call   b230 <_Z3inbt>
    a32d:	83 c4 10             	add    esp,0x10
    a330:	84 c0                	test   al,al
    a332:	78 ec                	js     a320 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a334:	83 ec 0c             	sub    esp,0xc
    a337:	68 f6 03 00 00       	push   0x3f6
    a33c:	e8 ef 0e 00 00       	call   b230 <_Z3inbt>
    a341:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a348:	e8 e3 0e 00 00       	call   b230 <_Z3inbt>
    a34d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a354:	e8 d7 0e 00 00       	call   b230 <_Z3inbt>
    a359:	83 c4 10             	add    esp,0x10
    a35c:	eb 06                	jmp    a364 <_ZN3ata12lba28PIOReadEPvjhh+0x114>
    a35e:	66 90                	xchg   ax,ax
    a360:	a8 08                	test   al,0x8
    a362:	75 1e                	jne    a382 <_ZN3ata12lba28PIOReadEPvjhh+0x132>
    a364:	83 ec 0c             	sub    esp,0xc
    a367:	68 f7 01 00 00       	push   0x1f7
    a36c:	e8 bf 0e 00 00       	call   b230 <_Z3inbt>
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
    a3a3:	e8 98 0e 00 00       	call   b240 <_Z3inwt>
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
    a467:	e8 74 0d 00 00       	call   b1e0 <_Z4outbth>
    a46c:	58                   	pop    eax
    a46d:	5a                   	pop    edx
    a46e:	6a 00                	push   0x0
    a470:	68 f1 01 00 00       	push   0x1f1
    a475:	e8 66 0d 00 00       	call   b1e0 <_Z4outbth>
    a47a:	59                   	pop    ecx
    a47b:	5e                   	pop    esi
    a47c:	0f b6 c7             	movzx  eax,bh
    a47f:	50                   	push   eax
    a480:	68 f2 01 00 00       	push   0x1f2
    a485:	e8 56 0d 00 00       	call   b1e0 <_Z4outbth>
    a48a:	58                   	pop    eax
    a48b:	89 f8                	mov    eax,edi
    a48d:	0f ac e8 18          	shrd   eax,ebp,0x18
    a491:	5a                   	pop    edx
    a492:	0f b6 c0             	movzx  eax,al
    a495:	50                   	push   eax
    a496:	68 f3 01 00 00       	push   0x1f3
    a49b:	e8 40 0d 00 00       	call   b1e0 <_Z4outbth>
    a4a0:	5e                   	pop    esi
    a4a1:	58                   	pop    eax
    a4a2:	89 e8                	mov    eax,ebp
    a4a4:	0f b6 c0             	movzx  eax,al
    a4a7:	50                   	push   eax
    a4a8:	68 f4 01 00 00       	push   0x1f4
    a4ad:	e8 2e 0d 00 00       	call   b1e0 <_Z4outbth>
    a4b2:	58                   	pop    eax
    a4b3:	89 e8                	mov    eax,ebp
    a4b5:	5a                   	pop    edx
    a4b6:	0f b6 c4             	movzx  eax,ah
    a4b9:	50                   	push   eax
    a4ba:	68 f5 01 00 00       	push   0x1f5
    a4bf:	e8 1c 0d 00 00       	call   b1e0 <_Z4outbth>
    a4c4:	59                   	pop    ecx
    a4c5:	5e                   	pop    esi
    a4c6:	0f b6 c3             	movzx  eax,bl
    a4c9:	50                   	push   eax
    a4ca:	68 f2 01 00 00       	push   0x1f2
    a4cf:	e8 0c 0d 00 00       	call   b1e0 <_Z4outbth>
    a4d4:	58                   	pop    eax
    a4d5:	89 f8                	mov    eax,edi
    a4d7:	5a                   	pop    edx
    a4d8:	0f b6 c0             	movzx  eax,al
    a4db:	50                   	push   eax
    a4dc:	68 f3 01 00 00       	push   0x1f3
    a4e1:	e8 fa 0c 00 00       	call   b1e0 <_Z4outbth>
    a4e6:	89 f8                	mov    eax,edi
    a4e8:	0f ac e8 08          	shrd   eax,ebp,0x8
    a4ec:	59                   	pop    ecx
    a4ed:	5e                   	pop    esi
    a4ee:	0f b6 c0             	movzx  eax,al
    a4f1:	50                   	push   eax
    a4f2:	68 f4 01 00 00       	push   0x1f4
    a4f7:	0f ac ef 10          	shrd   edi,ebp,0x10
    a4fb:	e8 e0 0c 00 00       	call   b1e0 <_Z4outbth>
    a500:	5e                   	pop    esi
    a501:	58                   	pop    eax
    a502:	89 f8                	mov    eax,edi
    a504:	0f b6 f0             	movzx  esi,al
    a507:	56                   	push   esi
    a508:	68 f5 01 00 00       	push   0x1f5
    a50d:	e8 ce 0c 00 00       	call   b1e0 <_Z4outbth>
    a512:	83 c4 10             	add    esp,0x10
    a515:	8d 76 00             	lea    esi,[esi+0x0]
    a518:	83 ec 0c             	sub    esp,0xc
    a51b:	68 f7 01 00 00       	push   0x1f7
    a520:	e8 0b 0d 00 00       	call   b230 <_Z3inbt>
    a525:	83 c4 10             	add    esp,0x10
    a528:	84 c0                	test   al,al
    a52a:	78 ec                	js     a518 <_ZN3ata12lba48PIOReadEPvyth+0xd8>
    a52c:	83 ec 08             	sub    esp,0x8
    a52f:	89 df                	mov    edi,ebx
    a531:	6a 24                	push   0x24
    a533:	68 f7 01 00 00       	push   0x1f7
    a538:	e8 a3 0c 00 00       	call   b1e0 <_Z4outbth>
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
    a568:	e8 c3 0c 00 00       	call   b230 <_Z3inbt>
    a56d:	83 c4 10             	add    esp,0x10
    a570:	84 c0                	test   al,al
    a572:	78 ec                	js     a560 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a574:	83 ec 0c             	sub    esp,0xc
    a577:	68 f6 03 00 00       	push   0x3f6
    a57c:	e8 af 0c 00 00       	call   b230 <_Z3inbt>
    a581:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a588:	e8 a3 0c 00 00       	call   b230 <_Z3inbt>
    a58d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a594:	e8 97 0c 00 00       	call   b230 <_Z3inbt>
    a599:	83 c4 10             	add    esp,0x10
    a59c:	eb 06                	jmp    a5a4 <_ZN3ata12lba48PIOReadEPvyth+0x164>
    a59e:	66 90                	xchg   ax,ax
    a5a0:	a8 08                	test   al,0x8
    a5a2:	75 1e                	jne    a5c2 <_ZN3ata12lba48PIOReadEPvyth+0x182>
    a5a4:	83 ec 0c             	sub    esp,0xc
    a5a7:	68 f7 01 00 00       	push   0x1f7
    a5ac:	e8 7f 0c 00 00       	call   b230 <_Z3inbt>
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
    a5e3:	e8 58 0c 00 00       	call   b240 <_Z3inwt>
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
    a6cd:	e8 5e 0b 00 00       	call   b230 <_Z3inbt>
    a6d2:	83 c4 10             	add    esp,0x10
    a6d5:	3c ff                	cmp    al,0xff
    a6d7:	0f 84 e3 00 00 00    	je     a7c0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a6dd:	c1 e3 04             	shl    ebx,0x4
    a6e0:	83 ec 08             	sub    esp,0x8
    a6e3:	83 cb a0             	or     ebx,0xffffffa0
    a6e6:	0f b6 c3             	movzx  eax,bl
    a6e9:	50                   	push   eax
    a6ea:	68 f6 01 00 00       	push   0x1f6
    a6ef:	e8 ec 0a 00 00       	call   b1e0 <_Z4outbth>
    a6f4:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a6fb:	e8 30 0b 00 00       	call   b230 <_Z3inbt>
    a700:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a707:	e8 24 0b 00 00       	call   b230 <_Z3inbt>
    a70c:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a713:	e8 18 0b 00 00       	call   b230 <_Z3inbt>
    a718:	83 c4 10             	add    esp,0x10
    a71b:	90                   	nop
    a71c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a720:	83 ec 0c             	sub    esp,0xc
    a723:	68 f7 01 00 00       	push   0x1f7
    a728:	e8 03 0b 00 00       	call   b230 <_Z3inbt>
    a72d:	83 c4 10             	add    esp,0x10
    a730:	84 c0                	test   al,al
    a732:	78 ec                	js     a720 <_ZN3ata12sendIdentifyEhRbb+0x70>
    a734:	83 ec 08             	sub    esp,0x8
    a737:	6a 00                	push   0x0
    a739:	68 f2 01 00 00       	push   0x1f2
    a73e:	e8 9d 0a 00 00       	call   b1e0 <_Z4outbth>
    a743:	59                   	pop    ecx
    a744:	5b                   	pop    ebx
    a745:	6a 00                	push   0x0
    a747:	68 f3 01 00 00       	push   0x1f3
    a74c:	e8 8f 0a 00 00       	call   b1e0 <_Z4outbth>
    a751:	5e                   	pop    esi
    a752:	5f                   	pop    edi
    a753:	6a 00                	push   0x0
    a755:	68 f4 01 00 00       	push   0x1f4
    a75a:	e8 81 0a 00 00       	call   b1e0 <_Z4outbth>
    a75f:	58                   	pop    eax
    a760:	5a                   	pop    edx
    a761:	6a 00                	push   0x0
    a763:	68 f5 01 00 00       	push   0x1f5
    a768:	e8 73 0a 00 00       	call   b1e0 <_Z4outbth>
    a76d:	59                   	pop    ecx
    a76e:	5b                   	pop    ebx
    a76f:	68 ec 00 00 00       	push   0xec
    a774:	68 f7 01 00 00       	push   0x1f7
    a779:	e8 62 0a 00 00       	call   b1e0 <_Z4outbth>
    a77e:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    a785:	e8 a6 0a 00 00       	call   b230 <_Z3inbt>
    a78a:	83 c4 10             	add    esp,0x10
    a78d:	84 c0                	test   al,al
    a78f:	74 2f                	je     a7c0 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a791:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a798:	83 ec 0c             	sub    esp,0xc
    a79b:	68 f7 01 00 00       	push   0x1f7
    a7a0:	e8 8b 0a 00 00       	call   b230 <_Z3inbt>
    a7a5:	83 c4 10             	add    esp,0x10
    a7a8:	84 c0                	test   al,al
    a7aa:	78 ec                	js     a798 <_ZN3ata12sendIdentifyEhRbb+0xe8>
    a7ac:	83 ec 0c             	sub    esp,0xc
    a7af:	68 f4 01 00 00       	push   0x1f4
    a7b4:	e8 77 0a 00 00       	call   b230 <_Z3inbt>
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
    a7d8:	e8 53 0a 00 00       	call   b230 <_Z3inbt>
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
    a7fc:	e8 2f 0a 00 00       	call   b230 <_Z3inbt>
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
    a833:	e8 08 0a 00 00       	call   b240 <_Z3inwt>
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
    a880:	e8 1b 09 00 00       	call   b1a0 <_Z6printfPKc>
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
    a8ac:	e8 3f 18 00 00       	call   c0f0 <_Z14_manage_escapeItEiPKcPT_>
    a8b1:	05 26 d1 00 00       	add    eax,0xd126
    a8b6:	89 04 24             	mov    DWORD PTR [esp],eax
    a8b9:	e8 e2 08 00 00       	call   b1a0 <_Z6printfPKc>
    a8be:	83 c4 10             	add    esp,0x10
    a8c1:	39 f7                	cmp    edi,esi
    a8c3:	75 d3                	jne    a898 <_ZN3ata12sendIdentifyEhRbb+0x1e8>
    a8c5:	83 ec 0c             	sub    esp,0xc
    a8c8:	68 82 d1 00 00       	push   0xd182
    a8cd:	e8 ce 08 00 00       	call   b1a0 <_Z6printfPKc>
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
    a8f5:	e8 06 19 00 00       	call   c200 <_Z6printfItJttEEvPKcT_DpT0_>
    a8fa:	58                   	pop    eax
    a8fb:	5a                   	pop    edx
    a8fc:	ff b4 24 a0 00 00 00 	push   DWORD PTR [esp+0xa0]
    a903:	68 41 d1 00 00       	push   0xd141
    a908:	e8 23 14 00 00       	call   bd30 <_Z6printfIiEvPKcT_>
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
    a97f:	e8 9c 07 00 00       	call   b120 <_Z7putcharc>
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
    a9af:	e8 4c 15 00 00       	call   bf00 <_Z6printfIcEvPKcT_>
    a9b4:	83 c4 10             	add    esp,0x10
    a9b7:	39 df                	cmp    edi,ebx
    a9b9:	75 e5                	jne    a9a0 <_ZN3ata12sendIdentifyEhRbb+0x2f0>
    a9bb:	83 ec 0c             	sub    esp,0xc
    a9be:	68 82 d1 00 00       	push   0xd182
    a9c3:	e8 d8 07 00 00       	call   b1a0 <_Z6printfPKc>
    a9c8:	83 c4 10             	add    esp,0x10
    a9cb:	e9 86 fe ff ff       	jmp    a856 <_ZN3ata12sendIdentifyEhRbb+0x1a6>
    a9d0:	83 ec 08             	sub    esp,0x8
    a9d3:	8d 44 24 26          	lea    eax,[esp+0x26]
    a9d7:	50                   	push   eax
    a9d8:	51                   	push   ecx
    a9d9:	e8 12 17 00 00       	call   c0f0 <_Z14_manage_escapeItEiPKcPT_>
    a9de:	0f b7 d6             	movzx  edx,si
    a9e1:	57                   	push   edi
    a9e2:	8d 84 03 4e d1 00 00 	lea    eax,[ebx+eax*1+0xd14e]
    a9e9:	52                   	push   edx
    a9ea:	0f b7 54 24 24       	movzx  edx,WORD PTR [esp+0x24]
    a9ef:	52                   	push   edx
    a9f0:	50                   	push   eax
    a9f1:	e8 0a 18 00 00       	call   c200 <_Z6printfItJttEEvPKcT_DpT0_>
    a9f6:	83 c4 20             	add    esp,0x20
    a9f9:	eb 95                	jmp    a990 <_ZN3ata12sendIdentifyEhRbb+0x2e0>
    a9fb:	83 ec 0c             	sub    esp,0xc
    a9fe:	8d 5d 02             	lea    ebx,[ebp+0x2]
    aa01:	6a 25                	push   0x25
    aa03:	e8 18 07 00 00       	call   b120 <_Z7putcharc>
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
    aa64:	31 c0                	xor    eax,eax
    aa66:	c7 05 08 0c 10 00 87 	mov    DWORD PTR ds:0x100c08,0x800087
    aa6d:	00 80 00 
    aa70:	c7 05 0c 0c 10 00 87 	mov    DWORD PTR ds:0x100c0c,0xc00087
    aa77:	00 c0 00 
    aa7a:	c7 05 10 0c 10 00 87 	mov    DWORD PTR ds:0x100c10,0x1000087
    aa81:	00 00 01 
    aa84:	c7 05 14 0c 10 00 87 	mov    DWORD PTR ds:0x100c14,0x1400087
    aa8b:	00 40 01 
    aa8e:	c7 05 18 0c 10 00 87 	mov    DWORD PTR ds:0x100c18,0x1800087
    aa95:	00 80 01 
    aa98:	c7 05 1c 0c 10 00 87 	mov    DWORD PTR ds:0x100c1c,0x1c00087
    aa9f:	00 c0 01 
    aaa2:	c7 05 20 0c 10 00 87 	mov    DWORD PTR ds:0x100c20,0x2000087
    aaa9:	00 00 02 
    aaac:	c7 05 24 0c 10 00 87 	mov    DWORD PTR ds:0x100c24,0x2400087
    aab3:	00 40 02 
    aab6:	c7 05 28 0c 10 00 87 	mov    DWORD PTR ds:0x100c28,0x2800087
    aabd:	00 80 02 
    aac0:	c7 05 2c 0c 10 00 87 	mov    DWORD PTR ds:0x100c2c,0x2c00087
    aac7:	00 c0 02 
    aaca:	c7 05 30 0c 10 00 87 	mov    DWORD PTR ds:0x100c30,0x3000087
    aad1:	00 00 03 
    aad4:	c7 05 34 0c 10 00 87 	mov    DWORD PTR ds:0x100c34,0x3400087
    aadb:	00 40 03 
    aade:	c7 05 38 0c 10 00 87 	mov    DWORD PTR ds:0x100c38,0x3800087
    aae5:	00 80 03 
    aae8:	c7 05 3c 0c 10 00 87 	mov    DWORD PTR ds:0x100c3c,0x3c00087
    aaef:	00 c0 03 
    aaf2:	c7 05 00 00 00 02 00 	mov    DWORD PTR ds:0x2000000,0x0
    aaf9:	00 00 00 
    aafc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ab00:	c7 04 85 04 00 00 02 	mov    DWORD PTR [eax*4+0x2000004],0x0
    ab07:	00 00 00 00 
    ab0b:	83 c0 01             	add    eax,0x1
    ab0e:	3d 00 80 00 00       	cmp    eax,0x8000
    ab13:	75 eb                	jne    ab00 <_ZN6paging18init_kernel_pagingEv+0xe0>
    ab15:	e8 f6 00 00 00       	call   ac10 <_ZN4boot12get_ram_sizeEv>
    ab1a:	c1 e8 0c             	shr    eax,0xc
    ab1d:	3d 00 40 00 00       	cmp    eax,0x4000
    ab22:	76 4b                	jbe    ab6f <_ZN6paging18init_kernel_pagingEv+0x14f>
    ab24:	8b 15 00 00 00 02    	mov    edx,DWORD PTR ds:0x2000000
    ab2a:	b9 00 40 00 00       	mov    ecx,0x4000
    ab2f:	be 01 00 00 00       	mov    esi,0x1
    ab34:	8d 9a 00 c0 ff ff    	lea    ebx,[edx-0x4000]
    ab3a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ab40:	8d bc 19 00 80 00 00 	lea    edi,[ecx+ebx*1+0x8000]
    ab47:	89 ca                	mov    edx,ecx
    ab49:	c1 e2 0c             	shl    edx,0xc
    ab4c:	89 14 bd 04 00 00 02 	mov    DWORD PTR [edi*4+0x2000004],edx
    ab53:	89 f7                	mov    edi,esi
    ab55:	c1 ea 11             	shr    edx,0x11
    ab58:	d3 e7                	shl    edi,cl
    ab5a:	83 c1 01             	add    ecx,0x1
    ab5d:	09 3c 95 04 00 00 02 	or     DWORD PTR [edx*4+0x2000004],edi
    ab64:	39 c8                	cmp    eax,ecx
    ab66:	75 d8                	jne    ab40 <_ZN6paging18init_kernel_pagingEv+0x120>
    ab68:	01 d8                	add    eax,ebx
    ab6a:	a3 00 00 00 02       	mov    ds:0x2000000,eax
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
    aba5:	90                   	nop
    aba6:	8d 76 00             	lea    esi,[esi+0x0]
    aba9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000abb0 <_ZN9PhysPages4initEv>:
    abb0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    abb4:	c7 02 00 00 00 00    	mov    DWORD PTR [edx],0x0
    abba:	8d 42 04             	lea    eax,[edx+0x4]
    abbd:	81 c2 04 00 02 00    	add    edx,0x20004
    abc3:	90                   	nop
    abc4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    abc8:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    abce:	83 c0 04             	add    eax,0x4
    abd1:	39 d0                	cmp    eax,edx
    abd3:	75 f3                	jne    abc8 <_ZN9PhysPages4initEv+0x18>
    abd5:	f3 c3                	repz ret 
    abd7:	90                   	nop
    abd8:	90                   	nop
    abd9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000abe0 <_ZN9PhysPages8add_pageEj>:
    abe0:	53                   	push   ebx
    abe1:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    abe5:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    abe9:	8b 10                	mov    edx,DWORD PTR [eax]
    abeb:	8d 5a 01             	lea    ebx,[edx+0x1]
    abee:	89 18                	mov    DWORD PTR [eax],ebx
    abf0:	89 cb                	mov    ebx,ecx
    abf2:	89 8c 90 04 00 02 00 	mov    DWORD PTR [eax+edx*4+0x20004],ecx
    abf9:	c1 eb 11             	shr    ebx,0x11
    abfc:	c1 e9 0c             	shr    ecx,0xc
    abff:	ba 01 00 00 00       	mov    edx,0x1
    ac04:	d3 e2                	shl    edx,cl
    ac06:	09 54 98 04          	or     DWORD PTR [eax+ebx*4+0x4],edx
    ac0a:	5b                   	pop    ebx
    ac0b:	c3                   	ret    
    ac0c:	66 90                	xchg   ax,ax
    ac0e:	66 90                	xchg   ax,ax

0000ac10 <_ZN4boot12get_ram_sizeEv>:
    ac10:	0f b7 05 02 05 00 00 	movzx  eax,WORD PTR ds:0x502
    ac17:	0f b7 15 00 05 00 00 	movzx  edx,WORD PTR ds:0x500
    ac1e:	c1 e0 06             	shl    eax,0x6
    ac21:	01 d0                	add    eax,edx
    ac23:	c1 e0 0a             	shl    eax,0xa
    ac26:	c3                   	ret    
    ac27:	66 90                	xchg   ax,ax
    ac29:	66 90                	xchg   ax,ax
    ac2b:	66 90                	xchg   ax,ax
    ac2d:	66 90                	xchg   ax,ax
    ac2f:	90                   	nop

0000ac30 <_ZN3VGA17_actualize_cursorEv>:
    ac30:	53                   	push   ebx
    ac31:	83 ec 10             	sub    esp,0x10
    ac34:	8b 1d 04 00 01 00    	mov    ebx,DWORD PTR ds:0x10004
    ac3a:	6a 0e                	push   0xe
    ac3c:	68 d4 03 00 00       	push   0x3d4
    ac41:	8d 1c 9b             	lea    ebx,[ebx+ebx*4]
    ac44:	c1 e3 04             	shl    ebx,0x4
    ac47:	66 03 1d 00 00 01 00 	add    bx,WORD PTR ds:0x10000
    ac4e:	e8 8d 05 00 00       	call   b1e0 <_Z4outbth>
    ac53:	58                   	pop    eax
    ac54:	5a                   	pop    edx
    ac55:	0f b6 c7             	movzx  eax,bh
    ac58:	0f b6 db             	movzx  ebx,bl
    ac5b:	50                   	push   eax
    ac5c:	68 d5 03 00 00       	push   0x3d5
    ac61:	e8 7a 05 00 00       	call   b1e0 <_Z4outbth>
    ac66:	59                   	pop    ecx
    ac67:	58                   	pop    eax
    ac68:	6a 0f                	push   0xf
    ac6a:	68 d4 03 00 00       	push   0x3d4
    ac6f:	e8 6c 05 00 00       	call   b1e0 <_Z4outbth>
    ac74:	58                   	pop    eax
    ac75:	5a                   	pop    edx
    ac76:	53                   	push   ebx
    ac77:	68 d5 03 00 00       	push   0x3d5
    ac7c:	e8 5f 05 00 00       	call   b1e0 <_Z4outbth>
    ac81:	83 c4 18             	add    esp,0x18
    ac84:	5b                   	pop    ebx
    ac85:	c3                   	ret    
    ac86:	8d 76 00             	lea    esi,[esi+0x0]
    ac89:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ac90 <_ZN3VGA14_pos_in_screenEii>:
    ac90:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    ac94:	8d 04 80             	lea    eax,[eax+eax*4]
    ac97:	c1 e0 04             	shl    eax,0x4
    ac9a:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    ac9e:	01 c0                	add    eax,eax
    aca0:	c3                   	ret    
    aca1:	eb 0d                	jmp    acb0 <_ZN3VGA12_char_val_atEii>
    aca3:	90                   	nop
    aca4:	90                   	nop
    aca5:	90                   	nop
    aca6:	90                   	nop
    aca7:	90                   	nop
    aca8:	90                   	nop
    aca9:	90                   	nop
    acaa:	90                   	nop
    acab:	90                   	nop
    acac:	90                   	nop
    acad:	90                   	nop
    acae:	90                   	nop
    acaf:	90                   	nop

0000acb0 <_ZN3VGA12_char_val_atEii>:
    acb0:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    acb4:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    acba:	8d 04 80             	lea    eax,[eax+eax*4]
    acbd:	c1 e0 04             	shl    eax,0x4
    acc0:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    acc4:	8d 04 42             	lea    eax,[edx+eax*2]
    acc7:	c3                   	ret    
    acc8:	90                   	nop
    acc9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000acd0 <_ZN3VGA13_char_mode_atEii>:
    acd0:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    acd4:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    acda:	8d 04 80             	lea    eax,[eax+eax*4]
    acdd:	c1 e0 04             	shl    eax,0x4
    ace0:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    ace4:	8d 44 42 01          	lea    eax,[edx+eax*2+0x1]
    ace8:	c3                   	ret    
    ace9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000acf0 <_ZN3VGA6scrollEc>:
    acf0:	55                   	push   ebp
    acf1:	57                   	push   edi
    acf2:	31 ed                	xor    ebp,ebp
    acf4:	56                   	push   esi
    acf5:	53                   	push   ebx
    acf6:	be 40 01 00 00       	mov    esi,0x140
    acfb:	bf 50 00 00 00       	mov    edi,0x50
    ad00:	83 ec 1c             	sub    esp,0x1c
    ad03:	0f b6 44 24 30       	movzx  eax,BYTE PTR [esp+0x30]
    ad08:	88 44 24 0f          	mov    BYTE PTR [esp+0xf],al
    ad0c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ad10:	89 e9                	mov    ecx,ebp
    ad12:	8d 04 3f             	lea    eax,[edi+edi*1]
    ad15:	29 f9                	sub    ecx,edi
    ad17:	01 c9                	add    ecx,ecx
    ad19:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ad20:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad26:	0f b6 1c 02          	movzx  ebx,BYTE PTR [edx+eax*1]
    ad2a:	01 ca                	add    edx,ecx
    ad2c:	88 1c 02             	mov    BYTE PTR [edx+eax*1],bl
    ad2f:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad35:	0f b6 5c 02 01       	movzx  ebx,BYTE PTR [edx+eax*1+0x1]
    ad3a:	01 ca                	add    edx,ecx
    ad3c:	83 c0 02             	add    eax,0x2
    ad3f:	88 5c 10 ff          	mov    BYTE PTR [eax+edx*1-0x1],bl
    ad43:	39 f0                	cmp    eax,esi
    ad45:	75 d9                	jne    ad20 <_ZN3VGA6scrollEc+0x30>
    ad47:	83 c7 50             	add    edi,0x50
    ad4a:	83 c5 50             	add    ebp,0x50
    ad4d:	8d b0 a0 00 00 00    	lea    esi,[eax+0xa0]
    ad53:	81 ff d0 07 00 00    	cmp    edi,0x7d0
    ad59:	75 b5                	jne    ad10 <_ZN3VGA6scrollEc+0x20>
    ad5b:	0f b6 4c 24 0f       	movzx  ecx,BYTE PTR [esp+0xf]
    ad60:	b8 00 0f 00 00       	mov    eax,0xf00
    ad65:	8d 76 00             	lea    esi,[esi+0x0]
    ad68:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad6e:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    ad72:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ad78:	88 4c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],cl
    ad7c:	83 c0 02             	add    eax,0x2
    ad7f:	3d a0 0f 00 00       	cmp    eax,0xfa0
    ad84:	75 e2                	jne    ad68 <_ZN3VGA6scrollEc+0x78>
    ad86:	a1 04 00 01 00       	mov    eax,ds:0x10004
    ad8b:	ba 00 00 00 00       	mov    edx,0x0
    ad90:	83 e8 01             	sub    eax,0x1
    ad93:	0f 48 c2             	cmovs  eax,edx
    ad96:	a3 04 00 01 00       	mov    ds:0x10004,eax
    ad9b:	83 c4 1c             	add    esp,0x1c
    ad9e:	5b                   	pop    ebx
    ad9f:	5e                   	pop    esi
    ada0:	5f                   	pop    edi
    ada1:	5d                   	pop    ebp
    ada2:	e9 89 fe ff ff       	jmp    ac30 <_ZN3VGA17_actualize_cursorEv>
    ada7:	89 f6                	mov    esi,esi
    ada9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000adb0 <_ZN3VGA12clear_screenEc>:
    adb0:	53                   	push   ebx
    adb1:	0f b6 5c 24 08       	movzx  ebx,BYTE PTR [esp+0x8]
    adb6:	31 c0                	xor    eax,eax
    adb8:	90                   	nop
    adb9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    adc0:	8d 88 a0 00 00 00    	lea    ecx,[eax+0xa0]
    adc6:	8d 76 00             	lea    esi,[esi+0x0]
    adc9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    add0:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    add6:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    adda:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ade0:	88 5c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],bl
    ade4:	83 c0 02             	add    eax,0x2
    ade7:	39 c1                	cmp    ecx,eax
    ade9:	75 e5                	jne    add0 <_ZN3VGA12clear_screenEc+0x20>
    adeb:	81 f9 a0 0f 00 00    	cmp    ecx,0xfa0
    adf1:	75 cd                	jne    adc0 <_ZN3VGA12clear_screenEc+0x10>
    adf3:	5b                   	pop    ebx
    adf4:	c7 05 04 00 01 00 00 	mov    DWORD PTR ds:0x10004,0x0
    adfb:	00 00 00 
    adfe:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ae05:	00 00 00 
    ae08:	e9 23 fe ff ff       	jmp    ac30 <_ZN3VGA17_actualize_cursorEv>
    ae0d:	8d 76 00             	lea    esi,[esi+0x0]

0000ae10 <_ZN3VGA7putcharEcc>:
    ae10:	55                   	push   ebp
    ae11:	57                   	push   edi
    ae12:	56                   	push   esi
    ae13:	53                   	push   ebx
    ae14:	83 ec 1c             	sub    esp,0x1c
    ae17:	8b 3d 04 00 01 00    	mov    edi,DWORD PTR ds:0x10004
    ae1d:	8b 5c 24 30          	mov    ebx,DWORD PTR [esp+0x30]
    ae21:	8b 4c 24 34          	mov    ecx,DWORD PTR [esp+0x34]
    ae25:	80 fb 0a             	cmp    bl,0xa
    ae28:	0f 84 d2 00 00 00    	je     af00 <_ZN3VGA7putcharEcc+0xf0>
    ae2e:	80 fb 09             	cmp    bl,0x9
    ae31:	0f 85 99 00 00 00    	jne    aed0 <_ZN3VGA7putcharEcc+0xc0>
    ae37:	a1 00 00 01 00       	mov    eax,ds:0x10000
    ae3c:	31 f6                	xor    esi,esi
    ae3e:	8d 50 04             	lea    edx,[eax+0x4]
    ae41:	83 e2 fc             	and    edx,0xfffffffc
    ae44:	83 fa 4f             	cmp    edx,0x4f
    ae47:	89 15 00 00 01 00    	mov    DWORD PTR ds:0x10000,edx
    ae4d:	0f 8e 15 01 00 00    	jle    af68 <_ZN3VGA7putcharEcc+0x158>
    ae53:	bd cd cc cc cc       	mov    ebp,0xcccccccd
    ae58:	89 d0                	mov    eax,edx
    ae5a:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ae61:	00 00 00 
    ae64:	f7 e5                	mul    ebp
    ae66:	c1 ea 06             	shr    edx,0x6
    ae69:	01 fa                	add    edx,edi
    ae6b:	83 fa 18             	cmp    edx,0x18
    ae6e:	89 15 04 00 01 00    	mov    DWORD PTR ds:0x10004,edx
    ae74:	0f 8f ce 00 00 00    	jg     af48 <_ZN3VGA7putcharEcc+0x138>
    ae7a:	89 f0                	mov    eax,esi
    ae7c:	84 c0                	test   al,al
    ae7e:	74 3f                	je     aebf <_ZN3VGA7putcharEcc+0xaf>
    ae80:	8b 3d 04 00 01 00    	mov    edi,DWORD PTR ds:0x10004
    ae86:	8b 2d 00 00 01 00    	mov    ebp,DWORD PTR ds:0x10000
    ae8c:	8d 04 bf             	lea    eax,[edi+edi*4]
    ae8f:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ae95:	c1 e0 04             	shl    eax,0x4
    ae98:	01 e8                	add    eax,ebp
    ae9a:	88 1c 42             	mov    BYTE PTR [edx+eax*2],bl
    ae9d:	a1 04 00 01 00       	mov    eax,ds:0x10004
    aea2:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    aea8:	8d 04 80             	lea    eax,[eax+eax*4]
    aeab:	c1 e0 04             	shl    eax,0x4
    aeae:	03 05 00 00 01 00    	add    eax,DWORD PTR ds:0x10000
    aeb4:	88 4c 42 01          	mov    BYTE PTR [edx+eax*2+0x1],cl
    aeb8:	83 05 00 00 01 00 01 	add    DWORD PTR ds:0x10000,0x1
    aebf:	83 c4 1c             	add    esp,0x1c
    aec2:	5b                   	pop    ebx
    aec3:	5e                   	pop    esi
    aec4:	5f                   	pop    edi
    aec5:	5d                   	pop    ebp
    aec6:	e9 65 fd ff ff       	jmp    ac30 <_ZN3VGA17_actualize_cursorEv>
    aecb:	90                   	nop
    aecc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    aed0:	80 fb 0d             	cmp    bl,0xd
    aed3:	75 4f                	jne    af24 <_ZN3VGA7putcharEcc+0x114>
    aed5:	83 ff 18             	cmp    edi,0x18
    aed8:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    aedf:	00 00 00 
    aee2:	7e db                	jle    aebf <_ZN3VGA7putcharEcc+0xaf>
    aee4:	83 ec 0c             	sub    esp,0xc
    aee7:	0f be c9             	movsx  ecx,cl
    aeea:	51                   	push   ecx
    aeeb:	e8 00 fe ff ff       	call   acf0 <_ZN3VGA6scrollEc>
    aef0:	83 c4 10             	add    esp,0x10
    aef3:	83 c4 1c             	add    esp,0x1c
    aef6:	5b                   	pop    ebx
    aef7:	5e                   	pop    esi
    aef8:	5f                   	pop    edi
    aef9:	5d                   	pop    ebp
    aefa:	e9 31 fd ff ff       	jmp    ac30 <_ZN3VGA17_actualize_cursorEv>
    aeff:	90                   	nop
    af00:	8d 57 01             	lea    edx,[edi+0x1]
    af03:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    af0a:	00 00 00 
    af0d:	83 fa 18             	cmp    edx,0x18
    af10:	89 15 04 00 01 00    	mov    DWORD PTR ds:0x10004,edx
    af16:	7f cc                	jg     aee4 <_ZN3VGA7putcharEcc+0xd4>
    af18:	83 c4 1c             	add    esp,0x1c
    af1b:	5b                   	pop    ebx
    af1c:	5e                   	pop    esi
    af1d:	5f                   	pop    edi
    af1e:	5d                   	pop    ebp
    af1f:	e9 0c fd ff ff       	jmp    ac30 <_ZN3VGA17_actualize_cursorEv>
    af24:	8b 2d 00 00 01 00    	mov    ebp,DWORD PTR ds:0x10000
    af2a:	be 01 00 00 00       	mov    esi,0x1
    af2f:	83 fd 4f             	cmp    ebp,0x4f
    af32:	89 ea                	mov    edx,ebp
    af34:	0f 8f 19 ff ff ff    	jg     ae53 <_ZN3VGA7putcharEcc+0x43>
    af3a:	83 ff 18             	cmp    edi,0x18
    af3d:	0f 8e 49 ff ff ff    	jle    ae8c <_ZN3VGA7putcharEcc+0x7c>
    af43:	90                   	nop
    af44:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    af48:	83 ec 0c             	sub    esp,0xc
    af4b:	0f be c1             	movsx  eax,cl
    af4e:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    af52:	50                   	push   eax
    af53:	e8 98 fd ff ff       	call   acf0 <_ZN3VGA6scrollEc>
    af58:	83 c4 10             	add    esp,0x10
    af5b:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    af5f:	e9 16 ff ff ff       	jmp    ae7a <_ZN3VGA7putcharEcc+0x6a>
    af64:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    af68:	83 ff 18             	cmp    edi,0x18
    af6b:	0f 8e 4e ff ff ff    	jle    aebf <_ZN3VGA7putcharEcc+0xaf>
    af71:	eb d5                	jmp    af48 <_ZN3VGA7putcharEcc+0x138>
    af73:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    af79:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000af80 <_ZN3VGA5printEPKcc>:
    af80:	56                   	push   esi
    af81:	53                   	push   ebx
    af82:	83 ec 04             	sub    esp,0x4
    af85:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    af89:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    af8d:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    af90:	84 c0                	test   al,al
    af92:	74 24                	je     afb8 <_ZN3VGA5printEPKcc+0x38>
    af94:	0f be f2             	movsx  esi,dl
    af97:	83 c3 01             	add    ebx,0x1
    af9a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    afa0:	83 ec 08             	sub    esp,0x8
    afa3:	83 c3 01             	add    ebx,0x1
    afa6:	56                   	push   esi
    afa7:	50                   	push   eax
    afa8:	e8 63 fe ff ff       	call   ae10 <_ZN3VGA7putcharEcc>
    afad:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    afb1:	83 c4 10             	add    esp,0x10
    afb4:	84 c0                	test   al,al
    afb6:	75 e8                	jne    afa0 <_ZN3VGA5printEPKcc+0x20>
    afb8:	83 c4 04             	add    esp,0x4
    afbb:	5b                   	pop    ebx
    afbc:	5e                   	pop    esi
    afbd:	c3                   	ret    
    afbe:	66 90                	xchg   ax,ax

0000afc0 <_ZN3VGA17_put_nbr_base_recEii>:
    afc0:	53                   	push   ebx
    afc1:	83 ec 08             	sub    esp,0x8
    afc4:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    afc8:	8b 4c 24 14          	mov    ecx,DWORD PTR [esp+0x14]
    afcc:	85 c0                	test   eax,eax
    afce:	75 08                	jne    afd8 <_ZN3VGA17_put_nbr_base_recEii+0x18>
    afd0:	83 c4 08             	add    esp,0x8
    afd3:	5b                   	pop    ebx
    afd4:	c3                   	ret    
    afd5:	8d 76 00             	lea    esi,[esi+0x0]
    afd8:	99                   	cdq    
    afd9:	83 ec 08             	sub    esp,0x8
    afdc:	f7 f9                	idiv   ecx
    afde:	51                   	push   ecx
    afdf:	50                   	push   eax
    afe0:	89 d3                	mov    ebx,edx
    afe2:	e8 d9 ff ff ff       	call   afc0 <_ZN3VGA17_put_nbr_base_recEii>
    afe7:	0f be 83 00 f0 00 00 	movsx  eax,BYTE PTR [ebx+0xf000]
    afee:	c7 44 24 24 0f 00 00 	mov    DWORD PTR [esp+0x24],0xf
    aff5:	00 
    aff6:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    affa:	83 c4 18             	add    esp,0x18
    affd:	5b                   	pop    ebx
    affe:	e9 0d fe ff ff       	jmp    ae10 <_ZN3VGA7putcharEcc>
    b003:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b009:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b010 <_ZN3VGA13_put_nbr_baseEii>:
    b010:	56                   	push   esi
    b011:	53                   	push   ebx
    b012:	83 ec 14             	sub    esp,0x14
    b015:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    b019:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    b01d:	85 c0                	test   eax,eax
    b01f:	78 4f                	js     b070 <_ZN3VGA13_put_nbr_baseEii+0x60>
    b021:	74 2d                	je     b050 <_ZN3VGA13_put_nbr_baseEii+0x40>
    b023:	99                   	cdq    
    b024:	83 ec 08             	sub    esp,0x8
    b027:	f7 fb                	idiv   ebx
    b029:	53                   	push   ebx
    b02a:	50                   	push   eax
    b02b:	89 d6                	mov    esi,edx
    b02d:	e8 8e ff ff ff       	call   afc0 <_ZN3VGA17_put_nbr_base_recEii>
    b032:	0f be 86 00 f0 00 00 	movsx  eax,BYTE PTR [esi+0xf000]
    b039:	c7 44 24 34 0f 00 00 	mov    DWORD PTR [esp+0x34],0xf
    b040:	00 
    b041:	89 44 24 30          	mov    DWORD PTR [esp+0x30],eax
    b045:	83 c4 24             	add    esp,0x24
    b048:	5b                   	pop    ebx
    b049:	5e                   	pop    esi
    b04a:	e9 c1 fd ff ff       	jmp    ae10 <_ZN3VGA7putcharEcc>
    b04f:	90                   	nop
    b050:	0f be 05 00 f0 00 00 	movsx  eax,BYTE PTR ds:0xf000
    b057:	c7 44 24 24 0f 00 00 	mov    DWORD PTR [esp+0x24],0xf
    b05e:	00 
    b05f:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    b063:	83 c4 14             	add    esp,0x14
    b066:	5b                   	pop    ebx
    b067:	5e                   	pop    esi
    b068:	e9 a3 fd ff ff       	jmp    ae10 <_ZN3VGA7putcharEcc>
    b06d:	8d 76 00             	lea    esi,[esi+0x0]
    b070:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    b074:	83 ec 08             	sub    esp,0x8
    b077:	6a 0f                	push   0xf
    b079:	6a 2d                	push   0x2d
    b07b:	e8 90 fd ff ff       	call   ae10 <_ZN3VGA7putcharEcc>
    b080:	83 c4 10             	add    esp,0x10
    b083:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b087:	eb 9a                	jmp    b023 <_ZN3VGA13_put_nbr_baseEii+0x13>
    b089:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b090 <_ZN3VGA6putHexEi>:
    b090:	83 ec 14             	sub    esp,0x14
    b093:	6a 10                	push   0x10
    b095:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b099:	e8 72 ff ff ff       	call   b010 <_ZN3VGA13_put_nbr_baseEii>
    b09e:	83 c4 1c             	add    esp,0x1c
    b0a1:	c3                   	ret    
    b0a2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b0a9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b0b0 <_ZN3VGA6putDecEi>:
    b0b0:	83 ec 14             	sub    esp,0x14
    b0b3:	6a 0a                	push   0xa
    b0b5:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b0b9:	e8 52 ff ff ff       	call   b010 <_ZN3VGA13_put_nbr_baseEii>
    b0be:	83 c4 1c             	add    esp,0x1c
    b0c1:	c3                   	ret    
    b0c2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b0c9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b0d0 <_ZN3VGA6putOctEi>:
    b0d0:	83 ec 14             	sub    esp,0x14
    b0d3:	6a 08                	push   0x8
    b0d5:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b0d9:	e8 32 ff ff ff       	call   b010 <_ZN3VGA13_put_nbr_baseEii>
    b0de:	83 c4 1c             	add    esp,0x1c
    b0e1:	c3                   	ret    
    b0e2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b0e9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b0f0 <_ZN3VGA6putBinEi>:
    b0f0:	83 ec 14             	sub    esp,0x14
    b0f3:	6a 02                	push   0x2
    b0f5:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b0f9:	e8 12 ff ff ff       	call   b010 <_ZN3VGA13_put_nbr_baseEii>
    b0fe:	83 c4 1c             	add    esp,0x1c
    b101:	c3                   	ret    
    b102:	66 90                	xchg   ax,ax
    b104:	66 90                	xchg   ax,ax
    b106:	66 90                	xchg   ax,ax
    b108:	66 90                	xchg   ax,ax
    b10a:	66 90                	xchg   ax,ax
    b10c:	66 90                	xchg   ax,ax
    b10e:	66 90                	xchg   ax,ax

0000b110 <_Z12clear_screenv>:
    b110:	83 ec 18             	sub    esp,0x18
    b113:	6a 0f                	push   0xf
    b115:	e8 96 fc ff ff       	call   adb0 <_ZN3VGA12clear_screenEc>
    b11a:	83 c4 1c             	add    esp,0x1c
    b11d:	c3                   	ret    
    b11e:	66 90                	xchg   ax,ax

0000b120 <_Z7putcharc>:
    b120:	83 ec 14             	sub    esp,0x14
    b123:	6a 0f                	push   0xf
    b125:	0f be 44 24 1c       	movsx  eax,BYTE PTR [esp+0x1c]
    b12a:	50                   	push   eax
    b12b:	e8 e0 fc ff ff       	call   ae10 <_ZN3VGA7putcharEcc>
    b130:	83 c4 1c             	add    esp,0x1c
    b133:	c3                   	ret    
    b134:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b13a:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000b140 <_Z6putdeci>:
    b140:	e9 6b ff ff ff       	jmp    b0b0 <_ZN3VGA6putDecEi>
    b145:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b149:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b150 <_Z6puthexi>:
    b150:	e9 3b ff ff ff       	jmp    b090 <_ZN3VGA6putHexEi>
    b155:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b159:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b160 <_Z6putocti>:
    b160:	e9 6b ff ff ff       	jmp    b0d0 <_ZN3VGA6putOctEi>
    b165:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b169:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b170 <_Z6putbini>:
    b170:	e9 7b ff ff ff       	jmp    b0f0 <_ZN3VGA6putBinEi>
    b175:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b179:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b180 <_Z6putstrPc>:
    b180:	83 ec 14             	sub    esp,0x14
    b183:	6a 0f                	push   0xf
    b185:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    b189:	e8 f2 fd ff ff       	call   af80 <_ZN3VGA5printEPKcc>
    b18e:	83 c4 1c             	add    esp,0x1c
    b191:	c3                   	ret    
    b192:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b199:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b1a0 <_Z6printfPKc>:
    b1a0:	53                   	push   ebx
    b1a1:	83 ec 08             	sub    esp,0x8
    b1a4:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    b1a8:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    b1ab:	84 c0                	test   al,al
    b1ad:	74 22                	je     b1d1 <_Z6printfPKc+0x31>
    b1af:	83 c3 01             	add    ebx,0x1
    b1b2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b1b8:	83 ec 08             	sub    esp,0x8
    b1bb:	83 c3 01             	add    ebx,0x1
    b1be:	6a 0f                	push   0xf
    b1c0:	50                   	push   eax
    b1c1:	e8 4a fc ff ff       	call   ae10 <_ZN3VGA7putcharEcc>
    b1c6:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    b1ca:	83 c4 10             	add    esp,0x10
    b1cd:	84 c0                	test   al,al
    b1cf:	75 e7                	jne    b1b8 <_Z6printfPKc+0x18>
    b1d1:	83 c4 08             	add    esp,0x8
    b1d4:	5b                   	pop    ebx
    b1d5:	c3                   	ret    
    b1d6:	66 90                	xchg   ax,ax
    b1d8:	66 90                	xchg   ax,ax
    b1da:	66 90                	xchg   ax,ax
    b1dc:	66 90                	xchg   ax,ax
    b1de:	66 90                	xchg   ax,ax

0000b1e0 <_Z4outbth>:
    b1e0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b1e4:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b1e8:	ee                   	out    dx,al
    b1e9:	c3                   	ret    
    b1ea:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b1f0 <_Z4outwtt>:
    b1f0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b1f4:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b1f8:	66 ef                	out    dx,ax
    b1fa:	c3                   	ret    
    b1fb:	90                   	nop
    b1fc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000b200 <_Z4outdtj>:
    b200:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b204:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b208:	ef                   	out    dx,eax
    b209:	c3                   	ret    
    b20a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b210 <_Z4inwstjj>:
    b210:	57                   	push   edi
    b211:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    b215:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    b219:	8b 7c 24 0c          	mov    edi,DWORD PTR [esp+0xc]
    b21d:	fc                   	cld    
    b21e:	f3 6d                	rep ins DWORD PTR es:[edi],dx
    b220:	5f                   	pop    edi
    b221:	c3                   	ret    
    b222:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b229:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b230 <_Z3inbt>:
    b230:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b234:	ec                   	in     al,dx
    b235:	c3                   	ret    
    b236:	8d 76 00             	lea    esi,[esi+0x0]
    b239:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b240 <_Z3inwt>:
    b240:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b244:	66 ed                	in     ax,dx
    b246:	c3                   	ret    
    b247:	89 f6                	mov    esi,esi
    b249:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b250 <_Z3indt>:
    b250:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b254:	ed                   	in     eax,dx
    b255:	c3                   	ret    
    b256:	8d 76 00             	lea    esi,[esi+0x0]
    b259:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b260 <_Z7io_waitv>:
    b260:	31 c0                	xor    eax,eax
    b262:	e6 80                	out    0x80,al
    b264:	c3                   	ret    
    b265:	66 90                	xchg   ax,ax
    b267:	66 90                	xchg   ax,ax
    b269:	66 90                	xchg   ax,ax
    b26b:	66 90                	xchg   ax,ax
    b26d:	66 90                	xchg   ax,ax
    b26f:	90                   	nop

0000b270 <_ZN3pci13configAddressEhhhh>:
    b270:	0f b6 44 24 10       	movzx  eax,BYTE PTR [esp+0x10]
    b275:	0f b6 54 24 0c       	movzx  edx,BYTE PTR [esp+0xc]
    b27a:	c1 e0 02             	shl    eax,0x2
    b27d:	c1 e2 08             	shl    edx,0x8
    b280:	0f b6 c0             	movzx  eax,al
    b283:	09 d0                	or     eax,edx
    b285:	0f b6 54 24 08       	movzx  edx,BYTE PTR [esp+0x8]
    b28a:	c1 e2 0b             	shl    edx,0xb
    b28d:	09 d0                	or     eax,edx
    b28f:	0f b6 54 24 04       	movzx  edx,BYTE PTR [esp+0x4]
    b294:	c1 e2 10             	shl    edx,0x10
    b297:	09 d0                	or     eax,edx
    b299:	0d 00 00 00 80       	or     eax,0x80000000
    b29e:	c3                   	ret    
    b29f:	90                   	nop

0000b2a0 <_ZN3pci14configReadByteEhhhhh>:
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
    b2dc:	e8 1f ff ff ff       	call   b200 <_Z4outdtj>
    b2e1:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    b2e8:	e8 63 ff ff ff       	call   b250 <_Z3indt>
    b2ed:	0f b6 cb             	movzx  ecx,bl
    b2f0:	83 c4 18             	add    esp,0x18
    b2f3:	c1 e1 03             	shl    ecx,0x3
    b2f6:	d3 e8                	shr    eax,cl
    b2f8:	5b                   	pop    ebx
    b2f9:	c3                   	ret    
    b2fa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b300 <_ZN3pci14configReadWordEhhhhh>:
    b300:	53                   	push   ebx
    b301:	83 ec 10             	sub    esp,0x10
    b304:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b309:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b30e:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    b312:	c1 e2 0b             	shl    edx,0xb
    b315:	c1 e0 10             	shl    eax,0x10
    b318:	09 d0                	or     eax,edx
    b31a:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b31f:	c1 e2 08             	shl    edx,0x8
    b322:	09 d0                	or     eax,edx
    b324:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b329:	c1 e2 02             	shl    edx,0x2
    b32c:	0f b6 d2             	movzx  edx,dl
    b32f:	09 d0                	or     eax,edx
    b331:	0d 00 00 00 80       	or     eax,0x80000000
    b336:	50                   	push   eax
    b337:	68 f8 0c 00 00       	push   0xcf8
    b33c:	e8 bf fe ff ff       	call   b200 <_Z4outdtj>
    b341:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    b348:	e8 03 ff ff ff       	call   b250 <_Z3indt>
    b34d:	0f b6 cb             	movzx  ecx,bl
    b350:	83 c4 18             	add    esp,0x18
    b353:	c1 e1 04             	shl    ecx,0x4
    b356:	d3 e8                	shr    eax,cl
    b358:	5b                   	pop    ebx
    b359:	c3                   	ret    
    b35a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b360 <_ZN3pci10configReadEhhhh>:
    b360:	83 ec 14             	sub    esp,0x14
    b363:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b368:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b36d:	c1 e0 10             	shl    eax,0x10
    b370:	c1 e2 0b             	shl    edx,0xb
    b373:	09 d0                	or     eax,edx
    b375:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b37a:	c1 e2 08             	shl    edx,0x8
    b37d:	09 d0                	or     eax,edx
    b37f:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b384:	c1 e2 02             	shl    edx,0x2
    b387:	0f b6 d2             	movzx  edx,dl
    b38a:	09 d0                	or     eax,edx
    b38c:	0d 00 00 00 80       	or     eax,0x80000000
    b391:	50                   	push   eax
    b392:	68 f8 0c 00 00       	push   0xcf8
    b397:	e8 64 fe ff ff       	call   b200 <_Z4outdtj>
    b39c:	c7 44 24 20 fc 0c 00 	mov    DWORD PTR [esp+0x20],0xcfc
    b3a3:	00 
    b3a4:	83 c4 1c             	add    esp,0x1c
    b3a7:	e9 a4 fe ff ff       	jmp    b250 <_Z3indt>
    b3ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000b3b0 <_ZN3pci11checkDeviceEhhh>:
    b3b0:	83 ec 18             	sub    esp,0x18
    b3b3:	6a 00                	push   0x0
    b3b5:	6a 00                	push   0x0
    b3b7:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b3bc:	50                   	push   eax
    b3bd:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b3c2:	50                   	push   eax
    b3c3:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b3c8:	50                   	push   eax
    b3c9:	e8 32 ff ff ff       	call   b300 <_ZN3pci14configReadWordEhhhhh>
    b3ce:	66 83 f8 ff          	cmp    ax,0xffff
    b3d2:	0f 95 c0             	setne  al
    b3d5:	83 c4 2c             	add    esp,0x2c
    b3d8:	c3                   	ret    
    b3d9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b3e0 <_ZN3pci11printBussesEv>:
    b3e0:	55                   	push   ebp
    b3e1:	57                   	push   edi
    b3e2:	56                   	push   esi
    b3e3:	53                   	push   ebx
    b3e4:	83 ec 4c             	sub    esp,0x4c
    b3e7:	c7 44 24 10 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    b3ee:	00 
    b3ef:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    b3f6:	00 
    b3f7:	89 f6                	mov    esi,esi
    b3f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b400:	31 f6                	xor    esi,esi
    b402:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b408:	83 ec 0c             	sub    esp,0xc
    b40b:	6a 00                	push   0x0
    b40d:	6a 00                	push   0x0
    b40f:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    b413:	53                   	push   ebx
    b414:	56                   	push   esi
    b415:	8b 7c 24 28          	mov    edi,DWORD PTR [esp+0x28]
    b419:	57                   	push   edi
    b41a:	e8 e1 fe ff ff       	call   b300 <_ZN3pci14configReadWordEhhhhh>
    b41f:	83 c4 20             	add    esp,0x20
    b422:	66 83 f8 ff          	cmp    ax,0xffff
    b426:	0f 84 6c 01 00 00    	je     b598 <_ZN3pci11printBussesEv+0x1b8>
    b42c:	83 ec 0c             	sub    esp,0xc
    b42f:	6a 00                	push   0x0
    b431:	6a 02                	push   0x2
    b433:	53                   	push   ebx
    b434:	56                   	push   esi
    b435:	57                   	push   edi
    b436:	e8 65 fe ff ff       	call   b2a0 <_ZN3pci14configReadByteEhhhhh>
    b43b:	88 44 24 38          	mov    BYTE PTR [esp+0x38],al
    b43f:	83 c4 14             	add    esp,0x14
    b442:	6a 01                	push   0x1
    b444:	6a 02                	push   0x2
    b446:	53                   	push   ebx
    b447:	56                   	push   esi
    b448:	57                   	push   edi
    b449:	e8 52 fe ff ff       	call   b2a0 <_ZN3pci14configReadByteEhhhhh>
    b44e:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    b452:	83 c4 14             	add    esp,0x14
    b455:	6a 02                	push   0x2
    b457:	6a 02                	push   0x2
    b459:	53                   	push   ebx
    b45a:	56                   	push   esi
    b45b:	57                   	push   edi
    b45c:	e8 3f fe ff ff       	call   b2a0 <_ZN3pci14configReadByteEhhhhh>
    b461:	83 c4 14             	add    esp,0x14
    b464:	89 c5                	mov    ebp,eax
    b466:	6a 03                	push   0x3
    b468:	6a 02                	push   0x2
    b46a:	53                   	push   ebx
    b46b:	56                   	push   esi
    b46c:	57                   	push   edi
    b46d:	31 ff                	xor    edi,edi
    b46f:	e8 2c fe ff ff       	call   b2a0 <_ZN3pci14configReadByteEhhhhh>
    b474:	ba 43 00 00 00       	mov    edx,0x43
    b479:	88 44 24 4f          	mov    BYTE PTR [esp+0x4f],al
    b47d:	83 c4 20             	add    esp,0x20
    b480:	eb 29                	jmp    b4ab <_ZN3pci11printBussesEv+0xcb>
    b482:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b488:	3c 25                	cmp    al,0x25
    b48a:	0f 84 90 03 00 00    	je     b820 <_ZN3pci11printBussesEv+0x440>
    b490:	84 c0                	test   al,al
    b492:	0f 85 d8 01 00 00    	jne    b670 <_ZN3pci11printBussesEv+0x290>
    b498:	8d 5f 02             	lea    ebx,[edi+0x2]
    b49b:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b4a2:	84 c0                	test   al,al
    b4a4:	74 3a                	je     b4e0 <_ZN3pci11printBussesEv+0x100>
    b4a6:	0f be d0             	movsx  edx,al
    b4a9:	89 df                	mov    edi,ebx
    b4ab:	8d 5f 01             	lea    ebx,[edi+0x1]
    b4ae:	80 fa 25             	cmp    dl,0x25
    b4b1:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b4b8:	8d 8b a8 d1 00 00    	lea    ecx,[ebx+0xd1a8]
    b4be:	74 c8                	je     b488 <_ZN3pci11printBussesEv+0xa8>
    b4c0:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    b4c4:	83 ec 0c             	sub    esp,0xc
    b4c7:	52                   	push   edx
    b4c8:	e8 53 fc ff ff       	call   b120 <_Z7putcharc>
    b4cd:	83 c4 10             	add    esp,0x10
    b4d0:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    b4d5:	84 c0                	test   al,al
    b4d7:	75 cd                	jne    b4a6 <_ZN3pci11printBussesEv+0xc6>
    b4d9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b4e0:	6a 04                	push   0x4
    b4e2:	8b 6c 24 14          	mov    ebp,DWORD PTR [esp+0x14]
    b4e6:	55                   	push   ebp
    b4e7:	56                   	push   esi
    b4e8:	8b 5c 24 18          	mov    ebx,DWORD PTR [esp+0x18]
    b4ec:	53                   	push   ebx
    b4ed:	e8 6e fe ff ff       	call   b360 <_ZN3pci10configReadEhhhh>
    b4f2:	c7 04 24 03 00 00 00 	mov    DWORD PTR [esp],0x3
    b4f9:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    b4fd:	6a 03                	push   0x3
    b4ff:	55                   	push   ebp
    b500:	56                   	push   esi
    b501:	53                   	push   ebx
    b502:	e8 99 fd ff ff       	call   b2a0 <_ZN3pci14configReadByteEhhhhh>
    b507:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    b50b:	83 c4 14             	add    esp,0x14
    b50e:	6a 01                	push   0x1
    b510:	6a 00                	push   0x0
    b512:	55                   	push   ebp
    b513:	56                   	push   esi
    b514:	53                   	push   ebx
    b515:	e8 e6 fd ff ff       	call   b300 <_ZN3pci14configReadWordEhhhhh>
    b51a:	83 c4 14             	add    esp,0x14
    b51d:	89 c7                	mov    edi,eax
    b51f:	6a 00                	push   0x0
    b521:	6a 00                	push   0x0
    b523:	55                   	push   ebp
    b524:	56                   	push   esi
    b525:	31 ed                	xor    ebp,ebp
    b527:	53                   	push   ebx
    b528:	e8 d3 fd ff ff       	call   b300 <_ZN3pci14configReadWordEhhhhh>
    b52d:	ba 56 00 00 00       	mov    edx,0x56
    b532:	66 89 44 24 54       	mov    WORD PTR [esp+0x54],ax
    b537:	83 c4 20             	add    esp,0x20
    b53a:	eb 27                	jmp    b563 <_ZN3pci11printBussesEv+0x183>
    b53c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b540:	3c 25                	cmp    al,0x25
    b542:	0f 84 00 03 00 00    	je     b848 <_ZN3pci11printBussesEv+0x468>
    b548:	84 c0                	test   al,al
    b54a:	0f 85 90 00 00 00    	jne    b5e0 <_ZN3pci11printBussesEv+0x200>
    b550:	8d 5d 02             	lea    ebx,[ebp+0x2]
    b553:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b55a:	84 c0                	test   al,al
    b55c:	74 3a                	je     b598 <_ZN3pci11printBussesEv+0x1b8>
    b55e:	0f be d0             	movsx  edx,al
    b561:	89 dd                	mov    ebp,ebx
    b563:	8d 5d 01             	lea    ebx,[ebp+0x1]
    b566:	80 fa 25             	cmp    dl,0x25
    b569:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b570:	8d 8b ec d1 00 00    	lea    ecx,[ebx+0xd1ec]
    b576:	74 c8                	je     b540 <_ZN3pci11printBussesEv+0x160>
    b578:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    b57c:	83 ec 0c             	sub    esp,0xc
    b57f:	52                   	push   edx
    b580:	e8 9b fb ff ff       	call   b120 <_Z7putcharc>
    b585:	83 c4 10             	add    esp,0x10
    b588:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    b58d:	84 c0                	test   al,al
    b58f:	75 cd                	jne    b55e <_ZN3pci11printBussesEv+0x17e>
    b591:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b598:	83 c6 01             	add    esi,0x1
    b59b:	83 fe 20             	cmp    esi,0x20
    b59e:	0f 85 64 fe ff ff    	jne    b408 <_ZN3pci11printBussesEv+0x28>
    b5a4:	83 44 24 0c 01       	add    DWORD PTR [esp+0xc],0x1
    b5a9:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b5ad:	3d 00 01 00 00       	cmp    eax,0x100
    b5b2:	0f 85 48 fe ff ff    	jne    b400 <_ZN3pci11printBussesEv+0x20>
    b5b8:	83 44 24 10 01       	add    DWORD PTR [esp+0x10],0x1
    b5bd:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    b5c1:	83 f8 08             	cmp    eax,0x8
    b5c4:	0f 85 25 fe ff ff    	jne    b3ef <_ZN3pci11printBussesEv+0xf>
    b5ca:	83 ec 0c             	sub    esp,0xc
    b5cd:	68 69 d1 00 00       	push   0xd169
    b5d2:	e8 c9 fb ff ff       	call   b1a0 <_Z6printfPKc>
    b5d7:	83 c4 5c             	add    esp,0x5c
    b5da:	5b                   	pop    ebx
    b5db:	5e                   	pop    esi
    b5dc:	5f                   	pop    edi
    b5dd:	5d                   	pop    ebp
    b5de:	c3                   	ret    
    b5df:	90                   	nop
    b5e0:	83 ec 08             	sub    esp,0x8
    b5e3:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    b5e7:	50                   	push   eax
    b5e8:	51                   	push   ecx
    b5e9:	e8 02 0b 00 00       	call   c0f0 <_Z14_manage_escapeItEiPKcPT_>
    b5ee:	01 c3                	add    ebx,eax
    b5f0:	66 89 7c 24 46       	mov    WORD PTR [esp+0x46],di
    b5f5:	83 c4 10             	add    esp,0x10
    b5f8:	0f be 83 ec d1 00 00 	movsx  eax,BYTE PTR [ebx+0xd1ec]
    b5ff:	8d ab ec d1 00 00    	lea    ebp,[ebx+0xd1ec]
    b605:	84 c0                	test   al,al
    b607:	74 8f                	je     b598 <_ZN3pci11printBussesEv+0x1b8>
    b609:	31 d2                	xor    edx,edx
    b60b:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b60f:	89 ee                	mov    esi,ebp
    b611:	89 d5                	mov    ebp,edx
    b613:	eb 25                	jmp    b63a <_ZN3pci11printBussesEv+0x25a>
    b615:	8d 76 00             	lea    esi,[esi+0x0]
    b618:	80 fb 25             	cmp    bl,0x25
    b61b:	0f 84 7f 03 00 00    	je     b9a0 <_ZN3pci11printBussesEv+0x5c0>
    b621:	84 db                	test   bl,bl
    b623:	0f 85 d7 00 00 00    	jne    b700 <_ZN3pci11printBussesEv+0x320>
    b629:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b62e:	8d 7d 02             	lea    edi,[ebp+0x2]
    b631:	84 db                	test   bl,bl
    b633:	74 22                	je     b657 <_ZN3pci11printBussesEv+0x277>
    b635:	0f be c3             	movsx  eax,bl
    b638:	89 fd                	mov    ebp,edi
    b63a:	8d 7d 01             	lea    edi,[ebp+0x1]
    b63d:	3c 25                	cmp    al,0x25
    b63f:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b642:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b645:	74 d1                	je     b618 <_ZN3pci11printBussesEv+0x238>
    b647:	83 ec 0c             	sub    esp,0xc
    b64a:	50                   	push   eax
    b64b:	e8 d0 fa ff ff       	call   b120 <_Z7putcharc>
    b650:	83 c4 10             	add    esp,0x10
    b653:	84 db                	test   bl,bl
    b655:	75 de                	jne    b635 <_ZN3pci11printBussesEv+0x255>
    b657:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b65b:	83 c6 01             	add    esi,0x1
    b65e:	83 fe 20             	cmp    esi,0x20
    b661:	0f 85 a1 fd ff ff    	jne    b408 <_ZN3pci11printBussesEv+0x28>
    b667:	e9 38 ff ff ff       	jmp    b5a4 <_ZN3pci11printBussesEv+0x1c4>
    b66c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b670:	83 ec 08             	sub    esp,0x8
    b673:	8d 44 24 37          	lea    eax,[esp+0x37]
    b677:	50                   	push   eax
    b678:	51                   	push   ecx
    b679:	e8 b2 0d 00 00       	call   c430 <_Z14_manage_escapeIhEiPKcPT_>
    b67e:	01 c3                	add    ebx,eax
    b680:	89 e8                	mov    eax,ebp
    b682:	88 44 24 40          	mov    BYTE PTR [esp+0x40],al
    b686:	0f be 83 a8 d1 00 00 	movsx  eax,BYTE PTR [ebx+0xd1a8]
    b68d:	83 c4 10             	add    esp,0x10
    b690:	8d 93 a8 d1 00 00    	lea    edx,[ebx+0xd1a8]
    b696:	84 c0                	test   al,al
    b698:	0f 84 42 fe ff ff    	je     b4e0 <_ZN3pci11printBussesEv+0x100>
    b69e:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    b6a2:	31 ed                	xor    ebp,ebp
    b6a4:	89 d6                	mov    esi,edx
    b6a6:	eb 2a                	jmp    b6d2 <_ZN3pci11printBussesEv+0x2f2>
    b6a8:	90                   	nop
    b6a9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b6b0:	80 fb 25             	cmp    bl,0x25
    b6b3:	0f 84 17 03 00 00    	je     b9d0 <_ZN3pci11printBussesEv+0x5f0>
    b6b9:	84 db                	test   bl,bl
    b6bb:	0f 85 cf 00 00 00    	jne    b790 <_ZN3pci11printBussesEv+0x3b0>
    b6c1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b6c6:	8d 7d 02             	lea    edi,[ebp+0x2]
    b6c9:	84 db                	test   bl,bl
    b6cb:	74 22                	je     b6ef <_ZN3pci11printBussesEv+0x30f>
    b6cd:	0f be c3             	movsx  eax,bl
    b6d0:	89 fd                	mov    ebp,edi
    b6d2:	8d 7d 01             	lea    edi,[ebp+0x1]
    b6d5:	3c 25                	cmp    al,0x25
    b6d7:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b6da:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b6dd:	74 d1                	je     b6b0 <_ZN3pci11printBussesEv+0x2d0>
    b6df:	83 ec 0c             	sub    esp,0xc
    b6e2:	50                   	push   eax
    b6e3:	e8 38 fa ff ff       	call   b120 <_Z7putcharc>
    b6e8:	83 c4 10             	add    esp,0x10
    b6eb:	84 db                	test   bl,bl
    b6ed:	75 de                	jne    b6cd <_ZN3pci11printBussesEv+0x2ed>
    b6ef:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    b6f3:	e9 e8 fd ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    b6f8:	90                   	nop
    b6f9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b700:	83 ec 08             	sub    esp,0x8
    b703:	89 f5                	mov    ebp,esi
    b705:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b709:	8d 44 24 3e          	lea    eax,[esp+0x3e]
    b70d:	50                   	push   eax
    b70e:	51                   	push   ecx
    b70f:	e8 dc 09 00 00       	call   c0f0 <_Z14_manage_escapeItEiPKcPT_>
    b714:	8d 1c 38             	lea    ebx,[eax+edi*1]
    b717:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    b71c:	01 dd                	add    ebp,ebx
    b71e:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    b722:	88 44 24 43          	mov    BYTE PTR [esp+0x43],al
    b726:	83 c4 10             	add    esp,0x10
    b729:	84 d2                	test   dl,dl
    b72b:	0f 84 67 fe ff ff    	je     b598 <_ZN3pci11printBussesEv+0x1b8>
    b731:	31 ff                	xor    edi,edi
    b733:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b737:	89 ee                	mov    esi,ebp
    b739:	89 fd                	mov    ebp,edi
    b73b:	eb 29                	jmp    b766 <_ZN3pci11printBussesEv+0x386>
    b73d:	8d 76 00             	lea    esi,[esi+0x0]
    b740:	80 fb 25             	cmp    bl,0x25
    b743:	0f 84 57 04 00 00    	je     bba0 <_ZN3pci11printBussesEv+0x7c0>
    b749:	84 db                	test   bl,bl
    b74b:	0f 85 2f 01 00 00    	jne    b880 <_ZN3pci11printBussesEv+0x4a0>
    b751:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b756:	8d 7d 02             	lea    edi,[ebp+0x2]
    b759:	84 db                	test   bl,bl
    b75b:	0f 84 f6 fe ff ff    	je     b657 <_ZN3pci11printBussesEv+0x277>
    b761:	0f be d3             	movsx  edx,bl
    b764:	89 fd                	mov    ebp,edi
    b766:	8d 7d 01             	lea    edi,[ebp+0x1]
    b769:	80 fa 25             	cmp    dl,0x25
    b76c:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b76f:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b772:	74 cc                	je     b740 <_ZN3pci11printBussesEv+0x360>
    b774:	83 ec 0c             	sub    esp,0xc
    b777:	52                   	push   edx
    b778:	e8 a3 f9 ff ff       	call   b120 <_Z7putcharc>
    b77d:	83 c4 10             	add    esp,0x10
    b780:	84 db                	test   bl,bl
    b782:	75 dd                	jne    b761 <_ZN3pci11printBussesEv+0x381>
    b784:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b788:	e9 ce fe ff ff       	jmp    b65b <_ZN3pci11printBussesEv+0x27b>
    b78d:	8d 76 00             	lea    esi,[esi+0x0]
    b790:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b794:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    b798:	83 ec 08             	sub    esp,0x8
    b79b:	8d 44 24 38          	lea    eax,[esp+0x38]
    b79f:	50                   	push   eax
    b7a0:	51                   	push   ecx
    b7a1:	e8 8a 0c 00 00       	call   c430 <_Z14_manage_escapeIhEiPKcPT_>
    b7a6:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b7aa:	01 c7                	add    edi,eax
    b7ac:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    b7b1:	01 fa                	add    edx,edi
    b7b3:	88 44 24 41          	mov    BYTE PTR [esp+0x41],al
    b7b7:	0f be 02             	movsx  eax,BYTE PTR [edx]
    b7ba:	83 c4 10             	add    esp,0x10
    b7bd:	84 c0                	test   al,al
    b7bf:	0f 84 1b fd ff ff    	je     b4e0 <_ZN3pci11printBussesEv+0x100>
    b7c5:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    b7c9:	31 ff                	xor    edi,edi
    b7cb:	89 d6                	mov    esi,edx
    b7cd:	eb 23                	jmp    b7f2 <_ZN3pci11printBussesEv+0x412>
    b7cf:	90                   	nop
    b7d0:	80 fb 25             	cmp    bl,0x25
    b7d3:	0f 84 97 03 00 00    	je     bb70 <_ZN3pci11printBussesEv+0x790>
    b7d9:	84 db                	test   bl,bl
    b7db:	0f 85 27 01 00 00    	jne    b908 <_ZN3pci11printBussesEv+0x528>
    b7e1:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    b7e6:	8d 6f 02             	lea    ebp,[edi+0x2]
    b7e9:	84 db                	test   bl,bl
    b7eb:	74 22                	je     b80f <_ZN3pci11printBussesEv+0x42f>
    b7ed:	0f be c3             	movsx  eax,bl
    b7f0:	89 ef                	mov    edi,ebp
    b7f2:	8d 6f 01             	lea    ebp,[edi+0x1]
    b7f5:	3c 25                	cmp    al,0x25
    b7f7:	8d 0c 2e             	lea    ecx,[esi+ebp*1]
    b7fa:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b7fd:	74 d1                	je     b7d0 <_ZN3pci11printBussesEv+0x3f0>
    b7ff:	83 ec 0c             	sub    esp,0xc
    b802:	50                   	push   eax
    b803:	e8 18 f9 ff ff       	call   b120 <_Z7putcharc>
    b808:	83 c4 10             	add    esp,0x10
    b80b:	84 db                	test   bl,bl
    b80d:	75 de                	jne    b7ed <_ZN3pci11printBussesEv+0x40d>
    b80f:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b813:	e9 c8 fc ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    b818:	90                   	nop
    b819:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b820:	83 ec 0c             	sub    esp,0xc
    b823:	8d 5f 02             	lea    ebx,[edi+0x2]
    b826:	6a 25                	push   0x25
    b828:	e8 f3 f8 ff ff       	call   b120 <_Z7putcharc>
    b82d:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b834:	83 c4 10             	add    esp,0x10
    b837:	84 c0                	test   al,al
    b839:	0f 85 67 fc ff ff    	jne    b4a6 <_ZN3pci11printBussesEv+0xc6>
    b83f:	e9 9c fc ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    b844:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b848:	83 ec 0c             	sub    esp,0xc
    b84b:	8d 5d 02             	lea    ebx,[ebp+0x2]
    b84e:	6a 25                	push   0x25
    b850:	e8 cb f8 ff ff       	call   b120 <_Z7putcharc>
    b855:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b85c:	83 c4 10             	add    esp,0x10
    b85f:	84 c0                	test   al,al
    b861:	0f 85 f7 fc ff ff    	jne    b55e <_ZN3pci11printBussesEv+0x17e>
    b867:	83 c6 01             	add    esi,0x1
    b86a:	83 fe 20             	cmp    esi,0x20
    b86d:	0f 85 95 fb ff ff    	jne    b408 <_ZN3pci11printBussesEv+0x28>
    b873:	e9 2c fd ff ff       	jmp    b5a4 <_ZN3pci11printBussesEv+0x1c4>
    b878:	90                   	nop
    b879:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b880:	83 ec 08             	sub    esp,0x8
    b883:	89 f5                	mov    ebp,esi
    b885:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b889:	8d 44 24 3b          	lea    eax,[esp+0x3b]
    b88d:	89 fb                	mov    ebx,edi
    b88f:	50                   	push   eax
    b890:	51                   	push   ecx
    b891:	e8 9a 0b 00 00       	call   c430 <_Z14_manage_escapeIhEiPKcPT_>
    b896:	01 c3                	add    ebx,eax
    b898:	83 c4 10             	add    esp,0x10
    b89b:	01 eb                	add    ebx,ebp
    b89d:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    b8a0:	84 d2                	test   dl,dl
    b8a2:	0f 84 f0 fc ff ff    	je     b598 <_ZN3pci11printBussesEv+0x1b8>
    b8a8:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b8ac:	31 ed                	xor    ebp,ebp
    b8ae:	89 de                	mov    esi,ebx
    b8b0:	eb 2c                	jmp    b8de <_ZN3pci11printBussesEv+0x4fe>
    b8b2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b8b8:	80 fb 25             	cmp    bl,0x25
    b8bb:	0f 84 bf 03 00 00    	je     bc80 <_ZN3pci11printBussesEv+0x8a0>
    b8c1:	84 db                	test   bl,bl
    b8c3:	0f 85 37 01 00 00    	jne    ba00 <_ZN3pci11printBussesEv+0x620>
    b8c9:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b8ce:	8d 7d 02             	lea    edi,[ebp+0x2]
    b8d1:	84 db                	test   bl,bl
    b8d3:	0f 84 7e fd ff ff    	je     b657 <_ZN3pci11printBussesEv+0x277>
    b8d9:	0f be d3             	movsx  edx,bl
    b8dc:	89 fd                	mov    ebp,edi
    b8de:	8d 7d 01             	lea    edi,[ebp+0x1]
    b8e1:	80 fa 25             	cmp    dl,0x25
    b8e4:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b8e7:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b8ea:	74 cc                	je     b8b8 <_ZN3pci11printBussesEv+0x4d8>
    b8ec:	83 ec 0c             	sub    esp,0xc
    b8ef:	52                   	push   edx
    b8f0:	e8 2b f8 ff ff       	call   b120 <_Z7putcharc>
    b8f5:	83 c4 10             	add    esp,0x10
    b8f8:	84 db                	test   bl,bl
    b8fa:	75 dd                	jne    b8d9 <_ZN3pci11printBussesEv+0x4f9>
    b8fc:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b900:	e9 56 fd ff ff       	jmp    b65b <_ZN3pci11printBussesEv+0x27b>
    b905:	8d 76 00             	lea    esi,[esi+0x0]
    b908:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b90c:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b910:	83 ec 08             	sub    esp,0x8
    b913:	8d 44 24 39          	lea    eax,[esp+0x39]
    b917:	50                   	push   eax
    b918:	51                   	push   ecx
    b919:	e8 12 0b 00 00       	call   c430 <_Z14_manage_escapeIhEiPKcPT_>
    b91e:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b922:	01 c5                	add    ebp,eax
    b924:	0f b6 44 24 28       	movzx  eax,BYTE PTR [esp+0x28]
    b929:	01 d5                	add    ebp,edx
    b92b:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    b92f:	88 44 24 42          	mov    BYTE PTR [esp+0x42],al
    b933:	83 c4 10             	add    esp,0x10
    b936:	84 d2                	test   dl,dl
    b938:	0f 84 a2 fb ff ff    	je     b4e0 <_ZN3pci11printBussesEv+0x100>
    b93e:	31 ff                	xor    edi,edi
    b940:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b944:	89 ee                	mov    esi,ebp
    b946:	89 fd                	mov    ebp,edi
    b948:	eb 28                	jmp    b972 <_ZN3pci11printBussesEv+0x592>
    b94a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b950:	80 fb 25             	cmp    bl,0x25
    b953:	0f 84 f7 02 00 00    	je     bc50 <_ZN3pci11printBussesEv+0x870>
    b959:	84 db                	test   bl,bl
    b95b:	0f 85 7f 01 00 00    	jne    bae0 <_ZN3pci11printBussesEv+0x700>
    b961:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b966:	8d 7d 02             	lea    edi,[ebp+0x2]
    b969:	84 db                	test   bl,bl
    b96b:	74 23                	je     b990 <_ZN3pci11printBussesEv+0x5b0>
    b96d:	0f be d3             	movsx  edx,bl
    b970:	89 fd                	mov    ebp,edi
    b972:	8d 7d 01             	lea    edi,[ebp+0x1]
    b975:	80 fa 25             	cmp    dl,0x25
    b978:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b97b:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b97e:	74 d0                	je     b950 <_ZN3pci11printBussesEv+0x570>
    b980:	83 ec 0c             	sub    esp,0xc
    b983:	52                   	push   edx
    b984:	e8 97 f7 ff ff       	call   b120 <_Z7putcharc>
    b989:	83 c4 10             	add    esp,0x10
    b98c:	84 db                	test   bl,bl
    b98e:	75 dd                	jne    b96d <_ZN3pci11printBussesEv+0x58d>
    b990:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b994:	e9 47 fb ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    b999:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b9a0:	83 ec 0c             	sub    esp,0xc
    b9a3:	8d 7d 02             	lea    edi,[ebp+0x2]
    b9a6:	6a 25                	push   0x25
    b9a8:	e8 73 f7 ff ff       	call   b120 <_Z7putcharc>
    b9ad:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b9b2:	83 c4 10             	add    esp,0x10
    b9b5:	84 db                	test   bl,bl
    b9b7:	0f 85 78 fc ff ff    	jne    b635 <_ZN3pci11printBussesEv+0x255>
    b9bd:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b9c1:	e9 95 fc ff ff       	jmp    b65b <_ZN3pci11printBussesEv+0x27b>
    b9c6:	8d 76 00             	lea    esi,[esi+0x0]
    b9c9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b9d0:	83 ec 0c             	sub    esp,0xc
    b9d3:	8d 7d 02             	lea    edi,[ebp+0x2]
    b9d6:	6a 25                	push   0x25
    b9d8:	e8 43 f7 ff ff       	call   b120 <_Z7putcharc>
    b9dd:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b9e2:	83 c4 10             	add    esp,0x10
    b9e5:	84 db                	test   bl,bl
    b9e7:	0f 85 e0 fc ff ff    	jne    b6cd <_ZN3pci11printBussesEv+0x2ed>
    b9ed:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    b9f1:	e9 ea fa ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    b9f6:	8d 76 00             	lea    esi,[esi+0x0]
    b9f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ba00:	89 d8                	mov    eax,ebx
    ba02:	89 f3                	mov    ebx,esi
    ba04:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    ba08:	83 e8 42             	sub    eax,0x42
    ba0b:	3c 36                	cmp    al,0x36
    ba0d:	77 21                	ja     ba30 <_ZN3pci11printBussesEv+0x650>
    ba0f:	0f b6 c0             	movzx  eax,al
    ba12:	ff 24 85 00 d0 00 00 	jmp    DWORD PTR [eax*4+0xd000]
    ba19:	83 ec 0c             	sub    esp,0xc
    ba1c:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba20:	e8 5b f7 ff ff       	call   b180 <_Z6putstrPc>
    ba25:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba29:	83 c4 10             	add    esp,0x10
    ba2c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ba30:	83 ec 0c             	sub    esp,0xc
    ba33:	83 c6 01             	add    esi,0x1
    ba36:	51                   	push   ecx
    ba37:	e8 64 f7 ff ff       	call   b1a0 <_Z6printfPKc>
    ba3c:	83 c4 10             	add    esp,0x10
    ba3f:	83 fe 20             	cmp    esi,0x20
    ba42:	0f 85 c0 f9 ff ff    	jne    b408 <_ZN3pci11printBussesEv+0x28>
    ba48:	e9 57 fb ff ff       	jmp    b5a4 <_ZN3pci11printBussesEv+0x1c4>
    ba4d:	83 ec 0c             	sub    esp,0xc
    ba50:	0f be 44 24 24       	movsx  eax,BYTE PTR [esp+0x24]
    ba55:	50                   	push   eax
    ba56:	e8 c5 f6 ff ff       	call   b120 <_Z7putcharc>
    ba5b:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba5f:	83 c4 10             	add    esp,0x10
    ba62:	eb cc                	jmp    ba30 <_ZN3pci11printBussesEv+0x650>
    ba64:	83 ec 0c             	sub    esp,0xc
    ba67:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba6b:	e8 e0 f6 ff ff       	call   b150 <_Z6puthexi>
    ba70:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba74:	83 c4 10             	add    esp,0x10
    ba77:	eb b7                	jmp    ba30 <_ZN3pci11printBussesEv+0x650>
    ba79:	83 ec 0c             	sub    esp,0xc
    ba7c:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba80:	e8 db f6 ff ff       	call   b160 <_Z6putocti>
    ba85:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba89:	83 c4 10             	add    esp,0x10
    ba8c:	eb a2                	jmp    ba30 <_ZN3pci11printBussesEv+0x650>
    ba8e:	83 ec 0c             	sub    esp,0xc
    ba91:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ba95:	e8 d6 f6 ff ff       	call   b170 <_Z6putbini>
    ba9a:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ba9e:	83 c4 10             	add    esp,0x10
    baa1:	eb 8d                	jmp    ba30 <_ZN3pci11printBussesEv+0x650>
    baa3:	83 ec 0c             	sub    esp,0xc
    baa6:	68 bc e5 00 00       	push   0xe5bc
    baab:	e8 f0 f6 ff ff       	call   b1a0 <_Z6printfPKc>
    bab0:	58                   	pop    eax
    bab1:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    bab5:	e8 96 f6 ff ff       	call   b150 <_Z6puthexi>
    baba:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    babe:	83 c4 10             	add    esp,0x10
    bac1:	e9 6a ff ff ff       	jmp    ba30 <_ZN3pci11printBussesEv+0x650>
    bac6:	83 ec 0c             	sub    esp,0xc
    bac9:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    bacd:	e8 6e f6 ff ff       	call   b140 <_Z6putdeci>
    bad2:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    bad6:	83 c4 10             	add    esp,0x10
    bad9:	e9 52 ff ff ff       	jmp    ba30 <_ZN3pci11printBussesEv+0x650>
    bade:	66 90                	xchg   ax,ax
    bae0:	83 ec 08             	sub    esp,0x8
    bae3:	89 f5                	mov    ebp,esi
    bae5:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    bae9:	8d 44 24 3a          	lea    eax,[esp+0x3a]
    baed:	89 fb                	mov    ebx,edi
    baef:	50                   	push   eax
    baf0:	51                   	push   ecx
    baf1:	e8 3a 09 00 00       	call   c430 <_Z14_manage_escapeIhEiPKcPT_>
    baf6:	01 c3                	add    ebx,eax
    baf8:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    bafc:	01 eb                	add    ebx,ebp
    bafe:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    bb01:	89 44 24 48          	mov    DWORD PTR [esp+0x48],eax
    bb05:	83 c4 10             	add    esp,0x10
    bb08:	84 d2                	test   dl,dl
    bb0a:	0f 84 d0 f9 ff ff    	je     b4e0 <_ZN3pci11printBussesEv+0x100>
    bb10:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    bb14:	31 ed                	xor    ebp,ebp
    bb16:	89 de                	mov    esi,ebx
    bb18:	eb 2c                	jmp    bb46 <_ZN3pci11printBussesEv+0x766>
    bb1a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bb20:	80 fb 25             	cmp    bl,0x25
    bb23:	0f 84 af 01 00 00    	je     bcd8 <_ZN3pci11printBussesEv+0x8f8>
    bb29:	84 db                	test   bl,bl
    bb2b:	0f 85 9f 00 00 00    	jne    bbd0 <_ZN3pci11printBussesEv+0x7f0>
    bb31:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bb36:	8d 7d 02             	lea    edi,[ebp+0x2]
    bb39:	84 db                	test   bl,bl
    bb3b:	0f 84 4f fe ff ff    	je     b990 <_ZN3pci11printBussesEv+0x5b0>
    bb41:	0f be d3             	movsx  edx,bl
    bb44:	89 fd                	mov    ebp,edi
    bb46:	8d 7d 01             	lea    edi,[ebp+0x1]
    bb49:	80 fa 25             	cmp    dl,0x25
    bb4c:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    bb4f:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    bb52:	74 cc                	je     bb20 <_ZN3pci11printBussesEv+0x740>
    bb54:	83 ec 0c             	sub    esp,0xc
    bb57:	52                   	push   edx
    bb58:	e8 c3 f5 ff ff       	call   b120 <_Z7putcharc>
    bb5d:	83 c4 10             	add    esp,0x10
    bb60:	84 db                	test   bl,bl
    bb62:	75 dd                	jne    bb41 <_ZN3pci11printBussesEv+0x761>
    bb64:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bb68:	e9 73 f9 ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    bb6d:	8d 76 00             	lea    esi,[esi+0x0]
    bb70:	83 ec 0c             	sub    esp,0xc
    bb73:	8d 6f 02             	lea    ebp,[edi+0x2]
    bb76:	6a 25                	push   0x25
    bb78:	e8 a3 f5 ff ff       	call   b120 <_Z7putcharc>
    bb7d:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    bb82:	83 c4 10             	add    esp,0x10
    bb85:	84 db                	test   bl,bl
    bb87:	0f 85 60 fc ff ff    	jne    b7ed <_ZN3pci11printBussesEv+0x40d>
    bb8d:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    bb91:	e9 4a f9 ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    bb96:	8d 76 00             	lea    esi,[esi+0x0]
    bb99:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bba0:	83 ec 0c             	sub    esp,0xc
    bba3:	8d 7d 02             	lea    edi,[ebp+0x2]
    bba6:	6a 25                	push   0x25
    bba8:	e8 73 f5 ff ff       	call   b120 <_Z7putcharc>
    bbad:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bbb2:	83 c4 10             	add    esp,0x10
    bbb5:	84 db                	test   bl,bl
    bbb7:	0f 85 a4 fb ff ff    	jne    b761 <_ZN3pci11printBussesEv+0x381>
    bbbd:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bbc1:	e9 95 fa ff ff       	jmp    b65b <_ZN3pci11printBussesEv+0x27b>
    bbc6:	8d 76 00             	lea    esi,[esi+0x0]
    bbc9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bbd0:	83 ec 08             	sub    esp,0x8
    bbd3:	89 f3                	mov    ebx,esi
    bbd5:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    bbd9:	8d 44 24 40          	lea    eax,[esp+0x40]
    bbdd:	50                   	push   eax
    bbde:	51                   	push   ecx
    bbdf:	e8 5c 09 00 00       	call   c540 <_Z14_manage_escapeIiEiPKcPT_>
    bbe4:	01 c7                	add    edi,eax
    bbe6:	89 74 24 4c          	mov    DWORD PTR [esp+0x4c],esi
    bbea:	83 c4 10             	add    esp,0x10
    bbed:	01 df                	add    edi,ebx
    bbef:	0f be 07             	movsx  eax,BYTE PTR [edi]
    bbf2:	84 c0                	test   al,al
    bbf4:	0f 84 e6 f8 ff ff    	je     b4e0 <_ZN3pci11printBussesEv+0x100>
    bbfa:	31 d2                	xor    edx,edx
    bbfc:	eb 28                	jmp    bc26 <_ZN3pci11printBussesEv+0x846>
    bbfe:	66 90                	xchg   ax,ax
    bc00:	80 fb 25             	cmp    bl,0x25
    bc03:	0f 84 f7 00 00 00    	je     bd00 <_ZN3pci11printBussesEv+0x920>
    bc09:	84 db                	test   bl,bl
    bc0b:	0f 85 9f 00 00 00    	jne    bcb0 <_ZN3pci11printBussesEv+0x8d0>
    bc11:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    bc16:	8d 6a 02             	lea    ebp,[edx+0x2]
    bc19:	84 db                	test   bl,bl
    bc1b:	0f 84 bf f8 ff ff    	je     b4e0 <_ZN3pci11printBussesEv+0x100>
    bc21:	0f be c3             	movsx  eax,bl
    bc24:	89 ea                	mov    edx,ebp
    bc26:	8d 6a 01             	lea    ebp,[edx+0x1]
    bc29:	3c 25                	cmp    al,0x25
    bc2b:	8d 0c 2f             	lea    ecx,[edi+ebp*1]
    bc2e:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    bc31:	74 cd                	je     bc00 <_ZN3pci11printBussesEv+0x820>
    bc33:	83 ec 0c             	sub    esp,0xc
    bc36:	50                   	push   eax
    bc37:	e8 e4 f4 ff ff       	call   b120 <_Z7putcharc>
    bc3c:	83 c4 10             	add    esp,0x10
    bc3f:	84 db                	test   bl,bl
    bc41:	75 de                	jne    bc21 <_ZN3pci11printBussesEv+0x841>
    bc43:	e9 98 f8 ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    bc48:	90                   	nop
    bc49:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bc50:	83 ec 0c             	sub    esp,0xc
    bc53:	8d 7d 02             	lea    edi,[ebp+0x2]
    bc56:	6a 25                	push   0x25
    bc58:	e8 c3 f4 ff ff       	call   b120 <_Z7putcharc>
    bc5d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bc62:	83 c4 10             	add    esp,0x10
    bc65:	84 db                	test   bl,bl
    bc67:	0f 85 00 fd ff ff    	jne    b96d <_ZN3pci11printBussesEv+0x58d>
    bc6d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bc71:	e9 6a f8 ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    bc76:	8d 76 00             	lea    esi,[esi+0x0]
    bc79:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bc80:	83 ec 0c             	sub    esp,0xc
    bc83:	8d 7d 02             	lea    edi,[ebp+0x2]
    bc86:	6a 25                	push   0x25
    bc88:	e8 93 f4 ff ff       	call   b120 <_Z7putcharc>
    bc8d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bc92:	83 c4 10             	add    esp,0x10
    bc95:	84 db                	test   bl,bl
    bc97:	0f 85 3c fc ff ff    	jne    b8d9 <_ZN3pci11printBussesEv+0x4f9>
    bc9d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bca1:	e9 b5 f9 ff ff       	jmp    b65b <_ZN3pci11printBussesEv+0x27b>
    bca6:	8d 76 00             	lea    esi,[esi+0x0]
    bca9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bcb0:	83 ec 08             	sub    esp,0x8
    bcb3:	8d 44 24 44          	lea    eax,[esp+0x44]
    bcb7:	50                   	push   eax
    bcb8:	51                   	push   ecx
    bcb9:	e8 82 08 00 00       	call   c540 <_Z14_manage_escapeIiEiPKcPT_>
    bcbe:	8d 1c 28             	lea    ebx,[eax+ebp*1]
    bcc1:	01 fb                	add    ebx,edi
    bcc3:	89 1c 24             	mov    DWORD PTR [esp],ebx
    bcc6:	e8 d5 f4 ff ff       	call   b1a0 <_Z6printfPKc>
    bccb:	83 c4 10             	add    esp,0x10
    bcce:	e9 0d f8 ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    bcd3:	90                   	nop
    bcd4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bcd8:	83 ec 0c             	sub    esp,0xc
    bcdb:	8d 7d 02             	lea    edi,[ebp+0x2]
    bcde:	6a 25                	push   0x25
    bce0:	e8 3b f4 ff ff       	call   b120 <_Z7putcharc>
    bce5:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    bcea:	83 c4 10             	add    esp,0x10
    bced:	84 db                	test   bl,bl
    bcef:	0f 85 4c fe ff ff    	jne    bb41 <_ZN3pci11printBussesEv+0x761>
    bcf5:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    bcf9:	e9 e2 f7 ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>
    bcfe:	66 90                	xchg   ax,ax
    bd00:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    bd04:	83 ec 0c             	sub    esp,0xc
    bd07:	6a 25                	push   0x25
    bd09:	e8 12 f4 ff ff       	call   b120 <_Z7putcharc>
    bd0e:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    bd12:	83 c4 10             	add    esp,0x10
    bd15:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    bd1a:	8d 6a 02             	lea    ebp,[edx+0x2]
    bd1d:	84 db                	test   bl,bl
    bd1f:	0f 85 fc fe ff ff    	jne    bc21 <_ZN3pci11printBussesEv+0x841>
    bd25:	e9 b6 f7 ff ff       	jmp    b4e0 <_ZN3pci11printBussesEv+0x100>

Disassembly of section .text._Z6printfIiEvPKcT_:

0000bd30 <_Z6printfIiEvPKcT_>:
    bd30:	55                   	push   ebp
    bd31:	57                   	push   edi
    bd32:	31 ff                	xor    edi,edi
    bd34:	56                   	push   esi
    bd35:	53                   	push   ebx
    bd36:	83 ec 1c             	sub    esp,0x1c
    bd39:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    bd3d:	8b 74 24 30          	mov    esi,DWORD PTR [esp+0x30]
    bd41:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    bd45:	0f be 06             	movsx  eax,BYTE PTR [esi]
    bd48:	84 c0                	test   al,al
    bd4a:	74 4c                	je     bd98 <_Z6printfIiEvPKcT_+0x68>
    bd4c:	8d 5f 01             	lea    ebx,[edi+0x1]
    bd4f:	3c 25                	cmp    al,0x25
    bd51:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    bd54:	75 2e                	jne    bd84 <_Z6printfIiEvPKcT_+0x54>
    bd56:	8d 76 00             	lea    esi,[esi+0x0]
    bd59:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bd60:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    bd64:	3c 25                	cmp    al,0x25
    bd66:	74 78                	je     bde0 <_Z6printfIiEvPKcT_+0xb0>
    bd68:	84 c0                	test   al,al
    bd6a:	75 34                	jne    bda0 <_Z6printfIiEvPKcT_+0x70>
    bd6c:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    bd71:	8d 5f 02             	lea    ebx,[edi+0x2]
    bd74:	84 c0                	test   al,al
    bd76:	74 20                	je     bd98 <_Z6printfIiEvPKcT_+0x68>
    bd78:	89 df                	mov    edi,ebx
    bd7a:	8d 5f 01             	lea    ebx,[edi+0x1]
    bd7d:	3c 25                	cmp    al,0x25
    bd7f:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    bd82:	74 dc                	je     bd60 <_Z6printfIiEvPKcT_+0x30>
    bd84:	83 ec 0c             	sub    esp,0xc
    bd87:	50                   	push   eax
    bd88:	e8 93 f3 ff ff       	call   b120 <_Z7putcharc>
    bd8d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    bd91:	83 c4 10             	add    esp,0x10
    bd94:	84 c0                	test   al,al
    bd96:	75 e0                	jne    bd78 <_Z6printfIiEvPKcT_+0x48>
    bd98:	83 c4 1c             	add    esp,0x1c
    bd9b:	5b                   	pop    ebx
    bd9c:	5e                   	pop    esi
    bd9d:	5f                   	pop    edi
    bd9e:	5d                   	pop    ebp
    bd9f:	c3                   	ret    
    bda0:	83 e8 42             	sub    eax,0x42
    bda3:	3c 36                	cmp    al,0x36
    bda5:	77 26                	ja     bdcd <_Z6printfIiEvPKcT_+0x9d>
    bda7:	0f b6 c0             	movzx  eax,al
    bdaa:	ff 24 85 28 e3 00 00 	jmp    DWORD PTR [eax*4+0xe328]
    bdb1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bdb8:	83 ec 0c             	sub    esp,0xc
    bdbb:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bdbf:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bdc4:	50                   	push   eax
    bdc5:	e8 56 f3 ff ff       	call   b120 <_Z7putcharc>
    bdca:	83 c4 10             	add    esp,0x10
    bdcd:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    bdd1:	83 c4 1c             	add    esp,0x1c
    bdd4:	5b                   	pop    ebx
    bdd5:	5e                   	pop    esi
    bdd6:	5f                   	pop    edi
    bdd7:	5d                   	pop    ebp
    bdd8:	e9 c3 f3 ff ff       	jmp    b1a0 <_Z6printfPKc>
    bddd:	8d 76 00             	lea    esi,[esi+0x0]
    bde0:	83 ec 0c             	sub    esp,0xc
    bde3:	8d 5f 02             	lea    ebx,[edi+0x2]
    bde6:	6a 25                	push   0x25
    bde8:	e8 33 f3 ff ff       	call   b120 <_Z7putcharc>
    bded:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    bdf2:	83 c4 10             	add    esp,0x10
    bdf5:	84 c0                	test   al,al
    bdf7:	74 9f                	je     bd98 <_Z6printfIiEvPKcT_+0x68>
    bdf9:	89 df                	mov    edi,ebx
    bdfb:	e9 7a ff ff ff       	jmp    bd7a <_Z6printfIiEvPKcT_+0x4a>
    be00:	83 ec 0c             	sub    esp,0xc
    be03:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    be07:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be0b:	e8 70 f3 ff ff       	call   b180 <_Z6putstrPc>
    be10:	83 c4 10             	add    esp,0x10
    be13:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be17:	83 c4 1c             	add    esp,0x1c
    be1a:	5b                   	pop    ebx
    be1b:	5e                   	pop    esi
    be1c:	5f                   	pop    edi
    be1d:	5d                   	pop    ebp
    be1e:	e9 7d f3 ff ff       	jmp    b1a0 <_Z6printfPKc>
    be23:	90                   	nop
    be24:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    be28:	83 ec 0c             	sub    esp,0xc
    be2b:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    be2f:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be33:	e8 38 f3 ff ff       	call   b170 <_Z6putbini>
    be38:	83 c4 10             	add    esp,0x10
    be3b:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be3f:	83 c4 1c             	add    esp,0x1c
    be42:	5b                   	pop    ebx
    be43:	5e                   	pop    esi
    be44:	5f                   	pop    edi
    be45:	5d                   	pop    ebp
    be46:	e9 55 f3 ff ff       	jmp    b1a0 <_Z6printfPKc>
    be4b:	90                   	nop
    be4c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    be50:	83 ec 0c             	sub    esp,0xc
    be53:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    be57:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be5b:	e8 00 f3 ff ff       	call   b160 <_Z6putocti>
    be60:	83 c4 10             	add    esp,0x10
    be63:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be67:	83 c4 1c             	add    esp,0x1c
    be6a:	5b                   	pop    ebx
    be6b:	5e                   	pop    esi
    be6c:	5f                   	pop    edi
    be6d:	5d                   	pop    ebp
    be6e:	e9 2d f3 ff ff       	jmp    b1a0 <_Z6printfPKc>
    be73:	90                   	nop
    be74:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    be78:	83 ec 0c             	sub    esp,0xc
    be7b:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    be7f:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    be83:	e8 c8 f2 ff ff       	call   b150 <_Z6puthexi>
    be88:	83 c4 10             	add    esp,0x10
    be8b:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    be8f:	83 c4 1c             	add    esp,0x1c
    be92:	5b                   	pop    ebx
    be93:	5e                   	pop    esi
    be94:	5f                   	pop    edi
    be95:	5d                   	pop    ebp
    be96:	e9 05 f3 ff ff       	jmp    b1a0 <_Z6printfPKc>
    be9b:	90                   	nop
    be9c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bea0:	83 ec 0c             	sub    esp,0xc
    bea3:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    bea7:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    beab:	e8 90 f2 ff ff       	call   b140 <_Z6putdeci>
    beb0:	83 c4 10             	add    esp,0x10
    beb3:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    beb7:	83 c4 1c             	add    esp,0x1c
    beba:	5b                   	pop    ebx
    bebb:	5e                   	pop    esi
    bebc:	5f                   	pop    edi
    bebd:	5d                   	pop    ebp
    bebe:	e9 dd f2 ff ff       	jmp    b1a0 <_Z6printfPKc>
    bec3:	90                   	nop
    bec4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bec8:	83 ec 0c             	sub    esp,0xc
    becb:	8d 6c 3e 02          	lea    ebp,[esi+edi*1+0x2]
    becf:	68 24 e3 00 00       	push   0xe324
    bed4:	e8 c7 f2 ff ff       	call   b1a0 <_Z6printfPKc>
    bed9:	58                   	pop    eax
    beda:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bede:	e8 6d f2 ff ff       	call   b150 <_Z6puthexi>
    bee3:	83 c4 10             	add    esp,0x10
    bee6:	89 6c 24 30          	mov    DWORD PTR [esp+0x30],ebp
    beea:	83 c4 1c             	add    esp,0x1c
    beed:	5b                   	pop    ebx
    beee:	5e                   	pop    esi
    beef:	5f                   	pop    edi
    bef0:	5d                   	pop    ebp
    bef1:	e9 aa f2 ff ff       	jmp    b1a0 <_Z6printfPKc>

Disassembly of section .text._Z6printfIcEvPKcT_:

0000bf00 <_Z6printfIcEvPKcT_>:
    bf00:	55                   	push   ebp
    bf01:	57                   	push   edi
    bf02:	56                   	push   esi
    bf03:	53                   	push   ebx
    bf04:	31 f6                	xor    esi,esi
    bf06:	83 ec 1c             	sub    esp,0x1c
    bf09:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    bf0d:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    bf11:	88 44 24 0c          	mov    BYTE PTR [esp+0xc],al
    bf15:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    bf19:	84 c0                	test   al,al
    bf1b:	74 4e                	je     bf6b <_Z6printfIcEvPKcT_+0x6b>
    bf1d:	8d 5e 01             	lea    ebx,[esi+0x1]
    bf20:	3c 25                	cmp    al,0x25
    bf22:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    bf26:	75 30                	jne    bf58 <_Z6printfIcEvPKcT_+0x58>
    bf28:	90                   	nop
    bf29:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bf30:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    bf33:	3c 25                	cmp    al,0x25
    bf35:	0f 84 85 00 00 00    	je     bfc0 <_Z6printfIcEvPKcT_+0xc0>
    bf3b:	84 c0                	test   al,al
    bf3d:	75 39                	jne    bf78 <_Z6printfIcEvPKcT_+0x78>
    bf3f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    bf44:	8d 5e 02             	lea    ebx,[esi+0x2]
    bf47:	84 c0                	test   al,al
    bf49:	74 20                	je     bf6b <_Z6printfIcEvPKcT_+0x6b>
    bf4b:	89 de                	mov    esi,ebx
    bf4d:	8d 5e 01             	lea    ebx,[esi+0x1]
    bf50:	3c 25                	cmp    al,0x25
    bf52:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    bf56:	74 d8                	je     bf30 <_Z6printfIcEvPKcT_+0x30>
    bf58:	83 ec 0c             	sub    esp,0xc
    bf5b:	50                   	push   eax
    bf5c:	e8 bf f1 ff ff       	call   b120 <_Z7putcharc>
    bf61:	0f be 07             	movsx  eax,BYTE PTR [edi]
    bf64:	83 c4 10             	add    esp,0x10
    bf67:	84 c0                	test   al,al
    bf69:	75 e0                	jne    bf4b <_Z6printfIcEvPKcT_+0x4b>
    bf6b:	83 c4 1c             	add    esp,0x1c
    bf6e:	5b                   	pop    ebx
    bf6f:	5e                   	pop    esi
    bf70:	5f                   	pop    edi
    bf71:	5d                   	pop    ebp
    bf72:	c3                   	ret    
    bf73:	90                   	nop
    bf74:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bf78:	83 e8 42             	sub    eax,0x42
    bf7b:	3c 36                	cmp    al,0x36
    bf7d:	77 26                	ja     bfa5 <_Z6printfIcEvPKcT_+0xa5>
    bf7f:	0f b6 c0             	movzx  eax,al
    bf82:	ff 24 85 04 e4 00 00 	jmp    DWORD PTR [eax*4+0xe404]
    bf89:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bf90:	83 ec 0c             	sub    esp,0xc
    bf93:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bf97:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bf9c:	50                   	push   eax
    bf9d:	e8 7e f1 ff ff       	call   b120 <_Z7putcharc>
    bfa2:	83 c4 10             	add    esp,0x10
    bfa5:	83 ec 0c             	sub    esp,0xc
    bfa8:	57                   	push   edi
    bfa9:	e8 f2 f1 ff ff       	call   b1a0 <_Z6printfPKc>
    bfae:	83 c4 10             	add    esp,0x10
    bfb1:	83 c4 1c             	add    esp,0x1c
    bfb4:	5b                   	pop    ebx
    bfb5:	5e                   	pop    esi
    bfb6:	5f                   	pop    edi
    bfb7:	5d                   	pop    ebp
    bfb8:	c3                   	ret    
    bfb9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bfc0:	83 ec 0c             	sub    esp,0xc
    bfc3:	8d 5e 02             	lea    ebx,[esi+0x2]
    bfc6:	6a 25                	push   0x25
    bfc8:	e8 53 f1 ff ff       	call   b120 <_Z7putcharc>
    bfcd:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    bfd2:	83 c4 10             	add    esp,0x10
    bfd5:	84 c0                	test   al,al
    bfd7:	74 92                	je     bf6b <_Z6printfIcEvPKcT_+0x6b>
    bfd9:	89 de                	mov    esi,ebx
    bfdb:	e9 6d ff ff ff       	jmp    bf4d <_Z6printfIcEvPKcT_+0x4d>
    bfe0:	83 ec 0c             	sub    esp,0xc
    bfe3:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    bfe7:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bfeb:	e8 90 f1 ff ff       	call   b180 <_Z6putstrPc>
    bff0:	83 c4 10             	add    esp,0x10
    bff3:	83 ec 0c             	sub    esp,0xc
    bff6:	57                   	push   edi
    bff7:	e8 a4 f1 ff ff       	call   b1a0 <_Z6printfPKc>
    bffc:	83 c4 10             	add    esp,0x10
    bfff:	eb b0                	jmp    bfb1 <_Z6printfIcEvPKcT_+0xb1>
    c001:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c008:	83 ec 0c             	sub    esp,0xc
    c00b:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c00f:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    c014:	50                   	push   eax
    c015:	e8 56 f1 ff ff       	call   b170 <_Z6putbini>
    c01a:	83 c4 10             	add    esp,0x10
    c01d:	83 ec 0c             	sub    esp,0xc
    c020:	57                   	push   edi
    c021:	e8 7a f1 ff ff       	call   b1a0 <_Z6printfPKc>
    c026:	83 c4 10             	add    esp,0x10
    c029:	eb 86                	jmp    bfb1 <_Z6printfIcEvPKcT_+0xb1>
    c02b:	90                   	nop
    c02c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c030:	83 ec 0c             	sub    esp,0xc
    c033:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c037:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    c03c:	50                   	push   eax
    c03d:	e8 1e f1 ff ff       	call   b160 <_Z6putocti>
    c042:	83 c4 10             	add    esp,0x10
    c045:	83 ec 0c             	sub    esp,0xc
    c048:	57                   	push   edi
    c049:	e8 52 f1 ff ff       	call   b1a0 <_Z6printfPKc>
    c04e:	83 c4 10             	add    esp,0x10
    c051:	e9 5b ff ff ff       	jmp    bfb1 <_Z6printfIcEvPKcT_+0xb1>
    c056:	8d 76 00             	lea    esi,[esi+0x0]
    c059:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c060:	83 ec 0c             	sub    esp,0xc
    c063:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c067:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    c06c:	50                   	push   eax
    c06d:	e8 de f0 ff ff       	call   b150 <_Z6puthexi>
    c072:	83 c4 10             	add    esp,0x10
    c075:	83 ec 0c             	sub    esp,0xc
    c078:	57                   	push   edi
    c079:	e8 22 f1 ff ff       	call   b1a0 <_Z6printfPKc>
    c07e:	83 c4 10             	add    esp,0x10
    c081:	e9 2b ff ff ff       	jmp    bfb1 <_Z6printfIcEvPKcT_+0xb1>
    c086:	8d 76 00             	lea    esi,[esi+0x0]
    c089:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c090:	83 ec 0c             	sub    esp,0xc
    c093:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c097:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    c09c:	50                   	push   eax
    c09d:	e8 9e f0 ff ff       	call   b140 <_Z6putdeci>
    c0a2:	83 c4 10             	add    esp,0x10
    c0a5:	83 ec 0c             	sub    esp,0xc
    c0a8:	57                   	push   edi
    c0a9:	e8 f2 f0 ff ff       	call   b1a0 <_Z6printfPKc>
    c0ae:	83 c4 10             	add    esp,0x10
    c0b1:	e9 fb fe ff ff       	jmp    bfb1 <_Z6printfIcEvPKcT_+0xb1>
    c0b6:	8d 76 00             	lea    esi,[esi+0x0]
    c0b9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c0c0:	83 ec 0c             	sub    esp,0xc
    c0c3:	8d 7c 35 02          	lea    edi,[ebp+esi*1+0x2]
    c0c7:	68 24 e3 00 00       	push   0xe324
    c0cc:	e8 cf f0 ff ff       	call   b1a0 <_Z6printfPKc>
    c0d1:	58                   	pop    eax
    c0d2:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    c0d6:	e8 75 f0 ff ff       	call   b150 <_Z6puthexi>
    c0db:	83 c4 10             	add    esp,0x10
    c0de:	83 ec 0c             	sub    esp,0xc
    c0e1:	57                   	push   edi
    c0e2:	e8 b9 f0 ff ff       	call   b1a0 <_Z6printfPKc>
    c0e7:	83 c4 10             	add    esp,0x10
    c0ea:	e9 c2 fe ff ff       	jmp    bfb1 <_Z6printfIcEvPKcT_+0xb1>

Disassembly of section .text._Z14_manage_escapeItEiPKcPT_:

0000c0f0 <_Z14_manage_escapeItEiPKcPT_>:
    c0f0:	83 ec 0c             	sub    esp,0xc
    c0f3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c0f7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c0fa:	83 e8 42             	sub    eax,0x42
    c0fd:	3c 36                	cmp    al,0x36
    c0ff:	0f 87 f3 00 00 00    	ja     c1f8 <_Z14_manage_escapeItEiPKcPT_+0x108>
    c105:	0f b6 c0             	movzx  eax,al
    c108:	ff 24 85 e0 e4 00 00 	jmp    DWORD PTR [eax*4+0xe4e0]
    c10f:	90                   	nop
    c110:	83 ec 0c             	sub    esp,0xc
    c113:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c117:	ff 30                	push   DWORD PTR [eax]
    c119:	e8 62 f0 ff ff       	call   b180 <_Z6putstrPc>
    c11e:	83 c4 10             	add    esp,0x10
    c121:	b8 01 00 00 00       	mov    eax,0x1
    c126:	83 c4 0c             	add    esp,0xc
    c129:	c3                   	ret    
    c12a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c130:	83 ec 0c             	sub    esp,0xc
    c133:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c137:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c13a:	50                   	push   eax
    c13b:	e8 30 f0 ff ff       	call   b170 <_Z6putbini>
    c140:	83 c4 10             	add    esp,0x10
    c143:	b8 01 00 00 00       	mov    eax,0x1
    c148:	83 c4 0c             	add    esp,0xc
    c14b:	c3                   	ret    
    c14c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c150:	83 ec 0c             	sub    esp,0xc
    c153:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c157:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c15a:	50                   	push   eax
    c15b:	e8 00 f0 ff ff       	call   b160 <_Z6putocti>
    c160:	83 c4 10             	add    esp,0x10
    c163:	b8 01 00 00 00       	mov    eax,0x1
    c168:	83 c4 0c             	add    esp,0xc
    c16b:	c3                   	ret    
    c16c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c170:	83 ec 0c             	sub    esp,0xc
    c173:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c177:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c17a:	50                   	push   eax
    c17b:	e8 d0 ef ff ff       	call   b150 <_Z6puthexi>
    c180:	83 c4 10             	add    esp,0x10
    c183:	b8 01 00 00 00       	mov    eax,0x1
    c188:	83 c4 0c             	add    esp,0xc
    c18b:	c3                   	ret    
    c18c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c190:	83 ec 0c             	sub    esp,0xc
    c193:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c197:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c19a:	50                   	push   eax
    c19b:	e8 80 ef ff ff       	call   b120 <_Z7putcharc>
    c1a0:	83 c4 10             	add    esp,0x10
    c1a3:	b8 01 00 00 00       	mov    eax,0x1
    c1a8:	83 c4 0c             	add    esp,0xc
    c1ab:	c3                   	ret    
    c1ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c1b0:	83 ec 0c             	sub    esp,0xc
    c1b3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c1b7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    c1ba:	50                   	push   eax
    c1bb:	e8 80 ef ff ff       	call   b140 <_Z6putdeci>
    c1c0:	83 c4 10             	add    esp,0x10
    c1c3:	b8 01 00 00 00       	mov    eax,0x1
    c1c8:	83 c4 0c             	add    esp,0xc
    c1cb:	c3                   	ret    
    c1cc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c1d0:	83 ec 0c             	sub    esp,0xc
    c1d3:	68 24 e3 00 00       	push   0xe324
    c1d8:	e8 c3 ef ff ff       	call   b1a0 <_Z6printfPKc>
    c1dd:	58                   	pop    eax
    c1de:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c1e2:	ff 30                	push   DWORD PTR [eax]
    c1e4:	e8 67 ef ff ff       	call   b150 <_Z6puthexi>
    c1e9:	83 c4 10             	add    esp,0x10
    c1ec:	b8 01 00 00 00       	mov    eax,0x1
    c1f1:	83 c4 0c             	add    esp,0xc
    c1f4:	c3                   	ret    
    c1f5:	8d 76 00             	lea    esi,[esi+0x0]
    c1f8:	31 c0                	xor    eax,eax
    c1fa:	e9 27 ff ff ff       	jmp    c126 <_Z14_manage_escapeItEiPKcPT_+0x36>

Disassembly of section .text._Z6printfItJttEEvPKcT_DpT0_:

0000c200 <_Z6printfItJttEEvPKcT_DpT0_>:
    c200:	55                   	push   ebp
    c201:	57                   	push   edi
    c202:	31 c9                	xor    ecx,ecx
    c204:	56                   	push   esi
    c205:	53                   	push   ebx
    c206:	83 ec 2c             	sub    esp,0x2c
    c209:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    c20d:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    c211:	8b 74 24 48          	mov    esi,DWORD PTR [esp+0x48]
    c215:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    c219:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    c21d:	66 89 44 24 0c       	mov    WORD PTR [esp+0xc],ax
    c222:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c226:	84 c0                	test   al,al
    c228:	74 49                	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c22a:	8d 79 01             	lea    edi,[ecx+0x1]
    c22d:	3c 25                	cmp    al,0x25
    c22f:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    c233:	75 2b                	jne    c260 <_Z6printfItJttEEvPKcT_DpT0_+0x60>
    c235:	8d 76 00             	lea    esi,[esi+0x0]
    c238:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    c23b:	3c 25                	cmp    al,0x25
    c23d:	0f 84 3d 01 00 00    	je     c380 <_Z6printfItJttEEvPKcT_DpT0_+0x180>
    c243:	84 c0                	test   al,al
    c245:	75 39                	jne    c280 <_Z6printfItJttEEvPKcT_DpT0_+0x80>
    c247:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    c24c:	8d 79 02             	lea    edi,[ecx+0x2]
    c24f:	84 c0                	test   al,al
    c251:	74 20                	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c253:	89 f9                	mov    ecx,edi
    c255:	8d 79 01             	lea    edi,[ecx+0x1]
    c258:	3c 25                	cmp    al,0x25
    c25a:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    c25e:	74 d8                	je     c238 <_Z6printfItJttEEvPKcT_DpT0_+0x38>
    c260:	83 ec 0c             	sub    esp,0xc
    c263:	50                   	push   eax
    c264:	e8 b7 ee ff ff       	call   b120 <_Z7putcharc>
    c269:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    c26c:	83 c4 10             	add    esp,0x10
    c26f:	84 c0                	test   al,al
    c271:	75 e0                	jne    c253 <_Z6printfItJttEEvPKcT_DpT0_+0x53>
    c273:	83 c4 2c             	add    esp,0x2c
    c276:	5b                   	pop    ebx
    c277:	5e                   	pop    esi
    c278:	5f                   	pop    edi
    c279:	5d                   	pop    ebp
    c27a:	c3                   	ret    
    c27b:	90                   	nop
    c27c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c280:	83 ec 08             	sub    esp,0x8
    c283:	8d 44 24 14          	lea    eax,[esp+0x14]
    c287:	50                   	push   eax
    c288:	53                   	push   ebx
    c289:	e8 62 fe ff ff       	call   c0f0 <_Z14_manage_escapeItEiPKcPT_>
    c28e:	01 c7                	add    edi,eax
    c290:	66 89 74 24 2c       	mov    WORD PTR [esp+0x2c],si
    c295:	83 c4 10             	add    esp,0x10
    c298:	01 fd                	add    ebp,edi
    c29a:	31 ff                	xor    edi,edi
    c29c:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c2a0:	84 c0                	test   al,al
    c2a2:	74 cf                	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c2a4:	8d 77 01             	lea    esi,[edi+0x1]
    c2a7:	3c 25                	cmp    al,0x25
    c2a9:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    c2ad:	75 29                	jne    c2d8 <_Z6printfItJttEEvPKcT_DpT0_+0xd8>
    c2af:	90                   	nop
    c2b0:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    c2b3:	3c 25                	cmp    al,0x25
    c2b5:	0f 84 1d 01 00 00    	je     c3d8 <_Z6printfItJttEEvPKcT_DpT0_+0x1d8>
    c2bb:	84 c0                	test   al,al
    c2bd:	75 31                	jne    c2f0 <_Z6printfItJttEEvPKcT_DpT0_+0xf0>
    c2bf:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    c2c4:	8d 77 02             	lea    esi,[edi+0x2]
    c2c7:	84 c0                	test   al,al
    c2c9:	74 a8                	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c2cb:	89 f7                	mov    edi,esi
    c2cd:	8d 77 01             	lea    esi,[edi+0x1]
    c2d0:	3c 25                	cmp    al,0x25
    c2d2:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    c2d6:	74 d8                	je     c2b0 <_Z6printfItJttEEvPKcT_DpT0_+0xb0>
    c2d8:	83 ec 0c             	sub    esp,0xc
    c2db:	50                   	push   eax
    c2dc:	e8 3f ee ff ff       	call   b120 <_Z7putcharc>
    c2e1:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    c2e4:	83 c4 10             	add    esp,0x10
    c2e7:	84 c0                	test   al,al
    c2e9:	74 88                	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c2eb:	89 f7                	mov    edi,esi
    c2ed:	eb de                	jmp    c2cd <_Z6printfItJttEEvPKcT_DpT0_+0xcd>
    c2ef:	90                   	nop
    c2f0:	83 ec 08             	sub    esp,0x8
    c2f3:	8d 44 24 24          	lea    eax,[esp+0x24]
    c2f7:	50                   	push   eax
    c2f8:	53                   	push   ebx
    c2f9:	e8 f2 fd ff ff       	call   c0f0 <_Z14_manage_escapeItEiPKcPT_>
    c2fe:	01 c6                	add    esi,eax
    c300:	0f b7 44 24 14       	movzx  eax,WORD PTR [esp+0x14]
    c305:	01 f5                	add    ebp,esi
    c307:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    c30c:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    c310:	83 c4 10             	add    esp,0x10
    c313:	84 c0                	test   al,al
    c315:	0f 84 58 ff ff ff    	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c31b:	31 f6                	xor    esi,esi
    c31d:	3c 25                	cmp    al,0x25
    c31f:	8d 5e 01             	lea    ebx,[esi+0x1]
    c322:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    c326:	75 34                	jne    c35c <_Z6printfItJttEEvPKcT_DpT0_+0x15c>
    c328:	90                   	nop
    c329:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c330:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    c333:	3c 25                	cmp    al,0x25
    c335:	0f 84 c5 00 00 00    	je     c400 <_Z6printfItJttEEvPKcT_DpT0_+0x200>
    c33b:	84 c0                	test   al,al
    c33d:	75 71                	jne    c3b0 <_Z6printfItJttEEvPKcT_DpT0_+0x1b0>
    c33f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    c344:	8d 5e 02             	lea    ebx,[esi+0x2]
    c347:	84 c0                	test   al,al
    c349:	0f 84 24 ff ff ff    	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c34f:	89 de                	mov    esi,ebx
    c351:	8d 5e 01             	lea    ebx,[esi+0x1]
    c354:	3c 25                	cmp    al,0x25
    c356:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    c35a:	74 d4                	je     c330 <_Z6printfItJttEEvPKcT_DpT0_+0x130>
    c35c:	83 ec 0c             	sub    esp,0xc
    c35f:	50                   	push   eax
    c360:	e8 bb ed ff ff       	call   b120 <_Z7putcharc>
    c365:	0f be 07             	movsx  eax,BYTE PTR [edi]
    c368:	83 c4 10             	add    esp,0x10
    c36b:	84 c0                	test   al,al
    c36d:	0f 84 00 ff ff ff    	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c373:	89 de                	mov    esi,ebx
    c375:	eb da                	jmp    c351 <_Z6printfItJttEEvPKcT_DpT0_+0x151>
    c377:	89 f6                	mov    esi,esi
    c379:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c380:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    c384:	83 ec 0c             	sub    esp,0xc
    c387:	6a 25                	push   0x25
    c389:	e8 92 ed ff ff       	call   b120 <_Z7putcharc>
    c38e:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    c392:	83 c4 10             	add    esp,0x10
    c395:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    c39a:	8d 79 02             	lea    edi,[ecx+0x2]
    c39d:	84 c0                	test   al,al
    c39f:	0f 84 ce fe ff ff    	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c3a5:	89 f9                	mov    ecx,edi
    c3a7:	e9 a9 fe ff ff       	jmp    c255 <_Z6printfItJttEEvPKcT_DpT0_+0x55>
    c3ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c3b0:	83 ec 08             	sub    esp,0x8
    c3b3:	8d 44 24 26          	lea    eax,[esp+0x26]
    c3b7:	50                   	push   eax
    c3b8:	57                   	push   edi
    c3b9:	e8 32 fd ff ff       	call   c0f0 <_Z14_manage_escapeItEiPKcPT_>
    c3be:	01 c3                	add    ebx,eax
    c3c0:	01 dd                	add    ebp,ebx
    c3c2:	89 2c 24             	mov    DWORD PTR [esp],ebp
    c3c5:	e8 d6 ed ff ff       	call   b1a0 <_Z6printfPKc>
    c3ca:	83 c4 10             	add    esp,0x10
    c3cd:	83 c4 2c             	add    esp,0x2c
    c3d0:	5b                   	pop    ebx
    c3d1:	5e                   	pop    esi
    c3d2:	5f                   	pop    edi
    c3d3:	5d                   	pop    ebp
    c3d4:	c3                   	ret    
    c3d5:	8d 76 00             	lea    esi,[esi+0x0]
    c3d8:	83 ec 0c             	sub    esp,0xc
    c3db:	8d 77 02             	lea    esi,[edi+0x2]
    c3de:	6a 25                	push   0x25
    c3e0:	e8 3b ed ff ff       	call   b120 <_Z7putcharc>
    c3e5:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    c3ea:	83 c4 10             	add    esp,0x10
    c3ed:	84 c0                	test   al,al
    c3ef:	0f 84 7e fe ff ff    	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c3f5:	89 f7                	mov    edi,esi
    c3f7:	e9 d1 fe ff ff       	jmp    c2cd <_Z6printfItJttEEvPKcT_DpT0_+0xcd>
    c3fc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c400:	83 ec 0c             	sub    esp,0xc
    c403:	8d 5e 02             	lea    ebx,[esi+0x2]
    c406:	6a 25                	push   0x25
    c408:	e8 13 ed ff ff       	call   b120 <_Z7putcharc>
    c40d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    c412:	83 c4 10             	add    esp,0x10
    c415:	84 c0                	test   al,al
    c417:	0f 84 56 fe ff ff    	je     c273 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c41d:	89 de                	mov    esi,ebx
    c41f:	e9 2d ff ff ff       	jmp    c351 <_Z6printfItJttEEvPKcT_DpT0_+0x151>

Disassembly of section .text._Z14_manage_escapeIhEiPKcPT_:

0000c430 <_Z14_manage_escapeIhEiPKcPT_>:
    c430:	83 ec 0c             	sub    esp,0xc
    c433:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c437:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c43a:	83 e8 42             	sub    eax,0x42
    c43d:	3c 36                	cmp    al,0x36
    c43f:	0f 87 f3 00 00 00    	ja     c538 <_Z14_manage_escapeIhEiPKcPT_+0x108>
    c445:	0f b6 c0             	movzx  eax,al
    c448:	ff 24 85 c0 e5 00 00 	jmp    DWORD PTR [eax*4+0xe5c0]
    c44f:	90                   	nop
    c450:	83 ec 0c             	sub    esp,0xc
    c453:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c457:	ff 30                	push   DWORD PTR [eax]
    c459:	e8 22 ed ff ff       	call   b180 <_Z6putstrPc>
    c45e:	83 c4 10             	add    esp,0x10
    c461:	b8 01 00 00 00       	mov    eax,0x1
    c466:	83 c4 0c             	add    esp,0xc
    c469:	c3                   	ret    
    c46a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c470:	83 ec 0c             	sub    esp,0xc
    c473:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c477:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c47a:	50                   	push   eax
    c47b:	e8 f0 ec ff ff       	call   b170 <_Z6putbini>
    c480:	83 c4 10             	add    esp,0x10
    c483:	b8 01 00 00 00       	mov    eax,0x1
    c488:	83 c4 0c             	add    esp,0xc
    c48b:	c3                   	ret    
    c48c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c490:	83 ec 0c             	sub    esp,0xc
    c493:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c497:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c49a:	50                   	push   eax
    c49b:	e8 c0 ec ff ff       	call   b160 <_Z6putocti>
    c4a0:	83 c4 10             	add    esp,0x10
    c4a3:	b8 01 00 00 00       	mov    eax,0x1
    c4a8:	83 c4 0c             	add    esp,0xc
    c4ab:	c3                   	ret    
    c4ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c4b0:	83 ec 0c             	sub    esp,0xc
    c4b3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c4b7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c4ba:	50                   	push   eax
    c4bb:	e8 90 ec ff ff       	call   b150 <_Z6puthexi>
    c4c0:	83 c4 10             	add    esp,0x10
    c4c3:	b8 01 00 00 00       	mov    eax,0x1
    c4c8:	83 c4 0c             	add    esp,0xc
    c4cb:	c3                   	ret    
    c4cc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c4d0:	83 ec 0c             	sub    esp,0xc
    c4d3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c4d7:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c4da:	50                   	push   eax
    c4db:	e8 40 ec ff ff       	call   b120 <_Z7putcharc>
    c4e0:	83 c4 10             	add    esp,0x10
    c4e3:	b8 01 00 00 00       	mov    eax,0x1
    c4e8:	83 c4 0c             	add    esp,0xc
    c4eb:	c3                   	ret    
    c4ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c4f0:	83 ec 0c             	sub    esp,0xc
    c4f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c4f7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c4fa:	50                   	push   eax
    c4fb:	e8 40 ec ff ff       	call   b140 <_Z6putdeci>
    c500:	83 c4 10             	add    esp,0x10
    c503:	b8 01 00 00 00       	mov    eax,0x1
    c508:	83 c4 0c             	add    esp,0xc
    c50b:	c3                   	ret    
    c50c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c510:	83 ec 0c             	sub    esp,0xc
    c513:	68 bc e5 00 00       	push   0xe5bc
    c518:	e8 83 ec ff ff       	call   b1a0 <_Z6printfPKc>
    c51d:	58                   	pop    eax
    c51e:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c522:	ff 30                	push   DWORD PTR [eax]
    c524:	e8 27 ec ff ff       	call   b150 <_Z6puthexi>
    c529:	83 c4 10             	add    esp,0x10
    c52c:	b8 01 00 00 00       	mov    eax,0x1
    c531:	83 c4 0c             	add    esp,0xc
    c534:	c3                   	ret    
    c535:	8d 76 00             	lea    esi,[esi+0x0]
    c538:	31 c0                	xor    eax,eax
    c53a:	e9 27 ff ff ff       	jmp    c466 <_Z14_manage_escapeIhEiPKcPT_+0x36>

Disassembly of section .text._Z14_manage_escapeIiEiPKcPT_:

0000c540 <_Z14_manage_escapeIiEiPKcPT_>:
    c540:	83 ec 0c             	sub    esp,0xc
    c543:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c547:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c54a:	83 e8 42             	sub    eax,0x42
    c54d:	3c 36                	cmp    al,0x36
    c54f:	0f 87 db 00 00 00    	ja     c630 <_Z14_manage_escapeIiEiPKcPT_+0xf0>
    c555:	0f b6 c0             	movzx  eax,al
    c558:	ff 24 85 9c e6 00 00 	jmp    DWORD PTR [eax*4+0xe69c]
    c55f:	90                   	nop
    c560:	83 ec 0c             	sub    esp,0xc
    c563:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c567:	ff 30                	push   DWORD PTR [eax]
    c569:	e8 12 ec ff ff       	call   b180 <_Z6putstrPc>
    c56e:	83 c4 10             	add    esp,0x10
    c571:	b8 01 00 00 00       	mov    eax,0x1
    c576:	83 c4 0c             	add    esp,0xc
    c579:	c3                   	ret    
    c57a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c580:	83 ec 0c             	sub    esp,0xc
    c583:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c587:	ff 30                	push   DWORD PTR [eax]
    c589:	e8 e2 eb ff ff       	call   b170 <_Z6putbini>
    c58e:	83 c4 10             	add    esp,0x10
    c591:	b8 01 00 00 00       	mov    eax,0x1
    c596:	83 c4 0c             	add    esp,0xc
    c599:	c3                   	ret    
    c59a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c5a0:	83 ec 0c             	sub    esp,0xc
    c5a3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c5a7:	ff 30                	push   DWORD PTR [eax]
    c5a9:	e8 b2 eb ff ff       	call   b160 <_Z6putocti>
    c5ae:	83 c4 10             	add    esp,0x10
    c5b1:	b8 01 00 00 00       	mov    eax,0x1
    c5b6:	83 c4 0c             	add    esp,0xc
    c5b9:	c3                   	ret    
    c5ba:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c5c0:	83 ec 0c             	sub    esp,0xc
    c5c3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c5c7:	ff 30                	push   DWORD PTR [eax]
    c5c9:	e8 82 eb ff ff       	call   b150 <_Z6puthexi>
    c5ce:	83 c4 10             	add    esp,0x10
    c5d1:	b8 01 00 00 00       	mov    eax,0x1
    c5d6:	83 c4 0c             	add    esp,0xc
    c5d9:	c3                   	ret    
    c5da:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c5e0:	83 ec 0c             	sub    esp,0xc
    c5e3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c5e7:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c5ea:	50                   	push   eax
    c5eb:	e8 30 eb ff ff       	call   b120 <_Z7putcharc>
    c5f0:	83 c4 10             	add    esp,0x10
    c5f3:	b8 01 00 00 00       	mov    eax,0x1
    c5f8:	83 c4 0c             	add    esp,0xc
    c5fb:	c3                   	ret    
    c5fc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c600:	83 ec 0c             	sub    esp,0xc
    c603:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c607:	ff 30                	push   DWORD PTR [eax]
    c609:	e8 32 eb ff ff       	call   b140 <_Z6putdeci>
    c60e:	83 c4 10             	add    esp,0x10
    c611:	b8 01 00 00 00       	mov    eax,0x1
    c616:	83 c4 0c             	add    esp,0xc
    c619:	c3                   	ret    
    c61a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c620:	83 ec 0c             	sub    esp,0xc
    c623:	68 bc e5 00 00       	push   0xe5bc
    c628:	e8 73 eb ff ff       	call   b1a0 <_Z6printfPKc>
    c62d:	58                   	pop    eax
    c62e:	eb 93                	jmp    c5c3 <_Z14_manage_escapeIiEiPKcPT_+0x83>
    c630:	31 c0                	xor    eax,eax
    c632:	e9 3f ff ff ff       	jmp    c576 <_Z14_manage_escapeIiEiPKcPT_+0x36>
