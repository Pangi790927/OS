
stage2.elf:     file format elf32-i386


Disassembly of section .text:

0000a000 <kernel_2-0x10>:
    a000:	e8 0b 00 00 00       	call   a010 <kernel_2>
    a005:	eb fe                	jmp    a005 <WHITE_ON_BLACK+0x9ff6>
    a007:	66 90                	xchg   ax,ax
    a009:	66 90                	xchg   ax,ax
    a00b:	66 90                	xchg   ax,ax
    a00d:	66 90                	xchg   ax,ax
    a00f:	90                   	nop

0000a010 <kernel_2>:
    a010:	83 ec 1c             	sub    esp,0x1c
    a013:	c6 44 24 0f 00       	mov    BYTE PTR [esp+0xf],0x0
    a018:	e8 23 0e 00 00       	call   ae40 <_Z12clear_screenv>
    a01d:	83 ec 0c             	sub    esp,0xc
    a020:	68 dc d0 00 00       	push   0xd0dc
    a025:	e8 a6 0e 00 00       	call   aed0 <_Z6printfPKc>
    a02a:	e8 c1 00 00 00       	call   a0f0 <check_A20_on>
    a02f:	83 c4 10             	add    esp,0x10
    a032:	85 c0                	test   eax,eax
    a034:	0f 85 ab 00 00 00    	jne    a0e5 <kernel_2+0xd5>
    a03a:	83 ec 04             	sub    esp,0x4
    a03d:	6a 00                	push   0x0
    a03f:	8d 44 24 17          	lea    eax,[esp+0x17]
    a043:	50                   	push   eax
    a044:	6a 00                	push   0x0
    a046:	e8 c5 05 00 00       	call   a610 <_ZN3ata12sendIdentifyEhRbb>
    a04b:	83 c4 10             	add    esp,0x10
    a04e:	84 c0                	test   al,al
    a050:	74 7e                	je     a0d0 <kernel_2+0xc0>
    a052:	80 7c 24 0f 00       	cmp    BYTE PTR [esp+0xf],0x0
    a057:	75 48                	jne    a0a1 <kernel_2+0x91>
    a059:	83 ec 0c             	sub    esp,0xc
    a05c:	68 84 d1 00 00       	push   0xd184
    a061:	e8 6a 0e 00 00       	call   aed0 <_Z6printfPKc>
    a066:	c7 04 24 00 00 00 00 	mov    DWORD PTR [esp],0x0
    a06d:	68 e8 07 00 00       	push   0x7e8
    a072:	6a 00                	push   0x0
    a074:	68 80 00 00 00       	push   0x80
    a079:	68 00 00 00 01       	push   0x1000000
    a07e:	e8 ed 04 00 00       	call   a570 <_ZN3ata9lba48ReadEPvyjh>
    a083:	83 c4 20             	add    esp,0x20
    a086:	84 c0                	test   al,al
    a088:	75 34                	jne    a0be <kernel_2+0xae>
    a08a:	83 ec 0c             	sub    esp,0xc
    a08d:	68 f7 d0 00 00       	push   0xd0f7
    a092:	e8 39 0e 00 00       	call   aed0 <_Z6printfPKc>
    a097:	83 c4 10             	add    esp,0x10
    a09a:	e8 61 5f ff 00       	call   1000000 <VGA_TEXT_MEMORY+0xf48000>
    a09f:	eb fe                	jmp    a09f <kernel_2+0x8f>
    a0a1:	6a 00                	push   0x0
    a0a3:	68 e8 07 00 00       	push   0x7e8
    a0a8:	68 80 00 00 00       	push   0x80
    a0ad:	68 00 00 00 01       	push   0x1000000
    a0b2:	e8 79 02 00 00       	call   a330 <_ZN3ata9lba28ReadEPvjjh>
    a0b7:	83 c4 10             	add    esp,0x10
    a0ba:	84 c0                	test   al,al
    a0bc:	74 cc                	je     a08a <kernel_2+0x7a>
    a0be:	83 ec 0c             	sub    esp,0xc
    a0c1:	68 04 d1 00 00       	push   0xd104
    a0c6:	e8 05 0e 00 00       	call   aed0 <_Z6printfPKc>
    a0cb:	83 c4 10             	add    esp,0x10
    a0ce:	eb ca                	jmp    a09a <kernel_2+0x8a>
    a0d0:	83 ec 0c             	sub    esp,0xc
    a0d3:	68 e6 d0 00 00       	push   0xd0e6
    a0d8:	e8 f3 0d 00 00       	call   aed0 <_Z6printfPKc>
    a0dd:	83 c4 10             	add    esp,0x10
    a0e0:	e9 6d ff ff ff       	jmp    a052 <kernel_2+0x42>
    a0e5:	e8 24 00 00 00       	call   a10e <enable_A20>
    a0ea:	e9 4b ff ff ff       	jmp    a03a <kernel_2+0x2a>
    a0ef:	90                   	nop

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

0000a150 <_ZN3ata7waitBSYEv>:
    a150:	83 ec 0c             	sub    esp,0xc
    a153:	90                   	nop
    a154:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a158:	83 ec 0c             	sub    esp,0xc
    a15b:	68 f7 01 00 00       	push   0x1f7
    a160:	e8 fb 0d 00 00       	call   af60 <_Z3inbt>
    a165:	83 c4 10             	add    esp,0x10
    a168:	84 c0                	test   al,al
    a16a:	78 ec                	js     a158 <_ZN3ata7waitBSYEv+0x8>
    a16c:	83 c4 0c             	add    esp,0xc
    a16f:	c3                   	ret    

0000a170 <_ZN3ata7waitDSQEv>:
    a170:	83 ec 0c             	sub    esp,0xc
    a173:	eb 07                	jmp    a17c <_ZN3ata7waitDSQEv+0xc>
    a175:	8d 76 00             	lea    esi,[esi+0x0]
    a178:	a8 08                	test   al,0x8
    a17a:	75 24                	jne    a1a0 <_ZN3ata7waitDSQEv+0x30>
    a17c:	83 ec 0c             	sub    esp,0xc
    a17f:	68 f7 01 00 00       	push   0x1f7
    a184:	e8 d7 0d 00 00       	call   af60 <_Z3inbt>
    a189:	83 c4 10             	add    esp,0x10
    a18c:	a8 01                	test   al,0x1
    a18e:	74 e8                	je     a178 <_ZN3ata7waitDSQEv+0x8>
    a190:	31 c0                	xor    eax,eax
    a192:	83 c4 0c             	add    esp,0xc
    a195:	c3                   	ret    
    a196:	8d 76 00             	lea    esi,[esi+0x0]
    a199:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    a1a0:	b8 01 00 00 00       	mov    eax,0x1
    a1a5:	83 c4 0c             	add    esp,0xc
    a1a8:	c3                   	ret    
    a1a9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000a1b0 <_ZN3ata12lba28PIOReadEPvjhh>:
    a1b0:	55                   	push   ebp
    a1b1:	57                   	push   edi
    a1b2:	56                   	push   esi
    a1b3:	53                   	push   ebx
    a1b4:	83 ec 24             	sub    esp,0x24
    a1b7:	8b 5c 24 3c          	mov    ebx,DWORD PTR [esp+0x3c]
    a1bb:	0f b6 54 24 44       	movzx  edx,BYTE PTR [esp+0x44]
    a1c0:	8b 7c 24 40          	mov    edi,DWORD PTR [esp+0x40]
    a1c4:	89 d8                	mov    eax,ebx
    a1c6:	c1 e8 18             	shr    eax,0x18
    a1c9:	c1 e2 04             	shl    edx,0x4
    a1cc:	83 ca e0             	or     edx,0xffffffe0
    a1cf:	83 e0 0f             	and    eax,0xf
    a1d2:	09 d0                	or     eax,edx
    a1d4:	0f b6 c0             	movzx  eax,al
    a1d7:	50                   	push   eax
    a1d8:	68 f6 01 00 00       	push   0x1f6
    a1dd:	e8 2e 0d 00 00       	call   af10 <_Z4outbth>
    a1e2:	58                   	pop    eax
    a1e3:	5a                   	pop    edx
    a1e4:	6a 00                	push   0x0
    a1e6:	68 f1 01 00 00       	push   0x1f1
    a1eb:	e8 20 0d 00 00       	call   af10 <_Z4outbth>
    a1f0:	59                   	pop    ecx
    a1f1:	89 f8                	mov    eax,edi
    a1f3:	5e                   	pop    esi
    a1f4:	0f b6 f8             	movzx  edi,al
    a1f7:	57                   	push   edi
    a1f8:	68 f2 01 00 00       	push   0x1f2
    a1fd:	e8 0e 0d 00 00       	call   af10 <_Z4outbth>
    a202:	5d                   	pop    ebp
    a203:	58                   	pop    eax
    a204:	0f b6 c3             	movzx  eax,bl
    a207:	50                   	push   eax
    a208:	68 f3 01 00 00       	push   0x1f3
    a20d:	e8 fe 0c 00 00       	call   af10 <_Z4outbth>
    a212:	58                   	pop    eax
    a213:	5a                   	pop    edx
    a214:	0f b6 c7             	movzx  eax,bh
    a217:	50                   	push   eax
    a218:	68 f4 01 00 00       	push   0x1f4
    a21d:	e8 ee 0c 00 00       	call   af10 <_Z4outbth>
    a222:	89 d8                	mov    eax,ebx
    a224:	59                   	pop    ecx
    a225:	c1 e8 10             	shr    eax,0x10
    a228:	5e                   	pop    esi
    a229:	0f b6 c0             	movzx  eax,al
    a22c:	50                   	push   eax
    a22d:	68 f5 01 00 00       	push   0x1f5
    a232:	e8 d9 0c 00 00       	call   af10 <_Z4outbth>
    a237:	83 c4 10             	add    esp,0x10
    a23a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a240:	83 ec 0c             	sub    esp,0xc
    a243:	68 f7 01 00 00       	push   0x1f7
    a248:	e8 13 0d 00 00       	call   af60 <_Z3inbt>
    a24d:	83 c4 10             	add    esp,0x10
    a250:	84 c0                	test   al,al
    a252:	78 ec                	js     a240 <_ZN3ata12lba28PIOReadEPvjhh+0x90>
    a254:	83 ec 08             	sub    esp,0x8
    a257:	6a 20                	push   0x20
    a259:	68 f7 01 00 00       	push   0x1f7
    a25e:	e8 ad 0c 00 00       	call   af10 <_Z4outbth>
    a263:	83 c4 10             	add    esp,0x10
    a266:	85 ff                	test   edi,edi
    a268:	0f 84 b0 00 00 00    	je     a31e <_ZN3ata12lba28PIOReadEPvjhh+0x16e>
    a26e:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    a272:	31 f6                	xor    esi,esi
    a274:	05 00 02 00 00       	add    eax,0x200
    a279:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a27d:	8d 76 00             	lea    esi,[esi+0x0]
    a280:	83 ec 0c             	sub    esp,0xc
    a283:	68 f7 01 00 00       	push   0x1f7
    a288:	e8 d3 0c 00 00       	call   af60 <_Z3inbt>
    a28d:	83 c4 10             	add    esp,0x10
    a290:	84 c0                	test   al,al
    a292:	78 ec                	js     a280 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a294:	83 ec 0c             	sub    esp,0xc
    a297:	68 f6 03 00 00       	push   0x3f6
    a29c:	e8 bf 0c 00 00       	call   af60 <_Z3inbt>
    a2a1:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a2a8:	e8 b3 0c 00 00       	call   af60 <_Z3inbt>
    a2ad:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a2b4:	e8 a7 0c 00 00       	call   af60 <_Z3inbt>
    a2b9:	83 c4 10             	add    esp,0x10
    a2bc:	eb 06                	jmp    a2c4 <_ZN3ata12lba28PIOReadEPvjhh+0x114>
    a2be:	66 90                	xchg   ax,ax
    a2c0:	a8 08                	test   al,0x8
    a2c2:	75 1e                	jne    a2e2 <_ZN3ata12lba28PIOReadEPvjhh+0x132>
    a2c4:	83 ec 0c             	sub    esp,0xc
    a2c7:	68 f7 01 00 00       	push   0x1f7
    a2cc:	e8 8f 0c 00 00       	call   af60 <_Z3inbt>
    a2d1:	83 c4 10             	add    esp,0x10
    a2d4:	a8 01                	test   al,0x1
    a2d6:	74 e8                	je     a2c0 <_ZN3ata12lba28PIOReadEPvjhh+0x110>
    a2d8:	83 c4 1c             	add    esp,0x1c
    a2db:	31 c0                	xor    eax,eax
    a2dd:	5b                   	pop    ebx
    a2de:	5e                   	pop    esi
    a2df:	5f                   	pop    edi
    a2e0:	5d                   	pop    ebp
    a2e1:	c3                   	ret    
    a2e2:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a2e6:	89 f3                	mov    ebx,esi
    a2e8:	c1 e3 09             	shl    ebx,0x9
    a2eb:	01 dd                	add    ebp,ebx
    a2ed:	03 5c 24 0c          	add    ebx,DWORD PTR [esp+0xc]
    a2f1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a2f8:	83 ec 0c             	sub    esp,0xc
    a2fb:	83 c5 02             	add    ebp,0x2
    a2fe:	68 f0 01 00 00       	push   0x1f0
    a303:	e8 68 0c 00 00       	call   af70 <_Z3inwt>
    a308:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    a30c:	83 c4 10             	add    esp,0x10
    a30f:	39 dd                	cmp    ebp,ebx
    a311:	75 e5                	jne    a2f8 <_ZN3ata12lba28PIOReadEPvjhh+0x148>
    a313:	83 c6 01             	add    esi,0x1
    a316:	39 f7                	cmp    edi,esi
    a318:	0f 85 62 ff ff ff    	jne    a280 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a31e:	83 c4 1c             	add    esp,0x1c
    a321:	b8 01 00 00 00       	mov    eax,0x1
    a326:	5b                   	pop    ebx
    a327:	5e                   	pop    esi
    a328:	5f                   	pop    edi
    a329:	5d                   	pop    ebp
    a32a:	c3                   	ret    
    a32b:	90                   	nop
    a32c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000a330 <_ZN3ata9lba28ReadEPvjjh>:
    a330:	55                   	push   ebp
    a331:	57                   	push   edi
    a332:	56                   	push   esi
    a333:	53                   	push   ebx
    a334:	83 ec 1c             	sub    esp,0x1c
    a337:	8b 74 24 38          	mov    esi,DWORD PTR [esp+0x38]
    a33b:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a33f:	8b 7c 24 34          	mov    edi,DWORD PTR [esp+0x34]
    a343:	8b 44 24 3c          	mov    eax,DWORD PTR [esp+0x3c]
    a347:	85 f6                	test   esi,esi
    a349:	74 45                	je     a390 <_ZN3ata9lba28ReadEPvjjh+0x60>
    a34b:	0f b6 c0             	movzx  eax,al
    a34e:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a352:	eb 0f                	jmp    a363 <_ZN3ata9lba28ReadEPvjjh+0x33>
    a354:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a358:	01 df                	add    edi,ebx
    a35a:	c1 e3 09             	shl    ebx,0x9
    a35d:	01 dd                	add    ebp,ebx
    a35f:	85 f6                	test   esi,esi
    a361:	74 2d                	je     a390 <_ZN3ata9lba28ReadEPvjjh+0x60>
    a363:	81 fe ff 00 00 00    	cmp    esi,0xff
    a369:	bb ff 00 00 00       	mov    ebx,0xff
    a36e:	ff 74 24 0c          	push   DWORD PTR [esp+0xc]
    a372:	0f 46 de             	cmovbe ebx,esi
    a375:	53                   	push   ebx
    a376:	57                   	push   edi
    a377:	29 de                	sub    esi,ebx
    a379:	55                   	push   ebp
    a37a:	e8 31 fe ff ff       	call   a1b0 <_ZN3ata12lba28PIOReadEPvjhh>
    a37f:	83 c4 10             	add    esp,0x10
    a382:	84 c0                	test   al,al
    a384:	75 d2                	jne    a358 <_ZN3ata9lba28ReadEPvjjh+0x28>
    a386:	83 c4 1c             	add    esp,0x1c
    a389:	5b                   	pop    ebx
    a38a:	5e                   	pop    esi
    a38b:	5f                   	pop    edi
    a38c:	5d                   	pop    ebp
    a38d:	c3                   	ret    
    a38e:	66 90                	xchg   ax,ax
    a390:	83 c4 1c             	add    esp,0x1c
    a393:	b8 01 00 00 00       	mov    eax,0x1
    a398:	5b                   	pop    ebx
    a399:	5e                   	pop    esi
    a39a:	5f                   	pop    edi
    a39b:	5d                   	pop    ebp
    a39c:	c3                   	ret    
    a39d:	8d 76 00             	lea    esi,[esi+0x0]

0000a3a0 <_ZN3ata12lba48PIOReadEPvyth>:
    a3a0:	55                   	push   ebp
    a3a1:	57                   	push   edi
    a3a2:	56                   	push   esi
    a3a3:	53                   	push   ebx
    a3a4:	83 ec 24             	sub    esp,0x24
    a3a7:	0f b6 44 24 48       	movzx  eax,BYTE PTR [esp+0x48]
    a3ac:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    a3b0:	8b 7c 24 3c          	mov    edi,DWORD PTR [esp+0x3c]
    a3b4:	8b 5c 24 44          	mov    ebx,DWORD PTR [esp+0x44]
    a3b8:	c1 e0 04             	shl    eax,0x4
    a3bb:	83 c8 e0             	or     eax,0xffffffe0
    a3be:	0f b6 c0             	movzx  eax,al
    a3c1:	50                   	push   eax
    a3c2:	68 f6 01 00 00       	push   0x1f6
    a3c7:	e8 44 0b 00 00       	call   af10 <_Z4outbth>
    a3cc:	58                   	pop    eax
    a3cd:	5a                   	pop    edx
    a3ce:	6a 00                	push   0x0
    a3d0:	68 f1 01 00 00       	push   0x1f1
    a3d5:	e8 36 0b 00 00       	call   af10 <_Z4outbth>
    a3da:	59                   	pop    ecx
    a3db:	5e                   	pop    esi
    a3dc:	0f b6 c7             	movzx  eax,bh
    a3df:	50                   	push   eax
    a3e0:	68 f2 01 00 00       	push   0x1f2
    a3e5:	e8 26 0b 00 00       	call   af10 <_Z4outbth>
    a3ea:	58                   	pop    eax
    a3eb:	89 f8                	mov    eax,edi
    a3ed:	0f ac e8 18          	shrd   eax,ebp,0x18
    a3f1:	5a                   	pop    edx
    a3f2:	0f b6 c0             	movzx  eax,al
    a3f5:	50                   	push   eax
    a3f6:	68 f3 01 00 00       	push   0x1f3
    a3fb:	e8 10 0b 00 00       	call   af10 <_Z4outbth>
    a400:	5e                   	pop    esi
    a401:	58                   	pop    eax
    a402:	89 e8                	mov    eax,ebp
    a404:	0f b6 c0             	movzx  eax,al
    a407:	50                   	push   eax
    a408:	68 f4 01 00 00       	push   0x1f4
    a40d:	e8 fe 0a 00 00       	call   af10 <_Z4outbth>
    a412:	58                   	pop    eax
    a413:	89 e8                	mov    eax,ebp
    a415:	5a                   	pop    edx
    a416:	0f b6 c4             	movzx  eax,ah
    a419:	50                   	push   eax
    a41a:	68 f5 01 00 00       	push   0x1f5
    a41f:	e8 ec 0a 00 00       	call   af10 <_Z4outbth>
    a424:	59                   	pop    ecx
    a425:	5e                   	pop    esi
    a426:	0f b6 c3             	movzx  eax,bl
    a429:	50                   	push   eax
    a42a:	68 f2 01 00 00       	push   0x1f2
    a42f:	e8 dc 0a 00 00       	call   af10 <_Z4outbth>
    a434:	58                   	pop    eax
    a435:	89 f8                	mov    eax,edi
    a437:	5a                   	pop    edx
    a438:	0f b6 c0             	movzx  eax,al
    a43b:	50                   	push   eax
    a43c:	68 f3 01 00 00       	push   0x1f3
    a441:	e8 ca 0a 00 00       	call   af10 <_Z4outbth>
    a446:	89 f8                	mov    eax,edi
    a448:	0f ac e8 08          	shrd   eax,ebp,0x8
    a44c:	59                   	pop    ecx
    a44d:	5e                   	pop    esi
    a44e:	0f b6 c0             	movzx  eax,al
    a451:	50                   	push   eax
    a452:	68 f4 01 00 00       	push   0x1f4
    a457:	0f ac ef 10          	shrd   edi,ebp,0x10
    a45b:	e8 b0 0a 00 00       	call   af10 <_Z4outbth>
    a460:	5e                   	pop    esi
    a461:	58                   	pop    eax
    a462:	89 f8                	mov    eax,edi
    a464:	0f b6 f0             	movzx  esi,al
    a467:	56                   	push   esi
    a468:	68 f5 01 00 00       	push   0x1f5
    a46d:	e8 9e 0a 00 00       	call   af10 <_Z4outbth>
    a472:	83 c4 10             	add    esp,0x10
    a475:	8d 76 00             	lea    esi,[esi+0x0]
    a478:	83 ec 0c             	sub    esp,0xc
    a47b:	68 f7 01 00 00       	push   0x1f7
    a480:	e8 db 0a 00 00       	call   af60 <_Z3inbt>
    a485:	83 c4 10             	add    esp,0x10
    a488:	84 c0                	test   al,al
    a48a:	78 ec                	js     a478 <_ZN3ata12lba48PIOReadEPvyth+0xd8>
    a48c:	83 ec 08             	sub    esp,0x8
    a48f:	89 df                	mov    edi,ebx
    a491:	6a 24                	push   0x24
    a493:	68 f7 01 00 00       	push   0x1f7
    a498:	e8 73 0a 00 00       	call   af10 <_Z4outbth>
    a49d:	83 c4 10             	add    esp,0x10
    a4a0:	81 e7 ff ff 00 00    	and    edi,0xffff
    a4a6:	0f 84 b2 00 00 00    	je     a55e <_ZN3ata12lba48PIOReadEPvyth+0x1be>
    a4ac:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    a4b0:	31 f6                	xor    esi,esi
    a4b2:	05 00 02 00 00       	add    eax,0x200
    a4b7:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a4bb:	90                   	nop
    a4bc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a4c0:	83 ec 0c             	sub    esp,0xc
    a4c3:	68 f7 01 00 00       	push   0x1f7
    a4c8:	e8 93 0a 00 00       	call   af60 <_Z3inbt>
    a4cd:	83 c4 10             	add    esp,0x10
    a4d0:	84 c0                	test   al,al
    a4d2:	78 ec                	js     a4c0 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a4d4:	83 ec 0c             	sub    esp,0xc
    a4d7:	68 f6 03 00 00       	push   0x3f6
    a4dc:	e8 7f 0a 00 00       	call   af60 <_Z3inbt>
    a4e1:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a4e8:	e8 73 0a 00 00       	call   af60 <_Z3inbt>
    a4ed:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a4f4:	e8 67 0a 00 00       	call   af60 <_Z3inbt>
    a4f9:	83 c4 10             	add    esp,0x10
    a4fc:	eb 06                	jmp    a504 <_ZN3ata12lba48PIOReadEPvyth+0x164>
    a4fe:	66 90                	xchg   ax,ax
    a500:	a8 08                	test   al,0x8
    a502:	75 1e                	jne    a522 <_ZN3ata12lba48PIOReadEPvyth+0x182>
    a504:	83 ec 0c             	sub    esp,0xc
    a507:	68 f7 01 00 00       	push   0x1f7
    a50c:	e8 4f 0a 00 00       	call   af60 <_Z3inbt>
    a511:	83 c4 10             	add    esp,0x10
    a514:	a8 01                	test   al,0x1
    a516:	74 e8                	je     a500 <_ZN3ata12lba48PIOReadEPvyth+0x160>
    a518:	83 c4 1c             	add    esp,0x1c
    a51b:	31 c0                	xor    eax,eax
    a51d:	5b                   	pop    ebx
    a51e:	5e                   	pop    esi
    a51f:	5f                   	pop    edi
    a520:	5d                   	pop    ebp
    a521:	c3                   	ret    
    a522:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a526:	89 f3                	mov    ebx,esi
    a528:	c1 e3 09             	shl    ebx,0x9
    a52b:	01 dd                	add    ebp,ebx
    a52d:	03 5c 24 0c          	add    ebx,DWORD PTR [esp+0xc]
    a531:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a538:	83 ec 0c             	sub    esp,0xc
    a53b:	83 c5 02             	add    ebp,0x2
    a53e:	68 f0 01 00 00       	push   0x1f0
    a543:	e8 28 0a 00 00       	call   af70 <_Z3inwt>
    a548:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    a54c:	83 c4 10             	add    esp,0x10
    a54f:	39 dd                	cmp    ebp,ebx
    a551:	75 e5                	jne    a538 <_ZN3ata12lba48PIOReadEPvyth+0x198>
    a553:	83 c6 01             	add    esi,0x1
    a556:	39 fe                	cmp    esi,edi
    a558:	0f 85 62 ff ff ff    	jne    a4c0 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a55e:	83 c4 1c             	add    esp,0x1c
    a561:	b8 01 00 00 00       	mov    eax,0x1
    a566:	5b                   	pop    ebx
    a567:	5e                   	pop    esi
    a568:	5f                   	pop    edi
    a569:	5d                   	pop    ebp
    a56a:	c3                   	ret    
    a56b:	90                   	nop
    a56c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000a570 <_ZN3ata9lba48ReadEPvyjh>:
    a570:	55                   	push   ebp
    a571:	57                   	push   edi
    a572:	56                   	push   esi
    a573:	53                   	push   ebx
    a574:	83 ec 1c             	sub    esp,0x1c
    a577:	8b 6c 24 3c          	mov    ebp,DWORD PTR [esp+0x3c]
    a57b:	8b 54 24 30          	mov    edx,DWORD PTR [esp+0x30]
    a57f:	8b 74 24 34          	mov    esi,DWORD PTR [esp+0x34]
    a583:	8b 7c 24 38          	mov    edi,DWORD PTR [esp+0x38]
    a587:	8b 44 24 40          	mov    eax,DWORD PTR [esp+0x40]
    a58b:	85 ed                	test   ebp,ebp
    a58d:	74 69                	je     a5f8 <_ZN3ata9lba48ReadEPvyjh+0x88>
    a58f:	0f b6 c0             	movzx  eax,al
    a592:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a596:	eb 1c                	jmp    a5b4 <_ZN3ata9lba48ReadEPvyjh+0x44>
    a598:	90                   	nop
    a599:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a5a0:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    a5a4:	03 34 24             	add    esi,DWORD PTR [esp]
    a5a7:	13 7c 24 04          	adc    edi,DWORD PTR [esp+0x4]
    a5ab:	c1 e3 09             	shl    ebx,0x9
    a5ae:	01 da                	add    edx,ebx
    a5b0:	85 ed                	test   ebp,ebp
    a5b2:	74 44                	je     a5f8 <_ZN3ata9lba48ReadEPvyjh+0x88>
    a5b4:	81 fd ff ff 00 00    	cmp    ebp,0xffff
    a5ba:	bb ff ff 00 00       	mov    ebx,0xffff
    a5bf:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    a5c6:	00 
    a5c7:	0f 46 dd             	cmovbe ebx,ebp
    a5ca:	83 ec 0c             	sub    esp,0xc
    a5cd:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    a5d1:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    a5d5:	29 dd                	sub    ebp,ebx
    a5d7:	53                   	push   ebx
    a5d8:	57                   	push   edi
    a5d9:	56                   	push   esi
    a5da:	52                   	push   edx
    a5db:	89 54 24 28          	mov    DWORD PTR [esp+0x28],edx
    a5df:	e8 bc fd ff ff       	call   a3a0 <_ZN3ata12lba48PIOReadEPvyth>
    a5e4:	83 c4 20             	add    esp,0x20
    a5e7:	84 c0                	test   al,al
    a5e9:	75 b5                	jne    a5a0 <_ZN3ata9lba48ReadEPvyjh+0x30>
    a5eb:	83 c4 1c             	add    esp,0x1c
    a5ee:	5b                   	pop    ebx
    a5ef:	5e                   	pop    esi
    a5f0:	5f                   	pop    edi
    a5f1:	5d                   	pop    ebp
    a5f2:	c3                   	ret    
    a5f3:	90                   	nop
    a5f4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a5f8:	83 c4 1c             	add    esp,0x1c
    a5fb:	b8 01 00 00 00       	mov    eax,0x1
    a600:	5b                   	pop    ebx
    a601:	5e                   	pop    esi
    a602:	5f                   	pop    edi
    a603:	5d                   	pop    ebp
    a604:	c3                   	ret    
    a605:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a609:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000a610 <_ZN3ata12sendIdentifyEhRbb>:
    a610:	55                   	push   ebp
    a611:	57                   	push   edi
    a612:	56                   	push   esi
    a613:	53                   	push   ebx
    a614:	81 ec 38 02 00 00    	sub    esp,0x238
    a61a:	8b 9c 24 4c 02 00 00 	mov    ebx,DWORD PTR [esp+0x24c]
    a621:	8b ac 24 54 02 00 00 	mov    ebp,DWORD PTR [esp+0x254]
    a628:	68 f7 01 00 00       	push   0x1f7
    a62d:	e8 2e 09 00 00       	call   af60 <_Z3inbt>
    a632:	83 c4 10             	add    esp,0x10
    a635:	3c ff                	cmp    al,0xff
    a637:	0f 84 e3 00 00 00    	je     a720 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a63d:	c1 e3 04             	shl    ebx,0x4
    a640:	83 ec 08             	sub    esp,0x8
    a643:	83 cb a0             	or     ebx,0xffffffa0
    a646:	0f b6 db             	movzx  ebx,bl
    a649:	53                   	push   ebx
    a64a:	68 f6 01 00 00       	push   0x1f6
    a64f:	e8 bc 08 00 00       	call   af10 <_Z4outbth>
    a654:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a65b:	e8 00 09 00 00       	call   af60 <_Z3inbt>
    a660:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a667:	e8 f4 08 00 00       	call   af60 <_Z3inbt>
    a66c:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a673:	e8 e8 08 00 00       	call   af60 <_Z3inbt>
    a678:	83 c4 10             	add    esp,0x10
    a67b:	90                   	nop
    a67c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a680:	83 ec 0c             	sub    esp,0xc
    a683:	68 f7 01 00 00       	push   0x1f7
    a688:	e8 d3 08 00 00       	call   af60 <_Z3inbt>
    a68d:	83 c4 10             	add    esp,0x10
    a690:	84 c0                	test   al,al
    a692:	78 ec                	js     a680 <_ZN3ata12sendIdentifyEhRbb+0x70>
    a694:	83 ec 08             	sub    esp,0x8
    a697:	6a 00                	push   0x0
    a699:	68 f2 01 00 00       	push   0x1f2
    a69e:	e8 6d 08 00 00       	call   af10 <_Z4outbth>
    a6a3:	59                   	pop    ecx
    a6a4:	5b                   	pop    ebx
    a6a5:	6a 00                	push   0x0
    a6a7:	68 f3 01 00 00       	push   0x1f3
    a6ac:	e8 5f 08 00 00       	call   af10 <_Z4outbth>
    a6b1:	5e                   	pop    esi
    a6b2:	5f                   	pop    edi
    a6b3:	6a 00                	push   0x0
    a6b5:	68 f4 01 00 00       	push   0x1f4
    a6ba:	e8 51 08 00 00       	call   af10 <_Z4outbth>
    a6bf:	58                   	pop    eax
    a6c0:	5a                   	pop    edx
    a6c1:	6a 00                	push   0x0
    a6c3:	68 f5 01 00 00       	push   0x1f5
    a6c8:	e8 43 08 00 00       	call   af10 <_Z4outbth>
    a6cd:	59                   	pop    ecx
    a6ce:	5b                   	pop    ebx
    a6cf:	68 ec 00 00 00       	push   0xec
    a6d4:	68 f7 01 00 00       	push   0x1f7
    a6d9:	e8 32 08 00 00       	call   af10 <_Z4outbth>
    a6de:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    a6e5:	e8 76 08 00 00       	call   af60 <_Z3inbt>
    a6ea:	83 c4 10             	add    esp,0x10
    a6ed:	84 c0                	test   al,al
    a6ef:	74 2f                	je     a720 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a6f1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a6f8:	83 ec 0c             	sub    esp,0xc
    a6fb:	68 f7 01 00 00       	push   0x1f7
    a700:	e8 5b 08 00 00       	call   af60 <_Z3inbt>
    a705:	83 c4 10             	add    esp,0x10
    a708:	84 c0                	test   al,al
    a70a:	78 ec                	js     a6f8 <_ZN3ata12sendIdentifyEhRbb+0xe8>
    a70c:	83 ec 0c             	sub    esp,0xc
    a70f:	68 f4 01 00 00       	push   0x1f4
    a714:	e8 47 08 00 00       	call   af60 <_Z3inbt>
    a719:	83 c4 10             	add    esp,0x10
    a71c:	84 c0                	test   al,al
    a71e:	74 10                	je     a730 <_ZN3ata12sendIdentifyEhRbb+0x120>
    a720:	31 c0                	xor    eax,eax
    a722:	81 c4 2c 02 00 00    	add    esp,0x22c
    a728:	5b                   	pop    ebx
    a729:	5e                   	pop    esi
    a72a:	5f                   	pop    edi
    a72b:	5d                   	pop    ebp
    a72c:	c3                   	ret    
    a72d:	8d 76 00             	lea    esi,[esi+0x0]
    a730:	83 ec 0c             	sub    esp,0xc
    a733:	68 f5 01 00 00       	push   0x1f5
    a738:	e8 23 08 00 00       	call   af60 <_Z3inbt>
    a73d:	83 c4 10             	add    esp,0x10
    a740:	84 c0                	test   al,al
    a742:	74 10                	je     a754 <_ZN3ata12sendIdentifyEhRbb+0x144>
    a744:	eb da                	jmp    a720 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a746:	8d 76 00             	lea    esi,[esi+0x0]
    a749:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    a750:	a8 08                	test   al,0x8
    a752:	75 16                	jne    a76a <_ZN3ata12sendIdentifyEhRbb+0x15a>
    a754:	83 ec 0c             	sub    esp,0xc
    a757:	68 f7 01 00 00       	push   0x1f7
    a75c:	e8 ff 07 00 00       	call   af60 <_Z3inbt>
    a761:	83 c4 10             	add    esp,0x10
    a764:	a8 01                	test   al,0x1
    a766:	74 e8                	je     a750 <_ZN3ata12sendIdentifyEhRbb+0x140>
    a768:	eb b6                	jmp    a720 <_ZN3ata12sendIdentifyEhRbb+0x110>
    a76a:	8d 7c 24 20          	lea    edi,[esp+0x20]
    a76e:	b9 80 00 00 00       	mov    ecx,0x80
    a773:	31 c0                	xor    eax,eax
    a775:	8d b4 24 20 02 00 00 	lea    esi,[esp+0x220]
    a77c:	8d 5c 24 20          	lea    ebx,[esp+0x20]
    a780:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    a782:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a788:	83 ec 0c             	sub    esp,0xc
    a78b:	83 c3 02             	add    ebx,0x2
    a78e:	68 f0 01 00 00       	push   0x1f0
    a793:	e8 d8 07 00 00       	call   af70 <_Z3inwt>
    a798:	66 89 43 fe          	mov    WORD PTR [ebx-0x2],ax
    a79c:	83 c4 10             	add    esp,0x10
    a79f:	39 de                	cmp    esi,ebx
    a7a1:	75 e5                	jne    a788 <_ZN3ata12sendIdentifyEhRbb+0x178>
    a7a3:	89 e8                	mov    eax,ebp
    a7a5:	0f b7 b4 24 c6 00 00 	movzx  esi,WORD PTR [esp+0xc6]
    a7ac:	00 
    a7ad:	84 c0                	test   al,al
    a7af:	75 1f                	jne    a7d0 <_ZN3ata12sendIdentifyEhRbb+0x1c0>
    a7b1:	89 f0                	mov    eax,esi
    a7b3:	8b 94 24 44 02 00 00 	mov    edx,DWORD PTR [esp+0x244]
    a7ba:	66 c1 e8 0a          	shr    ax,0xa
    a7be:	83 f0 01             	xor    eax,0x1
    a7c1:	83 e0 01             	and    eax,0x1
    a7c4:	88 02                	mov    BYTE PTR [edx],al
    a7c6:	b8 01 00 00 00       	mov    eax,0x1
    a7cb:	e9 52 ff ff ff       	jmp    a722 <_ZN3ata12sendIdentifyEhRbb+0x112>
    a7d0:	83 ec 0c             	sub    esp,0xc
    a7d3:	68 12 d1 00 00       	push   0xd112
    a7d8:	e8 f3 06 00 00       	call   aed0 <_Z6printfPKc>
    a7dd:	83 c4 10             	add    esp,0x10
    a7e0:	8d 7c 24 20          	lea    edi,[esp+0x20]
    a7e4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a7e8:	8d 6f 20             	lea    ebp,[edi+0x20]
    a7eb:	90                   	nop
    a7ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a7f0:	0f b7 07             	movzx  eax,WORD PTR [edi]
    a7f3:	83 ec 08             	sub    esp,0x8
    a7f6:	83 c7 02             	add    edi,0x2
    a7f9:	50                   	push   eax
    a7fa:	68 25 d1 00 00       	push   0xd125
    a7ff:	e8 8c 16 00 00       	call   be90 <_Z6printfItEvPKcT_>
    a804:	83 c4 10             	add    esp,0x10
    a807:	39 fd                	cmp    ebp,edi
    a809:	75 e5                	jne    a7f0 <_ZN3ata12sendIdentifyEhRbb+0x1e0>
    a80b:	83 ec 0c             	sub    esp,0xc
    a80e:	68 82 d1 00 00       	push   0xd182
    a813:	e8 b8 06 00 00       	call   aed0 <_Z6printfPKc>
    a818:	83 c4 10             	add    esp,0x10
    a81b:	39 dd                	cmp    ebp,ebx
    a81d:	75 c9                	jne    a7e8 <_ZN3ata12sendIdentifyEhRbb+0x1d8>
    a81f:	0f b7 84 24 d0 00 00 	movzx  eax,WORD PTR [esp+0xd0]
    a826:	00 
    a827:	31 ed                	xor    ebp,ebp
    a829:	50                   	push   eax
    a82a:	0f b7 c6             	movzx  eax,si
    a82d:	50                   	push   eax
    a82e:	0f b7 44 24 28       	movzx  eax,WORD PTR [esp+0x28]
    a833:	50                   	push   eax
    a834:	68 29 d1 00 00       	push   0xd129
    a839:	e8 12 17 00 00       	call   bf50 <_Z6printfItJttEEvPKcT_DpT0_>
    a83e:	58                   	pop    eax
    a83f:	5a                   	pop    edx
    a840:	ff b4 24 a0 00 00 00 	push   DWORD PTR [esp+0xa0]
    a847:	68 41 d1 00 00       	push   0xd141
    a84c:	e8 1f 12 00 00       	call   ba70 <_Z6printfIiEvPKcT_>
    a851:	0f b7 84 24 fc 00 00 	movzx  eax,WORD PTR [esp+0xfc]
    a858:	00 
    a859:	0f b7 bc 24 fe 00 00 	movzx  edi,WORD PTR [esp+0xfe]
    a860:	00 
    a861:	ba 31 00 00 00       	mov    edx,0x31
    a866:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    a86a:	0f b7 84 24 fa 00 00 	movzx  eax,WORD PTR [esp+0xfa]
    a871:	00 
    a872:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    a876:	0f b7 84 24 f8 00 00 	movzx  eax,WORD PTR [esp+0xf8]
    a87d:	00 
    a87e:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    a883:	83 c4 10             	add    esp,0x10
    a886:	eb 1f                	jmp    a8a7 <_ZN3ata12sendIdentifyEhRbb+0x297>
    a888:	3c 25                	cmp    al,0x25
    a88a:	0f 84 a9 00 00 00    	je     a939 <_ZN3ata12sendIdentifyEhRbb+0x329>
    a890:	84 c0                	test   al,al
    a892:	75 7c                	jne    a910 <_ZN3ata12sendIdentifyEhRbb+0x300>
    a894:	8d 5d 02             	lea    ebx,[ebp+0x2]
    a897:	0f b6 83 4e d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd14e]
    a89e:	84 c0                	test   al,al
    a8a0:	74 33                	je     a8d5 <_ZN3ata12sendIdentifyEhRbb+0x2c5>
    a8a2:	0f be d0             	movsx  edx,al
    a8a5:	89 dd                	mov    ebp,ebx
    a8a7:	8d 5d 01             	lea    ebx,[ebp+0x1]
    a8aa:	80 fa 25             	cmp    dl,0x25
    a8ad:	0f b6 83 4e d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd14e]
    a8b4:	8d 8b 4e d1 00 00    	lea    ecx,[ebx+0xd14e]
    a8ba:	74 cc                	je     a888 <_ZN3ata12sendIdentifyEhRbb+0x278>
    a8bc:	88 44 24 07          	mov    BYTE PTR [esp+0x7],al
    a8c0:	83 ec 0c             	sub    esp,0xc
    a8c3:	52                   	push   edx
    a8c4:	e8 87 05 00 00       	call   ae50 <_Z7putcharc>
    a8c9:	83 c4 10             	add    esp,0x10
    a8cc:	0f b6 44 24 07       	movzx  eax,BYTE PTR [esp+0x7]
    a8d1:	84 c0                	test   al,al
    a8d3:	75 cd                	jne    a8a2 <_ZN3ata12sendIdentifyEhRbb+0x292>
    a8d5:	8d 5c 24 56          	lea    ebx,[esp+0x56]
    a8d9:	8d 7c 24 7e          	lea    edi,[esp+0x7e]
    a8dd:	8d 76 00             	lea    esi,[esi+0x0]
    a8e0:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    a8e3:	83 ec 08             	sub    esp,0x8
    a8e6:	83 c3 01             	add    ebx,0x1
    a8e9:	50                   	push   eax
    a8ea:	68 66 d1 00 00       	push   0xd166
    a8ef:	e8 0c 13 00 00       	call   bc00 <_Z6printfIcEvPKcT_>
    a8f4:	83 c4 10             	add    esp,0x10
    a8f7:	39 df                	cmp    edi,ebx
    a8f9:	75 e5                	jne    a8e0 <_ZN3ata12sendIdentifyEhRbb+0x2d0>
    a8fb:	83 ec 0c             	sub    esp,0xc
    a8fe:	68 82 d1 00 00       	push   0xd182
    a903:	e8 c8 05 00 00       	call   aed0 <_Z6printfPKc>
    a908:	83 c4 10             	add    esp,0x10
    a90b:	e9 a1 fe ff ff       	jmp    a7b1 <_ZN3ata12sendIdentifyEhRbb+0x1a1>
    a910:	83 ec 08             	sub    esp,0x8
    a913:	8d 44 24 26          	lea    eax,[esp+0x26]
    a917:	50                   	push   eax
    a918:	51                   	push   ecx
    a919:	e8 82 14 00 00       	call   bda0 <_Z14_manage_escapeItEiPKcPT_>
    a91e:	8d 84 03 4e d1 00 00 	lea    eax,[ebx+eax*1+0xd14e]
    a925:	57                   	push   edi
    a926:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    a92a:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    a92e:	50                   	push   eax
    a92f:	e8 1c 16 00 00       	call   bf50 <_Z6printfItJttEEvPKcT_DpT0_>
    a934:	83 c4 20             	add    esp,0x20
    a937:	eb 9c                	jmp    a8d5 <_ZN3ata12sendIdentifyEhRbb+0x2c5>
    a939:	83 ec 0c             	sub    esp,0xc
    a93c:	8d 5d 02             	lea    ebx,[ebp+0x2]
    a93f:	6a 25                	push   0x25
    a941:	e8 0a 05 00 00       	call   ae50 <_Z7putcharc>
    a946:	0f b6 83 4e d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd14e]
    a94d:	83 c4 10             	add    esp,0x10
    a950:	84 c0                	test   al,al
    a952:	0f 85 4a ff ff ff    	jne    a8a2 <_ZN3ata12sendIdentifyEhRbb+0x292>
    a958:	e9 78 ff ff ff       	jmp    a8d5 <_ZN3ata12sendIdentifyEhRbb+0x2c5>
    a95d:	66 90                	xchg   ax,ax
    a95f:	90                   	nop

0000a960 <_ZN3VGA17_actualize_cursorEv>:
    a960:	53                   	push   ebx
    a961:	83 ec 10             	sub    esp,0x10
    a964:	8b 1d 04 00 01 00    	mov    ebx,DWORD PTR ds:0x10004
    a96a:	6a 0e                	push   0xe
    a96c:	68 d4 03 00 00       	push   0x3d4
    a971:	8d 1c 9b             	lea    ebx,[ebx+ebx*4]
    a974:	c1 e3 04             	shl    ebx,0x4
    a977:	66 03 1d 00 00 01 00 	add    bx,WORD PTR ds:0x10000
    a97e:	e8 8d 05 00 00       	call   af10 <_Z4outbth>
    a983:	58                   	pop    eax
    a984:	5a                   	pop    edx
    a985:	0f b6 c7             	movzx  eax,bh
    a988:	0f b6 db             	movzx  ebx,bl
    a98b:	50                   	push   eax
    a98c:	68 d5 03 00 00       	push   0x3d5
    a991:	e8 7a 05 00 00       	call   af10 <_Z4outbth>
    a996:	59                   	pop    ecx
    a997:	58                   	pop    eax
    a998:	6a 0f                	push   0xf
    a99a:	68 d4 03 00 00       	push   0x3d4
    a99f:	e8 6c 05 00 00       	call   af10 <_Z4outbth>
    a9a4:	58                   	pop    eax
    a9a5:	5a                   	pop    edx
    a9a6:	53                   	push   ebx
    a9a7:	68 d5 03 00 00       	push   0x3d5
    a9ac:	e8 5f 05 00 00       	call   af10 <_Z4outbth>
    a9b1:	83 c4 18             	add    esp,0x18
    a9b4:	5b                   	pop    ebx
    a9b5:	c3                   	ret    
    a9b6:	8d 76 00             	lea    esi,[esi+0x0]
    a9b9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000a9c0 <_ZN3VGA14_pos_in_screenEii>:
    a9c0:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    a9c4:	8d 04 80             	lea    eax,[eax+eax*4]
    a9c7:	c1 e0 04             	shl    eax,0x4
    a9ca:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    a9ce:	01 c0                	add    eax,eax
    a9d0:	c3                   	ret    
    a9d1:	eb 0d                	jmp    a9e0 <_ZN3VGA12_char_val_atEii>
    a9d3:	90                   	nop
    a9d4:	90                   	nop
    a9d5:	90                   	nop
    a9d6:	90                   	nop
    a9d7:	90                   	nop
    a9d8:	90                   	nop
    a9d9:	90                   	nop
    a9da:	90                   	nop
    a9db:	90                   	nop
    a9dc:	90                   	nop
    a9dd:	90                   	nop
    a9de:	90                   	nop
    a9df:	90                   	nop

0000a9e0 <_ZN3VGA12_char_val_atEii>:
    a9e0:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    a9e4:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    a9ea:	8d 04 80             	lea    eax,[eax+eax*4]
    a9ed:	c1 e0 04             	shl    eax,0x4
    a9f0:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    a9f4:	8d 04 42             	lea    eax,[edx+eax*2]
    a9f7:	c3                   	ret    
    a9f8:	90                   	nop
    a9f9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000aa00 <_ZN3VGA13_char_mode_atEii>:
    aa00:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    aa04:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    aa0a:	8d 04 80             	lea    eax,[eax+eax*4]
    aa0d:	c1 e0 04             	shl    eax,0x4
    aa10:	03 44 24 08          	add    eax,DWORD PTR [esp+0x8]
    aa14:	8d 44 42 01          	lea    eax,[edx+eax*2+0x1]
    aa18:	c3                   	ret    
    aa19:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000aa20 <_ZN3VGA6scrollEc>:
    aa20:	55                   	push   ebp
    aa21:	57                   	push   edi
    aa22:	31 ed                	xor    ebp,ebp
    aa24:	56                   	push   esi
    aa25:	53                   	push   ebx
    aa26:	be 40 01 00 00       	mov    esi,0x140
    aa2b:	bf 50 00 00 00       	mov    edi,0x50
    aa30:	83 ec 1c             	sub    esp,0x1c
    aa33:	0f b6 44 24 30       	movzx  eax,BYTE PTR [esp+0x30]
    aa38:	88 44 24 0f          	mov    BYTE PTR [esp+0xf],al
    aa3c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    aa40:	89 e9                	mov    ecx,ebp
    aa42:	8d 04 3f             	lea    eax,[edi+edi*1]
    aa45:	29 f9                	sub    ecx,edi
    aa47:	01 c9                	add    ecx,ecx
    aa49:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    aa50:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    aa56:	0f b6 1c 02          	movzx  ebx,BYTE PTR [edx+eax*1]
    aa5a:	01 ca                	add    edx,ecx
    aa5c:	88 1c 02             	mov    BYTE PTR [edx+eax*1],bl
    aa5f:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    aa65:	0f b6 5c 02 01       	movzx  ebx,BYTE PTR [edx+eax*1+0x1]
    aa6a:	01 ca                	add    edx,ecx
    aa6c:	83 c0 02             	add    eax,0x2
    aa6f:	88 5c 10 ff          	mov    BYTE PTR [eax+edx*1-0x1],bl
    aa73:	39 f0                	cmp    eax,esi
    aa75:	75 d9                	jne    aa50 <_ZN3VGA6scrollEc+0x30>
    aa77:	83 c7 50             	add    edi,0x50
    aa7a:	83 c5 50             	add    ebp,0x50
    aa7d:	8d b0 a0 00 00 00    	lea    esi,[eax+0xa0]
    aa83:	81 ff d0 07 00 00    	cmp    edi,0x7d0
    aa89:	75 b5                	jne    aa40 <_ZN3VGA6scrollEc+0x20>
    aa8b:	0f b6 4c 24 0f       	movzx  ecx,BYTE PTR [esp+0xf]
    aa90:	b8 00 0f 00 00       	mov    eax,0xf00
    aa95:	8d 76 00             	lea    esi,[esi+0x0]
    aa98:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    aa9e:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    aaa2:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    aaa8:	88 4c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],cl
    aaac:	83 c0 02             	add    eax,0x2
    aaaf:	3d a0 0f 00 00       	cmp    eax,0xfa0
    aab4:	75 e2                	jne    aa98 <_ZN3VGA6scrollEc+0x78>
    aab6:	a1 04 00 01 00       	mov    eax,ds:0x10004
    aabb:	ba 00 00 00 00       	mov    edx,0x0
    aac0:	83 e8 01             	sub    eax,0x1
    aac3:	0f 48 c2             	cmovs  eax,edx
    aac6:	a3 04 00 01 00       	mov    ds:0x10004,eax
    aacb:	83 c4 1c             	add    esp,0x1c
    aace:	5b                   	pop    ebx
    aacf:	5e                   	pop    esi
    aad0:	5f                   	pop    edi
    aad1:	5d                   	pop    ebp
    aad2:	e9 89 fe ff ff       	jmp    a960 <_ZN3VGA17_actualize_cursorEv>
    aad7:	89 f6                	mov    esi,esi
    aad9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000aae0 <_ZN3VGA12clear_screenEc>:
    aae0:	53                   	push   ebx
    aae1:	0f b6 5c 24 08       	movzx  ebx,BYTE PTR [esp+0x8]
    aae6:	31 c0                	xor    eax,eax
    aae8:	90                   	nop
    aae9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    aaf0:	8d 88 a0 00 00 00    	lea    ecx,[eax+0xa0]
    aaf6:	8d 76 00             	lea    esi,[esi+0x0]
    aaf9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ab00:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ab06:	c6 04 02 20          	mov    BYTE PTR [edx+eax*1],0x20
    ab0a:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    ab10:	88 5c 02 01          	mov    BYTE PTR [edx+eax*1+0x1],bl
    ab14:	83 c0 02             	add    eax,0x2
    ab17:	39 c1                	cmp    ecx,eax
    ab19:	75 e5                	jne    ab00 <_ZN3VGA12clear_screenEc+0x20>
    ab1b:	81 f9 a0 0f 00 00    	cmp    ecx,0xfa0
    ab21:	75 cd                	jne    aaf0 <_ZN3VGA12clear_screenEc+0x10>
    ab23:	5b                   	pop    ebx
    ab24:	c7 05 04 00 01 00 00 	mov    DWORD PTR ds:0x10004,0x0
    ab2b:	00 00 00 
    ab2e:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ab35:	00 00 00 
    ab38:	e9 23 fe ff ff       	jmp    a960 <_ZN3VGA17_actualize_cursorEv>
    ab3d:	8d 76 00             	lea    esi,[esi+0x0]

0000ab40 <_ZN3VGA7putcharEcc>:
    ab40:	55                   	push   ebp
    ab41:	57                   	push   edi
    ab42:	56                   	push   esi
    ab43:	53                   	push   ebx
    ab44:	83 ec 1c             	sub    esp,0x1c
    ab47:	8b 3d 04 00 01 00    	mov    edi,DWORD PTR ds:0x10004
    ab4d:	8b 5c 24 30          	mov    ebx,DWORD PTR [esp+0x30]
    ab51:	8b 4c 24 34          	mov    ecx,DWORD PTR [esp+0x34]
    ab55:	80 fb 0a             	cmp    bl,0xa
    ab58:	0f 84 d2 00 00 00    	je     ac30 <_ZN3VGA7putcharEcc+0xf0>
    ab5e:	80 fb 09             	cmp    bl,0x9
    ab61:	0f 85 99 00 00 00    	jne    ac00 <_ZN3VGA7putcharEcc+0xc0>
    ab67:	a1 00 00 01 00       	mov    eax,ds:0x10000
    ab6c:	31 f6                	xor    esi,esi
    ab6e:	8d 50 04             	lea    edx,[eax+0x4]
    ab71:	83 e2 fc             	and    edx,0xfffffffc
    ab74:	83 fa 4f             	cmp    edx,0x4f
    ab77:	89 15 00 00 01 00    	mov    DWORD PTR ds:0x10000,edx
    ab7d:	0f 8e 15 01 00 00    	jle    ac98 <_ZN3VGA7putcharEcc+0x158>
    ab83:	bd cd cc cc cc       	mov    ebp,0xcccccccd
    ab88:	89 d0                	mov    eax,edx
    ab8a:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ab91:	00 00 00 
    ab94:	f7 e5                	mul    ebp
    ab96:	c1 ea 06             	shr    edx,0x6
    ab99:	01 fa                	add    edx,edi
    ab9b:	83 fa 18             	cmp    edx,0x18
    ab9e:	89 15 04 00 01 00    	mov    DWORD PTR ds:0x10004,edx
    aba4:	0f 8f ce 00 00 00    	jg     ac78 <_ZN3VGA7putcharEcc+0x138>
    abaa:	89 f0                	mov    eax,esi
    abac:	84 c0                	test   al,al
    abae:	74 3f                	je     abef <_ZN3VGA7putcharEcc+0xaf>
    abb0:	8b 3d 04 00 01 00    	mov    edi,DWORD PTR ds:0x10004
    abb6:	8b 2d 00 00 01 00    	mov    ebp,DWORD PTR ds:0x10000
    abbc:	8d 04 bf             	lea    eax,[edi+edi*4]
    abbf:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    abc5:	c1 e0 04             	shl    eax,0x4
    abc8:	01 e8                	add    eax,ebp
    abca:	88 1c 42             	mov    BYTE PTR [edx+eax*2],bl
    abcd:	a1 04 00 01 00       	mov    eax,ds:0x10004
    abd2:	8b 15 14 f0 00 00    	mov    edx,DWORD PTR ds:0xf014
    abd8:	8d 04 80             	lea    eax,[eax+eax*4]
    abdb:	c1 e0 04             	shl    eax,0x4
    abde:	03 05 00 00 01 00    	add    eax,DWORD PTR ds:0x10000
    abe4:	88 4c 42 01          	mov    BYTE PTR [edx+eax*2+0x1],cl
    abe8:	83 05 00 00 01 00 01 	add    DWORD PTR ds:0x10000,0x1
    abef:	83 c4 1c             	add    esp,0x1c
    abf2:	5b                   	pop    ebx
    abf3:	5e                   	pop    esi
    abf4:	5f                   	pop    edi
    abf5:	5d                   	pop    ebp
    abf6:	e9 65 fd ff ff       	jmp    a960 <_ZN3VGA17_actualize_cursorEv>
    abfb:	90                   	nop
    abfc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ac00:	80 fb 0d             	cmp    bl,0xd
    ac03:	75 4f                	jne    ac54 <_ZN3VGA7putcharEcc+0x114>
    ac05:	83 ff 18             	cmp    edi,0x18
    ac08:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ac0f:	00 00 00 
    ac12:	7e db                	jle    abef <_ZN3VGA7putcharEcc+0xaf>
    ac14:	83 ec 0c             	sub    esp,0xc
    ac17:	0f be c9             	movsx  ecx,cl
    ac1a:	51                   	push   ecx
    ac1b:	e8 00 fe ff ff       	call   aa20 <_ZN3VGA6scrollEc>
    ac20:	83 c4 10             	add    esp,0x10
    ac23:	83 c4 1c             	add    esp,0x1c
    ac26:	5b                   	pop    ebx
    ac27:	5e                   	pop    esi
    ac28:	5f                   	pop    edi
    ac29:	5d                   	pop    ebp
    ac2a:	e9 31 fd ff ff       	jmp    a960 <_ZN3VGA17_actualize_cursorEv>
    ac2f:	90                   	nop
    ac30:	8d 57 01             	lea    edx,[edi+0x1]
    ac33:	c7 05 00 00 01 00 00 	mov    DWORD PTR ds:0x10000,0x0
    ac3a:	00 00 00 
    ac3d:	83 fa 18             	cmp    edx,0x18
    ac40:	89 15 04 00 01 00    	mov    DWORD PTR ds:0x10004,edx
    ac46:	7f cc                	jg     ac14 <_ZN3VGA7putcharEcc+0xd4>
    ac48:	83 c4 1c             	add    esp,0x1c
    ac4b:	5b                   	pop    ebx
    ac4c:	5e                   	pop    esi
    ac4d:	5f                   	pop    edi
    ac4e:	5d                   	pop    ebp
    ac4f:	e9 0c fd ff ff       	jmp    a960 <_ZN3VGA17_actualize_cursorEv>
    ac54:	8b 2d 00 00 01 00    	mov    ebp,DWORD PTR ds:0x10000
    ac5a:	be 01 00 00 00       	mov    esi,0x1
    ac5f:	83 fd 4f             	cmp    ebp,0x4f
    ac62:	89 ea                	mov    edx,ebp
    ac64:	0f 8f 19 ff ff ff    	jg     ab83 <_ZN3VGA7putcharEcc+0x43>
    ac6a:	83 ff 18             	cmp    edi,0x18
    ac6d:	0f 8e 49 ff ff ff    	jle    abbc <_ZN3VGA7putcharEcc+0x7c>
    ac73:	90                   	nop
    ac74:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ac78:	83 ec 0c             	sub    esp,0xc
    ac7b:	0f be c1             	movsx  eax,cl
    ac7e:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    ac82:	50                   	push   eax
    ac83:	e8 98 fd ff ff       	call   aa20 <_ZN3VGA6scrollEc>
    ac88:	83 c4 10             	add    esp,0x10
    ac8b:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    ac8f:	e9 16 ff ff ff       	jmp    abaa <_ZN3VGA7putcharEcc+0x6a>
    ac94:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ac98:	83 ff 18             	cmp    edi,0x18
    ac9b:	0f 8e 4e ff ff ff    	jle    abef <_ZN3VGA7putcharEcc+0xaf>
    aca1:	eb d5                	jmp    ac78 <_ZN3VGA7putcharEcc+0x138>
    aca3:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    aca9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000acb0 <_ZN3VGA5printEPKcc>:
    acb0:	53                   	push   ebx
    acb1:	83 ec 08             	sub    esp,0x8
    acb4:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    acb8:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    acbb:	84 c0                	test   al,al
    acbd:	74 22                	je     ace1 <_ZN3VGA5printEPKcc+0x31>
    acbf:	83 c3 01             	add    ebx,0x1
    acc2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    acc8:	83 ec 08             	sub    esp,0x8
    accb:	83 c3 01             	add    ebx,0x1
    acce:	6a 0f                	push   0xf
    acd0:	50                   	push   eax
    acd1:	e8 6a fe ff ff       	call   ab40 <_ZN3VGA7putcharEcc>
    acd6:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    acda:	83 c4 10             	add    esp,0x10
    acdd:	84 c0                	test   al,al
    acdf:	75 e7                	jne    acc8 <_ZN3VGA5printEPKcc+0x18>
    ace1:	83 c4 08             	add    esp,0x8
    ace4:	5b                   	pop    ebx
    ace5:	c3                   	ret    
    ace6:	8d 76 00             	lea    esi,[esi+0x0]
    ace9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000acf0 <_ZN3VGA17_put_nbr_base_recEii>:
    acf0:	53                   	push   ebx
    acf1:	83 ec 08             	sub    esp,0x8
    acf4:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    acf8:	8b 4c 24 14          	mov    ecx,DWORD PTR [esp+0x14]
    acfc:	85 c0                	test   eax,eax
    acfe:	75 08                	jne    ad08 <_ZN3VGA17_put_nbr_base_recEii+0x18>
    ad00:	83 c4 08             	add    esp,0x8
    ad03:	5b                   	pop    ebx
    ad04:	c3                   	ret    
    ad05:	8d 76 00             	lea    esi,[esi+0x0]
    ad08:	99                   	cdq    
    ad09:	83 ec 08             	sub    esp,0x8
    ad0c:	f7 f9                	idiv   ecx
    ad0e:	51                   	push   ecx
    ad0f:	50                   	push   eax
    ad10:	89 d3                	mov    ebx,edx
    ad12:	e8 d9 ff ff ff       	call   acf0 <_ZN3VGA17_put_nbr_base_recEii>
    ad17:	0f be 83 00 f0 00 00 	movsx  eax,BYTE PTR [ebx+0xf000]
    ad1e:	c7 44 24 24 0f 00 00 	mov    DWORD PTR [esp+0x24],0xf
    ad25:	00 
    ad26:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    ad2a:	83 c4 18             	add    esp,0x18
    ad2d:	5b                   	pop    ebx
    ad2e:	e9 0d fe ff ff       	jmp    ab40 <_ZN3VGA7putcharEcc>
    ad33:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ad39:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ad40 <_ZN3VGA13_put_nbr_baseEii>:
    ad40:	56                   	push   esi
    ad41:	53                   	push   ebx
    ad42:	83 ec 14             	sub    esp,0x14
    ad45:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    ad49:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    ad4d:	85 c0                	test   eax,eax
    ad4f:	78 4f                	js     ada0 <_ZN3VGA13_put_nbr_baseEii+0x60>
    ad51:	74 2d                	je     ad80 <_ZN3VGA13_put_nbr_baseEii+0x40>
    ad53:	99                   	cdq    
    ad54:	83 ec 08             	sub    esp,0x8
    ad57:	f7 fb                	idiv   ebx
    ad59:	53                   	push   ebx
    ad5a:	50                   	push   eax
    ad5b:	89 d6                	mov    esi,edx
    ad5d:	e8 8e ff ff ff       	call   acf0 <_ZN3VGA17_put_nbr_base_recEii>
    ad62:	0f be 86 00 f0 00 00 	movsx  eax,BYTE PTR [esi+0xf000]
    ad69:	c7 44 24 34 0f 00 00 	mov    DWORD PTR [esp+0x34],0xf
    ad70:	00 
    ad71:	89 44 24 30          	mov    DWORD PTR [esp+0x30],eax
    ad75:	83 c4 24             	add    esp,0x24
    ad78:	5b                   	pop    ebx
    ad79:	5e                   	pop    esi
    ad7a:	e9 c1 fd ff ff       	jmp    ab40 <_ZN3VGA7putcharEcc>
    ad7f:	90                   	nop
    ad80:	0f be 05 00 f0 00 00 	movsx  eax,BYTE PTR ds:0xf000
    ad87:	c7 44 24 24 0f 00 00 	mov    DWORD PTR [esp+0x24],0xf
    ad8e:	00 
    ad8f:	89 44 24 20          	mov    DWORD PTR [esp+0x20],eax
    ad93:	83 c4 14             	add    esp,0x14
    ad96:	5b                   	pop    ebx
    ad97:	5e                   	pop    esi
    ad98:	e9 a3 fd ff ff       	jmp    ab40 <_ZN3VGA7putcharEcc>
    ad9d:	8d 76 00             	lea    esi,[esi+0x0]
    ada0:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    ada4:	83 ec 08             	sub    esp,0x8
    ada7:	6a 0f                	push   0xf
    ada9:	6a 2d                	push   0x2d
    adab:	e8 90 fd ff ff       	call   ab40 <_ZN3VGA7putcharEcc>
    adb0:	83 c4 10             	add    esp,0x10
    adb3:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    adb7:	eb 9a                	jmp    ad53 <_ZN3VGA13_put_nbr_baseEii+0x13>
    adb9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000adc0 <_ZN3VGA6putHexEi>:
    adc0:	83 ec 14             	sub    esp,0x14
    adc3:	6a 10                	push   0x10
    adc5:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    adc9:	e8 72 ff ff ff       	call   ad40 <_ZN3VGA13_put_nbr_baseEii>
    adce:	83 c4 1c             	add    esp,0x1c
    add1:	c3                   	ret    
    add2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    add9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ade0 <_ZN3VGA6putDecEi>:
    ade0:	83 ec 14             	sub    esp,0x14
    ade3:	6a 0a                	push   0xa
    ade5:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    ade9:	e8 52 ff ff ff       	call   ad40 <_ZN3VGA13_put_nbr_baseEii>
    adee:	83 c4 1c             	add    esp,0x1c
    adf1:	c3                   	ret    
    adf2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    adf9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ae00 <_ZN3VGA6putOctEi>:
    ae00:	83 ec 14             	sub    esp,0x14
    ae03:	6a 08                	push   0x8
    ae05:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    ae09:	e8 32 ff ff ff       	call   ad40 <_ZN3VGA13_put_nbr_baseEii>
    ae0e:	83 c4 1c             	add    esp,0x1c
    ae11:	c3                   	ret    
    ae12:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ae19:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ae20 <_ZN3VGA6putBinEi>:
    ae20:	83 ec 14             	sub    esp,0x14
    ae23:	6a 02                	push   0x2
    ae25:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    ae29:	e8 12 ff ff ff       	call   ad40 <_ZN3VGA13_put_nbr_baseEii>
    ae2e:	83 c4 1c             	add    esp,0x1c
    ae31:	c3                   	ret    
    ae32:	66 90                	xchg   ax,ax
    ae34:	66 90                	xchg   ax,ax
    ae36:	66 90                	xchg   ax,ax
    ae38:	66 90                	xchg   ax,ax
    ae3a:	66 90                	xchg   ax,ax
    ae3c:	66 90                	xchg   ax,ax
    ae3e:	66 90                	xchg   ax,ax

0000ae40 <_Z12clear_screenv>:
    ae40:	83 ec 18             	sub    esp,0x18
    ae43:	6a 0f                	push   0xf
    ae45:	e8 96 fc ff ff       	call   aae0 <_ZN3VGA12clear_screenEc>
    ae4a:	83 c4 1c             	add    esp,0x1c
    ae4d:	c3                   	ret    
    ae4e:	66 90                	xchg   ax,ax

0000ae50 <_Z7putcharc>:
    ae50:	83 ec 14             	sub    esp,0x14
    ae53:	6a 0f                	push   0xf
    ae55:	0f be 44 24 1c       	movsx  eax,BYTE PTR [esp+0x1c]
    ae5a:	50                   	push   eax
    ae5b:	e8 e0 fc ff ff       	call   ab40 <_ZN3VGA7putcharEcc>
    ae60:	83 c4 1c             	add    esp,0x1c
    ae63:	c3                   	ret    
    ae64:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ae6a:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000ae70 <_Z6putdeci>:
    ae70:	e9 6b ff ff ff       	jmp    ade0 <_ZN3VGA6putDecEi>
    ae75:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ae79:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ae80 <_Z6puthexi>:
    ae80:	e9 3b ff ff ff       	jmp    adc0 <_ZN3VGA6putHexEi>
    ae85:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ae89:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000ae90 <_Z6putocti>:
    ae90:	e9 6b ff ff ff       	jmp    ae00 <_ZN3VGA6putOctEi>
    ae95:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ae99:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000aea0 <_Z6putbini>:
    aea0:	e9 7b ff ff ff       	jmp    ae20 <_ZN3VGA6putBinEi>
    aea5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    aea9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000aeb0 <_Z6putstrPc>:
    aeb0:	83 ec 14             	sub    esp,0x14
    aeb3:	6a 0f                	push   0xf
    aeb5:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    aeb9:	e8 f2 fd ff ff       	call   acb0 <_ZN3VGA5printEPKcc>
    aebe:	83 c4 1c             	add    esp,0x1c
    aec1:	c3                   	ret    
    aec2:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    aec9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000aed0 <_Z6printfPKc>:
    aed0:	53                   	push   ebx
    aed1:	83 ec 08             	sub    esp,0x8
    aed4:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    aed8:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    aedb:	84 c0                	test   al,al
    aedd:	74 22                	je     af01 <_Z6printfPKc+0x31>
    aedf:	83 c3 01             	add    ebx,0x1
    aee2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    aee8:	83 ec 08             	sub    esp,0x8
    aeeb:	83 c3 01             	add    ebx,0x1
    aeee:	6a 0f                	push   0xf
    aef0:	50                   	push   eax
    aef1:	e8 4a fc ff ff       	call   ab40 <_ZN3VGA7putcharEcc>
    aef6:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    aefa:	83 c4 10             	add    esp,0x10
    aefd:	84 c0                	test   al,al
    aeff:	75 e7                	jne    aee8 <_Z6printfPKc+0x18>
    af01:	83 c4 08             	add    esp,0x8
    af04:	5b                   	pop    ebx
    af05:	c3                   	ret    
    af06:	66 90                	xchg   ax,ax
    af08:	66 90                	xchg   ax,ax
    af0a:	66 90                	xchg   ax,ax
    af0c:	66 90                	xchg   ax,ax
    af0e:	66 90                	xchg   ax,ax

0000af10 <_Z4outbth>:
    af10:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    af14:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    af18:	ee                   	out    dx,al
    af19:	c3                   	ret    
    af1a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000af20 <_Z4outwtt>:
    af20:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    af24:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    af28:	66 ef                	out    dx,ax
    af2a:	c3                   	ret    
    af2b:	90                   	nop
    af2c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000af30 <_Z4outdtj>:
    af30:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    af34:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    af38:	ef                   	out    dx,eax
    af39:	c3                   	ret    
    af3a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000af40 <_Z4inwstjj>:
    af40:	57                   	push   edi
    af41:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    af45:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    af49:	8b 7c 24 0c          	mov    edi,DWORD PTR [esp+0xc]
    af4d:	fc                   	cld    
    af4e:	f3 6d                	rep ins DWORD PTR es:[edi],dx
    af50:	5f                   	pop    edi
    af51:	c3                   	ret    
    af52:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    af59:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000af60 <_Z3inbt>:
    af60:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    af64:	ec                   	in     al,dx
    af65:	c3                   	ret    
    af66:	8d 76 00             	lea    esi,[esi+0x0]
    af69:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000af70 <_Z3inwt>:
    af70:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    af74:	66 ed                	in     ax,dx
    af76:	c3                   	ret    
    af77:	89 f6                	mov    esi,esi
    af79:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000af80 <_Z3indt>:
    af80:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    af84:	ed                   	in     eax,dx
    af85:	c3                   	ret    
    af86:	8d 76 00             	lea    esi,[esi+0x0]
    af89:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000af90 <_Z7io_waitv>:
    af90:	31 c0                	xor    eax,eax
    af92:	e6 80                	out    0x80,al
    af94:	c3                   	ret    
    af95:	66 90                	xchg   ax,ax
    af97:	66 90                	xchg   ax,ax
    af99:	66 90                	xchg   ax,ax
    af9b:	66 90                	xchg   ax,ax
    af9d:	66 90                	xchg   ax,ax
    af9f:	90                   	nop

0000afa0 <_ZN3pci13configAddressEhhhh>:
    afa0:	0f b6 44 24 10       	movzx  eax,BYTE PTR [esp+0x10]
    afa5:	0f b6 54 24 0c       	movzx  edx,BYTE PTR [esp+0xc]
    afaa:	c1 e0 02             	shl    eax,0x2
    afad:	c1 e2 08             	shl    edx,0x8
    afb0:	0f b6 c0             	movzx  eax,al
    afb3:	09 d0                	or     eax,edx
    afb5:	0f b6 54 24 08       	movzx  edx,BYTE PTR [esp+0x8]
    afba:	c1 e2 0b             	shl    edx,0xb
    afbd:	09 d0                	or     eax,edx
    afbf:	0f b6 54 24 04       	movzx  edx,BYTE PTR [esp+0x4]
    afc4:	c1 e2 10             	shl    edx,0x10
    afc7:	09 d0                	or     eax,edx
    afc9:	0d 00 00 00 80       	or     eax,0x80000000
    afce:	c3                   	ret    
    afcf:	90                   	nop

0000afd0 <_ZN3pci14configReadByteEhhhhh>:
    afd0:	53                   	push   ebx
    afd1:	83 ec 10             	sub    esp,0x10
    afd4:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    afd9:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    afde:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    afe2:	c1 e2 0b             	shl    edx,0xb
    afe5:	c1 e0 10             	shl    eax,0x10
    afe8:	09 d0                	or     eax,edx
    afea:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    afef:	c1 e2 08             	shl    edx,0x8
    aff2:	09 d0                	or     eax,edx
    aff4:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    aff9:	c1 e2 02             	shl    edx,0x2
    affc:	0f b6 d2             	movzx  edx,dl
    afff:	09 d0                	or     eax,edx
    b001:	0d 00 00 00 80       	or     eax,0x80000000
    b006:	50                   	push   eax
    b007:	68 f8 0c 00 00       	push   0xcf8
    b00c:	e8 1f ff ff ff       	call   af30 <_Z4outdtj>
    b011:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    b018:	e8 63 ff ff ff       	call   af80 <_Z3indt>
    b01d:	0f b6 cb             	movzx  ecx,bl
    b020:	83 c4 18             	add    esp,0x18
    b023:	c1 e1 03             	shl    ecx,0x3
    b026:	d3 e8                	shr    eax,cl
    b028:	5b                   	pop    ebx
    b029:	c3                   	ret    
    b02a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b030 <_ZN3pci14configReadWordEhhhhh>:
    b030:	53                   	push   ebx
    b031:	83 ec 10             	sub    esp,0x10
    b034:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b039:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b03e:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    b042:	c1 e2 0b             	shl    edx,0xb
    b045:	c1 e0 10             	shl    eax,0x10
    b048:	09 d0                	or     eax,edx
    b04a:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b04f:	c1 e2 08             	shl    edx,0x8
    b052:	09 d0                	or     eax,edx
    b054:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b059:	c1 e2 02             	shl    edx,0x2
    b05c:	0f b6 d2             	movzx  edx,dl
    b05f:	09 d0                	or     eax,edx
    b061:	0d 00 00 00 80       	or     eax,0x80000000
    b066:	50                   	push   eax
    b067:	68 f8 0c 00 00       	push   0xcf8
    b06c:	e8 bf fe ff ff       	call   af30 <_Z4outdtj>
    b071:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    b078:	e8 03 ff ff ff       	call   af80 <_Z3indt>
    b07d:	0f b6 cb             	movzx  ecx,bl
    b080:	83 c4 18             	add    esp,0x18
    b083:	c1 e1 04             	shl    ecx,0x4
    b086:	d3 e8                	shr    eax,cl
    b088:	5b                   	pop    ebx
    b089:	c3                   	ret    
    b08a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000b090 <_ZN3pci10configReadEhhhh>:
    b090:	83 ec 14             	sub    esp,0x14
    b093:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    b098:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    b09d:	c1 e0 10             	shl    eax,0x10
    b0a0:	c1 e2 0b             	shl    edx,0xb
    b0a3:	09 d0                	or     eax,edx
    b0a5:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    b0aa:	c1 e2 08             	shl    edx,0x8
    b0ad:	09 d0                	or     eax,edx
    b0af:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    b0b4:	c1 e2 02             	shl    edx,0x2
    b0b7:	0f b6 d2             	movzx  edx,dl
    b0ba:	09 d0                	or     eax,edx
    b0bc:	0d 00 00 00 80       	or     eax,0x80000000
    b0c1:	50                   	push   eax
    b0c2:	68 f8 0c 00 00       	push   0xcf8
    b0c7:	e8 64 fe ff ff       	call   af30 <_Z4outdtj>
    b0cc:	c7 44 24 20 fc 0c 00 	mov    DWORD PTR [esp+0x20],0xcfc
    b0d3:	00 
    b0d4:	83 c4 1c             	add    esp,0x1c
    b0d7:	e9 a4 fe ff ff       	jmp    af80 <_Z3indt>
    b0dc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000b0e0 <_ZN3pci11checkDeviceEhhh>:
    b0e0:	83 ec 18             	sub    esp,0x18
    b0e3:	6a 00                	push   0x0
    b0e5:	6a 00                	push   0x0
    b0e7:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b0ec:	50                   	push   eax
    b0ed:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b0f2:	50                   	push   eax
    b0f3:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b0f8:	50                   	push   eax
    b0f9:	e8 32 ff ff ff       	call   b030 <_ZN3pci14configReadWordEhhhhh>
    b0fe:	66 83 f8 ff          	cmp    ax,0xffff
    b102:	0f 95 c0             	setne  al
    b105:	83 c4 2c             	add    esp,0x2c
    b108:	c3                   	ret    
    b109:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b110 <_ZN3pci11printBussesEv>:
    b110:	55                   	push   ebp
    b111:	57                   	push   edi
    b112:	56                   	push   esi
    b113:	53                   	push   ebx
    b114:	83 ec 4c             	sub    esp,0x4c
    b117:	c7 44 24 10 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    b11e:	00 
    b11f:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    b126:	00 
    b127:	89 f6                	mov    esi,esi
    b129:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b130:	31 f6                	xor    esi,esi
    b132:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b138:	83 ec 0c             	sub    esp,0xc
    b13b:	6a 00                	push   0x0
    b13d:	6a 00                	push   0x0
    b13f:	8b 5c 24 24          	mov    ebx,DWORD PTR [esp+0x24]
    b143:	53                   	push   ebx
    b144:	56                   	push   esi
    b145:	8b 7c 24 28          	mov    edi,DWORD PTR [esp+0x28]
    b149:	57                   	push   edi
    b14a:	e8 e1 fe ff ff       	call   b030 <_ZN3pci14configReadWordEhhhhh>
    b14f:	83 c4 20             	add    esp,0x20
    b152:	66 83 f8 ff          	cmp    ax,0xffff
    b156:	0f 84 8c 01 00 00    	je     b2e8 <_ZN3pci11printBussesEv+0x1d8>
    b15c:	83 ec 0c             	sub    esp,0xc
    b15f:	6a 01                	push   0x1
    b161:	6a 02                	push   0x2
    b163:	53                   	push   ebx
    b164:	56                   	push   esi
    b165:	57                   	push   edi
    b166:	e8 c5 fe ff ff       	call   b030 <_ZN3pci14configReadWordEhhhhh>
    b16b:	83 c4 14             	add    esp,0x14
    b16e:	6a 00                	push   0x0
    b170:	6a 02                	push   0x2
    b172:	53                   	push   ebx
    b173:	56                   	push   esi
    b174:	57                   	push   edi
    b175:	e8 b6 fe ff ff       	call   b030 <_ZN3pci14configReadWordEhhhhh>
    b17a:	83 c4 14             	add    esp,0x14
    b17d:	6a 00                	push   0x0
    b17f:	6a 02                	push   0x2
    b181:	53                   	push   ebx
    b182:	56                   	push   esi
    b183:	57                   	push   edi
    b184:	e8 47 fe ff ff       	call   afd0 <_ZN3pci14configReadByteEhhhhh>
    b189:	88 44 24 3c          	mov    BYTE PTR [esp+0x3c],al
    b18d:	83 c4 14             	add    esp,0x14
    b190:	6a 01                	push   0x1
    b192:	6a 02                	push   0x2
    b194:	53                   	push   ebx
    b195:	56                   	push   esi
    b196:	57                   	push   edi
    b197:	e8 34 fe ff ff       	call   afd0 <_ZN3pci14configReadByteEhhhhh>
    b19c:	88 44 24 3b          	mov    BYTE PTR [esp+0x3b],al
    b1a0:	83 c4 14             	add    esp,0x14
    b1a3:	6a 02                	push   0x2
    b1a5:	6a 02                	push   0x2
    b1a7:	53                   	push   ebx
    b1a8:	56                   	push   esi
    b1a9:	57                   	push   edi
    b1aa:	e8 21 fe ff ff       	call   afd0 <_ZN3pci14configReadByteEhhhhh>
    b1af:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    b1b3:	83 c4 14             	add    esp,0x14
    b1b6:	6a 03                	push   0x3
    b1b8:	6a 02                	push   0x2
    b1ba:	53                   	push   ebx
    b1bb:	56                   	push   esi
    b1bc:	57                   	push   edi
    b1bd:	31 ff                	xor    edi,edi
    b1bf:	e8 0c fe ff ff       	call   afd0 <_ZN3pci14configReadByteEhhhhh>
    b1c4:	ba 43 00 00 00       	mov    edx,0x43
    b1c9:	88 44 24 4f          	mov    BYTE PTR [esp+0x4f],al
    b1cd:	83 c4 20             	add    esp,0x20
    b1d0:	eb 29                	jmp    b1fb <_ZN3pci11printBussesEv+0xeb>
    b1d2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b1d8:	3c 25                	cmp    al,0x25
    b1da:	0f 84 d0 03 00 00    	je     b5b0 <_ZN3pci11printBussesEv+0x4a0>
    b1e0:	84 c0                	test   al,al
    b1e2:	0f 85 e0 01 00 00    	jne    b3c8 <_ZN3pci11printBussesEv+0x2b8>
    b1e8:	8d 5f 02             	lea    ebx,[edi+0x2]
    b1eb:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b1f2:	84 c0                	test   al,al
    b1f4:	74 3a                	je     b230 <_ZN3pci11printBussesEv+0x120>
    b1f6:	0f be d0             	movsx  edx,al
    b1f9:	89 df                	mov    edi,ebx
    b1fb:	8d 5f 01             	lea    ebx,[edi+0x1]
    b1fe:	80 fa 25             	cmp    dl,0x25
    b201:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b208:	8d 8b a8 d1 00 00    	lea    ecx,[ebx+0xd1a8]
    b20e:	74 c8                	je     b1d8 <_ZN3pci11printBussesEv+0xc8>
    b210:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    b214:	83 ec 0c             	sub    esp,0xc
    b217:	52                   	push   edx
    b218:	e8 33 fc ff ff       	call   ae50 <_Z7putcharc>
    b21d:	83 c4 10             	add    esp,0x10
    b220:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    b225:	84 c0                	test   al,al
    b227:	75 cd                	jne    b1f6 <_ZN3pci11printBussesEv+0xe6>
    b229:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b230:	6a 04                	push   0x4
    b232:	8b 5c 24 14          	mov    ebx,DWORD PTR [esp+0x14]
    b236:	53                   	push   ebx
    b237:	56                   	push   esi
    b238:	8b 7c 24 18          	mov    edi,DWORD PTR [esp+0x18]
    b23c:	57                   	push   edi
    b23d:	e8 4e fe ff ff       	call   b090 <_ZN3pci10configReadEhhhh>
    b242:	c7 04 24 03 00 00 00 	mov    DWORD PTR [esp],0x3
    b249:	89 44 24 2c          	mov    DWORD PTR [esp+0x2c],eax
    b24d:	6a 03                	push   0x3
    b24f:	53                   	push   ebx
    b250:	56                   	push   esi
    b251:	57                   	push   edi
    b252:	e8 79 fd ff ff       	call   afd0 <_ZN3pci14configReadByteEhhhhh>
    b257:	88 44 24 3b          	mov    BYTE PTR [esp+0x3b],al
    b25b:	83 c4 14             	add    esp,0x14
    b25e:	6a 01                	push   0x1
    b260:	6a 00                	push   0x0
    b262:	53                   	push   ebx
    b263:	56                   	push   esi
    b264:	57                   	push   edi
    b265:	e8 c6 fd ff ff       	call   b030 <_ZN3pci14configReadWordEhhhhh>
    b26a:	66 89 44 24 34       	mov    WORD PTR [esp+0x34],ax
    b26f:	83 c4 14             	add    esp,0x14
    b272:	6a 00                	push   0x0
    b274:	6a 00                	push   0x0
    b276:	53                   	push   ebx
    b277:	56                   	push   esi
    b278:	57                   	push   edi
    b279:	31 ff                	xor    edi,edi
    b27b:	e8 b0 fd ff ff       	call   b030 <_ZN3pci14configReadWordEhhhhh>
    b280:	ba 56 00 00 00       	mov    edx,0x56
    b285:	66 89 44 24 54       	mov    WORD PTR [esp+0x54],ax
    b28a:	83 c4 20             	add    esp,0x20
    b28d:	eb 24                	jmp    b2b3 <_ZN3pci11printBussesEv+0x1a3>
    b28f:	90                   	nop
    b290:	3c 25                	cmp    al,0x25
    b292:	0f 84 e0 02 00 00    	je     b578 <_ZN3pci11printBussesEv+0x468>
    b298:	84 c0                	test   al,al
    b29a:	0f 85 90 00 00 00    	jne    b330 <_ZN3pci11printBussesEv+0x220>
    b2a0:	8d 5f 02             	lea    ebx,[edi+0x2]
    b2a3:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b2aa:	84 c0                	test   al,al
    b2ac:	74 3a                	je     b2e8 <_ZN3pci11printBussesEv+0x1d8>
    b2ae:	0f be d0             	movsx  edx,al
    b2b1:	89 df                	mov    edi,ebx
    b2b3:	8d 5f 01             	lea    ebx,[edi+0x1]
    b2b6:	80 fa 25             	cmp    dl,0x25
    b2b9:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b2c0:	8d 8b ec d1 00 00    	lea    ecx,[ebx+0xd1ec]
    b2c6:	74 c8                	je     b290 <_ZN3pci11printBussesEv+0x180>
    b2c8:	88 44 24 08          	mov    BYTE PTR [esp+0x8],al
    b2cc:	83 ec 0c             	sub    esp,0xc
    b2cf:	52                   	push   edx
    b2d0:	e8 7b fb ff ff       	call   ae50 <_Z7putcharc>
    b2d5:	83 c4 10             	add    esp,0x10
    b2d8:	0f b6 44 24 08       	movzx  eax,BYTE PTR [esp+0x8]
    b2dd:	84 c0                	test   al,al
    b2df:	75 cd                	jne    b2ae <_ZN3pci11printBussesEv+0x19e>
    b2e1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b2e8:	83 c6 01             	add    esi,0x1
    b2eb:	83 fe 20             	cmp    esi,0x20
    b2ee:	0f 85 44 fe ff ff    	jne    b138 <_ZN3pci11printBussesEv+0x28>
    b2f4:	83 44 24 0c 01       	add    DWORD PTR [esp+0xc],0x1
    b2f9:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b2fd:	3d 00 01 00 00       	cmp    eax,0x100
    b302:	0f 85 28 fe ff ff    	jne    b130 <_ZN3pci11printBussesEv+0x20>
    b308:	83 44 24 10 01       	add    DWORD PTR [esp+0x10],0x1
    b30d:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    b311:	83 f8 03             	cmp    eax,0x3
    b314:	0f 85 05 fe ff ff    	jne    b11f <_ZN3pci11printBussesEv+0xf>
    b31a:	83 ec 0c             	sub    esp,0xc
    b31d:	68 69 d1 00 00       	push   0xd169
    b322:	e8 a9 fb ff ff       	call   aed0 <_Z6printfPKc>
    b327:	83 c4 5c             	add    esp,0x5c
    b32a:	5b                   	pop    ebx
    b32b:	5e                   	pop    esi
    b32c:	5f                   	pop    edi
    b32d:	5d                   	pop    ebp
    b32e:	c3                   	ret    
    b32f:	90                   	nop
    b330:	83 ec 08             	sub    esp,0x8
    b333:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    b337:	50                   	push   eax
    b338:	51                   	push   ecx
    b339:	e8 62 0a 00 00       	call   bda0 <_Z14_manage_escapeItEiPKcPT_>
    b33e:	01 c3                	add    ebx,eax
    b340:	0f b7 44 24 24       	movzx  eax,WORD PTR [esp+0x24]
    b345:	0f be 93 ec d1 00 00 	movsx  edx,BYTE PTR [ebx+0xd1ec]
    b34c:	8d ab ec d1 00 00    	lea    ebp,[ebx+0xd1ec]
    b352:	66 89 44 24 46       	mov    WORD PTR [esp+0x46],ax
    b357:	83 c4 10             	add    esp,0x10
    b35a:	84 d2                	test   dl,dl
    b35c:	74 8a                	je     b2e8 <_ZN3pci11printBussesEv+0x1d8>
    b35e:	31 ff                	xor    edi,edi
    b360:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b364:	89 ee                	mov    esi,ebp
    b366:	89 fd                	mov    ebp,edi
    b368:	eb 28                	jmp    b392 <_ZN3pci11printBussesEv+0x282>
    b36a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b370:	80 fb 25             	cmp    bl,0x25
    b373:	0f 84 a7 03 00 00    	je     b720 <_ZN3pci11printBussesEv+0x610>
    b379:	84 db                	test   bl,bl
    b37b:	0f 85 d7 00 00 00    	jne    b458 <_ZN3pci11printBussesEv+0x348>
    b381:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b386:	8d 7d 02             	lea    edi,[ebp+0x2]
    b389:	84 db                	test   bl,bl
    b38b:	74 23                	je     b3b0 <_ZN3pci11printBussesEv+0x2a0>
    b38d:	0f be d3             	movsx  edx,bl
    b390:	89 fd                	mov    ebp,edi
    b392:	8d 7d 01             	lea    edi,[ebp+0x1]
    b395:	80 fa 25             	cmp    dl,0x25
    b398:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b39b:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b39e:	74 d0                	je     b370 <_ZN3pci11printBussesEv+0x260>
    b3a0:	83 ec 0c             	sub    esp,0xc
    b3a3:	52                   	push   edx
    b3a4:	e8 a7 fa ff ff       	call   ae50 <_Z7putcharc>
    b3a9:	83 c4 10             	add    esp,0x10
    b3ac:	84 db                	test   bl,bl
    b3ae:	75 dd                	jne    b38d <_ZN3pci11printBussesEv+0x27d>
    b3b0:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b3b4:	83 c6 01             	add    esi,0x1
    b3b7:	83 fe 20             	cmp    esi,0x20
    b3ba:	0f 85 78 fd ff ff    	jne    b138 <_ZN3pci11printBussesEv+0x28>
    b3c0:	e9 2f ff ff ff       	jmp    b2f4 <_ZN3pci11printBussesEv+0x1e4>
    b3c5:	8d 76 00             	lea    esi,[esi+0x0]
    b3c8:	83 ec 08             	sub    esp,0x8
    b3cb:	8d 44 24 37          	lea    eax,[esp+0x37]
    b3cf:	50                   	push   eax
    b3d0:	51                   	push   ecx
    b3d1:	e8 0a 0d 00 00       	call   c0e0 <_Z14_manage_escapeIhEiPKcPT_>
    b3d6:	01 c3                	add    ebx,eax
    b3d8:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    b3dd:	0f be 93 a8 d1 00 00 	movsx  edx,BYTE PTR [ebx+0xd1a8]
    b3e4:	8d ab a8 d1 00 00    	lea    ebp,[ebx+0xd1a8]
    b3ea:	88 44 24 40          	mov    BYTE PTR [esp+0x40],al
    b3ee:	83 c4 10             	add    esp,0x10
    b3f1:	84 d2                	test   dl,dl
    b3f3:	0f 84 37 fe ff ff    	je     b230 <_ZN3pci11printBussesEv+0x120>
    b3f9:	31 ff                	xor    edi,edi
    b3fb:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b3ff:	89 ee                	mov    esi,ebp
    b401:	89 fd                	mov    ebp,edi
    b403:	eb 25                	jmp    b42a <_ZN3pci11printBussesEv+0x31a>
    b405:	8d 76 00             	lea    esi,[esi+0x0]
    b408:	80 fb 25             	cmp    bl,0x25
    b40b:	0f 84 df 02 00 00    	je     b6f0 <_ZN3pci11printBussesEv+0x5e0>
    b411:	84 db                	test   bl,bl
    b413:	0f 85 cf 00 00 00    	jne    b4e8 <_ZN3pci11printBussesEv+0x3d8>
    b419:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b41e:	8d 7d 02             	lea    edi,[ebp+0x2]
    b421:	84 db                	test   bl,bl
    b423:	74 23                	je     b448 <_ZN3pci11printBussesEv+0x338>
    b425:	0f be d3             	movsx  edx,bl
    b428:	89 fd                	mov    ebp,edi
    b42a:	8d 7d 01             	lea    edi,[ebp+0x1]
    b42d:	80 fa 25             	cmp    dl,0x25
    b430:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b433:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b436:	74 d0                	je     b408 <_ZN3pci11printBussesEv+0x2f8>
    b438:	83 ec 0c             	sub    esp,0xc
    b43b:	52                   	push   edx
    b43c:	e8 0f fa ff ff       	call   ae50 <_Z7putcharc>
    b441:	83 c4 10             	add    esp,0x10
    b444:	84 db                	test   bl,bl
    b446:	75 dd                	jne    b425 <_ZN3pci11printBussesEv+0x315>
    b448:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b44c:	e9 df fd ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    b451:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b458:	83 ec 08             	sub    esp,0x8
    b45b:	89 f5                	mov    ebp,esi
    b45d:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b461:	8d 44 24 3e          	lea    eax,[esp+0x3e]
    b465:	89 fb                	mov    ebx,edi
    b467:	50                   	push   eax
    b468:	51                   	push   ecx
    b469:	e8 32 09 00 00       	call   bda0 <_Z14_manage_escapeItEiPKcPT_>
    b46e:	01 c3                	add    ebx,eax
    b470:	0f b6 44 24 2b       	movzx  eax,BYTE PTR [esp+0x2b]
    b475:	01 eb                	add    ebx,ebp
    b477:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    b47a:	88 44 24 43          	mov    BYTE PTR [esp+0x43],al
    b47e:	83 c4 10             	add    esp,0x10
    b481:	84 d2                	test   dl,dl
    b483:	0f 84 5f fe ff ff    	je     b2e8 <_ZN3pci11printBussesEv+0x1d8>
    b489:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b48d:	31 ed                	xor    ebp,ebp
    b48f:	89 de                	mov    esi,ebx
    b491:	eb 2b                	jmp    b4be <_ZN3pci11printBussesEv+0x3ae>
    b493:	90                   	nop
    b494:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b498:	80 fb 25             	cmp    bl,0x25
    b49b:	0f 84 ff 03 00 00    	je     b8a0 <_ZN3pci11printBussesEv+0x790>
    b4a1:	84 db                	test   bl,bl
    b4a3:	0f 85 b7 01 00 00    	jne    b660 <_ZN3pci11printBussesEv+0x550>
    b4a9:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b4ae:	8d 7d 02             	lea    edi,[ebp+0x2]
    b4b1:	84 db                	test   bl,bl
    b4b3:	0f 84 f7 fe ff ff    	je     b3b0 <_ZN3pci11printBussesEv+0x2a0>
    b4b9:	0f be d3             	movsx  edx,bl
    b4bc:	89 fd                	mov    ebp,edi
    b4be:	8d 7d 01             	lea    edi,[ebp+0x1]
    b4c1:	80 fa 25             	cmp    dl,0x25
    b4c4:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b4c7:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b4ca:	74 cc                	je     b498 <_ZN3pci11printBussesEv+0x388>
    b4cc:	83 ec 0c             	sub    esp,0xc
    b4cf:	52                   	push   edx
    b4d0:	e8 7b f9 ff ff       	call   ae50 <_Z7putcharc>
    b4d5:	83 c4 10             	add    esp,0x10
    b4d8:	84 db                	test   bl,bl
    b4da:	75 dd                	jne    b4b9 <_ZN3pci11printBussesEv+0x3a9>
    b4dc:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b4e0:	e9 cf fe ff ff       	jmp    b3b4 <_ZN3pci11printBussesEv+0x2a4>
    b4e5:	8d 76 00             	lea    esi,[esi+0x0]
    b4e8:	83 ec 08             	sub    esp,0x8
    b4eb:	89 f5                	mov    ebp,esi
    b4ed:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b4f1:	8d 44 24 38          	lea    eax,[esp+0x38]
    b4f5:	89 fb                	mov    ebx,edi
    b4f7:	50                   	push   eax
    b4f8:	51                   	push   ecx
    b4f9:	e8 e2 0b 00 00       	call   c0e0 <_Z14_manage_escapeIhEiPKcPT_>
    b4fe:	01 c3                	add    ebx,eax
    b500:	0f b6 44 24 2b       	movzx  eax,BYTE PTR [esp+0x2b]
    b505:	01 eb                	add    ebx,ebp
    b507:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    b50a:	88 44 24 41          	mov    BYTE PTR [esp+0x41],al
    b50e:	83 c4 10             	add    esp,0x10
    b511:	84 d2                	test   dl,dl
    b513:	0f 84 17 fd ff ff    	je     b230 <_ZN3pci11printBussesEv+0x120>
    b519:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b51d:	31 ed                	xor    ebp,ebp
    b51f:	89 de                	mov    esi,ebx
    b521:	eb 2b                	jmp    b54e <_ZN3pci11printBussesEv+0x43e>
    b523:	90                   	nop
    b524:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b528:	80 fb 25             	cmp    bl,0x25
    b52b:	0f 84 9f 03 00 00    	je     b8d0 <_ZN3pci11printBussesEv+0x7c0>
    b531:	84 db                	test   bl,bl
    b533:	0f 85 9f 00 00 00    	jne    b5d8 <_ZN3pci11printBussesEv+0x4c8>
    b539:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b53e:	8d 7d 02             	lea    edi,[ebp+0x2]
    b541:	84 db                	test   bl,bl
    b543:	0f 84 ff fe ff ff    	je     b448 <_ZN3pci11printBussesEv+0x338>
    b549:	0f be d3             	movsx  edx,bl
    b54c:	89 fd                	mov    ebp,edi
    b54e:	8d 7d 01             	lea    edi,[ebp+0x1]
    b551:	80 fa 25             	cmp    dl,0x25
    b554:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b557:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b55a:	74 cc                	je     b528 <_ZN3pci11printBussesEv+0x418>
    b55c:	83 ec 0c             	sub    esp,0xc
    b55f:	52                   	push   edx
    b560:	e8 eb f8 ff ff       	call   ae50 <_Z7putcharc>
    b565:	83 c4 10             	add    esp,0x10
    b568:	84 db                	test   bl,bl
    b56a:	75 dd                	jne    b549 <_ZN3pci11printBussesEv+0x439>
    b56c:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b570:	e9 bb fc ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    b575:	8d 76 00             	lea    esi,[esi+0x0]
    b578:	83 ec 0c             	sub    esp,0xc
    b57b:	8d 5f 02             	lea    ebx,[edi+0x2]
    b57e:	6a 25                	push   0x25
    b580:	e8 cb f8 ff ff       	call   ae50 <_Z7putcharc>
    b585:	0f b6 83 ec d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1ec]
    b58c:	83 c4 10             	add    esp,0x10
    b58f:	84 c0                	test   al,al
    b591:	0f 85 17 fd ff ff    	jne    b2ae <_ZN3pci11printBussesEv+0x19e>
    b597:	83 c6 01             	add    esi,0x1
    b59a:	83 fe 20             	cmp    esi,0x20
    b59d:	0f 85 95 fb ff ff    	jne    b138 <_ZN3pci11printBussesEv+0x28>
    b5a3:	e9 4c fd ff ff       	jmp    b2f4 <_ZN3pci11printBussesEv+0x1e4>
    b5a8:	90                   	nop
    b5a9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b5b0:	83 ec 0c             	sub    esp,0xc
    b5b3:	8d 5f 02             	lea    ebx,[edi+0x2]
    b5b6:	6a 25                	push   0x25
    b5b8:	e8 93 f8 ff ff       	call   ae50 <_Z7putcharc>
    b5bd:	0f b6 83 a8 d1 00 00 	movzx  eax,BYTE PTR [ebx+0xd1a8]
    b5c4:	83 c4 10             	add    esp,0x10
    b5c7:	84 c0                	test   al,al
    b5c9:	0f 85 27 fc ff ff    	jne    b1f6 <_ZN3pci11printBussesEv+0xe6>
    b5cf:	e9 5c fc ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    b5d4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b5d8:	83 ec 08             	sub    esp,0x8
    b5db:	89 f3                	mov    ebx,esi
    b5dd:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b5e1:	8d 44 24 39          	lea    eax,[esp+0x39]
    b5e5:	50                   	push   eax
    b5e6:	51                   	push   ecx
    b5e7:	e8 f4 0a 00 00       	call   c0e0 <_Z14_manage_escapeIhEiPKcPT_>
    b5ec:	01 c7                	add    edi,eax
    b5ee:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    b5f3:	8d 14 3b             	lea    edx,[ebx+edi*1]
    b5f6:	88 44 24 42          	mov    BYTE PTR [esp+0x42],al
    b5fa:	0f be 02             	movsx  eax,BYTE PTR [edx]
    b5fd:	83 c4 10             	add    esp,0x10
    b600:	84 c0                	test   al,al
    b602:	0f 84 28 fc ff ff    	je     b230 <_ZN3pci11printBussesEv+0x120>
    b608:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    b60c:	31 ff                	xor    edi,edi
    b60e:	89 d6                	mov    esi,edx
    b610:	eb 28                	jmp    b63a <_ZN3pci11printBussesEv+0x52a>
    b612:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b618:	80 fb 25             	cmp    bl,0x25
    b61b:	0f 84 5f 03 00 00    	je     b980 <_ZN3pci11printBussesEv+0x870>
    b621:	84 db                	test   bl,bl
    b623:	0f 85 e7 01 00 00    	jne    b810 <_ZN3pci11printBussesEv+0x700>
    b629:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    b62e:	8d 6f 02             	lea    ebp,[edi+0x2]
    b631:	84 db                	test   bl,bl
    b633:	74 22                	je     b657 <_ZN3pci11printBussesEv+0x547>
    b635:	0f be c3             	movsx  eax,bl
    b638:	89 ef                	mov    edi,ebp
    b63a:	8d 6f 01             	lea    ebp,[edi+0x1]
    b63d:	3c 25                	cmp    al,0x25
    b63f:	8d 0c 2e             	lea    ecx,[esi+ebp*1]
    b642:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b645:	74 d1                	je     b618 <_ZN3pci11printBussesEv+0x508>
    b647:	83 ec 0c             	sub    esp,0xc
    b64a:	50                   	push   eax
    b64b:	e8 00 f8 ff ff       	call   ae50 <_Z7putcharc>
    b650:	83 c4 10             	add    esp,0x10
    b653:	84 db                	test   bl,bl
    b655:	75 de                	jne    b635 <_ZN3pci11printBussesEv+0x525>
    b657:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b65b:	e9 d0 fb ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    b660:	83 ec 08             	sub    esp,0x8
    b663:	89 f3                	mov    ebx,esi
    b665:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    b669:	8d 44 24 3b          	lea    eax,[esp+0x3b]
    b66d:	50                   	push   eax
    b66e:	51                   	push   ecx
    b66f:	e8 6c 0a 00 00       	call   c0e0 <_Z14_manage_escapeIhEiPKcPT_>
    b674:	01 c7                	add    edi,eax
    b676:	83 c4 10             	add    esp,0x10
    b679:	01 fb                	add    ebx,edi
    b67b:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    b67e:	84 d2                	test   dl,dl
    b680:	0f 84 62 fc ff ff    	je     b2e8 <_ZN3pci11printBussesEv+0x1d8>
    b686:	31 c9                	xor    ecx,ecx
    b688:	89 dd                	mov    ebp,ebx
    b68a:	eb 2c                	jmp    b6b8 <_ZN3pci11printBussesEv+0x5a8>
    b68c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b690:	8d 79 02             	lea    edi,[ecx+0x2]
    b693:	80 fb 25             	cmp    bl,0x25
    b696:	8d 44 3d 00          	lea    eax,[ebp+edi*1+0x0]
    b69a:	0f 84 10 03 00 00    	je     b9b0 <_ZN3pci11printBussesEv+0x8a0>
    b6a0:	84 db                	test   bl,bl
    b6a2:	0f 85 a8 00 00 00    	jne    b750 <_ZN3pci11printBussesEv+0x640>
    b6a8:	0f b6 18             	movzx  ebx,BYTE PTR [eax]
    b6ab:	84 db                	test   bl,bl
    b6ad:	0f 84 35 fc ff ff    	je     b2e8 <_ZN3pci11printBussesEv+0x1d8>
    b6b3:	0f be d3             	movsx  edx,bl
    b6b6:	89 f9                	mov    ecx,edi
    b6b8:	80 fa 25             	cmp    dl,0x25
    b6bb:	8d 79 01             	lea    edi,[ecx+0x1]
    b6be:	0f b6 5c 0d 01       	movzx  ebx,BYTE PTR [ebp+ecx*1+0x1]
    b6c3:	74 cb                	je     b690 <_ZN3pci11printBussesEv+0x580>
    b6c5:	83 ec 0c             	sub    esp,0xc
    b6c8:	52                   	push   edx
    b6c9:	e8 82 f7 ff ff       	call   ae50 <_Z7putcharc>
    b6ce:	83 c4 10             	add    esp,0x10
    b6d1:	84 db                	test   bl,bl
    b6d3:	75 de                	jne    b6b3 <_ZN3pci11printBussesEv+0x5a3>
    b6d5:	83 c6 01             	add    esi,0x1
    b6d8:	83 fe 20             	cmp    esi,0x20
    b6db:	0f 85 57 fa ff ff    	jne    b138 <_ZN3pci11printBussesEv+0x28>
    b6e1:	e9 0e fc ff ff       	jmp    b2f4 <_ZN3pci11printBussesEv+0x1e4>
    b6e6:	8d 76 00             	lea    esi,[esi+0x0]
    b6e9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b6f0:	83 ec 0c             	sub    esp,0xc
    b6f3:	8d 7d 02             	lea    edi,[ebp+0x2]
    b6f6:	6a 25                	push   0x25
    b6f8:	e8 53 f7 ff ff       	call   ae50 <_Z7putcharc>
    b6fd:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b702:	83 c4 10             	add    esp,0x10
    b705:	84 db                	test   bl,bl
    b707:	0f 85 18 fd ff ff    	jne    b425 <_ZN3pci11printBussesEv+0x315>
    b70d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b711:	e9 1a fb ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    b716:	8d 76 00             	lea    esi,[esi+0x0]
    b719:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b720:	83 ec 0c             	sub    esp,0xc
    b723:	8d 7d 02             	lea    edi,[ebp+0x2]
    b726:	6a 25                	push   0x25
    b728:	e8 23 f7 ff ff       	call   ae50 <_Z7putcharc>
    b72d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b732:	83 c4 10             	add    esp,0x10
    b735:	84 db                	test   bl,bl
    b737:	0f 85 50 fc ff ff    	jne    b38d <_ZN3pci11printBussesEv+0x27d>
    b73d:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b741:	e9 6e fc ff ff       	jmp    b3b4 <_ZN3pci11printBussesEv+0x2a4>
    b746:	8d 76 00             	lea    esi,[esi+0x0]
    b749:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b750:	89 c5                	mov    ebp,eax
    b752:	89 d8                	mov    eax,ebx
    b754:	83 e8 42             	sub    eax,0x42
    b757:	3c 36                	cmp    al,0x36
    b759:	77 1d                	ja     b778 <_ZN3pci11printBussesEv+0x668>
    b75b:	0f b6 c0             	movzx  eax,al
    b75e:	ff 24 85 00 d0 00 00 	jmp    DWORD PTR [eax*4+0xd000]
    b765:	83 ec 0c             	sub    esp,0xc
    b768:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    b76c:	e8 3f f7 ff ff       	call   aeb0 <_Z6putstrPc>
    b771:	83 c4 10             	add    esp,0x10
    b774:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b778:	83 ec 0c             	sub    esp,0xc
    b77b:	83 c6 01             	add    esi,0x1
    b77e:	55                   	push   ebp
    b77f:	e8 4c f7 ff ff       	call   aed0 <_Z6printfPKc>
    b784:	83 c4 10             	add    esp,0x10
    b787:	83 fe 20             	cmp    esi,0x20
    b78a:	0f 85 a8 f9 ff ff    	jne    b138 <_ZN3pci11printBussesEv+0x28>
    b790:	e9 5f fb ff ff       	jmp    b2f4 <_ZN3pci11printBussesEv+0x1e4>
    b795:	83 ec 0c             	sub    esp,0xc
    b798:	68 44 e5 00 00       	push   0xe544
    b79d:	e8 2e f7 ff ff       	call   aed0 <_Z6printfPKc>
    b7a2:	58                   	pop    eax
    b7a3:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    b7a7:	e8 d4 f6 ff ff       	call   ae80 <_Z6puthexi>
    b7ac:	83 c4 10             	add    esp,0x10
    b7af:	eb c7                	jmp    b778 <_ZN3pci11printBussesEv+0x668>
    b7b1:	83 ec 0c             	sub    esp,0xc
    b7b4:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    b7b8:	e8 e3 f6 ff ff       	call   aea0 <_Z6putbini>
    b7bd:	83 c4 10             	add    esp,0x10
    b7c0:	eb b6                	jmp    b778 <_ZN3pci11printBussesEv+0x668>
    b7c2:	83 ec 0c             	sub    esp,0xc
    b7c5:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    b7c9:	e8 a2 f6 ff ff       	call   ae70 <_Z6putdeci>
    b7ce:	83 c4 10             	add    esp,0x10
    b7d1:	eb a5                	jmp    b778 <_ZN3pci11printBussesEv+0x668>
    b7d3:	83 ec 0c             	sub    esp,0xc
    b7d6:	0f be 44 24 28       	movsx  eax,BYTE PTR [esp+0x28]
    b7db:	50                   	push   eax
    b7dc:	e8 6f f6 ff ff       	call   ae50 <_Z7putcharc>
    b7e1:	83 c4 10             	add    esp,0x10
    b7e4:	eb 92                	jmp    b778 <_ZN3pci11printBussesEv+0x668>
    b7e6:	83 ec 0c             	sub    esp,0xc
    b7e9:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    b7ed:	e8 8e f6 ff ff       	call   ae80 <_Z6puthexi>
    b7f2:	83 c4 10             	add    esp,0x10
    b7f5:	eb 81                	jmp    b778 <_ZN3pci11printBussesEv+0x668>
    b7f7:	83 ec 0c             	sub    esp,0xc
    b7fa:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    b7fe:	e8 8d f6 ff ff       	call   ae90 <_Z6putocti>
    b803:	83 c4 10             	add    esp,0x10
    b806:	e9 6d ff ff ff       	jmp    b778 <_ZN3pci11printBussesEv+0x668>
    b80b:	90                   	nop
    b80c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b810:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b814:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b818:	83 ec 08             	sub    esp,0x8
    b81b:	8d 44 24 3a          	lea    eax,[esp+0x3a]
    b81f:	50                   	push   eax
    b820:	51                   	push   ecx
    b821:	e8 ba 08 00 00       	call   c0e0 <_Z14_manage_escapeIhEiPKcPT_>
    b826:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b82a:	01 c5                	add    ebp,eax
    b82c:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    b830:	01 ea                	add    edx,ebp
    b832:	89 44 24 48          	mov    DWORD PTR [esp+0x48],eax
    b836:	83 c4 10             	add    esp,0x10
    b839:	0f be 02             	movsx  eax,BYTE PTR [edx]
    b83c:	84 c0                	test   al,al
    b83e:	0f 84 ec f9 ff ff    	je     b230 <_ZN3pci11printBussesEv+0x120>
    b844:	89 74 24 14          	mov    DWORD PTR [esp+0x14],esi
    b848:	31 ed                	xor    ebp,ebp
    b84a:	89 d6                	mov    esi,edx
    b84c:	eb 28                	jmp    b876 <_ZN3pci11printBussesEv+0x766>
    b84e:	66 90                	xchg   ax,ax
    b850:	80 fb 25             	cmp    bl,0x25
    b853:	0f 84 b7 01 00 00    	je     ba10 <_ZN3pci11printBussesEv+0x900>
    b859:	84 db                	test   bl,bl
    b85b:	0f 85 9f 00 00 00    	jne    b900 <_ZN3pci11printBussesEv+0x7f0>
    b861:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b866:	8d 7d 02             	lea    edi,[ebp+0x2]
    b869:	84 db                	test   bl,bl
    b86b:	0f 84 e6 fd ff ff    	je     b657 <_ZN3pci11printBussesEv+0x547>
    b871:	0f be c3             	movsx  eax,bl
    b874:	89 fd                	mov    ebp,edi
    b876:	8d 7d 01             	lea    edi,[ebp+0x1]
    b879:	3c 25                	cmp    al,0x25
    b87b:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    b87e:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b881:	74 cd                	je     b850 <_ZN3pci11printBussesEv+0x740>
    b883:	83 ec 0c             	sub    esp,0xc
    b886:	50                   	push   eax
    b887:	e8 c4 f5 ff ff       	call   ae50 <_Z7putcharc>
    b88c:	83 c4 10             	add    esp,0x10
    b88f:	84 db                	test   bl,bl
    b891:	75 de                	jne    b871 <_ZN3pci11printBussesEv+0x761>
    b893:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b897:	e9 94 f9 ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    b89c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b8a0:	83 ec 0c             	sub    esp,0xc
    b8a3:	8d 7d 02             	lea    edi,[ebp+0x2]
    b8a6:	6a 25                	push   0x25
    b8a8:	e8 a3 f5 ff ff       	call   ae50 <_Z7putcharc>
    b8ad:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b8b2:	83 c4 10             	add    esp,0x10
    b8b5:	84 db                	test   bl,bl
    b8b7:	0f 85 fc fb ff ff    	jne    b4b9 <_ZN3pci11printBussesEv+0x3a9>
    b8bd:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b8c1:	e9 ee fa ff ff       	jmp    b3b4 <_ZN3pci11printBussesEv+0x2a4>
    b8c6:	8d 76 00             	lea    esi,[esi+0x0]
    b8c9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b8d0:	83 ec 0c             	sub    esp,0xc
    b8d3:	8d 7d 02             	lea    edi,[ebp+0x2]
    b8d6:	6a 25                	push   0x25
    b8d8:	e8 73 f5 ff ff       	call   ae50 <_Z7putcharc>
    b8dd:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    b8e2:	83 c4 10             	add    esp,0x10
    b8e5:	84 db                	test   bl,bl
    b8e7:	0f 85 5c fc ff ff    	jne    b549 <_ZN3pci11printBussesEv+0x439>
    b8ed:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    b8f1:	e9 3a f9 ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    b8f6:	8d 76 00             	lea    esi,[esi+0x0]
    b8f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b900:	89 74 24 08          	mov    DWORD PTR [esp+0x8],esi
    b904:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b908:	83 ec 08             	sub    esp,0x8
    b90b:	8d 44 24 40          	lea    eax,[esp+0x40]
    b90f:	50                   	push   eax
    b910:	51                   	push   ecx
    b911:	e8 ba 08 00 00       	call   c1d0 <_Z14_manage_escapeIiEiPKcPT_>
    b916:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    b91a:	01 c7                	add    edi,eax
    b91c:	89 74 24 4c          	mov    DWORD PTR [esp+0x4c],esi
    b920:	83 c4 10             	add    esp,0x10
    b923:	01 d7                	add    edi,edx
    b925:	0f be 07             	movsx  eax,BYTE PTR [edi]
    b928:	84 c0                	test   al,al
    b92a:	0f 84 00 f9 ff ff    	je     b230 <_ZN3pci11printBussesEv+0x120>
    b930:	31 d2                	xor    edx,edx
    b932:	eb 2a                	jmp    b95e <_ZN3pci11printBussesEv+0x84e>
    b934:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b938:	80 fb 25             	cmp    bl,0x25
    b93b:	0f 84 ff 00 00 00    	je     ba40 <_ZN3pci11printBussesEv+0x930>
    b941:	84 db                	test   bl,bl
    b943:	0f 85 9f 00 00 00    	jne    b9e8 <_ZN3pci11printBussesEv+0x8d8>
    b949:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    b94e:	8d 6a 02             	lea    ebp,[edx+0x2]
    b951:	84 db                	test   bl,bl
    b953:	0f 84 d7 f8 ff ff    	je     b230 <_ZN3pci11printBussesEv+0x120>
    b959:	0f be c3             	movsx  eax,bl
    b95c:	89 ea                	mov    edx,ebp
    b95e:	8d 6a 01             	lea    ebp,[edx+0x1]
    b961:	3c 25                	cmp    al,0x25
    b963:	8d 0c 2f             	lea    ecx,[edi+ebp*1]
    b966:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    b969:	74 cd                	je     b938 <_ZN3pci11printBussesEv+0x828>
    b96b:	83 ec 0c             	sub    esp,0xc
    b96e:	50                   	push   eax
    b96f:	e8 dc f4 ff ff       	call   ae50 <_Z7putcharc>
    b974:	83 c4 10             	add    esp,0x10
    b977:	84 db                	test   bl,bl
    b979:	75 de                	jne    b959 <_ZN3pci11printBussesEv+0x849>
    b97b:	e9 b0 f8 ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    b980:	83 ec 0c             	sub    esp,0xc
    b983:	8d 6f 02             	lea    ebp,[edi+0x2]
    b986:	6a 25                	push   0x25
    b988:	e8 c3 f4 ff ff       	call   ae50 <_Z7putcharc>
    b98d:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    b992:	83 c4 10             	add    esp,0x10
    b995:	84 db                	test   bl,bl
    b997:	0f 85 98 fc ff ff    	jne    b635 <_ZN3pci11printBussesEv+0x525>
    b99d:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    b9a1:	e9 8a f8 ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    b9a6:	8d 76 00             	lea    esi,[esi+0x0]
    b9a9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b9b0:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    b9b4:	83 ec 0c             	sub    esp,0xc
    b9b7:	6a 25                	push   0x25
    b9b9:	e8 92 f4 ff ff       	call   ae50 <_Z7putcharc>
    b9be:	8b 44 24 18          	mov    eax,DWORD PTR [esp+0x18]
    b9c2:	83 c4 10             	add    esp,0x10
    b9c5:	0f b6 18             	movzx  ebx,BYTE PTR [eax]
    b9c8:	84 db                	test   bl,bl
    b9ca:	0f 85 e3 fc ff ff    	jne    b6b3 <_ZN3pci11printBussesEv+0x5a3>
    b9d0:	83 c6 01             	add    esi,0x1
    b9d3:	83 fe 20             	cmp    esi,0x20
    b9d6:	0f 85 5c f7 ff ff    	jne    b138 <_ZN3pci11printBussesEv+0x28>
    b9dc:	e9 13 f9 ff ff       	jmp    b2f4 <_ZN3pci11printBussesEv+0x1e4>
    b9e1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b9e8:	83 ec 08             	sub    esp,0x8
    b9eb:	8d 44 24 44          	lea    eax,[esp+0x44]
    b9ef:	50                   	push   eax
    b9f0:	51                   	push   ecx
    b9f1:	e8 da 07 00 00       	call   c1d0 <_Z14_manage_escapeIiEiPKcPT_>
    b9f6:	8d 14 28             	lea    edx,[eax+ebp*1]
    b9f9:	01 fa                	add    edx,edi
    b9fb:	89 14 24             	mov    DWORD PTR [esp],edx
    b9fe:	e8 cd f4 ff ff       	call   aed0 <_Z6printfPKc>
    ba03:	83 c4 10             	add    esp,0x10
    ba06:	e9 25 f8 ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    ba0b:	90                   	nop
    ba0c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ba10:	83 ec 0c             	sub    esp,0xc
    ba13:	8d 7d 02             	lea    edi,[ebp+0x2]
    ba16:	6a 25                	push   0x25
    ba18:	e8 33 f4 ff ff       	call   ae50 <_Z7putcharc>
    ba1d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    ba22:	83 c4 10             	add    esp,0x10
    ba25:	84 db                	test   bl,bl
    ba27:	0f 85 44 fe ff ff    	jne    b871 <_ZN3pci11printBussesEv+0x761>
    ba2d:	8b 74 24 14          	mov    esi,DWORD PTR [esp+0x14]
    ba31:	e9 fa f7 ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>
    ba36:	8d 76 00             	lea    esi,[esi+0x0]
    ba39:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ba40:	89 54 24 08          	mov    DWORD PTR [esp+0x8],edx
    ba44:	83 ec 0c             	sub    esp,0xc
    ba47:	6a 25                	push   0x25
    ba49:	e8 02 f4 ff ff       	call   ae50 <_Z7putcharc>
    ba4e:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    ba52:	83 c4 10             	add    esp,0x10
    ba55:	0f b6 5c 17 02       	movzx  ebx,BYTE PTR [edi+edx*1+0x2]
    ba5a:	8d 6a 02             	lea    ebp,[edx+0x2]
    ba5d:	84 db                	test   bl,bl
    ba5f:	0f 85 f4 fe ff ff    	jne    b959 <_ZN3pci11printBussesEv+0x849>
    ba65:	e9 c6 f7 ff ff       	jmp    b230 <_ZN3pci11printBussesEv+0x120>

Disassembly of section .text._Z6printfIiEvPKcT_:

0000ba70 <_Z6printfIiEvPKcT_>:
    ba70:	55                   	push   ebp
    ba71:	57                   	push   edi
    ba72:	31 d2                	xor    edx,edx
    ba74:	56                   	push   esi
    ba75:	53                   	push   ebx
    ba76:	83 ec 0c             	sub    esp,0xc
    ba79:	8b 7c 24 20          	mov    edi,DWORD PTR [esp+0x20]
    ba7d:	8b 74 24 24          	mov    esi,DWORD PTR [esp+0x24]
    ba81:	0f be 07             	movsx  eax,BYTE PTR [edi]
    ba84:	84 c0                	test   al,al
    ba86:	74 4a                	je     bad2 <_Z6printfIiEvPKcT_+0x62>
    ba88:	8d 5a 01             	lea    ebx,[edx+0x1]
    ba8b:	3c 25                	cmp    al,0x25
    ba8d:	8d 2c 1f             	lea    ebp,[edi+ebx*1]
    ba90:	75 2c                	jne    babe <_Z6printfIiEvPKcT_+0x4e>
    ba92:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ba98:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    ba9c:	8d 5a 02             	lea    ebx,[edx+0x2]
    ba9f:	8d 2c 1f             	lea    ebp,[edi+ebx*1]
    baa2:	3c 25                	cmp    al,0x25
    baa4:	74 7a                	je     bb20 <_Z6printfIiEvPKcT_+0xb0>
    baa6:	84 c0                	test   al,al
    baa8:	75 36                	jne    bae0 <_Z6printfIiEvPKcT_+0x70>
    baaa:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    baae:	84 c0                	test   al,al
    bab0:	74 20                	je     bad2 <_Z6printfIiEvPKcT_+0x62>
    bab2:	89 da                	mov    edx,ebx
    bab4:	3c 25                	cmp    al,0x25
    bab6:	8d 5a 01             	lea    ebx,[edx+0x1]
    bab9:	8d 2c 1f             	lea    ebp,[edi+ebx*1]
    babc:	74 da                	je     ba98 <_Z6printfIiEvPKcT_+0x28>
    babe:	83 ec 0c             	sub    esp,0xc
    bac1:	50                   	push   eax
    bac2:	e8 89 f3 ff ff       	call   ae50 <_Z7putcharc>
    bac7:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    bacb:	83 c4 10             	add    esp,0x10
    bace:	84 c0                	test   al,al
    bad0:	75 e0                	jne    bab2 <_Z6printfIiEvPKcT_+0x42>
    bad2:	83 c4 0c             	add    esp,0xc
    bad5:	5b                   	pop    ebx
    bad6:	5e                   	pop    esi
    bad7:	5f                   	pop    edi
    bad8:	5d                   	pop    ebp
    bad9:	c3                   	ret    
    bada:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bae0:	83 e8 42             	sub    eax,0x42
    bae3:	3c 36                	cmp    al,0x36
    bae5:	77 22                	ja     bb09 <_Z6printfIiEvPKcT_+0x99>
    bae7:	0f b6 c0             	movzx  eax,al
    baea:	ff 24 85 b0 e2 00 00 	jmp    DWORD PTR [eax*4+0xe2b0]
    baf1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    baf8:	89 f0                	mov    eax,esi
    bafa:	83 ec 0c             	sub    esp,0xc
    bafd:	0f be f0             	movsx  esi,al
    bb00:	56                   	push   esi
    bb01:	e8 4a f3 ff ff       	call   ae50 <_Z7putcharc>
    bb06:	83 c4 10             	add    esp,0x10
    bb09:	89 6c 24 20          	mov    DWORD PTR [esp+0x20],ebp
    bb0d:	83 c4 0c             	add    esp,0xc
    bb10:	5b                   	pop    ebx
    bb11:	5e                   	pop    esi
    bb12:	5f                   	pop    edi
    bb13:	5d                   	pop    ebp
    bb14:	e9 b7 f3 ff ff       	jmp    aed0 <_Z6printfPKc>
    bb19:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bb20:	83 ec 0c             	sub    esp,0xc
    bb23:	6a 25                	push   0x25
    bb25:	eb 9b                	jmp    bac2 <_Z6printfIiEvPKcT_+0x52>
    bb27:	89 f6                	mov    esi,esi
    bb29:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bb30:	83 ec 0c             	sub    esp,0xc
    bb33:	56                   	push   esi
    bb34:	e8 77 f3 ff ff       	call   aeb0 <_Z6putstrPc>
    bb39:	83 c4 10             	add    esp,0x10
    bb3c:	89 6c 24 20          	mov    DWORD PTR [esp+0x20],ebp
    bb40:	83 c4 0c             	add    esp,0xc
    bb43:	5b                   	pop    ebx
    bb44:	5e                   	pop    esi
    bb45:	5f                   	pop    edi
    bb46:	5d                   	pop    ebp
    bb47:	e9 84 f3 ff ff       	jmp    aed0 <_Z6printfPKc>
    bb4c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bb50:	83 ec 0c             	sub    esp,0xc
    bb53:	56                   	push   esi
    bb54:	e8 47 f3 ff ff       	call   aea0 <_Z6putbini>
    bb59:	83 c4 10             	add    esp,0x10
    bb5c:	89 6c 24 20          	mov    DWORD PTR [esp+0x20],ebp
    bb60:	83 c4 0c             	add    esp,0xc
    bb63:	5b                   	pop    ebx
    bb64:	5e                   	pop    esi
    bb65:	5f                   	pop    edi
    bb66:	5d                   	pop    ebp
    bb67:	e9 64 f3 ff ff       	jmp    aed0 <_Z6printfPKc>
    bb6c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bb70:	83 ec 0c             	sub    esp,0xc
    bb73:	56                   	push   esi
    bb74:	e8 17 f3 ff ff       	call   ae90 <_Z6putocti>
    bb79:	83 c4 10             	add    esp,0x10
    bb7c:	89 6c 24 20          	mov    DWORD PTR [esp+0x20],ebp
    bb80:	83 c4 0c             	add    esp,0xc
    bb83:	5b                   	pop    ebx
    bb84:	5e                   	pop    esi
    bb85:	5f                   	pop    edi
    bb86:	5d                   	pop    ebp
    bb87:	e9 44 f3 ff ff       	jmp    aed0 <_Z6printfPKc>
    bb8c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bb90:	83 ec 0c             	sub    esp,0xc
    bb93:	56                   	push   esi
    bb94:	e8 e7 f2 ff ff       	call   ae80 <_Z6puthexi>
    bb99:	83 c4 10             	add    esp,0x10
    bb9c:	89 6c 24 20          	mov    DWORD PTR [esp+0x20],ebp
    bba0:	83 c4 0c             	add    esp,0xc
    bba3:	5b                   	pop    ebx
    bba4:	5e                   	pop    esi
    bba5:	5f                   	pop    edi
    bba6:	5d                   	pop    ebp
    bba7:	e9 24 f3 ff ff       	jmp    aed0 <_Z6printfPKc>
    bbac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bbb0:	83 ec 0c             	sub    esp,0xc
    bbb3:	56                   	push   esi
    bbb4:	e8 b7 f2 ff ff       	call   ae70 <_Z6putdeci>
    bbb9:	83 c4 10             	add    esp,0x10
    bbbc:	89 6c 24 20          	mov    DWORD PTR [esp+0x20],ebp
    bbc0:	83 c4 0c             	add    esp,0xc
    bbc3:	5b                   	pop    ebx
    bbc4:	5e                   	pop    esi
    bbc5:	5f                   	pop    edi
    bbc6:	5d                   	pop    ebp
    bbc7:	e9 04 f3 ff ff       	jmp    aed0 <_Z6printfPKc>
    bbcc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bbd0:	83 ec 0c             	sub    esp,0xc
    bbd3:	68 ac e2 00 00       	push   0xe2ac
    bbd8:	e8 f3 f2 ff ff       	call   aed0 <_Z6printfPKc>
    bbdd:	89 34 24             	mov    DWORD PTR [esp],esi
    bbe0:	e8 9b f2 ff ff       	call   ae80 <_Z6puthexi>
    bbe5:	83 c4 10             	add    esp,0x10
    bbe8:	89 6c 24 20          	mov    DWORD PTR [esp+0x20],ebp
    bbec:	83 c4 0c             	add    esp,0xc
    bbef:	5b                   	pop    ebx
    bbf0:	5e                   	pop    esi
    bbf1:	5f                   	pop    edi
    bbf2:	5d                   	pop    ebp
    bbf3:	e9 d8 f2 ff ff       	jmp    aed0 <_Z6printfPKc>

Disassembly of section .text._Z6printfIcEvPKcT_:

0000bc00 <_Z6printfIcEvPKcT_>:
    bc00:	57                   	push   edi
    bc01:	56                   	push   esi
    bc02:	31 d2                	xor    edx,edx
    bc04:	53                   	push   ebx
    bc05:	83 ec 10             	sub    esp,0x10
    bc08:	8b 44 24 24          	mov    eax,DWORD PTR [esp+0x24]
    bc0c:	8b 7c 24 20          	mov    edi,DWORD PTR [esp+0x20]
    bc10:	88 44 24 0c          	mov    BYTE PTR [esp+0xc],al
    bc14:	0f be 07             	movsx  eax,BYTE PTR [edi]
    bc17:	84 c0                	test   al,al
    bc19:	74 44                	je     bc5f <_Z6printfIcEvPKcT_+0x5f>
    bc1b:	8d 5a 01             	lea    ebx,[edx+0x1]
    bc1e:	3c 25                	cmp    al,0x25
    bc20:	8d 34 1f             	lea    esi,[edi+ebx*1]
    bc23:	75 27                	jne    bc4c <_Z6printfIcEvPKcT_+0x4c>
    bc25:	8d 76 00             	lea    esi,[esi+0x0]
    bc28:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    bc2b:	8d 5a 02             	lea    ebx,[edx+0x2]
    bc2e:	8d 34 1f             	lea    esi,[edi+ebx*1]
    bc31:	3c 25                	cmp    al,0x25
    bc33:	74 7b                	je     bcb0 <_Z6printfIcEvPKcT_+0xb0>
    bc35:	84 c0                	test   al,al
    bc37:	75 37                	jne    bc70 <_Z6printfIcEvPKcT_+0x70>
    bc39:	0f be 06             	movsx  eax,BYTE PTR [esi]
    bc3c:	84 c0                	test   al,al
    bc3e:	74 1f                	je     bc5f <_Z6printfIcEvPKcT_+0x5f>
    bc40:	89 da                	mov    edx,ebx
    bc42:	3c 25                	cmp    al,0x25
    bc44:	8d 5a 01             	lea    ebx,[edx+0x1]
    bc47:	8d 34 1f             	lea    esi,[edi+ebx*1]
    bc4a:	74 dc                	je     bc28 <_Z6printfIcEvPKcT_+0x28>
    bc4c:	83 ec 0c             	sub    esp,0xc
    bc4f:	50                   	push   eax
    bc50:	e8 fb f1 ff ff       	call   ae50 <_Z7putcharc>
    bc55:	0f be 06             	movsx  eax,BYTE PTR [esi]
    bc58:	83 c4 10             	add    esp,0x10
    bc5b:	84 c0                	test   al,al
    bc5d:	75 e1                	jne    bc40 <_Z6printfIcEvPKcT_+0x40>
    bc5f:	83 c4 10             	add    esp,0x10
    bc62:	5b                   	pop    ebx
    bc63:	5e                   	pop    esi
    bc64:	5f                   	pop    edi
    bc65:	c3                   	ret    
    bc66:	8d 76 00             	lea    esi,[esi+0x0]
    bc69:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bc70:	83 e8 42             	sub    eax,0x42
    bc73:	3c 36                	cmp    al,0x36
    bc75:	77 22                	ja     bc99 <_Z6printfIcEvPKcT_+0x99>
    bc77:	0f b6 c0             	movzx  eax,al
    bc7a:	ff 24 85 8c e3 00 00 	jmp    DWORD PTR [eax*4+0xe38c]
    bc81:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bc88:	83 ec 0c             	sub    esp,0xc
    bc8b:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bc90:	50                   	push   eax
    bc91:	e8 ba f1 ff ff       	call   ae50 <_Z7putcharc>
    bc96:	83 c4 10             	add    esp,0x10
    bc99:	83 ec 0c             	sub    esp,0xc
    bc9c:	56                   	push   esi
    bc9d:	e8 2e f2 ff ff       	call   aed0 <_Z6printfPKc>
    bca2:	83 c4 10             	add    esp,0x10
    bca5:	83 c4 10             	add    esp,0x10
    bca8:	5b                   	pop    ebx
    bca9:	5e                   	pop    esi
    bcaa:	5f                   	pop    edi
    bcab:	c3                   	ret    
    bcac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bcb0:	83 ec 0c             	sub    esp,0xc
    bcb3:	6a 25                	push   0x25
    bcb5:	eb 99                	jmp    bc50 <_Z6printfIcEvPKcT_+0x50>
    bcb7:	89 f6                	mov    esi,esi
    bcb9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bcc0:	83 ec 0c             	sub    esp,0xc
    bcc3:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bcc7:	e8 e4 f1 ff ff       	call   aeb0 <_Z6putstrPc>
    bccc:	83 c4 10             	add    esp,0x10
    bccf:	83 ec 0c             	sub    esp,0xc
    bcd2:	56                   	push   esi
    bcd3:	e8 f8 f1 ff ff       	call   aed0 <_Z6printfPKc>
    bcd8:	83 c4 10             	add    esp,0x10
    bcdb:	eb c8                	jmp    bca5 <_Z6printfIcEvPKcT_+0xa5>
    bcdd:	8d 76 00             	lea    esi,[esi+0x0]
    bce0:	83 ec 0c             	sub    esp,0xc
    bce3:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bce8:	50                   	push   eax
    bce9:	e8 b2 f1 ff ff       	call   aea0 <_Z6putbini>
    bcee:	83 c4 10             	add    esp,0x10
    bcf1:	83 ec 0c             	sub    esp,0xc
    bcf4:	56                   	push   esi
    bcf5:	e8 d6 f1 ff ff       	call   aed0 <_Z6printfPKc>
    bcfa:	83 c4 10             	add    esp,0x10
    bcfd:	eb a6                	jmp    bca5 <_Z6printfIcEvPKcT_+0xa5>
    bcff:	90                   	nop
    bd00:	83 ec 0c             	sub    esp,0xc
    bd03:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bd08:	50                   	push   eax
    bd09:	e8 82 f1 ff ff       	call   ae90 <_Z6putocti>
    bd0e:	83 c4 10             	add    esp,0x10
    bd11:	83 ec 0c             	sub    esp,0xc
    bd14:	56                   	push   esi
    bd15:	e8 b6 f1 ff ff       	call   aed0 <_Z6printfPKc>
    bd1a:	83 c4 10             	add    esp,0x10
    bd1d:	eb 86                	jmp    bca5 <_Z6printfIcEvPKcT_+0xa5>
    bd1f:	90                   	nop
    bd20:	83 ec 0c             	sub    esp,0xc
    bd23:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bd28:	50                   	push   eax
    bd29:	e8 52 f1 ff ff       	call   ae80 <_Z6puthexi>
    bd2e:	83 c4 10             	add    esp,0x10
    bd31:	83 ec 0c             	sub    esp,0xc
    bd34:	56                   	push   esi
    bd35:	e8 96 f1 ff ff       	call   aed0 <_Z6printfPKc>
    bd3a:	83 c4 10             	add    esp,0x10
    bd3d:	e9 63 ff ff ff       	jmp    bca5 <_Z6printfIcEvPKcT_+0xa5>
    bd42:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bd48:	83 ec 0c             	sub    esp,0xc
    bd4b:	0f be 44 24 18       	movsx  eax,BYTE PTR [esp+0x18]
    bd50:	50                   	push   eax
    bd51:	e8 1a f1 ff ff       	call   ae70 <_Z6putdeci>
    bd56:	83 c4 10             	add    esp,0x10
    bd59:	83 ec 0c             	sub    esp,0xc
    bd5c:	56                   	push   esi
    bd5d:	e8 6e f1 ff ff       	call   aed0 <_Z6printfPKc>
    bd62:	83 c4 10             	add    esp,0x10
    bd65:	e9 3b ff ff ff       	jmp    bca5 <_Z6printfIcEvPKcT_+0xa5>
    bd6a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bd70:	83 ec 0c             	sub    esp,0xc
    bd73:	68 ac e2 00 00       	push   0xe2ac
    bd78:	e8 53 f1 ff ff       	call   aed0 <_Z6printfPKc>
    bd7d:	58                   	pop    eax
    bd7e:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    bd82:	e8 f9 f0 ff ff       	call   ae80 <_Z6puthexi>
    bd87:	83 c4 10             	add    esp,0x10
    bd8a:	83 ec 0c             	sub    esp,0xc
    bd8d:	56                   	push   esi
    bd8e:	e8 3d f1 ff ff       	call   aed0 <_Z6printfPKc>
    bd93:	83 c4 10             	add    esp,0x10
    bd96:	e9 0a ff ff ff       	jmp    bca5 <_Z6printfIcEvPKcT_+0xa5>

Disassembly of section .text._Z14_manage_escapeItEiPKcPT_:

0000bda0 <_Z14_manage_escapeItEiPKcPT_>:
    bda0:	83 ec 0c             	sub    esp,0xc
    bda3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    bda7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    bdaa:	83 e8 42             	sub    eax,0x42
    bdad:	3c 36                	cmp    al,0x36
    bdaf:	77 2c                	ja     bddd <_Z14_manage_escapeItEiPKcPT_+0x3d>
    bdb1:	0f b6 c0             	movzx  eax,al
    bdb4:	ff 24 85 68 e4 00 00 	jmp    DWORD PTR [eax*4+0xe468]
    bdbb:	90                   	nop
    bdbc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bdc0:	83 ec 0c             	sub    esp,0xc
    bdc3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    bdc7:	ff 30                	push   DWORD PTR [eax]
    bdc9:	e8 e2 f0 ff ff       	call   aeb0 <_Z6putstrPc>
    bdce:	83 c4 10             	add    esp,0x10
    bdd1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bdd8:	b8 01 00 00 00       	mov    eax,0x1
    bddd:	83 c4 0c             	add    esp,0xc
    bde0:	c3                   	ret    
    bde1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bde8:	83 ec 0c             	sub    esp,0xc
    bdeb:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    bdef:	0f b7 00             	movzx  eax,WORD PTR [eax]
    bdf2:	50                   	push   eax
    bdf3:	e8 a8 f0 ff ff       	call   aea0 <_Z6putbini>
    bdf8:	83 c4 10             	add    esp,0x10
    bdfb:	eb db                	jmp    bdd8 <_Z14_manage_escapeItEiPKcPT_+0x38>
    bdfd:	8d 76 00             	lea    esi,[esi+0x0]
    be00:	83 ec 0c             	sub    esp,0xc
    be03:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    be07:	0f b7 00             	movzx  eax,WORD PTR [eax]
    be0a:	50                   	push   eax
    be0b:	e8 80 f0 ff ff       	call   ae90 <_Z6putocti>
    be10:	83 c4 10             	add    esp,0x10
    be13:	eb c3                	jmp    bdd8 <_Z14_manage_escapeItEiPKcPT_+0x38>
    be15:	8d 76 00             	lea    esi,[esi+0x0]
    be18:	83 ec 0c             	sub    esp,0xc
    be1b:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    be1f:	0f b7 00             	movzx  eax,WORD PTR [eax]
    be22:	50                   	push   eax
    be23:	e8 58 f0 ff ff       	call   ae80 <_Z6puthexi>
    be28:	83 c4 10             	add    esp,0x10
    be2b:	eb ab                	jmp    bdd8 <_Z14_manage_escapeItEiPKcPT_+0x38>
    be2d:	8d 76 00             	lea    esi,[esi+0x0]
    be30:	83 ec 0c             	sub    esp,0xc
    be33:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    be37:	0f be 00             	movsx  eax,BYTE PTR [eax]
    be3a:	50                   	push   eax
    be3b:	e8 10 f0 ff ff       	call   ae50 <_Z7putcharc>
    be40:	83 c4 10             	add    esp,0x10
    be43:	eb 93                	jmp    bdd8 <_Z14_manage_escapeItEiPKcPT_+0x38>
    be45:	8d 76 00             	lea    esi,[esi+0x0]
    be48:	83 ec 0c             	sub    esp,0xc
    be4b:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    be4f:	0f b7 00             	movzx  eax,WORD PTR [eax]
    be52:	50                   	push   eax
    be53:	e8 18 f0 ff ff       	call   ae70 <_Z6putdeci>
    be58:	83 c4 10             	add    esp,0x10
    be5b:	e9 78 ff ff ff       	jmp    bdd8 <_Z14_manage_escapeItEiPKcPT_+0x38>
    be60:	83 ec 0c             	sub    esp,0xc
    be63:	68 ac e2 00 00       	push   0xe2ac
    be68:	e8 63 f0 ff ff       	call   aed0 <_Z6printfPKc>
    be6d:	58                   	pop    eax
    be6e:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    be72:	ff 30                	push   DWORD PTR [eax]
    be74:	e8 07 f0 ff ff       	call   ae80 <_Z6puthexi>
    be79:	83 c4 10             	add    esp,0x10
    be7c:	e9 57 ff ff ff       	jmp    bdd8 <_Z14_manage_escapeItEiPKcPT_+0x38>

Disassembly of section .text._Z6printfItEvPKcT_:

0000be90 <_Z6printfItEvPKcT_>:
    be90:	55                   	push   ebp
    be91:	57                   	push   edi
    be92:	56                   	push   esi
    be93:	53                   	push   ebx
    be94:	31 f6                	xor    esi,esi
    be96:	83 ec 1c             	sub    esp,0x1c
    be99:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    be9d:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    bea1:	66 89 44 24 0c       	mov    WORD PTR [esp+0xc],ax
    bea6:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    beaa:	84 c0                	test   al,al
    beac:	74 49                	je     bef7 <_Z6printfItEvPKcT_+0x67>
    beae:	8d 5e 01             	lea    ebx,[esi+0x1]
    beb1:	3c 25                	cmp    al,0x25
    beb3:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    beb7:	75 2b                	jne    bee4 <_Z6printfItEvPKcT_+0x54>
    beb9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bec0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    bec3:	3c 25                	cmp    al,0x25
    bec5:	74 61                	je     bf28 <_Z6printfItEvPKcT_+0x98>
    bec7:	84 c0                	test   al,al
    bec9:	75 35                	jne    bf00 <_Z6printfItEvPKcT_+0x70>
    becb:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    bed0:	8d 5e 02             	lea    ebx,[esi+0x2]
    bed3:	84 c0                	test   al,al
    bed5:	74 20                	je     bef7 <_Z6printfItEvPKcT_+0x67>
    bed7:	89 de                	mov    esi,ebx
    bed9:	8d 5e 01             	lea    ebx,[esi+0x1]
    bedc:	3c 25                	cmp    al,0x25
    bede:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    bee2:	74 dc                	je     bec0 <_Z6printfItEvPKcT_+0x30>
    bee4:	83 ec 0c             	sub    esp,0xc
    bee7:	50                   	push   eax
    bee8:	e8 63 ef ff ff       	call   ae50 <_Z7putcharc>
    beed:	0f be 07             	movsx  eax,BYTE PTR [edi]
    bef0:	83 c4 10             	add    esp,0x10
    bef3:	84 c0                	test   al,al
    bef5:	75 e0                	jne    bed7 <_Z6printfItEvPKcT_+0x47>
    bef7:	83 c4 1c             	add    esp,0x1c
    befa:	5b                   	pop    ebx
    befb:	5e                   	pop    esi
    befc:	5f                   	pop    edi
    befd:	5d                   	pop    ebp
    befe:	c3                   	ret    
    beff:	90                   	nop
    bf00:	83 ec 08             	sub    esp,0x8
    bf03:	8d 44 24 14          	lea    eax,[esp+0x14]
    bf07:	50                   	push   eax
    bf08:	57                   	push   edi
    bf09:	e8 92 fe ff ff       	call   bda0 <_Z14_manage_escapeItEiPKcPT_>
    bf0e:	01 c3                	add    ebx,eax
    bf10:	01 dd                	add    ebp,ebx
    bf12:	89 2c 24             	mov    DWORD PTR [esp],ebp
    bf15:	e8 b6 ef ff ff       	call   aed0 <_Z6printfPKc>
    bf1a:	83 c4 10             	add    esp,0x10
    bf1d:	83 c4 1c             	add    esp,0x1c
    bf20:	5b                   	pop    ebx
    bf21:	5e                   	pop    esi
    bf22:	5f                   	pop    edi
    bf23:	5d                   	pop    ebp
    bf24:	c3                   	ret    
    bf25:	8d 76 00             	lea    esi,[esi+0x0]
    bf28:	83 ec 0c             	sub    esp,0xc
    bf2b:	8d 5e 02             	lea    ebx,[esi+0x2]
    bf2e:	6a 25                	push   0x25
    bf30:	e8 1b ef ff ff       	call   ae50 <_Z7putcharc>
    bf35:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    bf3a:	83 c4 10             	add    esp,0x10
    bf3d:	84 c0                	test   al,al
    bf3f:	74 b6                	je     bef7 <_Z6printfItEvPKcT_+0x67>
    bf41:	89 de                	mov    esi,ebx
    bf43:	eb 94                	jmp    bed9 <_Z6printfItEvPKcT_+0x49>

Disassembly of section .text._Z6printfItJttEEvPKcT_DpT0_:

0000bf50 <_Z6printfItJttEEvPKcT_DpT0_>:
    bf50:	55                   	push   ebp
    bf51:	57                   	push   edi
    bf52:	31 c9                	xor    ecx,ecx
    bf54:	56                   	push   esi
    bf55:	53                   	push   ebx
    bf56:	83 ec 2c             	sub    esp,0x2c
    bf59:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    bf5d:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    bf61:	8b 74 24 48          	mov    esi,DWORD PTR [esp+0x48]
    bf65:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    bf69:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    bf6d:	66 89 44 24 0c       	mov    WORD PTR [esp+0xc],ax
    bf72:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    bf76:	84 c0                	test   al,al
    bf78:	74 49                	je     bfc3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    bf7a:	8d 79 01             	lea    edi,[ecx+0x1]
    bf7d:	3c 25                	cmp    al,0x25
    bf7f:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    bf83:	75 2b                	jne    bfb0 <_Z6printfItJttEEvPKcT_DpT0_+0x60>
    bf85:	8d 76 00             	lea    esi,[esi+0x0]
    bf88:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    bf8b:	3c 25                	cmp    al,0x25
    bf8d:	0f 84 f5 00 00 00    	je     c088 <_Z6printfItJttEEvPKcT_DpT0_+0x138>
    bf93:	84 c0                	test   al,al
    bf95:	75 39                	jne    bfd0 <_Z6printfItJttEEvPKcT_DpT0_+0x80>
    bf97:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    bf9c:	8d 79 02             	lea    edi,[ecx+0x2]
    bf9f:	84 c0                	test   al,al
    bfa1:	74 20                	je     bfc3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    bfa3:	89 f9                	mov    ecx,edi
    bfa5:	8d 79 01             	lea    edi,[ecx+0x1]
    bfa8:	3c 25                	cmp    al,0x25
    bfaa:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    bfae:	74 d8                	je     bf88 <_Z6printfItJttEEvPKcT_DpT0_+0x38>
    bfb0:	83 ec 0c             	sub    esp,0xc
    bfb3:	50                   	push   eax
    bfb4:	e8 97 ee ff ff       	call   ae50 <_Z7putcharc>
    bfb9:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    bfbc:	83 c4 10             	add    esp,0x10
    bfbf:	84 c0                	test   al,al
    bfc1:	75 e0                	jne    bfa3 <_Z6printfItJttEEvPKcT_DpT0_+0x53>
    bfc3:	83 c4 2c             	add    esp,0x2c
    bfc6:	5b                   	pop    ebx
    bfc7:	5e                   	pop    esi
    bfc8:	5f                   	pop    edi
    bfc9:	5d                   	pop    ebp
    bfca:	c3                   	ret    
    bfcb:	90                   	nop
    bfcc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bfd0:	83 ec 08             	sub    esp,0x8
    bfd3:	8d 44 24 14          	lea    eax,[esp+0x14]
    bfd7:	50                   	push   eax
    bfd8:	53                   	push   ebx
    bfd9:	e8 c2 fd ff ff       	call   bda0 <_Z14_manage_escapeItEiPKcPT_>
    bfde:	01 c7                	add    edi,eax
    bfe0:	0f b7 54 24 14       	movzx  edx,WORD PTR [esp+0x14]
    bfe5:	66 89 74 24 2e       	mov    WORD PTR [esp+0x2e],si
    bfea:	01 fd                	add    ebp,edi
    bfec:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    bff0:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    bff4:	83 c4 10             	add    esp,0x10
    bff7:	84 c0                	test   al,al
    bff9:	74 c8                	je     bfc3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    bffb:	31 ff                	xor    edi,edi
    bffd:	3c 25                	cmp    al,0x25
    bfff:	8d 77 01             	lea    esi,[edi+0x1]
    c002:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    c006:	75 30                	jne    c038 <_Z6printfItJttEEvPKcT_DpT0_+0xe8>
    c008:	90                   	nop
    c009:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c010:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    c013:	3c 25                	cmp    al,0x25
    c015:	0f 84 9d 00 00 00    	je     c0b8 <_Z6printfItJttEEvPKcT_DpT0_+0x168>
    c01b:	84 c0                	test   al,al
    c01d:	75 39                	jne    c058 <_Z6printfItJttEEvPKcT_DpT0_+0x108>
    c01f:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    c024:	8d 77 02             	lea    esi,[edi+0x2]
    c027:	84 c0                	test   al,al
    c029:	74 98                	je     bfc3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c02b:	89 f7                	mov    edi,esi
    c02d:	8d 77 01             	lea    esi,[edi+0x1]
    c030:	3c 25                	cmp    al,0x25
    c032:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    c036:	74 d8                	je     c010 <_Z6printfItJttEEvPKcT_DpT0_+0xc0>
    c038:	83 ec 0c             	sub    esp,0xc
    c03b:	50                   	push   eax
    c03c:	e8 0f ee ff ff       	call   ae50 <_Z7putcharc>
    c041:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    c044:	83 c4 10             	add    esp,0x10
    c047:	84 c0                	test   al,al
    c049:	0f 84 74 ff ff ff    	je     bfc3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c04f:	89 f7                	mov    edi,esi
    c051:	eb da                	jmp    c02d <_Z6printfItJttEEvPKcT_DpT0_+0xdd>
    c053:	90                   	nop
    c054:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c058:	83 ec 08             	sub    esp,0x8
    c05b:	8d 44 24 26          	lea    eax,[esp+0x26]
    c05f:	50                   	push   eax
    c060:	53                   	push   ebx
    c061:	e8 3a fd ff ff       	call   bda0 <_Z14_manage_escapeItEiPKcPT_>
    c066:	5a                   	pop    edx
    c067:	01 c6                	add    esi,eax
    c069:	59                   	pop    ecx
    c06a:	01 f5                	add    ebp,esi
    c06c:	ff 74 24 0c          	push   DWORD PTR [esp+0xc]
    c070:	55                   	push   ebp
    c071:	e8 1a fe ff ff       	call   be90 <_Z6printfItEvPKcT_>
    c076:	83 c4 10             	add    esp,0x10
    c079:	83 c4 2c             	add    esp,0x2c
    c07c:	5b                   	pop    ebx
    c07d:	5e                   	pop    esi
    c07e:	5f                   	pop    edi
    c07f:	5d                   	pop    ebp
    c080:	c3                   	ret    
    c081:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c088:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    c08c:	83 ec 0c             	sub    esp,0xc
    c08f:	6a 25                	push   0x25
    c091:	e8 ba ed ff ff       	call   ae50 <_Z7putcharc>
    c096:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    c09a:	83 c4 10             	add    esp,0x10
    c09d:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    c0a2:	8d 79 02             	lea    edi,[ecx+0x2]
    c0a5:	84 c0                	test   al,al
    c0a7:	0f 84 16 ff ff ff    	je     bfc3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c0ad:	89 f9                	mov    ecx,edi
    c0af:	e9 f1 fe ff ff       	jmp    bfa5 <_Z6printfItJttEEvPKcT_DpT0_+0x55>
    c0b4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c0b8:	83 ec 0c             	sub    esp,0xc
    c0bb:	8d 77 02             	lea    esi,[edi+0x2]
    c0be:	6a 25                	push   0x25
    c0c0:	e8 8b ed ff ff       	call   ae50 <_Z7putcharc>
    c0c5:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    c0ca:	83 c4 10             	add    esp,0x10
    c0cd:	84 c0                	test   al,al
    c0cf:	0f 84 ee fe ff ff    	je     bfc3 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    c0d5:	89 f7                	mov    edi,esi
    c0d7:	e9 51 ff ff ff       	jmp    c02d <_Z6printfItJttEEvPKcT_DpT0_+0xdd>

Disassembly of section .text._Z14_manage_escapeIhEiPKcPT_:

0000c0e0 <_Z14_manage_escapeIhEiPKcPT_>:
    c0e0:	83 ec 0c             	sub    esp,0xc
    c0e3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c0e7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c0ea:	83 e8 42             	sub    eax,0x42
    c0ed:	3c 36                	cmp    al,0x36
    c0ef:	77 2c                	ja     c11d <_Z14_manage_escapeIhEiPKcPT_+0x3d>
    c0f1:	0f b6 c0             	movzx  eax,al
    c0f4:	ff 24 85 48 e5 00 00 	jmp    DWORD PTR [eax*4+0xe548]
    c0fb:	90                   	nop
    c0fc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c100:	83 ec 0c             	sub    esp,0xc
    c103:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c107:	ff 30                	push   DWORD PTR [eax]
    c109:	e8 a2 ed ff ff       	call   aeb0 <_Z6putstrPc>
    c10e:	83 c4 10             	add    esp,0x10
    c111:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c118:	b8 01 00 00 00       	mov    eax,0x1
    c11d:	83 c4 0c             	add    esp,0xc
    c120:	c3                   	ret    
    c121:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c128:	83 ec 0c             	sub    esp,0xc
    c12b:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c12f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c132:	50                   	push   eax
    c133:	e8 68 ed ff ff       	call   aea0 <_Z6putbini>
    c138:	83 c4 10             	add    esp,0x10
    c13b:	eb db                	jmp    c118 <_Z14_manage_escapeIhEiPKcPT_+0x38>
    c13d:	8d 76 00             	lea    esi,[esi+0x0]
    c140:	83 ec 0c             	sub    esp,0xc
    c143:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c147:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c14a:	50                   	push   eax
    c14b:	e8 40 ed ff ff       	call   ae90 <_Z6putocti>
    c150:	83 c4 10             	add    esp,0x10
    c153:	eb c3                	jmp    c118 <_Z14_manage_escapeIhEiPKcPT_+0x38>
    c155:	8d 76 00             	lea    esi,[esi+0x0]
    c158:	83 ec 0c             	sub    esp,0xc
    c15b:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c15f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c162:	50                   	push   eax
    c163:	e8 18 ed ff ff       	call   ae80 <_Z6puthexi>
    c168:	83 c4 10             	add    esp,0x10
    c16b:	eb ab                	jmp    c118 <_Z14_manage_escapeIhEiPKcPT_+0x38>
    c16d:	8d 76 00             	lea    esi,[esi+0x0]
    c170:	83 ec 0c             	sub    esp,0xc
    c173:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c177:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c17a:	50                   	push   eax
    c17b:	e8 d0 ec ff ff       	call   ae50 <_Z7putcharc>
    c180:	83 c4 10             	add    esp,0x10
    c183:	eb 93                	jmp    c118 <_Z14_manage_escapeIhEiPKcPT_+0x38>
    c185:	8d 76 00             	lea    esi,[esi+0x0]
    c188:	83 ec 0c             	sub    esp,0xc
    c18b:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c18f:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c192:	50                   	push   eax
    c193:	e8 d8 ec ff ff       	call   ae70 <_Z6putdeci>
    c198:	83 c4 10             	add    esp,0x10
    c19b:	e9 78 ff ff ff       	jmp    c118 <_Z14_manage_escapeIhEiPKcPT_+0x38>
    c1a0:	83 ec 0c             	sub    esp,0xc
    c1a3:	68 44 e5 00 00       	push   0xe544
    c1a8:	e8 23 ed ff ff       	call   aed0 <_Z6printfPKc>
    c1ad:	58                   	pop    eax
    c1ae:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c1b2:	ff 30                	push   DWORD PTR [eax]
    c1b4:	e8 c7 ec ff ff       	call   ae80 <_Z6puthexi>
    c1b9:	83 c4 10             	add    esp,0x10
    c1bc:	e9 57 ff ff ff       	jmp    c118 <_Z14_manage_escapeIhEiPKcPT_+0x38>

Disassembly of section .text._Z14_manage_escapeIiEiPKcPT_:

0000c1d0 <_Z14_manage_escapeIiEiPKcPT_>:
    c1d0:	83 ec 0c             	sub    esp,0xc
    c1d3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    c1d7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    c1da:	83 e8 42             	sub    eax,0x42
    c1dd:	3c 36                	cmp    al,0x36
    c1df:	77 2c                	ja     c20d <_Z14_manage_escapeIiEiPKcPT_+0x3d>
    c1e1:	0f b6 c0             	movzx  eax,al
    c1e4:	ff 24 85 24 e6 00 00 	jmp    DWORD PTR [eax*4+0xe624]
    c1eb:	90                   	nop
    c1ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c1f0:	83 ec 0c             	sub    esp,0xc
    c1f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c1f7:	ff 30                	push   DWORD PTR [eax]
    c1f9:	e8 b2 ec ff ff       	call   aeb0 <_Z6putstrPc>
    c1fe:	83 c4 10             	add    esp,0x10
    c201:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c208:	b8 01 00 00 00       	mov    eax,0x1
    c20d:	83 c4 0c             	add    esp,0xc
    c210:	c3                   	ret    
    c211:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c218:	83 ec 0c             	sub    esp,0xc
    c21b:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c21f:	ff 30                	push   DWORD PTR [eax]
    c221:	e8 7a ec ff ff       	call   aea0 <_Z6putbini>
    c226:	83 c4 10             	add    esp,0x10
    c229:	eb dd                	jmp    c208 <_Z14_manage_escapeIiEiPKcPT_+0x38>
    c22b:	90                   	nop
    c22c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c230:	83 ec 0c             	sub    esp,0xc
    c233:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c237:	ff 30                	push   DWORD PTR [eax]
    c239:	e8 52 ec ff ff       	call   ae90 <_Z6putocti>
    c23e:	83 c4 10             	add    esp,0x10
    c241:	eb c5                	jmp    c208 <_Z14_manage_escapeIiEiPKcPT_+0x38>
    c243:	90                   	nop
    c244:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c248:	83 ec 0c             	sub    esp,0xc
    c24b:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c24f:	ff 30                	push   DWORD PTR [eax]
    c251:	e8 2a ec ff ff       	call   ae80 <_Z6puthexi>
    c256:	83 c4 10             	add    esp,0x10
    c259:	eb ad                	jmp    c208 <_Z14_manage_escapeIiEiPKcPT_+0x38>
    c25b:	90                   	nop
    c25c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c260:	83 ec 0c             	sub    esp,0xc
    c263:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c267:	0f be 00             	movsx  eax,BYTE PTR [eax]
    c26a:	50                   	push   eax
    c26b:	e8 e0 eb ff ff       	call   ae50 <_Z7putcharc>
    c270:	83 c4 10             	add    esp,0x10
    c273:	eb 93                	jmp    c208 <_Z14_manage_escapeIiEiPKcPT_+0x38>
    c275:	8d 76 00             	lea    esi,[esi+0x0]
    c278:	83 ec 0c             	sub    esp,0xc
    c27b:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c27f:	ff 30                	push   DWORD PTR [eax]
    c281:	e8 ea eb ff ff       	call   ae70 <_Z6putdeci>
    c286:	83 c4 10             	add    esp,0x10
    c289:	e9 7a ff ff ff       	jmp    c208 <_Z14_manage_escapeIiEiPKcPT_+0x38>
    c28e:	66 90                	xchg   ax,ax
    c290:	83 ec 0c             	sub    esp,0xc
    c293:	68 44 e5 00 00       	push   0xe544
    c298:	e8 33 ec ff ff       	call   aed0 <_Z6printfPKc>
    c29d:	58                   	pop    eax
    c29e:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    c2a2:	ff 30                	push   DWORD PTR [eax]
    c2a4:	e8 d7 eb ff ff       	call   ae80 <_Z6puthexi>
    c2a9:	83 c4 10             	add    esp,0x10
    c2ac:	e9 57 ff ff ff       	jmp    c208 <_Z14_manage_escapeIiEiPKcPT_+0x38>
