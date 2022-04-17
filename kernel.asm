
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	20813103          	ld	sp,520(sp) # 80004208 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	040010ef          	jal	ra,8000105c <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <main>:
#include "../lib/console.h"

void main(){
    80001000:	ff010113          	addi	sp,sp,-16
    80001004:	00113423          	sd	ra,8(sp)
    80001008:	00813023          	sd	s0,0(sp)
    8000100c:	01010413          	addi	s0,sp,16
    __putc('O');
    80001010:	04f00513          	li	a0,79
    80001014:	00002097          	auipc	ra,0x2
    80001018:	108080e7          	jalr	264(ra) # 8000311c <__putc>
    __putc('S');
    8000101c:	05300513          	li	a0,83
    80001020:	00002097          	auipc	ra,0x2
    80001024:	0fc080e7          	jalr	252(ra) # 8000311c <__putc>
    __putc('\n');
    80001028:	00a00513          	li	a0,10
    8000102c:	00002097          	auipc	ra,0x2
    80001030:	0f0080e7          	jalr	240(ra) # 8000311c <__putc>
    __putc('\n');
    80001034:	00a00513          	li	a0,10
    80001038:	00002097          	auipc	ra,0x2
    8000103c:	0e4080e7          	jalr	228(ra) # 8000311c <__putc>

    while(1){
        char car = __getc();
    80001040:	00002097          	auipc	ra,0x2
    80001044:	118080e7          	jalr	280(ra) # 80003158 <__getc>
        __putc(car +30);
    80001048:	01e5051b          	addiw	a0,a0,30
    8000104c:	0ff57513          	andi	a0,a0,255
    80001050:	00002097          	auipc	ra,0x2
    80001054:	0cc080e7          	jalr	204(ra) # 8000311c <__putc>
    while(1){
    80001058:	fe9ff06f          	j	80001040 <main+0x40>

000000008000105c <start>:
    8000105c:	ff010113          	addi	sp,sp,-16
    80001060:	00813423          	sd	s0,8(sp)
    80001064:	01010413          	addi	s0,sp,16
    80001068:	300027f3          	csrr	a5,mstatus
    8000106c:	ffffe737          	lui	a4,0xffffe
    80001070:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff935f>
    80001074:	00e7f7b3          	and	a5,a5,a4
    80001078:	00001737          	lui	a4,0x1
    8000107c:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80001080:	00e7e7b3          	or	a5,a5,a4
    80001084:	30079073          	csrw	mstatus,a5
    80001088:	00000797          	auipc	a5,0x0
    8000108c:	16078793          	addi	a5,a5,352 # 800011e8 <system_main>
    80001090:	34179073          	csrw	mepc,a5
    80001094:	00000793          	li	a5,0
    80001098:	18079073          	csrw	satp,a5
    8000109c:	000107b7          	lui	a5,0x10
    800010a0:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800010a4:	30279073          	csrw	medeleg,a5
    800010a8:	30379073          	csrw	mideleg,a5
    800010ac:	104027f3          	csrr	a5,sie
    800010b0:	2227e793          	ori	a5,a5,546
    800010b4:	10479073          	csrw	sie,a5
    800010b8:	fff00793          	li	a5,-1
    800010bc:	00a7d793          	srli	a5,a5,0xa
    800010c0:	3b079073          	csrw	pmpaddr0,a5
    800010c4:	00f00793          	li	a5,15
    800010c8:	3a079073          	csrw	pmpcfg0,a5
    800010cc:	f14027f3          	csrr	a5,mhartid
    800010d0:	0200c737          	lui	a4,0x200c
    800010d4:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800010d8:	0007869b          	sext.w	a3,a5
    800010dc:	00269713          	slli	a4,a3,0x2
    800010e0:	000f4637          	lui	a2,0xf4
    800010e4:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800010e8:	00d70733          	add	a4,a4,a3
    800010ec:	0037979b          	slliw	a5,a5,0x3
    800010f0:	020046b7          	lui	a3,0x2004
    800010f4:	00d787b3          	add	a5,a5,a3
    800010f8:	00c585b3          	add	a1,a1,a2
    800010fc:	00371693          	slli	a3,a4,0x3
    80001100:	00003717          	auipc	a4,0x3
    80001104:	15070713          	addi	a4,a4,336 # 80004250 <timer_scratch>
    80001108:	00b7b023          	sd	a1,0(a5)
    8000110c:	00d70733          	add	a4,a4,a3
    80001110:	00f73c23          	sd	a5,24(a4)
    80001114:	02c73023          	sd	a2,32(a4)
    80001118:	34071073          	csrw	mscratch,a4
    8000111c:	00000797          	auipc	a5,0x0
    80001120:	6e478793          	addi	a5,a5,1764 # 80001800 <timervec>
    80001124:	30579073          	csrw	mtvec,a5
    80001128:	300027f3          	csrr	a5,mstatus
    8000112c:	0087e793          	ori	a5,a5,8
    80001130:	30079073          	csrw	mstatus,a5
    80001134:	304027f3          	csrr	a5,mie
    80001138:	0807e793          	ori	a5,a5,128
    8000113c:	30479073          	csrw	mie,a5
    80001140:	f14027f3          	csrr	a5,mhartid
    80001144:	0007879b          	sext.w	a5,a5
    80001148:	00078213          	mv	tp,a5
    8000114c:	30200073          	mret
    80001150:	00813403          	ld	s0,8(sp)
    80001154:	01010113          	addi	sp,sp,16
    80001158:	00008067          	ret

000000008000115c <timerinit>:
    8000115c:	ff010113          	addi	sp,sp,-16
    80001160:	00813423          	sd	s0,8(sp)
    80001164:	01010413          	addi	s0,sp,16
    80001168:	f14027f3          	csrr	a5,mhartid
    8000116c:	0200c737          	lui	a4,0x200c
    80001170:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001174:	0007869b          	sext.w	a3,a5
    80001178:	00269713          	slli	a4,a3,0x2
    8000117c:	000f4637          	lui	a2,0xf4
    80001180:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001184:	00d70733          	add	a4,a4,a3
    80001188:	0037979b          	slliw	a5,a5,0x3
    8000118c:	020046b7          	lui	a3,0x2004
    80001190:	00d787b3          	add	a5,a5,a3
    80001194:	00c585b3          	add	a1,a1,a2
    80001198:	00371693          	slli	a3,a4,0x3
    8000119c:	00003717          	auipc	a4,0x3
    800011a0:	0b470713          	addi	a4,a4,180 # 80004250 <timer_scratch>
    800011a4:	00b7b023          	sd	a1,0(a5)
    800011a8:	00d70733          	add	a4,a4,a3
    800011ac:	00f73c23          	sd	a5,24(a4)
    800011b0:	02c73023          	sd	a2,32(a4)
    800011b4:	34071073          	csrw	mscratch,a4
    800011b8:	00000797          	auipc	a5,0x0
    800011bc:	64878793          	addi	a5,a5,1608 # 80001800 <timervec>
    800011c0:	30579073          	csrw	mtvec,a5
    800011c4:	300027f3          	csrr	a5,mstatus
    800011c8:	0087e793          	ori	a5,a5,8
    800011cc:	30079073          	csrw	mstatus,a5
    800011d0:	304027f3          	csrr	a5,mie
    800011d4:	0807e793          	ori	a5,a5,128
    800011d8:	30479073          	csrw	mie,a5
    800011dc:	00813403          	ld	s0,8(sp)
    800011e0:	01010113          	addi	sp,sp,16
    800011e4:	00008067          	ret

00000000800011e8 <system_main>:
    800011e8:	fe010113          	addi	sp,sp,-32
    800011ec:	00813823          	sd	s0,16(sp)
    800011f0:	00913423          	sd	s1,8(sp)
    800011f4:	00113c23          	sd	ra,24(sp)
    800011f8:	02010413          	addi	s0,sp,32
    800011fc:	00000097          	auipc	ra,0x0
    80001200:	0c4080e7          	jalr	196(ra) # 800012c0 <cpuid>
    80001204:	00003497          	auipc	s1,0x3
    80001208:	01c48493          	addi	s1,s1,28 # 80004220 <started>
    8000120c:	02050263          	beqz	a0,80001230 <system_main+0x48>
    80001210:	0004a783          	lw	a5,0(s1)
    80001214:	0007879b          	sext.w	a5,a5
    80001218:	fe078ce3          	beqz	a5,80001210 <system_main+0x28>
    8000121c:	0ff0000f          	fence
    80001220:	00003517          	auipc	a0,0x3
    80001224:	e1050513          	addi	a0,a0,-496 # 80004030 <console_handler+0xea0>
    80001228:	00001097          	auipc	ra,0x1
    8000122c:	a74080e7          	jalr	-1420(ra) # 80001c9c <panic>
    80001230:	00001097          	auipc	ra,0x1
    80001234:	9c8080e7          	jalr	-1592(ra) # 80001bf8 <consoleinit>
    80001238:	00001097          	auipc	ra,0x1
    8000123c:	154080e7          	jalr	340(ra) # 8000238c <printfinit>
    80001240:	00003517          	auipc	a0,0x3
    80001244:	ed050513          	addi	a0,a0,-304 # 80004110 <console_handler+0xf80>
    80001248:	00001097          	auipc	ra,0x1
    8000124c:	ab0080e7          	jalr	-1360(ra) # 80001cf8 <__printf>
    80001250:	00003517          	auipc	a0,0x3
    80001254:	db050513          	addi	a0,a0,-592 # 80004000 <console_handler+0xe70>
    80001258:	00001097          	auipc	ra,0x1
    8000125c:	aa0080e7          	jalr	-1376(ra) # 80001cf8 <__printf>
    80001260:	00003517          	auipc	a0,0x3
    80001264:	eb050513          	addi	a0,a0,-336 # 80004110 <console_handler+0xf80>
    80001268:	00001097          	auipc	ra,0x1
    8000126c:	a90080e7          	jalr	-1392(ra) # 80001cf8 <__printf>
    80001270:	00001097          	auipc	ra,0x1
    80001274:	4a8080e7          	jalr	1192(ra) # 80002718 <kinit>
    80001278:	00000097          	auipc	ra,0x0
    8000127c:	148080e7          	jalr	328(ra) # 800013c0 <trapinit>
    80001280:	00000097          	auipc	ra,0x0
    80001284:	16c080e7          	jalr	364(ra) # 800013ec <trapinithart>
    80001288:	00000097          	auipc	ra,0x0
    8000128c:	5b8080e7          	jalr	1464(ra) # 80001840 <plicinit>
    80001290:	00000097          	auipc	ra,0x0
    80001294:	5d8080e7          	jalr	1496(ra) # 80001868 <plicinithart>
    80001298:	00000097          	auipc	ra,0x0
    8000129c:	078080e7          	jalr	120(ra) # 80001310 <userinit>
    800012a0:	0ff0000f          	fence
    800012a4:	00100793          	li	a5,1
    800012a8:	00003517          	auipc	a0,0x3
    800012ac:	d7050513          	addi	a0,a0,-656 # 80004018 <console_handler+0xe88>
    800012b0:	00f4a023          	sw	a5,0(s1)
    800012b4:	00001097          	auipc	ra,0x1
    800012b8:	a44080e7          	jalr	-1468(ra) # 80001cf8 <__printf>
    800012bc:	0000006f          	j	800012bc <system_main+0xd4>

00000000800012c0 <cpuid>:
    800012c0:	ff010113          	addi	sp,sp,-16
    800012c4:	00813423          	sd	s0,8(sp)
    800012c8:	01010413          	addi	s0,sp,16
    800012cc:	00020513          	mv	a0,tp
    800012d0:	00813403          	ld	s0,8(sp)
    800012d4:	0005051b          	sext.w	a0,a0
    800012d8:	01010113          	addi	sp,sp,16
    800012dc:	00008067          	ret

00000000800012e0 <mycpu>:
    800012e0:	ff010113          	addi	sp,sp,-16
    800012e4:	00813423          	sd	s0,8(sp)
    800012e8:	01010413          	addi	s0,sp,16
    800012ec:	00020793          	mv	a5,tp
    800012f0:	00813403          	ld	s0,8(sp)
    800012f4:	0007879b          	sext.w	a5,a5
    800012f8:	00779793          	slli	a5,a5,0x7
    800012fc:	00004517          	auipc	a0,0x4
    80001300:	f8450513          	addi	a0,a0,-124 # 80005280 <cpus>
    80001304:	00f50533          	add	a0,a0,a5
    80001308:	01010113          	addi	sp,sp,16
    8000130c:	00008067          	ret

0000000080001310 <userinit>:
    80001310:	ff010113          	addi	sp,sp,-16
    80001314:	00813423          	sd	s0,8(sp)
    80001318:	01010413          	addi	s0,sp,16
    8000131c:	00813403          	ld	s0,8(sp)
    80001320:	01010113          	addi	sp,sp,16
    80001324:	00000317          	auipc	t1,0x0
    80001328:	cdc30067          	jr	-804(t1) # 80001000 <main>

000000008000132c <either_copyout>:
    8000132c:	ff010113          	addi	sp,sp,-16
    80001330:	00813023          	sd	s0,0(sp)
    80001334:	00113423          	sd	ra,8(sp)
    80001338:	01010413          	addi	s0,sp,16
    8000133c:	02051663          	bnez	a0,80001368 <either_copyout+0x3c>
    80001340:	00058513          	mv	a0,a1
    80001344:	00060593          	mv	a1,a2
    80001348:	0006861b          	sext.w	a2,a3
    8000134c:	00002097          	auipc	ra,0x2
    80001350:	c58080e7          	jalr	-936(ra) # 80002fa4 <__memmove>
    80001354:	00813083          	ld	ra,8(sp)
    80001358:	00013403          	ld	s0,0(sp)
    8000135c:	00000513          	li	a0,0
    80001360:	01010113          	addi	sp,sp,16
    80001364:	00008067          	ret
    80001368:	00003517          	auipc	a0,0x3
    8000136c:	cf050513          	addi	a0,a0,-784 # 80004058 <console_handler+0xec8>
    80001370:	00001097          	auipc	ra,0x1
    80001374:	92c080e7          	jalr	-1748(ra) # 80001c9c <panic>

0000000080001378 <either_copyin>:
    80001378:	ff010113          	addi	sp,sp,-16
    8000137c:	00813023          	sd	s0,0(sp)
    80001380:	00113423          	sd	ra,8(sp)
    80001384:	01010413          	addi	s0,sp,16
    80001388:	02059463          	bnez	a1,800013b0 <either_copyin+0x38>
    8000138c:	00060593          	mv	a1,a2
    80001390:	0006861b          	sext.w	a2,a3
    80001394:	00002097          	auipc	ra,0x2
    80001398:	c10080e7          	jalr	-1008(ra) # 80002fa4 <__memmove>
    8000139c:	00813083          	ld	ra,8(sp)
    800013a0:	00013403          	ld	s0,0(sp)
    800013a4:	00000513          	li	a0,0
    800013a8:	01010113          	addi	sp,sp,16
    800013ac:	00008067          	ret
    800013b0:	00003517          	auipc	a0,0x3
    800013b4:	cd050513          	addi	a0,a0,-816 # 80004080 <console_handler+0xef0>
    800013b8:	00001097          	auipc	ra,0x1
    800013bc:	8e4080e7          	jalr	-1820(ra) # 80001c9c <panic>

00000000800013c0 <trapinit>:
    800013c0:	ff010113          	addi	sp,sp,-16
    800013c4:	00813423          	sd	s0,8(sp)
    800013c8:	01010413          	addi	s0,sp,16
    800013cc:	00813403          	ld	s0,8(sp)
    800013d0:	00003597          	auipc	a1,0x3
    800013d4:	cd858593          	addi	a1,a1,-808 # 800040a8 <console_handler+0xf18>
    800013d8:	00004517          	auipc	a0,0x4
    800013dc:	f2850513          	addi	a0,a0,-216 # 80005300 <tickslock>
    800013e0:	01010113          	addi	sp,sp,16
    800013e4:	00001317          	auipc	t1,0x1
    800013e8:	5c430067          	jr	1476(t1) # 800029a8 <initlock>

00000000800013ec <trapinithart>:
    800013ec:	ff010113          	addi	sp,sp,-16
    800013f0:	00813423          	sd	s0,8(sp)
    800013f4:	01010413          	addi	s0,sp,16
    800013f8:	00000797          	auipc	a5,0x0
    800013fc:	2f878793          	addi	a5,a5,760 # 800016f0 <kernelvec>
    80001400:	10579073          	csrw	stvec,a5
    80001404:	00813403          	ld	s0,8(sp)
    80001408:	01010113          	addi	sp,sp,16
    8000140c:	00008067          	ret

0000000080001410 <usertrap>:
    80001410:	ff010113          	addi	sp,sp,-16
    80001414:	00813423          	sd	s0,8(sp)
    80001418:	01010413          	addi	s0,sp,16
    8000141c:	00813403          	ld	s0,8(sp)
    80001420:	01010113          	addi	sp,sp,16
    80001424:	00008067          	ret

0000000080001428 <usertrapret>:
    80001428:	ff010113          	addi	sp,sp,-16
    8000142c:	00813423          	sd	s0,8(sp)
    80001430:	01010413          	addi	s0,sp,16
    80001434:	00813403          	ld	s0,8(sp)
    80001438:	01010113          	addi	sp,sp,16
    8000143c:	00008067          	ret

0000000080001440 <kerneltrap>:
    80001440:	fe010113          	addi	sp,sp,-32
    80001444:	00813823          	sd	s0,16(sp)
    80001448:	00113c23          	sd	ra,24(sp)
    8000144c:	00913423          	sd	s1,8(sp)
    80001450:	02010413          	addi	s0,sp,32
    80001454:	142025f3          	csrr	a1,scause
    80001458:	100027f3          	csrr	a5,sstatus
    8000145c:	0027f793          	andi	a5,a5,2
    80001460:	10079c63          	bnez	a5,80001578 <kerneltrap+0x138>
    80001464:	142027f3          	csrr	a5,scause
    80001468:	0207ce63          	bltz	a5,800014a4 <kerneltrap+0x64>
    8000146c:	00003517          	auipc	a0,0x3
    80001470:	c8450513          	addi	a0,a0,-892 # 800040f0 <console_handler+0xf60>
    80001474:	00001097          	auipc	ra,0x1
    80001478:	884080e7          	jalr	-1916(ra) # 80001cf8 <__printf>
    8000147c:	141025f3          	csrr	a1,sepc
    80001480:	14302673          	csrr	a2,stval
    80001484:	00003517          	auipc	a0,0x3
    80001488:	c7c50513          	addi	a0,a0,-900 # 80004100 <console_handler+0xf70>
    8000148c:	00001097          	auipc	ra,0x1
    80001490:	86c080e7          	jalr	-1940(ra) # 80001cf8 <__printf>
    80001494:	00003517          	auipc	a0,0x3
    80001498:	c8450513          	addi	a0,a0,-892 # 80004118 <console_handler+0xf88>
    8000149c:	00001097          	auipc	ra,0x1
    800014a0:	800080e7          	jalr	-2048(ra) # 80001c9c <panic>
    800014a4:	0ff7f713          	andi	a4,a5,255
    800014a8:	00900693          	li	a3,9
    800014ac:	04d70063          	beq	a4,a3,800014ec <kerneltrap+0xac>
    800014b0:	fff00713          	li	a4,-1
    800014b4:	03f71713          	slli	a4,a4,0x3f
    800014b8:	00170713          	addi	a4,a4,1
    800014bc:	fae798e3          	bne	a5,a4,8000146c <kerneltrap+0x2c>
    800014c0:	00000097          	auipc	ra,0x0
    800014c4:	e00080e7          	jalr	-512(ra) # 800012c0 <cpuid>
    800014c8:	06050663          	beqz	a0,80001534 <kerneltrap+0xf4>
    800014cc:	144027f3          	csrr	a5,sip
    800014d0:	ffd7f793          	andi	a5,a5,-3
    800014d4:	14479073          	csrw	sip,a5
    800014d8:	01813083          	ld	ra,24(sp)
    800014dc:	01013403          	ld	s0,16(sp)
    800014e0:	00813483          	ld	s1,8(sp)
    800014e4:	02010113          	addi	sp,sp,32
    800014e8:	00008067          	ret
    800014ec:	00000097          	auipc	ra,0x0
    800014f0:	3c8080e7          	jalr	968(ra) # 800018b4 <plic_claim>
    800014f4:	00a00793          	li	a5,10
    800014f8:	00050493          	mv	s1,a0
    800014fc:	06f50863          	beq	a0,a5,8000156c <kerneltrap+0x12c>
    80001500:	fc050ce3          	beqz	a0,800014d8 <kerneltrap+0x98>
    80001504:	00050593          	mv	a1,a0
    80001508:	00003517          	auipc	a0,0x3
    8000150c:	bc850513          	addi	a0,a0,-1080 # 800040d0 <console_handler+0xf40>
    80001510:	00000097          	auipc	ra,0x0
    80001514:	7e8080e7          	jalr	2024(ra) # 80001cf8 <__printf>
    80001518:	01013403          	ld	s0,16(sp)
    8000151c:	01813083          	ld	ra,24(sp)
    80001520:	00048513          	mv	a0,s1
    80001524:	00813483          	ld	s1,8(sp)
    80001528:	02010113          	addi	sp,sp,32
    8000152c:	00000317          	auipc	t1,0x0
    80001530:	3c030067          	jr	960(t1) # 800018ec <plic_complete>
    80001534:	00004517          	auipc	a0,0x4
    80001538:	dcc50513          	addi	a0,a0,-564 # 80005300 <tickslock>
    8000153c:	00001097          	auipc	ra,0x1
    80001540:	490080e7          	jalr	1168(ra) # 800029cc <acquire>
    80001544:	00003717          	auipc	a4,0x3
    80001548:	ce070713          	addi	a4,a4,-800 # 80004224 <ticks>
    8000154c:	00072783          	lw	a5,0(a4)
    80001550:	00004517          	auipc	a0,0x4
    80001554:	db050513          	addi	a0,a0,-592 # 80005300 <tickslock>
    80001558:	0017879b          	addiw	a5,a5,1
    8000155c:	00f72023          	sw	a5,0(a4)
    80001560:	00001097          	auipc	ra,0x1
    80001564:	538080e7          	jalr	1336(ra) # 80002a98 <release>
    80001568:	f65ff06f          	j	800014cc <kerneltrap+0x8c>
    8000156c:	00001097          	auipc	ra,0x1
    80001570:	094080e7          	jalr	148(ra) # 80002600 <uartintr>
    80001574:	fa5ff06f          	j	80001518 <kerneltrap+0xd8>
    80001578:	00003517          	auipc	a0,0x3
    8000157c:	b3850513          	addi	a0,a0,-1224 # 800040b0 <console_handler+0xf20>
    80001580:	00000097          	auipc	ra,0x0
    80001584:	71c080e7          	jalr	1820(ra) # 80001c9c <panic>

0000000080001588 <clockintr>:
    80001588:	fe010113          	addi	sp,sp,-32
    8000158c:	00813823          	sd	s0,16(sp)
    80001590:	00913423          	sd	s1,8(sp)
    80001594:	00113c23          	sd	ra,24(sp)
    80001598:	02010413          	addi	s0,sp,32
    8000159c:	00004497          	auipc	s1,0x4
    800015a0:	d6448493          	addi	s1,s1,-668 # 80005300 <tickslock>
    800015a4:	00048513          	mv	a0,s1
    800015a8:	00001097          	auipc	ra,0x1
    800015ac:	424080e7          	jalr	1060(ra) # 800029cc <acquire>
    800015b0:	00003717          	auipc	a4,0x3
    800015b4:	c7470713          	addi	a4,a4,-908 # 80004224 <ticks>
    800015b8:	00072783          	lw	a5,0(a4)
    800015bc:	01013403          	ld	s0,16(sp)
    800015c0:	01813083          	ld	ra,24(sp)
    800015c4:	00048513          	mv	a0,s1
    800015c8:	0017879b          	addiw	a5,a5,1
    800015cc:	00813483          	ld	s1,8(sp)
    800015d0:	00f72023          	sw	a5,0(a4)
    800015d4:	02010113          	addi	sp,sp,32
    800015d8:	00001317          	auipc	t1,0x1
    800015dc:	4c030067          	jr	1216(t1) # 80002a98 <release>

00000000800015e0 <devintr>:
    800015e0:	142027f3          	csrr	a5,scause
    800015e4:	00000513          	li	a0,0
    800015e8:	0007c463          	bltz	a5,800015f0 <devintr+0x10>
    800015ec:	00008067          	ret
    800015f0:	fe010113          	addi	sp,sp,-32
    800015f4:	00813823          	sd	s0,16(sp)
    800015f8:	00113c23          	sd	ra,24(sp)
    800015fc:	00913423          	sd	s1,8(sp)
    80001600:	02010413          	addi	s0,sp,32
    80001604:	0ff7f713          	andi	a4,a5,255
    80001608:	00900693          	li	a3,9
    8000160c:	04d70c63          	beq	a4,a3,80001664 <devintr+0x84>
    80001610:	fff00713          	li	a4,-1
    80001614:	03f71713          	slli	a4,a4,0x3f
    80001618:	00170713          	addi	a4,a4,1
    8000161c:	00e78c63          	beq	a5,a4,80001634 <devintr+0x54>
    80001620:	01813083          	ld	ra,24(sp)
    80001624:	01013403          	ld	s0,16(sp)
    80001628:	00813483          	ld	s1,8(sp)
    8000162c:	02010113          	addi	sp,sp,32
    80001630:	00008067          	ret
    80001634:	00000097          	auipc	ra,0x0
    80001638:	c8c080e7          	jalr	-884(ra) # 800012c0 <cpuid>
    8000163c:	06050663          	beqz	a0,800016a8 <devintr+0xc8>
    80001640:	144027f3          	csrr	a5,sip
    80001644:	ffd7f793          	andi	a5,a5,-3
    80001648:	14479073          	csrw	sip,a5
    8000164c:	01813083          	ld	ra,24(sp)
    80001650:	01013403          	ld	s0,16(sp)
    80001654:	00813483          	ld	s1,8(sp)
    80001658:	00200513          	li	a0,2
    8000165c:	02010113          	addi	sp,sp,32
    80001660:	00008067          	ret
    80001664:	00000097          	auipc	ra,0x0
    80001668:	250080e7          	jalr	592(ra) # 800018b4 <plic_claim>
    8000166c:	00a00793          	li	a5,10
    80001670:	00050493          	mv	s1,a0
    80001674:	06f50663          	beq	a0,a5,800016e0 <devintr+0x100>
    80001678:	00100513          	li	a0,1
    8000167c:	fa0482e3          	beqz	s1,80001620 <devintr+0x40>
    80001680:	00048593          	mv	a1,s1
    80001684:	00003517          	auipc	a0,0x3
    80001688:	a4c50513          	addi	a0,a0,-1460 # 800040d0 <console_handler+0xf40>
    8000168c:	00000097          	auipc	ra,0x0
    80001690:	66c080e7          	jalr	1644(ra) # 80001cf8 <__printf>
    80001694:	00048513          	mv	a0,s1
    80001698:	00000097          	auipc	ra,0x0
    8000169c:	254080e7          	jalr	596(ra) # 800018ec <plic_complete>
    800016a0:	00100513          	li	a0,1
    800016a4:	f7dff06f          	j	80001620 <devintr+0x40>
    800016a8:	00004517          	auipc	a0,0x4
    800016ac:	c5850513          	addi	a0,a0,-936 # 80005300 <tickslock>
    800016b0:	00001097          	auipc	ra,0x1
    800016b4:	31c080e7          	jalr	796(ra) # 800029cc <acquire>
    800016b8:	00003717          	auipc	a4,0x3
    800016bc:	b6c70713          	addi	a4,a4,-1172 # 80004224 <ticks>
    800016c0:	00072783          	lw	a5,0(a4)
    800016c4:	00004517          	auipc	a0,0x4
    800016c8:	c3c50513          	addi	a0,a0,-964 # 80005300 <tickslock>
    800016cc:	0017879b          	addiw	a5,a5,1
    800016d0:	00f72023          	sw	a5,0(a4)
    800016d4:	00001097          	auipc	ra,0x1
    800016d8:	3c4080e7          	jalr	964(ra) # 80002a98 <release>
    800016dc:	f65ff06f          	j	80001640 <devintr+0x60>
    800016e0:	00001097          	auipc	ra,0x1
    800016e4:	f20080e7          	jalr	-224(ra) # 80002600 <uartintr>
    800016e8:	fadff06f          	j	80001694 <devintr+0xb4>
    800016ec:	0000                	unimp
	...

00000000800016f0 <kernelvec>:
    800016f0:	f0010113          	addi	sp,sp,-256
    800016f4:	00113023          	sd	ra,0(sp)
    800016f8:	00213423          	sd	sp,8(sp)
    800016fc:	00313823          	sd	gp,16(sp)
    80001700:	00413c23          	sd	tp,24(sp)
    80001704:	02513023          	sd	t0,32(sp)
    80001708:	02613423          	sd	t1,40(sp)
    8000170c:	02713823          	sd	t2,48(sp)
    80001710:	02813c23          	sd	s0,56(sp)
    80001714:	04913023          	sd	s1,64(sp)
    80001718:	04a13423          	sd	a0,72(sp)
    8000171c:	04b13823          	sd	a1,80(sp)
    80001720:	04c13c23          	sd	a2,88(sp)
    80001724:	06d13023          	sd	a3,96(sp)
    80001728:	06e13423          	sd	a4,104(sp)
    8000172c:	06f13823          	sd	a5,112(sp)
    80001730:	07013c23          	sd	a6,120(sp)
    80001734:	09113023          	sd	a7,128(sp)
    80001738:	09213423          	sd	s2,136(sp)
    8000173c:	09313823          	sd	s3,144(sp)
    80001740:	09413c23          	sd	s4,152(sp)
    80001744:	0b513023          	sd	s5,160(sp)
    80001748:	0b613423          	sd	s6,168(sp)
    8000174c:	0b713823          	sd	s7,176(sp)
    80001750:	0b813c23          	sd	s8,184(sp)
    80001754:	0d913023          	sd	s9,192(sp)
    80001758:	0da13423          	sd	s10,200(sp)
    8000175c:	0db13823          	sd	s11,208(sp)
    80001760:	0dc13c23          	sd	t3,216(sp)
    80001764:	0fd13023          	sd	t4,224(sp)
    80001768:	0fe13423          	sd	t5,232(sp)
    8000176c:	0ff13823          	sd	t6,240(sp)
    80001770:	cd1ff0ef          	jal	ra,80001440 <kerneltrap>
    80001774:	00013083          	ld	ra,0(sp)
    80001778:	00813103          	ld	sp,8(sp)
    8000177c:	01013183          	ld	gp,16(sp)
    80001780:	02013283          	ld	t0,32(sp)
    80001784:	02813303          	ld	t1,40(sp)
    80001788:	03013383          	ld	t2,48(sp)
    8000178c:	03813403          	ld	s0,56(sp)
    80001790:	04013483          	ld	s1,64(sp)
    80001794:	04813503          	ld	a0,72(sp)
    80001798:	05013583          	ld	a1,80(sp)
    8000179c:	05813603          	ld	a2,88(sp)
    800017a0:	06013683          	ld	a3,96(sp)
    800017a4:	06813703          	ld	a4,104(sp)
    800017a8:	07013783          	ld	a5,112(sp)
    800017ac:	07813803          	ld	a6,120(sp)
    800017b0:	08013883          	ld	a7,128(sp)
    800017b4:	08813903          	ld	s2,136(sp)
    800017b8:	09013983          	ld	s3,144(sp)
    800017bc:	09813a03          	ld	s4,152(sp)
    800017c0:	0a013a83          	ld	s5,160(sp)
    800017c4:	0a813b03          	ld	s6,168(sp)
    800017c8:	0b013b83          	ld	s7,176(sp)
    800017cc:	0b813c03          	ld	s8,184(sp)
    800017d0:	0c013c83          	ld	s9,192(sp)
    800017d4:	0c813d03          	ld	s10,200(sp)
    800017d8:	0d013d83          	ld	s11,208(sp)
    800017dc:	0d813e03          	ld	t3,216(sp)
    800017e0:	0e013e83          	ld	t4,224(sp)
    800017e4:	0e813f03          	ld	t5,232(sp)
    800017e8:	0f013f83          	ld	t6,240(sp)
    800017ec:	10010113          	addi	sp,sp,256
    800017f0:	10200073          	sret
    800017f4:	00000013          	nop
    800017f8:	00000013          	nop
    800017fc:	00000013          	nop

0000000080001800 <timervec>:
    80001800:	34051573          	csrrw	a0,mscratch,a0
    80001804:	00b53023          	sd	a1,0(a0)
    80001808:	00c53423          	sd	a2,8(a0)
    8000180c:	00d53823          	sd	a3,16(a0)
    80001810:	01853583          	ld	a1,24(a0)
    80001814:	02053603          	ld	a2,32(a0)
    80001818:	0005b683          	ld	a3,0(a1)
    8000181c:	00c686b3          	add	a3,a3,a2
    80001820:	00d5b023          	sd	a3,0(a1)
    80001824:	00200593          	li	a1,2
    80001828:	14459073          	csrw	sip,a1
    8000182c:	01053683          	ld	a3,16(a0)
    80001830:	00853603          	ld	a2,8(a0)
    80001834:	00053583          	ld	a1,0(a0)
    80001838:	34051573          	csrrw	a0,mscratch,a0
    8000183c:	30200073          	mret

0000000080001840 <plicinit>:
    80001840:	ff010113          	addi	sp,sp,-16
    80001844:	00813423          	sd	s0,8(sp)
    80001848:	01010413          	addi	s0,sp,16
    8000184c:	00813403          	ld	s0,8(sp)
    80001850:	0c0007b7          	lui	a5,0xc000
    80001854:	00100713          	li	a4,1
    80001858:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    8000185c:	00e7a223          	sw	a4,4(a5)
    80001860:	01010113          	addi	sp,sp,16
    80001864:	00008067          	ret

0000000080001868 <plicinithart>:
    80001868:	ff010113          	addi	sp,sp,-16
    8000186c:	00813023          	sd	s0,0(sp)
    80001870:	00113423          	sd	ra,8(sp)
    80001874:	01010413          	addi	s0,sp,16
    80001878:	00000097          	auipc	ra,0x0
    8000187c:	a48080e7          	jalr	-1464(ra) # 800012c0 <cpuid>
    80001880:	0085171b          	slliw	a4,a0,0x8
    80001884:	0c0027b7          	lui	a5,0xc002
    80001888:	00e787b3          	add	a5,a5,a4
    8000188c:	40200713          	li	a4,1026
    80001890:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    80001894:	00813083          	ld	ra,8(sp)
    80001898:	00013403          	ld	s0,0(sp)
    8000189c:	00d5151b          	slliw	a0,a0,0xd
    800018a0:	0c2017b7          	lui	a5,0xc201
    800018a4:	00a78533          	add	a0,a5,a0
    800018a8:	00052023          	sw	zero,0(a0)
    800018ac:	01010113          	addi	sp,sp,16
    800018b0:	00008067          	ret

00000000800018b4 <plic_claim>:
    800018b4:	ff010113          	addi	sp,sp,-16
    800018b8:	00813023          	sd	s0,0(sp)
    800018bc:	00113423          	sd	ra,8(sp)
    800018c0:	01010413          	addi	s0,sp,16
    800018c4:	00000097          	auipc	ra,0x0
    800018c8:	9fc080e7          	jalr	-1540(ra) # 800012c0 <cpuid>
    800018cc:	00813083          	ld	ra,8(sp)
    800018d0:	00013403          	ld	s0,0(sp)
    800018d4:	00d5151b          	slliw	a0,a0,0xd
    800018d8:	0c2017b7          	lui	a5,0xc201
    800018dc:	00a78533          	add	a0,a5,a0
    800018e0:	00452503          	lw	a0,4(a0)
    800018e4:	01010113          	addi	sp,sp,16
    800018e8:	00008067          	ret

00000000800018ec <plic_complete>:
    800018ec:	fe010113          	addi	sp,sp,-32
    800018f0:	00813823          	sd	s0,16(sp)
    800018f4:	00913423          	sd	s1,8(sp)
    800018f8:	00113c23          	sd	ra,24(sp)
    800018fc:	02010413          	addi	s0,sp,32
    80001900:	00050493          	mv	s1,a0
    80001904:	00000097          	auipc	ra,0x0
    80001908:	9bc080e7          	jalr	-1604(ra) # 800012c0 <cpuid>
    8000190c:	01813083          	ld	ra,24(sp)
    80001910:	01013403          	ld	s0,16(sp)
    80001914:	00d5179b          	slliw	a5,a0,0xd
    80001918:	0c201737          	lui	a4,0xc201
    8000191c:	00f707b3          	add	a5,a4,a5
    80001920:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001924:	00813483          	ld	s1,8(sp)
    80001928:	02010113          	addi	sp,sp,32
    8000192c:	00008067          	ret

0000000080001930 <consolewrite>:
    80001930:	fb010113          	addi	sp,sp,-80
    80001934:	04813023          	sd	s0,64(sp)
    80001938:	04113423          	sd	ra,72(sp)
    8000193c:	02913c23          	sd	s1,56(sp)
    80001940:	03213823          	sd	s2,48(sp)
    80001944:	03313423          	sd	s3,40(sp)
    80001948:	03413023          	sd	s4,32(sp)
    8000194c:	01513c23          	sd	s5,24(sp)
    80001950:	05010413          	addi	s0,sp,80
    80001954:	06c05c63          	blez	a2,800019cc <consolewrite+0x9c>
    80001958:	00060993          	mv	s3,a2
    8000195c:	00050a13          	mv	s4,a0
    80001960:	00058493          	mv	s1,a1
    80001964:	00000913          	li	s2,0
    80001968:	fff00a93          	li	s5,-1
    8000196c:	01c0006f          	j	80001988 <consolewrite+0x58>
    80001970:	fbf44503          	lbu	a0,-65(s0)
    80001974:	0019091b          	addiw	s2,s2,1
    80001978:	00148493          	addi	s1,s1,1
    8000197c:	00001097          	auipc	ra,0x1
    80001980:	a9c080e7          	jalr	-1380(ra) # 80002418 <uartputc>
    80001984:	03298063          	beq	s3,s2,800019a4 <consolewrite+0x74>
    80001988:	00048613          	mv	a2,s1
    8000198c:	00100693          	li	a3,1
    80001990:	000a0593          	mv	a1,s4
    80001994:	fbf40513          	addi	a0,s0,-65
    80001998:	00000097          	auipc	ra,0x0
    8000199c:	9e0080e7          	jalr	-1568(ra) # 80001378 <either_copyin>
    800019a0:	fd5518e3          	bne	a0,s5,80001970 <consolewrite+0x40>
    800019a4:	04813083          	ld	ra,72(sp)
    800019a8:	04013403          	ld	s0,64(sp)
    800019ac:	03813483          	ld	s1,56(sp)
    800019b0:	02813983          	ld	s3,40(sp)
    800019b4:	02013a03          	ld	s4,32(sp)
    800019b8:	01813a83          	ld	s5,24(sp)
    800019bc:	00090513          	mv	a0,s2
    800019c0:	03013903          	ld	s2,48(sp)
    800019c4:	05010113          	addi	sp,sp,80
    800019c8:	00008067          	ret
    800019cc:	00000913          	li	s2,0
    800019d0:	fd5ff06f          	j	800019a4 <consolewrite+0x74>

00000000800019d4 <consoleread>:
    800019d4:	f9010113          	addi	sp,sp,-112
    800019d8:	06813023          	sd	s0,96(sp)
    800019dc:	04913c23          	sd	s1,88(sp)
    800019e0:	05213823          	sd	s2,80(sp)
    800019e4:	05313423          	sd	s3,72(sp)
    800019e8:	05413023          	sd	s4,64(sp)
    800019ec:	03513c23          	sd	s5,56(sp)
    800019f0:	03613823          	sd	s6,48(sp)
    800019f4:	03713423          	sd	s7,40(sp)
    800019f8:	03813023          	sd	s8,32(sp)
    800019fc:	06113423          	sd	ra,104(sp)
    80001a00:	01913c23          	sd	s9,24(sp)
    80001a04:	07010413          	addi	s0,sp,112
    80001a08:	00060b93          	mv	s7,a2
    80001a0c:	00050913          	mv	s2,a0
    80001a10:	00058c13          	mv	s8,a1
    80001a14:	00060b1b          	sext.w	s6,a2
    80001a18:	00004497          	auipc	s1,0x4
    80001a1c:	90048493          	addi	s1,s1,-1792 # 80005318 <cons>
    80001a20:	00400993          	li	s3,4
    80001a24:	fff00a13          	li	s4,-1
    80001a28:	00a00a93          	li	s5,10
    80001a2c:	05705e63          	blez	s7,80001a88 <consoleread+0xb4>
    80001a30:	09c4a703          	lw	a4,156(s1)
    80001a34:	0984a783          	lw	a5,152(s1)
    80001a38:	0007071b          	sext.w	a4,a4
    80001a3c:	08e78463          	beq	a5,a4,80001ac4 <consoleread+0xf0>
    80001a40:	07f7f713          	andi	a4,a5,127
    80001a44:	00e48733          	add	a4,s1,a4
    80001a48:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001a4c:	0017869b          	addiw	a3,a5,1
    80001a50:	08d4ac23          	sw	a3,152(s1)
    80001a54:	00070c9b          	sext.w	s9,a4
    80001a58:	0b370663          	beq	a4,s3,80001b04 <consoleread+0x130>
    80001a5c:	00100693          	li	a3,1
    80001a60:	f9f40613          	addi	a2,s0,-97
    80001a64:	000c0593          	mv	a1,s8
    80001a68:	00090513          	mv	a0,s2
    80001a6c:	f8e40fa3          	sb	a4,-97(s0)
    80001a70:	00000097          	auipc	ra,0x0
    80001a74:	8bc080e7          	jalr	-1860(ra) # 8000132c <either_copyout>
    80001a78:	01450863          	beq	a0,s4,80001a88 <consoleread+0xb4>
    80001a7c:	001c0c13          	addi	s8,s8,1
    80001a80:	fffb8b9b          	addiw	s7,s7,-1
    80001a84:	fb5c94e3          	bne	s9,s5,80001a2c <consoleread+0x58>
    80001a88:	000b851b          	sext.w	a0,s7
    80001a8c:	06813083          	ld	ra,104(sp)
    80001a90:	06013403          	ld	s0,96(sp)
    80001a94:	05813483          	ld	s1,88(sp)
    80001a98:	05013903          	ld	s2,80(sp)
    80001a9c:	04813983          	ld	s3,72(sp)
    80001aa0:	04013a03          	ld	s4,64(sp)
    80001aa4:	03813a83          	ld	s5,56(sp)
    80001aa8:	02813b83          	ld	s7,40(sp)
    80001aac:	02013c03          	ld	s8,32(sp)
    80001ab0:	01813c83          	ld	s9,24(sp)
    80001ab4:	40ab053b          	subw	a0,s6,a0
    80001ab8:	03013b03          	ld	s6,48(sp)
    80001abc:	07010113          	addi	sp,sp,112
    80001ac0:	00008067          	ret
    80001ac4:	00001097          	auipc	ra,0x1
    80001ac8:	1d8080e7          	jalr	472(ra) # 80002c9c <push_on>
    80001acc:	0984a703          	lw	a4,152(s1)
    80001ad0:	09c4a783          	lw	a5,156(s1)
    80001ad4:	0007879b          	sext.w	a5,a5
    80001ad8:	fef70ce3          	beq	a4,a5,80001ad0 <consoleread+0xfc>
    80001adc:	00001097          	auipc	ra,0x1
    80001ae0:	234080e7          	jalr	564(ra) # 80002d10 <pop_on>
    80001ae4:	0984a783          	lw	a5,152(s1)
    80001ae8:	07f7f713          	andi	a4,a5,127
    80001aec:	00e48733          	add	a4,s1,a4
    80001af0:	01874703          	lbu	a4,24(a4)
    80001af4:	0017869b          	addiw	a3,a5,1
    80001af8:	08d4ac23          	sw	a3,152(s1)
    80001afc:	00070c9b          	sext.w	s9,a4
    80001b00:	f5371ee3          	bne	a4,s3,80001a5c <consoleread+0x88>
    80001b04:	000b851b          	sext.w	a0,s7
    80001b08:	f96bf2e3          	bgeu	s7,s6,80001a8c <consoleread+0xb8>
    80001b0c:	08f4ac23          	sw	a5,152(s1)
    80001b10:	f7dff06f          	j	80001a8c <consoleread+0xb8>

0000000080001b14 <consputc>:
    80001b14:	10000793          	li	a5,256
    80001b18:	00f50663          	beq	a0,a5,80001b24 <consputc+0x10>
    80001b1c:	00001317          	auipc	t1,0x1
    80001b20:	9f430067          	jr	-1548(t1) # 80002510 <uartputc_sync>
    80001b24:	ff010113          	addi	sp,sp,-16
    80001b28:	00113423          	sd	ra,8(sp)
    80001b2c:	00813023          	sd	s0,0(sp)
    80001b30:	01010413          	addi	s0,sp,16
    80001b34:	00800513          	li	a0,8
    80001b38:	00001097          	auipc	ra,0x1
    80001b3c:	9d8080e7          	jalr	-1576(ra) # 80002510 <uartputc_sync>
    80001b40:	02000513          	li	a0,32
    80001b44:	00001097          	auipc	ra,0x1
    80001b48:	9cc080e7          	jalr	-1588(ra) # 80002510 <uartputc_sync>
    80001b4c:	00013403          	ld	s0,0(sp)
    80001b50:	00813083          	ld	ra,8(sp)
    80001b54:	00800513          	li	a0,8
    80001b58:	01010113          	addi	sp,sp,16
    80001b5c:	00001317          	auipc	t1,0x1
    80001b60:	9b430067          	jr	-1612(t1) # 80002510 <uartputc_sync>

0000000080001b64 <consoleintr>:
    80001b64:	fe010113          	addi	sp,sp,-32
    80001b68:	00813823          	sd	s0,16(sp)
    80001b6c:	00913423          	sd	s1,8(sp)
    80001b70:	01213023          	sd	s2,0(sp)
    80001b74:	00113c23          	sd	ra,24(sp)
    80001b78:	02010413          	addi	s0,sp,32
    80001b7c:	00003917          	auipc	s2,0x3
    80001b80:	79c90913          	addi	s2,s2,1948 # 80005318 <cons>
    80001b84:	00050493          	mv	s1,a0
    80001b88:	00090513          	mv	a0,s2
    80001b8c:	00001097          	auipc	ra,0x1
    80001b90:	e40080e7          	jalr	-448(ra) # 800029cc <acquire>
    80001b94:	02048c63          	beqz	s1,80001bcc <consoleintr+0x68>
    80001b98:	0a092783          	lw	a5,160(s2)
    80001b9c:	09892703          	lw	a4,152(s2)
    80001ba0:	07f00693          	li	a3,127
    80001ba4:	40e7873b          	subw	a4,a5,a4
    80001ba8:	02e6e263          	bltu	a3,a4,80001bcc <consoleintr+0x68>
    80001bac:	00d00713          	li	a4,13
    80001bb0:	04e48063          	beq	s1,a4,80001bf0 <consoleintr+0x8c>
    80001bb4:	07f7f713          	andi	a4,a5,127
    80001bb8:	00e90733          	add	a4,s2,a4
    80001bbc:	0017879b          	addiw	a5,a5,1
    80001bc0:	0af92023          	sw	a5,160(s2)
    80001bc4:	00970c23          	sb	s1,24(a4)
    80001bc8:	08f92e23          	sw	a5,156(s2)
    80001bcc:	01013403          	ld	s0,16(sp)
    80001bd0:	01813083          	ld	ra,24(sp)
    80001bd4:	00813483          	ld	s1,8(sp)
    80001bd8:	00013903          	ld	s2,0(sp)
    80001bdc:	00003517          	auipc	a0,0x3
    80001be0:	73c50513          	addi	a0,a0,1852 # 80005318 <cons>
    80001be4:	02010113          	addi	sp,sp,32
    80001be8:	00001317          	auipc	t1,0x1
    80001bec:	eb030067          	jr	-336(t1) # 80002a98 <release>
    80001bf0:	00a00493          	li	s1,10
    80001bf4:	fc1ff06f          	j	80001bb4 <consoleintr+0x50>

0000000080001bf8 <consoleinit>:
    80001bf8:	fe010113          	addi	sp,sp,-32
    80001bfc:	00113c23          	sd	ra,24(sp)
    80001c00:	00813823          	sd	s0,16(sp)
    80001c04:	00913423          	sd	s1,8(sp)
    80001c08:	02010413          	addi	s0,sp,32
    80001c0c:	00003497          	auipc	s1,0x3
    80001c10:	70c48493          	addi	s1,s1,1804 # 80005318 <cons>
    80001c14:	00048513          	mv	a0,s1
    80001c18:	00002597          	auipc	a1,0x2
    80001c1c:	51058593          	addi	a1,a1,1296 # 80004128 <console_handler+0xf98>
    80001c20:	00001097          	auipc	ra,0x1
    80001c24:	d88080e7          	jalr	-632(ra) # 800029a8 <initlock>
    80001c28:	00000097          	auipc	ra,0x0
    80001c2c:	7ac080e7          	jalr	1964(ra) # 800023d4 <uartinit>
    80001c30:	01813083          	ld	ra,24(sp)
    80001c34:	01013403          	ld	s0,16(sp)
    80001c38:	00000797          	auipc	a5,0x0
    80001c3c:	d9c78793          	addi	a5,a5,-612 # 800019d4 <consoleread>
    80001c40:	0af4bc23          	sd	a5,184(s1)
    80001c44:	00000797          	auipc	a5,0x0
    80001c48:	cec78793          	addi	a5,a5,-788 # 80001930 <consolewrite>
    80001c4c:	0cf4b023          	sd	a5,192(s1)
    80001c50:	00813483          	ld	s1,8(sp)
    80001c54:	02010113          	addi	sp,sp,32
    80001c58:	00008067          	ret

0000000080001c5c <console_read>:
    80001c5c:	ff010113          	addi	sp,sp,-16
    80001c60:	00813423          	sd	s0,8(sp)
    80001c64:	01010413          	addi	s0,sp,16
    80001c68:	00813403          	ld	s0,8(sp)
    80001c6c:	00003317          	auipc	t1,0x3
    80001c70:	76433303          	ld	t1,1892(t1) # 800053d0 <devsw+0x10>
    80001c74:	01010113          	addi	sp,sp,16
    80001c78:	00030067          	jr	t1

0000000080001c7c <console_write>:
    80001c7c:	ff010113          	addi	sp,sp,-16
    80001c80:	00813423          	sd	s0,8(sp)
    80001c84:	01010413          	addi	s0,sp,16
    80001c88:	00813403          	ld	s0,8(sp)
    80001c8c:	00003317          	auipc	t1,0x3
    80001c90:	74c33303          	ld	t1,1868(t1) # 800053d8 <devsw+0x18>
    80001c94:	01010113          	addi	sp,sp,16
    80001c98:	00030067          	jr	t1

0000000080001c9c <panic>:
    80001c9c:	fe010113          	addi	sp,sp,-32
    80001ca0:	00113c23          	sd	ra,24(sp)
    80001ca4:	00813823          	sd	s0,16(sp)
    80001ca8:	00913423          	sd	s1,8(sp)
    80001cac:	02010413          	addi	s0,sp,32
    80001cb0:	00050493          	mv	s1,a0
    80001cb4:	00002517          	auipc	a0,0x2
    80001cb8:	47c50513          	addi	a0,a0,1148 # 80004130 <console_handler+0xfa0>
    80001cbc:	00003797          	auipc	a5,0x3
    80001cc0:	7a07ae23          	sw	zero,1980(a5) # 80005478 <pr+0x18>
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	034080e7          	jalr	52(ra) # 80001cf8 <__printf>
    80001ccc:	00048513          	mv	a0,s1
    80001cd0:	00000097          	auipc	ra,0x0
    80001cd4:	028080e7          	jalr	40(ra) # 80001cf8 <__printf>
    80001cd8:	00002517          	auipc	a0,0x2
    80001cdc:	43850513          	addi	a0,a0,1080 # 80004110 <console_handler+0xf80>
    80001ce0:	00000097          	auipc	ra,0x0
    80001ce4:	018080e7          	jalr	24(ra) # 80001cf8 <__printf>
    80001ce8:	00100793          	li	a5,1
    80001cec:	00002717          	auipc	a4,0x2
    80001cf0:	52f72e23          	sw	a5,1340(a4) # 80004228 <panicked>
    80001cf4:	0000006f          	j	80001cf4 <panic+0x58>

0000000080001cf8 <__printf>:
    80001cf8:	f3010113          	addi	sp,sp,-208
    80001cfc:	08813023          	sd	s0,128(sp)
    80001d00:	07313423          	sd	s3,104(sp)
    80001d04:	09010413          	addi	s0,sp,144
    80001d08:	05813023          	sd	s8,64(sp)
    80001d0c:	08113423          	sd	ra,136(sp)
    80001d10:	06913c23          	sd	s1,120(sp)
    80001d14:	07213823          	sd	s2,112(sp)
    80001d18:	07413023          	sd	s4,96(sp)
    80001d1c:	05513c23          	sd	s5,88(sp)
    80001d20:	05613823          	sd	s6,80(sp)
    80001d24:	05713423          	sd	s7,72(sp)
    80001d28:	03913c23          	sd	s9,56(sp)
    80001d2c:	03a13823          	sd	s10,48(sp)
    80001d30:	03b13423          	sd	s11,40(sp)
    80001d34:	00003317          	auipc	t1,0x3
    80001d38:	72c30313          	addi	t1,t1,1836 # 80005460 <pr>
    80001d3c:	01832c03          	lw	s8,24(t1)
    80001d40:	00b43423          	sd	a1,8(s0)
    80001d44:	00c43823          	sd	a2,16(s0)
    80001d48:	00d43c23          	sd	a3,24(s0)
    80001d4c:	02e43023          	sd	a4,32(s0)
    80001d50:	02f43423          	sd	a5,40(s0)
    80001d54:	03043823          	sd	a6,48(s0)
    80001d58:	03143c23          	sd	a7,56(s0)
    80001d5c:	00050993          	mv	s3,a0
    80001d60:	4a0c1663          	bnez	s8,8000220c <__printf+0x514>
    80001d64:	60098c63          	beqz	s3,8000237c <__printf+0x684>
    80001d68:	0009c503          	lbu	a0,0(s3)
    80001d6c:	00840793          	addi	a5,s0,8
    80001d70:	f6f43c23          	sd	a5,-136(s0)
    80001d74:	00000493          	li	s1,0
    80001d78:	22050063          	beqz	a0,80001f98 <__printf+0x2a0>
    80001d7c:	00002a37          	lui	s4,0x2
    80001d80:	00018ab7          	lui	s5,0x18
    80001d84:	000f4b37          	lui	s6,0xf4
    80001d88:	00989bb7          	lui	s7,0x989
    80001d8c:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80001d90:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80001d94:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80001d98:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80001d9c:	00148c9b          	addiw	s9,s1,1
    80001da0:	02500793          	li	a5,37
    80001da4:	01998933          	add	s2,s3,s9
    80001da8:	38f51263          	bne	a0,a5,8000212c <__printf+0x434>
    80001dac:	00094783          	lbu	a5,0(s2)
    80001db0:	00078c9b          	sext.w	s9,a5
    80001db4:	1e078263          	beqz	a5,80001f98 <__printf+0x2a0>
    80001db8:	0024849b          	addiw	s1,s1,2
    80001dbc:	07000713          	li	a4,112
    80001dc0:	00998933          	add	s2,s3,s1
    80001dc4:	38e78a63          	beq	a5,a4,80002158 <__printf+0x460>
    80001dc8:	20f76863          	bltu	a4,a5,80001fd8 <__printf+0x2e0>
    80001dcc:	42a78863          	beq	a5,a0,800021fc <__printf+0x504>
    80001dd0:	06400713          	li	a4,100
    80001dd4:	40e79663          	bne	a5,a4,800021e0 <__printf+0x4e8>
    80001dd8:	f7843783          	ld	a5,-136(s0)
    80001ddc:	0007a603          	lw	a2,0(a5)
    80001de0:	00878793          	addi	a5,a5,8
    80001de4:	f6f43c23          	sd	a5,-136(s0)
    80001de8:	42064a63          	bltz	a2,8000221c <__printf+0x524>
    80001dec:	00a00713          	li	a4,10
    80001df0:	02e677bb          	remuw	a5,a2,a4
    80001df4:	00002d97          	auipc	s11,0x2
    80001df8:	364d8d93          	addi	s11,s11,868 # 80004158 <digits>
    80001dfc:	00900593          	li	a1,9
    80001e00:	0006051b          	sext.w	a0,a2
    80001e04:	00000c93          	li	s9,0
    80001e08:	02079793          	slli	a5,a5,0x20
    80001e0c:	0207d793          	srli	a5,a5,0x20
    80001e10:	00fd87b3          	add	a5,s11,a5
    80001e14:	0007c783          	lbu	a5,0(a5)
    80001e18:	02e656bb          	divuw	a3,a2,a4
    80001e1c:	f8f40023          	sb	a5,-128(s0)
    80001e20:	14c5d863          	bge	a1,a2,80001f70 <__printf+0x278>
    80001e24:	06300593          	li	a1,99
    80001e28:	00100c93          	li	s9,1
    80001e2c:	02e6f7bb          	remuw	a5,a3,a4
    80001e30:	02079793          	slli	a5,a5,0x20
    80001e34:	0207d793          	srli	a5,a5,0x20
    80001e38:	00fd87b3          	add	a5,s11,a5
    80001e3c:	0007c783          	lbu	a5,0(a5)
    80001e40:	02e6d73b          	divuw	a4,a3,a4
    80001e44:	f8f400a3          	sb	a5,-127(s0)
    80001e48:	12a5f463          	bgeu	a1,a0,80001f70 <__printf+0x278>
    80001e4c:	00a00693          	li	a3,10
    80001e50:	00900593          	li	a1,9
    80001e54:	02d777bb          	remuw	a5,a4,a3
    80001e58:	02079793          	slli	a5,a5,0x20
    80001e5c:	0207d793          	srli	a5,a5,0x20
    80001e60:	00fd87b3          	add	a5,s11,a5
    80001e64:	0007c503          	lbu	a0,0(a5)
    80001e68:	02d757bb          	divuw	a5,a4,a3
    80001e6c:	f8a40123          	sb	a0,-126(s0)
    80001e70:	48e5f263          	bgeu	a1,a4,800022f4 <__printf+0x5fc>
    80001e74:	06300513          	li	a0,99
    80001e78:	02d7f5bb          	remuw	a1,a5,a3
    80001e7c:	02059593          	slli	a1,a1,0x20
    80001e80:	0205d593          	srli	a1,a1,0x20
    80001e84:	00bd85b3          	add	a1,s11,a1
    80001e88:	0005c583          	lbu	a1,0(a1)
    80001e8c:	02d7d7bb          	divuw	a5,a5,a3
    80001e90:	f8b401a3          	sb	a1,-125(s0)
    80001e94:	48e57263          	bgeu	a0,a4,80002318 <__printf+0x620>
    80001e98:	3e700513          	li	a0,999
    80001e9c:	02d7f5bb          	remuw	a1,a5,a3
    80001ea0:	02059593          	slli	a1,a1,0x20
    80001ea4:	0205d593          	srli	a1,a1,0x20
    80001ea8:	00bd85b3          	add	a1,s11,a1
    80001eac:	0005c583          	lbu	a1,0(a1)
    80001eb0:	02d7d7bb          	divuw	a5,a5,a3
    80001eb4:	f8b40223          	sb	a1,-124(s0)
    80001eb8:	46e57663          	bgeu	a0,a4,80002324 <__printf+0x62c>
    80001ebc:	02d7f5bb          	remuw	a1,a5,a3
    80001ec0:	02059593          	slli	a1,a1,0x20
    80001ec4:	0205d593          	srli	a1,a1,0x20
    80001ec8:	00bd85b3          	add	a1,s11,a1
    80001ecc:	0005c583          	lbu	a1,0(a1)
    80001ed0:	02d7d7bb          	divuw	a5,a5,a3
    80001ed4:	f8b402a3          	sb	a1,-123(s0)
    80001ed8:	46ea7863          	bgeu	s4,a4,80002348 <__printf+0x650>
    80001edc:	02d7f5bb          	remuw	a1,a5,a3
    80001ee0:	02059593          	slli	a1,a1,0x20
    80001ee4:	0205d593          	srli	a1,a1,0x20
    80001ee8:	00bd85b3          	add	a1,s11,a1
    80001eec:	0005c583          	lbu	a1,0(a1)
    80001ef0:	02d7d7bb          	divuw	a5,a5,a3
    80001ef4:	f8b40323          	sb	a1,-122(s0)
    80001ef8:	3eeaf863          	bgeu	s5,a4,800022e8 <__printf+0x5f0>
    80001efc:	02d7f5bb          	remuw	a1,a5,a3
    80001f00:	02059593          	slli	a1,a1,0x20
    80001f04:	0205d593          	srli	a1,a1,0x20
    80001f08:	00bd85b3          	add	a1,s11,a1
    80001f0c:	0005c583          	lbu	a1,0(a1)
    80001f10:	02d7d7bb          	divuw	a5,a5,a3
    80001f14:	f8b403a3          	sb	a1,-121(s0)
    80001f18:	42eb7e63          	bgeu	s6,a4,80002354 <__printf+0x65c>
    80001f1c:	02d7f5bb          	remuw	a1,a5,a3
    80001f20:	02059593          	slli	a1,a1,0x20
    80001f24:	0205d593          	srli	a1,a1,0x20
    80001f28:	00bd85b3          	add	a1,s11,a1
    80001f2c:	0005c583          	lbu	a1,0(a1)
    80001f30:	02d7d7bb          	divuw	a5,a5,a3
    80001f34:	f8b40423          	sb	a1,-120(s0)
    80001f38:	42ebfc63          	bgeu	s7,a4,80002370 <__printf+0x678>
    80001f3c:	02079793          	slli	a5,a5,0x20
    80001f40:	0207d793          	srli	a5,a5,0x20
    80001f44:	00fd8db3          	add	s11,s11,a5
    80001f48:	000dc703          	lbu	a4,0(s11)
    80001f4c:	00a00793          	li	a5,10
    80001f50:	00900c93          	li	s9,9
    80001f54:	f8e404a3          	sb	a4,-119(s0)
    80001f58:	00065c63          	bgez	a2,80001f70 <__printf+0x278>
    80001f5c:	f9040713          	addi	a4,s0,-112
    80001f60:	00f70733          	add	a4,a4,a5
    80001f64:	02d00693          	li	a3,45
    80001f68:	fed70823          	sb	a3,-16(a4)
    80001f6c:	00078c93          	mv	s9,a5
    80001f70:	f8040793          	addi	a5,s0,-128
    80001f74:	01978cb3          	add	s9,a5,s9
    80001f78:	f7f40d13          	addi	s10,s0,-129
    80001f7c:	000cc503          	lbu	a0,0(s9)
    80001f80:	fffc8c93          	addi	s9,s9,-1
    80001f84:	00000097          	auipc	ra,0x0
    80001f88:	b90080e7          	jalr	-1136(ra) # 80001b14 <consputc>
    80001f8c:	ffac98e3          	bne	s9,s10,80001f7c <__printf+0x284>
    80001f90:	00094503          	lbu	a0,0(s2)
    80001f94:	e00514e3          	bnez	a0,80001d9c <__printf+0xa4>
    80001f98:	1a0c1663          	bnez	s8,80002144 <__printf+0x44c>
    80001f9c:	08813083          	ld	ra,136(sp)
    80001fa0:	08013403          	ld	s0,128(sp)
    80001fa4:	07813483          	ld	s1,120(sp)
    80001fa8:	07013903          	ld	s2,112(sp)
    80001fac:	06813983          	ld	s3,104(sp)
    80001fb0:	06013a03          	ld	s4,96(sp)
    80001fb4:	05813a83          	ld	s5,88(sp)
    80001fb8:	05013b03          	ld	s6,80(sp)
    80001fbc:	04813b83          	ld	s7,72(sp)
    80001fc0:	04013c03          	ld	s8,64(sp)
    80001fc4:	03813c83          	ld	s9,56(sp)
    80001fc8:	03013d03          	ld	s10,48(sp)
    80001fcc:	02813d83          	ld	s11,40(sp)
    80001fd0:	0d010113          	addi	sp,sp,208
    80001fd4:	00008067          	ret
    80001fd8:	07300713          	li	a4,115
    80001fdc:	1ce78a63          	beq	a5,a4,800021b0 <__printf+0x4b8>
    80001fe0:	07800713          	li	a4,120
    80001fe4:	1ee79e63          	bne	a5,a4,800021e0 <__printf+0x4e8>
    80001fe8:	f7843783          	ld	a5,-136(s0)
    80001fec:	0007a703          	lw	a4,0(a5)
    80001ff0:	00878793          	addi	a5,a5,8
    80001ff4:	f6f43c23          	sd	a5,-136(s0)
    80001ff8:	28074263          	bltz	a4,8000227c <__printf+0x584>
    80001ffc:	00002d97          	auipc	s11,0x2
    80002000:	15cd8d93          	addi	s11,s11,348 # 80004158 <digits>
    80002004:	00f77793          	andi	a5,a4,15
    80002008:	00fd87b3          	add	a5,s11,a5
    8000200c:	0007c683          	lbu	a3,0(a5)
    80002010:	00f00613          	li	a2,15
    80002014:	0007079b          	sext.w	a5,a4
    80002018:	f8d40023          	sb	a3,-128(s0)
    8000201c:	0047559b          	srliw	a1,a4,0x4
    80002020:	0047569b          	srliw	a3,a4,0x4
    80002024:	00000c93          	li	s9,0
    80002028:	0ee65063          	bge	a2,a4,80002108 <__printf+0x410>
    8000202c:	00f6f693          	andi	a3,a3,15
    80002030:	00dd86b3          	add	a3,s11,a3
    80002034:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002038:	0087d79b          	srliw	a5,a5,0x8
    8000203c:	00100c93          	li	s9,1
    80002040:	f8d400a3          	sb	a3,-127(s0)
    80002044:	0cb67263          	bgeu	a2,a1,80002108 <__printf+0x410>
    80002048:	00f7f693          	andi	a3,a5,15
    8000204c:	00dd86b3          	add	a3,s11,a3
    80002050:	0006c583          	lbu	a1,0(a3)
    80002054:	00f00613          	li	a2,15
    80002058:	0047d69b          	srliw	a3,a5,0x4
    8000205c:	f8b40123          	sb	a1,-126(s0)
    80002060:	0047d593          	srli	a1,a5,0x4
    80002064:	28f67e63          	bgeu	a2,a5,80002300 <__printf+0x608>
    80002068:	00f6f693          	andi	a3,a3,15
    8000206c:	00dd86b3          	add	a3,s11,a3
    80002070:	0006c503          	lbu	a0,0(a3)
    80002074:	0087d813          	srli	a6,a5,0x8
    80002078:	0087d69b          	srliw	a3,a5,0x8
    8000207c:	f8a401a3          	sb	a0,-125(s0)
    80002080:	28b67663          	bgeu	a2,a1,8000230c <__printf+0x614>
    80002084:	00f6f693          	andi	a3,a3,15
    80002088:	00dd86b3          	add	a3,s11,a3
    8000208c:	0006c583          	lbu	a1,0(a3)
    80002090:	00c7d513          	srli	a0,a5,0xc
    80002094:	00c7d69b          	srliw	a3,a5,0xc
    80002098:	f8b40223          	sb	a1,-124(s0)
    8000209c:	29067a63          	bgeu	a2,a6,80002330 <__printf+0x638>
    800020a0:	00f6f693          	andi	a3,a3,15
    800020a4:	00dd86b3          	add	a3,s11,a3
    800020a8:	0006c583          	lbu	a1,0(a3)
    800020ac:	0107d813          	srli	a6,a5,0x10
    800020b0:	0107d69b          	srliw	a3,a5,0x10
    800020b4:	f8b402a3          	sb	a1,-123(s0)
    800020b8:	28a67263          	bgeu	a2,a0,8000233c <__printf+0x644>
    800020bc:	00f6f693          	andi	a3,a3,15
    800020c0:	00dd86b3          	add	a3,s11,a3
    800020c4:	0006c683          	lbu	a3,0(a3)
    800020c8:	0147d79b          	srliw	a5,a5,0x14
    800020cc:	f8d40323          	sb	a3,-122(s0)
    800020d0:	21067663          	bgeu	a2,a6,800022dc <__printf+0x5e4>
    800020d4:	02079793          	slli	a5,a5,0x20
    800020d8:	0207d793          	srli	a5,a5,0x20
    800020dc:	00fd8db3          	add	s11,s11,a5
    800020e0:	000dc683          	lbu	a3,0(s11)
    800020e4:	00800793          	li	a5,8
    800020e8:	00700c93          	li	s9,7
    800020ec:	f8d403a3          	sb	a3,-121(s0)
    800020f0:	00075c63          	bgez	a4,80002108 <__printf+0x410>
    800020f4:	f9040713          	addi	a4,s0,-112
    800020f8:	00f70733          	add	a4,a4,a5
    800020fc:	02d00693          	li	a3,45
    80002100:	fed70823          	sb	a3,-16(a4)
    80002104:	00078c93          	mv	s9,a5
    80002108:	f8040793          	addi	a5,s0,-128
    8000210c:	01978cb3          	add	s9,a5,s9
    80002110:	f7f40d13          	addi	s10,s0,-129
    80002114:	000cc503          	lbu	a0,0(s9)
    80002118:	fffc8c93          	addi	s9,s9,-1
    8000211c:	00000097          	auipc	ra,0x0
    80002120:	9f8080e7          	jalr	-1544(ra) # 80001b14 <consputc>
    80002124:	ff9d18e3          	bne	s10,s9,80002114 <__printf+0x41c>
    80002128:	0100006f          	j	80002138 <__printf+0x440>
    8000212c:	00000097          	auipc	ra,0x0
    80002130:	9e8080e7          	jalr	-1560(ra) # 80001b14 <consputc>
    80002134:	000c8493          	mv	s1,s9
    80002138:	00094503          	lbu	a0,0(s2)
    8000213c:	c60510e3          	bnez	a0,80001d9c <__printf+0xa4>
    80002140:	e40c0ee3          	beqz	s8,80001f9c <__printf+0x2a4>
    80002144:	00003517          	auipc	a0,0x3
    80002148:	31c50513          	addi	a0,a0,796 # 80005460 <pr>
    8000214c:	00001097          	auipc	ra,0x1
    80002150:	94c080e7          	jalr	-1716(ra) # 80002a98 <release>
    80002154:	e49ff06f          	j	80001f9c <__printf+0x2a4>
    80002158:	f7843783          	ld	a5,-136(s0)
    8000215c:	03000513          	li	a0,48
    80002160:	01000d13          	li	s10,16
    80002164:	00878713          	addi	a4,a5,8
    80002168:	0007bc83          	ld	s9,0(a5)
    8000216c:	f6e43c23          	sd	a4,-136(s0)
    80002170:	00000097          	auipc	ra,0x0
    80002174:	9a4080e7          	jalr	-1628(ra) # 80001b14 <consputc>
    80002178:	07800513          	li	a0,120
    8000217c:	00000097          	auipc	ra,0x0
    80002180:	998080e7          	jalr	-1640(ra) # 80001b14 <consputc>
    80002184:	00002d97          	auipc	s11,0x2
    80002188:	fd4d8d93          	addi	s11,s11,-44 # 80004158 <digits>
    8000218c:	03ccd793          	srli	a5,s9,0x3c
    80002190:	00fd87b3          	add	a5,s11,a5
    80002194:	0007c503          	lbu	a0,0(a5)
    80002198:	fffd0d1b          	addiw	s10,s10,-1
    8000219c:	004c9c93          	slli	s9,s9,0x4
    800021a0:	00000097          	auipc	ra,0x0
    800021a4:	974080e7          	jalr	-1676(ra) # 80001b14 <consputc>
    800021a8:	fe0d12e3          	bnez	s10,8000218c <__printf+0x494>
    800021ac:	f8dff06f          	j	80002138 <__printf+0x440>
    800021b0:	f7843783          	ld	a5,-136(s0)
    800021b4:	0007bc83          	ld	s9,0(a5)
    800021b8:	00878793          	addi	a5,a5,8
    800021bc:	f6f43c23          	sd	a5,-136(s0)
    800021c0:	000c9a63          	bnez	s9,800021d4 <__printf+0x4dc>
    800021c4:	1080006f          	j	800022cc <__printf+0x5d4>
    800021c8:	001c8c93          	addi	s9,s9,1
    800021cc:	00000097          	auipc	ra,0x0
    800021d0:	948080e7          	jalr	-1720(ra) # 80001b14 <consputc>
    800021d4:	000cc503          	lbu	a0,0(s9)
    800021d8:	fe0518e3          	bnez	a0,800021c8 <__printf+0x4d0>
    800021dc:	f5dff06f          	j	80002138 <__printf+0x440>
    800021e0:	02500513          	li	a0,37
    800021e4:	00000097          	auipc	ra,0x0
    800021e8:	930080e7          	jalr	-1744(ra) # 80001b14 <consputc>
    800021ec:	000c8513          	mv	a0,s9
    800021f0:	00000097          	auipc	ra,0x0
    800021f4:	924080e7          	jalr	-1756(ra) # 80001b14 <consputc>
    800021f8:	f41ff06f          	j	80002138 <__printf+0x440>
    800021fc:	02500513          	li	a0,37
    80002200:	00000097          	auipc	ra,0x0
    80002204:	914080e7          	jalr	-1772(ra) # 80001b14 <consputc>
    80002208:	f31ff06f          	j	80002138 <__printf+0x440>
    8000220c:	00030513          	mv	a0,t1
    80002210:	00000097          	auipc	ra,0x0
    80002214:	7bc080e7          	jalr	1980(ra) # 800029cc <acquire>
    80002218:	b4dff06f          	j	80001d64 <__printf+0x6c>
    8000221c:	40c0053b          	negw	a0,a2
    80002220:	00a00713          	li	a4,10
    80002224:	02e576bb          	remuw	a3,a0,a4
    80002228:	00002d97          	auipc	s11,0x2
    8000222c:	f30d8d93          	addi	s11,s11,-208 # 80004158 <digits>
    80002230:	ff700593          	li	a1,-9
    80002234:	02069693          	slli	a3,a3,0x20
    80002238:	0206d693          	srli	a3,a3,0x20
    8000223c:	00dd86b3          	add	a3,s11,a3
    80002240:	0006c683          	lbu	a3,0(a3)
    80002244:	02e557bb          	divuw	a5,a0,a4
    80002248:	f8d40023          	sb	a3,-128(s0)
    8000224c:	10b65e63          	bge	a2,a1,80002368 <__printf+0x670>
    80002250:	06300593          	li	a1,99
    80002254:	02e7f6bb          	remuw	a3,a5,a4
    80002258:	02069693          	slli	a3,a3,0x20
    8000225c:	0206d693          	srli	a3,a3,0x20
    80002260:	00dd86b3          	add	a3,s11,a3
    80002264:	0006c683          	lbu	a3,0(a3)
    80002268:	02e7d73b          	divuw	a4,a5,a4
    8000226c:	00200793          	li	a5,2
    80002270:	f8d400a3          	sb	a3,-127(s0)
    80002274:	bca5ece3          	bltu	a1,a0,80001e4c <__printf+0x154>
    80002278:	ce5ff06f          	j	80001f5c <__printf+0x264>
    8000227c:	40e007bb          	negw	a5,a4
    80002280:	00002d97          	auipc	s11,0x2
    80002284:	ed8d8d93          	addi	s11,s11,-296 # 80004158 <digits>
    80002288:	00f7f693          	andi	a3,a5,15
    8000228c:	00dd86b3          	add	a3,s11,a3
    80002290:	0006c583          	lbu	a1,0(a3)
    80002294:	ff100613          	li	a2,-15
    80002298:	0047d69b          	srliw	a3,a5,0x4
    8000229c:	f8b40023          	sb	a1,-128(s0)
    800022a0:	0047d59b          	srliw	a1,a5,0x4
    800022a4:	0ac75e63          	bge	a4,a2,80002360 <__printf+0x668>
    800022a8:	00f6f693          	andi	a3,a3,15
    800022ac:	00dd86b3          	add	a3,s11,a3
    800022b0:	0006c603          	lbu	a2,0(a3)
    800022b4:	00f00693          	li	a3,15
    800022b8:	0087d79b          	srliw	a5,a5,0x8
    800022bc:	f8c400a3          	sb	a2,-127(s0)
    800022c0:	d8b6e4e3          	bltu	a3,a1,80002048 <__printf+0x350>
    800022c4:	00200793          	li	a5,2
    800022c8:	e2dff06f          	j	800020f4 <__printf+0x3fc>
    800022cc:	00002c97          	auipc	s9,0x2
    800022d0:	e6cc8c93          	addi	s9,s9,-404 # 80004138 <console_handler+0xfa8>
    800022d4:	02800513          	li	a0,40
    800022d8:	ef1ff06f          	j	800021c8 <__printf+0x4d0>
    800022dc:	00700793          	li	a5,7
    800022e0:	00600c93          	li	s9,6
    800022e4:	e0dff06f          	j	800020f0 <__printf+0x3f8>
    800022e8:	00700793          	li	a5,7
    800022ec:	00600c93          	li	s9,6
    800022f0:	c69ff06f          	j	80001f58 <__printf+0x260>
    800022f4:	00300793          	li	a5,3
    800022f8:	00200c93          	li	s9,2
    800022fc:	c5dff06f          	j	80001f58 <__printf+0x260>
    80002300:	00300793          	li	a5,3
    80002304:	00200c93          	li	s9,2
    80002308:	de9ff06f          	j	800020f0 <__printf+0x3f8>
    8000230c:	00400793          	li	a5,4
    80002310:	00300c93          	li	s9,3
    80002314:	dddff06f          	j	800020f0 <__printf+0x3f8>
    80002318:	00400793          	li	a5,4
    8000231c:	00300c93          	li	s9,3
    80002320:	c39ff06f          	j	80001f58 <__printf+0x260>
    80002324:	00500793          	li	a5,5
    80002328:	00400c93          	li	s9,4
    8000232c:	c2dff06f          	j	80001f58 <__printf+0x260>
    80002330:	00500793          	li	a5,5
    80002334:	00400c93          	li	s9,4
    80002338:	db9ff06f          	j	800020f0 <__printf+0x3f8>
    8000233c:	00600793          	li	a5,6
    80002340:	00500c93          	li	s9,5
    80002344:	dadff06f          	j	800020f0 <__printf+0x3f8>
    80002348:	00600793          	li	a5,6
    8000234c:	00500c93          	li	s9,5
    80002350:	c09ff06f          	j	80001f58 <__printf+0x260>
    80002354:	00800793          	li	a5,8
    80002358:	00700c93          	li	s9,7
    8000235c:	bfdff06f          	j	80001f58 <__printf+0x260>
    80002360:	00100793          	li	a5,1
    80002364:	d91ff06f          	j	800020f4 <__printf+0x3fc>
    80002368:	00100793          	li	a5,1
    8000236c:	bf1ff06f          	j	80001f5c <__printf+0x264>
    80002370:	00900793          	li	a5,9
    80002374:	00800c93          	li	s9,8
    80002378:	be1ff06f          	j	80001f58 <__printf+0x260>
    8000237c:	00002517          	auipc	a0,0x2
    80002380:	dc450513          	addi	a0,a0,-572 # 80004140 <console_handler+0xfb0>
    80002384:	00000097          	auipc	ra,0x0
    80002388:	918080e7          	jalr	-1768(ra) # 80001c9c <panic>

000000008000238c <printfinit>:
    8000238c:	fe010113          	addi	sp,sp,-32
    80002390:	00813823          	sd	s0,16(sp)
    80002394:	00913423          	sd	s1,8(sp)
    80002398:	00113c23          	sd	ra,24(sp)
    8000239c:	02010413          	addi	s0,sp,32
    800023a0:	00003497          	auipc	s1,0x3
    800023a4:	0c048493          	addi	s1,s1,192 # 80005460 <pr>
    800023a8:	00048513          	mv	a0,s1
    800023ac:	00002597          	auipc	a1,0x2
    800023b0:	da458593          	addi	a1,a1,-604 # 80004150 <console_handler+0xfc0>
    800023b4:	00000097          	auipc	ra,0x0
    800023b8:	5f4080e7          	jalr	1524(ra) # 800029a8 <initlock>
    800023bc:	01813083          	ld	ra,24(sp)
    800023c0:	01013403          	ld	s0,16(sp)
    800023c4:	0004ac23          	sw	zero,24(s1)
    800023c8:	00813483          	ld	s1,8(sp)
    800023cc:	02010113          	addi	sp,sp,32
    800023d0:	00008067          	ret

00000000800023d4 <uartinit>:
    800023d4:	ff010113          	addi	sp,sp,-16
    800023d8:	00813423          	sd	s0,8(sp)
    800023dc:	01010413          	addi	s0,sp,16
    800023e0:	100007b7          	lui	a5,0x10000
    800023e4:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    800023e8:	f8000713          	li	a4,-128
    800023ec:	00e781a3          	sb	a4,3(a5)
    800023f0:	00300713          	li	a4,3
    800023f4:	00e78023          	sb	a4,0(a5)
    800023f8:	000780a3          	sb	zero,1(a5)
    800023fc:	00e781a3          	sb	a4,3(a5)
    80002400:	00700693          	li	a3,7
    80002404:	00d78123          	sb	a3,2(a5)
    80002408:	00e780a3          	sb	a4,1(a5)
    8000240c:	00813403          	ld	s0,8(sp)
    80002410:	01010113          	addi	sp,sp,16
    80002414:	00008067          	ret

0000000080002418 <uartputc>:
    80002418:	00002797          	auipc	a5,0x2
    8000241c:	e107a783          	lw	a5,-496(a5) # 80004228 <panicked>
    80002420:	00078463          	beqz	a5,80002428 <uartputc+0x10>
    80002424:	0000006f          	j	80002424 <uartputc+0xc>
    80002428:	fd010113          	addi	sp,sp,-48
    8000242c:	02813023          	sd	s0,32(sp)
    80002430:	00913c23          	sd	s1,24(sp)
    80002434:	01213823          	sd	s2,16(sp)
    80002438:	01313423          	sd	s3,8(sp)
    8000243c:	02113423          	sd	ra,40(sp)
    80002440:	03010413          	addi	s0,sp,48
    80002444:	00002917          	auipc	s2,0x2
    80002448:	dec90913          	addi	s2,s2,-532 # 80004230 <uart_tx_r>
    8000244c:	00093783          	ld	a5,0(s2)
    80002450:	00002497          	auipc	s1,0x2
    80002454:	de848493          	addi	s1,s1,-536 # 80004238 <uart_tx_w>
    80002458:	0004b703          	ld	a4,0(s1)
    8000245c:	02078693          	addi	a3,a5,32
    80002460:	00050993          	mv	s3,a0
    80002464:	02e69c63          	bne	a3,a4,8000249c <uartputc+0x84>
    80002468:	00001097          	auipc	ra,0x1
    8000246c:	834080e7          	jalr	-1996(ra) # 80002c9c <push_on>
    80002470:	00093783          	ld	a5,0(s2)
    80002474:	0004b703          	ld	a4,0(s1)
    80002478:	02078793          	addi	a5,a5,32
    8000247c:	00e79463          	bne	a5,a4,80002484 <uartputc+0x6c>
    80002480:	0000006f          	j	80002480 <uartputc+0x68>
    80002484:	00001097          	auipc	ra,0x1
    80002488:	88c080e7          	jalr	-1908(ra) # 80002d10 <pop_on>
    8000248c:	00093783          	ld	a5,0(s2)
    80002490:	0004b703          	ld	a4,0(s1)
    80002494:	02078693          	addi	a3,a5,32
    80002498:	fce688e3          	beq	a3,a4,80002468 <uartputc+0x50>
    8000249c:	01f77693          	andi	a3,a4,31
    800024a0:	00003597          	auipc	a1,0x3
    800024a4:	fe058593          	addi	a1,a1,-32 # 80005480 <uart_tx_buf>
    800024a8:	00d586b3          	add	a3,a1,a3
    800024ac:	00170713          	addi	a4,a4,1
    800024b0:	01368023          	sb	s3,0(a3)
    800024b4:	00e4b023          	sd	a4,0(s1)
    800024b8:	10000637          	lui	a2,0x10000
    800024bc:	02f71063          	bne	a4,a5,800024dc <uartputc+0xc4>
    800024c0:	0340006f          	j	800024f4 <uartputc+0xdc>
    800024c4:	00074703          	lbu	a4,0(a4)
    800024c8:	00f93023          	sd	a5,0(s2)
    800024cc:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    800024d0:	00093783          	ld	a5,0(s2)
    800024d4:	0004b703          	ld	a4,0(s1)
    800024d8:	00f70e63          	beq	a4,a5,800024f4 <uartputc+0xdc>
    800024dc:	00564683          	lbu	a3,5(a2)
    800024e0:	01f7f713          	andi	a4,a5,31
    800024e4:	00e58733          	add	a4,a1,a4
    800024e8:	0206f693          	andi	a3,a3,32
    800024ec:	00178793          	addi	a5,a5,1
    800024f0:	fc069ae3          	bnez	a3,800024c4 <uartputc+0xac>
    800024f4:	02813083          	ld	ra,40(sp)
    800024f8:	02013403          	ld	s0,32(sp)
    800024fc:	01813483          	ld	s1,24(sp)
    80002500:	01013903          	ld	s2,16(sp)
    80002504:	00813983          	ld	s3,8(sp)
    80002508:	03010113          	addi	sp,sp,48
    8000250c:	00008067          	ret

0000000080002510 <uartputc_sync>:
    80002510:	ff010113          	addi	sp,sp,-16
    80002514:	00813423          	sd	s0,8(sp)
    80002518:	01010413          	addi	s0,sp,16
    8000251c:	00002717          	auipc	a4,0x2
    80002520:	d0c72703          	lw	a4,-756(a4) # 80004228 <panicked>
    80002524:	02071663          	bnez	a4,80002550 <uartputc_sync+0x40>
    80002528:	00050793          	mv	a5,a0
    8000252c:	100006b7          	lui	a3,0x10000
    80002530:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002534:	02077713          	andi	a4,a4,32
    80002538:	fe070ce3          	beqz	a4,80002530 <uartputc_sync+0x20>
    8000253c:	0ff7f793          	andi	a5,a5,255
    80002540:	00f68023          	sb	a5,0(a3)
    80002544:	00813403          	ld	s0,8(sp)
    80002548:	01010113          	addi	sp,sp,16
    8000254c:	00008067          	ret
    80002550:	0000006f          	j	80002550 <uartputc_sync+0x40>

0000000080002554 <uartstart>:
    80002554:	ff010113          	addi	sp,sp,-16
    80002558:	00813423          	sd	s0,8(sp)
    8000255c:	01010413          	addi	s0,sp,16
    80002560:	00002617          	auipc	a2,0x2
    80002564:	cd060613          	addi	a2,a2,-816 # 80004230 <uart_tx_r>
    80002568:	00002517          	auipc	a0,0x2
    8000256c:	cd050513          	addi	a0,a0,-816 # 80004238 <uart_tx_w>
    80002570:	00063783          	ld	a5,0(a2)
    80002574:	00053703          	ld	a4,0(a0)
    80002578:	04f70263          	beq	a4,a5,800025bc <uartstart+0x68>
    8000257c:	100005b7          	lui	a1,0x10000
    80002580:	00003817          	auipc	a6,0x3
    80002584:	f0080813          	addi	a6,a6,-256 # 80005480 <uart_tx_buf>
    80002588:	01c0006f          	j	800025a4 <uartstart+0x50>
    8000258c:	0006c703          	lbu	a4,0(a3)
    80002590:	00f63023          	sd	a5,0(a2)
    80002594:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    80002598:	00063783          	ld	a5,0(a2)
    8000259c:	00053703          	ld	a4,0(a0)
    800025a0:	00f70e63          	beq	a4,a5,800025bc <uartstart+0x68>
    800025a4:	01f7f713          	andi	a4,a5,31
    800025a8:	00e806b3          	add	a3,a6,a4
    800025ac:	0055c703          	lbu	a4,5(a1)
    800025b0:	00178793          	addi	a5,a5,1
    800025b4:	02077713          	andi	a4,a4,32
    800025b8:	fc071ae3          	bnez	a4,8000258c <uartstart+0x38>
    800025bc:	00813403          	ld	s0,8(sp)
    800025c0:	01010113          	addi	sp,sp,16
    800025c4:	00008067          	ret

00000000800025c8 <uartgetc>:
    800025c8:	ff010113          	addi	sp,sp,-16
    800025cc:	00813423          	sd	s0,8(sp)
    800025d0:	01010413          	addi	s0,sp,16
    800025d4:	10000737          	lui	a4,0x10000
    800025d8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    800025dc:	0017f793          	andi	a5,a5,1
    800025e0:	00078c63          	beqz	a5,800025f8 <uartgetc+0x30>
    800025e4:	00074503          	lbu	a0,0(a4)
    800025e8:	0ff57513          	andi	a0,a0,255
    800025ec:	00813403          	ld	s0,8(sp)
    800025f0:	01010113          	addi	sp,sp,16
    800025f4:	00008067          	ret
    800025f8:	fff00513          	li	a0,-1
    800025fc:	ff1ff06f          	j	800025ec <uartgetc+0x24>

0000000080002600 <uartintr>:
    80002600:	100007b7          	lui	a5,0x10000
    80002604:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002608:	0017f793          	andi	a5,a5,1
    8000260c:	0a078463          	beqz	a5,800026b4 <uartintr+0xb4>
    80002610:	fe010113          	addi	sp,sp,-32
    80002614:	00813823          	sd	s0,16(sp)
    80002618:	00913423          	sd	s1,8(sp)
    8000261c:	00113c23          	sd	ra,24(sp)
    80002620:	02010413          	addi	s0,sp,32
    80002624:	100004b7          	lui	s1,0x10000
    80002628:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000262c:	0ff57513          	andi	a0,a0,255
    80002630:	fffff097          	auipc	ra,0xfffff
    80002634:	534080e7          	jalr	1332(ra) # 80001b64 <consoleintr>
    80002638:	0054c783          	lbu	a5,5(s1)
    8000263c:	0017f793          	andi	a5,a5,1
    80002640:	fe0794e3          	bnez	a5,80002628 <uartintr+0x28>
    80002644:	00002617          	auipc	a2,0x2
    80002648:	bec60613          	addi	a2,a2,-1044 # 80004230 <uart_tx_r>
    8000264c:	00002517          	auipc	a0,0x2
    80002650:	bec50513          	addi	a0,a0,-1044 # 80004238 <uart_tx_w>
    80002654:	00063783          	ld	a5,0(a2)
    80002658:	00053703          	ld	a4,0(a0)
    8000265c:	04f70263          	beq	a4,a5,800026a0 <uartintr+0xa0>
    80002660:	100005b7          	lui	a1,0x10000
    80002664:	00003817          	auipc	a6,0x3
    80002668:	e1c80813          	addi	a6,a6,-484 # 80005480 <uart_tx_buf>
    8000266c:	01c0006f          	j	80002688 <uartintr+0x88>
    80002670:	0006c703          	lbu	a4,0(a3)
    80002674:	00f63023          	sd	a5,0(a2)
    80002678:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000267c:	00063783          	ld	a5,0(a2)
    80002680:	00053703          	ld	a4,0(a0)
    80002684:	00f70e63          	beq	a4,a5,800026a0 <uartintr+0xa0>
    80002688:	01f7f713          	andi	a4,a5,31
    8000268c:	00e806b3          	add	a3,a6,a4
    80002690:	0055c703          	lbu	a4,5(a1)
    80002694:	00178793          	addi	a5,a5,1
    80002698:	02077713          	andi	a4,a4,32
    8000269c:	fc071ae3          	bnez	a4,80002670 <uartintr+0x70>
    800026a0:	01813083          	ld	ra,24(sp)
    800026a4:	01013403          	ld	s0,16(sp)
    800026a8:	00813483          	ld	s1,8(sp)
    800026ac:	02010113          	addi	sp,sp,32
    800026b0:	00008067          	ret
    800026b4:	00002617          	auipc	a2,0x2
    800026b8:	b7c60613          	addi	a2,a2,-1156 # 80004230 <uart_tx_r>
    800026bc:	00002517          	auipc	a0,0x2
    800026c0:	b7c50513          	addi	a0,a0,-1156 # 80004238 <uart_tx_w>
    800026c4:	00063783          	ld	a5,0(a2)
    800026c8:	00053703          	ld	a4,0(a0)
    800026cc:	04f70263          	beq	a4,a5,80002710 <uartintr+0x110>
    800026d0:	100005b7          	lui	a1,0x10000
    800026d4:	00003817          	auipc	a6,0x3
    800026d8:	dac80813          	addi	a6,a6,-596 # 80005480 <uart_tx_buf>
    800026dc:	01c0006f          	j	800026f8 <uartintr+0xf8>
    800026e0:	0006c703          	lbu	a4,0(a3)
    800026e4:	00f63023          	sd	a5,0(a2)
    800026e8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800026ec:	00063783          	ld	a5,0(a2)
    800026f0:	00053703          	ld	a4,0(a0)
    800026f4:	02f70063          	beq	a4,a5,80002714 <uartintr+0x114>
    800026f8:	01f7f713          	andi	a4,a5,31
    800026fc:	00e806b3          	add	a3,a6,a4
    80002700:	0055c703          	lbu	a4,5(a1)
    80002704:	00178793          	addi	a5,a5,1
    80002708:	02077713          	andi	a4,a4,32
    8000270c:	fc071ae3          	bnez	a4,800026e0 <uartintr+0xe0>
    80002710:	00008067          	ret
    80002714:	00008067          	ret

0000000080002718 <kinit>:
    80002718:	fc010113          	addi	sp,sp,-64
    8000271c:	02913423          	sd	s1,40(sp)
    80002720:	fffff7b7          	lui	a5,0xfffff
    80002724:	00004497          	auipc	s1,0x4
    80002728:	d7b48493          	addi	s1,s1,-645 # 8000649f <end+0xfff>
    8000272c:	02813823          	sd	s0,48(sp)
    80002730:	01313c23          	sd	s3,24(sp)
    80002734:	00f4f4b3          	and	s1,s1,a5
    80002738:	02113c23          	sd	ra,56(sp)
    8000273c:	03213023          	sd	s2,32(sp)
    80002740:	01413823          	sd	s4,16(sp)
    80002744:	01513423          	sd	s5,8(sp)
    80002748:	04010413          	addi	s0,sp,64
    8000274c:	000017b7          	lui	a5,0x1
    80002750:	01100993          	li	s3,17
    80002754:	00f487b3          	add	a5,s1,a5
    80002758:	01b99993          	slli	s3,s3,0x1b
    8000275c:	06f9e063          	bltu	s3,a5,800027bc <kinit+0xa4>
    80002760:	00003a97          	auipc	s5,0x3
    80002764:	d40a8a93          	addi	s5,s5,-704 # 800054a0 <end>
    80002768:	0754ec63          	bltu	s1,s5,800027e0 <kinit+0xc8>
    8000276c:	0734fa63          	bgeu	s1,s3,800027e0 <kinit+0xc8>
    80002770:	00088a37          	lui	s4,0x88
    80002774:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    80002778:	00002917          	auipc	s2,0x2
    8000277c:	ac890913          	addi	s2,s2,-1336 # 80004240 <kmem>
    80002780:	00ca1a13          	slli	s4,s4,0xc
    80002784:	0140006f          	j	80002798 <kinit+0x80>
    80002788:	000017b7          	lui	a5,0x1
    8000278c:	00f484b3          	add	s1,s1,a5
    80002790:	0554e863          	bltu	s1,s5,800027e0 <kinit+0xc8>
    80002794:	0534f663          	bgeu	s1,s3,800027e0 <kinit+0xc8>
    80002798:	00001637          	lui	a2,0x1
    8000279c:	00100593          	li	a1,1
    800027a0:	00048513          	mv	a0,s1
    800027a4:	00000097          	auipc	ra,0x0
    800027a8:	5e4080e7          	jalr	1508(ra) # 80002d88 <__memset>
    800027ac:	00093783          	ld	a5,0(s2)
    800027b0:	00f4b023          	sd	a5,0(s1)
    800027b4:	00993023          	sd	s1,0(s2)
    800027b8:	fd4498e3          	bne	s1,s4,80002788 <kinit+0x70>
    800027bc:	03813083          	ld	ra,56(sp)
    800027c0:	03013403          	ld	s0,48(sp)
    800027c4:	02813483          	ld	s1,40(sp)
    800027c8:	02013903          	ld	s2,32(sp)
    800027cc:	01813983          	ld	s3,24(sp)
    800027d0:	01013a03          	ld	s4,16(sp)
    800027d4:	00813a83          	ld	s5,8(sp)
    800027d8:	04010113          	addi	sp,sp,64
    800027dc:	00008067          	ret
    800027e0:	00002517          	auipc	a0,0x2
    800027e4:	99050513          	addi	a0,a0,-1648 # 80004170 <digits+0x18>
    800027e8:	fffff097          	auipc	ra,0xfffff
    800027ec:	4b4080e7          	jalr	1204(ra) # 80001c9c <panic>

00000000800027f0 <freerange>:
    800027f0:	fc010113          	addi	sp,sp,-64
    800027f4:	000017b7          	lui	a5,0x1
    800027f8:	02913423          	sd	s1,40(sp)
    800027fc:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002800:	009504b3          	add	s1,a0,s1
    80002804:	fffff537          	lui	a0,0xfffff
    80002808:	02813823          	sd	s0,48(sp)
    8000280c:	02113c23          	sd	ra,56(sp)
    80002810:	03213023          	sd	s2,32(sp)
    80002814:	01313c23          	sd	s3,24(sp)
    80002818:	01413823          	sd	s4,16(sp)
    8000281c:	01513423          	sd	s5,8(sp)
    80002820:	01613023          	sd	s6,0(sp)
    80002824:	04010413          	addi	s0,sp,64
    80002828:	00a4f4b3          	and	s1,s1,a0
    8000282c:	00f487b3          	add	a5,s1,a5
    80002830:	06f5e463          	bltu	a1,a5,80002898 <freerange+0xa8>
    80002834:	00003a97          	auipc	s5,0x3
    80002838:	c6ca8a93          	addi	s5,s5,-916 # 800054a0 <end>
    8000283c:	0954e263          	bltu	s1,s5,800028c0 <freerange+0xd0>
    80002840:	01100993          	li	s3,17
    80002844:	01b99993          	slli	s3,s3,0x1b
    80002848:	0734fc63          	bgeu	s1,s3,800028c0 <freerange+0xd0>
    8000284c:	00058a13          	mv	s4,a1
    80002850:	00002917          	auipc	s2,0x2
    80002854:	9f090913          	addi	s2,s2,-1552 # 80004240 <kmem>
    80002858:	00002b37          	lui	s6,0x2
    8000285c:	0140006f          	j	80002870 <freerange+0x80>
    80002860:	000017b7          	lui	a5,0x1
    80002864:	00f484b3          	add	s1,s1,a5
    80002868:	0554ec63          	bltu	s1,s5,800028c0 <freerange+0xd0>
    8000286c:	0534fa63          	bgeu	s1,s3,800028c0 <freerange+0xd0>
    80002870:	00001637          	lui	a2,0x1
    80002874:	00100593          	li	a1,1
    80002878:	00048513          	mv	a0,s1
    8000287c:	00000097          	auipc	ra,0x0
    80002880:	50c080e7          	jalr	1292(ra) # 80002d88 <__memset>
    80002884:	00093703          	ld	a4,0(s2)
    80002888:	016487b3          	add	a5,s1,s6
    8000288c:	00e4b023          	sd	a4,0(s1)
    80002890:	00993023          	sd	s1,0(s2)
    80002894:	fcfa76e3          	bgeu	s4,a5,80002860 <freerange+0x70>
    80002898:	03813083          	ld	ra,56(sp)
    8000289c:	03013403          	ld	s0,48(sp)
    800028a0:	02813483          	ld	s1,40(sp)
    800028a4:	02013903          	ld	s2,32(sp)
    800028a8:	01813983          	ld	s3,24(sp)
    800028ac:	01013a03          	ld	s4,16(sp)
    800028b0:	00813a83          	ld	s5,8(sp)
    800028b4:	00013b03          	ld	s6,0(sp)
    800028b8:	04010113          	addi	sp,sp,64
    800028bc:	00008067          	ret
    800028c0:	00002517          	auipc	a0,0x2
    800028c4:	8b050513          	addi	a0,a0,-1872 # 80004170 <digits+0x18>
    800028c8:	fffff097          	auipc	ra,0xfffff
    800028cc:	3d4080e7          	jalr	980(ra) # 80001c9c <panic>

00000000800028d0 <kfree>:
    800028d0:	fe010113          	addi	sp,sp,-32
    800028d4:	00813823          	sd	s0,16(sp)
    800028d8:	00113c23          	sd	ra,24(sp)
    800028dc:	00913423          	sd	s1,8(sp)
    800028e0:	02010413          	addi	s0,sp,32
    800028e4:	03451793          	slli	a5,a0,0x34
    800028e8:	04079c63          	bnez	a5,80002940 <kfree+0x70>
    800028ec:	00003797          	auipc	a5,0x3
    800028f0:	bb478793          	addi	a5,a5,-1100 # 800054a0 <end>
    800028f4:	00050493          	mv	s1,a0
    800028f8:	04f56463          	bltu	a0,a5,80002940 <kfree+0x70>
    800028fc:	01100793          	li	a5,17
    80002900:	01b79793          	slli	a5,a5,0x1b
    80002904:	02f57e63          	bgeu	a0,a5,80002940 <kfree+0x70>
    80002908:	00001637          	lui	a2,0x1
    8000290c:	00100593          	li	a1,1
    80002910:	00000097          	auipc	ra,0x0
    80002914:	478080e7          	jalr	1144(ra) # 80002d88 <__memset>
    80002918:	00002797          	auipc	a5,0x2
    8000291c:	92878793          	addi	a5,a5,-1752 # 80004240 <kmem>
    80002920:	0007b703          	ld	a4,0(a5)
    80002924:	01813083          	ld	ra,24(sp)
    80002928:	01013403          	ld	s0,16(sp)
    8000292c:	00e4b023          	sd	a4,0(s1)
    80002930:	0097b023          	sd	s1,0(a5)
    80002934:	00813483          	ld	s1,8(sp)
    80002938:	02010113          	addi	sp,sp,32
    8000293c:	00008067          	ret
    80002940:	00002517          	auipc	a0,0x2
    80002944:	83050513          	addi	a0,a0,-2000 # 80004170 <digits+0x18>
    80002948:	fffff097          	auipc	ra,0xfffff
    8000294c:	354080e7          	jalr	852(ra) # 80001c9c <panic>

0000000080002950 <kalloc>:
    80002950:	fe010113          	addi	sp,sp,-32
    80002954:	00813823          	sd	s0,16(sp)
    80002958:	00913423          	sd	s1,8(sp)
    8000295c:	00113c23          	sd	ra,24(sp)
    80002960:	02010413          	addi	s0,sp,32
    80002964:	00002797          	auipc	a5,0x2
    80002968:	8dc78793          	addi	a5,a5,-1828 # 80004240 <kmem>
    8000296c:	0007b483          	ld	s1,0(a5)
    80002970:	02048063          	beqz	s1,80002990 <kalloc+0x40>
    80002974:	0004b703          	ld	a4,0(s1)
    80002978:	00001637          	lui	a2,0x1
    8000297c:	00500593          	li	a1,5
    80002980:	00048513          	mv	a0,s1
    80002984:	00e7b023          	sd	a4,0(a5)
    80002988:	00000097          	auipc	ra,0x0
    8000298c:	400080e7          	jalr	1024(ra) # 80002d88 <__memset>
    80002990:	01813083          	ld	ra,24(sp)
    80002994:	01013403          	ld	s0,16(sp)
    80002998:	00048513          	mv	a0,s1
    8000299c:	00813483          	ld	s1,8(sp)
    800029a0:	02010113          	addi	sp,sp,32
    800029a4:	00008067          	ret

00000000800029a8 <initlock>:
    800029a8:	ff010113          	addi	sp,sp,-16
    800029ac:	00813423          	sd	s0,8(sp)
    800029b0:	01010413          	addi	s0,sp,16
    800029b4:	00813403          	ld	s0,8(sp)
    800029b8:	00b53423          	sd	a1,8(a0)
    800029bc:	00052023          	sw	zero,0(a0)
    800029c0:	00053823          	sd	zero,16(a0)
    800029c4:	01010113          	addi	sp,sp,16
    800029c8:	00008067          	ret

00000000800029cc <acquire>:
    800029cc:	fe010113          	addi	sp,sp,-32
    800029d0:	00813823          	sd	s0,16(sp)
    800029d4:	00913423          	sd	s1,8(sp)
    800029d8:	00113c23          	sd	ra,24(sp)
    800029dc:	01213023          	sd	s2,0(sp)
    800029e0:	02010413          	addi	s0,sp,32
    800029e4:	00050493          	mv	s1,a0
    800029e8:	10002973          	csrr	s2,sstatus
    800029ec:	100027f3          	csrr	a5,sstatus
    800029f0:	ffd7f793          	andi	a5,a5,-3
    800029f4:	10079073          	csrw	sstatus,a5
    800029f8:	fffff097          	auipc	ra,0xfffff
    800029fc:	8e8080e7          	jalr	-1816(ra) # 800012e0 <mycpu>
    80002a00:	07852783          	lw	a5,120(a0)
    80002a04:	06078e63          	beqz	a5,80002a80 <acquire+0xb4>
    80002a08:	fffff097          	auipc	ra,0xfffff
    80002a0c:	8d8080e7          	jalr	-1832(ra) # 800012e0 <mycpu>
    80002a10:	07852783          	lw	a5,120(a0)
    80002a14:	0004a703          	lw	a4,0(s1)
    80002a18:	0017879b          	addiw	a5,a5,1
    80002a1c:	06f52c23          	sw	a5,120(a0)
    80002a20:	04071063          	bnez	a4,80002a60 <acquire+0x94>
    80002a24:	00100713          	li	a4,1
    80002a28:	00070793          	mv	a5,a4
    80002a2c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002a30:	0007879b          	sext.w	a5,a5
    80002a34:	fe079ae3          	bnez	a5,80002a28 <acquire+0x5c>
    80002a38:	0ff0000f          	fence
    80002a3c:	fffff097          	auipc	ra,0xfffff
    80002a40:	8a4080e7          	jalr	-1884(ra) # 800012e0 <mycpu>
    80002a44:	01813083          	ld	ra,24(sp)
    80002a48:	01013403          	ld	s0,16(sp)
    80002a4c:	00a4b823          	sd	a0,16(s1)
    80002a50:	00013903          	ld	s2,0(sp)
    80002a54:	00813483          	ld	s1,8(sp)
    80002a58:	02010113          	addi	sp,sp,32
    80002a5c:	00008067          	ret
    80002a60:	0104b903          	ld	s2,16(s1)
    80002a64:	fffff097          	auipc	ra,0xfffff
    80002a68:	87c080e7          	jalr	-1924(ra) # 800012e0 <mycpu>
    80002a6c:	faa91ce3          	bne	s2,a0,80002a24 <acquire+0x58>
    80002a70:	00001517          	auipc	a0,0x1
    80002a74:	70850513          	addi	a0,a0,1800 # 80004178 <digits+0x20>
    80002a78:	fffff097          	auipc	ra,0xfffff
    80002a7c:	224080e7          	jalr	548(ra) # 80001c9c <panic>
    80002a80:	00195913          	srli	s2,s2,0x1
    80002a84:	fffff097          	auipc	ra,0xfffff
    80002a88:	85c080e7          	jalr	-1956(ra) # 800012e0 <mycpu>
    80002a8c:	00197913          	andi	s2,s2,1
    80002a90:	07252e23          	sw	s2,124(a0)
    80002a94:	f75ff06f          	j	80002a08 <acquire+0x3c>

0000000080002a98 <release>:
    80002a98:	fe010113          	addi	sp,sp,-32
    80002a9c:	00813823          	sd	s0,16(sp)
    80002aa0:	00113c23          	sd	ra,24(sp)
    80002aa4:	00913423          	sd	s1,8(sp)
    80002aa8:	01213023          	sd	s2,0(sp)
    80002aac:	02010413          	addi	s0,sp,32
    80002ab0:	00052783          	lw	a5,0(a0)
    80002ab4:	00079a63          	bnez	a5,80002ac8 <release+0x30>
    80002ab8:	00001517          	auipc	a0,0x1
    80002abc:	6c850513          	addi	a0,a0,1736 # 80004180 <digits+0x28>
    80002ac0:	fffff097          	auipc	ra,0xfffff
    80002ac4:	1dc080e7          	jalr	476(ra) # 80001c9c <panic>
    80002ac8:	01053903          	ld	s2,16(a0)
    80002acc:	00050493          	mv	s1,a0
    80002ad0:	fffff097          	auipc	ra,0xfffff
    80002ad4:	810080e7          	jalr	-2032(ra) # 800012e0 <mycpu>
    80002ad8:	fea910e3          	bne	s2,a0,80002ab8 <release+0x20>
    80002adc:	0004b823          	sd	zero,16(s1)
    80002ae0:	0ff0000f          	fence
    80002ae4:	0f50000f          	fence	iorw,ow
    80002ae8:	0804a02f          	amoswap.w	zero,zero,(s1)
    80002aec:	ffffe097          	auipc	ra,0xffffe
    80002af0:	7f4080e7          	jalr	2036(ra) # 800012e0 <mycpu>
    80002af4:	100027f3          	csrr	a5,sstatus
    80002af8:	0027f793          	andi	a5,a5,2
    80002afc:	04079a63          	bnez	a5,80002b50 <release+0xb8>
    80002b00:	07852783          	lw	a5,120(a0)
    80002b04:	02f05e63          	blez	a5,80002b40 <release+0xa8>
    80002b08:	fff7871b          	addiw	a4,a5,-1
    80002b0c:	06e52c23          	sw	a4,120(a0)
    80002b10:	00071c63          	bnez	a4,80002b28 <release+0x90>
    80002b14:	07c52783          	lw	a5,124(a0)
    80002b18:	00078863          	beqz	a5,80002b28 <release+0x90>
    80002b1c:	100027f3          	csrr	a5,sstatus
    80002b20:	0027e793          	ori	a5,a5,2
    80002b24:	10079073          	csrw	sstatus,a5
    80002b28:	01813083          	ld	ra,24(sp)
    80002b2c:	01013403          	ld	s0,16(sp)
    80002b30:	00813483          	ld	s1,8(sp)
    80002b34:	00013903          	ld	s2,0(sp)
    80002b38:	02010113          	addi	sp,sp,32
    80002b3c:	00008067          	ret
    80002b40:	00001517          	auipc	a0,0x1
    80002b44:	66050513          	addi	a0,a0,1632 # 800041a0 <digits+0x48>
    80002b48:	fffff097          	auipc	ra,0xfffff
    80002b4c:	154080e7          	jalr	340(ra) # 80001c9c <panic>
    80002b50:	00001517          	auipc	a0,0x1
    80002b54:	63850513          	addi	a0,a0,1592 # 80004188 <digits+0x30>
    80002b58:	fffff097          	auipc	ra,0xfffff
    80002b5c:	144080e7          	jalr	324(ra) # 80001c9c <panic>

0000000080002b60 <holding>:
    80002b60:	00052783          	lw	a5,0(a0)
    80002b64:	00079663          	bnez	a5,80002b70 <holding+0x10>
    80002b68:	00000513          	li	a0,0
    80002b6c:	00008067          	ret
    80002b70:	fe010113          	addi	sp,sp,-32
    80002b74:	00813823          	sd	s0,16(sp)
    80002b78:	00913423          	sd	s1,8(sp)
    80002b7c:	00113c23          	sd	ra,24(sp)
    80002b80:	02010413          	addi	s0,sp,32
    80002b84:	01053483          	ld	s1,16(a0)
    80002b88:	ffffe097          	auipc	ra,0xffffe
    80002b8c:	758080e7          	jalr	1880(ra) # 800012e0 <mycpu>
    80002b90:	01813083          	ld	ra,24(sp)
    80002b94:	01013403          	ld	s0,16(sp)
    80002b98:	40a48533          	sub	a0,s1,a0
    80002b9c:	00153513          	seqz	a0,a0
    80002ba0:	00813483          	ld	s1,8(sp)
    80002ba4:	02010113          	addi	sp,sp,32
    80002ba8:	00008067          	ret

0000000080002bac <push_off>:
    80002bac:	fe010113          	addi	sp,sp,-32
    80002bb0:	00813823          	sd	s0,16(sp)
    80002bb4:	00113c23          	sd	ra,24(sp)
    80002bb8:	00913423          	sd	s1,8(sp)
    80002bbc:	02010413          	addi	s0,sp,32
    80002bc0:	100024f3          	csrr	s1,sstatus
    80002bc4:	100027f3          	csrr	a5,sstatus
    80002bc8:	ffd7f793          	andi	a5,a5,-3
    80002bcc:	10079073          	csrw	sstatus,a5
    80002bd0:	ffffe097          	auipc	ra,0xffffe
    80002bd4:	710080e7          	jalr	1808(ra) # 800012e0 <mycpu>
    80002bd8:	07852783          	lw	a5,120(a0)
    80002bdc:	02078663          	beqz	a5,80002c08 <push_off+0x5c>
    80002be0:	ffffe097          	auipc	ra,0xffffe
    80002be4:	700080e7          	jalr	1792(ra) # 800012e0 <mycpu>
    80002be8:	07852783          	lw	a5,120(a0)
    80002bec:	01813083          	ld	ra,24(sp)
    80002bf0:	01013403          	ld	s0,16(sp)
    80002bf4:	0017879b          	addiw	a5,a5,1
    80002bf8:	06f52c23          	sw	a5,120(a0)
    80002bfc:	00813483          	ld	s1,8(sp)
    80002c00:	02010113          	addi	sp,sp,32
    80002c04:	00008067          	ret
    80002c08:	0014d493          	srli	s1,s1,0x1
    80002c0c:	ffffe097          	auipc	ra,0xffffe
    80002c10:	6d4080e7          	jalr	1748(ra) # 800012e0 <mycpu>
    80002c14:	0014f493          	andi	s1,s1,1
    80002c18:	06952e23          	sw	s1,124(a0)
    80002c1c:	fc5ff06f          	j	80002be0 <push_off+0x34>

0000000080002c20 <pop_off>:
    80002c20:	ff010113          	addi	sp,sp,-16
    80002c24:	00813023          	sd	s0,0(sp)
    80002c28:	00113423          	sd	ra,8(sp)
    80002c2c:	01010413          	addi	s0,sp,16
    80002c30:	ffffe097          	auipc	ra,0xffffe
    80002c34:	6b0080e7          	jalr	1712(ra) # 800012e0 <mycpu>
    80002c38:	100027f3          	csrr	a5,sstatus
    80002c3c:	0027f793          	andi	a5,a5,2
    80002c40:	04079663          	bnez	a5,80002c8c <pop_off+0x6c>
    80002c44:	07852783          	lw	a5,120(a0)
    80002c48:	02f05a63          	blez	a5,80002c7c <pop_off+0x5c>
    80002c4c:	fff7871b          	addiw	a4,a5,-1
    80002c50:	06e52c23          	sw	a4,120(a0)
    80002c54:	00071c63          	bnez	a4,80002c6c <pop_off+0x4c>
    80002c58:	07c52783          	lw	a5,124(a0)
    80002c5c:	00078863          	beqz	a5,80002c6c <pop_off+0x4c>
    80002c60:	100027f3          	csrr	a5,sstatus
    80002c64:	0027e793          	ori	a5,a5,2
    80002c68:	10079073          	csrw	sstatus,a5
    80002c6c:	00813083          	ld	ra,8(sp)
    80002c70:	00013403          	ld	s0,0(sp)
    80002c74:	01010113          	addi	sp,sp,16
    80002c78:	00008067          	ret
    80002c7c:	00001517          	auipc	a0,0x1
    80002c80:	52450513          	addi	a0,a0,1316 # 800041a0 <digits+0x48>
    80002c84:	fffff097          	auipc	ra,0xfffff
    80002c88:	018080e7          	jalr	24(ra) # 80001c9c <panic>
    80002c8c:	00001517          	auipc	a0,0x1
    80002c90:	4fc50513          	addi	a0,a0,1276 # 80004188 <digits+0x30>
    80002c94:	fffff097          	auipc	ra,0xfffff
    80002c98:	008080e7          	jalr	8(ra) # 80001c9c <panic>

0000000080002c9c <push_on>:
    80002c9c:	fe010113          	addi	sp,sp,-32
    80002ca0:	00813823          	sd	s0,16(sp)
    80002ca4:	00113c23          	sd	ra,24(sp)
    80002ca8:	00913423          	sd	s1,8(sp)
    80002cac:	02010413          	addi	s0,sp,32
    80002cb0:	100024f3          	csrr	s1,sstatus
    80002cb4:	100027f3          	csrr	a5,sstatus
    80002cb8:	0027e793          	ori	a5,a5,2
    80002cbc:	10079073          	csrw	sstatus,a5
    80002cc0:	ffffe097          	auipc	ra,0xffffe
    80002cc4:	620080e7          	jalr	1568(ra) # 800012e0 <mycpu>
    80002cc8:	07852783          	lw	a5,120(a0)
    80002ccc:	02078663          	beqz	a5,80002cf8 <push_on+0x5c>
    80002cd0:	ffffe097          	auipc	ra,0xffffe
    80002cd4:	610080e7          	jalr	1552(ra) # 800012e0 <mycpu>
    80002cd8:	07852783          	lw	a5,120(a0)
    80002cdc:	01813083          	ld	ra,24(sp)
    80002ce0:	01013403          	ld	s0,16(sp)
    80002ce4:	0017879b          	addiw	a5,a5,1
    80002ce8:	06f52c23          	sw	a5,120(a0)
    80002cec:	00813483          	ld	s1,8(sp)
    80002cf0:	02010113          	addi	sp,sp,32
    80002cf4:	00008067          	ret
    80002cf8:	0014d493          	srli	s1,s1,0x1
    80002cfc:	ffffe097          	auipc	ra,0xffffe
    80002d00:	5e4080e7          	jalr	1508(ra) # 800012e0 <mycpu>
    80002d04:	0014f493          	andi	s1,s1,1
    80002d08:	06952e23          	sw	s1,124(a0)
    80002d0c:	fc5ff06f          	j	80002cd0 <push_on+0x34>

0000000080002d10 <pop_on>:
    80002d10:	ff010113          	addi	sp,sp,-16
    80002d14:	00813023          	sd	s0,0(sp)
    80002d18:	00113423          	sd	ra,8(sp)
    80002d1c:	01010413          	addi	s0,sp,16
    80002d20:	ffffe097          	auipc	ra,0xffffe
    80002d24:	5c0080e7          	jalr	1472(ra) # 800012e0 <mycpu>
    80002d28:	100027f3          	csrr	a5,sstatus
    80002d2c:	0027f793          	andi	a5,a5,2
    80002d30:	04078463          	beqz	a5,80002d78 <pop_on+0x68>
    80002d34:	07852783          	lw	a5,120(a0)
    80002d38:	02f05863          	blez	a5,80002d68 <pop_on+0x58>
    80002d3c:	fff7879b          	addiw	a5,a5,-1
    80002d40:	06f52c23          	sw	a5,120(a0)
    80002d44:	07853783          	ld	a5,120(a0)
    80002d48:	00079863          	bnez	a5,80002d58 <pop_on+0x48>
    80002d4c:	100027f3          	csrr	a5,sstatus
    80002d50:	ffd7f793          	andi	a5,a5,-3
    80002d54:	10079073          	csrw	sstatus,a5
    80002d58:	00813083          	ld	ra,8(sp)
    80002d5c:	00013403          	ld	s0,0(sp)
    80002d60:	01010113          	addi	sp,sp,16
    80002d64:	00008067          	ret
    80002d68:	00001517          	auipc	a0,0x1
    80002d6c:	46050513          	addi	a0,a0,1120 # 800041c8 <digits+0x70>
    80002d70:	fffff097          	auipc	ra,0xfffff
    80002d74:	f2c080e7          	jalr	-212(ra) # 80001c9c <panic>
    80002d78:	00001517          	auipc	a0,0x1
    80002d7c:	43050513          	addi	a0,a0,1072 # 800041a8 <digits+0x50>
    80002d80:	fffff097          	auipc	ra,0xfffff
    80002d84:	f1c080e7          	jalr	-228(ra) # 80001c9c <panic>

0000000080002d88 <__memset>:
    80002d88:	ff010113          	addi	sp,sp,-16
    80002d8c:	00813423          	sd	s0,8(sp)
    80002d90:	01010413          	addi	s0,sp,16
    80002d94:	1a060e63          	beqz	a2,80002f50 <__memset+0x1c8>
    80002d98:	40a007b3          	neg	a5,a0
    80002d9c:	0077f793          	andi	a5,a5,7
    80002da0:	00778693          	addi	a3,a5,7
    80002da4:	00b00813          	li	a6,11
    80002da8:	0ff5f593          	andi	a1,a1,255
    80002dac:	fff6071b          	addiw	a4,a2,-1
    80002db0:	1b06e663          	bltu	a3,a6,80002f5c <__memset+0x1d4>
    80002db4:	1cd76463          	bltu	a4,a3,80002f7c <__memset+0x1f4>
    80002db8:	1a078e63          	beqz	a5,80002f74 <__memset+0x1ec>
    80002dbc:	00b50023          	sb	a1,0(a0)
    80002dc0:	00100713          	li	a4,1
    80002dc4:	1ae78463          	beq	a5,a4,80002f6c <__memset+0x1e4>
    80002dc8:	00b500a3          	sb	a1,1(a0)
    80002dcc:	00200713          	li	a4,2
    80002dd0:	1ae78a63          	beq	a5,a4,80002f84 <__memset+0x1fc>
    80002dd4:	00b50123          	sb	a1,2(a0)
    80002dd8:	00300713          	li	a4,3
    80002ddc:	18e78463          	beq	a5,a4,80002f64 <__memset+0x1dc>
    80002de0:	00b501a3          	sb	a1,3(a0)
    80002de4:	00400713          	li	a4,4
    80002de8:	1ae78263          	beq	a5,a4,80002f8c <__memset+0x204>
    80002dec:	00b50223          	sb	a1,4(a0)
    80002df0:	00500713          	li	a4,5
    80002df4:	1ae78063          	beq	a5,a4,80002f94 <__memset+0x20c>
    80002df8:	00b502a3          	sb	a1,5(a0)
    80002dfc:	00700713          	li	a4,7
    80002e00:	18e79e63          	bne	a5,a4,80002f9c <__memset+0x214>
    80002e04:	00b50323          	sb	a1,6(a0)
    80002e08:	00700e93          	li	t4,7
    80002e0c:	00859713          	slli	a4,a1,0x8
    80002e10:	00e5e733          	or	a4,a1,a4
    80002e14:	01059e13          	slli	t3,a1,0x10
    80002e18:	01c76e33          	or	t3,a4,t3
    80002e1c:	01859313          	slli	t1,a1,0x18
    80002e20:	006e6333          	or	t1,t3,t1
    80002e24:	02059893          	slli	a7,a1,0x20
    80002e28:	40f60e3b          	subw	t3,a2,a5
    80002e2c:	011368b3          	or	a7,t1,a7
    80002e30:	02859813          	slli	a6,a1,0x28
    80002e34:	0108e833          	or	a6,a7,a6
    80002e38:	03059693          	slli	a3,a1,0x30
    80002e3c:	003e589b          	srliw	a7,t3,0x3
    80002e40:	00d866b3          	or	a3,a6,a3
    80002e44:	03859713          	slli	a4,a1,0x38
    80002e48:	00389813          	slli	a6,a7,0x3
    80002e4c:	00f507b3          	add	a5,a0,a5
    80002e50:	00e6e733          	or	a4,a3,a4
    80002e54:	000e089b          	sext.w	a7,t3
    80002e58:	00f806b3          	add	a3,a6,a5
    80002e5c:	00e7b023          	sd	a4,0(a5)
    80002e60:	00878793          	addi	a5,a5,8
    80002e64:	fed79ce3          	bne	a5,a3,80002e5c <__memset+0xd4>
    80002e68:	ff8e7793          	andi	a5,t3,-8
    80002e6c:	0007871b          	sext.w	a4,a5
    80002e70:	01d787bb          	addw	a5,a5,t4
    80002e74:	0ce88e63          	beq	a7,a4,80002f50 <__memset+0x1c8>
    80002e78:	00f50733          	add	a4,a0,a5
    80002e7c:	00b70023          	sb	a1,0(a4)
    80002e80:	0017871b          	addiw	a4,a5,1
    80002e84:	0cc77663          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002e88:	00e50733          	add	a4,a0,a4
    80002e8c:	00b70023          	sb	a1,0(a4)
    80002e90:	0027871b          	addiw	a4,a5,2
    80002e94:	0ac77e63          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002e98:	00e50733          	add	a4,a0,a4
    80002e9c:	00b70023          	sb	a1,0(a4)
    80002ea0:	0037871b          	addiw	a4,a5,3
    80002ea4:	0ac77663          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002ea8:	00e50733          	add	a4,a0,a4
    80002eac:	00b70023          	sb	a1,0(a4)
    80002eb0:	0047871b          	addiw	a4,a5,4
    80002eb4:	08c77e63          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002eb8:	00e50733          	add	a4,a0,a4
    80002ebc:	00b70023          	sb	a1,0(a4)
    80002ec0:	0057871b          	addiw	a4,a5,5
    80002ec4:	08c77663          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002ec8:	00e50733          	add	a4,a0,a4
    80002ecc:	00b70023          	sb	a1,0(a4)
    80002ed0:	0067871b          	addiw	a4,a5,6
    80002ed4:	06c77e63          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002ed8:	00e50733          	add	a4,a0,a4
    80002edc:	00b70023          	sb	a1,0(a4)
    80002ee0:	0077871b          	addiw	a4,a5,7
    80002ee4:	06c77663          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002ee8:	00e50733          	add	a4,a0,a4
    80002eec:	00b70023          	sb	a1,0(a4)
    80002ef0:	0087871b          	addiw	a4,a5,8
    80002ef4:	04c77e63          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002ef8:	00e50733          	add	a4,a0,a4
    80002efc:	00b70023          	sb	a1,0(a4)
    80002f00:	0097871b          	addiw	a4,a5,9
    80002f04:	04c77663          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002f08:	00e50733          	add	a4,a0,a4
    80002f0c:	00b70023          	sb	a1,0(a4)
    80002f10:	00a7871b          	addiw	a4,a5,10
    80002f14:	02c77e63          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002f18:	00e50733          	add	a4,a0,a4
    80002f1c:	00b70023          	sb	a1,0(a4)
    80002f20:	00b7871b          	addiw	a4,a5,11
    80002f24:	02c77663          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002f28:	00e50733          	add	a4,a0,a4
    80002f2c:	00b70023          	sb	a1,0(a4)
    80002f30:	00c7871b          	addiw	a4,a5,12
    80002f34:	00c77e63          	bgeu	a4,a2,80002f50 <__memset+0x1c8>
    80002f38:	00e50733          	add	a4,a0,a4
    80002f3c:	00b70023          	sb	a1,0(a4)
    80002f40:	00d7879b          	addiw	a5,a5,13
    80002f44:	00c7f663          	bgeu	a5,a2,80002f50 <__memset+0x1c8>
    80002f48:	00f507b3          	add	a5,a0,a5
    80002f4c:	00b78023          	sb	a1,0(a5)
    80002f50:	00813403          	ld	s0,8(sp)
    80002f54:	01010113          	addi	sp,sp,16
    80002f58:	00008067          	ret
    80002f5c:	00b00693          	li	a3,11
    80002f60:	e55ff06f          	j	80002db4 <__memset+0x2c>
    80002f64:	00300e93          	li	t4,3
    80002f68:	ea5ff06f          	j	80002e0c <__memset+0x84>
    80002f6c:	00100e93          	li	t4,1
    80002f70:	e9dff06f          	j	80002e0c <__memset+0x84>
    80002f74:	00000e93          	li	t4,0
    80002f78:	e95ff06f          	j	80002e0c <__memset+0x84>
    80002f7c:	00000793          	li	a5,0
    80002f80:	ef9ff06f          	j	80002e78 <__memset+0xf0>
    80002f84:	00200e93          	li	t4,2
    80002f88:	e85ff06f          	j	80002e0c <__memset+0x84>
    80002f8c:	00400e93          	li	t4,4
    80002f90:	e7dff06f          	j	80002e0c <__memset+0x84>
    80002f94:	00500e93          	li	t4,5
    80002f98:	e75ff06f          	j	80002e0c <__memset+0x84>
    80002f9c:	00600e93          	li	t4,6
    80002fa0:	e6dff06f          	j	80002e0c <__memset+0x84>

0000000080002fa4 <__memmove>:
    80002fa4:	ff010113          	addi	sp,sp,-16
    80002fa8:	00813423          	sd	s0,8(sp)
    80002fac:	01010413          	addi	s0,sp,16
    80002fb0:	0e060863          	beqz	a2,800030a0 <__memmove+0xfc>
    80002fb4:	fff6069b          	addiw	a3,a2,-1
    80002fb8:	0006881b          	sext.w	a6,a3
    80002fbc:	0ea5e863          	bltu	a1,a0,800030ac <__memmove+0x108>
    80002fc0:	00758713          	addi	a4,a1,7
    80002fc4:	00a5e7b3          	or	a5,a1,a0
    80002fc8:	40a70733          	sub	a4,a4,a0
    80002fcc:	0077f793          	andi	a5,a5,7
    80002fd0:	00f73713          	sltiu	a4,a4,15
    80002fd4:	00174713          	xori	a4,a4,1
    80002fd8:	0017b793          	seqz	a5,a5
    80002fdc:	00e7f7b3          	and	a5,a5,a4
    80002fe0:	10078863          	beqz	a5,800030f0 <__memmove+0x14c>
    80002fe4:	00900793          	li	a5,9
    80002fe8:	1107f463          	bgeu	a5,a6,800030f0 <__memmove+0x14c>
    80002fec:	0036581b          	srliw	a6,a2,0x3
    80002ff0:	fff8081b          	addiw	a6,a6,-1
    80002ff4:	02081813          	slli	a6,a6,0x20
    80002ff8:	01d85893          	srli	a7,a6,0x1d
    80002ffc:	00858813          	addi	a6,a1,8
    80003000:	00058793          	mv	a5,a1
    80003004:	00050713          	mv	a4,a0
    80003008:	01088833          	add	a6,a7,a6
    8000300c:	0007b883          	ld	a7,0(a5)
    80003010:	00878793          	addi	a5,a5,8
    80003014:	00870713          	addi	a4,a4,8
    80003018:	ff173c23          	sd	a7,-8(a4)
    8000301c:	ff0798e3          	bne	a5,a6,8000300c <__memmove+0x68>
    80003020:	ff867713          	andi	a4,a2,-8
    80003024:	02071793          	slli	a5,a4,0x20
    80003028:	0207d793          	srli	a5,a5,0x20
    8000302c:	00f585b3          	add	a1,a1,a5
    80003030:	40e686bb          	subw	a3,a3,a4
    80003034:	00f507b3          	add	a5,a0,a5
    80003038:	06e60463          	beq	a2,a4,800030a0 <__memmove+0xfc>
    8000303c:	0005c703          	lbu	a4,0(a1)
    80003040:	00e78023          	sb	a4,0(a5)
    80003044:	04068e63          	beqz	a3,800030a0 <__memmove+0xfc>
    80003048:	0015c603          	lbu	a2,1(a1)
    8000304c:	00100713          	li	a4,1
    80003050:	00c780a3          	sb	a2,1(a5)
    80003054:	04e68663          	beq	a3,a4,800030a0 <__memmove+0xfc>
    80003058:	0025c603          	lbu	a2,2(a1)
    8000305c:	00200713          	li	a4,2
    80003060:	00c78123          	sb	a2,2(a5)
    80003064:	02e68e63          	beq	a3,a4,800030a0 <__memmove+0xfc>
    80003068:	0035c603          	lbu	a2,3(a1)
    8000306c:	00300713          	li	a4,3
    80003070:	00c781a3          	sb	a2,3(a5)
    80003074:	02e68663          	beq	a3,a4,800030a0 <__memmove+0xfc>
    80003078:	0045c603          	lbu	a2,4(a1)
    8000307c:	00400713          	li	a4,4
    80003080:	00c78223          	sb	a2,4(a5)
    80003084:	00e68e63          	beq	a3,a4,800030a0 <__memmove+0xfc>
    80003088:	0055c603          	lbu	a2,5(a1)
    8000308c:	00500713          	li	a4,5
    80003090:	00c782a3          	sb	a2,5(a5)
    80003094:	00e68663          	beq	a3,a4,800030a0 <__memmove+0xfc>
    80003098:	0065c703          	lbu	a4,6(a1)
    8000309c:	00e78323          	sb	a4,6(a5)
    800030a0:	00813403          	ld	s0,8(sp)
    800030a4:	01010113          	addi	sp,sp,16
    800030a8:	00008067          	ret
    800030ac:	02061713          	slli	a4,a2,0x20
    800030b0:	02075713          	srli	a4,a4,0x20
    800030b4:	00e587b3          	add	a5,a1,a4
    800030b8:	f0f574e3          	bgeu	a0,a5,80002fc0 <__memmove+0x1c>
    800030bc:	02069613          	slli	a2,a3,0x20
    800030c0:	02065613          	srli	a2,a2,0x20
    800030c4:	fff64613          	not	a2,a2
    800030c8:	00e50733          	add	a4,a0,a4
    800030cc:	00c78633          	add	a2,a5,a2
    800030d0:	fff7c683          	lbu	a3,-1(a5)
    800030d4:	fff78793          	addi	a5,a5,-1
    800030d8:	fff70713          	addi	a4,a4,-1
    800030dc:	00d70023          	sb	a3,0(a4)
    800030e0:	fec798e3          	bne	a5,a2,800030d0 <__memmove+0x12c>
    800030e4:	00813403          	ld	s0,8(sp)
    800030e8:	01010113          	addi	sp,sp,16
    800030ec:	00008067          	ret
    800030f0:	02069713          	slli	a4,a3,0x20
    800030f4:	02075713          	srli	a4,a4,0x20
    800030f8:	00170713          	addi	a4,a4,1
    800030fc:	00e50733          	add	a4,a0,a4
    80003100:	00050793          	mv	a5,a0
    80003104:	0005c683          	lbu	a3,0(a1)
    80003108:	00178793          	addi	a5,a5,1
    8000310c:	00158593          	addi	a1,a1,1
    80003110:	fed78fa3          	sb	a3,-1(a5)
    80003114:	fee798e3          	bne	a5,a4,80003104 <__memmove+0x160>
    80003118:	f89ff06f          	j	800030a0 <__memmove+0xfc>

000000008000311c <__putc>:
    8000311c:	fe010113          	addi	sp,sp,-32
    80003120:	00813823          	sd	s0,16(sp)
    80003124:	00113c23          	sd	ra,24(sp)
    80003128:	02010413          	addi	s0,sp,32
    8000312c:	00050793          	mv	a5,a0
    80003130:	fef40593          	addi	a1,s0,-17
    80003134:	00100613          	li	a2,1
    80003138:	00000513          	li	a0,0
    8000313c:	fef407a3          	sb	a5,-17(s0)
    80003140:	fffff097          	auipc	ra,0xfffff
    80003144:	b3c080e7          	jalr	-1220(ra) # 80001c7c <console_write>
    80003148:	01813083          	ld	ra,24(sp)
    8000314c:	01013403          	ld	s0,16(sp)
    80003150:	02010113          	addi	sp,sp,32
    80003154:	00008067          	ret

0000000080003158 <__getc>:
    80003158:	fe010113          	addi	sp,sp,-32
    8000315c:	00813823          	sd	s0,16(sp)
    80003160:	00113c23          	sd	ra,24(sp)
    80003164:	02010413          	addi	s0,sp,32
    80003168:	fe840593          	addi	a1,s0,-24
    8000316c:	00100613          	li	a2,1
    80003170:	00000513          	li	a0,0
    80003174:	fffff097          	auipc	ra,0xfffff
    80003178:	ae8080e7          	jalr	-1304(ra) # 80001c5c <console_read>
    8000317c:	fe844503          	lbu	a0,-24(s0)
    80003180:	01813083          	ld	ra,24(sp)
    80003184:	01013403          	ld	s0,16(sp)
    80003188:	02010113          	addi	sp,sp,32
    8000318c:	00008067          	ret

0000000080003190 <console_handler>:
    80003190:	fe010113          	addi	sp,sp,-32
    80003194:	00813823          	sd	s0,16(sp)
    80003198:	00113c23          	sd	ra,24(sp)
    8000319c:	00913423          	sd	s1,8(sp)
    800031a0:	02010413          	addi	s0,sp,32
    800031a4:	14202773          	csrr	a4,scause
    800031a8:	100027f3          	csrr	a5,sstatus
    800031ac:	0027f793          	andi	a5,a5,2
    800031b0:	06079e63          	bnez	a5,8000322c <console_handler+0x9c>
    800031b4:	00074c63          	bltz	a4,800031cc <console_handler+0x3c>
    800031b8:	01813083          	ld	ra,24(sp)
    800031bc:	01013403          	ld	s0,16(sp)
    800031c0:	00813483          	ld	s1,8(sp)
    800031c4:	02010113          	addi	sp,sp,32
    800031c8:	00008067          	ret
    800031cc:	0ff77713          	andi	a4,a4,255
    800031d0:	00900793          	li	a5,9
    800031d4:	fef712e3          	bne	a4,a5,800031b8 <console_handler+0x28>
    800031d8:	ffffe097          	auipc	ra,0xffffe
    800031dc:	6dc080e7          	jalr	1756(ra) # 800018b4 <plic_claim>
    800031e0:	00a00793          	li	a5,10
    800031e4:	00050493          	mv	s1,a0
    800031e8:	02f50c63          	beq	a0,a5,80003220 <console_handler+0x90>
    800031ec:	fc0506e3          	beqz	a0,800031b8 <console_handler+0x28>
    800031f0:	00050593          	mv	a1,a0
    800031f4:	00001517          	auipc	a0,0x1
    800031f8:	edc50513          	addi	a0,a0,-292 # 800040d0 <console_handler+0xf40>
    800031fc:	fffff097          	auipc	ra,0xfffff
    80003200:	afc080e7          	jalr	-1284(ra) # 80001cf8 <__printf>
    80003204:	01013403          	ld	s0,16(sp)
    80003208:	01813083          	ld	ra,24(sp)
    8000320c:	00048513          	mv	a0,s1
    80003210:	00813483          	ld	s1,8(sp)
    80003214:	02010113          	addi	sp,sp,32
    80003218:	ffffe317          	auipc	t1,0xffffe
    8000321c:	6d430067          	jr	1748(t1) # 800018ec <plic_complete>
    80003220:	fffff097          	auipc	ra,0xfffff
    80003224:	3e0080e7          	jalr	992(ra) # 80002600 <uartintr>
    80003228:	fddff06f          	j	80003204 <console_handler+0x74>
    8000322c:	00001517          	auipc	a0,0x1
    80003230:	fa450513          	addi	a0,a0,-92 # 800041d0 <digits+0x78>
    80003234:	fffff097          	auipc	ra,0xfffff
    80003238:	a68080e7          	jalr	-1432(ra) # 80001c9c <panic>
	...
