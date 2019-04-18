
stage2.elf:     file format elf32-i386


Disassembly of section .text:

0000a000 <_ZZ8kernel_2vENUlPvjjS_E_4_FUNES_jjS_-0x10>:
    a000:	bd 00 00 80 00       	mov    ebp,0x800000
    a005:	89 ec                	mov    esp,ebp
    a007:	e8 34 00 00 00       	call   a040 <kernel_2>
    a00c:	eb fe                	jmp    a00c <_ZZ8kernel_2vENUlPvjjS_E_4_FUNES_jjS_-0x4>
    a00e:	66 90                	xchg   ax,ax

0000a010 <_ZZ8kernel_2vENUlPvjjS_E_4_FUNES_jjS_>:
    a010:	83 ec 14             	sub    esp,0x14
    a013:	31 d2                	xor    edx,edx
    a015:	8b 44 24 24          	mov    eax,DWORD PTR [esp+0x24]
    a019:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    a01c:	50                   	push   eax
    a01d:	6a 00                	push   0x0
    a01f:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    a023:	8b 44 24 28          	mov    eax,DWORD PTR [esp+0x28]
    a027:	52                   	push   edx
    a028:	50                   	push   eax
    a029:	ff 74 24 2c          	push   DWORD PTR [esp+0x2c]
    a02d:	e8 7e 08 00 00       	call   a8b0 <_ZN3ata4readEPvyjhb>
    a032:	83 f0 01             	xor    eax,0x1
    a035:	83 c4 2c             	add    esp,0x2c
    a038:	0f b6 c0             	movzx  eax,al
    a03b:	f7 d8                	neg    eax
    a03d:	c3                   	ret    
    a03e:	66 90                	xchg   ax,ax

0000a040 <kernel_2>:
    a040:	53                   	push   ebx
    a041:	83 ec 18             	sub    esp,0x18
    a044:	e8 97 1d 00 00       	call   bde0 <_ZN6serial4initEv>
    a049:	83 ec 0c             	sub    esp,0xc
    a04c:	68 20 03 01 00       	push   0x10320
    a051:	e8 7a 1d 00 00       	call   bdd0 <_Z6printfPKc>
    a056:	c7 04 24 30 09 01 00 	mov    DWORD PTR [esp],0x10930
    a05d:	e8 6e 1d 00 00       	call   bdd0 <_Z6printfPKc>
    a062:	e8 a9 02 00 00       	call   a310 <check_A20_on>
    a067:	83 c4 10             	add    esp,0x10
    a06a:	85 c0                	test   eax,eax
    a06c:	0f 85 9d 00 00 00    	jne    a10f <kernel_2+0xcf>
    a072:	e8 b9 0e 00 00       	call   af30 <_ZN6paging18init_kernel_pagingEv>
    a077:	c6 44 24 0f 00       	mov    BYTE PTR [esp+0xf],0x0
    a07c:	83 ec 04             	sub    esp,0x4
    a07f:	6a 00                	push   0x0
    a081:	8d 5c 24 17          	lea    ebx,[esp+0x17]
    a085:	53                   	push   ebx
    a086:	6a 00                	push   0x0
    a088:	e8 83 0a 00 00       	call   ab10 <_ZN3ata12sendIdentifyEhRbb>
    a08d:	83 c4 10             	add    esp,0x10
    a090:	84 c0                	test   al,al
    a092:	74 60                	je     a0f4 <kernel_2+0xb4>
    a094:	80 7c 24 0f 00       	cmp    BYTE PTR [esp+0xf],0x0
    a099:	75 3e                	jne    a0d9 <kernel_2+0x99>
    a09b:	83 ec 04             	sub    esp,0x4
    a09e:	53                   	push   ebx
    a09f:	68 10 a0 00 00       	push   0xa010
    a0a4:	68 00 00 01 00       	push   0x10000
    a0a9:	e8 c2 12 00 00       	call   b370 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_>
    a0ae:	83 c4 10             	add    esp,0x10
    a0b1:	85 c0                	test   eax,eax
    a0b3:	75 09                	jne    a0be <kernel_2+0x7e>
    a0b5:	b8 00 00 00 c1       	mov    eax,0xc1000000
    a0ba:	ff d0                	call   eax
    a0bc:	eb fe                	jmp    a0bc <kernel_2+0x7c>
    a0be:	68 14 00 01 00       	push   0x10014
    a0c3:	6a 3e                	push   0x3e
    a0c5:	68 3a 09 01 00       	push   0x1093a
    a0ca:	68 d0 03 01 00       	push   0x103d0
    a0cf:	e8 fc 2f 00 00       	call   d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>
    a0d4:	83 c4 10             	add    esp,0x10
    a0d7:	eb fe                	jmp    a0d7 <kernel_2+0x97>
    a0d9:	68 14 00 01 00       	push   0x10014
    a0de:	6a 2b                	push   0x2b
    a0e0:	68 3a 09 01 00       	push   0x1093a
    a0e5:	68 98 03 01 00       	push   0x10398
    a0ea:	e8 e1 2f 00 00       	call   d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>
    a0ef:	83 c4 10             	add    esp,0x10
    a0f2:	eb a7                	jmp    a09b <kernel_2+0x5b>
    a0f4:	68 14 00 01 00       	push   0x10014
    a0f9:	6a 28                	push   0x28
    a0fb:	68 3a 09 01 00       	push   0x1093a
    a100:	68 74 03 01 00       	push   0x10374
    a105:	e8 c6 2f 00 00       	call   d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>
    a10a:	83 c4 10             	add    esp,0x10
    a10d:	eb 85                	jmp    a094 <kernel_2+0x54>
    a10f:	e8 1a 02 00 00       	call   a32e <enable_A20>
    a114:	e9 59 ff ff ff       	jmp    a072 <kernel_2+0x32>
    a119:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000a120 <_Z19self_check_test_atab>:
    a120:	55                   	push   ebp
    a121:	57                   	push   edi
    a122:	56                   	push   esi
    a123:	53                   	push   ebx
    a124:	81 ec 2c 0a 00 00    	sub    esp,0xa2c
    a12a:	8b 94 24 40 0a 00 00 	mov    edx,DWORD PTR [esp+0xa40]
    a131:	8d 84 24 20 0a 00 00 	lea    eax,[esp+0xa20]
    a138:	8d 5c 24 20          	lea    ebx,[esp+0x20]
    a13c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a140:	c6 03 00             	mov    BYTE PTR [ebx],0x0
    a143:	83 c3 01             	add    ebx,0x1
    a146:	39 c3                	cmp    ebx,eax
    a148:	75 f6                	jne    a140 <_Z19self_check_test_atab+0x20>
    a14a:	0f b6 c2             	movzx  eax,dl
    a14d:	c7 44 24 1c 00 00 00 	mov    DWORD PTR [esp+0x1c],0x0
    a154:	00 
    a155:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    a159:	83 ec 0c             	sub    esp,0xc
    a15c:	be 00 02 00 00       	mov    esi,0x200
    a161:	8b 7c 24 28          	mov    edi,DWORD PTR [esp+0x28]
    a165:	57                   	push   edi
    a166:	68 00 00 01 00       	push   0x10000
    a16b:	6a 78                	push   0x78
    a16d:	68 3a 09 01 00       	push   0x1093a
    a172:	68 04 04 01 00       	push   0x10404
    a177:	e8 c4 36 00 00       	call   d840 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_>
    a17c:	8d 44 24 40          	lea    eax,[esp+0x40]
    a180:	01 f8                	add    eax,edi
    a182:	31 ff                	xor    edi,edi
    a184:	89 44 24 34          	mov    DWORD PTR [esp+0x34],eax
    a188:	83 c4 20             	add    esp,0x20
    a18b:	c7 44 24 10 00 00 00 	mov    DWORD PTR [esp+0x10],0x0
    a192:	00 
    a193:	83 ec 0c             	sub    esp,0xc
    a196:	8b 6c 24 1c          	mov    ebp,DWORD PTR [esp+0x1c]
    a19a:	55                   	push   ebp
    a19b:	68 00 00 01 00       	push   0x10000
    a1a0:	6a 7a                	push   0x7a
    a1a2:	68 3a 09 01 00       	push   0x1093a
    a1a7:	68 54 09 01 00       	push   0x10954
    a1ac:	e8 8f 36 00 00       	call   d840 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_>
    a1b1:	83 c4 20             	add    esp,0x20
    a1b4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a1b8:	89 e9                	mov    ecx,ebp
    a1ba:	2b 4c 24 10          	sub    ecx,DWORD PTR [esp+0x10]
    a1be:	83 ec 08             	sub    esp,0x8
    a1c1:	ff 74 24 20          	push   DWORD PTR [esp+0x20]
    a1c5:	6a 00                	push   0x0
    a1c7:	51                   	push   ecx
    a1c8:	89 4c 24 20          	mov    DWORD PTR [esp+0x20],ecx
    a1cc:	57                   	push   edi
    a1cd:	56                   	push   esi
    a1ce:	ff 74 24 30          	push   DWORD PTR [esp+0x30]
    a1d2:	e8 d9 06 00 00       	call   a8b0 <_ZN3ata4readEPvyjhb>
    a1d7:	83 c4 20             	add    esp,0x20
    a1da:	84 c0                	test   al,al
    a1dc:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    a1e0:	0f 84 f2 00 00 00    	je     a2d8 <_Z19self_check_test_atab+0x1b8>
    a1e6:	8d 44 24 20          	lea    eax,[esp+0x20]
    a1ea:	31 d2                	xor    edx,edx
    a1ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a1f0:	80 38 01             	cmp    BYTE PTR [eax],0x1
    a1f3:	83 da ff             	sbb    edx,0xffffffff
    a1f6:	83 c0 01             	add    eax,0x1
    a1f9:	39 c3                	cmp    ebx,eax
    a1fb:	75 f3                	jne    a1f0 <_Z19self_check_test_atab+0xd0>
    a1fd:	39 ca                	cmp    edx,ecx
    a1ff:	75 4f                	jne    a250 <_Z19self_check_test_atab+0x130>
    a201:	8d 4c 24 20          	lea    ecx,[esp+0x20]
    a205:	8d 76 00             	lea    esi,[esi+0x0]
    a208:	c6 01 00             	mov    BYTE PTR [ecx],0x0
    a20b:	83 c1 01             	add    ecx,0x1
    a20e:	39 c8                	cmp    eax,ecx
    a210:	75 f6                	jne    a208 <_Z19self_check_test_atab+0xe8>
    a212:	83 c5 40             	add    ebp,0x40
    a215:	81 fd ff 03 00 00    	cmp    ebp,0x3ff
    a21b:	76 9b                	jbe    a1b8 <_Z19self_check_test_atab+0x98>
    a21d:	83 44 24 10 40       	add    DWORD PTR [esp+0x10],0x40
    a222:	83 c6 40             	add    esi,0x40
    a225:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    a229:	83 d7 00             	adc    edi,0x0
    a22c:	3d 00 04 00 00       	cmp    eax,0x400
    a231:	0f 85 5c ff ff ff    	jne    a193 <_Z19self_check_test_atab+0x73>
    a237:	83 44 24 1c 01       	add    DWORD PTR [esp+0x1c],0x1
    a23c:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    a240:	3d 00 02 00 00       	cmp    eax,0x200
    a245:	0f 85 0e ff ff ff    	jne    a159 <_Z19self_check_test_atab+0x39>
    a24b:	31 c0                	xor    eax,eax
    a24d:	eb 7e                	jmp    a2cd <_Z19self_check_test_atab+0x1ad>
    a24f:	90                   	nop
    a250:	89 c8                	mov    eax,ecx
    a252:	89 54 24 18          	mov    DWORD PTR [esp+0x18],edx
    a256:	83 ec 04             	sub    esp,0x4
    a259:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    a25d:	55                   	push   ebp
    a25e:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    a262:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    a266:	68 00 00 01 00       	push   0x10000
    a26b:	68 8a 00 00 00       	push   0x8a
    a270:	68 3a 09 01 00       	push   0x1093a
    a275:	68 58 04 01 00       	push   0x10458
    a27a:	e8 21 3c 00 00       	call   dea0 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_>
    a27f:	83 c4 18             	add    esp,0x18
    a282:	8b 4c 24 20          	mov    ecx,DWORD PTR [esp+0x20]
    a286:	51                   	push   ecx
    a287:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    a28b:	52                   	push   edx
    a28c:	68 00 00 01 00       	push   0x10000
    a291:	68 8b 00 00 00       	push   0x8b
    a296:	68 3a 09 01 00       	push   0x1093a
    a29b:	68 94 04 01 00       	push   0x10494
    a2a0:	e8 6b 38 00 00       	call   db10 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_>
    a2a5:	83 c4 14             	add    esp,0x14
    a2a8:	ff 74 24 20          	push   DWORD PTR [esp+0x20]
    a2ac:	68 00 00 01 00       	push   0x10000
    a2b1:	68 8c 00 00 00       	push   0x8c
    a2b6:	68 3a 09 01 00       	push   0x1093a
    a2bb:	68 c4 04 01 00       	push   0x104c4
    a2c0:	e8 5b 32 00 00       	call   d520 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_>
    a2c5:	83 c4 20             	add    esp,0x20
    a2c8:	b8 ff ff ff ff       	mov    eax,0xffffffff
    a2cd:	81 c4 2c 0a 00 00    	add    esp,0xa2c
    a2d3:	5b                   	pop    ebx
    a2d4:	5e                   	pop    esi
    a2d5:	5f                   	pop    edi
    a2d6:	5d                   	pop    ebp
    a2d7:	c3                   	ret    
    a2d8:	68 00 00 01 00       	push   0x10000
    a2dd:	6a 7f                	push   0x7f
    a2df:	68 3a 09 01 00       	push   0x1093a
    a2e4:	68 2c 04 01 00       	push   0x1042c
    a2e9:	e8 e2 2d 00 00       	call   d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>
    a2ee:	83 c4 10             	add    esp,0x10
    a2f1:	b8 ff ff ff ff       	mov    eax,0xffffffff
    a2f6:	81 c4 2c 0a 00 00    	add    esp,0xa2c
    a2fc:	5b                   	pop    ebx
    a2fd:	5e                   	pop    esi
    a2fe:	5f                   	pop    edi
    a2ff:	5d                   	pop    ebp
    a300:	c3                   	ret    
    a301:	66 90                	xchg   ax,ax
    a303:	66 90                	xchg   ax,ax
    a305:	66 90                	xchg   ax,ax
    a307:	66 90                	xchg   ax,ax
    a309:	66 90                	xchg   ax,ax
    a30b:	66 90                	xchg   ax,ax
    a30d:	66 90                	xchg   ax,ax
    a30f:	90                   	nop

0000a310 <check_A20_on>:
    a310:	60                   	pusha  
    a311:	bf 45 23 11 00       	mov    edi,0x112345
    a316:	be 45 23 01 00       	mov    esi,0x12345
    a31b:	89 36                	mov    DWORD PTR [esi],esi
    a31d:	89 3f                	mov    DWORD PTR [edi],edi
    a31f:	a7                   	cmps   DWORD PTR ds:[esi],DWORD PTR es:[edi]
    a320:	b8 00 00 00 00       	mov    eax,0x0
    a325:	75 05                	jne    a32c <check_A20_on.A20_on>
    a327:	b8 01 00 00 00       	mov    eax,0x1

0000a32c <check_A20_on.A20_on>:
    a32c:	61                   	popa   
    a32d:	c3                   	ret    

0000a32e <enable_A20>:
    a32e:	60                   	pusha  
    a32f:	e4 92                	in     al,0x92
    a331:	0c 02                	or     al,0x2
    a333:	e6 92                	out    0x92,al
    a335:	61                   	popa   
    a336:	c3                   	ret    
    a337:	66 90                	xchg   ax,ax
    a339:	66 90                	xchg   ax,ax
    a33b:	66 90                	xchg   ax,ax
    a33d:	66 90                	xchg   ax,ax
    a33f:	90                   	nop

0000a340 <__setCR4>:
    a340:	55                   	push   ebp
    a341:	89 e5                	mov    ebp,esp
    a343:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a346:	0f 22 e0             	mov    cr4,eax
    a349:	5d                   	pop    ebp
    a34a:	c3                   	ret    

0000a34b <__getCR4>:
    a34b:	0f 20 e0             	mov    eax,cr4
    a34e:	c3                   	ret    

0000a34f <__setCR3>:
    a34f:	55                   	push   ebp
    a350:	89 e5                	mov    ebp,esp
    a352:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a355:	0f 22 d8             	mov    cr3,eax
    a358:	5d                   	pop    ebp
    a359:	c3                   	ret    

0000a35a <__getCR3>:
    a35a:	0f 20 d8             	mov    eax,cr3
    a35d:	c3                   	ret    

0000a35e <__setCR2>:
    a35e:	55                   	push   ebp
    a35f:	89 e5                	mov    ebp,esp
    a361:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a364:	0f 22 d0             	mov    cr2,eax
    a367:	5d                   	pop    ebp
    a368:	c3                   	ret    

0000a369 <__getCR2>:
    a369:	0f 20 d0             	mov    eax,cr2
    a36c:	c3                   	ret    

0000a36d <__setCR0>:
    a36d:	55                   	push   ebp
    a36e:	89 e5                	mov    ebp,esp
    a370:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a373:	0f 22 c0             	mov    cr0,eax
    a376:	5d                   	pop    ebp
    a377:	c3                   	ret    

0000a378 <__getCR0>:
    a378:	0f 20 c0             	mov    eax,cr0
    a37b:	c3                   	ret    
    a37c:	66 90                	xchg   ax,ax
    a37e:	66 90                	xchg   ax,ax

0000a380 <__isCpuidSuported>:
    a380:	9c                   	pushf  
    a381:	9c                   	pushf  
    a382:	81 34 24 00 00 20 00 	xor    DWORD PTR [esp],0x200000
    a389:	9d                   	popf   
    a38a:	9c                   	pushf  
    a38b:	58                   	pop    eax
    a38c:	33 04 24             	xor    eax,DWORD PTR [esp]
    a38f:	9d                   	popf   
    a390:	25 00 00 20 00       	and    eax,0x200000
    a395:	c3                   	ret    

0000a396 <__getCpuidVendor>:
    a396:	55                   	push   ebp
    a397:	89 e5                	mov    ebp,esp
    a399:	53                   	push   ebx
    a39a:	51                   	push   ecx
    a39b:	52                   	push   edx
    a39c:	b8 00 00 00 00       	mov    eax,0x0
    a3a1:	0f a2                	cpuid  
    a3a3:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a3a6:	89 18                	mov    DWORD PTR [eax],ebx
    a3a8:	89 50 04             	mov    DWORD PTR [eax+0x4],edx
    a3ab:	89 48 08             	mov    DWORD PTR [eax+0x8],ecx
    a3ae:	5a                   	pop    edx
    a3af:	59                   	pop    ecx
    a3b0:	5b                   	pop    ebx
    a3b1:	5d                   	pop    ebp
    a3b2:	c3                   	ret    

0000a3b3 <__getCpuidFeatures>:
    a3b3:	55                   	push   ebp
    a3b4:	89 e5                	mov    ebp,esp
    a3b6:	51                   	push   ecx
    a3b7:	52                   	push   edx
    a3b8:	b8 01 00 00 00       	mov    eax,0x1
    a3bd:	0f a2                	cpuid  
    a3bf:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    a3c2:	89 10                	mov    DWORD PTR [eax],edx
    a3c4:	89 48 04             	mov    DWORD PTR [eax+0x4],ecx
    a3c7:	5a                   	pop    edx
    a3c8:	59                   	pop    ecx
    a3c9:	5d                   	pop    ebp
    a3ca:	c3                   	ret    
    a3cb:	66 90                	xchg   ax,ax
    a3cd:	66 90                	xchg   ax,ax
    a3cf:	90                   	nop

0000a3d0 <_ZN3ata7waitBSYEv>:
    a3d0:	83 ec 0c             	sub    esp,0xc
    a3d3:	90                   	nop
    a3d4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a3d8:	83 ec 0c             	sub    esp,0xc
    a3db:	68 f7 01 00 00       	push   0x1f7
    a3e0:	e8 4b 1b 00 00       	call   bf30 <_Z3inbt>
    a3e5:	83 c4 10             	add    esp,0x10
    a3e8:	84 c0                	test   al,al
    a3ea:	78 ec                	js     a3d8 <_ZN3ata7waitBSYEv+0x8>
    a3ec:	83 c4 0c             	add    esp,0xc
    a3ef:	c3                   	ret    

0000a3f0 <_ZN3ata7waitDSQEv>:
    a3f0:	83 ec 0c             	sub    esp,0xc
    a3f3:	eb 07                	jmp    a3fc <_ZN3ata7waitDSQEv+0xc>
    a3f5:	8d 76 00             	lea    esi,[esi+0x0]
    a3f8:	a8 08                	test   al,0x8
    a3fa:	75 24                	jne    a420 <_ZN3ata7waitDSQEv+0x30>
    a3fc:	83 ec 0c             	sub    esp,0xc
    a3ff:	68 f7 01 00 00       	push   0x1f7
    a404:	e8 27 1b 00 00       	call   bf30 <_Z3inbt>
    a409:	83 c4 10             	add    esp,0x10
    a40c:	a8 01                	test   al,0x1
    a40e:	74 e8                	je     a3f8 <_ZN3ata7waitDSQEv+0x8>
    a410:	31 c0                	xor    eax,eax
    a412:	83 c4 0c             	add    esp,0xc
    a415:	c3                   	ret    
    a416:	8d 76 00             	lea    esi,[esi+0x0]
    a419:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    a420:	b8 01 00 00 00       	mov    eax,0x1
    a425:	83 c4 0c             	add    esp,0xc
    a428:	c3                   	ret    
    a429:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000a430 <_ZN3ata12lba28PIOReadEPvjhh>:
    a430:	55                   	push   ebp
    a431:	57                   	push   edi
    a432:	56                   	push   esi
    a433:	53                   	push   ebx
    a434:	83 ec 24             	sub    esp,0x24
    a437:	8b 5c 24 3c          	mov    ebx,DWORD PTR [esp+0x3c]
    a43b:	0f b6 54 24 44       	movzx  edx,BYTE PTR [esp+0x44]
    a440:	8b 7c 24 40          	mov    edi,DWORD PTR [esp+0x40]
    a444:	89 d8                	mov    eax,ebx
    a446:	c1 e8 18             	shr    eax,0x18
    a449:	c1 e2 04             	shl    edx,0x4
    a44c:	83 ca e0             	or     edx,0xffffffe0
    a44f:	83 e0 0f             	and    eax,0xf
    a452:	09 d0                	or     eax,edx
    a454:	0f b6 c0             	movzx  eax,al
    a457:	50                   	push   eax
    a458:	68 f6 01 00 00       	push   0x1f6
    a45d:	e8 7e 1a 00 00       	call   bee0 <_Z4outbth>
    a462:	58                   	pop    eax
    a463:	5a                   	pop    edx
    a464:	6a 00                	push   0x0
    a466:	68 f1 01 00 00       	push   0x1f1
    a46b:	e8 70 1a 00 00       	call   bee0 <_Z4outbth>
    a470:	59                   	pop    ecx
    a471:	89 f8                	mov    eax,edi
    a473:	5e                   	pop    esi
    a474:	0f b6 f8             	movzx  edi,al
    a477:	57                   	push   edi
    a478:	68 f2 01 00 00       	push   0x1f2
    a47d:	e8 5e 1a 00 00       	call   bee0 <_Z4outbth>
    a482:	5d                   	pop    ebp
    a483:	58                   	pop    eax
    a484:	0f b6 c3             	movzx  eax,bl
    a487:	50                   	push   eax
    a488:	68 f3 01 00 00       	push   0x1f3
    a48d:	e8 4e 1a 00 00       	call   bee0 <_Z4outbth>
    a492:	58                   	pop    eax
    a493:	5a                   	pop    edx
    a494:	0f b6 c7             	movzx  eax,bh
    a497:	50                   	push   eax
    a498:	68 f4 01 00 00       	push   0x1f4
    a49d:	e8 3e 1a 00 00       	call   bee0 <_Z4outbth>
    a4a2:	89 d8                	mov    eax,ebx
    a4a4:	59                   	pop    ecx
    a4a5:	c1 e8 10             	shr    eax,0x10
    a4a8:	5e                   	pop    esi
    a4a9:	0f b6 c0             	movzx  eax,al
    a4ac:	50                   	push   eax
    a4ad:	68 f5 01 00 00       	push   0x1f5
    a4b2:	e8 29 1a 00 00       	call   bee0 <_Z4outbth>
    a4b7:	83 c4 10             	add    esp,0x10
    a4ba:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a4c0:	83 ec 0c             	sub    esp,0xc
    a4c3:	68 f7 01 00 00       	push   0x1f7
    a4c8:	e8 63 1a 00 00       	call   bf30 <_Z3inbt>
    a4cd:	83 c4 10             	add    esp,0x10
    a4d0:	84 c0                	test   al,al
    a4d2:	78 ec                	js     a4c0 <_ZN3ata12lba28PIOReadEPvjhh+0x90>
    a4d4:	83 ec 08             	sub    esp,0x8
    a4d7:	6a 20                	push   0x20
    a4d9:	68 f7 01 00 00       	push   0x1f7
    a4de:	e8 fd 19 00 00       	call   bee0 <_Z4outbth>
    a4e3:	83 c4 10             	add    esp,0x10
    a4e6:	85 ff                	test   edi,edi
    a4e8:	0f 84 b0 00 00 00    	je     a59e <_ZN3ata12lba28PIOReadEPvjhh+0x16e>
    a4ee:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    a4f2:	31 f6                	xor    esi,esi
    a4f4:	05 00 02 00 00       	add    eax,0x200
    a4f9:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a4fd:	8d 76 00             	lea    esi,[esi+0x0]
    a500:	83 ec 0c             	sub    esp,0xc
    a503:	68 f7 01 00 00       	push   0x1f7
    a508:	e8 23 1a 00 00       	call   bf30 <_Z3inbt>
    a50d:	83 c4 10             	add    esp,0x10
    a510:	84 c0                	test   al,al
    a512:	78 ec                	js     a500 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a514:	83 ec 0c             	sub    esp,0xc
    a517:	68 f6 03 00 00       	push   0x3f6
    a51c:	e8 0f 1a 00 00       	call   bf30 <_Z3inbt>
    a521:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a528:	e8 03 1a 00 00       	call   bf30 <_Z3inbt>
    a52d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a534:	e8 f7 19 00 00       	call   bf30 <_Z3inbt>
    a539:	83 c4 10             	add    esp,0x10
    a53c:	eb 06                	jmp    a544 <_ZN3ata12lba28PIOReadEPvjhh+0x114>
    a53e:	66 90                	xchg   ax,ax
    a540:	a8 08                	test   al,0x8
    a542:	75 1e                	jne    a562 <_ZN3ata12lba28PIOReadEPvjhh+0x132>
    a544:	83 ec 0c             	sub    esp,0xc
    a547:	68 f7 01 00 00       	push   0x1f7
    a54c:	e8 df 19 00 00       	call   bf30 <_Z3inbt>
    a551:	83 c4 10             	add    esp,0x10
    a554:	a8 01                	test   al,0x1
    a556:	74 e8                	je     a540 <_ZN3ata12lba28PIOReadEPvjhh+0x110>
    a558:	83 c4 1c             	add    esp,0x1c
    a55b:	31 c0                	xor    eax,eax
    a55d:	5b                   	pop    ebx
    a55e:	5e                   	pop    esi
    a55f:	5f                   	pop    edi
    a560:	5d                   	pop    ebp
    a561:	c3                   	ret    
    a562:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a566:	89 f3                	mov    ebx,esi
    a568:	c1 e3 09             	shl    ebx,0x9
    a56b:	01 dd                	add    ebp,ebx
    a56d:	03 5c 24 0c          	add    ebx,DWORD PTR [esp+0xc]
    a571:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a578:	83 ec 0c             	sub    esp,0xc
    a57b:	83 c5 02             	add    ebp,0x2
    a57e:	68 f0 01 00 00       	push   0x1f0
    a583:	e8 b8 19 00 00       	call   bf40 <_Z3inwt>
    a588:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    a58c:	83 c4 10             	add    esp,0x10
    a58f:	39 dd                	cmp    ebp,ebx
    a591:	75 e5                	jne    a578 <_ZN3ata12lba28PIOReadEPvjhh+0x148>
    a593:	83 c6 01             	add    esi,0x1
    a596:	39 f7                	cmp    edi,esi
    a598:	0f 85 62 ff ff ff    	jne    a500 <_ZN3ata12lba28PIOReadEPvjhh+0xd0>
    a59e:	83 c4 1c             	add    esp,0x1c
    a5a1:	b8 01 00 00 00       	mov    eax,0x1
    a5a6:	5b                   	pop    ebx
    a5a7:	5e                   	pop    esi
    a5a8:	5f                   	pop    edi
    a5a9:	5d                   	pop    ebp
    a5aa:	c3                   	ret    
    a5ab:	90                   	nop
    a5ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000a5b0 <_ZN3ata9lba28ReadEPvyjh>:
    a5b0:	55                   	push   ebp
    a5b1:	57                   	push   edi
    a5b2:	56                   	push   esi
    a5b3:	53                   	push   ebx
    a5b4:	83 ec 1c             	sub    esp,0x1c
    a5b7:	8b 74 24 3c          	mov    esi,DWORD PTR [esp+0x3c]
    a5bb:	8b 4c 24 30          	mov    ecx,DWORD PTR [esp+0x30]
    a5bf:	8b 7c 24 34          	mov    edi,DWORD PTR [esp+0x34]
    a5c3:	8b 6c 24 38          	mov    ebp,DWORD PTR [esp+0x38]
    a5c7:	8b 44 24 40          	mov    eax,DWORD PTR [esp+0x40]
    a5cb:	85 f6                	test   esi,esi
    a5cd:	74 59                	je     a628 <_ZN3ata9lba28ReadEPvyjh+0x78>
    a5cf:	0f b6 c0             	movzx  eax,al
    a5d2:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a5d6:	eb 1b                	jmp    a5f3 <_ZN3ata9lba28ReadEPvyjh+0x43>
    a5d8:	90                   	nop
    a5d9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a5e0:	8b 4c 24 08          	mov    ecx,DWORD PTR [esp+0x8]
    a5e4:	31 d2                	xor    edx,edx
    a5e6:	01 df                	add    edi,ebx
    a5e8:	11 d5                	adc    ebp,edx
    a5ea:	c1 e3 09             	shl    ebx,0x9
    a5ed:	01 d9                	add    ecx,ebx
    a5ef:	85 f6                	test   esi,esi
    a5f1:	74 35                	je     a628 <_ZN3ata9lba28ReadEPvyjh+0x78>
    a5f3:	81 fe ff 00 00 00    	cmp    esi,0xff
    a5f9:	bb ff 00 00 00       	mov    ebx,0xff
    a5fe:	ff 74 24 0c          	push   DWORD PTR [esp+0xc]
    a602:	0f 46 de             	cmovbe ebx,esi
    a605:	53                   	push   ebx
    a606:	57                   	push   edi
    a607:	29 de                	sub    esi,ebx
    a609:	51                   	push   ecx
    a60a:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    a60e:	e8 1d fe ff ff       	call   a430 <_ZN3ata12lba28PIOReadEPvjhh>
    a613:	83 c4 10             	add    esp,0x10
    a616:	84 c0                	test   al,al
    a618:	75 c6                	jne    a5e0 <_ZN3ata9lba28ReadEPvyjh+0x30>
    a61a:	83 c4 1c             	add    esp,0x1c
    a61d:	5b                   	pop    ebx
    a61e:	5e                   	pop    esi
    a61f:	5f                   	pop    edi
    a620:	5d                   	pop    ebp
    a621:	c3                   	ret    
    a622:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    a628:	83 c4 1c             	add    esp,0x1c
    a62b:	b8 01 00 00 00       	mov    eax,0x1
    a630:	5b                   	pop    ebx
    a631:	5e                   	pop    esi
    a632:	5f                   	pop    edi
    a633:	5d                   	pop    ebp
    a634:	c3                   	ret    
    a635:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a639:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000a640 <_ZN3ata12lba48PIOReadEPvyth>:
    a640:	55                   	push   ebp
    a641:	57                   	push   edi
    a642:	56                   	push   esi
    a643:	53                   	push   ebx
    a644:	83 ec 24             	sub    esp,0x24
    a647:	0f b6 44 24 48       	movzx  eax,BYTE PTR [esp+0x48]
    a64c:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    a650:	8b 7c 24 3c          	mov    edi,DWORD PTR [esp+0x3c]
    a654:	8b 5c 24 44          	mov    ebx,DWORD PTR [esp+0x44]
    a658:	c1 e0 04             	shl    eax,0x4
    a65b:	83 c8 e0             	or     eax,0xffffffe0
    a65e:	0f b6 c0             	movzx  eax,al
    a661:	50                   	push   eax
    a662:	68 f6 01 00 00       	push   0x1f6
    a667:	e8 74 18 00 00       	call   bee0 <_Z4outbth>
    a66c:	58                   	pop    eax
    a66d:	5a                   	pop    edx
    a66e:	6a 00                	push   0x0
    a670:	68 f1 01 00 00       	push   0x1f1
    a675:	e8 66 18 00 00       	call   bee0 <_Z4outbth>
    a67a:	59                   	pop    ecx
    a67b:	5e                   	pop    esi
    a67c:	0f b6 c7             	movzx  eax,bh
    a67f:	50                   	push   eax
    a680:	68 f2 01 00 00       	push   0x1f2
    a685:	e8 56 18 00 00       	call   bee0 <_Z4outbth>
    a68a:	58                   	pop    eax
    a68b:	89 f8                	mov    eax,edi
    a68d:	0f ac e8 18          	shrd   eax,ebp,0x18
    a691:	5a                   	pop    edx
    a692:	0f b6 c0             	movzx  eax,al
    a695:	50                   	push   eax
    a696:	68 f3 01 00 00       	push   0x1f3
    a69b:	e8 40 18 00 00       	call   bee0 <_Z4outbth>
    a6a0:	5e                   	pop    esi
    a6a1:	58                   	pop    eax
    a6a2:	89 e8                	mov    eax,ebp
    a6a4:	0f b6 c0             	movzx  eax,al
    a6a7:	50                   	push   eax
    a6a8:	68 f4 01 00 00       	push   0x1f4
    a6ad:	e8 2e 18 00 00       	call   bee0 <_Z4outbth>
    a6b2:	58                   	pop    eax
    a6b3:	89 e8                	mov    eax,ebp
    a6b5:	5a                   	pop    edx
    a6b6:	0f b6 c4             	movzx  eax,ah
    a6b9:	50                   	push   eax
    a6ba:	68 f5 01 00 00       	push   0x1f5
    a6bf:	e8 1c 18 00 00       	call   bee0 <_Z4outbth>
    a6c4:	59                   	pop    ecx
    a6c5:	5e                   	pop    esi
    a6c6:	0f b6 c3             	movzx  eax,bl
    a6c9:	50                   	push   eax
    a6ca:	68 f2 01 00 00       	push   0x1f2
    a6cf:	e8 0c 18 00 00       	call   bee0 <_Z4outbth>
    a6d4:	58                   	pop    eax
    a6d5:	89 f8                	mov    eax,edi
    a6d7:	5a                   	pop    edx
    a6d8:	0f b6 c0             	movzx  eax,al
    a6db:	50                   	push   eax
    a6dc:	68 f3 01 00 00       	push   0x1f3
    a6e1:	e8 fa 17 00 00       	call   bee0 <_Z4outbth>
    a6e6:	89 f8                	mov    eax,edi
    a6e8:	0f ac e8 08          	shrd   eax,ebp,0x8
    a6ec:	59                   	pop    ecx
    a6ed:	5e                   	pop    esi
    a6ee:	0f b6 c0             	movzx  eax,al
    a6f1:	50                   	push   eax
    a6f2:	68 f4 01 00 00       	push   0x1f4
    a6f7:	0f ac ef 10          	shrd   edi,ebp,0x10
    a6fb:	e8 e0 17 00 00       	call   bee0 <_Z4outbth>
    a700:	5e                   	pop    esi
    a701:	58                   	pop    eax
    a702:	89 f8                	mov    eax,edi
    a704:	0f b6 f0             	movzx  esi,al
    a707:	56                   	push   esi
    a708:	68 f5 01 00 00       	push   0x1f5
    a70d:	e8 ce 17 00 00       	call   bee0 <_Z4outbth>
    a712:	83 c4 10             	add    esp,0x10
    a715:	8d 76 00             	lea    esi,[esi+0x0]
    a718:	83 ec 0c             	sub    esp,0xc
    a71b:	68 f7 01 00 00       	push   0x1f7
    a720:	e8 0b 18 00 00       	call   bf30 <_Z3inbt>
    a725:	83 c4 10             	add    esp,0x10
    a728:	84 c0                	test   al,al
    a72a:	78 ec                	js     a718 <_ZN3ata12lba48PIOReadEPvyth+0xd8>
    a72c:	83 ec 08             	sub    esp,0x8
    a72f:	89 df                	mov    edi,ebx
    a731:	6a 24                	push   0x24
    a733:	68 f7 01 00 00       	push   0x1f7
    a738:	e8 a3 17 00 00       	call   bee0 <_Z4outbth>
    a73d:	83 c4 10             	add    esp,0x10
    a740:	81 e7 ff ff 00 00    	and    edi,0xffff
    a746:	0f 84 b2 00 00 00    	je     a7fe <_ZN3ata12lba48PIOReadEPvyth+0x1be>
    a74c:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    a750:	31 f6                	xor    esi,esi
    a752:	05 00 02 00 00       	add    eax,0x200
    a757:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a75b:	90                   	nop
    a75c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a760:	83 ec 0c             	sub    esp,0xc
    a763:	68 f7 01 00 00       	push   0x1f7
    a768:	e8 c3 17 00 00       	call   bf30 <_Z3inbt>
    a76d:	83 c4 10             	add    esp,0x10
    a770:	84 c0                	test   al,al
    a772:	78 ec                	js     a760 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a774:	83 ec 0c             	sub    esp,0xc
    a777:	68 f6 03 00 00       	push   0x3f6
    a77c:	e8 af 17 00 00       	call   bf30 <_Z3inbt>
    a781:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a788:	e8 a3 17 00 00       	call   bf30 <_Z3inbt>
    a78d:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    a794:	e8 97 17 00 00       	call   bf30 <_Z3inbt>
    a799:	83 c4 10             	add    esp,0x10
    a79c:	eb 06                	jmp    a7a4 <_ZN3ata12lba48PIOReadEPvyth+0x164>
    a79e:	66 90                	xchg   ax,ax
    a7a0:	a8 08                	test   al,0x8
    a7a2:	75 1e                	jne    a7c2 <_ZN3ata12lba48PIOReadEPvyth+0x182>
    a7a4:	83 ec 0c             	sub    esp,0xc
    a7a7:	68 f7 01 00 00       	push   0x1f7
    a7ac:	e8 7f 17 00 00       	call   bf30 <_Z3inbt>
    a7b1:	83 c4 10             	add    esp,0x10
    a7b4:	a8 01                	test   al,0x1
    a7b6:	74 e8                	je     a7a0 <_ZN3ata12lba48PIOReadEPvyth+0x160>
    a7b8:	83 c4 1c             	add    esp,0x1c
    a7bb:	31 c0                	xor    eax,eax
    a7bd:	5b                   	pop    ebx
    a7be:	5e                   	pop    esi
    a7bf:	5f                   	pop    edi
    a7c0:	5d                   	pop    ebp
    a7c1:	c3                   	ret    
    a7c2:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    a7c6:	89 f3                	mov    ebx,esi
    a7c8:	c1 e3 09             	shl    ebx,0x9
    a7cb:	01 dd                	add    ebp,ebx
    a7cd:	03 5c 24 0c          	add    ebx,DWORD PTR [esp+0xc]
    a7d1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a7d8:	83 ec 0c             	sub    esp,0xc
    a7db:	83 c5 02             	add    ebp,0x2
    a7de:	68 f0 01 00 00       	push   0x1f0
    a7e3:	e8 58 17 00 00       	call   bf40 <_Z3inwt>
    a7e8:	66 89 45 fe          	mov    WORD PTR [ebp-0x2],ax
    a7ec:	83 c4 10             	add    esp,0x10
    a7ef:	39 dd                	cmp    ebp,ebx
    a7f1:	75 e5                	jne    a7d8 <_ZN3ata12lba48PIOReadEPvyth+0x198>
    a7f3:	83 c6 01             	add    esi,0x1
    a7f6:	39 fe                	cmp    esi,edi
    a7f8:	0f 85 62 ff ff ff    	jne    a760 <_ZN3ata12lba48PIOReadEPvyth+0x120>
    a7fe:	83 c4 1c             	add    esp,0x1c
    a801:	b8 01 00 00 00       	mov    eax,0x1
    a806:	5b                   	pop    ebx
    a807:	5e                   	pop    esi
    a808:	5f                   	pop    edi
    a809:	5d                   	pop    ebp
    a80a:	c3                   	ret    
    a80b:	90                   	nop
    a80c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000a810 <_ZN3ata9lba48ReadEPvyjh>:
    a810:	55                   	push   ebp
    a811:	57                   	push   edi
    a812:	56                   	push   esi
    a813:	53                   	push   ebx
    a814:	83 ec 1c             	sub    esp,0x1c
    a817:	8b 6c 24 3c          	mov    ebp,DWORD PTR [esp+0x3c]
    a81b:	8b 54 24 30          	mov    edx,DWORD PTR [esp+0x30]
    a81f:	8b 74 24 34          	mov    esi,DWORD PTR [esp+0x34]
    a823:	8b 7c 24 38          	mov    edi,DWORD PTR [esp+0x38]
    a827:	8b 44 24 40          	mov    eax,DWORD PTR [esp+0x40]
    a82b:	85 ed                	test   ebp,ebp
    a82d:	74 69                	je     a898 <_ZN3ata9lba48ReadEPvyjh+0x88>
    a82f:	0f b6 c0             	movzx  eax,al
    a832:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    a836:	eb 1c                	jmp    a854 <_ZN3ata9lba48ReadEPvyjh+0x44>
    a838:	90                   	nop
    a839:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    a840:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    a844:	03 34 24             	add    esi,DWORD PTR [esp]
    a847:	13 7c 24 04          	adc    edi,DWORD PTR [esp+0x4]
    a84b:	c1 e3 09             	shl    ebx,0x9
    a84e:	01 da                	add    edx,ebx
    a850:	85 ed                	test   ebp,ebp
    a852:	74 44                	je     a898 <_ZN3ata9lba48ReadEPvyjh+0x88>
    a854:	81 fd ff ff 00 00    	cmp    ebp,0xffff
    a85a:	bb ff ff 00 00       	mov    ebx,0xffff
    a85f:	c7 44 24 04 00 00 00 	mov    DWORD PTR [esp+0x4],0x0
    a866:	00 
    a867:	0f 46 dd             	cmovbe ebx,ebp
    a86a:	83 ec 0c             	sub    esp,0xc
    a86d:	89 5c 24 0c          	mov    DWORD PTR [esp+0xc],ebx
    a871:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    a875:	29 dd                	sub    ebp,ebx
    a877:	53                   	push   ebx
    a878:	57                   	push   edi
    a879:	56                   	push   esi
    a87a:	52                   	push   edx
    a87b:	89 54 24 28          	mov    DWORD PTR [esp+0x28],edx
    a87f:	e8 bc fd ff ff       	call   a640 <_ZN3ata12lba48PIOReadEPvyth>
    a884:	83 c4 20             	add    esp,0x20
    a887:	84 c0                	test   al,al
    a889:	75 b5                	jne    a840 <_ZN3ata9lba48ReadEPvyjh+0x30>
    a88b:	83 c4 1c             	add    esp,0x1c
    a88e:	5b                   	pop    ebx
    a88f:	5e                   	pop    esi
    a890:	5f                   	pop    edi
    a891:	5d                   	pop    ebp
    a892:	c3                   	ret    
    a893:	90                   	nop
    a894:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a898:	83 c4 1c             	add    esp,0x1c
    a89b:	b8 01 00 00 00       	mov    eax,0x1
    a8a0:	5b                   	pop    ebx
    a8a1:	5e                   	pop    esi
    a8a2:	5f                   	pop    edi
    a8a3:	5d                   	pop    ebp
    a8a4:	c3                   	ret    
    a8a5:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    a8a9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000a8b0 <_ZN3ata4readEPvyjhb>:
    a8b0:	55                   	push   ebp
    a8b1:	57                   	push   edi
    a8b2:	ba 10 a8 00 00       	mov    edx,0xa810
    a8b7:	56                   	push   esi
    a8b8:	53                   	push   ebx
    a8b9:	b8 b0 a5 00 00       	mov    eax,0xa5b0
    a8be:	81 ec 2c 04 00 00    	sub    esp,0x42c
    a8c4:	80 bc 24 54 04 00 00 	cmp    BYTE PTR [esp+0x454],0x0
    a8cb:	00 
    a8cc:	8b 8c 24 44 04 00 00 	mov    ecx,DWORD PTR [esp+0x444]
    a8d3:	8b 9c 24 48 04 00 00 	mov    ebx,DWORD PTR [esp+0x448]
    a8da:	8b ac 24 50 04 00 00 	mov    ebp,DWORD PTR [esp+0x450]
    a8e1:	0f 44 c2             	cmove  eax,edx
    a8e4:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    a8e8:	8b 84 24 4c 04 00 00 	mov    eax,DWORD PTR [esp+0x44c]
    a8ef:	85 c0                	test   eax,eax
    a8f1:	0f 84 99 01 00 00    	je     aa90 <_ZN3ata4readEPvyjhb+0x1e0>
    a8f7:	8b b4 24 4c 04 00 00 	mov    esi,DWORD PTR [esp+0x44c]
    a8fe:	89 c8                	mov    eax,ecx
    a900:	89 da                	mov    edx,ebx
    a902:	83 c0 ff             	add    eax,0xffffffff
    a905:	83 d2 ff             	adc    edx,0xffffffff
    a908:	31 ff                	xor    edi,edi
    a90a:	01 c6                	add    esi,eax
    a90c:	11 d7                	adc    edi,edx
    a90e:	39 fb                	cmp    ebx,edi
    a910:	0f 83 62 01 00 00    	jae    aa78 <_ZN3ata4readEPvyjhb+0x1c8>
    a916:	89 c8                	mov    eax,ecx
    a918:	89 da                	mov    edx,ebx
    a91a:	0f ac d8 09          	shrd   eax,ebx,0x9
    a91e:	c1 ea 09             	shr    edx,0x9
    a921:	89 cb                	mov    ebx,ecx
    a923:	89 44 24 10          	mov    DWORD PTR [esp+0x10],eax
    a927:	89 f0                	mov    eax,esi
    a929:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    a92d:	0f ac f8 09          	shrd   eax,edi,0x9
    a931:	89 fa                	mov    edx,edi
    a933:	81 e3 ff 01 00 00    	and    ebx,0x1ff
    a939:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    a93d:	c1 ea 09             	shr    edx,0x9
    a940:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    a944:	89 5c 24 1c          	mov    DWORD PTR [esp+0x1c],ebx
    a948:	89 54 24 0c          	mov    DWORD PTR [esp+0xc],edx
    a94c:	8b 5c 24 14          	mov    ebx,DWORD PTR [esp+0x14]
    a950:	81 e6 ff 01 00 00    	and    esi,0x1ff
    a956:	8b 7c 24 08          	mov    edi,DWORD PTR [esp+0x8]
    a95a:	8b 54 24 0c          	mov    edx,DWORD PTR [esp+0xc]
    a95e:	89 e8                	mov    eax,ebp
    a960:	0f b6 e8             	movzx  ebp,al
    a963:	31 cf                	xor    edi,ecx
    a965:	31 da                	xor    edx,ebx
    a967:	09 fa                	or     edx,edi
    a969:	0f 84 41 01 00 00    	je     aab0 <_ZN3ata4readEPvyjhb+0x200>
    a96f:	8d 7c 24 20          	lea    edi,[esp+0x20]
    a973:	8d 9c 24 20 02 00 00 	lea    ebx,[esp+0x220]
    a97a:	31 c0                	xor    eax,eax
    a97c:	b9 80 00 00 00       	mov    ecx,0x80
    a981:	83 ec 0c             	sub    esp,0xc
    a984:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    a986:	b9 80 00 00 00       	mov    ecx,0x80
    a98b:	89 df                	mov    edi,ebx
    a98d:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    a98f:	55                   	push   ebp
    a990:	6a 01                	push   0x1
    a992:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    a996:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    a99a:	8d 7c 24 3c          	lea    edi,[esp+0x3c]
    a99e:	57                   	push   edi
    a99f:	8b 44 24 38          	mov    eax,DWORD PTR [esp+0x38]
    a9a3:	ff d0                	call   eax
    a9a5:	83 c4 20             	add    esp,0x20
    a9a8:	84 c0                	test   al,al
    a9aa:	0f 84 ca 00 00 00    	je     aa7a <_ZN3ata4readEPvyjhb+0x1ca>
    a9b0:	83 ec 0c             	sub    esp,0xc
    a9b3:	55                   	push   ebp
    a9b4:	6a 01                	push   0x1
    a9b6:	ff 74 24 20          	push   DWORD PTR [esp+0x20]
    a9ba:	ff 74 24 20          	push   DWORD PTR [esp+0x20]
    a9be:	53                   	push   ebx
    a9bf:	8b 44 24 38          	mov    eax,DWORD PTR [esp+0x38]
    a9c3:	ff d0                	call   eax
    a9c5:	83 c4 20             	add    esp,0x20
    a9c8:	84 c0                	test   al,al
    a9ca:	0f 84 aa 00 00 00    	je     aa7a <_ZN3ata4readEPvyjhb+0x1ca>
    a9d0:	8b 4c 24 1c          	mov    ecx,DWORD PTR [esp+0x1c]
    a9d4:	8b 94 24 40 04 00 00 	mov    edx,DWORD PTR [esp+0x440]
    a9db:	89 c8                	mov    eax,ecx
    a9dd:	29 ca                	sub    edx,ecx
    a9df:	90                   	nop
    a9e0:	0f b6 0c 07          	movzx  ecx,BYTE PTR [edi+eax*1]
    a9e4:	88 0c 02             	mov    BYTE PTR [edx+eax*1],cl
    a9e7:	83 c0 01             	add    eax,0x1
    a9ea:	3d 00 02 00 00       	cmp    eax,0x200
    a9ef:	75 ef                	jne    a9e0 <_ZN3ata4readEPvyjhb+0x130>
    a9f1:	8b 84 24 4c 04 00 00 	mov    eax,DWORD PTR [esp+0x44c]
    a9f8:	8b bc 24 40 04 00 00 	mov    edi,DWORD PTR [esp+0x440]
    a9ff:	31 d2                	xor    edx,edx
    aa01:	8d 48 ff             	lea    ecx,[eax-0x1]
    aa04:	8d 46 01             	lea    eax,[esi+0x1]
    aa07:	29 f1                	sub    ecx,esi
    aa09:	01 f9                	add    ecx,edi
    aa0b:	89 c7                	mov    edi,eax
    aa0d:	8d 76 00             	lea    esi,[esi+0x0]
    aa10:	0f b6 04 13          	movzx  eax,BYTE PTR [ebx+edx*1]
    aa14:	88 04 11             	mov    BYTE PTR [ecx+edx*1],al
    aa17:	83 c2 01             	add    edx,0x1
    aa1a:	39 fa                	cmp    edx,edi
    aa1c:	75 f2                	jne    aa10 <_ZN3ata4readEPvyjhb+0x160>
    aa1e:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    aa22:	8b 5c 24 14          	mov    ebx,DWORD PTR [esp+0x14]
    aa26:	be 00 02 00 00       	mov    esi,0x200
    aa2b:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    aa2f:	8b 54 24 0c          	mov    edx,DWORD PTR [esp+0xc]
    aa33:	2b 74 24 1c          	sub    esi,DWORD PTR [esp+0x1c]
    aa37:	83 c1 01             	add    ecx,0x1
    aa3a:	83 d3 00             	adc    ebx,0x0
    aa3d:	83 c0 ff             	add    eax,0xffffffff
    aa40:	83 d2 ff             	adc    edx,0xffffffff
    aa43:	39 d3                	cmp    ebx,edx
    aa45:	77 49                	ja     aa90 <_ZN3ata4readEPvyjhb+0x1e0>
    aa47:	72 04                	jb     aa4d <_ZN3ata4readEPvyjhb+0x19d>
    aa49:	39 c1                	cmp    ecx,eax
    aa4b:	77 43                	ja     aa90 <_ZN3ata4readEPvyjhb+0x1e0>
    aa4d:	83 ec 0c             	sub    esp,0xc
    aa50:	55                   	push   ebp
    aa51:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    aa55:	f7 d0                	not    eax
    aa57:	03 44 24 18          	add    eax,DWORD PTR [esp+0x18]
    aa5b:	50                   	push   eax
    aa5c:	53                   	push   ebx
    aa5d:	51                   	push   ecx
    aa5e:	03 b4 24 5c 04 00 00 	add    esi,DWORD PTR [esp+0x45c]
    aa65:	56                   	push   esi
    aa66:	8b 44 24 38          	mov    eax,DWORD PTR [esp+0x38]
    aa6a:	ff d0                	call   eax
    aa6c:	83 c4 20             	add    esp,0x20
    aa6f:	eb 0b                	jmp    aa7c <_ZN3ata4readEPvyjhb+0x1cc>
    aa71:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    aa78:	76 26                	jbe    aaa0 <_ZN3ata4readEPvyjhb+0x1f0>
    aa7a:	31 c0                	xor    eax,eax
    aa7c:	81 c4 2c 04 00 00    	add    esp,0x42c
    aa82:	5b                   	pop    ebx
    aa83:	5e                   	pop    esi
    aa84:	5f                   	pop    edi
    aa85:	5d                   	pop    ebp
    aa86:	c3                   	ret    
    aa87:	89 f6                	mov    esi,esi
    aa89:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    aa90:	81 c4 2c 04 00 00    	add    esp,0x42c
    aa96:	b8 01 00 00 00       	mov    eax,0x1
    aa9b:	5b                   	pop    ebx
    aa9c:	5e                   	pop    esi
    aa9d:	5f                   	pop    edi
    aa9e:	5d                   	pop    ebp
    aa9f:	c3                   	ret    
    aaa0:	39 f1                	cmp    ecx,esi
    aaa2:	0f 86 6e fe ff ff    	jbe    a916 <_ZN3ata4readEPvyjhb+0x66>
    aaa8:	eb d0                	jmp    aa7a <_ZN3ata4readEPvyjhb+0x1ca>
    aaaa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    aab0:	83 ec 0c             	sub    esp,0xc
    aab3:	55                   	push   ebp
    aab4:	6a 01                	push   0x1
    aab6:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    aaba:	ff 74 24 28          	push   DWORD PTR [esp+0x28]
    aabe:	8d 9c 24 3c 02 00 00 	lea    ebx,[esp+0x23c]
    aac5:	53                   	push   ebx
    aac6:	8b 44 24 38          	mov    eax,DWORD PTR [esp+0x38]
    aaca:	ff d0                	call   eax
    aacc:	83 c4 20             	add    esp,0x20
    aacf:	84 c0                	test   al,al
    aad1:	74 a9                	je     aa7c <_ZN3ata4readEPvyjhb+0x1cc>
    aad3:	8b 4c 24 1c          	mov    ecx,DWORD PTR [esp+0x1c]
    aad7:	8b bc 24 40 04 00 00 	mov    edi,DWORD PTR [esp+0x440]
    aade:	29 cf                	sub    edi,ecx
    aae0:	39 f1                	cmp    ecx,esi
    aae2:	77 98                	ja     aa7c <_ZN3ata4readEPvyjhb+0x1cc>
    aae4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    aae8:	0f b6 14 0b          	movzx  edx,BYTE PTR [ebx+ecx*1]
    aaec:	88 14 0f             	mov    BYTE PTR [edi+ecx*1],dl
    aaef:	83 c1 01             	add    ecx,0x1
    aaf2:	39 ce                	cmp    esi,ecx
    aaf4:	72 86                	jb     aa7c <_ZN3ata4readEPvyjhb+0x1cc>
    aaf6:	0f b6 14 0b          	movzx  edx,BYTE PTR [ebx+ecx*1]
    aafa:	88 14 0f             	mov    BYTE PTR [edi+ecx*1],dl
    aafd:	83 c1 01             	add    ecx,0x1
    ab00:	39 ce                	cmp    esi,ecx
    ab02:	73 e4                	jae    aae8 <_ZN3ata4readEPvyjhb+0x238>
    ab04:	e9 73 ff ff ff       	jmp    aa7c <_ZN3ata4readEPvyjhb+0x1cc>
    ab09:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000ab10 <_ZN3ata12sendIdentifyEhRbb>:
    ab10:	55                   	push   ebp
    ab11:	57                   	push   edi
    ab12:	56                   	push   esi
    ab13:	53                   	push   ebx
    ab14:	81 ec 38 02 00 00    	sub    esp,0x238
    ab1a:	8b 9c 24 4c 02 00 00 	mov    ebx,DWORD PTR [esp+0x24c]
    ab21:	8b b4 24 54 02 00 00 	mov    esi,DWORD PTR [esp+0x254]
    ab28:	68 f7 01 00 00       	push   0x1f7
    ab2d:	e8 fe 13 00 00       	call   bf30 <_Z3inbt>
    ab32:	83 c4 10             	add    esp,0x10
    ab35:	3c ff                	cmp    al,0xff
    ab37:	0f 84 e3 00 00 00    	je     ac20 <_ZN3ata12sendIdentifyEhRbb+0x110>
    ab3d:	c1 e3 04             	shl    ebx,0x4
    ab40:	83 ec 08             	sub    esp,0x8
    ab43:	83 cb a0             	or     ebx,0xffffffa0
    ab46:	0f b6 db             	movzx  ebx,bl
    ab49:	53                   	push   ebx
    ab4a:	68 f6 01 00 00       	push   0x1f6
    ab4f:	e8 8c 13 00 00       	call   bee0 <_Z4outbth>
    ab54:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    ab5b:	e8 d0 13 00 00       	call   bf30 <_Z3inbt>
    ab60:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    ab67:	e8 c4 13 00 00       	call   bf30 <_Z3inbt>
    ab6c:	c7 04 24 f6 03 00 00 	mov    DWORD PTR [esp],0x3f6
    ab73:	e8 b8 13 00 00       	call   bf30 <_Z3inbt>
    ab78:	83 c4 10             	add    esp,0x10
    ab7b:	90                   	nop
    ab7c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ab80:	83 ec 0c             	sub    esp,0xc
    ab83:	68 f7 01 00 00       	push   0x1f7
    ab88:	e8 a3 13 00 00       	call   bf30 <_Z3inbt>
    ab8d:	83 c4 10             	add    esp,0x10
    ab90:	84 c0                	test   al,al
    ab92:	78 ec                	js     ab80 <_ZN3ata12sendIdentifyEhRbb+0x70>
    ab94:	83 ec 08             	sub    esp,0x8
    ab97:	6a 00                	push   0x0
    ab99:	68 f2 01 00 00       	push   0x1f2
    ab9e:	e8 3d 13 00 00       	call   bee0 <_Z4outbth>
    aba3:	5b                   	pop    ebx
    aba4:	5f                   	pop    edi
    aba5:	6a 00                	push   0x0
    aba7:	68 f3 01 00 00       	push   0x1f3
    abac:	e8 2f 13 00 00       	call   bee0 <_Z4outbth>
    abb1:	5d                   	pop    ebp
    abb2:	58                   	pop    eax
    abb3:	6a 00                	push   0x0
    abb5:	68 f4 01 00 00       	push   0x1f4
    abba:	e8 21 13 00 00       	call   bee0 <_Z4outbth>
    abbf:	58                   	pop    eax
    abc0:	5a                   	pop    edx
    abc1:	6a 00                	push   0x0
    abc3:	68 f5 01 00 00       	push   0x1f5
    abc8:	e8 13 13 00 00       	call   bee0 <_Z4outbth>
    abcd:	59                   	pop    ecx
    abce:	5b                   	pop    ebx
    abcf:	68 ec 00 00 00       	push   0xec
    abd4:	68 f7 01 00 00       	push   0x1f7
    abd9:	e8 02 13 00 00       	call   bee0 <_Z4outbth>
    abde:	c7 04 24 f7 01 00 00 	mov    DWORD PTR [esp],0x1f7
    abe5:	e8 46 13 00 00       	call   bf30 <_Z3inbt>
    abea:	83 c4 10             	add    esp,0x10
    abed:	84 c0                	test   al,al
    abef:	74 2f                	je     ac20 <_ZN3ata12sendIdentifyEhRbb+0x110>
    abf1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    abf8:	83 ec 0c             	sub    esp,0xc
    abfb:	68 f7 01 00 00       	push   0x1f7
    ac00:	e8 2b 13 00 00       	call   bf30 <_Z3inbt>
    ac05:	83 c4 10             	add    esp,0x10
    ac08:	84 c0                	test   al,al
    ac0a:	78 ec                	js     abf8 <_ZN3ata12sendIdentifyEhRbb+0xe8>
    ac0c:	83 ec 0c             	sub    esp,0xc
    ac0f:	68 f4 01 00 00       	push   0x1f4
    ac14:	e8 17 13 00 00       	call   bf30 <_Z3inbt>
    ac19:	83 c4 10             	add    esp,0x10
    ac1c:	84 c0                	test   al,al
    ac1e:	74 10                	je     ac30 <_ZN3ata12sendIdentifyEhRbb+0x120>
    ac20:	31 c0                	xor    eax,eax
    ac22:	81 c4 2c 02 00 00    	add    esp,0x22c
    ac28:	5b                   	pop    ebx
    ac29:	5e                   	pop    esi
    ac2a:	5f                   	pop    edi
    ac2b:	5d                   	pop    ebp
    ac2c:	c3                   	ret    
    ac2d:	8d 76 00             	lea    esi,[esi+0x0]
    ac30:	83 ec 0c             	sub    esp,0xc
    ac33:	68 f5 01 00 00       	push   0x1f5
    ac38:	e8 f3 12 00 00       	call   bf30 <_Z3inbt>
    ac3d:	83 c4 10             	add    esp,0x10
    ac40:	84 c0                	test   al,al
    ac42:	74 10                	je     ac54 <_ZN3ata12sendIdentifyEhRbb+0x144>
    ac44:	eb da                	jmp    ac20 <_ZN3ata12sendIdentifyEhRbb+0x110>
    ac46:	8d 76 00             	lea    esi,[esi+0x0]
    ac49:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ac50:	a8 08                	test   al,0x8
    ac52:	75 16                	jne    ac6a <_ZN3ata12sendIdentifyEhRbb+0x15a>
    ac54:	83 ec 0c             	sub    esp,0xc
    ac57:	68 f7 01 00 00       	push   0x1f7
    ac5c:	e8 cf 12 00 00       	call   bf30 <_Z3inbt>
    ac61:	83 c4 10             	add    esp,0x10
    ac64:	a8 01                	test   al,0x1
    ac66:	74 e8                	je     ac50 <_ZN3ata12sendIdentifyEhRbb+0x140>
    ac68:	eb b6                	jmp    ac20 <_ZN3ata12sendIdentifyEhRbb+0x110>
    ac6a:	8d 7c 24 20          	lea    edi,[esp+0x20]
    ac6e:	b9 80 00 00 00       	mov    ecx,0x80
    ac73:	31 c0                	xor    eax,eax
    ac75:	8d 5c 24 20          	lea    ebx,[esp+0x20]
    ac79:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    ac7b:	8d bc 24 20 02 00 00 	lea    edi,[esp+0x220]
    ac82:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ac88:	83 ec 0c             	sub    esp,0xc
    ac8b:	83 c3 02             	add    ebx,0x2
    ac8e:	68 f0 01 00 00       	push   0x1f0
    ac93:	e8 a8 12 00 00       	call   bf40 <_Z3inwt>
    ac98:	66 89 43 fe          	mov    WORD PTR [ebx-0x2],ax
    ac9c:	83 c4 10             	add    esp,0x10
    ac9f:	39 df                	cmp    edi,ebx
    aca1:	75 e5                	jne    ac88 <_ZN3ata12sendIdentifyEhRbb+0x178>
    aca3:	89 f0                	mov    eax,esi
    aca5:	0f b7 9c 24 c6 00 00 	movzx  ebx,WORD PTR [esp+0xc6]
    acac:	00 
    acad:	84 c0                	test   al,al
    acaf:	75 1d                	jne    acce <_ZN3ata12sendIdentifyEhRbb+0x1be>
    acb1:	8b 84 24 44 02 00 00 	mov    eax,DWORD PTR [esp+0x244]
    acb8:	66 c1 eb 0a          	shr    bx,0xa
    acbc:	83 f3 01             	xor    ebx,0x1
    acbf:	83 e3 01             	and    ebx,0x1
    acc2:	88 18                	mov    BYTE PTR [eax],bl
    acc4:	b8 01 00 00 00       	mov    eax,0x1
    acc9:	e9 54 ff ff ff       	jmp    ac22 <_ZN3ata12sendIdentifyEhRbb+0x112>
    acce:	68 20 00 01 00       	push   0x10020
    acd3:	68 9d 00 00 00       	push   0x9d
    acd8:	31 ff                	xor    edi,edi
    acda:	68 ec 04 01 00       	push   0x104ec
    acdf:	68 10 05 01 00       	push   0x10510
    ace4:	89 dd                	mov    ebp,ebx
    ace6:	e8 e5 23 00 00       	call   d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>
    aceb:	83 c4 0c             	add    esp,0xc
    acee:	0f b7 84 24 d4 00 00 	movzx  eax,WORD PTR [esp+0xd4]
    acf5:	00 
    acf6:	50                   	push   eax
    acf7:	0f b7 c3             	movzx  eax,bx
    acfa:	50                   	push   eax
    acfb:	0f b7 44 24 2c       	movzx  eax,WORD PTR [esp+0x2c]
    ad00:	50                   	push   eax
    ad01:	68 20 00 01 00       	push   0x10020
    ad06:	68 9e 00 00 00       	push   0x9e
    ad0b:	68 ec 04 01 00       	push   0x104ec
    ad10:	68 34 05 01 00       	push   0x10534
    ad15:	e8 d6 3c 00 00       	call   e9f0 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_>
    ad1a:	83 c4 14             	add    esp,0x14
    ad1d:	ff b4 24 a4 00 00 00 	push   DWORD PTR [esp+0xa4]
    ad24:	68 20 00 01 00       	push   0x10020
    ad29:	68 9f 00 00 00       	push   0x9f
    ad2e:	68 ec 04 01 00       	push   0x104ec
    ad33:	68 60 05 01 00       	push   0x10560
    ad38:	e8 33 34 00 00       	call   e170 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_>
    ad3d:	0f b7 84 24 0e 01 00 	movzx  eax,WORD PTR [esp+0x10e]
    ad44:	00 
    ad45:	c7 44 24 38 ec 04 01 	mov    DWORD PTR [esp+0x38],0x104ec
    ad4c:	00 
    ad4d:	ba 5b 00 00 00       	mov    edx,0x5b
    ad52:	66 89 44 24 28       	mov    WORD PTR [esp+0x28],ax
    ad57:	0f b7 84 24 0c 01 00 	movzx  eax,WORD PTR [esp+0x10c]
    ad5e:	00 
    ad5f:	66 89 44 24 2a       	mov    WORD PTR [esp+0x2a],ax
    ad64:	0f b7 84 24 0a 01 00 	movzx  eax,WORD PTR [esp+0x10a]
    ad6b:	00 
    ad6c:	66 89 44 24 2c       	mov    WORD PTR [esp+0x2c],ax
    ad71:	0f b7 84 24 08 01 00 	movzx  eax,WORD PTR [esp+0x108]
    ad78:	00 
    ad79:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    ad7e:	83 c4 20             	add    esp,0x20
    ad81:	eb 20                	jmp    ada3 <_ZN3ata12sendIdentifyEhRbb+0x293>
    ad83:	80 fb 25             	cmp    bl,0x25
    ad86:	0f 84 08 01 00 00    	je     ae94 <_ZN3ata12sendIdentifyEhRbb+0x384>
    ad8c:	84 db                	test   bl,bl
    ad8e:	75 77                	jne    ae07 <_ZN3ata12sendIdentifyEhRbb+0x2f7>
    ad90:	8d 77 02             	lea    esi,[edi+0x2]
    ad93:	0f b6 9e 80 05 01 00 	movzx  ebx,BYTE PTR [esi+0x10580]
    ad9a:	84 db                	test   bl,bl
    ad9c:	74 2a                	je     adc8 <_ZN3ata12sendIdentifyEhRbb+0x2b8>
    ad9e:	0f be d3             	movsx  edx,bl
    ada1:	89 f7                	mov    edi,esi
    ada3:	8d 77 01             	lea    esi,[edi+0x1]
    ada6:	80 fa 25             	cmp    dl,0x25
    ada9:	0f b6 9e 80 05 01 00 	movzx  ebx,BYTE PTR [esi+0x10580]
    adb0:	8d 8e 80 05 01 00    	lea    ecx,[esi+0x10580]
    adb6:	74 cb                	je     ad83 <_ZN3ata12sendIdentifyEhRbb+0x273>
    adb8:	83 ec 0c             	sub    esp,0xc
    adbb:	52                   	push   edx
    adbc:	e8 0f 0f 00 00       	call   bcd0 <_Z7putcharc>
    adc1:	83 c4 10             	add    esp,0x10
    adc4:	84 db                	test   bl,bl
    adc6:	75 d6                	jne    ad9e <_ZN3ata12sendIdentifyEhRbb+0x28e>
    adc8:	89 eb                	mov    ebx,ebp
    adca:	8d 74 24 56          	lea    esi,[esp+0x56]
    adce:	8d 7c 24 7e          	lea    edi,[esp+0x7e]
    add2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    add8:	0f be 06             	movsx  eax,BYTE PTR [esi]
    addb:	83 ec 0c             	sub    esp,0xc
    adde:	83 c6 01             	add    esi,0x1
    ade1:	50                   	push   eax
    ade2:	68 20 00 01 00       	push   0x10020
    ade7:	68 a3 00 00 00       	push   0xa3
    adec:	68 ec 04 01 00       	push   0x104ec
    adf1:	68 71 09 01 00       	push   0x10971
    adf6:	e8 35 37 00 00       	call   e530 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_>
    adfb:	83 c4 20             	add    esp,0x20
    adfe:	39 f7                	cmp    edi,esi
    ae00:	75 d6                	jne    add8 <_ZN3ata12sendIdentifyEhRbb+0x2c8>
    ae02:	e9 aa fe ff ff       	jmp    acb1 <_ZN3ata12sendIdentifyEhRbb+0x1a1>
    ae07:	83 ec 08             	sub    esp,0x8
    ae0a:	89 eb                	mov    ebx,ebp
    ae0c:	8d 44 24 20          	lea    eax,[esp+0x20]
    ae10:	50                   	push   eax
    ae11:	51                   	push   ecx
    ae12:	e8 b9 20 00 00       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    ae17:	01 c6                	add    esi,eax
    ae19:	c7 44 24 2c a0 00 00 	mov    DWORD PTR [esp+0x2c],0xa0
    ae20:	00 
    ae21:	83 c4 10             	add    esp,0x10
    ae24:	0f be 96 80 05 01 00 	movsx  edx,BYTE PTR [esi+0x10580]
    ae2b:	8d ae 80 05 01 00    	lea    ebp,[esi+0x10580]
    ae31:	84 d2                	test   dl,dl
    ae33:	74 95                	je     adca <_ZN3ata12sendIdentifyEhRbb+0x2ba>
    ae35:	31 ff                	xor    edi,edi
    ae37:	89 ee                	mov    esi,ebp
    ae39:	80 fa 25             	cmp    dl,0x25
    ae3c:	89 fd                	mov    ebp,edi
    ae3e:	66 89 5c 24 06       	mov    WORD PTR [esp+0x6],bx
    ae43:	8d 7d 01             	lea    edi,[ebp+0x1]
    ae46:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    ae49:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    ae4c:	75 2c                	jne    ae7a <_ZN3ata12sendIdentifyEhRbb+0x36a>
    ae4e:	80 fb 25             	cmp    bl,0x25
    ae51:	0f 84 af 00 00 00    	je     af06 <_ZN3ata12sendIdentifyEhRbb+0x3f6>
    ae57:	84 db                	test   bl,bl
    ae59:	75 65                	jne    aec0 <_ZN3ata12sendIdentifyEhRbb+0x3b0>
    ae5b:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    ae60:	8d 7d 02             	lea    edi,[ebp+0x2]
    ae63:	84 db                	test   bl,bl
    ae65:	74 23                	je     ae8a <_ZN3ata12sendIdentifyEhRbb+0x37a>
    ae67:	89 fd                	mov    ebp,edi
    ae69:	0f be d3             	movsx  edx,bl
    ae6c:	8d 7d 01             	lea    edi,[ebp+0x1]
    ae6f:	80 fa 25             	cmp    dl,0x25
    ae72:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    ae75:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    ae78:	74 d4                	je     ae4e <_ZN3ata12sendIdentifyEhRbb+0x33e>
    ae7a:	83 ec 0c             	sub    esp,0xc
    ae7d:	52                   	push   edx
    ae7e:	e8 4d 0e 00 00       	call   bcd0 <_Z7putcharc>
    ae83:	83 c4 10             	add    esp,0x10
    ae86:	84 db                	test   bl,bl
    ae88:	75 dd                	jne    ae67 <_ZN3ata12sendIdentifyEhRbb+0x357>
    ae8a:	0f b7 5c 24 06       	movzx  ebx,WORD PTR [esp+0x6]
    ae8f:	e9 36 ff ff ff       	jmp    adca <_ZN3ata12sendIdentifyEhRbb+0x2ba>
    ae94:	83 ec 0c             	sub    esp,0xc
    ae97:	8d 77 02             	lea    esi,[edi+0x2]
    ae9a:	6a 25                	push   0x25
    ae9c:	e8 2f 0e 00 00       	call   bcd0 <_Z7putcharc>
    aea1:	0f b6 9e 80 05 01 00 	movzx  ebx,BYTE PTR [esi+0x10580]
    aea8:	83 c4 10             	add    esp,0x10
    aeab:	84 db                	test   bl,bl
    aead:	0f 85 eb fe ff ff    	jne    ad9e <_ZN3ata12sendIdentifyEhRbb+0x28e>
    aeb3:	e9 10 ff ff ff       	jmp    adc8 <_ZN3ata12sendIdentifyEhRbb+0x2b8>
    aeb8:	90                   	nop
    aeb9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    aec0:	0f b7 5c 24 06       	movzx  ebx,WORD PTR [esp+0x6]
    aec5:	83 ec 08             	sub    esp,0x8
    aec8:	89 f5                	mov    ebp,esi
    aeca:	8d 44 24 24          	lea    eax,[esp+0x24]
    aece:	50                   	push   eax
    aecf:	51                   	push   ecx
    aed0:	e8 fb 20 00 00       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    aed5:	5a                   	pop    edx
    aed6:	59                   	pop    ecx
    aed7:	0f b7 54 24 10       	movzx  edx,WORD PTR [esp+0x10]
    aedc:	01 f8                	add    eax,edi
    aede:	01 e8                	add    eax,ebp
    aee0:	52                   	push   edx
    aee1:	0f b7 54 24 16       	movzx  edx,WORD PTR [esp+0x16]
    aee6:	52                   	push   edx
    aee7:	0f b7 54 24 1c       	movzx  edx,WORD PTR [esp+0x1c]
    aeec:	52                   	push   edx
    aeed:	0f b7 54 24 22       	movzx  edx,WORD PTR [esp+0x22]
    aef2:	52                   	push   edx
    aef3:	68 20 00 01 00       	push   0x10020
    aef8:	50                   	push   eax
    aef9:	e8 32 3d 00 00       	call   ec30 <_Z6printfIPKcJttttEEvS1_T_DpT0_>
    aefe:	83 c4 20             	add    esp,0x20
    af01:	e9 c4 fe ff ff       	jmp    adca <_ZN3ata12sendIdentifyEhRbb+0x2ba>
    af06:	83 ec 0c             	sub    esp,0xc
    af09:	8d 7d 02             	lea    edi,[ebp+0x2]
    af0c:	6a 25                	push   0x25
    af0e:	e8 bd 0d 00 00       	call   bcd0 <_Z7putcharc>
    af13:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    af18:	83 c4 10             	add    esp,0x10
    af1b:	84 db                	test   bl,bl
    af1d:	0f 85 44 ff ff ff    	jne    ae67 <_ZN3ata12sendIdentifyEhRbb+0x357>
    af23:	e9 62 ff ff ff       	jmp    ae8a <_ZN3ata12sendIdentifyEhRbb+0x37a>
    af28:	66 90                	xchg   ax,ax
    af2a:	66 90                	xchg   ax,ax
    af2c:	66 90                	xchg   ax,ax
    af2e:	66 90                	xchg   ax,ax

0000af30 <_ZN6paging18init_kernel_pagingEv>:
    af30:	57                   	push   edi
    af31:	56                   	push   esi
    af32:	b8 00 00 10 00       	mov    eax,0x100000
    af37:	53                   	push   ebx
    af38:	90                   	nop
    af39:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    af40:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    af46:	83 c0 04             	add    eax,0x4
    af49:	3d 00 10 10 00       	cmp    eax,0x101000
    af4e:	75 f0                	jne    af40 <_ZN6paging18init_kernel_pagingEv+0x10>
    af50:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    af56:	83 c0 04             	add    eax,0x4
    af59:	3d 00 10 50 00       	cmp    eax,0x501000
    af5e:	75 f0                	jne    af50 <_ZN6paging18init_kernel_pagingEv+0x20>
    af60:	c7 05 00 00 10 00 87 	mov    DWORD PTR ds:0x100000,0x87
    af67:	00 00 00 
    af6a:	c7 05 04 00 10 00 87 	mov    DWORD PTR ds:0x100004,0x400087
    af71:	00 40 00 
    af74:	31 c0                	xor    eax,eax
    af76:	c7 05 08 0c 10 00 87 	mov    DWORD PTR ds:0x100c08,0x800087
    af7d:	00 80 00 
    af80:	c7 05 0c 0c 10 00 87 	mov    DWORD PTR ds:0x100c0c,0xc00087
    af87:	00 c0 00 
    af8a:	c7 05 10 0c 10 00 87 	mov    DWORD PTR ds:0x100c10,0x1000087
    af91:	00 00 01 
    af94:	c7 05 14 0c 10 00 87 	mov    DWORD PTR ds:0x100c14,0x1400087
    af9b:	00 40 01 
    af9e:	c7 05 18 0c 10 00 87 	mov    DWORD PTR ds:0x100c18,0x1800087
    afa5:	00 80 01 
    afa8:	c7 05 1c 0c 10 00 87 	mov    DWORD PTR ds:0x100c1c,0x1c00087
    afaf:	00 c0 01 
    afb2:	c7 05 20 0c 10 00 87 	mov    DWORD PTR ds:0x100c20,0x2000087
    afb9:	00 00 02 
    afbc:	c7 05 24 0c 10 00 87 	mov    DWORD PTR ds:0x100c24,0x2400087
    afc3:	00 40 02 
    afc6:	c7 05 28 0c 10 00 87 	mov    DWORD PTR ds:0x100c28,0x2800087
    afcd:	00 80 02 
    afd0:	c7 05 2c 0c 10 00 87 	mov    DWORD PTR ds:0x100c2c,0x2c00087
    afd7:	00 c0 02 
    afda:	c7 05 30 0c 10 00 87 	mov    DWORD PTR ds:0x100c30,0x3000087
    afe1:	00 00 03 
    afe4:	c7 05 34 0c 10 00 87 	mov    DWORD PTR ds:0x100c34,0x3400087
    afeb:	00 40 03 
    afee:	c7 05 38 0c 10 00 87 	mov    DWORD PTR ds:0x100c38,0x3800087
    aff5:	00 80 03 
    aff8:	c7 05 3c 0c 10 00 87 	mov    DWORD PTR ds:0x100c3c,0x3c00087
    afff:	00 c0 03 
    b002:	c7 05 00 00 00 02 00 	mov    DWORD PTR ds:0x2000000,0x0
    b009:	00 00 00 
    b00c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b010:	c7 04 85 04 00 00 02 	mov    DWORD PTR [eax*4+0x2000004],0x0
    b017:	00 00 00 00 
    b01b:	83 c0 01             	add    eax,0x1
    b01e:	3d 00 80 00 00       	cmp    eax,0x8000
    b023:	75 eb                	jne    b010 <_ZN6paging18init_kernel_pagingEv+0xe0>
    b025:	e8 f6 00 00 00       	call   b120 <_ZN4boot12get_ram_sizeEv>
    b02a:	c1 e8 0c             	shr    eax,0xc
    b02d:	3d 00 40 00 00       	cmp    eax,0x4000
    b032:	76 4b                	jbe    b07f <_ZN6paging18init_kernel_pagingEv+0x14f>
    b034:	8b 15 00 00 00 02    	mov    edx,DWORD PTR ds:0x2000000
    b03a:	b9 00 40 00 00       	mov    ecx,0x4000
    b03f:	be 01 00 00 00       	mov    esi,0x1
    b044:	8d 9a 00 c0 ff ff    	lea    ebx,[edx-0x4000]
    b04a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b050:	8d bc 19 00 80 00 00 	lea    edi,[ecx+ebx*1+0x8000]
    b057:	89 ca                	mov    edx,ecx
    b059:	c1 e2 0c             	shl    edx,0xc
    b05c:	89 14 bd 04 00 00 02 	mov    DWORD PTR [edi*4+0x2000004],edx
    b063:	89 f7                	mov    edi,esi
    b065:	c1 ea 11             	shr    edx,0x11
    b068:	d3 e7                	shl    edi,cl
    b06a:	83 c1 01             	add    ecx,0x1
    b06d:	09 3c 95 04 00 00 02 	or     DWORD PTR [edx*4+0x2000004],edi
    b074:	39 c8                	cmp    eax,ecx
    b076:	75 d8                	jne    b050 <_ZN6paging18init_kernel_pagingEv+0x120>
    b078:	01 d8                	add    eax,ebx
    b07a:	a3 00 00 00 02       	mov    ds:0x2000000,eax
    b07f:	83 ec 0c             	sub    esp,0xc
    b082:	68 00 00 10 00       	push   0x100000
    b087:	e8 c3 f2 ff ff       	call   a34f <__setCR3>
    b08c:	e8 ba f2 ff ff       	call   a34b <__getCR4>
    b091:	83 c8 10             	or     eax,0x10
    b094:	89 04 24             	mov    DWORD PTR [esp],eax
    b097:	e8 a4 f2 ff ff       	call   a340 <__setCR4>
    b09c:	e8 d7 f2 ff ff       	call   a378 <__getCR0>
    b0a1:	0d 01 00 00 80       	or     eax,0x80000001
    b0a6:	89 04 24             	mov    DWORD PTR [esp],eax
    b0a9:	e8 bf f2 ff ff       	call   a36d <__setCR0>
    b0ae:	83 c4 10             	add    esp,0x10
    b0b1:	5b                   	pop    ebx
    b0b2:	5e                   	pop    esi
    b0b3:	5f                   	pop    edi
    b0b4:	c3                   	ret    
    b0b5:	90                   	nop
    b0b6:	8d 76 00             	lea    esi,[esi+0x0]
    b0b9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000b0c0 <_ZN9PhysPages4initEv>:
    b0c0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    b0c4:	c7 02 00 00 00 00    	mov    DWORD PTR [edx],0x0
    b0ca:	8d 42 04             	lea    eax,[edx+0x4]
    b0cd:	81 c2 04 00 02 00    	add    edx,0x20004
    b0d3:	90                   	nop
    b0d4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b0d8:	c7 00 00 00 00 00    	mov    DWORD PTR [eax],0x0
    b0de:	83 c0 04             	add    eax,0x4
    b0e1:	39 d0                	cmp    eax,edx
    b0e3:	75 f3                	jne    b0d8 <_ZN9PhysPages4initEv+0x18>
    b0e5:	f3 c3                	repz ret 
    b0e7:	90                   	nop
    b0e8:	90                   	nop
    b0e9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000b0f0 <_ZN9PhysPages8add_pageEj>:
    b0f0:	53                   	push   ebx
    b0f1:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b0f5:	8b 4c 24 0c          	mov    ecx,DWORD PTR [esp+0xc]
    b0f9:	8b 10                	mov    edx,DWORD PTR [eax]
    b0fb:	8d 5a 01             	lea    ebx,[edx+0x1]
    b0fe:	89 18                	mov    DWORD PTR [eax],ebx
    b100:	89 cb                	mov    ebx,ecx
    b102:	89 8c 90 04 00 02 00 	mov    DWORD PTR [eax+edx*4+0x20004],ecx
    b109:	c1 eb 11             	shr    ebx,0x11
    b10c:	c1 e9 0c             	shr    ecx,0xc
    b10f:	ba 01 00 00 00       	mov    edx,0x1
    b114:	d3 e2                	shl    edx,cl
    b116:	09 54 98 04          	or     DWORD PTR [eax+ebx*4+0x4],edx
    b11a:	5b                   	pop    ebx
    b11b:	c3                   	ret    
    b11c:	66 90                	xchg   ax,ax
    b11e:	66 90                	xchg   ax,ax

0000b120 <_ZN4boot12get_ram_sizeEv>:
    b120:	0f b7 05 02 05 00 00 	movzx  eax,WORD PTR ds:0x502
    b127:	0f b7 15 00 05 00 00 	movzx  edx,WORD PTR ds:0x500
    b12e:	c1 e0 06             	shl    eax,0x6
    b131:	01 d0                	add    eax,edx
    b133:	c1 e0 0a             	shl    eax,0xa
    b136:	c3                   	ret    
    b137:	66 90                	xchg   ax,ax
    b139:	66 90                	xchg   ax,ax
    b13b:	66 90                	xchg   ax,ax
    b13d:	66 90                	xchg   ax,ax
    b13f:	90                   	nop

0000b140 <_ZN3elf13load_file_hdrEjPFiPvjjS0_ES0_>:
    b140:	57                   	push   edi
    b141:	53                   	push   ebx
    b142:	83 ec 44             	sub    esp,0x44
    b145:	8b 5c 24 50          	mov    ebx,DWORD PTR [esp+0x50]
    b149:	ff 74 24 5c          	push   DWORD PTR [esp+0x5c]
    b14d:	6a 34                	push   0x34
    b14f:	ff 74 24 5c          	push   DWORD PTR [esp+0x5c]
    b153:	8d 44 24 18          	lea    eax,[esp+0x18]
    b157:	50                   	push   eax
    b158:	ff 54 24 68          	call   DWORD PTR [esp+0x68]
    b15c:	83 c4 10             	add    esp,0x10
    b15f:	85 c0                	test   eax,eax
    b161:	75 6d                	jne    b1d0 <_ZN3elf13load_file_hdrEjPFiPvjjS0_ES0_+0x90>
    b163:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b167:	89 03                	mov    DWORD PTR [ebx],eax
    b169:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    b16d:	89 43 04             	mov    DWORD PTR [ebx+0x4],eax
    b170:	8b 44 24 14          	mov    eax,DWORD PTR [esp+0x14]
    b174:	89 43 08             	mov    DWORD PTR [ebx+0x8],eax
    b177:	8b 44 24 18          	mov    eax,DWORD PTR [esp+0x18]
    b17b:	89 43 0c             	mov    DWORD PTR [ebx+0xc],eax
    b17e:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    b182:	89 43 10             	mov    DWORD PTR [ebx+0x10],eax
    b185:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    b189:	89 43 14             	mov    DWORD PTR [ebx+0x14],eax
    b18c:	8b 44 24 24          	mov    eax,DWORD PTR [esp+0x24]
    b190:	89 43 18             	mov    DWORD PTR [ebx+0x18],eax
    b193:	8b 44 24 28          	mov    eax,DWORD PTR [esp+0x28]
    b197:	89 43 1c             	mov    DWORD PTR [ebx+0x1c],eax
    b19a:	8b 44 24 2c          	mov    eax,DWORD PTR [esp+0x2c]
    b19e:	89 43 20             	mov    DWORD PTR [ebx+0x20],eax
    b1a1:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    b1a5:	89 43 24             	mov    DWORD PTR [ebx+0x24],eax
    b1a8:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    b1ac:	89 43 28             	mov    DWORD PTR [ebx+0x28],eax
    b1af:	8b 44 24 38          	mov    eax,DWORD PTR [esp+0x38]
    b1b3:	89 43 2c             	mov    DWORD PTR [ebx+0x2c],eax
    b1b6:	8b 44 24 3c          	mov    eax,DWORD PTR [esp+0x3c]
    b1ba:	89 43 30             	mov    DWORD PTR [ebx+0x30],eax
    b1bd:	83 c4 44             	add    esp,0x44
    b1c0:	89 d8                	mov    eax,ebx
    b1c2:	5b                   	pop    ebx
    b1c3:	5f                   	pop    edi
    b1c4:	c2 04 00             	ret    0x4
    b1c7:	89 f6                	mov    esi,esi
    b1c9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b1d0:	8d 7b 04             	lea    edi,[ebx+0x4]
    b1d3:	89 d9                	mov    ecx,ebx
    b1d5:	31 c0                	xor    eax,eax
    b1d7:	c7 03 00 00 00 00    	mov    DWORD PTR [ebx],0x0
    b1dd:	c7 43 30 00 00 00 00 	mov    DWORD PTR [ebx+0x30],0x0
    b1e4:	83 e7 fc             	and    edi,0xfffffffc
    b1e7:	29 f9                	sub    ecx,edi
    b1e9:	83 c1 34             	add    ecx,0x34
    b1ec:	c1 e9 02             	shr    ecx,0x2
    b1ef:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    b1f1:	83 c4 44             	add    esp,0x44
    b1f4:	89 d8                	mov    eax,ebx
    b1f6:	5b                   	pop    ebx
    b1f7:	5f                   	pop    edi
    b1f8:	c2 04 00             	ret    0x4
    b1fb:	90                   	nop
    b1fc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000b200 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_>:
    b200:	56                   	push   esi
    b201:	53                   	push   ebx
    b202:	83 ec 24             	sub    esp,0x24
    b205:	8b 44 24 38          	mov    eax,DWORD PTR [esp+0x38]
    b209:	8b 5c 24 30          	mov    ebx,DWORD PTR [esp+0x30]
    b20d:	ff 74 24 44          	push   DWORD PTR [esp+0x44]
    b211:	50                   	push   eax
    b212:	0f af 44 24 44       	imul   eax,DWORD PTR [esp+0x44]
    b217:	03 44 24 3c          	add    eax,DWORD PTR [esp+0x3c]
    b21b:	50                   	push   eax
    b21c:	8d 44 24 0c          	lea    eax,[esp+0xc]
    b220:	50                   	push   eax
    b221:	ff 54 24 50          	call   DWORD PTR [esp+0x50]
    b225:	83 c4 10             	add    esp,0x10
    b228:	85 c0                	test   eax,eax
    b22a:	75 44                	jne    b270 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_+0x70>
    b22c:	8b 04 24             	mov    eax,DWORD PTR [esp]
    b22f:	89 03                	mov    DWORD PTR [ebx],eax
    b231:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    b235:	89 43 04             	mov    DWORD PTR [ebx+0x4],eax
    b238:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    b23c:	89 43 08             	mov    DWORD PTR [ebx+0x8],eax
    b23f:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    b243:	89 43 0c             	mov    DWORD PTR [ebx+0xc],eax
    b246:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    b24a:	89 43 10             	mov    DWORD PTR [ebx+0x10],eax
    b24d:	8b 44 24 14          	mov    eax,DWORD PTR [esp+0x14]
    b251:	89 43 14             	mov    DWORD PTR [ebx+0x14],eax
    b254:	8b 44 24 18          	mov    eax,DWORD PTR [esp+0x18]
    b258:	89 43 18             	mov    DWORD PTR [ebx+0x18],eax
    b25b:	8b 44 24 1c          	mov    eax,DWORD PTR [esp+0x1c]
    b25f:	89 43 1c             	mov    DWORD PTR [ebx+0x1c],eax
    b262:	83 c4 24             	add    esp,0x24
    b265:	89 d8                	mov    eax,ebx
    b267:	5b                   	pop    ebx
    b268:	5e                   	pop    esi
    b269:	c2 04 00             	ret    0x4
    b26c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b270:	8d 4b 04             	lea    ecx,[ebx+0x4]
    b273:	89 d8                	mov    eax,ebx
    b275:	31 f6                	xor    esi,esi
    b277:	c7 03 00 00 00 00    	mov    DWORD PTR [ebx],0x0
    b27d:	c7 43 1c 00 00 00 00 	mov    DWORD PTR [ebx+0x1c],0x0
    b284:	31 d2                	xor    edx,edx
    b286:	83 e1 fc             	and    ecx,0xfffffffc
    b289:	29 c8                	sub    eax,ecx
    b28b:	83 c0 20             	add    eax,0x20
    b28e:	83 e0 fc             	and    eax,0xfffffffc
    b291:	89 34 11             	mov    DWORD PTR [ecx+edx*1],esi
    b294:	83 c2 04             	add    edx,0x4
    b297:	39 c2                	cmp    edx,eax
    b299:	72 f6                	jb     b291 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_+0x91>
    b29b:	eb c5                	jmp    b262 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_+0x62>
    b29d:	8d 76 00             	lea    esi,[esi+0x0]

0000b2a0 <_ZN3elf13load_sect_hdrEjjjPFiPvjjS0_ES0_>:
    b2a0:	57                   	push   edi
    b2a1:	53                   	push   ebx
    b2a2:	83 ec 34             	sub    esp,0x34
    b2a5:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    b2a9:	8b 5c 24 40          	mov    ebx,DWORD PTR [esp+0x40]
    b2ad:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    b2b1:	50                   	push   eax
    b2b2:	0f af 44 24 54       	imul   eax,DWORD PTR [esp+0x54]
    b2b7:	03 44 24 4c          	add    eax,DWORD PTR [esp+0x4c]
    b2bb:	50                   	push   eax
    b2bc:	8d 44 24 14          	lea    eax,[esp+0x14]
    b2c0:	50                   	push   eax
    b2c1:	ff 54 24 60          	call   DWORD PTR [esp+0x60]
    b2c5:	83 c4 10             	add    esp,0x10
    b2c8:	85 c0                	test   eax,eax
    b2ca:	74 34                	je     b300 <_ZN3elf13load_sect_hdrEjjjPFiPvjjS0_ES0_+0x60>
    b2cc:	8d 7b 04             	lea    edi,[ebx+0x4]
    b2cf:	89 d9                	mov    ecx,ebx
    b2d1:	31 c0                	xor    eax,eax
    b2d3:	c7 03 00 00 00 00    	mov    DWORD PTR [ebx],0x0
    b2d9:	c7 43 24 00 00 00 00 	mov    DWORD PTR [ebx+0x24],0x0
    b2e0:	83 e7 fc             	and    edi,0xfffffffc
    b2e3:	29 f9                	sub    ecx,edi
    b2e5:	83 c1 28             	add    ecx,0x28
    b2e8:	c1 e9 02             	shr    ecx,0x2
    b2eb:	f3 ab                	rep stos DWORD PTR es:[edi],eax
    b2ed:	83 c4 34             	add    esp,0x34
    b2f0:	89 d8                	mov    eax,ebx
    b2f2:	5b                   	pop    ebx
    b2f3:	5f                   	pop    edi
    b2f4:	c2 04 00             	ret    0x4
    b2f7:	89 f6                	mov    esi,esi
    b2f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b300:	83 ec 0c             	sub    esp,0xc
    b303:	ff 74 24 20          	push   DWORD PTR [esp+0x20]
    b307:	68 40 00 01 00       	push   0x10040
    b30c:	6a 27                	push   0x27
    b30e:	68 87 09 01 00       	push   0x10987
    b313:	68 a3 09 01 00       	push   0x109a3
    b318:	e8 23 25 00 00       	call   d840 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_>
    b31d:	8b 44 24 28          	mov    eax,DWORD PTR [esp+0x28]
    b321:	89 03                	mov    DWORD PTR [ebx],eax
    b323:	8b 44 24 2c          	mov    eax,DWORD PTR [esp+0x2c]
    b327:	89 43 04             	mov    DWORD PTR [ebx+0x4],eax
    b32a:	8b 44 24 30          	mov    eax,DWORD PTR [esp+0x30]
    b32e:	89 43 08             	mov    DWORD PTR [ebx+0x8],eax
    b331:	8b 44 24 34          	mov    eax,DWORD PTR [esp+0x34]
    b335:	89 43 0c             	mov    DWORD PTR [ebx+0xc],eax
    b338:	8b 44 24 38          	mov    eax,DWORD PTR [esp+0x38]
    b33c:	89 43 10             	mov    DWORD PTR [ebx+0x10],eax
    b33f:	8b 44 24 3c          	mov    eax,DWORD PTR [esp+0x3c]
    b343:	89 43 14             	mov    DWORD PTR [ebx+0x14],eax
    b346:	8b 44 24 40          	mov    eax,DWORD PTR [esp+0x40]
    b34a:	89 43 18             	mov    DWORD PTR [ebx+0x18],eax
    b34d:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    b351:	89 43 1c             	mov    DWORD PTR [ebx+0x1c],eax
    b354:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    b358:	89 43 20             	mov    DWORD PTR [ebx+0x20],eax
    b35b:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    b35f:	83 c4 20             	add    esp,0x20
    b362:	89 43 24             	mov    DWORD PTR [ebx+0x24],eax
    b365:	83 c4 34             	add    esp,0x34
    b368:	89 d8                	mov    eax,ebx
    b36a:	5b                   	pop    ebx
    b36b:	5f                   	pop    edi
    b36c:	c2 04 00             	ret    0x4
    b36f:	90                   	nop

0000b370 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_>:
    b370:	55                   	push   ebp
    b371:	89 e5                	mov    ebp,esp
    b373:	57                   	push   edi
    b374:	56                   	push   esi
    b375:	53                   	push   ebx
    b376:	8d 45 b4             	lea    eax,[ebp-0x4c]
    b379:	31 f6                	xor    esi,esi
    b37b:	81 ec dc 00 00 00    	sub    esp,0xdc
    b381:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    b384:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    b387:	ff 75 08             	push   DWORD PTR [ebp+0x8]
    b38a:	50                   	push   eax
    b38b:	e8 b0 fd ff ff       	call   b140 <_ZN3elf13load_file_hdrEjPFiPvjjS0_ES0_>
    b390:	0f b6 45 b5          	movzx  eax,BYTE PTR [ebp-0x4b]
    b394:	c7 85 5c ff ff ff 87 	mov    DWORD PTR [ebp-0xa4],0x10987
    b39b:	09 01 00 
    b39e:	83 c4 0c             	add    esp,0xc
    b3a1:	ba 5b 00 00 00       	mov    edx,0x5b
    b3a6:	88 85 48 ff ff ff    	mov    BYTE PTR [ebp-0xb8],al
    b3ac:	0f b6 45 b6          	movzx  eax,BYTE PTR [ebp-0x4a]
    b3b0:	88 85 4c ff ff ff    	mov    BYTE PTR [ebp-0xb4],al
    b3b6:	0f b6 45 b7          	movzx  eax,BYTE PTR [ebp-0x49]
    b3ba:	88 85 50 ff ff ff    	mov    BYTE PTR [ebp-0xb0],al
    b3c0:	8b 45 d0             	mov    eax,DWORD PTR [ebp-0x30]
    b3c3:	89 85 44 ff ff ff    	mov    DWORD PTR [ebp-0xbc],eax
    b3c9:	8b 45 d4             	mov    eax,DWORD PTR [ebp-0x2c]
    b3cc:	89 85 24 ff ff ff    	mov    DWORD PTR [ebp-0xdc],eax
    b3d2:	0f b7 45 de          	movzx  eax,WORD PTR [ebp-0x22]
    b3d6:	66 89 85 40 ff ff ff 	mov    WORD PTR [ebp-0xc0],ax
    b3dd:	0f b7 45 e0          	movzx  eax,WORD PTR [ebp-0x20]
    b3e1:	66 89 85 3c ff ff ff 	mov    WORD PTR [ebp-0xc4],ax
    b3e8:	0f b7 45 e2          	movzx  eax,WORD PTR [ebp-0x1e]
    b3ec:	66 89 85 34 ff ff ff 	mov    WORD PTR [ebp-0xcc],ax
    b3f3:	0f b7 45 e4          	movzx  eax,WORD PTR [ebp-0x1c]
    b3f7:	66 89 85 1e ff ff ff 	mov    WORD PTR [ebp-0xe2],ax
    b3fe:	0f b6 45 b4          	movzx  eax,BYTE PTR [ebp-0x4c]
    b402:	88 85 38 ff ff ff    	mov    BYTE PTR [ebp-0xc8],al
    b408:	eb 29                	jmp    b433 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xc3>
    b40a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    b410:	3c 25                	cmp    al,0x25
    b412:	0f 84 30 07 00 00    	je     bb48 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x7d8>
    b418:	84 c0                	test   al,al
    b41a:	0f 85 38 06 00 00    	jne    ba58 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x6e8>
    b420:	8d 5e 02             	lea    ebx,[esi+0x2]
    b423:	0f b6 83 ac 05 01 00 	movzx  eax,BYTE PTR [ebx+0x105ac]
    b42a:	84 c0                	test   al,al
    b42c:	74 3a                	je     b468 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xf8>
    b42e:	0f be d0             	movsx  edx,al
    b431:	89 de                	mov    esi,ebx
    b433:	8d 5e 01             	lea    ebx,[esi+0x1]
    b436:	80 fa 25             	cmp    dl,0x25
    b439:	0f b6 83 ac 05 01 00 	movzx  eax,BYTE PTR [ebx+0x105ac]
    b440:	8d 8b ac 05 01 00    	lea    ecx,[ebx+0x105ac]
    b446:	74 c8                	je     b410 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xa0>
    b448:	83 ec 0c             	sub    esp,0xc
    b44b:	88 85 54 ff ff ff    	mov    BYTE PTR [ebp-0xac],al
    b451:	52                   	push   edx
    b452:	e8 79 08 00 00       	call   bcd0 <_Z7putcharc>
    b457:	0f b6 85 54 ff ff ff 	movzx  eax,BYTE PTR [ebp-0xac]
    b45e:	83 c4 10             	add    esp,0x10
    b461:	84 c0                	test   al,al
    b463:	75 c9                	jne    b42e <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xbe>
    b465:	8d 76 00             	lea    esi,[esi+0x0]
    b468:	80 bd 48 ff ff ff 45 	cmp    BYTE PTR [ebp-0xb8],0x45
    b46f:	0f 95 c0             	setne  al
    b472:	80 bd 4c ff ff ff 4c 	cmp    BYTE PTR [ebp-0xb4],0x4c
    b479:	0f 95 c2             	setne  dl
    b47c:	09 d0                	or     eax,edx
    b47e:	80 bd 50 ff ff ff 46 	cmp    BYTE PTR [ebp-0xb0],0x46
    b485:	0f 95 c2             	setne  dl
    b488:	08 d0                	or     al,dl
    b48a:	0f 85 ad 05 00 00    	jne    ba3d <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x6cd>
    b490:	0f b7 85 3c ff ff ff 	movzx  eax,WORD PTR [ebp-0xc4]
    b497:	83 ec 0c             	sub    esp,0xc
    b49a:	50                   	push   eax
    b49b:	68 30 00 01 00       	push   0x10030
    b4a0:	6a 37                	push   0x37
    b4a2:	68 87 09 01 00       	push   0x10987
    b4a7:	68 d4 05 01 00       	push   0x105d4
    b4ac:	89 85 3c ff ff ff    	mov    DWORD PTR [ebp-0xc4],eax
    b4b2:	e8 99 3b 00 00       	call   f050 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_>
    b4b7:	83 c4 14             	add    esp,0x14
    b4ba:	ff b5 44 ff ff ff    	push   DWORD PTR [ebp-0xbc]
    b4c0:	68 30 00 01 00       	push   0x10030
    b4c5:	6a 38                	push   0x38
    b4c7:	68 87 09 01 00       	push   0x10987
    b4cc:	68 f4 05 01 00       	push   0x105f4
    b4d1:	e8 6a 23 00 00       	call   d840 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_>
    b4d6:	0f b7 85 40 ff ff ff 	movzx  eax,WORD PTR [ebp-0xc0]
    b4dd:	83 c4 14             	add    esp,0x14
    b4e0:	50                   	push   eax
    b4e1:	68 30 00 01 00       	push   0x10030
    b4e6:	6a 39                	push   0x39
    b4e8:	68 87 09 01 00       	push   0x10987
    b4ed:	68 14 06 01 00       	push   0x10614
    b4f2:	89 85 38 ff ff ff    	mov    DWORD PTR [ebp-0xc8],eax
    b4f8:	e8 53 3b 00 00       	call   f050 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_>
    b4fd:	8b 85 24 ff ff ff    	mov    eax,DWORD PTR [ebp-0xdc]
    b503:	03 45 08             	add    eax,DWORD PTR [ebp+0x8]
    b506:	83 c4 18             	add    esp,0x18
    b509:	0f b7 bd 34 ff ff ff 	movzx  edi,WORD PTR [ebp-0xcc]
    b510:	0f b7 55 e6          	movzx  edx,WORD PTR [ebp-0x1a]
    b514:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    b517:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    b51a:	89 c6                	mov    esi,eax
    b51c:	89 85 2c ff ff ff    	mov    DWORD PTR [ebp-0xd4],eax
    b522:	8d 85 64 ff ff ff    	lea    eax,[ebp-0x9c]
    b528:	52                   	push   edx
    b529:	57                   	push   edi
    b52a:	56                   	push   esi
    b52b:	50                   	push   eax
    b52c:	89 bd 30 ff ff ff    	mov    DWORD PTR [ebp-0xd0],edi
    b532:	e8 69 fd ff ff       	call   b2a0 <_ZN3elf13load_sect_hdrEjjjPFiPvjjS0_ES0_>
    b537:	8b 95 78 ff ff ff    	mov    edx,DWORD PTR [ebp-0x88]
    b53d:	83 c4 1c             	add    esp,0x1c
    b540:	8d 4a 0f             	lea    ecx,[edx+0xf]
    b543:	8d 5a ff             	lea    ebx,[edx-0x1]
    b546:	89 ce                	mov    esi,ecx
    b548:	83 e6 f0             	and    esi,0xfffffff0
    b54b:	29 f4                	sub    esp,esi
    b54d:	83 fa 01             	cmp    edx,0x1
    b550:	89 a5 28 ff ff ff    	mov    DWORD PTR [ebp-0xd8],esp
    b556:	c6 04 24 00          	mov    BYTE PTR [esp],0x0
    b55a:	8d 44 24 01          	lea    eax,[esp+0x1]
    b55e:	0f 8e 3a 06 00 00    	jle    bb9e <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x82e>
    b564:	8d 34 14             	lea    esi,[esp+edx*1]
    b567:	89 f6                	mov    esi,esi
    b569:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b570:	c6 00 00             	mov    BYTE PTR [eax],0x0
    b573:	83 c0 01             	add    eax,0x1
    b576:	39 f0                	cmp    eax,esi
    b578:	75 f6                	jne    b570 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x200>
    b57a:	83 e1 f0             	and    ecx,0xfffffff0
    b57d:	29 cc                	sub    esp,ecx
    b57f:	8d 44 24 01          	lea    eax,[esp+0x1]
    b583:	8d 0c 14             	lea    ecx,[esp+edx*1]
    b586:	89 e6                	mov    esi,esp
    b588:	c6 04 24 00          	mov    BYTE PTR [esp],0x0
    b58c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    b590:	c6 00 00             	mov    BYTE PTR [eax],0x0
    b593:	83 c0 01             	add    eax,0x1
    b596:	39 c1                	cmp    ecx,eax
    b598:	75 f6                	jne    b590 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x220>
    b59a:	8b 45 08             	mov    eax,DWORD PTR [ebp+0x8]
    b59d:	03 85 74 ff ff ff    	add    eax,DWORD PTR [ebp-0x8c]
    b5a3:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    b5a6:	52                   	push   edx
    b5a7:	50                   	push   eax
    b5a8:	ff b5 28 ff ff ff    	push   DWORD PTR [ebp-0xd8]
    b5ae:	ff 55 0c             	call   DWORD PTR [ebp+0xc]
    b5b1:	83 c4 10             	add    esp,0x10
    b5b4:	85 c0                	test   eax,eax
    b5b6:	89 85 20 ff ff ff    	mov    DWORD PTR [ebp-0xe0],eax
    b5bc:	0f 85 e9 05 00 00    	jne    bbab <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x83b>
    b5c2:	85 db                	test   ebx,ebx
    b5c4:	78 32                	js     b5f8 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x288>
    b5c6:	31 d2                	xor    edx,edx
    b5c8:	8b 8d 28 ff ff ff    	mov    ecx,DWORD PTR [ebp-0xd8]
    b5ce:	eb 0c                	jmp    b5dc <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x26c>
    b5d0:	c6 04 1e 20          	mov    BYTE PTR [esi+ebx*1],0x20
    b5d4:	83 eb 01             	sub    ebx,0x1
    b5d7:	83 fb ff             	cmp    ebx,0xffffffff
    b5da:	74 1c                	je     b5f8 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x288>
    b5dc:	0f b6 04 19          	movzx  eax,BYTE PTR [ecx+ebx*1]
    b5e0:	84 c0                	test   al,al
    b5e2:	88 04 1e             	mov    BYTE PTR [esi+ebx*1],al
    b5e5:	75 ed                	jne    b5d4 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x264>
    b5e7:	84 d2                	test   dl,dl
    b5e9:	75 e5                	jne    b5d0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x260>
    b5eb:	83 eb 01             	sub    ebx,0x1
    b5ee:	ba 01 00 00 00       	mov    edx,0x1
    b5f3:	83 fb ff             	cmp    ebx,0xffffffff
    b5f6:	75 e4                	jne    b5dc <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x26c>
    b5f8:	83 ec 0c             	sub    esp,0xc
    b5fb:	56                   	push   esi
    b5fc:	68 30 00 01 00       	push   0x10030
    b601:	6a 4f                	push   0x4f
    b603:	68 87 09 01 00       	push   0x10987
    b608:	68 68 06 01 00       	push   0x10668
    b60d:	e8 0e 1f 00 00       	call   d520 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_>
    b612:	8b 85 3c ff ff ff    	mov    eax,DWORD PTR [ebp-0xc4]
    b618:	83 c4 20             	add    esp,0x20
    b61b:	85 c0                	test   eax,eax
    b61d:	0f 84 32 01 00 00    	je     b755 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x3e5>
    b623:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [ebp-0xbc]
    b629:	03 45 08             	add    eax,DWORD PTR [ebp+0x8]
    b62c:	be 68 00 01 00       	mov    esi,0x10068
    b631:	c7 85 54 ff ff ff 00 	mov    DWORD PTR [ebp-0xac],0x0
    b638:	00 00 00 
    b63b:	bb 01 00 00 00       	mov    ebx,0x1
    b640:	89 85 34 ff ff ff    	mov    DWORD PTR [ebp-0xcc],eax
    b646:	8d 45 8c             	lea    eax,[ebp-0x74]
    b649:	89 85 40 ff ff ff    	mov    DWORD PTR [ebp-0xc0],eax
    b64f:	90                   	nop
    b650:	83 ec 08             	sub    esp,0x8
    b653:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    b656:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    b659:	ff b5 54 ff ff ff    	push   DWORD PTR [ebp-0xac]
    b65f:	ff b5 38 ff ff ff    	push   DWORD PTR [ebp-0xc8]
    b665:	31 ff                	xor    edi,edi
    b667:	ff b5 34 ff ff ff    	push   DWORD PTR [ebp-0xcc]
    b66d:	ff b5 40 ff ff ff    	push   DWORD PTR [ebp-0xc0]
    b673:	e8 88 fb ff ff       	call   b200 <_ZN3elf13load_prog_hdrEjjjPFiPvjjS0_ES0_>
    b678:	8b 45 90             	mov    eax,DWORD PTR [ebp-0x70]
    b67b:	8b 4d 8c             	mov    ecx,DWORD PTR [ebp-0x74]
    b67e:	83 c4 1c             	add    esp,0x1c
    b681:	ba 01 00 00 00       	mov    edx,0x1
    b686:	89 85 4c ff ff ff    	mov    DWORD PTR [ebp-0xb4],eax
    b68c:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    b68f:	89 85 50 ff ff ff    	mov    DWORD PTR [ebp-0xb0],eax
    b695:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    b698:	89 85 48 ff ff ff    	mov    DWORD PTR [ebp-0xb8],eax
    b69e:	b8 54 00 01 00       	mov    eax,0x10054
    b6a3:	eb 08                	jmp    b6ad <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x33d>
    b6a5:	8d 76 00             	lea    esi,[esi+0x0]
    b6a8:	8b 10                	mov    edx,DWORD PTR [eax]
    b6aa:	83 c0 04             	add    eax,0x4
    b6ad:	39 d1                	cmp    ecx,edx
    b6af:	0f 44 fb             	cmove  edi,ebx
    b6b2:	39 c6                	cmp    esi,eax
    b6b4:	75 f2                	jne    b6a8 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x338>
    b6b6:	83 ec 0c             	sub    esp,0xc
    b6b9:	ff b5 54 ff ff ff    	push   DWORD PTR [ebp-0xac]
    b6bf:	89 8d 44 ff ff ff    	mov    DWORD PTR [ebp-0xbc],ecx
    b6c5:	68 30 00 01 00       	push   0x10030
    b6ca:	6a 5d                	push   0x5d
    b6cc:	68 87 09 01 00       	push   0x10987
    b6d1:	68 8c 06 01 00       	push   0x1068c
    b6d6:	e8 95 2a 00 00       	call   e170 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_>
    b6db:	83 c4 20             	add    esp,0x20
    b6de:	ff b5 48 ff ff ff    	push   DWORD PTR [ebp-0xb8]
    b6e4:	ff 75 a8             	push   DWORD PTR [ebp-0x58]
    b6e7:	ff 75 98             	push   DWORD PTR [ebp-0x68]
    b6ea:	ff b5 50 ff ff ff    	push   DWORD PTR [ebp-0xb0]
    b6f0:	68 30 00 01 00       	push   0x10030
    b6f5:	6a 60                	push   0x60
    b6f7:	68 87 09 01 00       	push   0x10987
    b6fc:	68 b0 06 01 00       	push   0x106b0
    b701:	e8 aa 3d 00 00       	call   f4b0 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_>
    b706:	8b 8d 44 ff ff ff    	mov    ecx,DWORD PTR [ebp-0xbc]
    b70c:	83 c4 1c             	add    esp,0x1c
    b70f:	ff b5 4c ff ff ff    	push   DWORD PTR [ebp-0xb4]
    b715:	51                   	push   ecx
    b716:	ff 75 a0             	push   DWORD PTR [ebp-0x60]
    b719:	68 30 00 01 00       	push   0x10030
    b71e:	6a 62                	push   0x62
    b720:	68 87 09 01 00       	push   0x10987
    b725:	68 ec 06 01 00       	push   0x106ec
    b72a:	e8 71 27 00 00       	call   dea0 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_>
    b72f:	89 f8                	mov    eax,edi
    b731:	83 c4 20             	add    esp,0x20
    b734:	84 c0                	test   al,al
    b736:	0f 85 c4 02 00 00    	jne    ba00 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x690>
    b73c:	83 85 54 ff ff ff 01 	add    DWORD PTR [ebp-0xac],0x1
    b743:	8b 85 54 ff ff ff    	mov    eax,DWORD PTR [ebp-0xac]
    b749:	39 85 3c ff ff ff    	cmp    DWORD PTR [ebp-0xc4],eax
    b74f:	0f 85 fb fe ff ff    	jne    b650 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x2e0>
    b755:	0f b7 85 1e ff ff ff 	movzx  eax,WORD PTR [ebp-0xe2]
    b75c:	83 ec 0c             	sub    esp,0xc
    b75f:	50                   	push   eax
    b760:	68 30 00 01 00       	push   0x10030
    b765:	89 c6                	mov    esi,eax
    b767:	6a 6e                	push   0x6e
    b769:	68 87 09 01 00       	push   0x10987
    b76e:	68 40 07 01 00       	push   0x10740
    b773:	89 85 54 ff ff ff    	mov    DWORD PTR [ebp-0xac],eax
    b779:	e8 d2 38 00 00       	call   f050 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_>
    b77e:	83 c4 14             	add    esp,0x14
    b781:	ff b5 24 ff ff ff    	push   DWORD PTR [ebp-0xdc]
    b787:	68 30 00 01 00       	push   0x10030
    b78c:	6a 6f                	push   0x6f
    b78e:	68 87 09 01 00       	push   0x10987
    b793:	68 60 07 01 00       	push   0x10760
    b798:	e8 a3 20 00 00       	call   d840 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_>
    b79d:	83 c4 14             	add    esp,0x14
    b7a0:	ff b5 30 ff ff ff    	push   DWORD PTR [ebp-0xd0]
    b7a6:	68 30 00 01 00       	push   0x10030
    b7ab:	6a 70                	push   0x70
    b7ad:	68 87 09 01 00       	push   0x10987
    b7b2:	68 80 07 01 00       	push   0x10780
    b7b7:	e8 94 38 00 00       	call   f050 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_>
    b7bc:	83 c4 20             	add    esp,0x20
    b7bf:	85 f6                	test   esi,esi
    b7c1:	0f 84 09 02 00 00    	je     b9d0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x660>
    b7c7:	8d 45 8c             	lea    eax,[ebp-0x74]
    b7ca:	31 ff                	xor    edi,edi
    b7cc:	89 85 40 ff ff ff    	mov    DWORD PTR [ebp-0xc0],eax
    b7d2:	e9 9e 00 00 00       	jmp    b875 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x505>
    b7d7:	89 f6                	mov    esi,esi
    b7d9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    b7e0:	83 ec 0c             	sub    esp,0xc
    b7e3:	89 95 3c ff ff ff    	mov    DWORD PTR [ebp-0xc4],edx
    b7e9:	89 85 44 ff ff ff    	mov    DWORD PTR [ebp-0xbc],eax
    b7ef:	51                   	push   ecx
    b7f0:	68 30 00 01 00       	push   0x10030
    b7f5:	68 81 00 00 00       	push   0x81
    b7fa:	68 87 09 01 00       	push   0x10987
    b7ff:	68 dd 09 01 00       	push   0x109dd
    b804:	e8 17 1d 00 00       	call   d520 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_>
    b809:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [ebp-0xbc]
    b80f:	83 c4 20             	add    esp,0x20
    b812:	50                   	push   eax
    b813:	ff b5 4c ff ff ff    	push   DWORD PTR [ebp-0xb4]
    b819:	53                   	push   ebx
    b81a:	ff b5 50 ff ff ff    	push   DWORD PTR [ebp-0xb0]
    b820:	68 30 00 01 00       	push   0x10030
    b825:	68 84 00 00 00       	push   0x84
    b82a:	68 87 09 01 00       	push   0x10987
    b82f:	68 f0 07 01 00       	push   0x107f0
    b834:	e8 77 3c 00 00       	call   f4b0 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_>
    b839:	8b 95 3c ff ff ff    	mov    edx,DWORD PTR [ebp-0xc4]
    b83f:	83 c4 1c             	add    esp,0x1c
    b842:	ff b5 48 ff ff ff    	push   DWORD PTR [ebp-0xb8]
    b848:	56                   	push   esi
    b849:	52                   	push   edx
    b84a:	68 30 00 01 00       	push   0x10030
    b84f:	68 86 00 00 00       	push   0x86
    b854:	68 87 09 01 00       	push   0x10987
    b859:	68 2c 08 01 00       	push   0x1082c
    b85e:	e8 3d 26 00 00       	call   dea0 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_>
    b863:	83 c4 20             	add    esp,0x20
    b866:	83 c7 01             	add    edi,0x1
    b869:	39 bd 54 ff ff ff    	cmp    DWORD PTR [ebp-0xac],edi
    b86f:	0f 84 5b 01 00 00    	je     b9d0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x660>
    b875:	83 ec 0c             	sub    esp,0xc
    b878:	57                   	push   edi
    b879:	68 30 00 01 00       	push   0x10030
    b87e:	6a 73                	push   0x73
    b880:	68 87 09 01 00       	push   0x10987
    b885:	68 a4 07 01 00       	push   0x107a4
    b88a:	e8 e1 28 00 00       	call   e170 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_>
    b88f:	83 c4 18             	add    esp,0x18
    b892:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    b895:	ff 75 0c             	push   DWORD PTR [ebp+0xc]
    b898:	57                   	push   edi
    b899:	ff b5 30 ff ff ff    	push   DWORD PTR [ebp-0xd0]
    b89f:	ff b5 2c ff ff ff    	push   DWORD PTR [ebp-0xd4]
    b8a5:	ff b5 40 ff ff ff    	push   DWORD PTR [ebp-0xc0]
    b8ab:	e8 f0 f9 ff ff       	call   b2a0 <_ZN3elf13load_sect_hdrEjjjPFiPvjjS0_ES0_>
    b8b0:	8b 75 90             	mov    esi,DWORD PTR [ebp-0x70]
    b8b3:	83 c4 1c             	add    esp,0x1c
    b8b6:	85 f6                	test   esi,esi
    b8b8:	74 ac                	je     b866 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x4f6>
    b8ba:	8b 45 94             	mov    eax,DWORD PTR [ebp-0x6c]
    b8bd:	8b 8d 28 ff ff ff    	mov    ecx,DWORD PTR [ebp-0xd8]
    b8c3:	8b 5d 98             	mov    ebx,DWORD PTR [ebp-0x68]
    b8c6:	8b 55 a0             	mov    edx,DWORD PTR [ebp-0x60]
    b8c9:	89 85 50 ff ff ff    	mov    DWORD PTR [ebp-0xb0],eax
    b8cf:	8b 45 9c             	mov    eax,DWORD PTR [ebp-0x64]
    b8d2:	89 85 48 ff ff ff    	mov    DWORD PTR [ebp-0xb8],eax
    b8d8:	8b 45 ac             	mov    eax,DWORD PTR [ebp-0x54]
    b8db:	89 85 4c ff ff ff    	mov    DWORD PTR [ebp-0xb4],eax
    b8e1:	8b 45 8c             	mov    eax,DWORD PTR [ebp-0x74]
    b8e4:	01 c1                	add    ecx,eax
    b8e6:	83 fe 08             	cmp    esi,0x8
    b8e9:	0f 85 f1 fe ff ff    	jne    b7e0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x470>
    b8ef:	83 ec 0c             	sub    esp,0xc
    b8f2:	89 95 3c ff ff ff    	mov    DWORD PTR [ebp-0xc4],edx
    b8f8:	89 85 44 ff ff ff    	mov    DWORD PTR [ebp-0xbc],eax
    b8fe:	51                   	push   ecx
    b8ff:	68 30 00 01 00       	push   0x10030
    b904:	68 81 00 00 00       	push   0x81
    b909:	68 87 09 01 00       	push   0x10987
    b90e:	68 dd 09 01 00       	push   0x109dd
    b913:	e8 08 1c 00 00       	call   d520 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_>
    b918:	8b 85 44 ff ff ff    	mov    eax,DWORD PTR [ebp-0xbc]
    b91e:	83 c4 20             	add    esp,0x20
    b921:	50                   	push   eax
    b922:	ff b5 4c ff ff ff    	push   DWORD PTR [ebp-0xb4]
    b928:	53                   	push   ebx
    b929:	ff b5 50 ff ff ff    	push   DWORD PTR [ebp-0xb0]
    b92f:	68 30 00 01 00       	push   0x10030
    b934:	68 84 00 00 00       	push   0x84
    b939:	68 87 09 01 00       	push   0x10987
    b93e:	68 f0 07 01 00       	push   0x107f0
    b943:	e8 68 3b 00 00       	call   f4b0 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_>
    b948:	8b 95 3c ff ff ff    	mov    edx,DWORD PTR [ebp-0xc4]
    b94e:	83 c4 1c             	add    esp,0x1c
    b951:	ff b5 48 ff ff ff    	push   DWORD PTR [ebp-0xb8]
    b957:	6a 08                	push   0x8
    b959:	52                   	push   edx
    b95a:	68 30 00 01 00       	push   0x10030
    b95f:	68 86 00 00 00       	push   0x86
    b964:	68 87 09 01 00       	push   0x10987
    b969:	68 2c 08 01 00       	push   0x1082c
    b96e:	89 95 50 ff ff ff    	mov    DWORD PTR [ebp-0xb0],edx
    b974:	e8 27 25 00 00       	call   dea0 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_>
    b979:	8b 95 50 ff ff ff    	mov    edx,DWORD PTR [ebp-0xb0]
    b97f:	83 c4 20             	add    esp,0x20
    b982:	85 d2                	test   edx,edx
    b984:	8d 04 13             	lea    eax,[ebx+edx*1]
    b987:	74 11                	je     b99a <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x62a>
    b989:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b990:	c6 03 00             	mov    BYTE PTR [ebx],0x0
    b993:	83 c3 01             	add    ebx,0x1
    b996:	39 d8                	cmp    eax,ebx
    b998:	75 f6                	jne    b990 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x620>
    b99a:	83 ec 0c             	sub    esp,0xc
    b99d:	83 c7 01             	add    edi,0x1
    b9a0:	52                   	push   edx
    b9a1:	68 30 00 01 00       	push   0x10030
    b9a6:	68 8b 00 00 00       	push   0x8b
    b9ab:	68 87 09 01 00       	push   0x10987
    b9b0:	68 c8 07 01 00       	push   0x107c8
    b9b5:	e8 86 1e 00 00       	call   d840 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_>
    b9ba:	83 c4 20             	add    esp,0x20
    b9bd:	39 bd 54 ff ff ff    	cmp    DWORD PTR [ebp-0xac],edi
    b9c3:	0f 85 ac fe ff ff    	jne    b875 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x505>
    b9c9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    b9d0:	68 30 00 01 00       	push   0x10030
    b9d5:	68 8f 00 00 00       	push   0x8f
    b9da:	68 87 09 01 00       	push   0x10987
    b9df:	68 c0 09 01 00       	push   0x109c0
    b9e4:	e8 e7 16 00 00       	call   d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>
    b9e9:	83 c4 10             	add    esp,0x10
    b9ec:	8b 85 20 ff ff ff    	mov    eax,DWORD PTR [ebp-0xe0]
    b9f2:	8d 65 f4             	lea    esp,[ebp-0xc]
    b9f5:	5b                   	pop    ebx
    b9f6:	5e                   	pop    esi
    b9f7:	5f                   	pop    edi
    b9f8:	5d                   	pop    ebp
    b9f9:	c3                   	ret    
    b9fa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ba00:	68 30 00 01 00       	push   0x10030
    ba05:	6a 65                	push   0x65
    ba07:	68 87 09 01 00       	push   0x10987
    ba0c:	68 1c 07 01 00       	push   0x1071c
    ba11:	e8 ba 16 00 00       	call   d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>
    ba16:	8b 85 4c ff ff ff    	mov    eax,DWORD PTR [ebp-0xb4]
    ba1c:	03 45 08             	add    eax,DWORD PTR [ebp+0x8]
    ba1f:	ff 75 10             	push   DWORD PTR [ebp+0x10]
    ba22:	ff b5 48 ff ff ff    	push   DWORD PTR [ebp-0xb8]
    ba28:	50                   	push   eax
    ba29:	ff b5 50 ff ff ff    	push   DWORD PTR [ebp-0xb0]
    ba2f:	ff 55 0c             	call   DWORD PTR [ebp+0xc]
    ba32:	83 c4 20             	add    esp,0x20
    ba35:	85 c0                	test   eax,eax
    ba37:	0f 84 ff fc ff ff    	je     b73c <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x3cc>
    ba3d:	c7 85 20 ff ff ff ff 	mov    DWORD PTR [ebp-0xe0],0xffffffff
    ba44:	ff ff ff 
    ba47:	8b 85 20 ff ff ff    	mov    eax,DWORD PTR [ebp-0xe0]
    ba4d:	8d 65 f4             	lea    esp,[ebp-0xc]
    ba50:	5b                   	pop    ebx
    ba51:	5e                   	pop    esi
    ba52:	5f                   	pop    edi
    ba53:	5d                   	pop    ebp
    ba54:	c3                   	ret    
    ba55:	8d 76 00             	lea    esi,[esi+0x0]
    ba58:	8d 85 5c ff ff ff    	lea    eax,[ebp-0xa4]
    ba5e:	83 ec 08             	sub    esp,0x8
    ba61:	50                   	push   eax
    ba62:	51                   	push   ecx
    ba63:	e8 68 14 00 00       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    ba68:	01 c3                	add    ebx,eax
    ba6a:	83 c4 10             	add    esp,0x10
    ba6d:	c7 85 60 ff ff ff 2f 	mov    DWORD PTR [ebp-0xa0],0x2f
    ba74:	00 00 00 
    ba77:	0f be 83 ac 05 01 00 	movsx  eax,BYTE PTR [ebx+0x105ac]
    ba7e:	8d 93 ac 05 01 00    	lea    edx,[ebx+0x105ac]
    ba84:	84 c0                	test   al,al
    ba86:	0f 84 dc f9 ff ff    	je     b468 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xf8>
    ba8c:	31 ff                	xor    edi,edi
    ba8e:	3c 25                	cmp    al,0x25
    ba90:	8d 77 01             	lea    esi,[edi+0x1]
    ba93:	8d 0c 32             	lea    ecx,[edx+esi*1]
    ba96:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    ba99:	75 34                	jne    bacf <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x75f>
    ba9b:	90                   	nop
    ba9c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    baa0:	80 fb 25             	cmp    bl,0x25
    baa3:	0f 84 c7 00 00 00    	je     bb70 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x800>
    baa9:	84 db                	test   bl,bl
    baab:	75 43                	jne    baf0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x780>
    baad:	0f b6 5c 3a 02       	movzx  ebx,BYTE PTR [edx+edi*1+0x2]
    bab2:	8d 77 02             	lea    esi,[edi+0x2]
    bab5:	84 db                	test   bl,bl
    bab7:	0f 84 ab f9 ff ff    	je     b468 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xf8>
    babd:	89 f7                	mov    edi,esi
    babf:	0f be c3             	movsx  eax,bl
    bac2:	8d 77 01             	lea    esi,[edi+0x1]
    bac5:	3c 25                	cmp    al,0x25
    bac7:	8d 0c 32             	lea    ecx,[edx+esi*1]
    baca:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    bacd:	74 d1                	je     baa0 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x730>
    bacf:	83 ec 0c             	sub    esp,0xc
    bad2:	89 95 54 ff ff ff    	mov    DWORD PTR [ebp-0xac],edx
    bad8:	50                   	push   eax
    bad9:	e8 f2 01 00 00       	call   bcd0 <_Z7putcharc>
    bade:	83 c4 10             	add    esp,0x10
    bae1:	84 db                	test   bl,bl
    bae3:	8b 95 54 ff ff ff    	mov    edx,DWORD PTR [ebp-0xac]
    bae9:	75 d2                	jne    babd <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x74d>
    baeb:	e9 78 f9 ff ff       	jmp    b468 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xf8>
    baf0:	8d 85 60 ff ff ff    	lea    eax,[ebp-0xa0]
    baf6:	83 ec 08             	sub    esp,0x8
    baf9:	89 95 54 ff ff ff    	mov    DWORD PTR [ebp-0xac],edx
    baff:	50                   	push   eax
    bb00:	51                   	push   ecx
    bb01:	e8 ca 14 00 00       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    bb06:	5a                   	pop    edx
    bb07:	59                   	pop    ecx
    bb08:	0f b6 8d 50 ff ff ff 	movzx  ecx,BYTE PTR [ebp-0xb0]
    bb0f:	8b 95 54 ff ff ff    	mov    edx,DWORD PTR [ebp-0xac]
    bb15:	01 f0                	add    eax,esi
    bb17:	01 c2                	add    edx,eax
    bb19:	51                   	push   ecx
    bb1a:	0f b6 8d 4c ff ff ff 	movzx  ecx,BYTE PTR [ebp-0xb4]
    bb21:	51                   	push   ecx
    bb22:	0f b6 8d 48 ff ff ff 	movzx  ecx,BYTE PTR [ebp-0xb8]
    bb29:	51                   	push   ecx
    bb2a:	0f b6 8d 38 ff ff ff 	movzx  ecx,BYTE PTR [ebp-0xc8]
    bb31:	51                   	push   ecx
    bb32:	68 30 00 01 00       	push   0x10030
    bb37:	52                   	push   edx
    bb38:	e8 33 3e 00 00       	call   f970 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_>
    bb3d:	83 c4 20             	add    esp,0x20
    bb40:	e9 23 f9 ff ff       	jmp    b468 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xf8>
    bb45:	8d 76 00             	lea    esi,[esi+0x0]
    bb48:	83 ec 0c             	sub    esp,0xc
    bb4b:	8d 5e 02             	lea    ebx,[esi+0x2]
    bb4e:	6a 25                	push   0x25
    bb50:	e8 7b 01 00 00       	call   bcd0 <_Z7putcharc>
    bb55:	0f b6 83 ac 05 01 00 	movzx  eax,BYTE PTR [ebx+0x105ac]
    bb5c:	83 c4 10             	add    esp,0x10
    bb5f:	84 c0                	test   al,al
    bb61:	0f 85 c7 f8 ff ff    	jne    b42e <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xbe>
    bb67:	e9 fc f8 ff ff       	jmp    b468 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xf8>
    bb6c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bb70:	83 ec 0c             	sub    esp,0xc
    bb73:	89 95 54 ff ff ff    	mov    DWORD PTR [ebp-0xac],edx
    bb79:	8d 77 02             	lea    esi,[edi+0x2]
    bb7c:	6a 25                	push   0x25
    bb7e:	e8 4d 01 00 00       	call   bcd0 <_Z7putcharc>
    bb83:	8b 95 54 ff ff ff    	mov    edx,DWORD PTR [ebp-0xac]
    bb89:	83 c4 10             	add    esp,0x10
    bb8c:	0f b6 5c 3a 02       	movzx  ebx,BYTE PTR [edx+edi*1+0x2]
    bb91:	84 db                	test   bl,bl
    bb93:	0f 85 24 ff ff ff    	jne    babd <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x74d>
    bb99:	e9 ca f8 ff ff       	jmp    b468 <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0xf8>
    bb9e:	29 f4                	sub    esp,esi
    bba0:	89 e6                	mov    esi,esp
    bba2:	c6 04 24 00          	mov    BYTE PTR [esp],0x0
    bba6:	e9 ef f9 ff ff       	jmp    b59a <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x22a>
    bbab:	68 30 00 01 00       	push   0x10030
    bbb0:	6a 43                	push   0x43
    bbb2:	68 87 09 01 00       	push   0x10987
    bbb7:	68 38 06 01 00       	push   0x10638
    bbbc:	e8 0f 15 00 00       	call   d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>
    bbc1:	83 c4 10             	add    esp,0x10
    bbc4:	c7 85 20 ff ff ff ff 	mov    DWORD PTR [ebp-0xe0],0xffffffff
    bbcb:	ff ff ff 
    bbce:	e9 19 fe ff ff       	jmp    b9ec <_ZN3elf15load_elf_in_memEjPFiPvjjS0_ES0_+0x67c>
    bbd3:	66 90                	xchg   ax,ax
    bbd5:	66 90                	xchg   ax,ax
    bbd7:	66 90                	xchg   ax,ax
    bbd9:	66 90                	xchg   ax,ax
    bbdb:	66 90                	xchg   ax,ax
    bbdd:	66 90                	xchg   ax,ax
    bbdf:	90                   	nop

0000bbe0 <_ZL17_put_nbr_base_recii.part.0>:
    bbe0:	89 d1                	mov    ecx,edx
    bbe2:	99                   	cdq    
    bbe3:	53                   	push   ebx
    bbe4:	f7 f9                	idiv   ecx
    bbe6:	83 ec 08             	sub    esp,0x8
    bbe9:	85 c0                	test   eax,eax
    bbeb:	89 d3                	mov    ebx,edx
    bbed:	75 19                	jne    bc08 <_ZL17_put_nbr_base_recii.part.0+0x28>
    bbef:	0f be 83 68 00 01 00 	movsx  eax,BYTE PTR [ebx+0x10068]
    bbf6:	83 ec 0c             	sub    esp,0xc
    bbf9:	50                   	push   eax
    bbfa:	e8 61 02 00 00       	call   be60 <_ZN6serial7sendchrEc>
    bbff:	83 c4 18             	add    esp,0x18
    bc02:	5b                   	pop    ebx
    bc03:	c3                   	ret    
    bc04:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bc08:	89 ca                	mov    edx,ecx
    bc0a:	e8 d1 ff ff ff       	call   bbe0 <_ZL17_put_nbr_base_recii.part.0>
    bc0f:	eb de                	jmp    bbef <_ZL17_put_nbr_base_recii.part.0+0xf>
    bc11:	eb 0d                	jmp    bc20 <_ZL13_put_nbr_basejib>
    bc13:	90                   	nop
    bc14:	90                   	nop
    bc15:	90                   	nop
    bc16:	90                   	nop
    bc17:	90                   	nop
    bc18:	90                   	nop
    bc19:	90                   	nop
    bc1a:	90                   	nop
    bc1b:	90                   	nop
    bc1c:	90                   	nop
    bc1d:	90                   	nop
    bc1e:	90                   	nop
    bc1f:	90                   	nop

0000bc20 <_ZL13_put_nbr_basejib>:
    bc20:	56                   	push   esi
    bc21:	53                   	push   ebx
    bc22:	89 d6                	mov    esi,edx
    bc24:	89 c3                	mov    ebx,eax
    bc26:	83 ec 04             	sub    esp,0x4
    bc29:	85 c0                	test   eax,eax
    bc2b:	79 05                	jns    bc32 <_ZL13_put_nbr_basejib+0x12>
    bc2d:	80 f9 01             	cmp    cl,0x1
    bc30:	75 2e                	jne    bc60 <_ZL13_put_nbr_basejib+0x40>
    bc32:	85 db                	test   ebx,ebx
    bc34:	74 6a                	je     bca0 <_ZL13_put_nbr_basejib+0x80>
    bc36:	89 d8                	mov    eax,ebx
    bc38:	31 d2                	xor    edx,edx
    bc3a:	f7 f6                	div    esi
    bc3c:	85 c0                	test   eax,eax
    bc3e:	89 d3                	mov    ebx,edx
    bc40:	75 76                	jne    bcb8 <_ZL13_put_nbr_basejib+0x98>
    bc42:	0f be 83 68 00 01 00 	movsx  eax,BYTE PTR [ebx+0x10068]
    bc49:	83 ec 0c             	sub    esp,0xc
    bc4c:	50                   	push   eax
    bc4d:	e8 0e 02 00 00       	call   be60 <_ZN6serial7sendchrEc>
    bc52:	83 c4 10             	add    esp,0x10
    bc55:	83 c4 04             	add    esp,0x4
    bc58:	5b                   	pop    ebx
    bc59:	5e                   	pop    esi
    bc5a:	c3                   	ret    
    bc5b:	90                   	nop
    bc5c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bc60:	83 ec 0c             	sub    esp,0xc
    bc63:	6a 2d                	push   0x2d
    bc65:	e8 f6 01 00 00       	call   be60 <_ZN6serial7sendchrEc>
    bc6a:	89 d8                	mov    eax,ebx
    bc6c:	83 c4 10             	add    esp,0x10
    bc6f:	99                   	cdq    
    bc70:	f7 fe                	idiv   esi
    bc72:	85 c0                	test   eax,eax
    bc74:	74 09                	je     bc7f <_ZL13_put_nbr_basejib+0x5f>
    bc76:	f7 d8                	neg    eax
    bc78:	89 f2                	mov    edx,esi
    bc7a:	e8 61 ff ff ff       	call   bbe0 <_ZL17_put_nbr_base_recii.part.0>
    bc7f:	89 d8                	mov    eax,ebx
    bc81:	83 ec 0c             	sub    esp,0xc
    bc84:	f7 d8                	neg    eax
    bc86:	99                   	cdq    
    bc87:	f7 fe                	idiv   esi
    bc89:	0f be 82 68 00 01 00 	movsx  eax,BYTE PTR [edx+0x10068]
    bc90:	50                   	push   eax
    bc91:	e8 ca 01 00 00       	call   be60 <_ZN6serial7sendchrEc>
    bc96:	83 c4 10             	add    esp,0x10
    bc99:	83 c4 04             	add    esp,0x4
    bc9c:	5b                   	pop    ebx
    bc9d:	5e                   	pop    esi
    bc9e:	c3                   	ret    
    bc9f:	90                   	nop
    bca0:	83 ec 0c             	sub    esp,0xc
    bca3:	6a 30                	push   0x30
    bca5:	e8 b6 01 00 00       	call   be60 <_ZN6serial7sendchrEc>
    bcaa:	83 c4 10             	add    esp,0x10
    bcad:	83 c4 04             	add    esp,0x4
    bcb0:	5b                   	pop    ebx
    bcb1:	5e                   	pop    esi
    bcb2:	c3                   	ret    
    bcb3:	90                   	nop
    bcb4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bcb8:	89 f2                	mov    edx,esi
    bcba:	e8 21 ff ff ff       	call   bbe0 <_ZL17_put_nbr_base_recii.part.0>
    bcbf:	eb 81                	jmp    bc42 <_ZL13_put_nbr_basejib+0x22>
    bcc1:	eb 0d                	jmp    bcd0 <_Z7putcharc>
    bcc3:	90                   	nop
    bcc4:	90                   	nop
    bcc5:	90                   	nop
    bcc6:	90                   	nop
    bcc7:	90                   	nop
    bcc8:	90                   	nop
    bcc9:	90                   	nop
    bcca:	90                   	nop
    bccb:	90                   	nop
    bccc:	90                   	nop
    bccd:	90                   	nop
    bcce:	90                   	nop
    bccf:	90                   	nop

0000bcd0 <_Z7putcharc>:
    bcd0:	0f be 44 24 04       	movsx  eax,BYTE PTR [esp+0x4]
    bcd5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    bcd9:	e9 82 01 00 00       	jmp    be60 <_ZN6serial7sendchrEc>
    bcde:	66 90                	xchg   ax,ax

0000bce0 <_Z6putdeci>:
    bce0:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    bce4:	31 c9                	xor    ecx,ecx
    bce6:	ba 0a 00 00 00       	mov    edx,0xa
    bceb:	e9 30 ff ff ff       	jmp    bc20 <_ZL13_put_nbr_basejib>

0000bcf0 <_Z6puthexi>:
    bcf0:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    bcf4:	b9 01 00 00 00       	mov    ecx,0x1
    bcf9:	ba 10 00 00 00       	mov    edx,0x10
    bcfe:	e9 1d ff ff ff       	jmp    bc20 <_ZL13_put_nbr_basejib>
    bd03:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bd09:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bd10 <_Z6putocti>:
    bd10:	8b 44 24 04          	mov    eax,DWORD PTR [esp+0x4]
    bd14:	31 c9                	xor    ecx,ecx
    bd16:	ba 08 00 00 00       	mov    edx,0x8
    bd1b:	e9 00 ff ff ff       	jmp    bc20 <_ZL13_put_nbr_basejib>

0000bd20 <_Z6putbini>:
    bd20:	57                   	push   edi
    bd21:	56                   	push   esi
    bd22:	be 00 00 00 80       	mov    esi,0x80000000
    bd27:	53                   	push   ebx
    bd28:	8b 7c 24 10          	mov    edi,DWORD PTR [esp+0x10]
    bd2c:	31 db                	xor    ebx,ebx
    bd2e:	66 90                	xchg   ax,ax
    bd30:	85 f7                	test   edi,esi
    bd32:	74 24                	je     bd58 <_Z6putbini+0x38>
    bd34:	83 ec 0c             	sub    esp,0xc
    bd37:	83 c3 01             	add    ebx,0x1
    bd3a:	d1 ee                	shr    esi,1
    bd3c:	6a 31                	push   0x31
    bd3e:	e8 1d 01 00 00       	call   be60 <_ZN6serial7sendchrEc>
    bd43:	83 c4 10             	add    esp,0x10
    bd46:	f6 c3 07             	test   bl,0x7
    bd49:	75 24                	jne    bd6f <_Z6putbini+0x4f>
    bd4b:	83 fb 20             	cmp    ebx,0x20
    bd4e:	75 30                	jne    bd80 <_Z6putbini+0x60>
    bd50:	5b                   	pop    ebx
    bd51:	5e                   	pop    esi
    bd52:	5f                   	pop    edi
    bd53:	c3                   	ret    
    bd54:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    bd58:	83 ec 0c             	sub    esp,0xc
    bd5b:	83 c3 01             	add    ebx,0x1
    bd5e:	d1 ee                	shr    esi,1
    bd60:	6a 30                	push   0x30
    bd62:	e8 f9 00 00 00       	call   be60 <_ZN6serial7sendchrEc>
    bd67:	83 c4 10             	add    esp,0x10
    bd6a:	f6 c3 07             	test   bl,0x7
    bd6d:	74 dc                	je     bd4b <_Z6putbini+0x2b>
    bd6f:	83 fb 20             	cmp    ebx,0x20
    bd72:	75 bc                	jne    bd30 <_Z6putbini+0x10>
    bd74:	eb da                	jmp    bd50 <_Z6putbini+0x30>
    bd76:	8d 76 00             	lea    esi,[esi+0x0]
    bd79:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    bd80:	83 ec 0c             	sub    esp,0xc
    bd83:	6a 27                	push   0x27
    bd85:	e8 d6 00 00 00       	call   be60 <_ZN6serial7sendchrEc>
    bd8a:	83 c4 10             	add    esp,0x10
    bd8d:	eb a1                	jmp    bd30 <_Z6putbini+0x10>
    bd8f:	90                   	nop

0000bd90 <_Z6putstrPc>:
    bd90:	53                   	push   ebx
    bd91:	83 ec 08             	sub    esp,0x8
    bd94:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    bd98:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    bd9b:	84 c0                	test   al,al
    bd9d:	74 20                	je     bdbf <_Z6putstrPc+0x2f>
    bd9f:	83 c3 01             	add    ebx,0x1
    bda2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bda8:	83 ec 0c             	sub    esp,0xc
    bdab:	83 c3 01             	add    ebx,0x1
    bdae:	50                   	push   eax
    bdaf:	e8 ac 00 00 00       	call   be60 <_ZN6serial7sendchrEc>
    bdb4:	0f be 43 ff          	movsx  eax,BYTE PTR [ebx-0x1]
    bdb8:	83 c4 10             	add    esp,0x10
    bdbb:	84 c0                	test   al,al
    bdbd:	75 e9                	jne    bda8 <_Z6putstrPc+0x18>
    bdbf:	83 c4 08             	add    esp,0x8
    bdc2:	5b                   	pop    ebx
    bdc3:	c3                   	ret    
    bdc4:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    bdca:	8d bf 00 00 00 00    	lea    edi,[edi+0x0]

0000bdd0 <_Z6printfPKc>:
    bdd0:	eb be                	jmp    bd90 <_Z6putstrPc>
    bdd2:	66 90                	xchg   ax,ax
    bdd4:	66 90                	xchg   ax,ax
    bdd6:	66 90                	xchg   ax,ax
    bdd8:	66 90                	xchg   ax,ax
    bdda:	66 90                	xchg   ax,ax
    bddc:	66 90                	xchg   ax,ax
    bdde:	66 90                	xchg   ax,ax

0000bde0 <_ZN6serial4initEv>:
    bde0:	83 ec 14             	sub    esp,0x14
    bde3:	6a 00                	push   0x0
    bde5:	68 fb 03 00 00       	push   0x3fb
    bdea:	e8 f1 00 00 00       	call   bee0 <_Z4outbth>
    bdef:	58                   	pop    eax
    bdf0:	5a                   	pop    edx
    bdf1:	6a 00                	push   0x0
    bdf3:	68 f9 03 00 00       	push   0x3f9
    bdf8:	e8 e3 00 00 00       	call   bee0 <_Z4outbth>
    bdfd:	59                   	pop    ecx
    bdfe:	58                   	pop    eax
    bdff:	68 80 00 00 00       	push   0x80
    be04:	68 fb 03 00 00       	push   0x3fb
    be09:	e8 d2 00 00 00       	call   bee0 <_Z4outbth>
    be0e:	58                   	pop    eax
    be0f:	5a                   	pop    edx
    be10:	6a 01                	push   0x1
    be12:	68 f8 03 00 00       	push   0x3f8
    be17:	e8 c4 00 00 00       	call   bee0 <_Z4outbth>
    be1c:	59                   	pop    ecx
    be1d:	58                   	pop    eax
    be1e:	6a 00                	push   0x0
    be20:	68 f9 03 00 00       	push   0x3f9
    be25:	e8 b6 00 00 00       	call   bee0 <_Z4outbth>
    be2a:	58                   	pop    eax
    be2b:	5a                   	pop    edx
    be2c:	6a 03                	push   0x3
    be2e:	68 fb 03 00 00       	push   0x3fb
    be33:	e8 a8 00 00 00       	call   bee0 <_Z4outbth>
    be38:	59                   	pop    ecx
    be39:	58                   	pop    eax
    be3a:	68 c7 00 00 00       	push   0xc7
    be3f:	68 fa 03 00 00       	push   0x3fa
    be44:	e8 97 00 00 00       	call   bee0 <_Z4outbth>
    be49:	83 c4 1c             	add    esp,0x1c
    be4c:	c3                   	ret    
    be4d:	8d 76 00             	lea    esi,[esi+0x0]

0000be50 <_ZN6serial6uninitEv>:
    be50:	f3 c3                	repz ret 
    be52:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    be59:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000be60 <_ZN6serial7sendchrEc>:
    be60:	53                   	push   ebx
    be61:	83 ec 08             	sub    esp,0x8
    be64:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    be68:	90                   	nop
    be69:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    be70:	83 ec 0c             	sub    esp,0xc
    be73:	68 fd 03 00 00       	push   0x3fd
    be78:	e8 b3 00 00 00       	call   bf30 <_Z3inbt>
    be7d:	83 c4 10             	add    esp,0x10
    be80:	a8 20                	test   al,0x20
    be82:	74 ec                	je     be70 <_ZN6serial7sendchrEc+0x10>
    be84:	83 ec 08             	sub    esp,0x8
    be87:	0f b6 db             	movzx  ebx,bl
    be8a:	53                   	push   ebx
    be8b:	68 f8 03 00 00       	push   0x3f8
    be90:	e8 4b 00 00 00       	call   bee0 <_Z4outbth>
    be95:	83 c4 18             	add    esp,0x18
    be98:	5b                   	pop    ebx
    be99:	c3                   	ret    
    be9a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000bea0 <_ZN6serial7sendstrEPc>:
    bea0:	53                   	push   ebx
    bea1:	83 ec 08             	sub    esp,0x8
    bea4:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    bea8:	85 db                	test   ebx,ebx
    beaa:	74 22                	je     bece <_ZN6serial7sendstrEPc+0x2e>
    beac:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    beaf:	84 c0                	test   al,al
    beb1:	74 1b                	je     bece <_ZN6serial7sendstrEPc+0x2e>
    beb3:	90                   	nop
    beb4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    beb8:	83 ec 0c             	sub    esp,0xc
    bebb:	83 c3 01             	add    ebx,0x1
    bebe:	50                   	push   eax
    bebf:	e8 9c ff ff ff       	call   be60 <_ZN6serial7sendchrEc>
    bec4:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    bec7:	83 c4 10             	add    esp,0x10
    beca:	84 c0                	test   al,al
    becc:	75 ea                	jne    beb8 <_ZN6serial7sendstrEPc+0x18>
    bece:	83 c4 08             	add    esp,0x8
    bed1:	5b                   	pop    ebx
    bed2:	c3                   	ret    
    bed3:	66 90                	xchg   ax,ax
    bed5:	66 90                	xchg   ax,ax
    bed7:	66 90                	xchg   ax,ax
    bed9:	66 90                	xchg   ax,ax
    bedb:	66 90                	xchg   ax,ax
    bedd:	66 90                	xchg   ax,ax
    bedf:	90                   	nop

0000bee0 <_Z4outbth>:
    bee0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bee4:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    bee8:	ee                   	out    dx,al
    bee9:	c3                   	ret    
    beea:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000bef0 <_Z4outwtt>:
    bef0:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bef4:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    bef8:	66 ef                	out    dx,ax
    befa:	c3                   	ret    
    befb:	90                   	nop
    befc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000bf00 <_Z4outdtj>:
    bf00:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bf04:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    bf08:	ef                   	out    dx,eax
    bf09:	c3                   	ret    
    bf0a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000bf10 <_Z4inwstjj>:
    bf10:	57                   	push   edi
    bf11:	8b 54 24 08          	mov    edx,DWORD PTR [esp+0x8]
    bf15:	8b 4c 24 10          	mov    ecx,DWORD PTR [esp+0x10]
    bf19:	8b 7c 24 0c          	mov    edi,DWORD PTR [esp+0xc]
    bf1d:	fc                   	cld    
    bf1e:	f3 6d                	rep ins DWORD PTR es:[edi],dx
    bf20:	5f                   	pop    edi
    bf21:	c3                   	ret    
    bf22:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    bf29:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bf30 <_Z3inbt>:
    bf30:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bf34:	ec                   	in     al,dx
    bf35:	c3                   	ret    
    bf36:	8d 76 00             	lea    esi,[esi+0x0]
    bf39:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bf40 <_Z3inwt>:
    bf40:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bf44:	66 ed                	in     ax,dx
    bf46:	c3                   	ret    
    bf47:	89 f6                	mov    esi,esi
    bf49:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bf50 <_Z3indt>:
    bf50:	8b 54 24 04          	mov    edx,DWORD PTR [esp+0x4]
    bf54:	ed                   	in     eax,dx
    bf55:	c3                   	ret    
    bf56:	8d 76 00             	lea    esi,[esi+0x0]
    bf59:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]

0000bf60 <_Z7io_waitv>:
    bf60:	31 c0                	xor    eax,eax
    bf62:	e6 80                	out    0x80,al
    bf64:	c3                   	ret    
    bf65:	66 90                	xchg   ax,ax
    bf67:	66 90                	xchg   ax,ax
    bf69:	66 90                	xchg   ax,ax
    bf6b:	66 90                	xchg   ax,ax
    bf6d:	66 90                	xchg   ax,ax
    bf6f:	90                   	nop

0000bf70 <_ZN3pci13configAddressEhhhh>:
    bf70:	0f b6 44 24 10       	movzx  eax,BYTE PTR [esp+0x10]
    bf75:	0f b6 54 24 0c       	movzx  edx,BYTE PTR [esp+0xc]
    bf7a:	c1 e0 02             	shl    eax,0x2
    bf7d:	c1 e2 08             	shl    edx,0x8
    bf80:	0f b6 c0             	movzx  eax,al
    bf83:	09 d0                	or     eax,edx
    bf85:	0f b6 54 24 08       	movzx  edx,BYTE PTR [esp+0x8]
    bf8a:	c1 e2 0b             	shl    edx,0xb
    bf8d:	09 d0                	or     eax,edx
    bf8f:	0f b6 54 24 04       	movzx  edx,BYTE PTR [esp+0x4]
    bf94:	c1 e2 10             	shl    edx,0x10
    bf97:	09 d0                	or     eax,edx
    bf99:	0d 00 00 00 80       	or     eax,0x80000000
    bf9e:	c3                   	ret    
    bf9f:	90                   	nop

0000bfa0 <_ZN3pci14configReadByteEhhhhh>:
    bfa0:	53                   	push   ebx
    bfa1:	83 ec 10             	sub    esp,0x10
    bfa4:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    bfa9:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    bfae:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    bfb2:	c1 e2 0b             	shl    edx,0xb
    bfb5:	c1 e0 10             	shl    eax,0x10
    bfb8:	09 d0                	or     eax,edx
    bfba:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    bfbf:	c1 e2 08             	shl    edx,0x8
    bfc2:	09 d0                	or     eax,edx
    bfc4:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    bfc9:	c1 e2 02             	shl    edx,0x2
    bfcc:	0f b6 d2             	movzx  edx,dl
    bfcf:	09 d0                	or     eax,edx
    bfd1:	0d 00 00 00 80       	or     eax,0x80000000
    bfd6:	50                   	push   eax
    bfd7:	68 f8 0c 00 00       	push   0xcf8
    bfdc:	e8 1f ff ff ff       	call   bf00 <_Z4outdtj>
    bfe1:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    bfe8:	e8 63 ff ff ff       	call   bf50 <_Z3indt>
    bfed:	0f b6 cb             	movzx  ecx,bl
    bff0:	83 c4 18             	add    esp,0x18
    bff3:	c1 e1 03             	shl    ecx,0x3
    bff6:	d3 e8                	shr    eax,cl
    bff8:	5b                   	pop    ebx
    bff9:	c3                   	ret    
    bffa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000c000 <_ZN3pci14configReadWordEhhhhh>:
    c000:	53                   	push   ebx
    c001:	83 ec 10             	sub    esp,0x10
    c004:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    c009:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    c00e:	8b 5c 24 28          	mov    ebx,DWORD PTR [esp+0x28]
    c012:	c1 e2 0b             	shl    edx,0xb
    c015:	c1 e0 10             	shl    eax,0x10
    c018:	09 d0                	or     eax,edx
    c01a:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    c01f:	c1 e2 08             	shl    edx,0x8
    c022:	09 d0                	or     eax,edx
    c024:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    c029:	c1 e2 02             	shl    edx,0x2
    c02c:	0f b6 d2             	movzx  edx,dl
    c02f:	09 d0                	or     eax,edx
    c031:	0d 00 00 00 80       	or     eax,0x80000000
    c036:	50                   	push   eax
    c037:	68 f8 0c 00 00       	push   0xcf8
    c03c:	e8 bf fe ff ff       	call   bf00 <_Z4outdtj>
    c041:	c7 04 24 fc 0c 00 00 	mov    DWORD PTR [esp],0xcfc
    c048:	e8 03 ff ff ff       	call   bf50 <_Z3indt>
    c04d:	0f b6 cb             	movzx  ecx,bl
    c050:	83 c4 18             	add    esp,0x18
    c053:	c1 e1 04             	shl    ecx,0x4
    c056:	d3 e8                	shr    eax,cl
    c058:	5b                   	pop    ebx
    c059:	c3                   	ret    
    c05a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]

0000c060 <_ZN3pci10configReadEhhhh>:
    c060:	83 ec 14             	sub    esp,0x14
    c063:	0f b6 44 24 18       	movzx  eax,BYTE PTR [esp+0x18]
    c068:	0f b6 54 24 1c       	movzx  edx,BYTE PTR [esp+0x1c]
    c06d:	c1 e0 10             	shl    eax,0x10
    c070:	c1 e2 0b             	shl    edx,0xb
    c073:	09 d0                	or     eax,edx
    c075:	0f b6 54 24 20       	movzx  edx,BYTE PTR [esp+0x20]
    c07a:	c1 e2 08             	shl    edx,0x8
    c07d:	09 d0                	or     eax,edx
    c07f:	0f b6 54 24 24       	movzx  edx,BYTE PTR [esp+0x24]
    c084:	c1 e2 02             	shl    edx,0x2
    c087:	0f b6 d2             	movzx  edx,dl
    c08a:	09 d0                	or     eax,edx
    c08c:	0d 00 00 00 80       	or     eax,0x80000000
    c091:	50                   	push   eax
    c092:	68 f8 0c 00 00       	push   0xcf8
    c097:	e8 64 fe ff ff       	call   bf00 <_Z4outdtj>
    c09c:	c7 44 24 20 fc 0c 00 	mov    DWORD PTR [esp+0x20],0xcfc
    c0a3:	00 
    c0a4:	83 c4 1c             	add    esp,0x1c
    c0a7:	e9 a4 fe ff ff       	jmp    bf50 <_Z3indt>
    c0ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]

0000c0b0 <_ZN3pci11checkDeviceEhhh>:
    c0b0:	83 ec 18             	sub    esp,0x18
    c0b3:	6a 00                	push   0x0
    c0b5:	6a 00                	push   0x0
    c0b7:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    c0bc:	50                   	push   eax
    c0bd:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    c0c2:	50                   	push   eax
    c0c3:	0f b6 44 24 2c       	movzx  eax,BYTE PTR [esp+0x2c]
    c0c8:	50                   	push   eax
    c0c9:	e8 32 ff ff ff       	call   c000 <_ZN3pci14configReadWordEhhhhh>
    c0ce:	66 83 f8 ff          	cmp    ax,0xffff
    c0d2:	0f 95 c0             	setne  al
    c0d5:	83 c4 2c             	add    esp,0x2c
    c0d8:	c3                   	ret    
    c0d9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]

0000c0e0 <_ZN3pci11printBussesEv>:
    c0e0:	55                   	push   ebp
    c0e1:	57                   	push   edi
    c0e2:	56                   	push   esi
    c0e3:	53                   	push   ebx
    c0e4:	83 ec 5c             	sub    esp,0x5c
    c0e7:	c7 44 24 0c 00 00 00 	mov    DWORD PTR [esp+0xc],0x0
    c0ee:	00 
    c0ef:	c7 44 24 08 00 00 00 	mov    DWORD PTR [esp+0x8],0x0
    c0f6:	00 
    c0f7:	89 f6                	mov    esi,esi
    c0f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c100:	31 f6                	xor    esi,esi
    c102:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c108:	83 ec 0c             	sub    esp,0xc
    c10b:	6a 00                	push   0x0
    c10d:	6a 00                	push   0x0
    c10f:	8b 5c 24 20          	mov    ebx,DWORD PTR [esp+0x20]
    c113:	53                   	push   ebx
    c114:	56                   	push   esi
    c115:	8b 7c 24 24          	mov    edi,DWORD PTR [esp+0x24]
    c119:	57                   	push   edi
    c11a:	e8 e1 fe ff ff       	call   c000 <_ZN3pci14configReadWordEhhhhh>
    c11f:	83 c4 20             	add    esp,0x20
    c122:	66 83 f8 ff          	cmp    ax,0xffff
    c126:	0f 84 7c 01 00 00    	je     c2a8 <_ZN3pci11printBussesEv+0x1c8>
    c12c:	83 ec 0c             	sub    esp,0xc
    c12f:	6a 00                	push   0x0
    c131:	6a 02                	push   0x2
    c133:	53                   	push   ebx
    c134:	56                   	push   esi
    c135:	57                   	push   edi
    c136:	e8 65 fe ff ff       	call   bfa0 <_ZN3pci14configReadByteEhhhhh>
    c13b:	88 44 24 38          	mov    BYTE PTR [esp+0x38],al
    c13f:	83 c4 14             	add    esp,0x14
    c142:	6a 01                	push   0x1
    c144:	6a 02                	push   0x2
    c146:	53                   	push   ebx
    c147:	56                   	push   esi
    c148:	57                   	push   edi
    c149:	e8 52 fe ff ff       	call   bfa0 <_ZN3pci14configReadByteEhhhhh>
    c14e:	88 44 24 37          	mov    BYTE PTR [esp+0x37],al
    c152:	83 c4 14             	add    esp,0x14
    c155:	6a 02                	push   0x2
    c157:	6a 02                	push   0x2
    c159:	53                   	push   ebx
    c15a:	56                   	push   esi
    c15b:	57                   	push   edi
    c15c:	e8 3f fe ff ff       	call   bfa0 <_ZN3pci14configReadByteEhhhhh>
    c161:	88 44 24 34          	mov    BYTE PTR [esp+0x34],al
    c165:	83 c4 14             	add    esp,0x14
    c168:	6a 03                	push   0x3
    c16a:	6a 02                	push   0x2
    c16c:	53                   	push   ebx
    c16d:	56                   	push   esi
    c16e:	57                   	push   edi
    c16f:	31 ff                	xor    edi,edi
    c171:	e8 2a fe ff ff       	call   bfa0 <_ZN3pci14configReadByteEhhhhh>
    c176:	c7 44 24 54 f9 09 01 	mov    DWORD PTR [esp+0x54],0x109f9
    c17d:	00 
    c17e:	88 44 24 30          	mov    BYTE PTR [esp+0x30],al
    c182:	ba 5b 00 00 00       	mov    edx,0x5b
    c187:	83 c4 20             	add    esp,0x20
    c18a:	eb 27                	jmp    c1b3 <_ZN3pci11printBussesEv+0xd3>
    c18c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c190:	3c 25                	cmp    al,0x25
    c192:	0f 84 d8 03 00 00    	je     c570 <_ZN3pci11printBussesEv+0x490>
    c198:	84 c0                	test   al,al
    c19a:	0f 85 f8 01 00 00    	jne    c398 <_ZN3pci11printBussesEv+0x2b8>
    c1a0:	8d 5f 02             	lea    ebx,[edi+0x2]
    c1a3:	0f b6 83 5c 08 01 00 	movzx  eax,BYTE PTR [ebx+0x1085c]
    c1aa:	84 c0                	test   al,al
    c1ac:	74 3a                	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    c1ae:	0f be d0             	movsx  edx,al
    c1b1:	89 df                	mov    edi,ebx
    c1b3:	8d 5f 01             	lea    ebx,[edi+0x1]
    c1b6:	80 fa 25             	cmp    dl,0x25
    c1b9:	0f b6 83 5c 08 01 00 	movzx  eax,BYTE PTR [ebx+0x1085c]
    c1c0:	8d 8b 5c 08 01 00    	lea    ecx,[ebx+0x1085c]
    c1c6:	74 c8                	je     c190 <_ZN3pci11printBussesEv+0xb0>
    c1c8:	88 44 24 04          	mov    BYTE PTR [esp+0x4],al
    c1cc:	83 ec 0c             	sub    esp,0xc
    c1cf:	52                   	push   edx
    c1d0:	e8 fb fa ff ff       	call   bcd0 <_Z7putcharc>
    c1d5:	83 c4 10             	add    esp,0x10
    c1d8:	0f b6 44 24 04       	movzx  eax,BYTE PTR [esp+0x4]
    c1dd:	84 c0                	test   al,al
    c1df:	75 cd                	jne    c1ae <_ZN3pci11printBussesEv+0xce>
    c1e1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c1e8:	6a 04                	push   0x4
    c1ea:	8b 5c 24 10          	mov    ebx,DWORD PTR [esp+0x10]
    c1ee:	53                   	push   ebx
    c1ef:	56                   	push   esi
    c1f0:	8b 7c 24 14          	mov    edi,DWORD PTR [esp+0x14]
    c1f4:	57                   	push   edi
    c1f5:	e8 66 fe ff ff       	call   c060 <_ZN3pci10configReadEhhhh>
    c1fa:	c7 04 24 03 00 00 00 	mov    DWORD PTR [esp],0x3
    c201:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    c205:	6a 03                	push   0x3
    c207:	53                   	push   ebx
    c208:	56                   	push   esi
    c209:	57                   	push   edi
    c20a:	e8 91 fd ff ff       	call   bfa0 <_ZN3pci14configReadByteEhhhhh>
    c20f:	88 44 24 37          	mov    BYTE PTR [esp+0x37],al
    c213:	83 c4 14             	add    esp,0x14
    c216:	6a 01                	push   0x1
    c218:	6a 00                	push   0x0
    c21a:	53                   	push   ebx
    c21b:	56                   	push   esi
    c21c:	57                   	push   edi
    c21d:	e8 de fd ff ff       	call   c000 <_ZN3pci14configReadWordEhhhhh>
    c222:	66 89 44 24 34       	mov    WORD PTR [esp+0x34],ax
    c227:	83 c4 14             	add    esp,0x14
    c22a:	6a 00                	push   0x0
    c22c:	6a 00                	push   0x0
    c22e:	53                   	push   ebx
    c22f:	56                   	push   esi
    c230:	57                   	push   edi
    c231:	31 ff                	xor    edi,edi
    c233:	e8 c8 fd ff ff       	call   c000 <_ZN3pci14configReadWordEhhhhh>
    c238:	c7 44 24 50 f9 09 01 	mov    DWORD PTR [esp+0x50],0x109f9
    c23f:	00 
    c240:	66 89 44 24 30       	mov    WORD PTR [esp+0x30],ax
    c245:	ba 5b 00 00 00       	mov    edx,0x5b
    c24a:	83 c4 20             	add    esp,0x20
    c24d:	eb 24                	jmp    c273 <_ZN3pci11printBussesEv+0x193>
    c24f:	90                   	nop
    c250:	3c 25                	cmp    al,0x25
    c252:	0f 84 e8 02 00 00    	je     c540 <_ZN3pci11printBussesEv+0x460>
    c258:	84 c0                	test   al,al
    c25a:	0f 85 a0 00 00 00    	jne    c300 <_ZN3pci11printBussesEv+0x220>
    c260:	8d 5f 02             	lea    ebx,[edi+0x2]
    c263:	0f b6 83 b4 08 01 00 	movzx  eax,BYTE PTR [ebx+0x108b4]
    c26a:	84 c0                	test   al,al
    c26c:	74 3a                	je     c2a8 <_ZN3pci11printBussesEv+0x1c8>
    c26e:	0f be d0             	movsx  edx,al
    c271:	89 df                	mov    edi,ebx
    c273:	8d 5f 01             	lea    ebx,[edi+0x1]
    c276:	80 fa 25             	cmp    dl,0x25
    c279:	0f b6 83 b4 08 01 00 	movzx  eax,BYTE PTR [ebx+0x108b4]
    c280:	8d 8b b4 08 01 00    	lea    ecx,[ebx+0x108b4]
    c286:	74 c8                	je     c250 <_ZN3pci11printBussesEv+0x170>
    c288:	88 44 24 04          	mov    BYTE PTR [esp+0x4],al
    c28c:	83 ec 0c             	sub    esp,0xc
    c28f:	52                   	push   edx
    c290:	e8 3b fa ff ff       	call   bcd0 <_Z7putcharc>
    c295:	83 c4 10             	add    esp,0x10
    c298:	0f b6 44 24 04       	movzx  eax,BYTE PTR [esp+0x4]
    c29d:	84 c0                	test   al,al
    c29f:	75 cd                	jne    c26e <_ZN3pci11printBussesEv+0x18e>
    c2a1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c2a8:	83 c6 01             	add    esi,0x1
    c2ab:	83 fe 20             	cmp    esi,0x20
    c2ae:	0f 85 54 fe ff ff    	jne    c108 <_ZN3pci11printBussesEv+0x28>
    c2b4:	83 44 24 08 01       	add    DWORD PTR [esp+0x8],0x1
    c2b9:	8b 44 24 08          	mov    eax,DWORD PTR [esp+0x8]
    c2bd:	3d 00 01 00 00       	cmp    eax,0x100
    c2c2:	0f 85 38 fe ff ff    	jne    c100 <_ZN3pci11printBussesEv+0x20>
    c2c8:	83 44 24 0c 01       	add    DWORD PTR [esp+0xc],0x1
    c2cd:	8b 44 24 0c          	mov    eax,DWORD PTR [esp+0xc]
    c2d1:	83 f8 08             	cmp    eax,0x8
    c2d4:	0f 85 15 fe ff ff    	jne    c0ef <_ZN3pci11printBussesEv+0xf>
    c2da:	68 58 01 01 00       	push   0x10158
    c2df:	6a 3a                	push   0x3a
    c2e1:	68 f9 09 01 00       	push   0x109f9
    c2e6:	68 00 09 01 00       	push   0x10900
    c2eb:	e8 e0 0d 00 00       	call   d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>
    c2f0:	83 c4 6c             	add    esp,0x6c
    c2f3:	5b                   	pop    ebx
    c2f4:	5e                   	pop    esi
    c2f5:	5f                   	pop    edi
    c2f6:	5d                   	pop    ebp
    c2f7:	c3                   	ret    
    c2f8:	90                   	nop
    c2f9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c300:	83 ec 08             	sub    esp,0x8
    c303:	8d 44 24 38          	lea    eax,[esp+0x38]
    c307:	50                   	push   eax
    c308:	51                   	push   ecx
    c309:	e8 c2 0b 00 00       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    c30e:	01 c3                	add    ebx,eax
    c310:	c7 44 24 58 35 00 00 	mov    DWORD PTR [esp+0x58],0x35
    c317:	00 
    c318:	83 c4 10             	add    esp,0x10
    c31b:	0f be 83 b4 08 01 00 	movsx  eax,BYTE PTR [ebx+0x108b4]
    c322:	8d 93 b4 08 01 00    	lea    edx,[ebx+0x108b4]
    c328:	84 c0                	test   al,al
    c32a:	0f 84 78 ff ff ff    	je     c2a8 <_ZN3pci11printBussesEv+0x1c8>
    c330:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    c334:	31 ed                	xor    ebp,ebp
    c336:	89 d6                	mov    esi,edx
    c338:	eb 28                	jmp    c362 <_ZN3pci11printBussesEv+0x282>
    c33a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c340:	80 fb 25             	cmp    bl,0x25
    c343:	0f 84 87 03 00 00    	je     c6d0 <_ZN3pci11printBussesEv+0x5f0>
    c349:	84 db                	test   bl,bl
    c34b:	0f 85 cf 00 00 00    	jne    c420 <_ZN3pci11printBussesEv+0x340>
    c351:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c356:	8d 7d 02             	lea    edi,[ebp+0x2]
    c359:	84 db                	test   bl,bl
    c35b:	74 22                	je     c37f <_ZN3pci11printBussesEv+0x29f>
    c35d:	0f be c3             	movsx  eax,bl
    c360:	89 fd                	mov    ebp,edi
    c362:	8d 7d 01             	lea    edi,[ebp+0x1]
    c365:	3c 25                	cmp    al,0x25
    c367:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c36a:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c36d:	74 d1                	je     c340 <_ZN3pci11printBussesEv+0x260>
    c36f:	83 ec 0c             	sub    esp,0xc
    c372:	50                   	push   eax
    c373:	e8 58 f9 ff ff       	call   bcd0 <_Z7putcharc>
    c378:	83 c4 10             	add    esp,0x10
    c37b:	84 db                	test   bl,bl
    c37d:	75 de                	jne    c35d <_ZN3pci11printBussesEv+0x27d>
    c37f:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c383:	83 c6 01             	add    esi,0x1
    c386:	83 fe 20             	cmp    esi,0x20
    c389:	0f 85 79 fd ff ff    	jne    c108 <_ZN3pci11printBussesEv+0x28>
    c38f:	e9 20 ff ff ff       	jmp    c2b4 <_ZN3pci11printBussesEv+0x1d4>
    c394:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c398:	83 ec 08             	sub    esp,0x8
    c39b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    c39f:	50                   	push   eax
    c3a0:	51                   	push   ecx
    c3a1:	e8 2a 0b 00 00       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    c3a6:	01 c3                	add    ebx,eax
    c3a8:	c7 44 24 48 2f 00 00 	mov    DWORD PTR [esp+0x48],0x2f
    c3af:	00 
    c3b0:	83 c4 10             	add    esp,0x10
    c3b3:	0f be 83 5c 08 01 00 	movsx  eax,BYTE PTR [ebx+0x1085c]
    c3ba:	8d 93 5c 08 01 00    	lea    edx,[ebx+0x1085c]
    c3c0:	84 c0                	test   al,al
    c3c2:	0f 84 20 fe ff ff    	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    c3c8:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    c3cc:	31 ed                	xor    ebp,ebp
    c3ce:	89 d6                	mov    esi,edx
    c3d0:	eb 28                	jmp    c3fa <_ZN3pci11printBussesEv+0x31a>
    c3d2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c3d8:	80 fb 25             	cmp    bl,0x25
    c3db:	0f 84 1f 03 00 00    	je     c700 <_ZN3pci11printBussesEv+0x620>
    c3e1:	84 db                	test   bl,bl
    c3e3:	0f 85 c7 00 00 00    	jne    c4b0 <_ZN3pci11printBussesEv+0x3d0>
    c3e9:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c3ee:	8d 7d 02             	lea    edi,[ebp+0x2]
    c3f1:	84 db                	test   bl,bl
    c3f3:	74 22                	je     c417 <_ZN3pci11printBussesEv+0x337>
    c3f5:	0f be c3             	movsx  eax,bl
    c3f8:	89 fd                	mov    ebp,edi
    c3fa:	8d 7d 01             	lea    edi,[ebp+0x1]
    c3fd:	3c 25                	cmp    al,0x25
    c3ff:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c402:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c405:	74 d1                	je     c3d8 <_ZN3pci11printBussesEv+0x2f8>
    c407:	83 ec 0c             	sub    esp,0xc
    c40a:	50                   	push   eax
    c40b:	e8 c0 f8 ff ff       	call   bcd0 <_Z7putcharc>
    c410:	83 c4 10             	add    esp,0x10
    c413:	84 db                	test   bl,bl
    c415:	75 de                	jne    c3f5 <_ZN3pci11printBussesEv+0x315>
    c417:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c41b:	e9 c8 fd ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    c420:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    c424:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c428:	83 ec 08             	sub    esp,0x8
    c42b:	8d 44 24 50          	lea    eax,[esp+0x50]
    c42f:	50                   	push   eax
    c430:	51                   	push   ecx
    c431:	e8 9a 0b 00 00       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    c436:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    c43a:	01 c7                	add    edi,eax
    c43c:	c7 44 24 5c 58 01 01 	mov    DWORD PTR [esp+0x5c],0x10158
    c443:	00 
    c444:	83 c4 10             	add    esp,0x10
    c447:	01 fa                	add    edx,edi
    c449:	0f be 02             	movsx  eax,BYTE PTR [edx]
    c44c:	84 c0                	test   al,al
    c44e:	0f 84 54 fe ff ff    	je     c2a8 <_ZN3pci11printBussesEv+0x1c8>
    c454:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    c458:	31 ff                	xor    edi,edi
    c45a:	89 d6                	mov    esi,edx
    c45c:	eb 28                	jmp    c486 <_ZN3pci11printBussesEv+0x3a6>
    c45e:	66 90                	xchg   ax,ax
    c460:	80 fb 25             	cmp    bl,0x25
    c463:	0f 84 17 04 00 00    	je     c880 <_ZN3pci11printBussesEv+0x7a0>
    c469:	84 db                	test   bl,bl
    c46b:	0f 85 bf 01 00 00    	jne    c630 <_ZN3pci11printBussesEv+0x550>
    c471:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    c476:	8d 6f 02             	lea    ebp,[edi+0x2]
    c479:	84 db                	test   bl,bl
    c47b:	0f 84 fe fe ff ff    	je     c37f <_ZN3pci11printBussesEv+0x29f>
    c481:	0f be c3             	movsx  eax,bl
    c484:	89 ef                	mov    edi,ebp
    c486:	8d 6f 01             	lea    ebp,[edi+0x1]
    c489:	3c 25                	cmp    al,0x25
    c48b:	8d 0c 2e             	lea    ecx,[esi+ebp*1]
    c48e:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c491:	74 cd                	je     c460 <_ZN3pci11printBussesEv+0x380>
    c493:	83 ec 0c             	sub    esp,0xc
    c496:	50                   	push   eax
    c497:	e8 34 f8 ff ff       	call   bcd0 <_Z7putcharc>
    c49c:	83 c4 10             	add    esp,0x10
    c49f:	84 db                	test   bl,bl
    c4a1:	75 de                	jne    c481 <_ZN3pci11printBussesEv+0x3a1>
    c4a3:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c4a7:	e9 d7 fe ff ff       	jmp    c383 <_ZN3pci11printBussesEv+0x2a3>
    c4ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c4b0:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    c4b4:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c4b8:	83 ec 08             	sub    esp,0x8
    c4bb:	8d 44 24 40          	lea    eax,[esp+0x40]
    c4bf:	50                   	push   eax
    c4c0:	51                   	push   ecx
    c4c1:	e8 0a 0b 00 00       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    c4c6:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    c4ca:	01 c7                	add    edi,eax
    c4cc:	c7 44 24 4c 58 01 01 	mov    DWORD PTR [esp+0x4c],0x10158
    c4d3:	00 
    c4d4:	83 c4 10             	add    esp,0x10
    c4d7:	01 fa                	add    edx,edi
    c4d9:	0f be 02             	movsx  eax,BYTE PTR [edx]
    c4dc:	84 c0                	test   al,al
    c4de:	0f 84 04 fd ff ff    	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    c4e4:	89 74 24 1c          	mov    DWORD PTR [esp+0x1c],esi
    c4e8:	31 ff                	xor    edi,edi
    c4ea:	89 d6                	mov    esi,edx
    c4ec:	eb 28                	jmp    c516 <_ZN3pci11printBussesEv+0x436>
    c4ee:	66 90                	xchg   ax,ax
    c4f0:	80 fb 25             	cmp    bl,0x25
    c4f3:	0f 84 57 03 00 00    	je     c850 <_ZN3pci11printBussesEv+0x770>
    c4f9:	84 db                	test   bl,bl
    c4fb:	0f 85 97 00 00 00    	jne    c598 <_ZN3pci11printBussesEv+0x4b8>
    c501:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    c506:	8d 6f 02             	lea    ebp,[edi+0x2]
    c509:	84 db                	test   bl,bl
    c50b:	0f 84 06 ff ff ff    	je     c417 <_ZN3pci11printBussesEv+0x337>
    c511:	0f be c3             	movsx  eax,bl
    c514:	89 ef                	mov    edi,ebp
    c516:	8d 6f 01             	lea    ebp,[edi+0x1]
    c519:	3c 25                	cmp    al,0x25
    c51b:	8d 0c 2e             	lea    ecx,[esi+ebp*1]
    c51e:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c521:	74 cd                	je     c4f0 <_ZN3pci11printBussesEv+0x410>
    c523:	83 ec 0c             	sub    esp,0xc
    c526:	50                   	push   eax
    c527:	e8 a4 f7 ff ff       	call   bcd0 <_Z7putcharc>
    c52c:	83 c4 10             	add    esp,0x10
    c52f:	84 db                	test   bl,bl
    c531:	75 de                	jne    c511 <_ZN3pci11printBussesEv+0x431>
    c533:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c537:	e9 ac fc ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    c53c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c540:	83 ec 0c             	sub    esp,0xc
    c543:	8d 5f 02             	lea    ebx,[edi+0x2]
    c546:	6a 25                	push   0x25
    c548:	e8 83 f7 ff ff       	call   bcd0 <_Z7putcharc>
    c54d:	0f b6 83 b4 08 01 00 	movzx  eax,BYTE PTR [ebx+0x108b4]
    c554:	83 c4 10             	add    esp,0x10
    c557:	84 c0                	test   al,al
    c559:	0f 85 0f fd ff ff    	jne    c26e <_ZN3pci11printBussesEv+0x18e>
    c55f:	83 c6 01             	add    esi,0x1
    c562:	83 fe 20             	cmp    esi,0x20
    c565:	0f 85 9d fb ff ff    	jne    c108 <_ZN3pci11printBussesEv+0x28>
    c56b:	e9 44 fd ff ff       	jmp    c2b4 <_ZN3pci11printBussesEv+0x1d4>
    c570:	83 ec 0c             	sub    esp,0xc
    c573:	8d 5f 02             	lea    ebx,[edi+0x2]
    c576:	6a 25                	push   0x25
    c578:	e8 53 f7 ff ff       	call   bcd0 <_Z7putcharc>
    c57d:	0f b6 83 5c 08 01 00 	movzx  eax,BYTE PTR [ebx+0x1085c]
    c584:	83 c4 10             	add    esp,0x10
    c587:	84 c0                	test   al,al
    c589:	0f 85 1f fc ff ff    	jne    c1ae <_ZN3pci11printBussesEv+0xce>
    c58f:	e9 54 fc ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    c594:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c598:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    c59c:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c5a0:	83 ec 08             	sub    esp,0x8
    c5a3:	8d 44 24 44          	lea    eax,[esp+0x44]
    c5a7:	50                   	push   eax
    c5a8:	51                   	push   ecx
    c5a9:	e8 22 09 00 00       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    c5ae:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    c5b2:	01 c5                	add    ebp,eax
    c5b4:	0f b6 44 24 20       	movzx  eax,BYTE PTR [esp+0x20]
    c5b9:	01 d5                	add    ebp,edx
    c5bb:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    c5bf:	88 44 24 37          	mov    BYTE PTR [esp+0x37],al
    c5c3:	83 c4 10             	add    esp,0x10
    c5c6:	84 d2                	test   dl,dl
    c5c8:	0f 84 1a fc ff ff    	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    c5ce:	31 ff                	xor    edi,edi
    c5d0:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    c5d4:	89 ee                	mov    esi,ebp
    c5d6:	89 fd                	mov    ebp,edi
    c5d8:	eb 28                	jmp    c602 <_ZN3pci11printBussesEv+0x522>
    c5da:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c5e0:	80 fb 25             	cmp    bl,0x25
    c5e3:	0f 84 17 04 00 00    	je     ca00 <_ZN3pci11printBussesEv+0x920>
    c5e9:	84 db                	test   bl,bl
    c5eb:	0f 85 3f 01 00 00    	jne    c730 <_ZN3pci11printBussesEv+0x650>
    c5f1:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c5f6:	8d 7d 02             	lea    edi,[ebp+0x2]
    c5f9:	84 db                	test   bl,bl
    c5fb:	74 23                	je     c620 <_ZN3pci11printBussesEv+0x540>
    c5fd:	0f be d3             	movsx  edx,bl
    c600:	89 fd                	mov    ebp,edi
    c602:	8d 7d 01             	lea    edi,[ebp+0x1]
    c605:	80 fa 25             	cmp    dl,0x25
    c608:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c60b:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c60e:	74 d0                	je     c5e0 <_ZN3pci11printBussesEv+0x500>
    c610:	83 ec 0c             	sub    esp,0xc
    c613:	52                   	push   edx
    c614:	e8 b7 f6 ff ff       	call   bcd0 <_Z7putcharc>
    c619:	83 c4 10             	add    esp,0x10
    c61c:	84 db                	test   bl,bl
    c61e:	75 dd                	jne    c5fd <_ZN3pci11printBussesEv+0x51d>
    c620:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    c624:	e9 bf fb ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    c629:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c630:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    c634:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c638:	83 ec 08             	sub    esp,0x8
    c63b:	8d 44 24 54          	lea    eax,[esp+0x54]
    c63f:	50                   	push   eax
    c640:	51                   	push   ecx
    c641:	e8 8a 08 00 00       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    c646:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    c64a:	01 c5                	add    ebp,eax
    c64c:	0f b7 44 24 20       	movzx  eax,WORD PTR [esp+0x20]
    c651:	01 d5                	add    ebp,edx
    c653:	0f be 55 00          	movsx  edx,BYTE PTR [ebp+0x0]
    c657:	66 89 44 24 3c       	mov    WORD PTR [esp+0x3c],ax
    c65c:	83 c4 10             	add    esp,0x10
    c65f:	84 d2                	test   dl,dl
    c661:	0f 84 41 fc ff ff    	je     c2a8 <_ZN3pci11printBussesEv+0x1c8>
    c667:	31 ff                	xor    edi,edi
    c669:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    c66d:	89 ee                	mov    esi,ebp
    c66f:	89 fd                	mov    ebp,edi
    c671:	eb 27                	jmp    c69a <_ZN3pci11printBussesEv+0x5ba>
    c673:	90                   	nop
    c674:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c678:	80 fb 25             	cmp    bl,0x25
    c67b:	0f 84 4f 03 00 00    	je     c9d0 <_ZN3pci11printBussesEv+0x8f0>
    c681:	84 db                	test   bl,bl
    c683:	0f 85 37 01 00 00    	jne    c7c0 <_ZN3pci11printBussesEv+0x6e0>
    c689:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c68e:	8d 7d 02             	lea    edi,[ebp+0x2]
    c691:	84 db                	test   bl,bl
    c693:	74 23                	je     c6b8 <_ZN3pci11printBussesEv+0x5d8>
    c695:	0f be d3             	movsx  edx,bl
    c698:	89 fd                	mov    ebp,edi
    c69a:	8d 7d 01             	lea    edi,[ebp+0x1]
    c69d:	80 fa 25             	cmp    dl,0x25
    c6a0:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c6a3:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c6a6:	74 d0                	je     c678 <_ZN3pci11printBussesEv+0x598>
    c6a8:	83 ec 0c             	sub    esp,0xc
    c6ab:	52                   	push   edx
    c6ac:	e8 1f f6 ff ff       	call   bcd0 <_Z7putcharc>
    c6b1:	83 c4 10             	add    esp,0x10
    c6b4:	84 db                	test   bl,bl
    c6b6:	75 dd                	jne    c695 <_ZN3pci11printBussesEv+0x5b5>
    c6b8:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    c6bc:	83 c6 01             	add    esi,0x1
    c6bf:	83 fe 20             	cmp    esi,0x20
    c6c2:	0f 85 40 fa ff ff    	jne    c108 <_ZN3pci11printBussesEv+0x28>
    c6c8:	e9 e7 fb ff ff       	jmp    c2b4 <_ZN3pci11printBussesEv+0x1d4>
    c6cd:	8d 76 00             	lea    esi,[esi+0x0]
    c6d0:	83 ec 0c             	sub    esp,0xc
    c6d3:	8d 7d 02             	lea    edi,[ebp+0x2]
    c6d6:	6a 25                	push   0x25
    c6d8:	e8 f3 f5 ff ff       	call   bcd0 <_Z7putcharc>
    c6dd:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c6e2:	83 c4 10             	add    esp,0x10
    c6e5:	84 db                	test   bl,bl
    c6e7:	0f 85 70 fc ff ff    	jne    c35d <_ZN3pci11printBussesEv+0x27d>
    c6ed:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c6f1:	e9 8d fc ff ff       	jmp    c383 <_ZN3pci11printBussesEv+0x2a3>
    c6f6:	8d 76 00             	lea    esi,[esi+0x0]
    c6f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c700:	83 ec 0c             	sub    esp,0xc
    c703:	8d 7d 02             	lea    edi,[ebp+0x2]
    c706:	6a 25                	push   0x25
    c708:	e8 c3 f5 ff ff       	call   bcd0 <_Z7putcharc>
    c70d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c712:	83 c4 10             	add    esp,0x10
    c715:	84 db                	test   bl,bl
    c717:	0f 85 d8 fc ff ff    	jne    c3f5 <_ZN3pci11printBussesEv+0x315>
    c71d:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c721:	e9 c2 fa ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    c726:	8d 76 00             	lea    esi,[esi+0x0]
    c729:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c730:	83 ec 08             	sub    esp,0x8
    c733:	89 f5                	mov    ebp,esi
    c735:	8b 74 24 0c          	mov    esi,DWORD PTR [esp+0xc]
    c739:	8d 44 24 2f          	lea    eax,[esp+0x2f]
    c73d:	89 fb                	mov    ebx,edi
    c73f:	50                   	push   eax
    c740:	51                   	push   ecx
    c741:	e8 ea 2e 00 00       	call   f630 <_Z14_manage_escapeIhEiPKcPT_>
    c746:	01 c3                	add    ebx,eax
    c748:	0f b6 44 24 24       	movzx  eax,BYTE PTR [esp+0x24]
    c74d:	01 eb                	add    ebx,ebp
    c74f:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    c752:	88 44 24 38          	mov    BYTE PTR [esp+0x38],al
    c756:	83 c4 10             	add    esp,0x10
    c759:	84 d2                	test   dl,dl
    c75b:	0f 84 87 fa ff ff    	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    c761:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    c765:	31 ed                	xor    ebp,ebp
    c767:	89 de                	mov    esi,ebx
    c769:	eb 2b                	jmp    c796 <_ZN3pci11printBussesEv+0x6b6>
    c76b:	90                   	nop
    c76c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c770:	80 fb 25             	cmp    bl,0x25
    c773:	0f 84 f7 03 00 00    	je     cb70 <_ZN3pci11printBussesEv+0xa90>
    c779:	84 db                	test   bl,bl
    c77b:	0f 85 bf 01 00 00    	jne    c940 <_ZN3pci11printBussesEv+0x860>
    c781:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c786:	8d 7d 02             	lea    edi,[ebp+0x2]
    c789:	84 db                	test   bl,bl
    c78b:	0f 84 8f fe ff ff    	je     c620 <_ZN3pci11printBussesEv+0x540>
    c791:	0f be d3             	movsx  edx,bl
    c794:	89 fd                	mov    ebp,edi
    c796:	8d 7d 01             	lea    edi,[ebp+0x1]
    c799:	80 fa 25             	cmp    dl,0x25
    c79c:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c79f:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c7a2:	74 cc                	je     c770 <_ZN3pci11printBussesEv+0x690>
    c7a4:	83 ec 0c             	sub    esp,0xc
    c7a7:	52                   	push   edx
    c7a8:	e8 23 f5 ff ff       	call   bcd0 <_Z7putcharc>
    c7ad:	83 c4 10             	add    esp,0x10
    c7b0:	84 db                	test   bl,bl
    c7b2:	75 dd                	jne    c791 <_ZN3pci11printBussesEv+0x6b1>
    c7b4:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    c7b8:	e9 2b fa ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    c7bd:	8d 76 00             	lea    esi,[esi+0x0]
    c7c0:	83 ec 08             	sub    esp,0x8
    c7c3:	89 f5                	mov    ebp,esi
    c7c5:	8b 74 24 0c          	mov    esi,DWORD PTR [esp+0xc]
    c7c9:	8d 44 24 34          	lea    eax,[esp+0x34]
    c7cd:	89 fb                	mov    ebx,edi
    c7cf:	50                   	push   eax
    c7d0:	51                   	push   ecx
    c7d1:	e8 da 1e 00 00       	call   e6b0 <_Z14_manage_escapeItEiPKcPT_>
    c7d6:	01 c3                	add    ebx,eax
    c7d8:	0f b7 44 24 24       	movzx  eax,WORD PTR [esp+0x24]
    c7dd:	01 eb                	add    ebx,ebp
    c7df:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    c7e2:	66 89 44 24 3e       	mov    WORD PTR [esp+0x3e],ax
    c7e7:	83 c4 10             	add    esp,0x10
    c7ea:	84 d2                	test   dl,dl
    c7ec:	0f 84 b6 fa ff ff    	je     c2a8 <_ZN3pci11printBussesEv+0x1c8>
    c7f2:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    c7f6:	31 ed                	xor    ebp,ebp
    c7f8:	89 de                	mov    esi,ebx
    c7fa:	eb 2a                	jmp    c826 <_ZN3pci11printBussesEv+0x746>
    c7fc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    c800:	80 fb 25             	cmp    bl,0x25
    c803:	0f 84 37 03 00 00    	je     cb40 <_ZN3pci11printBussesEv+0xa60>
    c809:	84 db                	test   bl,bl
    c80b:	0f 85 9f 00 00 00    	jne    c8b0 <_ZN3pci11printBussesEv+0x7d0>
    c811:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c816:	8d 7d 02             	lea    edi,[ebp+0x2]
    c819:	84 db                	test   bl,bl
    c81b:	0f 84 97 fe ff ff    	je     c6b8 <_ZN3pci11printBussesEv+0x5d8>
    c821:	0f be d3             	movsx  edx,bl
    c824:	89 fd                	mov    ebp,edi
    c826:	8d 7d 01             	lea    edi,[ebp+0x1]
    c829:	80 fa 25             	cmp    dl,0x25
    c82c:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c82f:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c832:	74 cc                	je     c800 <_ZN3pci11printBussesEv+0x720>
    c834:	83 ec 0c             	sub    esp,0xc
    c837:	52                   	push   edx
    c838:	e8 93 f4 ff ff       	call   bcd0 <_Z7putcharc>
    c83d:	83 c4 10             	add    esp,0x10
    c840:	84 db                	test   bl,bl
    c842:	75 dd                	jne    c821 <_ZN3pci11printBussesEv+0x741>
    c844:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    c848:	e9 6f fe ff ff       	jmp    c6bc <_ZN3pci11printBussesEv+0x5dc>
    c84d:	8d 76 00             	lea    esi,[esi+0x0]
    c850:	83 ec 0c             	sub    esp,0xc
    c853:	8d 6f 02             	lea    ebp,[edi+0x2]
    c856:	6a 25                	push   0x25
    c858:	e8 73 f4 ff ff       	call   bcd0 <_Z7putcharc>
    c85d:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    c862:	83 c4 10             	add    esp,0x10
    c865:	84 db                	test   bl,bl
    c867:	0f 85 a4 fc ff ff    	jne    c511 <_ZN3pci11printBussesEv+0x431>
    c86d:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c871:	e9 72 f9 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    c876:	8d 76 00             	lea    esi,[esi+0x0]
    c879:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c880:	83 ec 0c             	sub    esp,0xc
    c883:	8d 6f 02             	lea    ebp,[edi+0x2]
    c886:	6a 25                	push   0x25
    c888:	e8 43 f4 ff ff       	call   bcd0 <_Z7putcharc>
    c88d:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    c892:	83 c4 10             	add    esp,0x10
    c895:	84 db                	test   bl,bl
    c897:	0f 85 e4 fb ff ff    	jne    c481 <_ZN3pci11printBussesEv+0x3a1>
    c89d:	8b 74 24 1c          	mov    esi,DWORD PTR [esp+0x1c]
    c8a1:	e9 dd fa ff ff       	jmp    c383 <_ZN3pci11printBussesEv+0x2a3>
    c8a6:	8d 76 00             	lea    esi,[esi+0x0]
    c8a9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    c8b0:	83 ec 08             	sub    esp,0x8
    c8b3:	89 f3                	mov    ebx,esi
    c8b5:	8b 74 24 0c          	mov    esi,DWORD PTR [esp+0xc]
    c8b9:	8d 44 24 36          	lea    eax,[esp+0x36]
    c8bd:	50                   	push   eax
    c8be:	51                   	push   ecx
    c8bf:	e8 ec 1d 00 00       	call   e6b0 <_Z14_manage_escapeItEiPKcPT_>
    c8c4:	01 c7                	add    edi,eax
    c8c6:	0f b6 44 24 27       	movzx  eax,BYTE PTR [esp+0x27]
    c8cb:	01 fb                	add    ebx,edi
    c8cd:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    c8d0:	88 44 24 3b          	mov    BYTE PTR [esp+0x3b],al
    c8d4:	83 c4 10             	add    esp,0x10
    c8d7:	84 d2                	test   dl,dl
    c8d9:	0f 84 c9 f9 ff ff    	je     c2a8 <_ZN3pci11printBussesEv+0x1c8>
    c8df:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    c8e3:	31 ed                	xor    ebp,ebp
    c8e5:	89 de                	mov    esi,ebx
    c8e7:	eb 2d                	jmp    c916 <_ZN3pci11printBussesEv+0x836>
    c8e9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c8f0:	80 fb 25             	cmp    bl,0x25
    c8f3:	0f 84 17 04 00 00    	je     cd10 <_ZN3pci11printBussesEv+0xc30>
    c8f9:	84 db                	test   bl,bl
    c8fb:	0f 85 2f 01 00 00    	jne    ca30 <_ZN3pci11printBussesEv+0x950>
    c901:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c906:	8d 7d 02             	lea    edi,[ebp+0x2]
    c909:	84 db                	test   bl,bl
    c90b:	0f 84 a7 fd ff ff    	je     c6b8 <_ZN3pci11printBussesEv+0x5d8>
    c911:	0f be d3             	movsx  edx,bl
    c914:	89 fd                	mov    ebp,edi
    c916:	8d 7d 01             	lea    edi,[ebp+0x1]
    c919:	80 fa 25             	cmp    dl,0x25
    c91c:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c91f:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c922:	74 cc                	je     c8f0 <_ZN3pci11printBussesEv+0x810>
    c924:	83 ec 0c             	sub    esp,0xc
    c927:	52                   	push   edx
    c928:	e8 a3 f3 ff ff       	call   bcd0 <_Z7putcharc>
    c92d:	83 c4 10             	add    esp,0x10
    c930:	84 db                	test   bl,bl
    c932:	75 dd                	jne    c911 <_ZN3pci11printBussesEv+0x831>
    c934:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    c938:	e9 7f fd ff ff       	jmp    c6bc <_ZN3pci11printBussesEv+0x5dc>
    c93d:	8d 76 00             	lea    esi,[esi+0x0]
    c940:	83 ec 08             	sub    esp,0x8
    c943:	89 f3                	mov    ebx,esi
    c945:	8b 74 24 0c          	mov    esi,DWORD PTR [esp+0xc]
    c949:	8d 44 24 30          	lea    eax,[esp+0x30]
    c94d:	50                   	push   eax
    c94e:	51                   	push   ecx
    c94f:	e8 dc 2c 00 00       	call   f630 <_Z14_manage_escapeIhEiPKcPT_>
    c954:	01 c7                	add    edi,eax
    c956:	0f b6 44 24 27       	movzx  eax,BYTE PTR [esp+0x27]
    c95b:	8d 14 3b             	lea    edx,[ebx+edi*1]
    c95e:	88 44 24 39          	mov    BYTE PTR [esp+0x39],al
    c962:	0f be 02             	movsx  eax,BYTE PTR [edx]
    c965:	83 c4 10             	add    esp,0x10
    c968:	84 c0                	test   al,al
    c96a:	0f 84 78 f8 ff ff    	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    c970:	89 74 24 10          	mov    DWORD PTR [esp+0x10],esi
    c974:	31 ed                	xor    ebp,ebp
    c976:	89 d6                	mov    esi,edx
    c978:	eb 28                	jmp    c9a2 <_ZN3pci11printBussesEv+0x8c2>
    c97a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    c980:	80 fb 25             	cmp    bl,0x25
    c983:	0f 84 b7 03 00 00    	je     cd40 <_ZN3pci11printBussesEv+0xc60>
    c989:	84 db                	test   bl,bl
    c98b:	0f 85 1f 01 00 00    	jne    cab0 <_ZN3pci11printBussesEv+0x9d0>
    c991:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c996:	8d 7d 02             	lea    edi,[ebp+0x2]
    c999:	84 db                	test   bl,bl
    c99b:	74 22                	je     c9bf <_ZN3pci11printBussesEv+0x8df>
    c99d:	0f be c3             	movsx  eax,bl
    c9a0:	89 fd                	mov    ebp,edi
    c9a2:	8d 7d 01             	lea    edi,[ebp+0x1]
    c9a5:	3c 25                	cmp    al,0x25
    c9a7:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    c9aa:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    c9ad:	74 d1                	je     c980 <_ZN3pci11printBussesEv+0x8a0>
    c9af:	83 ec 0c             	sub    esp,0xc
    c9b2:	50                   	push   eax
    c9b3:	e8 18 f3 ff ff       	call   bcd0 <_Z7putcharc>
    c9b8:	83 c4 10             	add    esp,0x10
    c9bb:	84 db                	test   bl,bl
    c9bd:	75 de                	jne    c99d <_ZN3pci11printBussesEv+0x8bd>
    c9bf:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    c9c3:	e9 20 f8 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    c9c8:	90                   	nop
    c9c9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    c9d0:	83 ec 0c             	sub    esp,0xc
    c9d3:	8d 7d 02             	lea    edi,[ebp+0x2]
    c9d6:	6a 25                	push   0x25
    c9d8:	e8 f3 f2 ff ff       	call   bcd0 <_Z7putcharc>
    c9dd:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    c9e2:	83 c4 10             	add    esp,0x10
    c9e5:	84 db                	test   bl,bl
    c9e7:	0f 85 a8 fc ff ff    	jne    c695 <_ZN3pci11printBussesEv+0x5b5>
    c9ed:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    c9f1:	e9 c6 fc ff ff       	jmp    c6bc <_ZN3pci11printBussesEv+0x5dc>
    c9f6:	8d 76 00             	lea    esi,[esi+0x0]
    c9f9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ca00:	83 ec 0c             	sub    esp,0xc
    ca03:	8d 7d 02             	lea    edi,[ebp+0x2]
    ca06:	6a 25                	push   0x25
    ca08:	e8 c3 f2 ff ff       	call   bcd0 <_Z7putcharc>
    ca0d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    ca12:	83 c4 10             	add    esp,0x10
    ca15:	84 db                	test   bl,bl
    ca17:	0f 85 e0 fb ff ff    	jne    c5fd <_ZN3pci11printBussesEv+0x51d>
    ca1d:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    ca21:	e9 c2 f7 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    ca26:	8d 76 00             	lea    esi,[esi+0x0]
    ca29:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ca30:	83 ec 08             	sub    esp,0x8
    ca33:	89 f3                	mov    ebx,esi
    ca35:	8b 74 24 0c          	mov    esi,DWORD PTR [esp+0xc]
    ca39:	8d 44 24 33          	lea    eax,[esp+0x33]
    ca3d:	50                   	push   eax
    ca3e:	51                   	push   ecx
    ca3f:	e8 ec 2b 00 00       	call   f630 <_Z14_manage_escapeIhEiPKcPT_>
    ca44:	01 c7                	add    edi,eax
    ca46:	83 c4 10             	add    esp,0x10
    ca49:	01 fb                	add    ebx,edi
    ca4b:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    ca4e:	84 d2                	test   dl,dl
    ca50:	0f 84 52 f8 ff ff    	je     c2a8 <_ZN3pci11printBussesEv+0x1c8>
    ca56:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    ca5a:	31 ed                	xor    ebp,ebp
    ca5c:	89 de                	mov    esi,ebx
    ca5e:	eb 26                	jmp    ca86 <_ZN3pci11printBussesEv+0x9a6>
    ca60:	80 fb 25             	cmp    bl,0x25
    ca63:	0f 84 b7 03 00 00    	je     ce20 <_ZN3pci11printBussesEv+0xd40>
    ca69:	84 db                	test   bl,bl
    ca6b:	0f 85 bf 01 00 00    	jne    cc30 <_ZN3pci11printBussesEv+0xb50>
    ca71:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    ca76:	8d 7d 02             	lea    edi,[ebp+0x2]
    ca79:	84 db                	test   bl,bl
    ca7b:	0f 84 37 fc ff ff    	je     c6b8 <_ZN3pci11printBussesEv+0x5d8>
    ca81:	0f be d3             	movsx  edx,bl
    ca84:	89 fd                	mov    ebp,edi
    ca86:	8d 7d 01             	lea    edi,[ebp+0x1]
    ca89:	80 fa 25             	cmp    dl,0x25
    ca8c:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    ca8f:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    ca92:	74 cc                	je     ca60 <_ZN3pci11printBussesEv+0x980>
    ca94:	83 ec 0c             	sub    esp,0xc
    ca97:	52                   	push   edx
    ca98:	e8 33 f2 ff ff       	call   bcd0 <_Z7putcharc>
    ca9d:	83 c4 10             	add    esp,0x10
    caa0:	84 db                	test   bl,bl
    caa2:	75 dd                	jne    ca81 <_ZN3pci11printBussesEv+0x9a1>
    caa4:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    caa8:	e9 0f fc ff ff       	jmp    c6bc <_ZN3pci11printBussesEv+0x5dc>
    caad:	8d 76 00             	lea    esi,[esi+0x0]
    cab0:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    cab4:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    cab8:	83 ec 08             	sub    esp,0x8
    cabb:	8d 44 24 31          	lea    eax,[esp+0x31]
    cabf:	50                   	push   eax
    cac0:	51                   	push   ecx
    cac1:	e8 6a 2b 00 00       	call   f630 <_Z14_manage_escapeIhEiPKcPT_>
    cac6:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    caca:	8d 1c 07             	lea    ebx,[edi+eax*1]
    cacd:	0f b6 44 24 28       	movzx  eax,BYTE PTR [esp+0x28]
    cad2:	01 d3                	add    ebx,edx
    cad4:	0f be 13             	movsx  edx,BYTE PTR [ebx]
    cad7:	88 44 24 3a          	mov    BYTE PTR [esp+0x3a],al
    cadb:	83 c4 10             	add    esp,0x10
    cade:	84 d2                	test   dl,dl
    cae0:	0f 84 02 f7 ff ff    	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    cae6:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    caea:	31 ed                	xor    ebp,ebp
    caec:	89 de                	mov    esi,ebx
    caee:	eb 26                	jmp    cb16 <_ZN3pci11printBussesEv+0xa36>
    caf0:	80 fb 25             	cmp    bl,0x25
    caf3:	0f 84 ff 02 00 00    	je     cdf8 <_ZN3pci11printBussesEv+0xd18>
    caf9:	84 db                	test   bl,bl
    cafb:	0f 85 9f 00 00 00    	jne    cba0 <_ZN3pci11printBussesEv+0xac0>
    cb01:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    cb06:	8d 7d 02             	lea    edi,[ebp+0x2]
    cb09:	84 db                	test   bl,bl
    cb0b:	0f 84 0f fb ff ff    	je     c620 <_ZN3pci11printBussesEv+0x540>
    cb11:	0f be d3             	movsx  edx,bl
    cb14:	89 fd                	mov    ebp,edi
    cb16:	8d 7d 01             	lea    edi,[ebp+0x1]
    cb19:	80 fa 25             	cmp    dl,0x25
    cb1c:	8d 0c 3e             	lea    ecx,[esi+edi*1]
    cb1f:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    cb22:	74 cc                	je     caf0 <_ZN3pci11printBussesEv+0xa10>
    cb24:	83 ec 0c             	sub    esp,0xc
    cb27:	52                   	push   edx
    cb28:	e8 a3 f1 ff ff       	call   bcd0 <_Z7putcharc>
    cb2d:	83 c4 10             	add    esp,0x10
    cb30:	84 db                	test   bl,bl
    cb32:	75 dd                	jne    cb11 <_ZN3pci11printBussesEv+0xa31>
    cb34:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    cb38:	e9 ab f6 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    cb3d:	8d 76 00             	lea    esi,[esi+0x0]
    cb40:	83 ec 0c             	sub    esp,0xc
    cb43:	8d 7d 02             	lea    edi,[ebp+0x2]
    cb46:	6a 25                	push   0x25
    cb48:	e8 83 f1 ff ff       	call   bcd0 <_Z7putcharc>
    cb4d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    cb52:	83 c4 10             	add    esp,0x10
    cb55:	84 db                	test   bl,bl
    cb57:	0f 85 c4 fc ff ff    	jne    c821 <_ZN3pci11printBussesEv+0x741>
    cb5d:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    cb61:	e9 56 fb ff ff       	jmp    c6bc <_ZN3pci11printBussesEv+0x5dc>
    cb66:	8d 76 00             	lea    esi,[esi+0x0]
    cb69:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    cb70:	83 ec 0c             	sub    esp,0xc
    cb73:	8d 7d 02             	lea    edi,[ebp+0x2]
    cb76:	6a 25                	push   0x25
    cb78:	e8 53 f1 ff ff       	call   bcd0 <_Z7putcharc>
    cb7d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    cb82:	83 c4 10             	add    esp,0x10
    cb85:	84 db                	test   bl,bl
    cb87:	0f 85 04 fc ff ff    	jne    c791 <_ZN3pci11printBussesEv+0x6b1>
    cb8d:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    cb91:	e9 52 f6 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    cb96:	8d 76 00             	lea    esi,[esi+0x0]
    cb99:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    cba0:	83 ec 08             	sub    esp,0x8
    cba3:	89 f3                	mov    ebx,esi
    cba5:	8b 74 24 0c          	mov    esi,DWORD PTR [esp+0xc]
    cba9:	8d 44 24 32          	lea    eax,[esp+0x32]
    cbad:	50                   	push   eax
    cbae:	51                   	push   ecx
    cbaf:	e8 7c 2a 00 00       	call   f630 <_Z14_manage_escapeIhEiPKcPT_>
    cbb4:	01 c7                	add    edi,eax
    cbb6:	8b 44 24 18          	mov    eax,DWORD PTR [esp+0x18]
    cbba:	8d 14 3b             	lea    edx,[ebx+edi*1]
    cbbd:	89 44 24 50          	mov    DWORD PTR [esp+0x50],eax
    cbc1:	0f be 02             	movsx  eax,BYTE PTR [edx]
    cbc4:	83 c4 10             	add    esp,0x10
    cbc7:	84 c0                	test   al,al
    cbc9:	0f 84 19 f6 ff ff    	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    cbcf:	89 74 24 10          	mov    DWORD PTR [esp+0x10],esi
    cbd3:	31 ff                	xor    edi,edi
    cbd5:	89 d6                	mov    esi,edx
    cbd7:	eb 2d                	jmp    cc06 <_ZN3pci11printBussesEv+0xb26>
    cbd9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    cbe0:	80 fb 25             	cmp    bl,0x25
    cbe3:	0f 84 8f 02 00 00    	je     ce78 <_ZN3pci11printBussesEv+0xd98>
    cbe9:	84 db                	test   bl,bl
    cbeb:	0f 85 7f 01 00 00    	jne    cd70 <_ZN3pci11printBussesEv+0xc90>
    cbf1:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    cbf6:	8d 6f 02             	lea    ebp,[edi+0x2]
    cbf9:	84 db                	test   bl,bl
    cbfb:	0f 84 be fd ff ff    	je     c9bf <_ZN3pci11printBussesEv+0x8df>
    cc01:	0f be c3             	movsx  eax,bl
    cc04:	89 ef                	mov    edi,ebp
    cc06:	8d 6f 01             	lea    ebp,[edi+0x1]
    cc09:	3c 25                	cmp    al,0x25
    cc0b:	8d 0c 2e             	lea    ecx,[esi+ebp*1]
    cc0e:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    cc11:	74 cd                	je     cbe0 <_ZN3pci11printBussesEv+0xb00>
    cc13:	83 ec 0c             	sub    esp,0xc
    cc16:	50                   	push   eax
    cc17:	e8 b4 f0 ff ff       	call   bcd0 <_Z7putcharc>
    cc1c:	83 c4 10             	add    esp,0x10
    cc1f:	84 db                	test   bl,bl
    cc21:	75 de                	jne    cc01 <_ZN3pci11printBussesEv+0xb21>
    cc23:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    cc27:	e9 bc f5 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    cc2c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    cc30:	89 d8                	mov    eax,ebx
    cc32:	89 f3                	mov    ebx,esi
    cc34:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    cc38:	83 e8 42             	sub    eax,0x42
    cc3b:	3c 36                	cmp    al,0x36
    cc3d:	77 21                	ja     cc60 <_ZN3pci11printBussesEv+0xb80>
    cc3f:	0f b6 c0             	movzx  eax,al
    cc42:	ff 24 85 7c 00 01 00 	jmp    DWORD PTR [eax*4+0x1007c]
    cc49:	83 ec 0c             	sub    esp,0xc
    cc4c:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    cc50:	e8 3b f1 ff ff       	call   bd90 <_Z6putstrPc>
    cc55:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    cc59:	83 c4 10             	add    esp,0x10
    cc5c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    cc60:	83 ec 0c             	sub    esp,0xc
    cc63:	83 c6 01             	add    esi,0x1
    cc66:	51                   	push   ecx
    cc67:	e8 64 f1 ff ff       	call   bdd0 <_Z6printfPKc>
    cc6c:	83 c4 10             	add    esp,0x10
    cc6f:	83 fe 20             	cmp    esi,0x20
    cc72:	0f 85 90 f4 ff ff    	jne    c108 <_ZN3pci11printBussesEv+0x28>
    cc78:	e9 37 f6 ff ff       	jmp    c2b4 <_ZN3pci11printBussesEv+0x1d4>
    cc7d:	83 ec 0c             	sub    esp,0xc
    cc80:	0f be 44 24 24       	movsx  eax,BYTE PTR [esp+0x24]
    cc85:	50                   	push   eax
    cc86:	e8 45 f0 ff ff       	call   bcd0 <_Z7putcharc>
    cc8b:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    cc8f:	83 c4 10             	add    esp,0x10
    cc92:	eb cc                	jmp    cc60 <_ZN3pci11printBussesEv+0xb80>
    cc94:	83 ec 0c             	sub    esp,0xc
    cc97:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    cc9b:	e8 50 f0 ff ff       	call   bcf0 <_Z6puthexi>
    cca0:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    cca4:	83 c4 10             	add    esp,0x10
    cca7:	eb b7                	jmp    cc60 <_ZN3pci11printBussesEv+0xb80>
    cca9:	83 ec 0c             	sub    esp,0xc
    ccac:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ccb0:	e8 5b f0 ff ff       	call   bd10 <_Z6putocti>
    ccb5:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ccb9:	83 c4 10             	add    esp,0x10
    ccbc:	eb a2                	jmp    cc60 <_ZN3pci11printBussesEv+0xb80>
    ccbe:	83 ec 0c             	sub    esp,0xc
    ccc1:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ccc5:	e8 56 f0 ff ff       	call   bd20 <_Z6putbini>
    ccca:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ccce:	83 c4 10             	add    esp,0x10
    ccd1:	eb 8d                	jmp    cc60 <_ZN3pci11printBussesEv+0xb80>
    ccd3:	83 ec 0c             	sub    esp,0xc
    ccd6:	68 64 01 01 00       	push   0x10164
    ccdb:	e8 f0 f0 ff ff       	call   bdd0 <_Z6printfPKc>
    cce0:	58                   	pop    eax
    cce1:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    cce5:	e8 06 f0 ff ff       	call   bcf0 <_Z6puthexi>
    ccea:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    ccee:	83 c4 10             	add    esp,0x10
    ccf1:	e9 6a ff ff ff       	jmp    cc60 <_ZN3pci11printBussesEv+0xb80>
    ccf6:	83 ec 0c             	sub    esp,0xc
    ccf9:	ff 74 24 24          	push   DWORD PTR [esp+0x24]
    ccfd:	e8 de ef ff ff       	call   bce0 <_Z6putdeci>
    cd02:	8d 4c 2b 02          	lea    ecx,[ebx+ebp*1+0x2]
    cd06:	83 c4 10             	add    esp,0x10
    cd09:	e9 52 ff ff ff       	jmp    cc60 <_ZN3pci11printBussesEv+0xb80>
    cd0e:	66 90                	xchg   ax,ax
    cd10:	83 ec 0c             	sub    esp,0xc
    cd13:	8d 7d 02             	lea    edi,[ebp+0x2]
    cd16:	6a 25                	push   0x25
    cd18:	e8 b3 ef ff ff       	call   bcd0 <_Z7putcharc>
    cd1d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    cd22:	83 c4 10             	add    esp,0x10
    cd25:	84 db                	test   bl,bl
    cd27:	0f 85 e4 fb ff ff    	jne    c911 <_ZN3pci11printBussesEv+0x831>
    cd2d:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    cd31:	e9 86 f9 ff ff       	jmp    c6bc <_ZN3pci11printBussesEv+0x5dc>
    cd36:	8d 76 00             	lea    esi,[esi+0x0]
    cd39:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    cd40:	83 ec 0c             	sub    esp,0xc
    cd43:	8d 7d 02             	lea    edi,[ebp+0x2]
    cd46:	6a 25                	push   0x25
    cd48:	e8 83 ef ff ff       	call   bcd0 <_Z7putcharc>
    cd4d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    cd52:	83 c4 10             	add    esp,0x10
    cd55:	84 db                	test   bl,bl
    cd57:	0f 85 40 fc ff ff    	jne    c99d <_ZN3pci11printBussesEv+0x8bd>
    cd5d:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    cd61:	e9 82 f4 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    cd66:	8d 76 00             	lea    esi,[esi+0x0]
    cd69:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    cd70:	89 74 24 04          	mov    DWORD PTR [esp+0x4],esi
    cd74:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    cd78:	83 ec 08             	sub    esp,0x8
    cd7b:	8d 44 24 48          	lea    eax,[esp+0x48]
    cd7f:	50                   	push   eax
    cd80:	51                   	push   ecx
    cd81:	e8 4a 02 00 00       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    cd86:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    cd8a:	01 c5                	add    ebp,eax
    cd8c:	89 74 24 54          	mov    DWORD PTR [esp+0x54],esi
    cd90:	83 c4 10             	add    esp,0x10
    cd93:	01 d5                	add    ebp,edx
    cd95:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    cd99:	84 c0                	test   al,al
    cd9b:	0f 84 47 f4 ff ff    	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    cda1:	31 d2                	xor    edx,edx
    cda3:	eb 29                	jmp    cdce <_ZN3pci11printBussesEv+0xcee>
    cda5:	8d 76 00             	lea    esi,[esi+0x0]
    cda8:	80 fb 25             	cmp    bl,0x25
    cdab:	0f 84 ef 00 00 00    	je     cea0 <_ZN3pci11printBussesEv+0xdc0>
    cdb1:	84 db                	test   bl,bl
    cdb3:	0f 85 97 00 00 00    	jne    ce50 <_ZN3pci11printBussesEv+0xd70>
    cdb9:	0f b6 5c 15 02       	movzx  ebx,BYTE PTR [ebp+edx*1+0x2]
    cdbe:	8d 7a 02             	lea    edi,[edx+0x2]
    cdc1:	84 db                	test   bl,bl
    cdc3:	0f 84 1f f4 ff ff    	je     c1e8 <_ZN3pci11printBussesEv+0x108>
    cdc9:	0f be c3             	movsx  eax,bl
    cdcc:	89 fa                	mov    edx,edi
    cdce:	8d 7a 01             	lea    edi,[edx+0x1]
    cdd1:	3c 25                	cmp    al,0x25
    cdd3:	8d 4c 3d 00          	lea    ecx,[ebp+edi*1+0x0]
    cdd7:	0f b6 19             	movzx  ebx,BYTE PTR [ecx]
    cdda:	74 cc                	je     cda8 <_ZN3pci11printBussesEv+0xcc8>
    cddc:	83 ec 0c             	sub    esp,0xc
    cddf:	50                   	push   eax
    cde0:	e8 eb ee ff ff       	call   bcd0 <_Z7putcharc>
    cde5:	83 c4 10             	add    esp,0x10
    cde8:	84 db                	test   bl,bl
    cdea:	75 dd                	jne    cdc9 <_ZN3pci11printBussesEv+0xce9>
    cdec:	e9 f7 f3 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    cdf1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    cdf8:	83 ec 0c             	sub    esp,0xc
    cdfb:	8d 7d 02             	lea    edi,[ebp+0x2]
    cdfe:	6a 25                	push   0x25
    ce00:	e8 cb ee ff ff       	call   bcd0 <_Z7putcharc>
    ce05:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    ce0a:	83 c4 10             	add    esp,0x10
    ce0d:	84 db                	test   bl,bl
    ce0f:	0f 85 fc fc ff ff    	jne    cb11 <_ZN3pci11printBussesEv+0xa31>
    ce15:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    ce19:	e9 ca f3 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    ce1e:	66 90                	xchg   ax,ax
    ce20:	83 ec 0c             	sub    esp,0xc
    ce23:	8d 7d 02             	lea    edi,[ebp+0x2]
    ce26:	6a 25                	push   0x25
    ce28:	e8 a3 ee ff ff       	call   bcd0 <_Z7putcharc>
    ce2d:	0f b6 5c 2e 02       	movzx  ebx,BYTE PTR [esi+ebp*1+0x2]
    ce32:	83 c4 10             	add    esp,0x10
    ce35:	84 db                	test   bl,bl
    ce37:	0f 85 44 fc ff ff    	jne    ca81 <_ZN3pci11printBussesEv+0x9a1>
    ce3d:	8b 74 24 04          	mov    esi,DWORD PTR [esp+0x4]
    ce41:	e9 76 f8 ff ff       	jmp    c6bc <_ZN3pci11printBussesEv+0x5dc>
    ce46:	8d 76 00             	lea    esi,[esi+0x0]
    ce49:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ce50:	83 ec 08             	sub    esp,0x8
    ce53:	8d 44 24 4c          	lea    eax,[esp+0x4c]
    ce57:	50                   	push   eax
    ce58:	51                   	push   ecx
    ce59:	e8 72 01 00 00       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    ce5e:	8d 14 38             	lea    edx,[eax+edi*1]
    ce61:	01 ea                	add    edx,ebp
    ce63:	89 14 24             	mov    DWORD PTR [esp],edx
    ce66:	e8 65 ef ff ff       	call   bdd0 <_Z6printfPKc>
    ce6b:	83 c4 10             	add    esp,0x10
    ce6e:	e9 75 f3 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    ce73:	90                   	nop
    ce74:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ce78:	83 ec 0c             	sub    esp,0xc
    ce7b:	8d 6f 02             	lea    ebp,[edi+0x2]
    ce7e:	6a 25                	push   0x25
    ce80:	e8 4b ee ff ff       	call   bcd0 <_Z7putcharc>
    ce85:	0f b6 5c 3e 02       	movzx  ebx,BYTE PTR [esi+edi*1+0x2]
    ce8a:	83 c4 10             	add    esp,0x10
    ce8d:	84 db                	test   bl,bl
    ce8f:	0f 85 6c fd ff ff    	jne    cc01 <_ZN3pci11printBussesEv+0xb21>
    ce95:	8b 74 24 10          	mov    esi,DWORD PTR [esp+0x10]
    ce99:	e9 4a f3 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>
    ce9e:	66 90                	xchg   ax,ax
    cea0:	89 54 24 04          	mov    DWORD PTR [esp+0x4],edx
    cea4:	83 ec 0c             	sub    esp,0xc
    cea7:	6a 25                	push   0x25
    cea9:	e8 22 ee ff ff       	call   bcd0 <_Z7putcharc>
    ceae:	8b 54 24 14          	mov    edx,DWORD PTR [esp+0x14]
    ceb2:	83 c4 10             	add    esp,0x10
    ceb5:	0f b6 5c 15 02       	movzx  ebx,BYTE PTR [ebp+edx*1+0x2]
    ceba:	8d 7a 02             	lea    edi,[edx+0x2]
    cebd:	84 db                	test   bl,bl
    cebf:	0f 85 04 ff ff ff    	jne    cdc9 <_ZN3pci11printBussesEv+0xce9>
    cec5:	e9 1e f3 ff ff       	jmp    c1e8 <_ZN3pci11printBussesEv+0x108>

Disassembly of section .text._Z14_manage_escapeIPKcEiS1_PT_:

0000ced0 <_Z14_manage_escapeIPKcEiS1_PT_>:
    ced0:	83 ec 0c             	sub    esp,0xc
    ced3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    ced7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    ceda:	83 e8 42             	sub    eax,0x42
    cedd:	3c 36                	cmp    al,0x36
    cedf:	0f 87 db 00 00 00    	ja     cfc0 <_Z14_manage_escapeIPKcEiS1_PT_+0xf0>
    cee5:	0f b6 c0             	movzx  eax,al
    cee8:	ff 24 85 68 01 01 00 	jmp    DWORD PTR [eax*4+0x10168]
    ceef:	90                   	nop
    cef0:	83 ec 0c             	sub    esp,0xc
    cef3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cef7:	ff 30                	push   DWORD PTR [eax]
    cef9:	e8 92 ee ff ff       	call   bd90 <_Z6putstrPc>
    cefe:	83 c4 10             	add    esp,0x10
    cf01:	b8 01 00 00 00       	mov    eax,0x1
    cf06:	83 c4 0c             	add    esp,0xc
    cf09:	c3                   	ret    
    cf0a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    cf10:	83 ec 0c             	sub    esp,0xc
    cf13:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cf17:	ff 30                	push   DWORD PTR [eax]
    cf19:	e8 02 ee ff ff       	call   bd20 <_Z6putbini>
    cf1e:	83 c4 10             	add    esp,0x10
    cf21:	b8 01 00 00 00       	mov    eax,0x1
    cf26:	83 c4 0c             	add    esp,0xc
    cf29:	c3                   	ret    
    cf2a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    cf30:	83 ec 0c             	sub    esp,0xc
    cf33:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cf37:	ff 30                	push   DWORD PTR [eax]
    cf39:	e8 d2 ed ff ff       	call   bd10 <_Z6putocti>
    cf3e:	83 c4 10             	add    esp,0x10
    cf41:	b8 01 00 00 00       	mov    eax,0x1
    cf46:	83 c4 0c             	add    esp,0xc
    cf49:	c3                   	ret    
    cf4a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    cf50:	83 ec 0c             	sub    esp,0xc
    cf53:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cf57:	ff 30                	push   DWORD PTR [eax]
    cf59:	e8 92 ed ff ff       	call   bcf0 <_Z6puthexi>
    cf5e:	83 c4 10             	add    esp,0x10
    cf61:	b8 01 00 00 00       	mov    eax,0x1
    cf66:	83 c4 0c             	add    esp,0xc
    cf69:	c3                   	ret    
    cf6a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    cf70:	83 ec 0c             	sub    esp,0xc
    cf73:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cf77:	0f be 00             	movsx  eax,BYTE PTR [eax]
    cf7a:	50                   	push   eax
    cf7b:	e8 50 ed ff ff       	call   bcd0 <_Z7putcharc>
    cf80:	83 c4 10             	add    esp,0x10
    cf83:	b8 01 00 00 00       	mov    eax,0x1
    cf88:	83 c4 0c             	add    esp,0xc
    cf8b:	c3                   	ret    
    cf8c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    cf90:	83 ec 0c             	sub    esp,0xc
    cf93:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cf97:	ff 30                	push   DWORD PTR [eax]
    cf99:	e8 42 ed ff ff       	call   bce0 <_Z6putdeci>
    cf9e:	83 c4 10             	add    esp,0x10
    cfa1:	b8 01 00 00 00       	mov    eax,0x1
    cfa6:	83 c4 0c             	add    esp,0xc
    cfa9:	c3                   	ret    
    cfaa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    cfb0:	83 ec 0c             	sub    esp,0xc
    cfb3:	68 64 01 01 00       	push   0x10164
    cfb8:	e8 13 ee ff ff       	call   bdd0 <_Z6printfPKc>
    cfbd:	58                   	pop    eax
    cfbe:	eb 93                	jmp    cf53 <_Z14_manage_escapeIPKcEiS1_PT_+0x83>
    cfc0:	31 c0                	xor    eax,eax
    cfc2:	e9 3f ff ff ff       	jmp    cf06 <_Z14_manage_escapeIPKcEiS1_PT_+0x36>

Disassembly of section .text._Z14_manage_escapeIiEiPKcPT_:

0000cfd0 <_Z14_manage_escapeIiEiPKcPT_>:
    cfd0:	83 ec 0c             	sub    esp,0xc
    cfd3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    cfd7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    cfda:	83 e8 42             	sub    eax,0x42
    cfdd:	3c 36                	cmp    al,0x36
    cfdf:	0f 87 db 00 00 00    	ja     d0c0 <_Z14_manage_escapeIiEiPKcPT_+0xf0>
    cfe5:	0f b6 c0             	movzx  eax,al
    cfe8:	ff 24 85 44 02 01 00 	jmp    DWORD PTR [eax*4+0x10244]
    cfef:	90                   	nop
    cff0:	83 ec 0c             	sub    esp,0xc
    cff3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    cff7:	ff 30                	push   DWORD PTR [eax]
    cff9:	e8 92 ed ff ff       	call   bd90 <_Z6putstrPc>
    cffe:	83 c4 10             	add    esp,0x10
    d001:	b8 01 00 00 00       	mov    eax,0x1
    d006:	83 c4 0c             	add    esp,0xc
    d009:	c3                   	ret    
    d00a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d010:	83 ec 0c             	sub    esp,0xc
    d013:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d017:	ff 30                	push   DWORD PTR [eax]
    d019:	e8 02 ed ff ff       	call   bd20 <_Z6putbini>
    d01e:	83 c4 10             	add    esp,0x10
    d021:	b8 01 00 00 00       	mov    eax,0x1
    d026:	83 c4 0c             	add    esp,0xc
    d029:	c3                   	ret    
    d02a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d030:	83 ec 0c             	sub    esp,0xc
    d033:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d037:	ff 30                	push   DWORD PTR [eax]
    d039:	e8 d2 ec ff ff       	call   bd10 <_Z6putocti>
    d03e:	83 c4 10             	add    esp,0x10
    d041:	b8 01 00 00 00       	mov    eax,0x1
    d046:	83 c4 0c             	add    esp,0xc
    d049:	c3                   	ret    
    d04a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d050:	83 ec 0c             	sub    esp,0xc
    d053:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d057:	ff 30                	push   DWORD PTR [eax]
    d059:	e8 92 ec ff ff       	call   bcf0 <_Z6puthexi>
    d05e:	83 c4 10             	add    esp,0x10
    d061:	b8 01 00 00 00       	mov    eax,0x1
    d066:	83 c4 0c             	add    esp,0xc
    d069:	c3                   	ret    
    d06a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d070:	83 ec 0c             	sub    esp,0xc
    d073:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d077:	0f be 00             	movsx  eax,BYTE PTR [eax]
    d07a:	50                   	push   eax
    d07b:	e8 50 ec ff ff       	call   bcd0 <_Z7putcharc>
    d080:	83 c4 10             	add    esp,0x10
    d083:	b8 01 00 00 00       	mov    eax,0x1
    d088:	83 c4 0c             	add    esp,0xc
    d08b:	c3                   	ret    
    d08c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d090:	83 ec 0c             	sub    esp,0xc
    d093:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d097:	ff 30                	push   DWORD PTR [eax]
    d099:	e8 42 ec ff ff       	call   bce0 <_Z6putdeci>
    d09e:	83 c4 10             	add    esp,0x10
    d0a1:	b8 01 00 00 00       	mov    eax,0x1
    d0a6:	83 c4 0c             	add    esp,0xc
    d0a9:	c3                   	ret    
    d0aa:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d0b0:	83 ec 0c             	sub    esp,0xc
    d0b3:	68 64 01 01 00       	push   0x10164
    d0b8:	e8 13 ed ff ff       	call   bdd0 <_Z6printfPKc>
    d0bd:	58                   	pop    eax
    d0be:	eb 93                	jmp    d053 <_Z14_manage_escapeIiEiPKcPT_+0x83>
    d0c0:	31 c0                	xor    eax,eax
    d0c2:	e9 3f ff ff ff       	jmp    d006 <_Z14_manage_escapeIiEiPKcPT_+0x36>

Disassembly of section .text._Z6printfIPKcJiS1_EEvS1_T_DpT0_:

0000d0d0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_>:
    d0d0:	55                   	push   ebp
    d0d1:	57                   	push   edi
    d0d2:	56                   	push   esi
    d0d3:	53                   	push   ebx
    d0d4:	31 f6                	xor    esi,esi
    d0d6:	83 ec 1c             	sub    esp,0x1c
    d0d9:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    d0dd:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d0e1:	84 c0                	test   al,al
    d0e3:	74 46                	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d0e5:	8d 5e 01             	lea    ebx,[esi+0x1]
    d0e8:	3c 25                	cmp    al,0x25
    d0ea:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d0ee:	75 28                	jne    d118 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x48>
    d0f0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    d0f3:	3c 25                	cmp    al,0x25
    d0f5:	0f 84 45 01 00 00    	je     d240 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x170>
    d0fb:	84 c0                	test   al,al
    d0fd:	75 39                	jne    d138 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x68>
    d0ff:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d104:	8d 5e 02             	lea    ebx,[esi+0x2]
    d107:	84 c0                	test   al,al
    d109:	74 20                	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d10b:	89 de                	mov    esi,ebx
    d10d:	8d 5e 01             	lea    ebx,[esi+0x1]
    d110:	3c 25                	cmp    al,0x25
    d112:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d116:	74 d8                	je     d0f0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x20>
    d118:	83 ec 0c             	sub    esp,0xc
    d11b:	50                   	push   eax
    d11c:	e8 af eb ff ff       	call   bcd0 <_Z7putcharc>
    d121:	0f be 07             	movsx  eax,BYTE PTR [edi]
    d124:	83 c4 10             	add    esp,0x10
    d127:	84 c0                	test   al,al
    d129:	75 e0                	jne    d10b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x3b>
    d12b:	83 c4 1c             	add    esp,0x1c
    d12e:	5b                   	pop    ebx
    d12f:	5e                   	pop    esi
    d130:	5f                   	pop    edi
    d131:	5d                   	pop    ebp
    d132:	c3                   	ret    
    d133:	90                   	nop
    d134:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d138:	83 ec 08             	sub    esp,0x8
    d13b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    d13f:	50                   	push   eax
    d140:	57                   	push   edi
    d141:	31 ff                	xor    edi,edi
    d143:	e8 88 fd ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    d148:	01 c3                	add    ebx,eax
    d14a:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    d14e:	01 eb                	add    ebx,ebp
    d150:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    d154:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    d157:	83 c4 10             	add    esp,0x10
    d15a:	84 c0                	test   al,al
    d15c:	74 cd                	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d15e:	8d 77 01             	lea    esi,[edi+0x1]
    d161:	3c 25                	cmp    al,0x25
    d163:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d166:	75 30                	jne    d198 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0xc8>
    d168:	90                   	nop
    d169:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d170:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    d174:	3c 25                	cmp    al,0x25
    d176:	0f 84 14 01 00 00    	je     d290 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x1c0>
    d17c:	84 c0                	test   al,al
    d17e:	75 38                	jne    d1b8 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0xe8>
    d180:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    d185:	8d 77 02             	lea    esi,[edi+0x2]
    d188:	84 c0                	test   al,al
    d18a:	74 9f                	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d18c:	89 f7                	mov    edi,esi
    d18e:	8d 77 01             	lea    esi,[edi+0x1]
    d191:	3c 25                	cmp    al,0x25
    d193:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d196:	74 d8                	je     d170 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0xa0>
    d198:	83 ec 0c             	sub    esp,0xc
    d19b:	50                   	push   eax
    d19c:	e8 2f eb ff ff       	call   bcd0 <_Z7putcharc>
    d1a1:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d1a5:	83 c4 10             	add    esp,0x10
    d1a8:	84 c0                	test   al,al
    d1aa:	0f 84 7b ff ff ff    	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d1b0:	89 f7                	mov    edi,esi
    d1b2:	eb da                	jmp    d18e <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0xbe>
    d1b4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d1b8:	83 ec 08             	sub    esp,0x8
    d1bb:	8d 44 24 10          	lea    eax,[esp+0x10]
    d1bf:	50                   	push   eax
    d1c0:	55                   	push   ebp
    d1c1:	e8 0a fe ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    d1c6:	01 c6                	add    esi,eax
    d1c8:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    d1cc:	01 de                	add    esi,ebx
    d1ce:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    d1d2:	0f be 06             	movsx  eax,BYTE PTR [esi]
    d1d5:	83 c4 10             	add    esp,0x10
    d1d8:	84 c0                	test   al,al
    d1da:	0f 84 4b ff ff ff    	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d1e0:	31 ff                	xor    edi,edi
    d1e2:	3c 25                	cmp    al,0x25
    d1e4:	8d 5f 01             	lea    ebx,[edi+0x1]
    d1e7:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    d1ea:	75 30                	jne    d21c <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x14c>
    d1ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d1f0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    d1f4:	3c 25                	cmp    al,0x25
    d1f6:	0f 84 bc 00 00 00    	je     d2b8 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x1e8>
    d1fc:	84 c0                	test   al,al
    d1fe:	75 68                	jne    d268 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x198>
    d200:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    d205:	8d 5f 02             	lea    ebx,[edi+0x2]
    d208:	84 c0                	test   al,al
    d20a:	0f 84 1b ff ff ff    	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d210:	89 df                	mov    edi,ebx
    d212:	8d 5f 01             	lea    ebx,[edi+0x1]
    d215:	3c 25                	cmp    al,0x25
    d217:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    d21a:	74 d4                	je     d1f0 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x120>
    d21c:	83 ec 0c             	sub    esp,0xc
    d21f:	50                   	push   eax
    d220:	e8 ab ea ff ff       	call   bcd0 <_Z7putcharc>
    d225:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d229:	83 c4 10             	add    esp,0x10
    d22c:	84 c0                	test   al,al
    d22e:	0f 84 f7 fe ff ff    	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d234:	89 df                	mov    edi,ebx
    d236:	eb da                	jmp    d212 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x142>
    d238:	90                   	nop
    d239:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d240:	83 ec 0c             	sub    esp,0xc
    d243:	8d 5e 02             	lea    ebx,[esi+0x2]
    d246:	6a 25                	push   0x25
    d248:	e8 83 ea ff ff       	call   bcd0 <_Z7putcharc>
    d24d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d252:	83 c4 10             	add    esp,0x10
    d255:	84 c0                	test   al,al
    d257:	0f 84 ce fe ff ff    	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d25d:	89 de                	mov    esi,ebx
    d25f:	e9 a9 fe ff ff       	jmp    d10d <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x3d>
    d264:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d268:	83 ec 08             	sub    esp,0x8
    d26b:	8d 44 24 14          	lea    eax,[esp+0x14]
    d26f:	50                   	push   eax
    d270:	55                   	push   ebp
    d271:	e8 5a fc ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    d276:	01 c3                	add    ebx,eax
    d278:	01 f3                	add    ebx,esi
    d27a:	89 1c 24             	mov    DWORD PTR [esp],ebx
    d27d:	e8 4e eb ff ff       	call   bdd0 <_Z6printfPKc>
    d282:	83 c4 10             	add    esp,0x10
    d285:	83 c4 1c             	add    esp,0x1c
    d288:	5b                   	pop    ebx
    d289:	5e                   	pop    esi
    d28a:	5f                   	pop    edi
    d28b:	5d                   	pop    ebp
    d28c:	c3                   	ret    
    d28d:	8d 76 00             	lea    esi,[esi+0x0]
    d290:	83 ec 0c             	sub    esp,0xc
    d293:	8d 77 02             	lea    esi,[edi+0x2]
    d296:	6a 25                	push   0x25
    d298:	e8 33 ea ff ff       	call   bcd0 <_Z7putcharc>
    d29d:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    d2a2:	83 c4 10             	add    esp,0x10
    d2a5:	84 c0                	test   al,al
    d2a7:	0f 84 7e fe ff ff    	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d2ad:	89 f7                	mov    edi,esi
    d2af:	e9 da fe ff ff       	jmp    d18e <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0xbe>
    d2b4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d2b8:	83 ec 0c             	sub    esp,0xc
    d2bb:	8d 5f 02             	lea    ebx,[edi+0x2]
    d2be:	6a 25                	push   0x25
    d2c0:	e8 0b ea ff ff       	call   bcd0 <_Z7putcharc>
    d2c5:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    d2ca:	83 c4 10             	add    esp,0x10
    d2cd:	84 c0                	test   al,al
    d2cf:	0f 84 56 fe ff ff    	je     d12b <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x5b>
    d2d5:	89 df                	mov    edi,ebx
    d2d7:	e9 36 ff ff ff       	jmp    d212 <_Z6printfIPKcJiS1_EEvS1_T_DpT0_+0x142>

Disassembly of section .text._Z6printfIPKcJPcEEvS1_T_DpT0_:

0000d2e0 <_Z6printfIPKcJPcEEvS1_T_DpT0_>:
    d2e0:	55                   	push   ebp
    d2e1:	57                   	push   edi
    d2e2:	56                   	push   esi
    d2e3:	53                   	push   ebx
    d2e4:	31 f6                	xor    esi,esi
    d2e6:	83 ec 0c             	sub    esp,0xc
    d2e9:	8b 6c 24 20          	mov    ebp,DWORD PTR [esp+0x20]
    d2ed:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d2f1:	84 c0                	test   al,al
    d2f3:	74 46                	je     d33b <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x5b>
    d2f5:	8d 5e 01             	lea    ebx,[esi+0x1]
    d2f8:	3c 25                	cmp    al,0x25
    d2fa:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d2fe:	75 28                	jne    d328 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x48>
    d300:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    d303:	3c 25                	cmp    al,0x25
    d305:	0f 84 fd 00 00 00    	je     d408 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x128>
    d30b:	84 c0                	test   al,al
    d30d:	75 39                	jne    d348 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x68>
    d30f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d314:	8d 5e 02             	lea    ebx,[esi+0x2]
    d317:	84 c0                	test   al,al
    d319:	74 20                	je     d33b <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x5b>
    d31b:	89 de                	mov    esi,ebx
    d31d:	8d 5e 01             	lea    ebx,[esi+0x1]
    d320:	3c 25                	cmp    al,0x25
    d322:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d326:	74 d8                	je     d300 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x20>
    d328:	83 ec 0c             	sub    esp,0xc
    d32b:	50                   	push   eax
    d32c:	e8 9f e9 ff ff       	call   bcd0 <_Z7putcharc>
    d331:	0f be 07             	movsx  eax,BYTE PTR [edi]
    d334:	83 c4 10             	add    esp,0x10
    d337:	84 c0                	test   al,al
    d339:	75 e0                	jne    d31b <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x3b>
    d33b:	83 c4 0c             	add    esp,0xc
    d33e:	5b                   	pop    ebx
    d33f:	5e                   	pop    esi
    d340:	5f                   	pop    edi
    d341:	5d                   	pop    ebp
    d342:	c3                   	ret    
    d343:	90                   	nop
    d344:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d348:	83 ec 08             	sub    esp,0x8
    d34b:	8d 44 24 2c          	lea    eax,[esp+0x2c]
    d34f:	50                   	push   eax
    d350:	57                   	push   edi
    d351:	e8 7a fb ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    d356:	01 c3                	add    ebx,eax
    d358:	83 c4 10             	add    esp,0x10
    d35b:	01 dd                	add    ebp,ebx
    d35d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d361:	84 c0                	test   al,al
    d363:	74 d6                	je     d33b <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x5b>
    d365:	31 db                	xor    ebx,ebx
    d367:	3c 25                	cmp    al,0x25
    d369:	8d 73 01             	lea    esi,[ebx+0x1]
    d36c:	8d 7c 35 00          	lea    edi,[ebp+esi*1+0x0]
    d370:	75 2e                	jne    d3a0 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0xc0>
    d372:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d378:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    d37b:	3c 25                	cmp    al,0x25
    d37d:	0f 84 ad 00 00 00    	je     d430 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x150>
    d383:	84 c0                	test   al,al
    d385:	75 39                	jne    d3c0 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0xe0>
    d387:	0f be 44 1d 02       	movsx  eax,BYTE PTR [ebp+ebx*1+0x2]
    d38c:	8d 73 02             	lea    esi,[ebx+0x2]
    d38f:	84 c0                	test   al,al
    d391:	74 a8                	je     d33b <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x5b>
    d393:	89 f3                	mov    ebx,esi
    d395:	8d 73 01             	lea    esi,[ebx+0x1]
    d398:	3c 25                	cmp    al,0x25
    d39a:	8d 7c 35 00          	lea    edi,[ebp+esi*1+0x0]
    d39e:	74 d8                	je     d378 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x98>
    d3a0:	83 ec 0c             	sub    esp,0xc
    d3a3:	50                   	push   eax
    d3a4:	e8 27 e9 ff ff       	call   bcd0 <_Z7putcharc>
    d3a9:	0f be 07             	movsx  eax,BYTE PTR [edi]
    d3ac:	83 c4 10             	add    esp,0x10
    d3af:	84 c0                	test   al,al
    d3b1:	74 88                	je     d33b <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x5b>
    d3b3:	89 f3                	mov    ebx,esi
    d3b5:	eb de                	jmp    d395 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0xb5>
    d3b7:	89 f6                	mov    esi,esi
    d3b9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    d3c0:	83 e8 42             	sub    eax,0x42
    d3c3:	3c 36                	cmp    al,0x36
    d3c5:	77 26                	ja     d3ed <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x10d>
    d3c7:	0f b6 c0             	movzx  eax,al
    d3ca:	ff 24 85 18 0a 01 00 	jmp    DWORD PTR [eax*4+0x10a18]
    d3d1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d3d8:	83 ec 0c             	sub    esp,0xc
    d3db:	8d 7c 1d 02          	lea    edi,[ebp+ebx*1+0x2]
    d3df:	0f be 44 24 34       	movsx  eax,BYTE PTR [esp+0x34]
    d3e4:	50                   	push   eax
    d3e5:	e8 e6 e8 ff ff       	call   bcd0 <_Z7putcharc>
    d3ea:	83 c4 10             	add    esp,0x10
    d3ed:	83 ec 0c             	sub    esp,0xc
    d3f0:	57                   	push   edi
    d3f1:	e8 da e9 ff ff       	call   bdd0 <_Z6printfPKc>
    d3f6:	83 c4 10             	add    esp,0x10
    d3f9:	83 c4 0c             	add    esp,0xc
    d3fc:	5b                   	pop    ebx
    d3fd:	5e                   	pop    esi
    d3fe:	5f                   	pop    edi
    d3ff:	5d                   	pop    ebp
    d400:	c3                   	ret    
    d401:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d408:	83 ec 0c             	sub    esp,0xc
    d40b:	8d 5e 02             	lea    ebx,[esi+0x2]
    d40e:	6a 25                	push   0x25
    d410:	e8 bb e8 ff ff       	call   bcd0 <_Z7putcharc>
    d415:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d41a:	83 c4 10             	add    esp,0x10
    d41d:	84 c0                	test   al,al
    d41f:	0f 84 16 ff ff ff    	je     d33b <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x5b>
    d425:	89 de                	mov    esi,ebx
    d427:	e9 f1 fe ff ff       	jmp    d31d <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x3d>
    d42c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d430:	83 ec 0c             	sub    esp,0xc
    d433:	8d 73 02             	lea    esi,[ebx+0x2]
    d436:	6a 25                	push   0x25
    d438:	e8 93 e8 ff ff       	call   bcd0 <_Z7putcharc>
    d43d:	0f be 44 1d 02       	movsx  eax,BYTE PTR [ebp+ebx*1+0x2]
    d442:	83 c4 10             	add    esp,0x10
    d445:	84 c0                	test   al,al
    d447:	0f 84 ee fe ff ff    	je     d33b <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x5b>
    d44d:	89 f3                	mov    ebx,esi
    d44f:	e9 41 ff ff ff       	jmp    d395 <_Z6printfIPKcJPcEEvS1_T_DpT0_+0xb5>
    d454:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d458:	83 ec 0c             	sub    esp,0xc
    d45b:	8d 7c 1d 02          	lea    edi,[ebp+ebx*1+0x2]
    d45f:	ff 74 24 34          	push   DWORD PTR [esp+0x34]
    d463:	e8 28 e9 ff ff       	call   bd90 <_Z6putstrPc>
    d468:	83 c4 10             	add    esp,0x10
    d46b:	eb 80                	jmp    d3ed <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x10d>
    d46d:	8d 76 00             	lea    esi,[esi+0x0]
    d470:	83 ec 0c             	sub    esp,0xc
    d473:	8d 7c 1d 02          	lea    edi,[ebp+ebx*1+0x2]
    d477:	ff 74 24 34          	push   DWORD PTR [esp+0x34]
    d47b:	e8 a0 e8 ff ff       	call   bd20 <_Z6putbini>
    d480:	83 c4 10             	add    esp,0x10
    d483:	e9 65 ff ff ff       	jmp    d3ed <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x10d>
    d488:	90                   	nop
    d489:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d490:	83 ec 0c             	sub    esp,0xc
    d493:	8d 7c 1d 02          	lea    edi,[ebp+ebx*1+0x2]
    d497:	ff 74 24 34          	push   DWORD PTR [esp+0x34]
    d49b:	e8 70 e8 ff ff       	call   bd10 <_Z6putocti>
    d4a0:	83 c4 10             	add    esp,0x10
    d4a3:	e9 45 ff ff ff       	jmp    d3ed <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x10d>
    d4a8:	90                   	nop
    d4a9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d4b0:	83 ec 0c             	sub    esp,0xc
    d4b3:	8d 7c 1d 02          	lea    edi,[ebp+ebx*1+0x2]
    d4b7:	ff 74 24 34          	push   DWORD PTR [esp+0x34]
    d4bb:	e8 30 e8 ff ff       	call   bcf0 <_Z6puthexi>
    d4c0:	83 c4 10             	add    esp,0x10
    d4c3:	e9 25 ff ff ff       	jmp    d3ed <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x10d>
    d4c8:	90                   	nop
    d4c9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d4d0:	83 ec 0c             	sub    esp,0xc
    d4d3:	8d 7c 1d 02          	lea    edi,[ebp+ebx*1+0x2]
    d4d7:	ff 74 24 34          	push   DWORD PTR [esp+0x34]
    d4db:	e8 00 e8 ff ff       	call   bce0 <_Z6putdeci>
    d4e0:	83 c4 10             	add    esp,0x10
    d4e3:	e9 05 ff ff ff       	jmp    d3ed <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x10d>
    d4e8:	90                   	nop
    d4e9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d4f0:	83 ec 0c             	sub    esp,0xc
    d4f3:	8d 7c 1d 02          	lea    edi,[ebp+ebx*1+0x2]
    d4f7:	68 64 01 01 00       	push   0x10164
    d4fc:	e8 cf e8 ff ff       	call   bdd0 <_Z6printfPKc>
    d501:	58                   	pop    eax
    d502:	ff 74 24 34          	push   DWORD PTR [esp+0x34]
    d506:	e8 e5 e7 ff ff       	call   bcf0 <_Z6puthexi>
    d50b:	83 c4 10             	add    esp,0x10
    d50e:	e9 da fe ff ff       	jmp    d3ed <_Z6printfIPKcJPcEEvS1_T_DpT0_+0x10d>

Disassembly of section .text._Z6printfIPKcJiS1_PcEEvS1_T_DpT0_:

0000d520 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_>:
    d520:	55                   	push   ebp
    d521:	57                   	push   edi
    d522:	56                   	push   esi
    d523:	53                   	push   ebx
    d524:	31 f6                	xor    esi,esi
    d526:	83 ec 1c             	sub    esp,0x1c
    d529:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    d52d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d531:	84 c0                	test   al,al
    d533:	74 46                	je     d57b <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x5b>
    d535:	8d 5e 01             	lea    ebx,[esi+0x1]
    d538:	3c 25                	cmp    al,0x25
    d53a:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d53e:	75 28                	jne    d568 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x48>
    d540:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    d543:	3c 25                	cmp    al,0x25
    d545:	0f 84 f5 00 00 00    	je     d640 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x120>
    d54b:	84 c0                	test   al,al
    d54d:	75 39                	jne    d588 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x68>
    d54f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d554:	8d 5e 02             	lea    ebx,[esi+0x2]
    d557:	84 c0                	test   al,al
    d559:	74 20                	je     d57b <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x5b>
    d55b:	89 de                	mov    esi,ebx
    d55d:	8d 5e 01             	lea    ebx,[esi+0x1]
    d560:	3c 25                	cmp    al,0x25
    d562:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d566:	74 d8                	je     d540 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x20>
    d568:	83 ec 0c             	sub    esp,0xc
    d56b:	50                   	push   eax
    d56c:	e8 5f e7 ff ff       	call   bcd0 <_Z7putcharc>
    d571:	0f be 07             	movsx  eax,BYTE PTR [edi]
    d574:	83 c4 10             	add    esp,0x10
    d577:	84 c0                	test   al,al
    d579:	75 e0                	jne    d55b <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x3b>
    d57b:	83 c4 1c             	add    esp,0x1c
    d57e:	5b                   	pop    ebx
    d57f:	5e                   	pop    esi
    d580:	5f                   	pop    edi
    d581:	5d                   	pop    ebp
    d582:	c3                   	ret    
    d583:	90                   	nop
    d584:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d588:	83 ec 08             	sub    esp,0x8
    d58b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    d58f:	50                   	push   eax
    d590:	57                   	push   edi
    d591:	e8 3a f9 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    d596:	01 c3                	add    ebx,eax
    d598:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    d59c:	01 eb                	add    ebx,ebp
    d59e:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    d5a2:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    d5a5:	83 c4 10             	add    esp,0x10
    d5a8:	84 c0                	test   al,al
    d5aa:	74 cf                	je     d57b <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x5b>
    d5ac:	31 ff                	xor    edi,edi
    d5ae:	3c 25                	cmp    al,0x25
    d5b0:	8d 77 01             	lea    esi,[edi+0x1]
    d5b3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d5b6:	75 30                	jne    d5e8 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0xc8>
    d5b8:	90                   	nop
    d5b9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d5c0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    d5c4:	3c 25                	cmp    al,0x25
    d5c6:	0f 84 9c 00 00 00    	je     d668 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x148>
    d5cc:	84 c0                	test   al,al
    d5ce:	75 38                	jne    d608 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0xe8>
    d5d0:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    d5d5:	8d 77 02             	lea    esi,[edi+0x2]
    d5d8:	84 c0                	test   al,al
    d5da:	74 9f                	je     d57b <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x5b>
    d5dc:	89 f7                	mov    edi,esi
    d5de:	8d 77 01             	lea    esi,[edi+0x1]
    d5e1:	3c 25                	cmp    al,0x25
    d5e3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d5e6:	74 d8                	je     d5c0 <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0xa0>
    d5e8:	83 ec 0c             	sub    esp,0xc
    d5eb:	50                   	push   eax
    d5ec:	e8 df e6 ff ff       	call   bcd0 <_Z7putcharc>
    d5f1:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d5f5:	83 c4 10             	add    esp,0x10
    d5f8:	84 c0                	test   al,al
    d5fa:	0f 84 7b ff ff ff    	je     d57b <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x5b>
    d600:	89 f7                	mov    edi,esi
    d602:	eb da                	jmp    d5de <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0xbe>
    d604:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d608:	83 ec 08             	sub    esp,0x8
    d60b:	8d 44 24 14          	lea    eax,[esp+0x14]
    d60f:	50                   	push   eax
    d610:	55                   	push   ebp
    d611:	e8 ba f9 ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    d616:	01 c6                	add    esi,eax
    d618:	83 c4 0c             	add    esp,0xc
    d61b:	01 f3                	add    ebx,esi
    d61d:	ff 74 24 44          	push   DWORD PTR [esp+0x44]
    d621:	ff 74 24 44          	push   DWORD PTR [esp+0x44]
    d625:	53                   	push   ebx
    d626:	e8 b5 fc ff ff       	call   d2e0 <_Z6printfIPKcJPcEEvS1_T_DpT0_>
    d62b:	83 c4 10             	add    esp,0x10
    d62e:	83 c4 1c             	add    esp,0x1c
    d631:	5b                   	pop    ebx
    d632:	5e                   	pop    esi
    d633:	5f                   	pop    edi
    d634:	5d                   	pop    ebp
    d635:	c3                   	ret    
    d636:	8d 76 00             	lea    esi,[esi+0x0]
    d639:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    d640:	83 ec 0c             	sub    esp,0xc
    d643:	8d 5e 02             	lea    ebx,[esi+0x2]
    d646:	6a 25                	push   0x25
    d648:	e8 83 e6 ff ff       	call   bcd0 <_Z7putcharc>
    d64d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d652:	83 c4 10             	add    esp,0x10
    d655:	84 c0                	test   al,al
    d657:	0f 84 1e ff ff ff    	je     d57b <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x5b>
    d65d:	89 de                	mov    esi,ebx
    d65f:	e9 f9 fe ff ff       	jmp    d55d <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x3d>
    d664:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d668:	83 ec 0c             	sub    esp,0xc
    d66b:	8d 77 02             	lea    esi,[edi+0x2]
    d66e:	6a 25                	push   0x25
    d670:	e8 5b e6 ff ff       	call   bcd0 <_Z7putcharc>
    d675:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    d67a:	83 c4 10             	add    esp,0x10
    d67d:	84 c0                	test   al,al
    d67f:	0f 84 f6 fe ff ff    	je     d57b <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0x5b>
    d685:	89 f7                	mov    edi,esi
    d687:	e9 52 ff ff ff       	jmp    d5de <_Z6printfIPKcJiS1_PcEEvS1_T_DpT0_+0xbe>

Disassembly of section .text._Z14_manage_escapeIjEiPKcPT_:

0000d690 <_Z14_manage_escapeIjEiPKcPT_>:
    d690:	83 ec 0c             	sub    esp,0xc
    d693:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    d697:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    d69a:	83 e8 42             	sub    eax,0x42
    d69d:	3c 36                	cmp    al,0x36
    d69f:	0f 87 db 00 00 00    	ja     d780 <_Z14_manage_escapeIjEiPKcPT_+0xf0>
    d6a5:	0f b6 c0             	movzx  eax,al
    d6a8:	ff 24 85 f4 0a 01 00 	jmp    DWORD PTR [eax*4+0x10af4]
    d6af:	90                   	nop
    d6b0:	83 ec 0c             	sub    esp,0xc
    d6b3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d6b7:	ff 30                	push   DWORD PTR [eax]
    d6b9:	e8 d2 e6 ff ff       	call   bd90 <_Z6putstrPc>
    d6be:	83 c4 10             	add    esp,0x10
    d6c1:	b8 01 00 00 00       	mov    eax,0x1
    d6c6:	83 c4 0c             	add    esp,0xc
    d6c9:	c3                   	ret    
    d6ca:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d6d0:	83 ec 0c             	sub    esp,0xc
    d6d3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d6d7:	ff 30                	push   DWORD PTR [eax]
    d6d9:	e8 42 e6 ff ff       	call   bd20 <_Z6putbini>
    d6de:	83 c4 10             	add    esp,0x10
    d6e1:	b8 01 00 00 00       	mov    eax,0x1
    d6e6:	83 c4 0c             	add    esp,0xc
    d6e9:	c3                   	ret    
    d6ea:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d6f0:	83 ec 0c             	sub    esp,0xc
    d6f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d6f7:	ff 30                	push   DWORD PTR [eax]
    d6f9:	e8 12 e6 ff ff       	call   bd10 <_Z6putocti>
    d6fe:	83 c4 10             	add    esp,0x10
    d701:	b8 01 00 00 00       	mov    eax,0x1
    d706:	83 c4 0c             	add    esp,0xc
    d709:	c3                   	ret    
    d70a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d710:	83 ec 0c             	sub    esp,0xc
    d713:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d717:	ff 30                	push   DWORD PTR [eax]
    d719:	e8 d2 e5 ff ff       	call   bcf0 <_Z6puthexi>
    d71e:	83 c4 10             	add    esp,0x10
    d721:	b8 01 00 00 00       	mov    eax,0x1
    d726:	83 c4 0c             	add    esp,0xc
    d729:	c3                   	ret    
    d72a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d730:	83 ec 0c             	sub    esp,0xc
    d733:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d737:	0f be 00             	movsx  eax,BYTE PTR [eax]
    d73a:	50                   	push   eax
    d73b:	e8 90 e5 ff ff       	call   bcd0 <_Z7putcharc>
    d740:	83 c4 10             	add    esp,0x10
    d743:	b8 01 00 00 00       	mov    eax,0x1
    d748:	83 c4 0c             	add    esp,0xc
    d74b:	c3                   	ret    
    d74c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d750:	83 ec 0c             	sub    esp,0xc
    d753:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    d757:	ff 30                	push   DWORD PTR [eax]
    d759:	e8 82 e5 ff ff       	call   bce0 <_Z6putdeci>
    d75e:	83 c4 10             	add    esp,0x10
    d761:	b8 01 00 00 00       	mov    eax,0x1
    d766:	83 c4 0c             	add    esp,0xc
    d769:	c3                   	ret    
    d76a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    d770:	83 ec 0c             	sub    esp,0xc
    d773:	68 64 01 01 00       	push   0x10164
    d778:	e8 53 e6 ff ff       	call   bdd0 <_Z6printfPKc>
    d77d:	58                   	pop    eax
    d77e:	eb 93                	jmp    d713 <_Z14_manage_escapeIjEiPKcPT_+0x83>
    d780:	31 c0                	xor    eax,eax
    d782:	e9 3f ff ff ff       	jmp    d6c6 <_Z14_manage_escapeIjEiPKcPT_+0x36>

Disassembly of section .text._Z6printfIjJEEvPKcT_DpT0_:

0000d790 <_Z6printfIjJEEvPKcT_DpT0_>:
    d790:	55                   	push   ebp
    d791:	57                   	push   edi
    d792:	56                   	push   esi
    d793:	53                   	push   ebx
    d794:	31 f6                	xor    esi,esi
    d796:	83 ec 0c             	sub    esp,0xc
    d799:	8b 6c 24 20          	mov    ebp,DWORD PTR [esp+0x20]
    d79d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d7a1:	84 c0                	test   al,al
    d7a3:	74 42                	je     d7e7 <_Z6printfIjJEEvPKcT_DpT0_+0x57>
    d7a5:	8d 5e 01             	lea    ebx,[esi+0x1]
    d7a8:	3c 25                	cmp    al,0x25
    d7aa:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d7ae:	75 24                	jne    d7d4 <_Z6printfIjJEEvPKcT_DpT0_+0x44>
    d7b0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    d7b3:	3c 25                	cmp    al,0x25
    d7b5:	74 61                	je     d818 <_Z6printfIjJEEvPKcT_DpT0_+0x88>
    d7b7:	84 c0                	test   al,al
    d7b9:	75 35                	jne    d7f0 <_Z6printfIjJEEvPKcT_DpT0_+0x60>
    d7bb:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d7c0:	8d 5e 02             	lea    ebx,[esi+0x2]
    d7c3:	84 c0                	test   al,al
    d7c5:	74 20                	je     d7e7 <_Z6printfIjJEEvPKcT_DpT0_+0x57>
    d7c7:	89 de                	mov    esi,ebx
    d7c9:	8d 5e 01             	lea    ebx,[esi+0x1]
    d7cc:	3c 25                	cmp    al,0x25
    d7ce:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d7d2:	74 dc                	je     d7b0 <_Z6printfIjJEEvPKcT_DpT0_+0x20>
    d7d4:	83 ec 0c             	sub    esp,0xc
    d7d7:	50                   	push   eax
    d7d8:	e8 f3 e4 ff ff       	call   bcd0 <_Z7putcharc>
    d7dd:	0f be 07             	movsx  eax,BYTE PTR [edi]
    d7e0:	83 c4 10             	add    esp,0x10
    d7e3:	84 c0                	test   al,al
    d7e5:	75 e0                	jne    d7c7 <_Z6printfIjJEEvPKcT_DpT0_+0x37>
    d7e7:	83 c4 0c             	add    esp,0xc
    d7ea:	5b                   	pop    ebx
    d7eb:	5e                   	pop    esi
    d7ec:	5f                   	pop    edi
    d7ed:	5d                   	pop    ebp
    d7ee:	c3                   	ret    
    d7ef:	90                   	nop
    d7f0:	83 ec 08             	sub    esp,0x8
    d7f3:	8d 44 24 2c          	lea    eax,[esp+0x2c]
    d7f7:	50                   	push   eax
    d7f8:	57                   	push   edi
    d7f9:	e8 92 fe ff ff       	call   d690 <_Z14_manage_escapeIjEiPKcPT_>
    d7fe:	01 c3                	add    ebx,eax
    d800:	01 dd                	add    ebp,ebx
    d802:	89 2c 24             	mov    DWORD PTR [esp],ebp
    d805:	e8 c6 e5 ff ff       	call   bdd0 <_Z6printfPKc>
    d80a:	83 c4 10             	add    esp,0x10
    d80d:	83 c4 0c             	add    esp,0xc
    d810:	5b                   	pop    ebx
    d811:	5e                   	pop    esi
    d812:	5f                   	pop    edi
    d813:	5d                   	pop    ebp
    d814:	c3                   	ret    
    d815:	8d 76 00             	lea    esi,[esi+0x0]
    d818:	83 ec 0c             	sub    esp,0xc
    d81b:	8d 5e 02             	lea    ebx,[esi+0x2]
    d81e:	6a 25                	push   0x25
    d820:	e8 ab e4 ff ff       	call   bcd0 <_Z7putcharc>
    d825:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d82a:	83 c4 10             	add    esp,0x10
    d82d:	84 c0                	test   al,al
    d82f:	74 b6                	je     d7e7 <_Z6printfIjJEEvPKcT_DpT0_+0x57>
    d831:	89 de                	mov    esi,ebx
    d833:	eb 94                	jmp    d7c9 <_Z6printfIjJEEvPKcT_DpT0_+0x39>

Disassembly of section .text._Z6printfIPKcJiS1_jEEvS1_T_DpT0_:

0000d840 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_>:
    d840:	55                   	push   ebp
    d841:	57                   	push   edi
    d842:	56                   	push   esi
    d843:	53                   	push   ebx
    d844:	31 f6                	xor    esi,esi
    d846:	83 ec 1c             	sub    esp,0x1c
    d849:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    d84d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d851:	84 c0                	test   al,al
    d853:	74 46                	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    d855:	8d 5e 01             	lea    ebx,[esi+0x1]
    d858:	3c 25                	cmp    al,0x25
    d85a:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d85e:	75 28                	jne    d888 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x48>
    d860:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    d863:	3c 25                	cmp    al,0x25
    d865:	0f 84 45 01 00 00    	je     d9b0 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x170>
    d86b:	84 c0                	test   al,al
    d86d:	75 39                	jne    d8a8 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x68>
    d86f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d874:	8d 5e 02             	lea    ebx,[esi+0x2]
    d877:	84 c0                	test   al,al
    d879:	74 20                	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    d87b:	89 de                	mov    esi,ebx
    d87d:	8d 5e 01             	lea    ebx,[esi+0x1]
    d880:	3c 25                	cmp    al,0x25
    d882:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    d886:	74 d8                	je     d860 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x20>
    d888:	83 ec 0c             	sub    esp,0xc
    d88b:	50                   	push   eax
    d88c:	e8 3f e4 ff ff       	call   bcd0 <_Z7putcharc>
    d891:	0f be 07             	movsx  eax,BYTE PTR [edi]
    d894:	83 c4 10             	add    esp,0x10
    d897:	84 c0                	test   al,al
    d899:	75 e0                	jne    d87b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x3b>
    d89b:	83 c4 1c             	add    esp,0x1c
    d89e:	5b                   	pop    ebx
    d89f:	5e                   	pop    esi
    d8a0:	5f                   	pop    edi
    d8a1:	5d                   	pop    ebp
    d8a2:	c3                   	ret    
    d8a3:	90                   	nop
    d8a4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d8a8:	83 ec 08             	sub    esp,0x8
    d8ab:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    d8af:	50                   	push   eax
    d8b0:	57                   	push   edi
    d8b1:	31 ff                	xor    edi,edi
    d8b3:	e8 18 f6 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    d8b8:	01 c3                	add    ebx,eax
    d8ba:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    d8be:	01 eb                	add    ebx,ebp
    d8c0:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    d8c4:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    d8c7:	83 c4 10             	add    esp,0x10
    d8ca:	84 c0                	test   al,al
    d8cc:	74 cd                	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    d8ce:	8d 77 01             	lea    esi,[edi+0x1]
    d8d1:	3c 25                	cmp    al,0x25
    d8d3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d8d6:	75 30                	jne    d908 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0xc8>
    d8d8:	90                   	nop
    d8d9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d8e0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    d8e4:	3c 25                	cmp    al,0x25
    d8e6:	0f 84 1c 01 00 00    	je     da08 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x1c8>
    d8ec:	84 c0                	test   al,al
    d8ee:	75 38                	jne    d928 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0xe8>
    d8f0:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    d8f5:	8d 77 02             	lea    esi,[edi+0x2]
    d8f8:	84 c0                	test   al,al
    d8fa:	74 9f                	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    d8fc:	89 f7                	mov    edi,esi
    d8fe:	8d 77 01             	lea    esi,[edi+0x1]
    d901:	3c 25                	cmp    al,0x25
    d903:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    d906:	74 d8                	je     d8e0 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0xa0>
    d908:	83 ec 0c             	sub    esp,0xc
    d90b:	50                   	push   eax
    d90c:	e8 bf e3 ff ff       	call   bcd0 <_Z7putcharc>
    d911:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d915:	83 c4 10             	add    esp,0x10
    d918:	84 c0                	test   al,al
    d91a:	0f 84 7b ff ff ff    	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    d920:	89 f7                	mov    edi,esi
    d922:	eb da                	jmp    d8fe <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0xbe>
    d924:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d928:	83 ec 08             	sub    esp,0x8
    d92b:	8d 44 24 10          	lea    eax,[esp+0x10]
    d92f:	50                   	push   eax
    d930:	55                   	push   ebp
    d931:	e8 9a f6 ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    d936:	01 c6                	add    esi,eax
    d938:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    d93c:	01 de                	add    esi,ebx
    d93e:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    d942:	0f be 06             	movsx  eax,BYTE PTR [esi]
    d945:	83 c4 10             	add    esp,0x10
    d948:	84 c0                	test   al,al
    d94a:	0f 84 4b ff ff ff    	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    d950:	31 ff                	xor    edi,edi
    d952:	3c 25                	cmp    al,0x25
    d954:	8d 5f 01             	lea    ebx,[edi+0x1]
    d957:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    d95a:	75 30                	jne    d98c <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x14c>
    d95c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d960:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    d964:	3c 25                	cmp    al,0x25
    d966:	0f 84 c4 00 00 00    	je     da30 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x1f0>
    d96c:	84 c0                	test   al,al
    d96e:	75 68                	jne    d9d8 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x198>
    d970:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    d975:	8d 5f 02             	lea    ebx,[edi+0x2]
    d978:	84 c0                	test   al,al
    d97a:	0f 84 1b ff ff ff    	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    d980:	89 df                	mov    edi,ebx
    d982:	8d 5f 01             	lea    ebx,[edi+0x1]
    d985:	3c 25                	cmp    al,0x25
    d987:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    d98a:	74 d4                	je     d960 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x120>
    d98c:	83 ec 0c             	sub    esp,0xc
    d98f:	50                   	push   eax
    d990:	e8 3b e3 ff ff       	call   bcd0 <_Z7putcharc>
    d995:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    d999:	83 c4 10             	add    esp,0x10
    d99c:	84 c0                	test   al,al
    d99e:	0f 84 f7 fe ff ff    	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    d9a4:	89 df                	mov    edi,ebx
    d9a6:	eb da                	jmp    d982 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x142>
    d9a8:	90                   	nop
    d9a9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    d9b0:	83 ec 0c             	sub    esp,0xc
    d9b3:	8d 5e 02             	lea    ebx,[esi+0x2]
    d9b6:	6a 25                	push   0x25
    d9b8:	e8 13 e3 ff ff       	call   bcd0 <_Z7putcharc>
    d9bd:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    d9c2:	83 c4 10             	add    esp,0x10
    d9c5:	84 c0                	test   al,al
    d9c7:	0f 84 ce fe ff ff    	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    d9cd:	89 de                	mov    esi,ebx
    d9cf:	e9 a9 fe ff ff       	jmp    d87d <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x3d>
    d9d4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    d9d8:	83 ec 08             	sub    esp,0x8
    d9db:	8d 44 24 14          	lea    eax,[esp+0x14]
    d9df:	50                   	push   eax
    d9e0:	55                   	push   ebp
    d9e1:	e8 ea f4 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    d9e6:	5a                   	pop    edx
    d9e7:	01 c3                	add    ebx,eax
    d9e9:	59                   	pop    ecx
    d9ea:	01 f3                	add    ebx,esi
    d9ec:	ff 74 24 48          	push   DWORD PTR [esp+0x48]
    d9f0:	53                   	push   ebx
    d9f1:	e8 9a fd ff ff       	call   d790 <_Z6printfIjJEEvPKcT_DpT0_>
    d9f6:	83 c4 10             	add    esp,0x10
    d9f9:	83 c4 1c             	add    esp,0x1c
    d9fc:	5b                   	pop    ebx
    d9fd:	5e                   	pop    esi
    d9fe:	5f                   	pop    edi
    d9ff:	5d                   	pop    ebp
    da00:	c3                   	ret    
    da01:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    da08:	83 ec 0c             	sub    esp,0xc
    da0b:	8d 77 02             	lea    esi,[edi+0x2]
    da0e:	6a 25                	push   0x25
    da10:	e8 bb e2 ff ff       	call   bcd0 <_Z7putcharc>
    da15:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    da1a:	83 c4 10             	add    esp,0x10
    da1d:	84 c0                	test   al,al
    da1f:	0f 84 76 fe ff ff    	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    da25:	89 f7                	mov    edi,esi
    da27:	e9 d2 fe ff ff       	jmp    d8fe <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0xbe>
    da2c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    da30:	83 ec 0c             	sub    esp,0xc
    da33:	8d 5f 02             	lea    ebx,[edi+0x2]
    da36:	6a 25                	push   0x25
    da38:	e8 93 e2 ff ff       	call   bcd0 <_Z7putcharc>
    da3d:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    da42:	83 c4 10             	add    esp,0x10
    da45:	84 c0                	test   al,al
    da47:	0f 84 4e fe ff ff    	je     d89b <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x5b>
    da4d:	89 df                	mov    edi,ebx
    da4f:	e9 2e ff ff ff       	jmp    d982 <_Z6printfIPKcJiS1_jEEvS1_T_DpT0_+0x142>

Disassembly of section .text._Z6printfIjJjEEvPKcT_DpT0_:

0000da60 <_Z6printfIjJjEEvPKcT_DpT0_>:
    da60:	55                   	push   ebp
    da61:	57                   	push   edi
    da62:	56                   	push   esi
    da63:	53                   	push   ebx
    da64:	31 f6                	xor    esi,esi
    da66:	83 ec 0c             	sub    esp,0xc
    da69:	8b 6c 24 20          	mov    ebp,DWORD PTR [esp+0x20]
    da6d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    da71:	84 c0                	test   al,al
    da73:	74 42                	je     dab7 <_Z6printfIjJjEEvPKcT_DpT0_+0x57>
    da75:	8d 5e 01             	lea    ebx,[esi+0x1]
    da78:	3c 25                	cmp    al,0x25
    da7a:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    da7e:	75 24                	jne    daa4 <_Z6printfIjJjEEvPKcT_DpT0_+0x44>
    da80:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    da83:	3c 25                	cmp    al,0x25
    da85:	74 69                	je     daf0 <_Z6printfIjJjEEvPKcT_DpT0_+0x90>
    da87:	84 c0                	test   al,al
    da89:	75 35                	jne    dac0 <_Z6printfIjJjEEvPKcT_DpT0_+0x60>
    da8b:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    da90:	8d 5e 02             	lea    ebx,[esi+0x2]
    da93:	84 c0                	test   al,al
    da95:	74 20                	je     dab7 <_Z6printfIjJjEEvPKcT_DpT0_+0x57>
    da97:	89 de                	mov    esi,ebx
    da99:	8d 5e 01             	lea    ebx,[esi+0x1]
    da9c:	3c 25                	cmp    al,0x25
    da9e:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    daa2:	74 dc                	je     da80 <_Z6printfIjJjEEvPKcT_DpT0_+0x20>
    daa4:	83 ec 0c             	sub    esp,0xc
    daa7:	50                   	push   eax
    daa8:	e8 23 e2 ff ff       	call   bcd0 <_Z7putcharc>
    daad:	0f be 07             	movsx  eax,BYTE PTR [edi]
    dab0:	83 c4 10             	add    esp,0x10
    dab3:	84 c0                	test   al,al
    dab5:	75 e0                	jne    da97 <_Z6printfIjJjEEvPKcT_DpT0_+0x37>
    dab7:	83 c4 0c             	add    esp,0xc
    daba:	5b                   	pop    ebx
    dabb:	5e                   	pop    esi
    dabc:	5f                   	pop    edi
    dabd:	5d                   	pop    ebp
    dabe:	c3                   	ret    
    dabf:	90                   	nop
    dac0:	83 ec 08             	sub    esp,0x8
    dac3:	8d 44 24 2c          	lea    eax,[esp+0x2c]
    dac7:	50                   	push   eax
    dac8:	57                   	push   edi
    dac9:	e8 c2 fb ff ff       	call   d690 <_Z14_manage_escapeIjEiPKcPT_>
    dace:	5a                   	pop    edx
    dacf:	01 c3                	add    ebx,eax
    dad1:	59                   	pop    ecx
    dad2:	01 dd                	add    ebp,ebx
    dad4:	ff 74 24 30          	push   DWORD PTR [esp+0x30]
    dad8:	55                   	push   ebp
    dad9:	e8 b2 fc ff ff       	call   d790 <_Z6printfIjJEEvPKcT_DpT0_>
    dade:	83 c4 10             	add    esp,0x10
    dae1:	83 c4 0c             	add    esp,0xc
    dae4:	5b                   	pop    ebx
    dae5:	5e                   	pop    esi
    dae6:	5f                   	pop    edi
    dae7:	5d                   	pop    ebp
    dae8:	c3                   	ret    
    dae9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    daf0:	83 ec 0c             	sub    esp,0xc
    daf3:	8d 5e 02             	lea    ebx,[esi+0x2]
    daf6:	6a 25                	push   0x25
    daf8:	e8 d3 e1 ff ff       	call   bcd0 <_Z7putcharc>
    dafd:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    db02:	83 c4 10             	add    esp,0x10
    db05:	84 c0                	test   al,al
    db07:	74 ae                	je     dab7 <_Z6printfIjJjEEvPKcT_DpT0_+0x57>
    db09:	89 de                	mov    esi,ebx
    db0b:	eb 8c                	jmp    da99 <_Z6printfIjJjEEvPKcT_DpT0_+0x39>

Disassembly of section .text._Z6printfIPKcJiS1_jjEEvS1_T_DpT0_:

0000db10 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_>:
    db10:	55                   	push   ebp
    db11:	57                   	push   edi
    db12:	56                   	push   esi
    db13:	53                   	push   ebx
    db14:	31 f6                	xor    esi,esi
    db16:	83 ec 1c             	sub    esp,0x1c
    db19:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    db1d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    db21:	84 c0                	test   al,al
    db23:	74 46                	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    db25:	8d 5e 01             	lea    ebx,[esi+0x1]
    db28:	3c 25                	cmp    al,0x25
    db2a:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    db2e:	75 28                	jne    db58 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x48>
    db30:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    db33:	3c 25                	cmp    al,0x25
    db35:	0f 84 45 01 00 00    	je     dc80 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x170>
    db3b:	84 c0                	test   al,al
    db3d:	75 39                	jne    db78 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x68>
    db3f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    db44:	8d 5e 02             	lea    ebx,[esi+0x2]
    db47:	84 c0                	test   al,al
    db49:	74 20                	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    db4b:	89 de                	mov    esi,ebx
    db4d:	8d 5e 01             	lea    ebx,[esi+0x1]
    db50:	3c 25                	cmp    al,0x25
    db52:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    db56:	74 d8                	je     db30 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x20>
    db58:	83 ec 0c             	sub    esp,0xc
    db5b:	50                   	push   eax
    db5c:	e8 6f e1 ff ff       	call   bcd0 <_Z7putcharc>
    db61:	0f be 07             	movsx  eax,BYTE PTR [edi]
    db64:	83 c4 10             	add    esp,0x10
    db67:	84 c0                	test   al,al
    db69:	75 e0                	jne    db4b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x3b>
    db6b:	83 c4 1c             	add    esp,0x1c
    db6e:	5b                   	pop    ebx
    db6f:	5e                   	pop    esi
    db70:	5f                   	pop    edi
    db71:	5d                   	pop    ebp
    db72:	c3                   	ret    
    db73:	90                   	nop
    db74:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    db78:	83 ec 08             	sub    esp,0x8
    db7b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    db7f:	50                   	push   eax
    db80:	57                   	push   edi
    db81:	31 ff                	xor    edi,edi
    db83:	e8 48 f3 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    db88:	01 c3                	add    ebx,eax
    db8a:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    db8e:	01 eb                	add    ebx,ebp
    db90:	89 44 24 18          	mov    DWORD PTR [esp+0x18],eax
    db94:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    db97:	83 c4 10             	add    esp,0x10
    db9a:	84 c0                	test   al,al
    db9c:	74 cd                	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    db9e:	8d 77 01             	lea    esi,[edi+0x1]
    dba1:	3c 25                	cmp    al,0x25
    dba3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    dba6:	75 30                	jne    dbd8 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0xc8>
    dba8:	90                   	nop
    dba9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    dbb0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    dbb4:	3c 25                	cmp    al,0x25
    dbb6:	0f 84 24 01 00 00    	je     dce0 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x1d0>
    dbbc:	84 c0                	test   al,al
    dbbe:	75 38                	jne    dbf8 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0xe8>
    dbc0:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    dbc5:	8d 77 02             	lea    esi,[edi+0x2]
    dbc8:	84 c0                	test   al,al
    dbca:	74 9f                	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    dbcc:	89 f7                	mov    edi,esi
    dbce:	8d 77 01             	lea    esi,[edi+0x1]
    dbd1:	3c 25                	cmp    al,0x25
    dbd3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    dbd6:	74 d8                	je     dbb0 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0xa0>
    dbd8:	83 ec 0c             	sub    esp,0xc
    dbdb:	50                   	push   eax
    dbdc:	e8 ef e0 ff ff       	call   bcd0 <_Z7putcharc>
    dbe1:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    dbe5:	83 c4 10             	add    esp,0x10
    dbe8:	84 c0                	test   al,al
    dbea:	0f 84 7b ff ff ff    	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    dbf0:	89 f7                	mov    edi,esi
    dbf2:	eb da                	jmp    dbce <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0xbe>
    dbf4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    dbf8:	83 ec 08             	sub    esp,0x8
    dbfb:	8d 44 24 10          	lea    eax,[esp+0x10]
    dbff:	50                   	push   eax
    dc00:	55                   	push   ebp
    dc01:	e8 ca f3 ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    dc06:	01 c6                	add    esi,eax
    dc08:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    dc0c:	01 de                	add    esi,ebx
    dc0e:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    dc12:	0f be 06             	movsx  eax,BYTE PTR [esi]
    dc15:	83 c4 10             	add    esp,0x10
    dc18:	84 c0                	test   al,al
    dc1a:	0f 84 4b ff ff ff    	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    dc20:	31 ff                	xor    edi,edi
    dc22:	3c 25                	cmp    al,0x25
    dc24:	8d 5f 01             	lea    ebx,[edi+0x1]
    dc27:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    dc2a:	75 30                	jne    dc5c <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x14c>
    dc2c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    dc30:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    dc34:	3c 25                	cmp    al,0x25
    dc36:	0f 84 cc 00 00 00    	je     dd08 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x1f8>
    dc3c:	84 c0                	test   al,al
    dc3e:	75 68                	jne    dca8 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x198>
    dc40:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    dc45:	8d 5f 02             	lea    ebx,[edi+0x2]
    dc48:	84 c0                	test   al,al
    dc4a:	0f 84 1b ff ff ff    	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    dc50:	89 df                	mov    edi,ebx
    dc52:	8d 5f 01             	lea    ebx,[edi+0x1]
    dc55:	3c 25                	cmp    al,0x25
    dc57:	8d 2c 1e             	lea    ebp,[esi+ebx*1]
    dc5a:	74 d4                	je     dc30 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x120>
    dc5c:	83 ec 0c             	sub    esp,0xc
    dc5f:	50                   	push   eax
    dc60:	e8 6b e0 ff ff       	call   bcd0 <_Z7putcharc>
    dc65:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    dc69:	83 c4 10             	add    esp,0x10
    dc6c:	84 c0                	test   al,al
    dc6e:	0f 84 f7 fe ff ff    	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    dc74:	89 df                	mov    edi,ebx
    dc76:	eb da                	jmp    dc52 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x142>
    dc78:	90                   	nop
    dc79:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    dc80:	83 ec 0c             	sub    esp,0xc
    dc83:	8d 5e 02             	lea    ebx,[esi+0x2]
    dc86:	6a 25                	push   0x25
    dc88:	e8 43 e0 ff ff       	call   bcd0 <_Z7putcharc>
    dc8d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    dc92:	83 c4 10             	add    esp,0x10
    dc95:	84 c0                	test   al,al
    dc97:	0f 84 ce fe ff ff    	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    dc9d:	89 de                	mov    esi,ebx
    dc9f:	e9 a9 fe ff ff       	jmp    db4d <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x3d>
    dca4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    dca8:	83 ec 08             	sub    esp,0x8
    dcab:	8d 44 24 14          	lea    eax,[esp+0x14]
    dcaf:	50                   	push   eax
    dcb0:	55                   	push   ebp
    dcb1:	e8 1a f2 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    dcb6:	01 c3                	add    ebx,eax
    dcb8:	83 c4 0c             	add    esp,0xc
    dcbb:	01 f3                	add    ebx,esi
    dcbd:	ff 74 24 48          	push   DWORD PTR [esp+0x48]
    dcc1:	ff 74 24 48          	push   DWORD PTR [esp+0x48]
    dcc5:	53                   	push   ebx
    dcc6:	e8 95 fd ff ff       	call   da60 <_Z6printfIjJjEEvPKcT_DpT0_>
    dccb:	83 c4 10             	add    esp,0x10
    dcce:	83 c4 1c             	add    esp,0x1c
    dcd1:	5b                   	pop    ebx
    dcd2:	5e                   	pop    esi
    dcd3:	5f                   	pop    edi
    dcd4:	5d                   	pop    ebp
    dcd5:	c3                   	ret    
    dcd6:	8d 76 00             	lea    esi,[esi+0x0]
    dcd9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    dce0:	83 ec 0c             	sub    esp,0xc
    dce3:	8d 77 02             	lea    esi,[edi+0x2]
    dce6:	6a 25                	push   0x25
    dce8:	e8 e3 df ff ff       	call   bcd0 <_Z7putcharc>
    dced:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    dcf2:	83 c4 10             	add    esp,0x10
    dcf5:	84 c0                	test   al,al
    dcf7:	0f 84 6e fe ff ff    	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    dcfd:	89 f7                	mov    edi,esi
    dcff:	e9 ca fe ff ff       	jmp    dbce <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0xbe>
    dd04:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    dd08:	83 ec 0c             	sub    esp,0xc
    dd0b:	8d 5f 02             	lea    ebx,[edi+0x2]
    dd0e:	6a 25                	push   0x25
    dd10:	e8 bb df ff ff       	call   bcd0 <_Z7putcharc>
    dd15:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    dd1a:	83 c4 10             	add    esp,0x10
    dd1d:	84 c0                	test   al,al
    dd1f:	0f 84 46 fe ff ff    	je     db6b <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x5b>
    dd25:	89 df                	mov    edi,ebx
    dd27:	e9 26 ff ff ff       	jmp    dc52 <_Z6printfIPKcJiS1_jjEEvS1_T_DpT0_+0x142>

Disassembly of section .text._Z6printfIPKcJjjjEEvS1_T_DpT0_:

0000dd30 <_Z6printfIPKcJjjjEEvS1_T_DpT0_>:
    dd30:	55                   	push   ebp
    dd31:	57                   	push   edi
    dd32:	56                   	push   esi
    dd33:	53                   	push   ebx
    dd34:	31 f6                	xor    esi,esi
    dd36:	83 ec 1c             	sub    esp,0x1c
    dd39:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    dd3d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    dd41:	84 c0                	test   al,al
    dd43:	74 46                	je     dd8b <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x5b>
    dd45:	8d 5e 01             	lea    ebx,[esi+0x1]
    dd48:	3c 25                	cmp    al,0x25
    dd4a:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    dd4e:	75 28                	jne    dd78 <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x48>
    dd50:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    dd53:	3c 25                	cmp    al,0x25
    dd55:	0f 84 f5 00 00 00    	je     de50 <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x120>
    dd5b:	84 c0                	test   al,al
    dd5d:	75 39                	jne    dd98 <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x68>
    dd5f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    dd64:	8d 5e 02             	lea    ebx,[esi+0x2]
    dd67:	84 c0                	test   al,al
    dd69:	74 20                	je     dd8b <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x5b>
    dd6b:	89 de                	mov    esi,ebx
    dd6d:	8d 5e 01             	lea    ebx,[esi+0x1]
    dd70:	3c 25                	cmp    al,0x25
    dd72:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    dd76:	74 d8                	je     dd50 <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x20>
    dd78:	83 ec 0c             	sub    esp,0xc
    dd7b:	50                   	push   eax
    dd7c:	e8 4f df ff ff       	call   bcd0 <_Z7putcharc>
    dd81:	0f be 07             	movsx  eax,BYTE PTR [edi]
    dd84:	83 c4 10             	add    esp,0x10
    dd87:	84 c0                	test   al,al
    dd89:	75 e0                	jne    dd6b <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x3b>
    dd8b:	83 c4 1c             	add    esp,0x1c
    dd8e:	5b                   	pop    ebx
    dd8f:	5e                   	pop    esi
    dd90:	5f                   	pop    edi
    dd91:	5d                   	pop    ebp
    dd92:	c3                   	ret    
    dd93:	90                   	nop
    dd94:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    dd98:	83 ec 08             	sub    esp,0x8
    dd9b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    dd9f:	50                   	push   eax
    dda0:	57                   	push   edi
    dda1:	e8 2a f1 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    dda6:	01 c3                	add    ebx,eax
    dda8:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    ddac:	01 eb                	add    ebx,ebp
    ddae:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    ddb2:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    ddb5:	83 c4 10             	add    esp,0x10
    ddb8:	84 c0                	test   al,al
    ddba:	74 cf                	je     dd8b <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x5b>
    ddbc:	31 ff                	xor    edi,edi
    ddbe:	3c 25                	cmp    al,0x25
    ddc0:	8d 77 01             	lea    esi,[edi+0x1]
    ddc3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    ddc6:	75 30                	jne    ddf8 <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0xc8>
    ddc8:	90                   	nop
    ddc9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ddd0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    ddd4:	3c 25                	cmp    al,0x25
    ddd6:	0f 84 9c 00 00 00    	je     de78 <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x148>
    dddc:	84 c0                	test   al,al
    ddde:	75 38                	jne    de18 <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0xe8>
    dde0:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    dde5:	8d 77 02             	lea    esi,[edi+0x2]
    dde8:	84 c0                	test   al,al
    ddea:	74 9f                	je     dd8b <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x5b>
    ddec:	89 f7                	mov    edi,esi
    ddee:	8d 77 01             	lea    esi,[edi+0x1]
    ddf1:	3c 25                	cmp    al,0x25
    ddf3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    ddf6:	74 d8                	je     ddd0 <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0xa0>
    ddf8:	83 ec 0c             	sub    esp,0xc
    ddfb:	50                   	push   eax
    ddfc:	e8 cf de ff ff       	call   bcd0 <_Z7putcharc>
    de01:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    de05:	83 c4 10             	add    esp,0x10
    de08:	84 c0                	test   al,al
    de0a:	0f 84 7b ff ff ff    	je     dd8b <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x5b>
    de10:	89 f7                	mov    edi,esi
    de12:	eb da                	jmp    ddee <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0xbe>
    de14:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    de18:	83 ec 08             	sub    esp,0x8
    de1b:	8d 44 24 14          	lea    eax,[esp+0x14]
    de1f:	50                   	push   eax
    de20:	55                   	push   ebp
    de21:	e8 6a f8 ff ff       	call   d690 <_Z14_manage_escapeIjEiPKcPT_>
    de26:	01 c6                	add    esi,eax
    de28:	83 c4 0c             	add    esp,0xc
    de2b:	01 f3                	add    ebx,esi
    de2d:	ff 74 24 44          	push   DWORD PTR [esp+0x44]
    de31:	ff 74 24 44          	push   DWORD PTR [esp+0x44]
    de35:	53                   	push   ebx
    de36:	e8 25 fc ff ff       	call   da60 <_Z6printfIjJjEEvPKcT_DpT0_>
    de3b:	83 c4 10             	add    esp,0x10
    de3e:	83 c4 1c             	add    esp,0x1c
    de41:	5b                   	pop    ebx
    de42:	5e                   	pop    esi
    de43:	5f                   	pop    edi
    de44:	5d                   	pop    ebp
    de45:	c3                   	ret    
    de46:	8d 76 00             	lea    esi,[esi+0x0]
    de49:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    de50:	83 ec 0c             	sub    esp,0xc
    de53:	8d 5e 02             	lea    ebx,[esi+0x2]
    de56:	6a 25                	push   0x25
    de58:	e8 73 de ff ff       	call   bcd0 <_Z7putcharc>
    de5d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    de62:	83 c4 10             	add    esp,0x10
    de65:	84 c0                	test   al,al
    de67:	0f 84 1e ff ff ff    	je     dd8b <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x5b>
    de6d:	89 de                	mov    esi,ebx
    de6f:	e9 f9 fe ff ff       	jmp    dd6d <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x3d>
    de74:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    de78:	83 ec 0c             	sub    esp,0xc
    de7b:	8d 77 02             	lea    esi,[edi+0x2]
    de7e:	6a 25                	push   0x25
    de80:	e8 4b de ff ff       	call   bcd0 <_Z7putcharc>
    de85:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    de8a:	83 c4 10             	add    esp,0x10
    de8d:	84 c0                	test   al,al
    de8f:	0f 84 f6 fe ff ff    	je     dd8b <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0x5b>
    de95:	89 f7                	mov    edi,esi
    de97:	e9 52 ff ff ff       	jmp    ddee <_Z6printfIPKcJjjjEEvS1_T_DpT0_+0xbe>

Disassembly of section .text._Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_:

0000dea0 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_>:
    dea0:	55                   	push   ebp
    dea1:	57                   	push   edi
    dea2:	56                   	push   esi
    dea3:	53                   	push   ebx
    dea4:	31 f6                	xor    esi,esi
    dea6:	83 ec 1c             	sub    esp,0x1c
    dea9:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    dead:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    deb1:	84 c0                	test   al,al
    deb3:	74 46                	je     defb <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x5b>
    deb5:	8d 5e 01             	lea    ebx,[esi+0x1]
    deb8:	3c 25                	cmp    al,0x25
    deba:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    debe:	75 28                	jne    dee8 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x48>
    dec0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    dec3:	3c 25                	cmp    al,0x25
    dec5:	0f 84 f5 00 00 00    	je     dfc0 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x120>
    decb:	84 c0                	test   al,al
    decd:	75 39                	jne    df08 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x68>
    decf:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    ded4:	8d 5e 02             	lea    ebx,[esi+0x2]
    ded7:	84 c0                	test   al,al
    ded9:	74 20                	je     defb <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x5b>
    dedb:	89 de                	mov    esi,ebx
    dedd:	8d 5e 01             	lea    ebx,[esi+0x1]
    dee0:	3c 25                	cmp    al,0x25
    dee2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    dee6:	74 d8                	je     dec0 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x20>
    dee8:	83 ec 0c             	sub    esp,0xc
    deeb:	50                   	push   eax
    deec:	e8 df dd ff ff       	call   bcd0 <_Z7putcharc>
    def1:	0f be 07             	movsx  eax,BYTE PTR [edi]
    def4:	83 c4 10             	add    esp,0x10
    def7:	84 c0                	test   al,al
    def9:	75 e0                	jne    dedb <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x3b>
    defb:	83 c4 1c             	add    esp,0x1c
    defe:	5b                   	pop    ebx
    deff:	5e                   	pop    esi
    df00:	5f                   	pop    edi
    df01:	5d                   	pop    ebp
    df02:	c3                   	ret    
    df03:	90                   	nop
    df04:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    df08:	83 ec 08             	sub    esp,0x8
    df0b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    df0f:	50                   	push   eax
    df10:	57                   	push   edi
    df11:	e8 ba ef ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    df16:	01 c3                	add    ebx,eax
    df18:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    df1c:	01 eb                	add    ebx,ebp
    df1e:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    df22:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    df25:	83 c4 10             	add    esp,0x10
    df28:	84 c0                	test   al,al
    df2a:	74 cf                	je     defb <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x5b>
    df2c:	31 ff                	xor    edi,edi
    df2e:	3c 25                	cmp    al,0x25
    df30:	8d 77 01             	lea    esi,[edi+0x1]
    df33:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    df36:	75 30                	jne    df68 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0xc8>
    df38:	90                   	nop
    df39:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    df40:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    df44:	3c 25                	cmp    al,0x25
    df46:	0f 84 9c 00 00 00    	je     dfe8 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x148>
    df4c:	84 c0                	test   al,al
    df4e:	75 38                	jne    df88 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0xe8>
    df50:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    df55:	8d 77 02             	lea    esi,[edi+0x2]
    df58:	84 c0                	test   al,al
    df5a:	74 9f                	je     defb <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x5b>
    df5c:	89 f7                	mov    edi,esi
    df5e:	8d 77 01             	lea    esi,[edi+0x1]
    df61:	3c 25                	cmp    al,0x25
    df63:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    df66:	74 d8                	je     df40 <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0xa0>
    df68:	83 ec 0c             	sub    esp,0xc
    df6b:	50                   	push   eax
    df6c:	e8 5f dd ff ff       	call   bcd0 <_Z7putcharc>
    df71:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    df75:	83 c4 10             	add    esp,0x10
    df78:	84 c0                	test   al,al
    df7a:	0f 84 7b ff ff ff    	je     defb <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x5b>
    df80:	89 f7                	mov    edi,esi
    df82:	eb da                	jmp    df5e <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0xbe>
    df84:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    df88:	83 ec 08             	sub    esp,0x8
    df8b:	8d 44 24 14          	lea    eax,[esp+0x14]
    df8f:	50                   	push   eax
    df90:	55                   	push   ebp
    df91:	e8 3a f0 ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    df96:	5a                   	pop    edx
    df97:	01 c6                	add    esi,eax
    df99:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    df9d:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    dfa1:	01 f3                	add    ebx,esi
    dfa3:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    dfa7:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    dfab:	53                   	push   ebx
    dfac:	e8 7f fd ff ff       	call   dd30 <_Z6printfIPKcJjjjEEvS1_T_DpT0_>
    dfb1:	83 c4 20             	add    esp,0x20
    dfb4:	83 c4 1c             	add    esp,0x1c
    dfb7:	5b                   	pop    ebx
    dfb8:	5e                   	pop    esi
    dfb9:	5f                   	pop    edi
    dfba:	5d                   	pop    ebp
    dfbb:	c3                   	ret    
    dfbc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    dfc0:	83 ec 0c             	sub    esp,0xc
    dfc3:	8d 5e 02             	lea    ebx,[esi+0x2]
    dfc6:	6a 25                	push   0x25
    dfc8:	e8 03 dd ff ff       	call   bcd0 <_Z7putcharc>
    dfcd:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    dfd2:	83 c4 10             	add    esp,0x10
    dfd5:	84 c0                	test   al,al
    dfd7:	0f 84 1e ff ff ff    	je     defb <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x5b>
    dfdd:	89 de                	mov    esi,ebx
    dfdf:	e9 f9 fe ff ff       	jmp    dedd <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x3d>
    dfe4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    dfe8:	83 ec 0c             	sub    esp,0xc
    dfeb:	8d 77 02             	lea    esi,[edi+0x2]
    dfee:	6a 25                	push   0x25
    dff0:	e8 db dc ff ff       	call   bcd0 <_Z7putcharc>
    dff5:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    dffa:	83 c4 10             	add    esp,0x10
    dffd:	84 c0                	test   al,al
    dfff:	0f 84 f6 fe ff ff    	je     defb <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0x5b>
    e005:	89 f7                	mov    edi,esi
    e007:	e9 52 ff ff ff       	jmp    df5e <_Z6printfIPKcJiS1_jjjEEvS1_T_DpT0_+0xbe>

Disassembly of section .text._Z6printfIPKcJiEEvS1_T_DpT0_:

0000e010 <_Z6printfIPKcJiEEvS1_T_DpT0_>:
    e010:	55                   	push   ebp
    e011:	57                   	push   edi
    e012:	56                   	push   esi
    e013:	53                   	push   ebx
    e014:	31 f6                	xor    esi,esi
    e016:	83 ec 1c             	sub    esp,0x1c
    e019:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    e01d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    e021:	84 c0                	test   al,al
    e023:	74 46                	je     e06b <_Z6printfIPKcJiEEvS1_T_DpT0_+0x5b>
    e025:	8d 5e 01             	lea    ebx,[esi+0x1]
    e028:	3c 25                	cmp    al,0x25
    e02a:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    e02e:	75 28                	jne    e058 <_Z6printfIPKcJiEEvS1_T_DpT0_+0x48>
    e030:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    e033:	3c 25                	cmp    al,0x25
    e035:	0f 84 e5 00 00 00    	je     e120 <_Z6printfIPKcJiEEvS1_T_DpT0_+0x110>
    e03b:	84 c0                	test   al,al
    e03d:	75 39                	jne    e078 <_Z6printfIPKcJiEEvS1_T_DpT0_+0x68>
    e03f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    e044:	8d 5e 02             	lea    ebx,[esi+0x2]
    e047:	84 c0                	test   al,al
    e049:	74 20                	je     e06b <_Z6printfIPKcJiEEvS1_T_DpT0_+0x5b>
    e04b:	89 de                	mov    esi,ebx
    e04d:	8d 5e 01             	lea    ebx,[esi+0x1]
    e050:	3c 25                	cmp    al,0x25
    e052:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    e056:	74 d8                	je     e030 <_Z6printfIPKcJiEEvS1_T_DpT0_+0x20>
    e058:	83 ec 0c             	sub    esp,0xc
    e05b:	50                   	push   eax
    e05c:	e8 6f dc ff ff       	call   bcd0 <_Z7putcharc>
    e061:	0f be 07             	movsx  eax,BYTE PTR [edi]
    e064:	83 c4 10             	add    esp,0x10
    e067:	84 c0                	test   al,al
    e069:	75 e0                	jne    e04b <_Z6printfIPKcJiEEvS1_T_DpT0_+0x3b>
    e06b:	83 c4 1c             	add    esp,0x1c
    e06e:	5b                   	pop    ebx
    e06f:	5e                   	pop    esi
    e070:	5f                   	pop    edi
    e071:	5d                   	pop    ebp
    e072:	c3                   	ret    
    e073:	90                   	nop
    e074:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e078:	83 ec 08             	sub    esp,0x8
    e07b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    e07f:	50                   	push   eax
    e080:	57                   	push   edi
    e081:	e8 4a ee ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    e086:	01 c3                	add    ebx,eax
    e088:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    e08c:	01 eb                	add    ebx,ebp
    e08e:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    e092:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    e095:	83 c4 10             	add    esp,0x10
    e098:	84 c0                	test   al,al
    e09a:	74 cf                	je     e06b <_Z6printfIPKcJiEEvS1_T_DpT0_+0x5b>
    e09c:	31 ff                	xor    edi,edi
    e09e:	3c 25                	cmp    al,0x25
    e0a0:	8d 77 01             	lea    esi,[edi+0x1]
    e0a3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    e0a6:	75 30                	jne    e0d8 <_Z6printfIPKcJiEEvS1_T_DpT0_+0xc8>
    e0a8:	90                   	nop
    e0a9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e0b0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    e0b4:	3c 25                	cmp    al,0x25
    e0b6:	0f 84 8c 00 00 00    	je     e148 <_Z6printfIPKcJiEEvS1_T_DpT0_+0x138>
    e0bc:	84 c0                	test   al,al
    e0be:	75 38                	jne    e0f8 <_Z6printfIPKcJiEEvS1_T_DpT0_+0xe8>
    e0c0:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    e0c5:	8d 77 02             	lea    esi,[edi+0x2]
    e0c8:	84 c0                	test   al,al
    e0ca:	74 9f                	je     e06b <_Z6printfIPKcJiEEvS1_T_DpT0_+0x5b>
    e0cc:	89 f7                	mov    edi,esi
    e0ce:	8d 77 01             	lea    esi,[edi+0x1]
    e0d1:	3c 25                	cmp    al,0x25
    e0d3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    e0d6:	74 d8                	je     e0b0 <_Z6printfIPKcJiEEvS1_T_DpT0_+0xa0>
    e0d8:	83 ec 0c             	sub    esp,0xc
    e0db:	50                   	push   eax
    e0dc:	e8 ef db ff ff       	call   bcd0 <_Z7putcharc>
    e0e1:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    e0e5:	83 c4 10             	add    esp,0x10
    e0e8:	84 c0                	test   al,al
    e0ea:	0f 84 7b ff ff ff    	je     e06b <_Z6printfIPKcJiEEvS1_T_DpT0_+0x5b>
    e0f0:	89 f7                	mov    edi,esi
    e0f2:	eb da                	jmp    e0ce <_Z6printfIPKcJiEEvS1_T_DpT0_+0xbe>
    e0f4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e0f8:	83 ec 08             	sub    esp,0x8
    e0fb:	8d 44 24 14          	lea    eax,[esp+0x14]
    e0ff:	50                   	push   eax
    e100:	55                   	push   ebp
    e101:	e8 ca ee ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    e106:	01 c6                	add    esi,eax
    e108:	01 f3                	add    ebx,esi
    e10a:	89 1c 24             	mov    DWORD PTR [esp],ebx
    e10d:	e8 be dc ff ff       	call   bdd0 <_Z6printfPKc>
    e112:	83 c4 10             	add    esp,0x10
    e115:	83 c4 1c             	add    esp,0x1c
    e118:	5b                   	pop    ebx
    e119:	5e                   	pop    esi
    e11a:	5f                   	pop    edi
    e11b:	5d                   	pop    ebp
    e11c:	c3                   	ret    
    e11d:	8d 76 00             	lea    esi,[esi+0x0]
    e120:	83 ec 0c             	sub    esp,0xc
    e123:	8d 5e 02             	lea    ebx,[esi+0x2]
    e126:	6a 25                	push   0x25
    e128:	e8 a3 db ff ff       	call   bcd0 <_Z7putcharc>
    e12d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    e132:	83 c4 10             	add    esp,0x10
    e135:	84 c0                	test   al,al
    e137:	0f 84 2e ff ff ff    	je     e06b <_Z6printfIPKcJiEEvS1_T_DpT0_+0x5b>
    e13d:	89 de                	mov    esi,ebx
    e13f:	e9 09 ff ff ff       	jmp    e04d <_Z6printfIPKcJiEEvS1_T_DpT0_+0x3d>
    e144:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e148:	83 ec 0c             	sub    esp,0xc
    e14b:	8d 77 02             	lea    esi,[edi+0x2]
    e14e:	6a 25                	push   0x25
    e150:	e8 7b db ff ff       	call   bcd0 <_Z7putcharc>
    e155:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    e15a:	83 c4 10             	add    esp,0x10
    e15d:	84 c0                	test   al,al
    e15f:	0f 84 06 ff ff ff    	je     e06b <_Z6printfIPKcJiEEvS1_T_DpT0_+0x5b>
    e165:	89 f7                	mov    edi,esi
    e167:	e9 62 ff ff ff       	jmp    e0ce <_Z6printfIPKcJiEEvS1_T_DpT0_+0xbe>

Disassembly of section .text._Z6printfIPKcJiS1_iEEvS1_T_DpT0_:

0000e170 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_>:
    e170:	55                   	push   ebp
    e171:	57                   	push   edi
    e172:	56                   	push   esi
    e173:	53                   	push   ebx
    e174:	31 f6                	xor    esi,esi
    e176:	83 ec 1c             	sub    esp,0x1c
    e179:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    e17d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    e181:	84 c0                	test   al,al
    e183:	74 46                	je     e1cb <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x5b>
    e185:	8d 5e 01             	lea    ebx,[esi+0x1]
    e188:	3c 25                	cmp    al,0x25
    e18a:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    e18e:	75 28                	jne    e1b8 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x48>
    e190:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    e193:	3c 25                	cmp    al,0x25
    e195:	0f 84 f5 00 00 00    	je     e290 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x120>
    e19b:	84 c0                	test   al,al
    e19d:	75 39                	jne    e1d8 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x68>
    e19f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    e1a4:	8d 5e 02             	lea    ebx,[esi+0x2]
    e1a7:	84 c0                	test   al,al
    e1a9:	74 20                	je     e1cb <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x5b>
    e1ab:	89 de                	mov    esi,ebx
    e1ad:	8d 5e 01             	lea    ebx,[esi+0x1]
    e1b0:	3c 25                	cmp    al,0x25
    e1b2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    e1b6:	74 d8                	je     e190 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x20>
    e1b8:	83 ec 0c             	sub    esp,0xc
    e1bb:	50                   	push   eax
    e1bc:	e8 0f db ff ff       	call   bcd0 <_Z7putcharc>
    e1c1:	0f be 07             	movsx  eax,BYTE PTR [edi]
    e1c4:	83 c4 10             	add    esp,0x10
    e1c7:	84 c0                	test   al,al
    e1c9:	75 e0                	jne    e1ab <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x3b>
    e1cb:	83 c4 1c             	add    esp,0x1c
    e1ce:	5b                   	pop    ebx
    e1cf:	5e                   	pop    esi
    e1d0:	5f                   	pop    edi
    e1d1:	5d                   	pop    ebp
    e1d2:	c3                   	ret    
    e1d3:	90                   	nop
    e1d4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e1d8:	83 ec 08             	sub    esp,0x8
    e1db:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    e1df:	50                   	push   eax
    e1e0:	57                   	push   edi
    e1e1:	e8 ea ec ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    e1e6:	01 c3                	add    ebx,eax
    e1e8:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    e1ec:	01 eb                	add    ebx,ebp
    e1ee:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    e1f2:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    e1f5:	83 c4 10             	add    esp,0x10
    e1f8:	84 c0                	test   al,al
    e1fa:	74 cf                	je     e1cb <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x5b>
    e1fc:	31 ff                	xor    edi,edi
    e1fe:	3c 25                	cmp    al,0x25
    e200:	8d 77 01             	lea    esi,[edi+0x1]
    e203:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    e206:	75 30                	jne    e238 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0xc8>
    e208:	90                   	nop
    e209:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e210:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    e214:	3c 25                	cmp    al,0x25
    e216:	0f 84 9c 00 00 00    	je     e2b8 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x148>
    e21c:	84 c0                	test   al,al
    e21e:	75 38                	jne    e258 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0xe8>
    e220:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    e225:	8d 77 02             	lea    esi,[edi+0x2]
    e228:	84 c0                	test   al,al
    e22a:	74 9f                	je     e1cb <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x5b>
    e22c:	89 f7                	mov    edi,esi
    e22e:	8d 77 01             	lea    esi,[edi+0x1]
    e231:	3c 25                	cmp    al,0x25
    e233:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    e236:	74 d8                	je     e210 <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0xa0>
    e238:	83 ec 0c             	sub    esp,0xc
    e23b:	50                   	push   eax
    e23c:	e8 8f da ff ff       	call   bcd0 <_Z7putcharc>
    e241:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    e245:	83 c4 10             	add    esp,0x10
    e248:	84 c0                	test   al,al
    e24a:	0f 84 7b ff ff ff    	je     e1cb <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x5b>
    e250:	89 f7                	mov    edi,esi
    e252:	eb da                	jmp    e22e <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0xbe>
    e254:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e258:	83 ec 08             	sub    esp,0x8
    e25b:	8d 44 24 14          	lea    eax,[esp+0x14]
    e25f:	50                   	push   eax
    e260:	55                   	push   ebp
    e261:	e8 6a ed ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    e266:	01 c6                	add    esi,eax
    e268:	83 c4 0c             	add    esp,0xc
    e26b:	01 f3                	add    ebx,esi
    e26d:	ff 74 24 44          	push   DWORD PTR [esp+0x44]
    e271:	ff 74 24 44          	push   DWORD PTR [esp+0x44]
    e275:	53                   	push   ebx
    e276:	e8 95 fd ff ff       	call   e010 <_Z6printfIPKcJiEEvS1_T_DpT0_>
    e27b:	83 c4 10             	add    esp,0x10
    e27e:	83 c4 1c             	add    esp,0x1c
    e281:	5b                   	pop    ebx
    e282:	5e                   	pop    esi
    e283:	5f                   	pop    edi
    e284:	5d                   	pop    ebp
    e285:	c3                   	ret    
    e286:	8d 76 00             	lea    esi,[esi+0x0]
    e289:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    e290:	83 ec 0c             	sub    esp,0xc
    e293:	8d 5e 02             	lea    ebx,[esi+0x2]
    e296:	6a 25                	push   0x25
    e298:	e8 33 da ff ff       	call   bcd0 <_Z7putcharc>
    e29d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    e2a2:	83 c4 10             	add    esp,0x10
    e2a5:	84 c0                	test   al,al
    e2a7:	0f 84 1e ff ff ff    	je     e1cb <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x5b>
    e2ad:	89 de                	mov    esi,ebx
    e2af:	e9 f9 fe ff ff       	jmp    e1ad <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x3d>
    e2b4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e2b8:	83 ec 0c             	sub    esp,0xc
    e2bb:	8d 77 02             	lea    esi,[edi+0x2]
    e2be:	6a 25                	push   0x25
    e2c0:	e8 0b da ff ff       	call   bcd0 <_Z7putcharc>
    e2c5:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    e2ca:	83 c4 10             	add    esp,0x10
    e2cd:	84 c0                	test   al,al
    e2cf:	0f 84 f6 fe ff ff    	je     e1cb <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0x5b>
    e2d5:	89 f7                	mov    edi,esi
    e2d7:	e9 52 ff ff ff       	jmp    e22e <_Z6printfIPKcJiS1_iEEvS1_T_DpT0_+0xbe>

Disassembly of section .text._Z6printfIPKcJcEEvS1_T_DpT0_:

0000e2e0 <_Z6printfIPKcJcEEvS1_T_DpT0_>:
    e2e0:	55                   	push   ebp
    e2e1:	57                   	push   edi
    e2e2:	56                   	push   esi
    e2e3:	53                   	push   ebx
    e2e4:	31 f6                	xor    esi,esi
    e2e6:	83 ec 2c             	sub    esp,0x2c
    e2e9:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    e2ed:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    e2f1:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    e2f5:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    e2f9:	84 c0                	test   al,al
    e2fb:	74 4e                	je     e34b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x6b>
    e2fd:	8d 7e 01             	lea    edi,[esi+0x1]
    e300:	3c 25                	cmp    al,0x25
    e302:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    e306:	75 30                	jne    e338 <_Z6printfIPKcJcEEvS1_T_DpT0_+0x58>
    e308:	90                   	nop
    e309:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e310:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    e313:	3c 25                	cmp    al,0x25
    e315:	0f 84 05 01 00 00    	je     e420 <_Z6printfIPKcJcEEvS1_T_DpT0_+0x140>
    e31b:	84 c0                	test   al,al
    e31d:	75 39                	jne    e358 <_Z6printfIPKcJcEEvS1_T_DpT0_+0x78>
    e31f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    e324:	8d 7e 02             	lea    edi,[esi+0x2]
    e327:	84 c0                	test   al,al
    e329:	74 20                	je     e34b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x6b>
    e32b:	89 fe                	mov    esi,edi
    e32d:	8d 7e 01             	lea    edi,[esi+0x1]
    e330:	3c 25                	cmp    al,0x25
    e332:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    e336:	74 d8                	je     e310 <_Z6printfIPKcJcEEvS1_T_DpT0_+0x30>
    e338:	83 ec 0c             	sub    esp,0xc
    e33b:	50                   	push   eax
    e33c:	e8 8f d9 ff ff       	call   bcd0 <_Z7putcharc>
    e341:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    e344:	83 c4 10             	add    esp,0x10
    e347:	84 c0                	test   al,al
    e349:	75 e0                	jne    e32b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x4b>
    e34b:	83 c4 2c             	add    esp,0x2c
    e34e:	5b                   	pop    ebx
    e34f:	5e                   	pop    esi
    e350:	5f                   	pop    edi
    e351:	5d                   	pop    ebp
    e352:	c3                   	ret    
    e353:	90                   	nop
    e354:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e358:	83 ec 08             	sub    esp,0x8
    e35b:	8d 44 24 4c          	lea    eax,[esp+0x4c]
    e35f:	50                   	push   eax
    e360:	53                   	push   ebx
    e361:	e8 6a eb ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    e366:	01 c7                	add    edi,eax
    e368:	8b 54 24 1c          	mov    edx,DWORD PTR [esp+0x1c]
    e36c:	01 fd                	add    ebp,edi
    e36e:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    e372:	0f be ca             	movsx  ecx,dl
    e375:	88 54 24 2f          	mov    BYTE PTR [esp+0x2f],dl
    e379:	89 4c 24 1c          	mov    DWORD PTR [esp+0x1c],ecx
    e37d:	83 c4 10             	add    esp,0x10
    e380:	84 c0                	test   al,al
    e382:	74 c7                	je     e34b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x6b>
    e384:	31 ff                	xor    edi,edi
    e386:	3c 25                	cmp    al,0x25
    e388:	8d 5f 01             	lea    ebx,[edi+0x1]
    e38b:	8d 74 1d 00          	lea    esi,[ebp+ebx*1+0x0]
    e38f:	75 2f                	jne    e3c0 <_Z6printfIPKcJcEEvS1_T_DpT0_+0xe0>
    e391:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e398:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    e39b:	3c 25                	cmp    al,0x25
    e39d:	0f 84 a5 00 00 00    	je     e448 <_Z6printfIPKcJcEEvS1_T_DpT0_+0x168>
    e3a3:	84 c0                	test   al,al
    e3a5:	75 39                	jne    e3e0 <_Z6printfIPKcJcEEvS1_T_DpT0_+0x100>
    e3a7:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    e3ac:	8d 5f 02             	lea    ebx,[edi+0x2]
    e3af:	84 c0                	test   al,al
    e3b1:	74 98                	je     e34b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x6b>
    e3b3:	89 df                	mov    edi,ebx
    e3b5:	8d 5f 01             	lea    ebx,[edi+0x1]
    e3b8:	3c 25                	cmp    al,0x25
    e3ba:	8d 74 1d 00          	lea    esi,[ebp+ebx*1+0x0]
    e3be:	74 d8                	je     e398 <_Z6printfIPKcJcEEvS1_T_DpT0_+0xb8>
    e3c0:	83 ec 0c             	sub    esp,0xc
    e3c3:	50                   	push   eax
    e3c4:	e8 07 d9 ff ff       	call   bcd0 <_Z7putcharc>
    e3c9:	0f be 06             	movsx  eax,BYTE PTR [esi]
    e3cc:	83 c4 10             	add    esp,0x10
    e3cf:	84 c0                	test   al,al
    e3d1:	0f 84 74 ff ff ff    	je     e34b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x6b>
    e3d7:	89 df                	mov    edi,ebx
    e3d9:	eb da                	jmp    e3b5 <_Z6printfIPKcJcEEvS1_T_DpT0_+0xd5>
    e3db:	90                   	nop
    e3dc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e3e0:	83 e8 42             	sub    eax,0x42
    e3e3:	3c 36                	cmp    al,0x36
    e3e5:	77 24                	ja     e40b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x12b>
    e3e7:	0f b6 c0             	movzx  eax,al
    e3ea:	ff 24 85 a8 2d 01 00 	jmp    DWORD PTR [eax*4+0x12da8]
    e3f1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e3f8:	83 ec 0c             	sub    esp,0xc
    e3fb:	8d 74 3d 02          	lea    esi,[ebp+edi*1+0x2]
    e3ff:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    e403:	e8 c8 d8 ff ff       	call   bcd0 <_Z7putcharc>
    e408:	83 c4 10             	add    esp,0x10
    e40b:	83 ec 0c             	sub    esp,0xc
    e40e:	56                   	push   esi
    e40f:	e8 bc d9 ff ff       	call   bdd0 <_Z6printfPKc>
    e414:	83 c4 10             	add    esp,0x10
    e417:	83 c4 2c             	add    esp,0x2c
    e41a:	5b                   	pop    ebx
    e41b:	5e                   	pop    esi
    e41c:	5f                   	pop    edi
    e41d:	5d                   	pop    ebp
    e41e:	c3                   	ret    
    e41f:	90                   	nop
    e420:	83 ec 0c             	sub    esp,0xc
    e423:	8d 7e 02             	lea    edi,[esi+0x2]
    e426:	6a 25                	push   0x25
    e428:	e8 a3 d8 ff ff       	call   bcd0 <_Z7putcharc>
    e42d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    e432:	83 c4 10             	add    esp,0x10
    e435:	84 c0                	test   al,al
    e437:	0f 84 0e ff ff ff    	je     e34b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x6b>
    e43d:	89 fe                	mov    esi,edi
    e43f:	e9 e9 fe ff ff       	jmp    e32d <_Z6printfIPKcJcEEvS1_T_DpT0_+0x4d>
    e444:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e448:	83 ec 0c             	sub    esp,0xc
    e44b:	8d 5f 02             	lea    ebx,[edi+0x2]
    e44e:	6a 25                	push   0x25
    e450:	e8 7b d8 ff ff       	call   bcd0 <_Z7putcharc>
    e455:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    e45a:	83 c4 10             	add    esp,0x10
    e45d:	84 c0                	test   al,al
    e45f:	0f 84 e6 fe ff ff    	je     e34b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x6b>
    e465:	89 df                	mov    edi,ebx
    e467:	e9 49 ff ff ff       	jmp    e3b5 <_Z6printfIPKcJcEEvS1_T_DpT0_+0xd5>
    e46c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e470:	83 ec 0c             	sub    esp,0xc
    e473:	8d 74 3d 02          	lea    esi,[ebp+edi*1+0x2]
    e477:	ff 74 24 2b          	push   DWORD PTR [esp+0x2b]
    e47b:	e8 10 d9 ff ff       	call   bd90 <_Z6putstrPc>
    e480:	83 c4 10             	add    esp,0x10
    e483:	eb 86                	jmp    e40b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x12b>
    e485:	8d 76 00             	lea    esi,[esi+0x0]
    e488:	83 ec 0c             	sub    esp,0xc
    e48b:	8d 74 3d 02          	lea    esi,[ebp+edi*1+0x2]
    e48f:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    e493:	e8 88 d8 ff ff       	call   bd20 <_Z6putbini>
    e498:	83 c4 10             	add    esp,0x10
    e49b:	e9 6b ff ff ff       	jmp    e40b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x12b>
    e4a0:	83 ec 0c             	sub    esp,0xc
    e4a3:	8d 74 3d 02          	lea    esi,[ebp+edi*1+0x2]
    e4a7:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    e4ab:	e8 60 d8 ff ff       	call   bd10 <_Z6putocti>
    e4b0:	83 c4 10             	add    esp,0x10
    e4b3:	e9 53 ff ff ff       	jmp    e40b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x12b>
    e4b8:	90                   	nop
    e4b9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e4c0:	83 ec 0c             	sub    esp,0xc
    e4c3:	8d 74 3d 02          	lea    esi,[ebp+edi*1+0x2]
    e4c7:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    e4cb:	e8 20 d8 ff ff       	call   bcf0 <_Z6puthexi>
    e4d0:	83 c4 10             	add    esp,0x10
    e4d3:	e9 33 ff ff ff       	jmp    e40b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x12b>
    e4d8:	90                   	nop
    e4d9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e4e0:	83 ec 0c             	sub    esp,0xc
    e4e3:	8d 74 3d 02          	lea    esi,[ebp+edi*1+0x2]
    e4e7:	ff 74 24 18          	push   DWORD PTR [esp+0x18]
    e4eb:	e8 f0 d7 ff ff       	call   bce0 <_Z6putdeci>
    e4f0:	83 c4 10             	add    esp,0x10
    e4f3:	e9 13 ff ff ff       	jmp    e40b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x12b>
    e4f8:	90                   	nop
    e4f9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e500:	83 ec 0c             	sub    esp,0xc
    e503:	8d 74 3d 02          	lea    esi,[ebp+edi*1+0x2]
    e507:	68 64 01 01 00       	push   0x10164
    e50c:	e8 bf d8 ff ff       	call   bdd0 <_Z6printfPKc>
    e511:	58                   	pop    eax
    e512:	ff 74 24 2b          	push   DWORD PTR [esp+0x2b]
    e516:	e8 d5 d7 ff ff       	call   bcf0 <_Z6puthexi>
    e51b:	83 c4 10             	add    esp,0x10
    e51e:	e9 e8 fe ff ff       	jmp    e40b <_Z6printfIPKcJcEEvS1_T_DpT0_+0x12b>

Disassembly of section .text._Z6printfIPKcJiS1_cEEvS1_T_DpT0_:

0000e530 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_>:
    e530:	55                   	push   ebp
    e531:	57                   	push   edi
    e532:	31 ed                	xor    ebp,ebp
    e534:	56                   	push   esi
    e535:	53                   	push   ebx
    e536:	83 ec 2c             	sub    esp,0x2c
    e539:	8b 44 24 50          	mov    eax,DWORD PTR [esp+0x50]
    e53d:	8b 7c 24 40          	mov    edi,DWORD PTR [esp+0x40]
    e541:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    e545:	0f be 07             	movsx  eax,BYTE PTR [edi]
    e548:	84 c0                	test   al,al
    e54a:	74 4e                	je     e59a <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x6a>
    e54c:	8d 5d 01             	lea    ebx,[ebp+0x1]
    e54f:	3c 25                	cmp    al,0x25
    e551:	8d 34 1f             	lea    esi,[edi+ebx*1]
    e554:	75 31                	jne    e587 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x57>
    e556:	8d 76 00             	lea    esi,[esi+0x0]
    e559:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    e560:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    e563:	3c 25                	cmp    al,0x25
    e565:	0f 84 f5 00 00 00    	je     e660 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x130>
    e56b:	84 c0                	test   al,al
    e56d:	75 39                	jne    e5a8 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x78>
    e56f:	0f be 44 2f 02       	movsx  eax,BYTE PTR [edi+ebp*1+0x2]
    e574:	8d 5d 02             	lea    ebx,[ebp+0x2]
    e577:	84 c0                	test   al,al
    e579:	74 1f                	je     e59a <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x6a>
    e57b:	89 dd                	mov    ebp,ebx
    e57d:	8d 5d 01             	lea    ebx,[ebp+0x1]
    e580:	3c 25                	cmp    al,0x25
    e582:	8d 34 1f             	lea    esi,[edi+ebx*1]
    e585:	74 d9                	je     e560 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x30>
    e587:	83 ec 0c             	sub    esp,0xc
    e58a:	50                   	push   eax
    e58b:	e8 40 d7 ff ff       	call   bcd0 <_Z7putcharc>
    e590:	0f be 06             	movsx  eax,BYTE PTR [esi]
    e593:	83 c4 10             	add    esp,0x10
    e596:	84 c0                	test   al,al
    e598:	75 e1                	jne    e57b <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x4b>
    e59a:	83 c4 2c             	add    esp,0x2c
    e59d:	5b                   	pop    ebx
    e59e:	5e                   	pop    esi
    e59f:	5f                   	pop    edi
    e5a0:	5d                   	pop    ebp
    e5a1:	c3                   	ret    
    e5a2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    e5a8:	83 ec 08             	sub    esp,0x8
    e5ab:	8d 44 24 4c          	lea    eax,[esp+0x4c]
    e5af:	50                   	push   eax
    e5b0:	56                   	push   esi
    e5b1:	e8 1a e9 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    e5b6:	01 c3                	add    ebx,eax
    e5b8:	8b 44 24 58          	mov    eax,DWORD PTR [esp+0x58]
    e5bc:	0f be 54 24 1c       	movsx  edx,BYTE PTR [esp+0x1c]
    e5c1:	01 df                	add    edi,ebx
    e5c3:	89 44 24 2c          	mov    DWORD PTR [esp+0x2c],eax
    e5c7:	0f be 07             	movsx  eax,BYTE PTR [edi]
    e5ca:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
    e5ce:	83 c4 10             	add    esp,0x10
    e5d1:	84 c0                	test   al,al
    e5d3:	74 c5                	je     e59a <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x6a>
    e5d5:	31 db                	xor    ebx,ebx
    e5d7:	3c 25                	cmp    al,0x25
    e5d9:	8d 6b 01             	lea    ebp,[ebx+0x1]
    e5dc:	8d 34 2f             	lea    esi,[edi+ebp*1]
    e5df:	75 2e                	jne    e60f <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0xdf>
    e5e1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e5e8:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    e5eb:	3c 25                	cmp    al,0x25
    e5ed:	0f 84 95 00 00 00    	je     e688 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x158>
    e5f3:	84 c0                	test   al,al
    e5f5:	75 39                	jne    e630 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x100>
    e5f7:	0f be 44 1f 02       	movsx  eax,BYTE PTR [edi+ebx*1+0x2]
    e5fc:	8d 6b 02             	lea    ebp,[ebx+0x2]
    e5ff:	84 c0                	test   al,al
    e601:	74 97                	je     e59a <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x6a>
    e603:	89 eb                	mov    ebx,ebp
    e605:	8d 6b 01             	lea    ebp,[ebx+0x1]
    e608:	3c 25                	cmp    al,0x25
    e60a:	8d 34 2f             	lea    esi,[edi+ebp*1]
    e60d:	74 d9                	je     e5e8 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0xb8>
    e60f:	83 ec 0c             	sub    esp,0xc
    e612:	50                   	push   eax
    e613:	e8 b8 d6 ff ff       	call   bcd0 <_Z7putcharc>
    e618:	0f be 06             	movsx  eax,BYTE PTR [esi]
    e61b:	83 c4 10             	add    esp,0x10
    e61e:	84 c0                	test   al,al
    e620:	0f 84 74 ff ff ff    	je     e59a <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x6a>
    e626:	89 eb                	mov    ebx,ebp
    e628:	eb db                	jmp    e605 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0xd5>
    e62a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    e630:	83 ec 08             	sub    esp,0x8
    e633:	8d 44 24 24          	lea    eax,[esp+0x24]
    e637:	50                   	push   eax
    e638:	56                   	push   esi
    e639:	e8 92 e9 ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    e63e:	01 c5                	add    ebp,eax
    e640:	83 c4 0c             	add    esp,0xc
    e643:	01 ef                	add    edi,ebp
    e645:	ff 74 24 10          	push   DWORD PTR [esp+0x10]
    e649:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    e64d:	57                   	push   edi
    e64e:	e8 8d fc ff ff       	call   e2e0 <_Z6printfIPKcJcEEvS1_T_DpT0_>
    e653:	83 c4 10             	add    esp,0x10
    e656:	83 c4 2c             	add    esp,0x2c
    e659:	5b                   	pop    ebx
    e65a:	5e                   	pop    esi
    e65b:	5f                   	pop    edi
    e65c:	5d                   	pop    ebp
    e65d:	c3                   	ret    
    e65e:	66 90                	xchg   ax,ax
    e660:	83 ec 0c             	sub    esp,0xc
    e663:	8d 5d 02             	lea    ebx,[ebp+0x2]
    e666:	6a 25                	push   0x25
    e668:	e8 63 d6 ff ff       	call   bcd0 <_Z7putcharc>
    e66d:	0f be 44 2f 02       	movsx  eax,BYTE PTR [edi+ebp*1+0x2]
    e672:	83 c4 10             	add    esp,0x10
    e675:	84 c0                	test   al,al
    e677:	0f 84 1d ff ff ff    	je     e59a <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x6a>
    e67d:	89 dd                	mov    ebp,ebx
    e67f:	e9 f9 fe ff ff       	jmp    e57d <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x4d>
    e684:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e688:	83 ec 0c             	sub    esp,0xc
    e68b:	8d 6b 02             	lea    ebp,[ebx+0x2]
    e68e:	6a 25                	push   0x25
    e690:	e8 3b d6 ff ff       	call   bcd0 <_Z7putcharc>
    e695:	0f be 44 1f 02       	movsx  eax,BYTE PTR [edi+ebx*1+0x2]
    e69a:	83 c4 10             	add    esp,0x10
    e69d:	84 c0                	test   al,al
    e69f:	0f 84 f5 fe ff ff    	je     e59a <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0x6a>
    e6a5:	89 eb                	mov    ebx,ebp
    e6a7:	e9 59 ff ff ff       	jmp    e605 <_Z6printfIPKcJiS1_cEEvS1_T_DpT0_+0xd5>

Disassembly of section .text._Z14_manage_escapeItEiPKcPT_:

0000e6b0 <_Z14_manage_escapeItEiPKcPT_>:
    e6b0:	83 ec 0c             	sub    esp,0xc
    e6b3:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    e6b7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    e6ba:	83 e8 42             	sub    eax,0x42
    e6bd:	3c 36                	cmp    al,0x36
    e6bf:	0f 87 f3 00 00 00    	ja     e7b8 <_Z14_manage_escapeItEiPKcPT_+0x108>
    e6c5:	0f b6 c0             	movzx  eax,al
    e6c8:	ff 24 85 84 2e 01 00 	jmp    DWORD PTR [eax*4+0x12e84]
    e6cf:	90                   	nop
    e6d0:	83 ec 0c             	sub    esp,0xc
    e6d3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    e6d7:	ff 30                	push   DWORD PTR [eax]
    e6d9:	e8 b2 d6 ff ff       	call   bd90 <_Z6putstrPc>
    e6de:	83 c4 10             	add    esp,0x10
    e6e1:	b8 01 00 00 00       	mov    eax,0x1
    e6e6:	83 c4 0c             	add    esp,0xc
    e6e9:	c3                   	ret    
    e6ea:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    e6f0:	83 ec 0c             	sub    esp,0xc
    e6f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    e6f7:	0f b7 00             	movzx  eax,WORD PTR [eax]
    e6fa:	50                   	push   eax
    e6fb:	e8 20 d6 ff ff       	call   bd20 <_Z6putbini>
    e700:	83 c4 10             	add    esp,0x10
    e703:	b8 01 00 00 00       	mov    eax,0x1
    e708:	83 c4 0c             	add    esp,0xc
    e70b:	c3                   	ret    
    e70c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e710:	83 ec 0c             	sub    esp,0xc
    e713:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    e717:	0f b7 00             	movzx  eax,WORD PTR [eax]
    e71a:	50                   	push   eax
    e71b:	e8 f0 d5 ff ff       	call   bd10 <_Z6putocti>
    e720:	83 c4 10             	add    esp,0x10
    e723:	b8 01 00 00 00       	mov    eax,0x1
    e728:	83 c4 0c             	add    esp,0xc
    e72b:	c3                   	ret    
    e72c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e730:	83 ec 0c             	sub    esp,0xc
    e733:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    e737:	0f b7 00             	movzx  eax,WORD PTR [eax]
    e73a:	50                   	push   eax
    e73b:	e8 b0 d5 ff ff       	call   bcf0 <_Z6puthexi>
    e740:	83 c4 10             	add    esp,0x10
    e743:	b8 01 00 00 00       	mov    eax,0x1
    e748:	83 c4 0c             	add    esp,0xc
    e74b:	c3                   	ret    
    e74c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e750:	83 ec 0c             	sub    esp,0xc
    e753:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    e757:	0f be 00             	movsx  eax,BYTE PTR [eax]
    e75a:	50                   	push   eax
    e75b:	e8 70 d5 ff ff       	call   bcd0 <_Z7putcharc>
    e760:	83 c4 10             	add    esp,0x10
    e763:	b8 01 00 00 00       	mov    eax,0x1
    e768:	83 c4 0c             	add    esp,0xc
    e76b:	c3                   	ret    
    e76c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e770:	83 ec 0c             	sub    esp,0xc
    e773:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    e777:	0f b7 00             	movzx  eax,WORD PTR [eax]
    e77a:	50                   	push   eax
    e77b:	e8 60 d5 ff ff       	call   bce0 <_Z6putdeci>
    e780:	83 c4 10             	add    esp,0x10
    e783:	b8 01 00 00 00       	mov    eax,0x1
    e788:	83 c4 0c             	add    esp,0xc
    e78b:	c3                   	ret    
    e78c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e790:	83 ec 0c             	sub    esp,0xc
    e793:	68 64 01 01 00       	push   0x10164
    e798:	e8 33 d6 ff ff       	call   bdd0 <_Z6printfPKc>
    e79d:	58                   	pop    eax
    e79e:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    e7a2:	ff 30                	push   DWORD PTR [eax]
    e7a4:	e8 47 d5 ff ff       	call   bcf0 <_Z6puthexi>
    e7a9:	83 c4 10             	add    esp,0x10
    e7ac:	b8 01 00 00 00       	mov    eax,0x1
    e7b1:	83 c4 0c             	add    esp,0xc
    e7b4:	c3                   	ret    
    e7b5:	8d 76 00             	lea    esi,[esi+0x0]
    e7b8:	31 c0                	xor    eax,eax
    e7ba:	e9 27 ff ff ff       	jmp    e6e6 <_Z14_manage_escapeItEiPKcPT_+0x36>

Disassembly of section .text._Z6printfItJttEEvPKcT_DpT0_:

0000e7c0 <_Z6printfItJttEEvPKcT_DpT0_>:
    e7c0:	55                   	push   ebp
    e7c1:	57                   	push   edi
    e7c2:	31 c9                	xor    ecx,ecx
    e7c4:	56                   	push   esi
    e7c5:	53                   	push   ebx
    e7c6:	83 ec 2c             	sub    esp,0x2c
    e7c9:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    e7cd:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    e7d1:	8b 74 24 48          	mov    esi,DWORD PTR [esp+0x48]
    e7d5:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    e7d9:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    e7dd:	66 89 44 24 0c       	mov    WORD PTR [esp+0xc],ax
    e7e2:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    e7e6:	84 c0                	test   al,al
    e7e8:	74 49                	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e7ea:	8d 79 01             	lea    edi,[ecx+0x1]
    e7ed:	3c 25                	cmp    al,0x25
    e7ef:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    e7f3:	75 2b                	jne    e820 <_Z6printfItJttEEvPKcT_DpT0_+0x60>
    e7f5:	8d 76 00             	lea    esi,[esi+0x0]
    e7f8:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    e7fb:	3c 25                	cmp    al,0x25
    e7fd:	0f 84 3d 01 00 00    	je     e940 <_Z6printfItJttEEvPKcT_DpT0_+0x180>
    e803:	84 c0                	test   al,al
    e805:	75 39                	jne    e840 <_Z6printfItJttEEvPKcT_DpT0_+0x80>
    e807:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    e80c:	8d 79 02             	lea    edi,[ecx+0x2]
    e80f:	84 c0                	test   al,al
    e811:	74 20                	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e813:	89 f9                	mov    ecx,edi
    e815:	8d 79 01             	lea    edi,[ecx+0x1]
    e818:	3c 25                	cmp    al,0x25
    e81a:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    e81e:	74 d8                	je     e7f8 <_Z6printfItJttEEvPKcT_DpT0_+0x38>
    e820:	83 ec 0c             	sub    esp,0xc
    e823:	50                   	push   eax
    e824:	e8 a7 d4 ff ff       	call   bcd0 <_Z7putcharc>
    e829:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    e82c:	83 c4 10             	add    esp,0x10
    e82f:	84 c0                	test   al,al
    e831:	75 e0                	jne    e813 <_Z6printfItJttEEvPKcT_DpT0_+0x53>
    e833:	83 c4 2c             	add    esp,0x2c
    e836:	5b                   	pop    ebx
    e837:	5e                   	pop    esi
    e838:	5f                   	pop    edi
    e839:	5d                   	pop    ebp
    e83a:	c3                   	ret    
    e83b:	90                   	nop
    e83c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e840:	83 ec 08             	sub    esp,0x8
    e843:	8d 44 24 14          	lea    eax,[esp+0x14]
    e847:	50                   	push   eax
    e848:	53                   	push   ebx
    e849:	e8 62 fe ff ff       	call   e6b0 <_Z14_manage_escapeItEiPKcPT_>
    e84e:	01 c7                	add    edi,eax
    e850:	66 89 74 24 2c       	mov    WORD PTR [esp+0x2c],si
    e855:	83 c4 10             	add    esp,0x10
    e858:	01 fd                	add    ebp,edi
    e85a:	31 ff                	xor    edi,edi
    e85c:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    e860:	84 c0                	test   al,al
    e862:	74 cf                	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e864:	8d 77 01             	lea    esi,[edi+0x1]
    e867:	3c 25                	cmp    al,0x25
    e869:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    e86d:	75 29                	jne    e898 <_Z6printfItJttEEvPKcT_DpT0_+0xd8>
    e86f:	90                   	nop
    e870:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    e873:	3c 25                	cmp    al,0x25
    e875:	0f 84 1d 01 00 00    	je     e998 <_Z6printfItJttEEvPKcT_DpT0_+0x1d8>
    e87b:	84 c0                	test   al,al
    e87d:	75 31                	jne    e8b0 <_Z6printfItJttEEvPKcT_DpT0_+0xf0>
    e87f:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    e884:	8d 77 02             	lea    esi,[edi+0x2]
    e887:	84 c0                	test   al,al
    e889:	74 a8                	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e88b:	89 f7                	mov    edi,esi
    e88d:	8d 77 01             	lea    esi,[edi+0x1]
    e890:	3c 25                	cmp    al,0x25
    e892:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    e896:	74 d8                	je     e870 <_Z6printfItJttEEvPKcT_DpT0_+0xb0>
    e898:	83 ec 0c             	sub    esp,0xc
    e89b:	50                   	push   eax
    e89c:	e8 2f d4 ff ff       	call   bcd0 <_Z7putcharc>
    e8a1:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    e8a4:	83 c4 10             	add    esp,0x10
    e8a7:	84 c0                	test   al,al
    e8a9:	74 88                	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e8ab:	89 f7                	mov    edi,esi
    e8ad:	eb de                	jmp    e88d <_Z6printfItJttEEvPKcT_DpT0_+0xcd>
    e8af:	90                   	nop
    e8b0:	83 ec 08             	sub    esp,0x8
    e8b3:	8d 44 24 24          	lea    eax,[esp+0x24]
    e8b7:	50                   	push   eax
    e8b8:	53                   	push   ebx
    e8b9:	e8 f2 fd ff ff       	call   e6b0 <_Z14_manage_escapeItEiPKcPT_>
    e8be:	01 c6                	add    esi,eax
    e8c0:	0f b7 44 24 14       	movzx  eax,WORD PTR [esp+0x14]
    e8c5:	01 f5                	add    ebp,esi
    e8c7:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    e8cc:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    e8d0:	83 c4 10             	add    esp,0x10
    e8d3:	84 c0                	test   al,al
    e8d5:	0f 84 58 ff ff ff    	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e8db:	31 f6                	xor    esi,esi
    e8dd:	3c 25                	cmp    al,0x25
    e8df:	8d 5e 01             	lea    ebx,[esi+0x1]
    e8e2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    e8e6:	75 34                	jne    e91c <_Z6printfItJttEEvPKcT_DpT0_+0x15c>
    e8e8:	90                   	nop
    e8e9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    e8f0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    e8f3:	3c 25                	cmp    al,0x25
    e8f5:	0f 84 c5 00 00 00    	je     e9c0 <_Z6printfItJttEEvPKcT_DpT0_+0x200>
    e8fb:	84 c0                	test   al,al
    e8fd:	75 71                	jne    e970 <_Z6printfItJttEEvPKcT_DpT0_+0x1b0>
    e8ff:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    e904:	8d 5e 02             	lea    ebx,[esi+0x2]
    e907:	84 c0                	test   al,al
    e909:	0f 84 24 ff ff ff    	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e90f:	89 de                	mov    esi,ebx
    e911:	8d 5e 01             	lea    ebx,[esi+0x1]
    e914:	3c 25                	cmp    al,0x25
    e916:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    e91a:	74 d4                	je     e8f0 <_Z6printfItJttEEvPKcT_DpT0_+0x130>
    e91c:	83 ec 0c             	sub    esp,0xc
    e91f:	50                   	push   eax
    e920:	e8 ab d3 ff ff       	call   bcd0 <_Z7putcharc>
    e925:	0f be 07             	movsx  eax,BYTE PTR [edi]
    e928:	83 c4 10             	add    esp,0x10
    e92b:	84 c0                	test   al,al
    e92d:	0f 84 00 ff ff ff    	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e933:	89 de                	mov    esi,ebx
    e935:	eb da                	jmp    e911 <_Z6printfItJttEEvPKcT_DpT0_+0x151>
    e937:	89 f6                	mov    esi,esi
    e939:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    e940:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    e944:	83 ec 0c             	sub    esp,0xc
    e947:	6a 25                	push   0x25
    e949:	e8 82 d3 ff ff       	call   bcd0 <_Z7putcharc>
    e94e:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    e952:	83 c4 10             	add    esp,0x10
    e955:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    e95a:	8d 79 02             	lea    edi,[ecx+0x2]
    e95d:	84 c0                	test   al,al
    e95f:	0f 84 ce fe ff ff    	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e965:	89 f9                	mov    ecx,edi
    e967:	e9 a9 fe ff ff       	jmp    e815 <_Z6printfItJttEEvPKcT_DpT0_+0x55>
    e96c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e970:	83 ec 08             	sub    esp,0x8
    e973:	8d 44 24 26          	lea    eax,[esp+0x26]
    e977:	50                   	push   eax
    e978:	57                   	push   edi
    e979:	e8 32 fd ff ff       	call   e6b0 <_Z14_manage_escapeItEiPKcPT_>
    e97e:	01 c3                	add    ebx,eax
    e980:	01 dd                	add    ebp,ebx
    e982:	89 2c 24             	mov    DWORD PTR [esp],ebp
    e985:	e8 46 d4 ff ff       	call   bdd0 <_Z6printfPKc>
    e98a:	83 c4 10             	add    esp,0x10
    e98d:	83 c4 2c             	add    esp,0x2c
    e990:	5b                   	pop    ebx
    e991:	5e                   	pop    esi
    e992:	5f                   	pop    edi
    e993:	5d                   	pop    ebp
    e994:	c3                   	ret    
    e995:	8d 76 00             	lea    esi,[esi+0x0]
    e998:	83 ec 0c             	sub    esp,0xc
    e99b:	8d 77 02             	lea    esi,[edi+0x2]
    e99e:	6a 25                	push   0x25
    e9a0:	e8 2b d3 ff ff       	call   bcd0 <_Z7putcharc>
    e9a5:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    e9aa:	83 c4 10             	add    esp,0x10
    e9ad:	84 c0                	test   al,al
    e9af:	0f 84 7e fe ff ff    	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e9b5:	89 f7                	mov    edi,esi
    e9b7:	e9 d1 fe ff ff       	jmp    e88d <_Z6printfItJttEEvPKcT_DpT0_+0xcd>
    e9bc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    e9c0:	83 ec 0c             	sub    esp,0xc
    e9c3:	8d 5e 02             	lea    ebx,[esi+0x2]
    e9c6:	6a 25                	push   0x25
    e9c8:	e8 03 d3 ff ff       	call   bcd0 <_Z7putcharc>
    e9cd:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    e9d2:	83 c4 10             	add    esp,0x10
    e9d5:	84 c0                	test   al,al
    e9d7:	0f 84 56 fe ff ff    	je     e833 <_Z6printfItJttEEvPKcT_DpT0_+0x73>
    e9dd:	89 de                	mov    esi,ebx
    e9df:	e9 2d ff ff ff       	jmp    e911 <_Z6printfItJttEEvPKcT_DpT0_+0x151>

Disassembly of section .text._Z6printfIPKcJiS1_tttEEvS1_T_DpT0_:

0000e9f0 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_>:
    e9f0:	55                   	push   ebp
    e9f1:	57                   	push   edi
    e9f2:	31 ed                	xor    ebp,ebp
    e9f4:	56                   	push   esi
    e9f5:	53                   	push   ebx
    e9f6:	83 ec 2c             	sub    esp,0x2c
    e9f9:	8b 44 24 50          	mov    eax,DWORD PTR [esp+0x50]
    e9fd:	8b 5c 24 40          	mov    ebx,DWORD PTR [esp+0x40]
    ea01:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    ea05:	8b 44 24 54          	mov    eax,DWORD PTR [esp+0x54]
    ea09:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    ea0d:	8b 44 24 58          	mov    eax,DWORD PTR [esp+0x58]
    ea11:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    ea15:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    ea18:	84 c0                	test   al,al
    ea1a:	74 4e                	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    ea1c:	8d 7d 01             	lea    edi,[ebp+0x1]
    ea1f:	3c 25                	cmp    al,0x25
    ea21:	8d 34 3b             	lea    esi,[ebx+edi*1]
    ea24:	75 31                	jne    ea57 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x67>
    ea26:	8d 76 00             	lea    esi,[esi+0x0]
    ea29:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    ea30:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    ea33:	3c 25                	cmp    al,0x25
    ea35:	0f 84 45 01 00 00    	je     eb80 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x190>
    ea3b:	84 c0                	test   al,al
    ea3d:	75 39                	jne    ea78 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x88>
    ea3f:	0f be 44 2b 02       	movsx  eax,BYTE PTR [ebx+ebp*1+0x2]
    ea44:	8d 7d 02             	lea    edi,[ebp+0x2]
    ea47:	84 c0                	test   al,al
    ea49:	74 1f                	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    ea4b:	89 fd                	mov    ebp,edi
    ea4d:	8d 7d 01             	lea    edi,[ebp+0x1]
    ea50:	3c 25                	cmp    al,0x25
    ea52:	8d 34 3b             	lea    esi,[ebx+edi*1]
    ea55:	74 d9                	je     ea30 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x40>
    ea57:	83 ec 0c             	sub    esp,0xc
    ea5a:	50                   	push   eax
    ea5b:	e8 70 d2 ff ff       	call   bcd0 <_Z7putcharc>
    ea60:	0f be 06             	movsx  eax,BYTE PTR [esi]
    ea63:	83 c4 10             	add    esp,0x10
    ea66:	84 c0                	test   al,al
    ea68:	75 e1                	jne    ea4b <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x5b>
    ea6a:	83 c4 2c             	add    esp,0x2c
    ea6d:	5b                   	pop    ebx
    ea6e:	5e                   	pop    esi
    ea6f:	5f                   	pop    edi
    ea70:	5d                   	pop    ebp
    ea71:	c3                   	ret    
    ea72:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ea78:	83 ec 08             	sub    esp,0x8
    ea7b:	8d 44 24 4c          	lea    eax,[esp+0x4c]
    ea7f:	50                   	push   eax
    ea80:	56                   	push   esi
    ea81:	e8 4a e4 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    ea86:	01 c7                	add    edi,eax
    ea88:	8b 44 24 58          	mov    eax,DWORD PTR [esp+0x58]
    ea8c:	01 fb                	add    ebx,edi
    ea8e:	31 ff                	xor    edi,edi
    ea90:	89 44 24 28          	mov    DWORD PTR [esp+0x28],eax
    ea94:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    ea97:	83 c4 10             	add    esp,0x10
    ea9a:	84 c0                	test   al,al
    ea9c:	74 cc                	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    ea9e:	8d 6f 01             	lea    ebp,[edi+0x1]
    eaa1:	3c 25                	cmp    al,0x25
    eaa3:	8d 34 2b             	lea    esi,[ebx+ebp*1]
    eaa6:	75 2f                	jne    ead7 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0xe7>
    eaa8:	90                   	nop
    eaa9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    eab0:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    eab3:	3c 25                	cmp    al,0x25
    eab5:	0f 84 25 01 00 00    	je     ebe0 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x1f0>
    eabb:	84 c0                	test   al,al
    eabd:	75 31                	jne    eaf0 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x100>
    eabf:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    eac4:	8d 6f 02             	lea    ebp,[edi+0x2]
    eac7:	84 c0                	test   al,al
    eac9:	74 9f                	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    eacb:	89 ef                	mov    edi,ebp
    eacd:	8d 6f 01             	lea    ebp,[edi+0x1]
    ead0:	3c 25                	cmp    al,0x25
    ead2:	8d 34 2b             	lea    esi,[ebx+ebp*1]
    ead5:	74 d9                	je     eab0 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0xc0>
    ead7:	83 ec 0c             	sub    esp,0xc
    eada:	50                   	push   eax
    eadb:	e8 f0 d1 ff ff       	call   bcd0 <_Z7putcharc>
    eae0:	0f be 06             	movsx  eax,BYTE PTR [esi]
    eae3:	83 c4 10             	add    esp,0x10
    eae6:	84 c0                	test   al,al
    eae8:	74 80                	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    eaea:	89 ef                	mov    edi,ebp
    eaec:	eb df                	jmp    eacd <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0xdd>
    eaee:	66 90                	xchg   ax,ax
    eaf0:	83 ec 08             	sub    esp,0x8
    eaf3:	8d 44 24 20          	lea    eax,[esp+0x20]
    eaf7:	50                   	push   eax
    eaf8:	56                   	push   esi
    eaf9:	e8 d2 e4 ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    eafe:	01 c5                	add    ebp,eax
    eb00:	8b 44 24 5c          	mov    eax,DWORD PTR [esp+0x5c]
    eb04:	01 dd                	add    ebp,ebx
    eb06:	89 44 24 2c          	mov    DWORD PTR [esp+0x2c],eax
    eb0a:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    eb0e:	83 c4 10             	add    esp,0x10
    eb11:	84 c0                	test   al,al
    eb13:	0f 84 51 ff ff ff    	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    eb19:	31 d2                	xor    edx,edx
    eb1b:	3c 25                	cmp    al,0x25
    eb1d:	89 d6                	mov    esi,edx
    eb1f:	8d 7e 01             	lea    edi,[esi+0x1]
    eb22:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    eb26:	75 34                	jne    eb5c <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x16c>
    eb28:	90                   	nop
    eb29:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    eb30:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    eb33:	3c 25                	cmp    al,0x25
    eb35:	0f 84 cd 00 00 00    	je     ec08 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x218>
    eb3b:	84 c0                	test   al,al
    eb3d:	75 69                	jne    eba8 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x1b8>
    eb3f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    eb44:	8d 7e 02             	lea    edi,[esi+0x2]
    eb47:	84 c0                	test   al,al
    eb49:	0f 84 1b ff ff ff    	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    eb4f:	89 fe                	mov    esi,edi
    eb51:	8d 7e 01             	lea    edi,[esi+0x1]
    eb54:	3c 25                	cmp    al,0x25
    eb56:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    eb5a:	74 d4                	je     eb30 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x140>
    eb5c:	83 ec 0c             	sub    esp,0xc
    eb5f:	50                   	push   eax
    eb60:	e8 6b d1 ff ff       	call   bcd0 <_Z7putcharc>
    eb65:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    eb68:	83 c4 10             	add    esp,0x10
    eb6b:	84 c0                	test   al,al
    eb6d:	0f 84 f7 fe ff ff    	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    eb73:	89 fe                	mov    esi,edi
    eb75:	eb da                	jmp    eb51 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x161>
    eb77:	89 f6                	mov    esi,esi
    eb79:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    eb80:	83 ec 0c             	sub    esp,0xc
    eb83:	8d 7d 02             	lea    edi,[ebp+0x2]
    eb86:	6a 25                	push   0x25
    eb88:	e8 43 d1 ff ff       	call   bcd0 <_Z7putcharc>
    eb8d:	0f be 44 2b 02       	movsx  eax,BYTE PTR [ebx+ebp*1+0x2]
    eb92:	83 c4 10             	add    esp,0x10
    eb95:	84 c0                	test   al,al
    eb97:	0f 84 cd fe ff ff    	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    eb9d:	89 fd                	mov    ebp,edi
    eb9f:	e9 a9 fe ff ff       	jmp    ea4d <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x5d>
    eba4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    eba8:	83 ec 08             	sub    esp,0x8
    ebab:	8d 44 24 24          	lea    eax,[esp+0x24]
    ebaf:	50                   	push   eax
    ebb0:	53                   	push   ebx
    ebb1:	e8 1a e3 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    ebb6:	0f b7 74 24 1c       	movzx  esi,WORD PTR [esp+0x1c]
    ebbb:	8d 14 38             	lea    edx,[eax+edi*1]
    ebbe:	01 ea                	add    edx,ebp
    ebc0:	56                   	push   esi
    ebc1:	0f b7 5c 24 1c       	movzx  ebx,WORD PTR [esp+0x1c]
    ebc6:	53                   	push   ebx
    ebc7:	0f b7 4c 24 1c       	movzx  ecx,WORD PTR [esp+0x1c]
    ebcc:	51                   	push   ecx
    ebcd:	52                   	push   edx
    ebce:	e8 ed fb ff ff       	call   e7c0 <_Z6printfItJttEEvPKcT_DpT0_>
    ebd3:	83 c4 20             	add    esp,0x20
    ebd6:	83 c4 2c             	add    esp,0x2c
    ebd9:	5b                   	pop    ebx
    ebda:	5e                   	pop    esi
    ebdb:	5f                   	pop    edi
    ebdc:	5d                   	pop    ebp
    ebdd:	c3                   	ret    
    ebde:	66 90                	xchg   ax,ax
    ebe0:	83 ec 0c             	sub    esp,0xc
    ebe3:	8d 6f 02             	lea    ebp,[edi+0x2]
    ebe6:	6a 25                	push   0x25
    ebe8:	e8 e3 d0 ff ff       	call   bcd0 <_Z7putcharc>
    ebed:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    ebf2:	83 c4 10             	add    esp,0x10
    ebf5:	84 c0                	test   al,al
    ebf7:	0f 84 6d fe ff ff    	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    ebfd:	89 ef                	mov    edi,ebp
    ebff:	e9 c9 fe ff ff       	jmp    eacd <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0xdd>
    ec04:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ec08:	83 ec 0c             	sub    esp,0xc
    ec0b:	8d 7e 02             	lea    edi,[esi+0x2]
    ec0e:	6a 25                	push   0x25
    ec10:	e8 bb d0 ff ff       	call   bcd0 <_Z7putcharc>
    ec15:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    ec1a:	83 c4 10             	add    esp,0x10
    ec1d:	84 c0                	test   al,al
    ec1f:	0f 84 45 fe ff ff    	je     ea6a <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x7a>
    ec25:	89 fe                	mov    esi,edi
    ec27:	e9 25 ff ff ff       	jmp    eb51 <_Z6printfIPKcJiS1_tttEEvS1_T_DpT0_+0x161>

Disassembly of section .text._Z6printfIPKcJttttEEvS1_T_DpT0_:

0000ec30 <_Z6printfIPKcJttttEEvS1_T_DpT0_>:
    ec30:	55                   	push   ebp
    ec31:	57                   	push   edi
    ec32:	31 ff                	xor    edi,edi
    ec34:	56                   	push   esi
    ec35:	53                   	push   ebx
    ec36:	83 ec 2c             	sub    esp,0x2c
    ec39:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    ec3d:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    ec41:	89 04 24             	mov    DWORD PTR [esp],eax
    ec44:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    ec48:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    ec4c:	8b 44 24 50          	mov    eax,DWORD PTR [esp+0x50]
    ec50:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    ec54:	8b 44 24 54          	mov    eax,DWORD PTR [esp+0x54]
    ec58:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    ec5c:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    ec60:	84 c0                	test   al,al
    ec62:	74 47                	je     ecab <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x7b>
    ec64:	8d 5f 01             	lea    ebx,[edi+0x1]
    ec67:	3c 25                	cmp    al,0x25
    ec69:	8d 74 1d 00          	lea    esi,[ebp+ebx*1+0x0]
    ec6d:	75 29                	jne    ec98 <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x68>
    ec6f:	90                   	nop
    ec70:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    ec73:	3c 25                	cmp    al,0x25
    ec75:	0f 84 15 01 00 00    	je     ed90 <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x160>
    ec7b:	84 c0                	test   al,al
    ec7d:	75 39                	jne    ecb8 <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x88>
    ec7f:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    ec84:	8d 5f 02             	lea    ebx,[edi+0x2]
    ec87:	84 c0                	test   al,al
    ec89:	74 20                	je     ecab <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x7b>
    ec8b:	89 df                	mov    edi,ebx
    ec8d:	8d 5f 01             	lea    ebx,[edi+0x1]
    ec90:	3c 25                	cmp    al,0x25
    ec92:	8d 74 1d 00          	lea    esi,[ebp+ebx*1+0x0]
    ec96:	74 d8                	je     ec70 <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x40>
    ec98:	83 ec 0c             	sub    esp,0xc
    ec9b:	50                   	push   eax
    ec9c:	e8 2f d0 ff ff       	call   bcd0 <_Z7putcharc>
    eca1:	0f be 06             	movsx  eax,BYTE PTR [esi]
    eca4:	83 c4 10             	add    esp,0x10
    eca7:	84 c0                	test   al,al
    eca9:	75 e0                	jne    ec8b <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x5b>
    ecab:	83 c4 2c             	add    esp,0x2c
    ecae:	5b                   	pop    ebx
    ecaf:	5e                   	pop    esi
    ecb0:	5f                   	pop    edi
    ecb1:	5d                   	pop    ebp
    ecb2:	c3                   	ret    
    ecb3:	90                   	nop
    ecb4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ecb8:	83 ec 08             	sub    esp,0x8
    ecbb:	8d 44 24 4c          	lea    eax,[esp+0x4c]
    ecbf:	50                   	push   eax
    ecc0:	56                   	push   esi
    ecc1:	e8 0a e2 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    ecc6:	01 c3                	add    ebx,eax
    ecc8:	0f b7 44 24 10       	movzx  eax,WORD PTR [esp+0x10]
    eccd:	0f b7 4c 24 18       	movzx  ecx,WORD PTR [esp+0x18]
    ecd2:	01 eb                	add    ebx,ebp
    ecd4:	0f b7 54 24 14       	movzx  edx,WORD PTR [esp+0x14]
    ecd9:	0f b7 74 24 1c       	movzx  esi,WORD PTR [esp+0x1c]
    ecde:	66 89 44 24 2e       	mov    WORD PTR [esp+0x2e],ax
    ece3:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    ece6:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    ecea:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    ecee:	83 c4 10             	add    esp,0x10
    ecf1:	84 c0                	test   al,al
    ecf3:	74 b6                	je     ecab <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x7b>
    ecf5:	31 d2                	xor    edx,edx
    ecf7:	89 34 24             	mov    DWORD PTR [esp],esi
    ecfa:	3c 25                	cmp    al,0x25
    ecfc:	89 d7                	mov    edi,edx
    ecfe:	89 de                	mov    esi,ebx
    ed00:	8d 6f 01             	lea    ebp,[edi+0x1]
    ed03:	8d 1c 2e             	lea    ebx,[esi+ebp*1]
    ed06:	75 2f                	jne    ed37 <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x107>
    ed08:	90                   	nop
    ed09:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ed10:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    ed13:	3c 25                	cmp    al,0x25
    ed15:	0f 84 9d 00 00 00    	je     edb8 <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x188>
    ed1b:	84 c0                	test   al,al
    ed1d:	75 39                	jne    ed58 <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x128>
    ed1f:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    ed24:	8d 6f 02             	lea    ebp,[edi+0x2]
    ed27:	84 c0                	test   al,al
    ed29:	74 80                	je     ecab <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x7b>
    ed2b:	89 ef                	mov    edi,ebp
    ed2d:	8d 6f 01             	lea    ebp,[edi+0x1]
    ed30:	3c 25                	cmp    al,0x25
    ed32:	8d 1c 2e             	lea    ebx,[esi+ebp*1]
    ed35:	74 d9                	je     ed10 <_Z6printfIPKcJttttEEvS1_T_DpT0_+0xe0>
    ed37:	83 ec 0c             	sub    esp,0xc
    ed3a:	50                   	push   eax
    ed3b:	e8 90 cf ff ff       	call   bcd0 <_Z7putcharc>
    ed40:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    ed43:	83 c4 10             	add    esp,0x10
    ed46:	84 c0                	test   al,al
    ed48:	0f 84 5d ff ff ff    	je     ecab <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x7b>
    ed4e:	89 ef                	mov    edi,ebp
    ed50:	eb db                	jmp    ed2d <_Z6printfIPKcJttttEEvS1_T_DpT0_+0xfd>
    ed52:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    ed58:	83 ec 08             	sub    esp,0x8
    ed5b:	89 df                	mov    edi,ebx
    ed5d:	89 f3                	mov    ebx,esi
    ed5f:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    ed63:	8d 44 24 26          	lea    eax,[esp+0x26]
    ed67:	50                   	push   eax
    ed68:	57                   	push   edi
    ed69:	e8 42 f9 ff ff       	call   e6b0 <_Z14_manage_escapeItEiPKcPT_>
    ed6e:	01 c5                	add    ebp,eax
    ed70:	56                   	push   esi
    ed71:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    ed75:	01 eb                	add    ebx,ebp
    ed77:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    ed7b:	53                   	push   ebx
    ed7c:	e8 3f fa ff ff       	call   e7c0 <_Z6printfItJttEEvPKcT_DpT0_>
    ed81:	83 c4 20             	add    esp,0x20
    ed84:	83 c4 2c             	add    esp,0x2c
    ed87:	5b                   	pop    ebx
    ed88:	5e                   	pop    esi
    ed89:	5f                   	pop    edi
    ed8a:	5d                   	pop    ebp
    ed8b:	c3                   	ret    
    ed8c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ed90:	83 ec 0c             	sub    esp,0xc
    ed93:	8d 5f 02             	lea    ebx,[edi+0x2]
    ed96:	6a 25                	push   0x25
    ed98:	e8 33 cf ff ff       	call   bcd0 <_Z7putcharc>
    ed9d:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    eda2:	83 c4 10             	add    esp,0x10
    eda5:	84 c0                	test   al,al
    eda7:	0f 84 fe fe ff ff    	je     ecab <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x7b>
    edad:	89 df                	mov    edi,ebx
    edaf:	e9 d9 fe ff ff       	jmp    ec8d <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x5d>
    edb4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    edb8:	83 ec 0c             	sub    esp,0xc
    edbb:	8d 6f 02             	lea    ebp,[edi+0x2]
    edbe:	6a 25                	push   0x25
    edc0:	e8 0b cf ff ff       	call   bcd0 <_Z7putcharc>
    edc5:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    edca:	83 c4 10             	add    esp,0x10
    edcd:	84 c0                	test   al,al
    edcf:	0f 84 d6 fe ff ff    	je     ecab <_Z6printfIPKcJttttEEvS1_T_DpT0_+0x7b>
    edd5:	89 ef                	mov    edi,ebp
    edd7:	e9 51 ff ff ff       	jmp    ed2d <_Z6printfIPKcJttttEEvS1_T_DpT0_+0xfd>

Disassembly of section .text._Z6printfIPKcJtEEvS1_T_DpT0_:

0000ede0 <_Z6printfIPKcJtEEvS1_T_DpT0_>:
    ede0:	55                   	push   ebp
    ede1:	57                   	push   edi
    ede2:	56                   	push   esi
    ede3:	53                   	push   ebx
    ede4:	31 f6                	xor    esi,esi
    ede6:	83 ec 2c             	sub    esp,0x2c
    ede9:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    eded:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    edf1:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    edf5:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    edf9:	84 c0                	test   al,al
    edfb:	74 4e                	je     ee4b <_Z6printfIPKcJtEEvS1_T_DpT0_+0x6b>
    edfd:	8d 7e 01             	lea    edi,[esi+0x1]
    ee00:	3c 25                	cmp    al,0x25
    ee02:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    ee06:	75 30                	jne    ee38 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x58>
    ee08:	90                   	nop
    ee09:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ee10:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    ee13:	3c 25                	cmp    al,0x25
    ee15:	0f 84 05 01 00 00    	je     ef20 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x140>
    ee1b:	84 c0                	test   al,al
    ee1d:	75 39                	jne    ee58 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x78>
    ee1f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    ee24:	8d 7e 02             	lea    edi,[esi+0x2]
    ee27:	84 c0                	test   al,al
    ee29:	74 20                	je     ee4b <_Z6printfIPKcJtEEvS1_T_DpT0_+0x6b>
    ee2b:	89 fe                	mov    esi,edi
    ee2d:	8d 7e 01             	lea    edi,[esi+0x1]
    ee30:	3c 25                	cmp    al,0x25
    ee32:	8d 5c 3d 00          	lea    ebx,[ebp+edi*1+0x0]
    ee36:	74 d8                	je     ee10 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x30>
    ee38:	83 ec 0c             	sub    esp,0xc
    ee3b:	50                   	push   eax
    ee3c:	e8 8f ce ff ff       	call   bcd0 <_Z7putcharc>
    ee41:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    ee44:	83 c4 10             	add    esp,0x10
    ee47:	84 c0                	test   al,al
    ee49:	75 e0                	jne    ee2b <_Z6printfIPKcJtEEvS1_T_DpT0_+0x4b>
    ee4b:	83 c4 2c             	add    esp,0x2c
    ee4e:	5b                   	pop    ebx
    ee4f:	5e                   	pop    esi
    ee50:	5f                   	pop    edi
    ee51:	5d                   	pop    ebp
    ee52:	c3                   	ret    
    ee53:	90                   	nop
    ee54:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ee58:	83 ec 08             	sub    esp,0x8
    ee5b:	8d 44 24 4c          	lea    eax,[esp+0x4c]
    ee5f:	50                   	push   eax
    ee60:	53                   	push   ebx
    ee61:	e8 6a e0 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    ee66:	01 c7                	add    edi,eax
    ee68:	8b 54 24 18          	mov    edx,DWORD PTR [esp+0x18]
    ee6c:	01 fd                	add    ebp,edi
    ee6e:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    ee72:	66 89 54 24 2e       	mov    WORD PTR [esp+0x2e],dx
    ee77:	83 c4 10             	add    esp,0x10
    ee7a:	0f b7 da             	movzx  ebx,dx
    ee7d:	84 c0                	test   al,al
    ee7f:	74 ca                	je     ee4b <_Z6printfIPKcJtEEvS1_T_DpT0_+0x6b>
    ee81:	31 c9                	xor    ecx,ecx
    ee83:	3c 25                	cmp    al,0x25
    ee85:	8d 79 01             	lea    edi,[ecx+0x1]
    ee88:	8d 74 3d 00          	lea    esi,[ebp+edi*1+0x0]
    ee8c:	75 2a                	jne    eeb8 <_Z6printfIPKcJtEEvS1_T_DpT0_+0xd8>
    ee8e:	66 90                	xchg   ax,ax
    ee90:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    ee93:	3c 25                	cmp    al,0x25
    ee95:	0f 84 ad 00 00 00    	je     ef48 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x168>
    ee9b:	84 c0                	test   al,al
    ee9d:	75 31                	jne    eed0 <_Z6printfIPKcJtEEvS1_T_DpT0_+0xf0>
    ee9f:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    eea4:	8d 79 02             	lea    edi,[ecx+0x2]
    eea7:	84 c0                	test   al,al
    eea9:	74 a0                	je     ee4b <_Z6printfIPKcJtEEvS1_T_DpT0_+0x6b>
    eeab:	89 f9                	mov    ecx,edi
    eead:	8d 79 01             	lea    edi,[ecx+0x1]
    eeb0:	3c 25                	cmp    al,0x25
    eeb2:	8d 74 3d 00          	lea    esi,[ebp+edi*1+0x0]
    eeb6:	74 d8                	je     ee90 <_Z6printfIPKcJtEEvS1_T_DpT0_+0xb0>
    eeb8:	83 ec 0c             	sub    esp,0xc
    eebb:	50                   	push   eax
    eebc:	e8 0f ce ff ff       	call   bcd0 <_Z7putcharc>
    eec1:	0f be 06             	movsx  eax,BYTE PTR [esi]
    eec4:	83 c4 10             	add    esp,0x10
    eec7:	84 c0                	test   al,al
    eec9:	74 80                	je     ee4b <_Z6printfIPKcJtEEvS1_T_DpT0_+0x6b>
    eecb:	89 f9                	mov    ecx,edi
    eecd:	eb de                	jmp    eead <_Z6printfIPKcJtEEvS1_T_DpT0_+0xcd>
    eecf:	90                   	nop
    eed0:	83 e8 42             	sub    eax,0x42
    eed3:	3c 36                	cmp    al,0x36
    eed5:	77 2e                	ja     ef05 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x125>
    eed7:	0f b6 c0             	movzx  eax,al
    eeda:	ff 24 85 60 2f 01 00 	jmp    DWORD PTR [eax*4+0x12f60]
    eee1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    eee8:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    eeec:	83 ec 0c             	sub    esp,0xc
    eeef:	0f be 5c 24 14       	movsx  ebx,BYTE PTR [esp+0x14]
    eef4:	53                   	push   ebx
    eef5:	e8 d6 cd ff ff       	call   bcd0 <_Z7putcharc>
    eefa:	8b 4c 24 1c          	mov    ecx,DWORD PTR [esp+0x1c]
    eefe:	83 c4 10             	add    esp,0x10
    ef01:	8d 74 0d 02          	lea    esi,[ebp+ecx*1+0x2]
    ef05:	83 ec 0c             	sub    esp,0xc
    ef08:	56                   	push   esi
    ef09:	e8 c2 ce ff ff       	call   bdd0 <_Z6printfPKc>
    ef0e:	83 c4 10             	add    esp,0x10
    ef11:	83 c4 2c             	add    esp,0x2c
    ef14:	5b                   	pop    ebx
    ef15:	5e                   	pop    esi
    ef16:	5f                   	pop    edi
    ef17:	5d                   	pop    ebp
    ef18:	c3                   	ret    
    ef19:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    ef20:	83 ec 0c             	sub    esp,0xc
    ef23:	8d 7e 02             	lea    edi,[esi+0x2]
    ef26:	6a 25                	push   0x25
    ef28:	e8 a3 cd ff ff       	call   bcd0 <_Z7putcharc>
    ef2d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    ef32:	83 c4 10             	add    esp,0x10
    ef35:	84 c0                	test   al,al
    ef37:	0f 84 0e ff ff ff    	je     ee4b <_Z6printfIPKcJtEEvS1_T_DpT0_+0x6b>
    ef3d:	89 fe                	mov    esi,edi
    ef3f:	e9 e9 fe ff ff       	jmp    ee2d <_Z6printfIPKcJtEEvS1_T_DpT0_+0x4d>
    ef44:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ef48:	89 4c 24 0c          	mov    DWORD PTR [esp+0xc],ecx
    ef4c:	83 ec 0c             	sub    esp,0xc
    ef4f:	6a 25                	push   0x25
    ef51:	e8 7a cd ff ff       	call   bcd0 <_Z7putcharc>
    ef56:	8b 4c 24 1c          	mov    ecx,DWORD PTR [esp+0x1c]
    ef5a:	83 c4 10             	add    esp,0x10
    ef5d:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    ef62:	8d 79 02             	lea    edi,[ecx+0x2]
    ef65:	84 c0                	test   al,al
    ef67:	0f 84 de fe ff ff    	je     ee4b <_Z6printfIPKcJtEEvS1_T_DpT0_+0x6b>
    ef6d:	89 f9                	mov    ecx,edi
    ef6f:	e9 39 ff ff ff       	jmp    eead <_Z6printfIPKcJtEEvS1_T_DpT0_+0xcd>
    ef74:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    ef78:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    ef7c:	83 ec 0c             	sub    esp,0xc
    ef7f:	ff 74 24 2a          	push   DWORD PTR [esp+0x2a]
    ef83:	e8 08 ce ff ff       	call   bd90 <_Z6putstrPc>
    ef88:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    ef8c:	83 c4 10             	add    esp,0x10
    ef8f:	8d 74 0d 02          	lea    esi,[ebp+ecx*1+0x2]
    ef93:	e9 6d ff ff ff       	jmp    ef05 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x125>
    ef98:	90                   	nop
    ef99:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    efa0:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    efa4:	83 ec 0c             	sub    esp,0xc
    efa7:	53                   	push   ebx
    efa8:	e8 73 cd ff ff       	call   bd20 <_Z6putbini>
    efad:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    efb1:	83 c4 10             	add    esp,0x10
    efb4:	8d 74 0d 02          	lea    esi,[ebp+ecx*1+0x2]
    efb8:	e9 48 ff ff ff       	jmp    ef05 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x125>
    efbd:	8d 76 00             	lea    esi,[esi+0x0]
    efc0:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    efc4:	83 ec 0c             	sub    esp,0xc
    efc7:	53                   	push   ebx
    efc8:	e8 43 cd ff ff       	call   bd10 <_Z6putocti>
    efcd:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    efd1:	83 c4 10             	add    esp,0x10
    efd4:	8d 74 0d 02          	lea    esi,[ebp+ecx*1+0x2]
    efd8:	e9 28 ff ff ff       	jmp    ef05 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x125>
    efdd:	8d 76 00             	lea    esi,[esi+0x0]
    efe0:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    efe4:	83 ec 0c             	sub    esp,0xc
    efe7:	53                   	push   ebx
    efe8:	e8 03 cd ff ff       	call   bcf0 <_Z6puthexi>
    efed:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    eff1:	83 c4 10             	add    esp,0x10
    eff4:	8d 74 0d 02          	lea    esi,[ebp+ecx*1+0x2]
    eff8:	e9 08 ff ff ff       	jmp    ef05 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x125>
    effd:	8d 76 00             	lea    esi,[esi+0x0]
    f000:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    f004:	83 ec 0c             	sub    esp,0xc
    f007:	53                   	push   ebx
    f008:	e8 d3 cc ff ff       	call   bce0 <_Z6putdeci>
    f00d:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    f011:	83 c4 10             	add    esp,0x10
    f014:	8d 74 0d 02          	lea    esi,[ebp+ecx*1+0x2]
    f018:	e9 e8 fe ff ff       	jmp    ef05 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x125>
    f01d:	8d 76 00             	lea    esi,[esi+0x0]
    f020:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    f024:	83 ec 0c             	sub    esp,0xc
    f027:	68 64 01 01 00       	push   0x10164
    f02c:	e8 9f cd ff ff       	call   bdd0 <_Z6printfPKc>
    f031:	58                   	pop    eax
    f032:	ff 74 24 2a          	push   DWORD PTR [esp+0x2a]
    f036:	e8 b5 cc ff ff       	call   bcf0 <_Z6puthexi>
    f03b:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    f03f:	83 c4 10             	add    esp,0x10
    f042:	8d 74 0d 02          	lea    esi,[ebp+ecx*1+0x2]
    f046:	e9 ba fe ff ff       	jmp    ef05 <_Z6printfIPKcJtEEvS1_T_DpT0_+0x125>

Disassembly of section .text._Z6printfIPKcJiS1_tEEvS1_T_DpT0_:

0000f050 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_>:
    f050:	55                   	push   ebp
    f051:	57                   	push   edi
    f052:	31 ed                	xor    ebp,ebp
    f054:	56                   	push   esi
    f055:	53                   	push   ebx
    f056:	83 ec 2c             	sub    esp,0x2c
    f059:	8b 44 24 50          	mov    eax,DWORD PTR [esp+0x50]
    f05d:	8b 7c 24 40          	mov    edi,DWORD PTR [esp+0x40]
    f061:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    f065:	0f be 07             	movsx  eax,BYTE PTR [edi]
    f068:	84 c0                	test   al,al
    f06a:	74 4e                	je     f0ba <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x6a>
    f06c:	8d 5d 01             	lea    ebx,[ebp+0x1]
    f06f:	3c 25                	cmp    al,0x25
    f071:	8d 34 1f             	lea    esi,[edi+ebx*1]
    f074:	75 31                	jne    f0a7 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x57>
    f076:	8d 76 00             	lea    esi,[esi+0x0]
    f079:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    f080:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    f083:	3c 25                	cmp    al,0x25
    f085:	0f 84 f5 00 00 00    	je     f180 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x130>
    f08b:	84 c0                	test   al,al
    f08d:	75 39                	jne    f0c8 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x78>
    f08f:	0f be 44 2f 02       	movsx  eax,BYTE PTR [edi+ebp*1+0x2]
    f094:	8d 5d 02             	lea    ebx,[ebp+0x2]
    f097:	84 c0                	test   al,al
    f099:	74 1f                	je     f0ba <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x6a>
    f09b:	89 dd                	mov    ebp,ebx
    f09d:	8d 5d 01             	lea    ebx,[ebp+0x1]
    f0a0:	3c 25                	cmp    al,0x25
    f0a2:	8d 34 1f             	lea    esi,[edi+ebx*1]
    f0a5:	74 d9                	je     f080 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x30>
    f0a7:	83 ec 0c             	sub    esp,0xc
    f0aa:	50                   	push   eax
    f0ab:	e8 20 cc ff ff       	call   bcd0 <_Z7putcharc>
    f0b0:	0f be 06             	movsx  eax,BYTE PTR [esi]
    f0b3:	83 c4 10             	add    esp,0x10
    f0b6:	84 c0                	test   al,al
    f0b8:	75 e1                	jne    f09b <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x4b>
    f0ba:	83 c4 2c             	add    esp,0x2c
    f0bd:	5b                   	pop    ebx
    f0be:	5e                   	pop    esi
    f0bf:	5f                   	pop    edi
    f0c0:	5d                   	pop    ebp
    f0c1:	c3                   	ret    
    f0c2:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    f0c8:	83 ec 08             	sub    esp,0x8
    f0cb:	8d 44 24 4c          	lea    eax,[esp+0x4c]
    f0cf:	50                   	push   eax
    f0d0:	56                   	push   esi
    f0d1:	e8 fa dd ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    f0d6:	01 c3                	add    ebx,eax
    f0d8:	8b 44 24 58          	mov    eax,DWORD PTR [esp+0x58]
    f0dc:	0f b7 54 24 1c       	movzx  edx,WORD PTR [esp+0x1c]
    f0e1:	01 df                	add    edi,ebx
    f0e3:	89 44 24 2c          	mov    DWORD PTR [esp+0x2c],eax
    f0e7:	0f be 07             	movsx  eax,BYTE PTR [edi]
    f0ea:	89 54 24 1c          	mov    DWORD PTR [esp+0x1c],edx
    f0ee:	83 c4 10             	add    esp,0x10
    f0f1:	84 c0                	test   al,al
    f0f3:	74 c5                	je     f0ba <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x6a>
    f0f5:	31 db                	xor    ebx,ebx
    f0f7:	3c 25                	cmp    al,0x25
    f0f9:	8d 6b 01             	lea    ebp,[ebx+0x1]
    f0fc:	8d 34 2f             	lea    esi,[edi+ebp*1]
    f0ff:	75 2e                	jne    f12f <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0xdf>
    f101:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    f108:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    f10b:	3c 25                	cmp    al,0x25
    f10d:	0f 84 95 00 00 00    	je     f1a8 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x158>
    f113:	84 c0                	test   al,al
    f115:	75 39                	jne    f150 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x100>
    f117:	0f be 44 1f 02       	movsx  eax,BYTE PTR [edi+ebx*1+0x2]
    f11c:	8d 6b 02             	lea    ebp,[ebx+0x2]
    f11f:	84 c0                	test   al,al
    f121:	74 97                	je     f0ba <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x6a>
    f123:	89 eb                	mov    ebx,ebp
    f125:	8d 6b 01             	lea    ebp,[ebx+0x1]
    f128:	3c 25                	cmp    al,0x25
    f12a:	8d 34 2f             	lea    esi,[edi+ebp*1]
    f12d:	74 d9                	je     f108 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0xb8>
    f12f:	83 ec 0c             	sub    esp,0xc
    f132:	50                   	push   eax
    f133:	e8 98 cb ff ff       	call   bcd0 <_Z7putcharc>
    f138:	0f be 06             	movsx  eax,BYTE PTR [esi]
    f13b:	83 c4 10             	add    esp,0x10
    f13e:	84 c0                	test   al,al
    f140:	0f 84 74 ff ff ff    	je     f0ba <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x6a>
    f146:	89 eb                	mov    ebx,ebp
    f148:	eb db                	jmp    f125 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0xd5>
    f14a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    f150:	83 ec 08             	sub    esp,0x8
    f153:	8d 44 24 24          	lea    eax,[esp+0x24]
    f157:	50                   	push   eax
    f158:	56                   	push   esi
    f159:	e8 72 de ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    f15e:	01 c5                	add    ebp,eax
    f160:	83 c4 0c             	add    esp,0xc
    f163:	01 ef                	add    edi,ebp
    f165:	ff 74 24 10          	push   DWORD PTR [esp+0x10]
    f169:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    f16d:	57                   	push   edi
    f16e:	e8 6d fc ff ff       	call   ede0 <_Z6printfIPKcJtEEvS1_T_DpT0_>
    f173:	83 c4 10             	add    esp,0x10
    f176:	83 c4 2c             	add    esp,0x2c
    f179:	5b                   	pop    ebx
    f17a:	5e                   	pop    esi
    f17b:	5f                   	pop    edi
    f17c:	5d                   	pop    ebp
    f17d:	c3                   	ret    
    f17e:	66 90                	xchg   ax,ax
    f180:	83 ec 0c             	sub    esp,0xc
    f183:	8d 5d 02             	lea    ebx,[ebp+0x2]
    f186:	6a 25                	push   0x25
    f188:	e8 43 cb ff ff       	call   bcd0 <_Z7putcharc>
    f18d:	0f be 44 2f 02       	movsx  eax,BYTE PTR [edi+ebp*1+0x2]
    f192:	83 c4 10             	add    esp,0x10
    f195:	84 c0                	test   al,al
    f197:	0f 84 1d ff ff ff    	je     f0ba <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x6a>
    f19d:	89 dd                	mov    ebp,ebx
    f19f:	e9 f9 fe ff ff       	jmp    f09d <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x4d>
    f1a4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f1a8:	83 ec 0c             	sub    esp,0xc
    f1ab:	8d 6b 02             	lea    ebp,[ebx+0x2]
    f1ae:	6a 25                	push   0x25
    f1b0:	e8 1b cb ff ff       	call   bcd0 <_Z7putcharc>
    f1b5:	0f be 44 1f 02       	movsx  eax,BYTE PTR [edi+ebx*1+0x2]
    f1ba:	83 c4 10             	add    esp,0x10
    f1bd:	84 c0                	test   al,al
    f1bf:	0f 84 f5 fe ff ff    	je     f0ba <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0x6a>
    f1c5:	89 eb                	mov    ebx,ebp
    f1c7:	e9 59 ff ff ff       	jmp    f125 <_Z6printfIPKcJiS1_tEEvS1_T_DpT0_+0xd5>

Disassembly of section .text._Z6printfIjJjjEEvPKcT_DpT0_:

0000f1d0 <_Z6printfIjJjjEEvPKcT_DpT0_>:
    f1d0:	55                   	push   ebp
    f1d1:	57                   	push   edi
    f1d2:	56                   	push   esi
    f1d3:	53                   	push   ebx
    f1d4:	31 f6                	xor    esi,esi
    f1d6:	83 ec 1c             	sub    esp,0x1c
    f1d9:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    f1dd:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f1e1:	84 c0                	test   al,al
    f1e3:	74 46                	je     f22b <_Z6printfIjJjjEEvPKcT_DpT0_+0x5b>
    f1e5:	8d 5e 01             	lea    ebx,[esi+0x1]
    f1e8:	3c 25                	cmp    al,0x25
    f1ea:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    f1ee:	75 28                	jne    f218 <_Z6printfIjJjjEEvPKcT_DpT0_+0x48>
    f1f0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    f1f3:	3c 25                	cmp    al,0x25
    f1f5:	0f 84 ed 00 00 00    	je     f2e8 <_Z6printfIjJjjEEvPKcT_DpT0_+0x118>
    f1fb:	84 c0                	test   al,al
    f1fd:	75 39                	jne    f238 <_Z6printfIjJjjEEvPKcT_DpT0_+0x68>
    f1ff:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    f204:	8d 5e 02             	lea    ebx,[esi+0x2]
    f207:	84 c0                	test   al,al
    f209:	74 20                	je     f22b <_Z6printfIjJjjEEvPKcT_DpT0_+0x5b>
    f20b:	89 de                	mov    esi,ebx
    f20d:	8d 5e 01             	lea    ebx,[esi+0x1]
    f210:	3c 25                	cmp    al,0x25
    f212:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    f216:	74 d8                	je     f1f0 <_Z6printfIjJjjEEvPKcT_DpT0_+0x20>
    f218:	83 ec 0c             	sub    esp,0xc
    f21b:	50                   	push   eax
    f21c:	e8 af ca ff ff       	call   bcd0 <_Z7putcharc>
    f221:	0f be 07             	movsx  eax,BYTE PTR [edi]
    f224:	83 c4 10             	add    esp,0x10
    f227:	84 c0                	test   al,al
    f229:	75 e0                	jne    f20b <_Z6printfIjJjjEEvPKcT_DpT0_+0x3b>
    f22b:	83 c4 1c             	add    esp,0x1c
    f22e:	5b                   	pop    ebx
    f22f:	5e                   	pop    esi
    f230:	5f                   	pop    edi
    f231:	5d                   	pop    ebp
    f232:	c3                   	ret    
    f233:	90                   	nop
    f234:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f238:	83 ec 08             	sub    esp,0x8
    f23b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    f23f:	50                   	push   eax
    f240:	57                   	push   edi
    f241:	e8 4a e4 ff ff       	call   d690 <_Z14_manage_escapeIjEiPKcPT_>
    f246:	01 c3                	add    ebx,eax
    f248:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    f24c:	01 eb                	add    ebx,ebp
    f24e:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    f252:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    f255:	83 c4 10             	add    esp,0x10
    f258:	84 c0                	test   al,al
    f25a:	74 cf                	je     f22b <_Z6printfIjJjjEEvPKcT_DpT0_+0x5b>
    f25c:	31 ff                	xor    edi,edi
    f25e:	3c 25                	cmp    al,0x25
    f260:	8d 77 01             	lea    esi,[edi+0x1]
    f263:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    f266:	75 30                	jne    f298 <_Z6printfIjJjjEEvPKcT_DpT0_+0xc8>
    f268:	90                   	nop
    f269:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    f270:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    f274:	3c 25                	cmp    al,0x25
    f276:	0f 84 94 00 00 00    	je     f310 <_Z6printfIjJjjEEvPKcT_DpT0_+0x140>
    f27c:	84 c0                	test   al,al
    f27e:	75 38                	jne    f2b8 <_Z6printfIjJjjEEvPKcT_DpT0_+0xe8>
    f280:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    f285:	8d 77 02             	lea    esi,[edi+0x2]
    f288:	84 c0                	test   al,al
    f28a:	74 9f                	je     f22b <_Z6printfIjJjjEEvPKcT_DpT0_+0x5b>
    f28c:	89 f7                	mov    edi,esi
    f28e:	8d 77 01             	lea    esi,[edi+0x1]
    f291:	3c 25                	cmp    al,0x25
    f293:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    f296:	74 d8                	je     f270 <_Z6printfIjJjjEEvPKcT_DpT0_+0xa0>
    f298:	83 ec 0c             	sub    esp,0xc
    f29b:	50                   	push   eax
    f29c:	e8 2f ca ff ff       	call   bcd0 <_Z7putcharc>
    f2a1:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f2a5:	83 c4 10             	add    esp,0x10
    f2a8:	84 c0                	test   al,al
    f2aa:	0f 84 7b ff ff ff    	je     f22b <_Z6printfIjJjjEEvPKcT_DpT0_+0x5b>
    f2b0:	89 f7                	mov    edi,esi
    f2b2:	eb da                	jmp    f28e <_Z6printfIjJjjEEvPKcT_DpT0_+0xbe>
    f2b4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f2b8:	83 ec 08             	sub    esp,0x8
    f2bb:	8d 44 24 14          	lea    eax,[esp+0x14]
    f2bf:	50                   	push   eax
    f2c0:	55                   	push   ebp
    f2c1:	e8 ca e3 ff ff       	call   d690 <_Z14_manage_escapeIjEiPKcPT_>
    f2c6:	5a                   	pop    edx
    f2c7:	01 c6                	add    esi,eax
    f2c9:	59                   	pop    ecx
    f2ca:	01 f3                	add    ebx,esi
    f2cc:	ff 74 24 44          	push   DWORD PTR [esp+0x44]
    f2d0:	53                   	push   ebx
    f2d1:	e8 ba e4 ff ff       	call   d790 <_Z6printfIjJEEvPKcT_DpT0_>
    f2d6:	83 c4 10             	add    esp,0x10
    f2d9:	83 c4 1c             	add    esp,0x1c
    f2dc:	5b                   	pop    ebx
    f2dd:	5e                   	pop    esi
    f2de:	5f                   	pop    edi
    f2df:	5d                   	pop    ebp
    f2e0:	c3                   	ret    
    f2e1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    f2e8:	83 ec 0c             	sub    esp,0xc
    f2eb:	8d 5e 02             	lea    ebx,[esi+0x2]
    f2ee:	6a 25                	push   0x25
    f2f0:	e8 db c9 ff ff       	call   bcd0 <_Z7putcharc>
    f2f5:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    f2fa:	83 c4 10             	add    esp,0x10
    f2fd:	84 c0                	test   al,al
    f2ff:	0f 84 26 ff ff ff    	je     f22b <_Z6printfIjJjjEEvPKcT_DpT0_+0x5b>
    f305:	89 de                	mov    esi,ebx
    f307:	e9 01 ff ff ff       	jmp    f20d <_Z6printfIjJjjEEvPKcT_DpT0_+0x3d>
    f30c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f310:	83 ec 0c             	sub    esp,0xc
    f313:	8d 77 02             	lea    esi,[edi+0x2]
    f316:	6a 25                	push   0x25
    f318:	e8 b3 c9 ff ff       	call   bcd0 <_Z7putcharc>
    f31d:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    f322:	83 c4 10             	add    esp,0x10
    f325:	84 c0                	test   al,al
    f327:	0f 84 fe fe ff ff    	je     f22b <_Z6printfIjJjjEEvPKcT_DpT0_+0x5b>
    f32d:	89 f7                	mov    edi,esi
    f32f:	e9 5a ff ff ff       	jmp    f28e <_Z6printfIjJjjEEvPKcT_DpT0_+0xbe>

Disassembly of section .text._Z6printfIPKcJjjjjEEvS1_T_DpT0_:

0000f340 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_>:
    f340:	55                   	push   ebp
    f341:	57                   	push   edi
    f342:	56                   	push   esi
    f343:	53                   	push   ebx
    f344:	31 f6                	xor    esi,esi
    f346:	83 ec 1c             	sub    esp,0x1c
    f349:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    f34d:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f351:	84 c0                	test   al,al
    f353:	74 46                	je     f39b <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x5b>
    f355:	8d 5e 01             	lea    ebx,[esi+0x1]
    f358:	3c 25                	cmp    al,0x25
    f35a:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    f35e:	75 28                	jne    f388 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x48>
    f360:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    f363:	3c 25                	cmp    al,0x25
    f365:	0f 84 f5 00 00 00    	je     f460 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x120>
    f36b:	84 c0                	test   al,al
    f36d:	75 39                	jne    f3a8 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x68>
    f36f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    f374:	8d 5e 02             	lea    ebx,[esi+0x2]
    f377:	84 c0                	test   al,al
    f379:	74 20                	je     f39b <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x5b>
    f37b:	89 de                	mov    esi,ebx
    f37d:	8d 5e 01             	lea    ebx,[esi+0x1]
    f380:	3c 25                	cmp    al,0x25
    f382:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    f386:	74 d8                	je     f360 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x20>
    f388:	83 ec 0c             	sub    esp,0xc
    f38b:	50                   	push   eax
    f38c:	e8 3f c9 ff ff       	call   bcd0 <_Z7putcharc>
    f391:	0f be 07             	movsx  eax,BYTE PTR [edi]
    f394:	83 c4 10             	add    esp,0x10
    f397:	84 c0                	test   al,al
    f399:	75 e0                	jne    f37b <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x3b>
    f39b:	83 c4 1c             	add    esp,0x1c
    f39e:	5b                   	pop    ebx
    f39f:	5e                   	pop    esi
    f3a0:	5f                   	pop    edi
    f3a1:	5d                   	pop    ebp
    f3a2:	c3                   	ret    
    f3a3:	90                   	nop
    f3a4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f3a8:	83 ec 08             	sub    esp,0x8
    f3ab:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    f3af:	50                   	push   eax
    f3b0:	57                   	push   edi
    f3b1:	e8 1a db ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    f3b6:	01 c3                	add    ebx,eax
    f3b8:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    f3bc:	01 eb                	add    ebx,ebp
    f3be:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    f3c2:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    f3c5:	83 c4 10             	add    esp,0x10
    f3c8:	84 c0                	test   al,al
    f3ca:	74 cf                	je     f39b <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x5b>
    f3cc:	31 ff                	xor    edi,edi
    f3ce:	3c 25                	cmp    al,0x25
    f3d0:	8d 77 01             	lea    esi,[edi+0x1]
    f3d3:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    f3d6:	75 30                	jne    f408 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0xc8>
    f3d8:	90                   	nop
    f3d9:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    f3e0:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    f3e4:	3c 25                	cmp    al,0x25
    f3e6:	0f 84 9c 00 00 00    	je     f488 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x148>
    f3ec:	84 c0                	test   al,al
    f3ee:	75 38                	jne    f428 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0xe8>
    f3f0:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    f3f5:	8d 77 02             	lea    esi,[edi+0x2]
    f3f8:	84 c0                	test   al,al
    f3fa:	74 9f                	je     f39b <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x5b>
    f3fc:	89 f7                	mov    edi,esi
    f3fe:	8d 77 01             	lea    esi,[edi+0x1]
    f401:	3c 25                	cmp    al,0x25
    f403:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    f406:	74 d8                	je     f3e0 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0xa0>
    f408:	83 ec 0c             	sub    esp,0xc
    f40b:	50                   	push   eax
    f40c:	e8 bf c8 ff ff       	call   bcd0 <_Z7putcharc>
    f411:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f415:	83 c4 10             	add    esp,0x10
    f418:	84 c0                	test   al,al
    f41a:	0f 84 7b ff ff ff    	je     f39b <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x5b>
    f420:	89 f7                	mov    edi,esi
    f422:	eb da                	jmp    f3fe <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0xbe>
    f424:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f428:	83 ec 08             	sub    esp,0x8
    f42b:	8d 44 24 14          	lea    eax,[esp+0x14]
    f42f:	50                   	push   eax
    f430:	55                   	push   ebp
    f431:	e8 5a e2 ff ff       	call   d690 <_Z14_manage_escapeIjEiPKcPT_>
    f436:	01 c6                	add    esi,eax
    f438:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    f43c:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    f440:	01 f3                	add    ebx,esi
    f442:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    f446:	53                   	push   ebx
    f447:	e8 84 fd ff ff       	call   f1d0 <_Z6printfIjJjjEEvPKcT_DpT0_>
    f44c:	83 c4 20             	add    esp,0x20
    f44f:	83 c4 1c             	add    esp,0x1c
    f452:	5b                   	pop    ebx
    f453:	5e                   	pop    esi
    f454:	5f                   	pop    edi
    f455:	5d                   	pop    ebp
    f456:	c3                   	ret    
    f457:	89 f6                	mov    esi,esi
    f459:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    f460:	83 ec 0c             	sub    esp,0xc
    f463:	8d 5e 02             	lea    ebx,[esi+0x2]
    f466:	6a 25                	push   0x25
    f468:	e8 63 c8 ff ff       	call   bcd0 <_Z7putcharc>
    f46d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    f472:	83 c4 10             	add    esp,0x10
    f475:	84 c0                	test   al,al
    f477:	0f 84 1e ff ff ff    	je     f39b <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x5b>
    f47d:	89 de                	mov    esi,ebx
    f47f:	e9 f9 fe ff ff       	jmp    f37d <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x3d>
    f484:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f488:	83 ec 0c             	sub    esp,0xc
    f48b:	8d 77 02             	lea    esi,[edi+0x2]
    f48e:	6a 25                	push   0x25
    f490:	e8 3b c8 ff ff       	call   bcd0 <_Z7putcharc>
    f495:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    f49a:	83 c4 10             	add    esp,0x10
    f49d:	84 c0                	test   al,al
    f49f:	0f 84 f6 fe ff ff    	je     f39b <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0x5b>
    f4a5:	89 f7                	mov    edi,esi
    f4a7:	e9 52 ff ff ff       	jmp    f3fe <_Z6printfIPKcJjjjjEEvS1_T_DpT0_+0xbe>

Disassembly of section .text._Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_:

0000f4b0 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_>:
    f4b0:	55                   	push   ebp
    f4b1:	57                   	push   edi
    f4b2:	56                   	push   esi
    f4b3:	53                   	push   ebx
    f4b4:	31 f6                	xor    esi,esi
    f4b6:	83 ec 1c             	sub    esp,0x1c
    f4b9:	8b 6c 24 30          	mov    ebp,DWORD PTR [esp+0x30]
    f4bd:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f4c1:	84 c0                	test   al,al
    f4c3:	74 46                	je     f50b <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x5b>
    f4c5:	8d 5e 01             	lea    ebx,[esi+0x1]
    f4c8:	3c 25                	cmp    al,0x25
    f4ca:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    f4ce:	75 28                	jne    f4f8 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x48>
    f4d0:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    f4d3:	3c 25                	cmp    al,0x25
    f4d5:	0f 84 fd 00 00 00    	je     f5d8 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x128>
    f4db:	84 c0                	test   al,al
    f4dd:	75 39                	jne    f518 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x68>
    f4df:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    f4e4:	8d 5e 02             	lea    ebx,[esi+0x2]
    f4e7:	84 c0                	test   al,al
    f4e9:	74 20                	je     f50b <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x5b>
    f4eb:	89 de                	mov    esi,ebx
    f4ed:	8d 5e 01             	lea    ebx,[esi+0x1]
    f4f0:	3c 25                	cmp    al,0x25
    f4f2:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    f4f6:	74 d8                	je     f4d0 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x20>
    f4f8:	83 ec 0c             	sub    esp,0xc
    f4fb:	50                   	push   eax
    f4fc:	e8 cf c7 ff ff       	call   bcd0 <_Z7putcharc>
    f501:	0f be 07             	movsx  eax,BYTE PTR [edi]
    f504:	83 c4 10             	add    esp,0x10
    f507:	84 c0                	test   al,al
    f509:	75 e0                	jne    f4eb <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x3b>
    f50b:	83 c4 1c             	add    esp,0x1c
    f50e:	5b                   	pop    ebx
    f50f:	5e                   	pop    esi
    f510:	5f                   	pop    edi
    f511:	5d                   	pop    ebp
    f512:	c3                   	ret    
    f513:	90                   	nop
    f514:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f518:	83 ec 08             	sub    esp,0x8
    f51b:	8d 44 24 3c          	lea    eax,[esp+0x3c]
    f51f:	50                   	push   eax
    f520:	57                   	push   edi
    f521:	e8 aa d9 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    f526:	01 c3                	add    ebx,eax
    f528:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    f52c:	01 eb                	add    ebx,ebp
    f52e:	89 44 24 1c          	mov    DWORD PTR [esp+0x1c],eax
    f532:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    f535:	83 c4 10             	add    esp,0x10
    f538:	84 c0                	test   al,al
    f53a:	74 cf                	je     f50b <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x5b>
    f53c:	31 ff                	xor    edi,edi
    f53e:	3c 25                	cmp    al,0x25
    f540:	8d 77 01             	lea    esi,[edi+0x1]
    f543:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    f546:	75 30                	jne    f578 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0xc8>
    f548:	90                   	nop
    f549:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    f550:	0f b6 45 00          	movzx  eax,BYTE PTR [ebp+0x0]
    f554:	3c 25                	cmp    al,0x25
    f556:	0f 84 a4 00 00 00    	je     f600 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x150>
    f55c:	84 c0                	test   al,al
    f55e:	75 38                	jne    f598 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0xe8>
    f560:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    f565:	8d 77 02             	lea    esi,[edi+0x2]
    f568:	84 c0                	test   al,al
    f56a:	74 9f                	je     f50b <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x5b>
    f56c:	89 f7                	mov    edi,esi
    f56e:	8d 77 01             	lea    esi,[edi+0x1]
    f571:	3c 25                	cmp    al,0x25
    f573:	8d 2c 33             	lea    ebp,[ebx+esi*1]
    f576:	74 d8                	je     f550 <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0xa0>
    f578:	83 ec 0c             	sub    esp,0xc
    f57b:	50                   	push   eax
    f57c:	e8 4f c7 ff ff       	call   bcd0 <_Z7putcharc>
    f581:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f585:	83 c4 10             	add    esp,0x10
    f588:	84 c0                	test   al,al
    f58a:	0f 84 7b ff ff ff    	je     f50b <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x5b>
    f590:	89 f7                	mov    edi,esi
    f592:	eb da                	jmp    f56e <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0xbe>
    f594:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f598:	83 ec 08             	sub    esp,0x8
    f59b:	8d 44 24 14          	lea    eax,[esp+0x14]
    f59f:	50                   	push   eax
    f5a0:	55                   	push   ebp
    f5a1:	e8 2a da ff ff       	call   cfd0 <_Z14_manage_escapeIiEiPKcPT_>
    f5a6:	5a                   	pop    edx
    f5a7:	01 c6                	add    esi,eax
    f5a9:	59                   	pop    ecx
    f5aa:	01 f3                	add    ebx,esi
    f5ac:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    f5b0:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    f5b4:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    f5b8:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    f5bc:	ff 74 24 54          	push   DWORD PTR [esp+0x54]
    f5c0:	53                   	push   ebx
    f5c1:	e8 7a fd ff ff       	call   f340 <_Z6printfIPKcJjjjjEEvS1_T_DpT0_>
    f5c6:	83 c4 20             	add    esp,0x20
    f5c9:	83 c4 1c             	add    esp,0x1c
    f5cc:	5b                   	pop    ebx
    f5cd:	5e                   	pop    esi
    f5ce:	5f                   	pop    edi
    f5cf:	5d                   	pop    ebp
    f5d0:	c3                   	ret    
    f5d1:	8d b4 26 00 00 00 00 	lea    esi,[esi+eiz*1+0x0]
    f5d8:	83 ec 0c             	sub    esp,0xc
    f5db:	8d 5e 02             	lea    ebx,[esi+0x2]
    f5de:	6a 25                	push   0x25
    f5e0:	e8 eb c6 ff ff       	call   bcd0 <_Z7putcharc>
    f5e5:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    f5ea:	83 c4 10             	add    esp,0x10
    f5ed:	84 c0                	test   al,al
    f5ef:	0f 84 16 ff ff ff    	je     f50b <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x5b>
    f5f5:	89 de                	mov    esi,ebx
    f5f7:	e9 f1 fe ff ff       	jmp    f4ed <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x3d>
    f5fc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f600:	83 ec 0c             	sub    esp,0xc
    f603:	8d 77 02             	lea    esi,[edi+0x2]
    f606:	6a 25                	push   0x25
    f608:	e8 c3 c6 ff ff       	call   bcd0 <_Z7putcharc>
    f60d:	0f be 44 3b 02       	movsx  eax,BYTE PTR [ebx+edi*1+0x2]
    f612:	83 c4 10             	add    esp,0x10
    f615:	84 c0                	test   al,al
    f617:	0f 84 ee fe ff ff    	je     f50b <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0x5b>
    f61d:	89 f7                	mov    edi,esi
    f61f:	e9 4a ff ff ff       	jmp    f56e <_Z6printfIPKcJiS1_jjjjEEvS1_T_DpT0_+0xbe>

Disassembly of section .text._Z14_manage_escapeIhEiPKcPT_:

0000f630 <_Z14_manage_escapeIhEiPKcPT_>:
    f630:	83 ec 0c             	sub    esp,0xc
    f633:	8b 44 24 10          	mov    eax,DWORD PTR [esp+0x10]
    f637:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    f63a:	83 e8 42             	sub    eax,0x42
    f63d:	3c 36                	cmp    al,0x36
    f63f:	0f 87 f3 00 00 00    	ja     f738 <_Z14_manage_escapeIhEiPKcPT_+0x108>
    f645:	0f b6 c0             	movzx  eax,al
    f648:	ff 24 85 3c 30 01 00 	jmp    DWORD PTR [eax*4+0x1303c]
    f64f:	90                   	nop
    f650:	83 ec 0c             	sub    esp,0xc
    f653:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    f657:	ff 30                	push   DWORD PTR [eax]
    f659:	e8 32 c7 ff ff       	call   bd90 <_Z6putstrPc>
    f65e:	83 c4 10             	add    esp,0x10
    f661:	b8 01 00 00 00       	mov    eax,0x1
    f666:	83 c4 0c             	add    esp,0xc
    f669:	c3                   	ret    
    f66a:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    f670:	83 ec 0c             	sub    esp,0xc
    f673:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    f677:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    f67a:	50                   	push   eax
    f67b:	e8 a0 c6 ff ff       	call   bd20 <_Z6putbini>
    f680:	83 c4 10             	add    esp,0x10
    f683:	b8 01 00 00 00       	mov    eax,0x1
    f688:	83 c4 0c             	add    esp,0xc
    f68b:	c3                   	ret    
    f68c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f690:	83 ec 0c             	sub    esp,0xc
    f693:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    f697:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    f69a:	50                   	push   eax
    f69b:	e8 70 c6 ff ff       	call   bd10 <_Z6putocti>
    f6a0:	83 c4 10             	add    esp,0x10
    f6a3:	b8 01 00 00 00       	mov    eax,0x1
    f6a8:	83 c4 0c             	add    esp,0xc
    f6ab:	c3                   	ret    
    f6ac:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f6b0:	83 ec 0c             	sub    esp,0xc
    f6b3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    f6b7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    f6ba:	50                   	push   eax
    f6bb:	e8 30 c6 ff ff       	call   bcf0 <_Z6puthexi>
    f6c0:	83 c4 10             	add    esp,0x10
    f6c3:	b8 01 00 00 00       	mov    eax,0x1
    f6c8:	83 c4 0c             	add    esp,0xc
    f6cb:	c3                   	ret    
    f6cc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f6d0:	83 ec 0c             	sub    esp,0xc
    f6d3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    f6d7:	0f be 00             	movsx  eax,BYTE PTR [eax]
    f6da:	50                   	push   eax
    f6db:	e8 f0 c5 ff ff       	call   bcd0 <_Z7putcharc>
    f6e0:	83 c4 10             	add    esp,0x10
    f6e3:	b8 01 00 00 00       	mov    eax,0x1
    f6e8:	83 c4 0c             	add    esp,0xc
    f6eb:	c3                   	ret    
    f6ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f6f0:	83 ec 0c             	sub    esp,0xc
    f6f3:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    f6f7:	0f b6 00             	movzx  eax,BYTE PTR [eax]
    f6fa:	50                   	push   eax
    f6fb:	e8 e0 c5 ff ff       	call   bce0 <_Z6putdeci>
    f700:	83 c4 10             	add    esp,0x10
    f703:	b8 01 00 00 00       	mov    eax,0x1
    f708:	83 c4 0c             	add    esp,0xc
    f70b:	c3                   	ret    
    f70c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f710:	83 ec 0c             	sub    esp,0xc
    f713:	68 64 01 01 00       	push   0x10164
    f718:	e8 b3 c6 ff ff       	call   bdd0 <_Z6printfPKc>
    f71d:	58                   	pop    eax
    f71e:	8b 44 24 20          	mov    eax,DWORD PTR [esp+0x20]
    f722:	ff 30                	push   DWORD PTR [eax]
    f724:	e8 c7 c5 ff ff       	call   bcf0 <_Z6puthexi>
    f729:	83 c4 10             	add    esp,0x10
    f72c:	b8 01 00 00 00       	mov    eax,0x1
    f731:	83 c4 0c             	add    esp,0xc
    f734:	c3                   	ret    
    f735:	8d 76 00             	lea    esi,[esi+0x0]
    f738:	31 c0                	xor    eax,eax
    f73a:	e9 27 ff ff ff       	jmp    f666 <_Z14_manage_escapeIhEiPKcPT_+0x36>

Disassembly of section .text._Z6printfIhJhhEEvPKcT_DpT0_:

0000f740 <_Z6printfIhJhhEEvPKcT_DpT0_>:
    f740:	55                   	push   ebp
    f741:	57                   	push   edi
    f742:	31 c9                	xor    ecx,ecx
    f744:	56                   	push   esi
    f745:	53                   	push   ebx
    f746:	83 ec 2c             	sub    esp,0x2c
    f749:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    f74d:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    f751:	8b 5c 24 48          	mov    ebx,DWORD PTR [esp+0x48]
    f755:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    f759:	8b 44 24 44          	mov    eax,DWORD PTR [esp+0x44]
    f75d:	88 44 24 0c          	mov    BYTE PTR [esp+0xc],al
    f761:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f765:	84 c0                	test   al,al
    f767:	74 4a                	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f769:	8d 79 01             	lea    edi,[ecx+0x1]
    f76c:	3c 25                	cmp    al,0x25
    f76e:	8d 74 3d 00          	lea    esi,[ebp+edi*1+0x0]
    f772:	75 2c                	jne    f7a0 <_Z6printfIhJhhEEvPKcT_DpT0_+0x60>
    f774:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f778:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    f77b:	3c 25                	cmp    al,0x25
    f77d:	0f 84 3d 01 00 00    	je     f8c0 <_Z6printfIhJhhEEvPKcT_DpT0_+0x180>
    f783:	84 c0                	test   al,al
    f785:	75 39                	jne    f7c0 <_Z6printfIhJhhEEvPKcT_DpT0_+0x80>
    f787:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    f78c:	8d 79 02             	lea    edi,[ecx+0x2]
    f78f:	84 c0                	test   al,al
    f791:	74 20                	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f793:	89 f9                	mov    ecx,edi
    f795:	8d 79 01             	lea    edi,[ecx+0x1]
    f798:	3c 25                	cmp    al,0x25
    f79a:	8d 74 3d 00          	lea    esi,[ebp+edi*1+0x0]
    f79e:	74 d8                	je     f778 <_Z6printfIhJhhEEvPKcT_DpT0_+0x38>
    f7a0:	83 ec 0c             	sub    esp,0xc
    f7a3:	50                   	push   eax
    f7a4:	e8 27 c5 ff ff       	call   bcd0 <_Z7putcharc>
    f7a9:	0f be 06             	movsx  eax,BYTE PTR [esi]
    f7ac:	83 c4 10             	add    esp,0x10
    f7af:	84 c0                	test   al,al
    f7b1:	75 e0                	jne    f793 <_Z6printfIhJhhEEvPKcT_DpT0_+0x53>
    f7b3:	83 c4 2c             	add    esp,0x2c
    f7b6:	5b                   	pop    ebx
    f7b7:	5e                   	pop    esi
    f7b8:	5f                   	pop    edi
    f7b9:	5d                   	pop    ebp
    f7ba:	c3                   	ret    
    f7bb:	90                   	nop
    f7bc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f7c0:	83 ec 08             	sub    esp,0x8
    f7c3:	8d 44 24 14          	lea    eax,[esp+0x14]
    f7c7:	50                   	push   eax
    f7c8:	56                   	push   esi
    f7c9:	e8 62 fe ff ff       	call   f630 <_Z14_manage_escapeIhEiPKcPT_>
    f7ce:	01 c7                	add    edi,eax
    f7d0:	88 5c 24 2e          	mov    BYTE PTR [esp+0x2e],bl
    f7d4:	83 c4 10             	add    esp,0x10
    f7d7:	01 fd                	add    ebp,edi
    f7d9:	31 ff                	xor    edi,edi
    f7db:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f7df:	84 c0                	test   al,al
    f7e1:	74 d0                	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f7e3:	8d 77 01             	lea    esi,[edi+0x1]
    f7e6:	3c 25                	cmp    al,0x25
    f7e8:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    f7ec:	75 2a                	jne    f818 <_Z6printfIhJhhEEvPKcT_DpT0_+0xd8>
    f7ee:	66 90                	xchg   ax,ax
    f7f0:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    f7f3:	3c 25                	cmp    al,0x25
    f7f5:	0f 84 1d 01 00 00    	je     f918 <_Z6printfIhJhhEEvPKcT_DpT0_+0x1d8>
    f7fb:	84 c0                	test   al,al
    f7fd:	75 31                	jne    f830 <_Z6printfIhJhhEEvPKcT_DpT0_+0xf0>
    f7ff:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    f804:	8d 77 02             	lea    esi,[edi+0x2]
    f807:	84 c0                	test   al,al
    f809:	74 a8                	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f80b:	89 f7                	mov    edi,esi
    f80d:	8d 77 01             	lea    esi,[edi+0x1]
    f810:	3c 25                	cmp    al,0x25
    f812:	8d 5c 35 00          	lea    ebx,[ebp+esi*1+0x0]
    f816:	74 d8                	je     f7f0 <_Z6printfIhJhhEEvPKcT_DpT0_+0xb0>
    f818:	83 ec 0c             	sub    esp,0xc
    f81b:	50                   	push   eax
    f81c:	e8 af c4 ff ff       	call   bcd0 <_Z7putcharc>
    f821:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    f824:	83 c4 10             	add    esp,0x10
    f827:	84 c0                	test   al,al
    f829:	74 88                	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f82b:	89 f7                	mov    edi,esi
    f82d:	eb de                	jmp    f80d <_Z6printfIhJhhEEvPKcT_DpT0_+0xcd>
    f82f:	90                   	nop
    f830:	83 ec 08             	sub    esp,0x8
    f833:	8d 44 24 26          	lea    eax,[esp+0x26]
    f837:	50                   	push   eax
    f838:	53                   	push   ebx
    f839:	e8 f2 fd ff ff       	call   f630 <_Z14_manage_escapeIhEiPKcPT_>
    f83e:	01 c6                	add    esi,eax
    f840:	0f b6 44 24 14       	movzx  eax,BYTE PTR [esp+0x14]
    f845:	01 f5                	add    ebp,esi
    f847:	88 44 24 2f          	mov    BYTE PTR [esp+0x2f],al
    f84b:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f84f:	83 c4 10             	add    esp,0x10
    f852:	84 c0                	test   al,al
    f854:	0f 84 59 ff ff ff    	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f85a:	31 f6                	xor    esi,esi
    f85c:	3c 25                	cmp    al,0x25
    f85e:	8d 5e 01             	lea    ebx,[esi+0x1]
    f861:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    f865:	75 35                	jne    f89c <_Z6printfIhJhhEEvPKcT_DpT0_+0x15c>
    f867:	89 f6                	mov    esi,esi
    f869:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    f870:	0f b6 07             	movzx  eax,BYTE PTR [edi]
    f873:	3c 25                	cmp    al,0x25
    f875:	0f 84 c5 00 00 00    	je     f940 <_Z6printfIhJhhEEvPKcT_DpT0_+0x200>
    f87b:	84 c0                	test   al,al
    f87d:	75 71                	jne    f8f0 <_Z6printfIhJhhEEvPKcT_DpT0_+0x1b0>
    f87f:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    f884:	8d 5e 02             	lea    ebx,[esi+0x2]
    f887:	84 c0                	test   al,al
    f889:	0f 84 24 ff ff ff    	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f88f:	89 de                	mov    esi,ebx
    f891:	8d 5e 01             	lea    ebx,[esi+0x1]
    f894:	3c 25                	cmp    al,0x25
    f896:	8d 7c 1d 00          	lea    edi,[ebp+ebx*1+0x0]
    f89a:	74 d4                	je     f870 <_Z6printfIhJhhEEvPKcT_DpT0_+0x130>
    f89c:	83 ec 0c             	sub    esp,0xc
    f89f:	50                   	push   eax
    f8a0:	e8 2b c4 ff ff       	call   bcd0 <_Z7putcharc>
    f8a5:	0f be 07             	movsx  eax,BYTE PTR [edi]
    f8a8:	83 c4 10             	add    esp,0x10
    f8ab:	84 c0                	test   al,al
    f8ad:	0f 84 00 ff ff ff    	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f8b3:	89 de                	mov    esi,ebx
    f8b5:	eb da                	jmp    f891 <_Z6printfIhJhhEEvPKcT_DpT0_+0x151>
    f8b7:	89 f6                	mov    esi,esi
    f8b9:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    f8c0:	89 4c 24 08          	mov    DWORD PTR [esp+0x8],ecx
    f8c4:	83 ec 0c             	sub    esp,0xc
    f8c7:	6a 25                	push   0x25
    f8c9:	e8 02 c4 ff ff       	call   bcd0 <_Z7putcharc>
    f8ce:	8b 4c 24 18          	mov    ecx,DWORD PTR [esp+0x18]
    f8d2:	83 c4 10             	add    esp,0x10
    f8d5:	0f be 44 0d 02       	movsx  eax,BYTE PTR [ebp+ecx*1+0x2]
    f8da:	8d 79 02             	lea    edi,[ecx+0x2]
    f8dd:	84 c0                	test   al,al
    f8df:	0f 84 ce fe ff ff    	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f8e5:	89 f9                	mov    ecx,edi
    f8e7:	e9 a9 fe ff ff       	jmp    f795 <_Z6printfIhJhhEEvPKcT_DpT0_+0x55>
    f8ec:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f8f0:	83 ec 08             	sub    esp,0x8
    f8f3:	8d 44 24 27          	lea    eax,[esp+0x27]
    f8f7:	50                   	push   eax
    f8f8:	57                   	push   edi
    f8f9:	e8 32 fd ff ff       	call   f630 <_Z14_manage_escapeIhEiPKcPT_>
    f8fe:	01 c3                	add    ebx,eax
    f900:	01 dd                	add    ebp,ebx
    f902:	89 2c 24             	mov    DWORD PTR [esp],ebp
    f905:	e8 c6 c4 ff ff       	call   bdd0 <_Z6printfPKc>
    f90a:	83 c4 10             	add    esp,0x10
    f90d:	83 c4 2c             	add    esp,0x2c
    f910:	5b                   	pop    ebx
    f911:	5e                   	pop    esi
    f912:	5f                   	pop    edi
    f913:	5d                   	pop    ebp
    f914:	c3                   	ret    
    f915:	8d 76 00             	lea    esi,[esi+0x0]
    f918:	83 ec 0c             	sub    esp,0xc
    f91b:	8d 77 02             	lea    esi,[edi+0x2]
    f91e:	6a 25                	push   0x25
    f920:	e8 ab c3 ff ff       	call   bcd0 <_Z7putcharc>
    f925:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    f92a:	83 c4 10             	add    esp,0x10
    f92d:	84 c0                	test   al,al
    f92f:	0f 84 7e fe ff ff    	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f935:	89 f7                	mov    edi,esi
    f937:	e9 d1 fe ff ff       	jmp    f80d <_Z6printfIhJhhEEvPKcT_DpT0_+0xcd>
    f93c:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f940:	83 ec 0c             	sub    esp,0xc
    f943:	8d 5e 02             	lea    ebx,[esi+0x2]
    f946:	6a 25                	push   0x25
    f948:	e8 83 c3 ff ff       	call   bcd0 <_Z7putcharc>
    f94d:	0f be 44 35 02       	movsx  eax,BYTE PTR [ebp+esi*1+0x2]
    f952:	83 c4 10             	add    esp,0x10
    f955:	84 c0                	test   al,al
    f957:	0f 84 56 fe ff ff    	je     f7b3 <_Z6printfIhJhhEEvPKcT_DpT0_+0x73>
    f95d:	89 de                	mov    esi,ebx
    f95f:	e9 2d ff ff ff       	jmp    f891 <_Z6printfIhJhhEEvPKcT_DpT0_+0x151>

Disassembly of section .text._Z6printfIPKcJhhhhEEvS1_T_DpT0_:

0000f970 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_>:
    f970:	55                   	push   ebp
    f971:	57                   	push   edi
    f972:	31 ff                	xor    edi,edi
    f974:	56                   	push   esi
    f975:	53                   	push   ebx
    f976:	83 ec 2c             	sub    esp,0x2c
    f979:	8b 44 24 48          	mov    eax,DWORD PTR [esp+0x48]
    f97d:	8b 6c 24 40          	mov    ebp,DWORD PTR [esp+0x40]
    f981:	89 04 24             	mov    DWORD PTR [esp],eax
    f984:	8b 44 24 4c          	mov    eax,DWORD PTR [esp+0x4c]
    f988:	89 44 24 04          	mov    DWORD PTR [esp+0x4],eax
    f98c:	8b 44 24 50          	mov    eax,DWORD PTR [esp+0x50]
    f990:	89 44 24 08          	mov    DWORD PTR [esp+0x8],eax
    f994:	8b 44 24 54          	mov    eax,DWORD PTR [esp+0x54]
    f998:	89 44 24 0c          	mov    DWORD PTR [esp+0xc],eax
    f99c:	0f be 45 00          	movsx  eax,BYTE PTR [ebp+0x0]
    f9a0:	84 c0                	test   al,al
    f9a2:	74 47                	je     f9eb <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x7b>
    f9a4:	8d 5f 01             	lea    ebx,[edi+0x1]
    f9a7:	3c 25                	cmp    al,0x25
    f9a9:	8d 74 1d 00          	lea    esi,[ebp+ebx*1+0x0]
    f9ad:	75 29                	jne    f9d8 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x68>
    f9af:	90                   	nop
    f9b0:	0f b6 06             	movzx  eax,BYTE PTR [esi]
    f9b3:	3c 25                	cmp    al,0x25
    f9b5:	0f 84 15 01 00 00    	je     fad0 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x160>
    f9bb:	84 c0                	test   al,al
    f9bd:	75 39                	jne    f9f8 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x88>
    f9bf:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    f9c4:	8d 5f 02             	lea    ebx,[edi+0x2]
    f9c7:	84 c0                	test   al,al
    f9c9:	74 20                	je     f9eb <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x7b>
    f9cb:	89 df                	mov    edi,ebx
    f9cd:	8d 5f 01             	lea    ebx,[edi+0x1]
    f9d0:	3c 25                	cmp    al,0x25
    f9d2:	8d 74 1d 00          	lea    esi,[ebp+ebx*1+0x0]
    f9d6:	74 d8                	je     f9b0 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x40>
    f9d8:	83 ec 0c             	sub    esp,0xc
    f9db:	50                   	push   eax
    f9dc:	e8 ef c2 ff ff       	call   bcd0 <_Z7putcharc>
    f9e1:	0f be 06             	movsx  eax,BYTE PTR [esi]
    f9e4:	83 c4 10             	add    esp,0x10
    f9e7:	84 c0                	test   al,al
    f9e9:	75 e0                	jne    f9cb <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x5b>
    f9eb:	83 c4 2c             	add    esp,0x2c
    f9ee:	5b                   	pop    ebx
    f9ef:	5e                   	pop    esi
    f9f0:	5f                   	pop    edi
    f9f1:	5d                   	pop    ebp
    f9f2:	c3                   	ret    
    f9f3:	90                   	nop
    f9f4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    f9f8:	83 ec 08             	sub    esp,0x8
    f9fb:	8d 44 24 4c          	lea    eax,[esp+0x4c]
    f9ff:	50                   	push   eax
    fa00:	56                   	push   esi
    fa01:	e8 ca d4 ff ff       	call   ced0 <_Z14_manage_escapeIPKcEiS1_PT_>
    fa06:	01 c3                	add    ebx,eax
    fa08:	0f b6 44 24 10       	movzx  eax,BYTE PTR [esp+0x10]
    fa0d:	0f b6 4c 24 18       	movzx  ecx,BYTE PTR [esp+0x18]
    fa12:	01 eb                	add    ebx,ebp
    fa14:	0f b6 54 24 14       	movzx  edx,BYTE PTR [esp+0x14]
    fa19:	0f b6 74 24 1c       	movzx  esi,BYTE PTR [esp+0x1c]
    fa1e:	88 44 24 2f          	mov    BYTE PTR [esp+0x2f],al
    fa22:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    fa25:	89 4c 24 18          	mov    DWORD PTR [esp+0x18],ecx
    fa29:	89 54 24 14          	mov    DWORD PTR [esp+0x14],edx
    fa2d:	83 c4 10             	add    esp,0x10
    fa30:	84 c0                	test   al,al
    fa32:	74 b7                	je     f9eb <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x7b>
    fa34:	31 d2                	xor    edx,edx
    fa36:	89 34 24             	mov    DWORD PTR [esp],esi
    fa39:	3c 25                	cmp    al,0x25
    fa3b:	89 d7                	mov    edi,edx
    fa3d:	89 de                	mov    esi,ebx
    fa3f:	8d 6f 01             	lea    ebp,[edi+0x1]
    fa42:	8d 1c 2e             	lea    ebx,[esi+ebp*1]
    fa45:	75 30                	jne    fa77 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x107>
    fa47:	89 f6                	mov    esi,esi
    fa49:	8d bc 27 00 00 00 00 	lea    edi,[edi+eiz*1+0x0]
    fa50:	0f b6 03             	movzx  eax,BYTE PTR [ebx]
    fa53:	3c 25                	cmp    al,0x25
    fa55:	0f 84 9d 00 00 00    	je     faf8 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x188>
    fa5b:	84 c0                	test   al,al
    fa5d:	75 39                	jne    fa98 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x128>
    fa5f:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    fa64:	8d 6f 02             	lea    ebp,[edi+0x2]
    fa67:	84 c0                	test   al,al
    fa69:	74 80                	je     f9eb <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x7b>
    fa6b:	89 ef                	mov    edi,ebp
    fa6d:	8d 6f 01             	lea    ebp,[edi+0x1]
    fa70:	3c 25                	cmp    al,0x25
    fa72:	8d 1c 2e             	lea    ebx,[esi+ebp*1]
    fa75:	74 d9                	je     fa50 <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0xe0>
    fa77:	83 ec 0c             	sub    esp,0xc
    fa7a:	50                   	push   eax
    fa7b:	e8 50 c2 ff ff       	call   bcd0 <_Z7putcharc>
    fa80:	0f be 03             	movsx  eax,BYTE PTR [ebx]
    fa83:	83 c4 10             	add    esp,0x10
    fa86:	84 c0                	test   al,al
    fa88:	0f 84 5d ff ff ff    	je     f9eb <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x7b>
    fa8e:	89 ef                	mov    edi,ebp
    fa90:	eb db                	jmp    fa6d <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0xfd>
    fa92:	8d b6 00 00 00 00    	lea    esi,[esi+0x0]
    fa98:	83 ec 08             	sub    esp,0x8
    fa9b:	89 df                	mov    edi,ebx
    fa9d:	89 f3                	mov    ebx,esi
    fa9f:	8b 74 24 08          	mov    esi,DWORD PTR [esp+0x8]
    faa3:	8d 44 24 27          	lea    eax,[esp+0x27]
    faa7:	50                   	push   eax
    faa8:	57                   	push   edi
    faa9:	e8 82 fb ff ff       	call   f630 <_Z14_manage_escapeIhEiPKcPT_>
    faae:	01 c5                	add    ebp,eax
    fab0:	56                   	push   esi
    fab1:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    fab5:	01 eb                	add    ebx,ebp
    fab7:	ff 74 24 1c          	push   DWORD PTR [esp+0x1c]
    fabb:	53                   	push   ebx
    fabc:	e8 7f fc ff ff       	call   f740 <_Z6printfIhJhhEEvPKcT_DpT0_>
    fac1:	83 c4 20             	add    esp,0x20
    fac4:	83 c4 2c             	add    esp,0x2c
    fac7:	5b                   	pop    ebx
    fac8:	5e                   	pop    esi
    fac9:	5f                   	pop    edi
    faca:	5d                   	pop    ebp
    facb:	c3                   	ret    
    facc:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    fad0:	83 ec 0c             	sub    esp,0xc
    fad3:	8d 5f 02             	lea    ebx,[edi+0x2]
    fad6:	6a 25                	push   0x25
    fad8:	e8 f3 c1 ff ff       	call   bcd0 <_Z7putcharc>
    fadd:	0f be 44 3d 02       	movsx  eax,BYTE PTR [ebp+edi*1+0x2]
    fae2:	83 c4 10             	add    esp,0x10
    fae5:	84 c0                	test   al,al
    fae7:	0f 84 fe fe ff ff    	je     f9eb <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x7b>
    faed:	89 df                	mov    edi,ebx
    faef:	e9 d9 fe ff ff       	jmp    f9cd <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x5d>
    faf4:	8d 74 26 00          	lea    esi,[esi+eiz*1+0x0]
    faf8:	83 ec 0c             	sub    esp,0xc
    fafb:	8d 6f 02             	lea    ebp,[edi+0x2]
    fafe:	6a 25                	push   0x25
    fb00:	e8 cb c1 ff ff       	call   bcd0 <_Z7putcharc>
    fb05:	0f be 44 3e 02       	movsx  eax,BYTE PTR [esi+edi*1+0x2]
    fb0a:	83 c4 10             	add    esp,0x10
    fb0d:	84 c0                	test   al,al
    fb0f:	0f 84 d6 fe ff ff    	je     f9eb <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0x7b>
    fb15:	89 ef                	mov    edi,ebp
    fb17:	e9 51 ff ff ff       	jmp    fa6d <_Z6printfIPKcJhhhhEEvS1_T_DpT0_+0xfd>
