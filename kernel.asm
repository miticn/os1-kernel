
kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00004117          	auipc	sp,0x4
    80000004:	23813103          	ld	sp,568(sp) # 80004238 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	00001537          	lui	a0,0x1
    8000000c:	f14025f3          	csrr	a1,mhartid
    80000010:	00158593          	addi	a1,a1,1
    80000014:	02b50533          	mul	a0,a0,a1
    80000018:	00a10133          	add	sp,sp,a0
    8000001c:	098010ef          	jal	ra,800010b4 <start>

0000000080000020 <spin>:
    80000020:	0000006f          	j	80000020 <spin>
	...

0000000080001000 <main>:
#include "../lib/console.h"
#include "../lib/mem.h"
#include "../lib/hw.h"

void main(){
    80001000:	ff010113          	addi	sp,sp,-16
    80001004:	00113423          	sd	ra,8(sp)
    80001008:	00813023          	sd	s0,0(sp)
    8000100c:	01010413          	addi	s0,sp,16
    __mem_alloc(4);
    80001010:	00400513          	li	a0,4
    80001014:	00000097          	auipc	ra,0x0
    80001018:	03c080e7          	jalr	60(ra) # 80001050 <__mem_alloc>
    if(HEAP_START_ADDR > HEAP_END_ADDR) __putc('k');
    8000101c:	00003717          	auipc	a4,0x3
    80001020:	20c73703          	ld	a4,524(a4) # 80004228 <HEAP_START_ADDR>
    80001024:	00003797          	auipc	a5,0x3
    80001028:	1fc7b783          	ld	a5,508(a5) # 80004220 <HEAP_END_ADDR>
    8000102c:	00e7ea63          	bltu	a5,a4,80001040 <main+0x40>
    80001030:	00813083          	ld	ra,8(sp)
    80001034:	00013403          	ld	s0,0(sp)
    80001038:	01010113          	addi	sp,sp,16
    8000103c:	00008067          	ret
    if(HEAP_START_ADDR > HEAP_END_ADDR) __putc('k');
    80001040:	06b00513          	li	a0,107
    80001044:	00002097          	auipc	ra,0x2
    80001048:	138080e7          	jalr	312(ra) # 8000317c <__putc>
    8000104c:	fe5ff06f          	j	80001030 <main+0x30>

0000000080001050 <__mem_alloc>:
#include "mem.h"
#include "hw.h"

static _frmem first = {0, 0};

void* __mem_alloc(size_t size){
    80001050:	ff010113          	addi	sp,sp,-16
    80001054:	00813423          	sd	s0,8(sp)
    80001058:	01010413          	addi	s0,sp,16
    if(first.next == 0) first.current_size = HEAP_END_ADDR - HEAP_START_ADDR;
    8000105c:	00003797          	auipc	a5,0x3
    80001060:	2247b783          	ld	a5,548(a5) # 80004280 <first>
    80001064:	00078a63          	beqz	a5,80001078 <__mem_alloc+0x28>
    size_to_alloc = size_to_alloc;

    //if (first.)

    return 0;
}
    80001068:	00000513          	li	a0,0
    8000106c:	00813403          	ld	s0,8(sp)
    80001070:	01010113          	addi	sp,sp,16
    80001074:	00008067          	ret
    if(first.next == 0) first.current_size = HEAP_END_ADDR - HEAP_START_ADDR;
    80001078:	00003797          	auipc	a5,0x3
    8000107c:	1a87b783          	ld	a5,424(a5) # 80004220 <HEAP_END_ADDR>
    80001080:	00003717          	auipc	a4,0x3
    80001084:	1a873703          	ld	a4,424(a4) # 80004228 <HEAP_START_ADDR>
    80001088:	40e787b3          	sub	a5,a5,a4
    8000108c:	00003717          	auipc	a4,0x3
    80001090:	1ef73e23          	sd	a5,508(a4) # 80004288 <first+0x8>
    80001094:	fd5ff06f          	j	80001068 <__mem_alloc+0x18>

0000000080001098 <__mem_free>:

int __mem_free(void* ptr){
    80001098:	ff010113          	addi	sp,sp,-16
    8000109c:	00813423          	sd	s0,8(sp)
    800010a0:	01010413          	addi	s0,sp,16
    return 0;
}
    800010a4:	00000513          	li	a0,0
    800010a8:	00813403          	ld	s0,8(sp)
    800010ac:	01010113          	addi	sp,sp,16
    800010b0:	00008067          	ret

00000000800010b4 <start>:
    800010b4:	ff010113          	addi	sp,sp,-16
    800010b8:	00813423          	sd	s0,8(sp)
    800010bc:	01010413          	addi	s0,sp,16
    800010c0:	300027f3          	csrr	a5,mstatus
    800010c4:	ffffe737          	lui	a4,0xffffe
    800010c8:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7fff931f>
    800010cc:	00e7f7b3          	and	a5,a5,a4
    800010d0:	00001737          	lui	a4,0x1
    800010d4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800010d8:	00e7e7b3          	or	a5,a5,a4
    800010dc:	30079073          	csrw	mstatus,a5
    800010e0:	00000797          	auipc	a5,0x0
    800010e4:	16078793          	addi	a5,a5,352 # 80001240 <system_main>
    800010e8:	34179073          	csrw	mepc,a5
    800010ec:	00000793          	li	a5,0
    800010f0:	18079073          	csrw	satp,a5
    800010f4:	000107b7          	lui	a5,0x10
    800010f8:	fff78793          	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800010fc:	30279073          	csrw	medeleg,a5
    80001100:	30379073          	csrw	mideleg,a5
    80001104:	104027f3          	csrr	a5,sie
    80001108:	2227e793          	ori	a5,a5,546
    8000110c:	10479073          	csrw	sie,a5
    80001110:	fff00793          	li	a5,-1
    80001114:	00a7d793          	srli	a5,a5,0xa
    80001118:	3b079073          	csrw	pmpaddr0,a5
    8000111c:	00f00793          	li	a5,15
    80001120:	3a079073          	csrw	pmpcfg0,a5
    80001124:	f14027f3          	csrr	a5,mhartid
    80001128:	0200c737          	lui	a4,0x200c
    8000112c:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80001130:	0007869b          	sext.w	a3,a5
    80001134:	00269713          	slli	a4,a3,0x2
    80001138:	000f4637          	lui	a2,0xf4
    8000113c:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80001140:	00d70733          	add	a4,a4,a3
    80001144:	0037979b          	slliw	a5,a5,0x3
    80001148:	020046b7          	lui	a3,0x2004
    8000114c:	00d787b3          	add	a5,a5,a3
    80001150:	00c585b3          	add	a1,a1,a2
    80001154:	00371693          	slli	a3,a4,0x3
    80001158:	00003717          	auipc	a4,0x3
    8000115c:	13870713          	addi	a4,a4,312 # 80004290 <timer_scratch>
    80001160:	00b7b023          	sd	a1,0(a5)
    80001164:	00d70733          	add	a4,a4,a3
    80001168:	00f73c23          	sd	a5,24(a4)
    8000116c:	02c73023          	sd	a2,32(a4)
    80001170:	34071073          	csrw	mscratch,a4
    80001174:	00000797          	auipc	a5,0x0
    80001178:	6ec78793          	addi	a5,a5,1772 # 80001860 <timervec>
    8000117c:	30579073          	csrw	mtvec,a5
    80001180:	300027f3          	csrr	a5,mstatus
    80001184:	0087e793          	ori	a5,a5,8
    80001188:	30079073          	csrw	mstatus,a5
    8000118c:	304027f3          	csrr	a5,mie
    80001190:	0807e793          	ori	a5,a5,128
    80001194:	30479073          	csrw	mie,a5
    80001198:	f14027f3          	csrr	a5,mhartid
    8000119c:	0007879b          	sext.w	a5,a5
    800011a0:	00078213          	mv	tp,a5
    800011a4:	30200073          	mret
    800011a8:	00813403          	ld	s0,8(sp)
    800011ac:	01010113          	addi	sp,sp,16
    800011b0:	00008067          	ret

00000000800011b4 <timerinit>:
    800011b4:	ff010113          	addi	sp,sp,-16
    800011b8:	00813423          	sd	s0,8(sp)
    800011bc:	01010413          	addi	s0,sp,16
    800011c0:	f14027f3          	csrr	a5,mhartid
    800011c4:	0200c737          	lui	a4,0x200c
    800011c8:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800011cc:	0007869b          	sext.w	a3,a5
    800011d0:	00269713          	slli	a4,a3,0x2
    800011d4:	000f4637          	lui	a2,0xf4
    800011d8:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800011dc:	00d70733          	add	a4,a4,a3
    800011e0:	0037979b          	slliw	a5,a5,0x3
    800011e4:	020046b7          	lui	a3,0x2004
    800011e8:	00d787b3          	add	a5,a5,a3
    800011ec:	00c585b3          	add	a1,a1,a2
    800011f0:	00371693          	slli	a3,a4,0x3
    800011f4:	00003717          	auipc	a4,0x3
    800011f8:	09c70713          	addi	a4,a4,156 # 80004290 <timer_scratch>
    800011fc:	00b7b023          	sd	a1,0(a5)
    80001200:	00d70733          	add	a4,a4,a3
    80001204:	00f73c23          	sd	a5,24(a4)
    80001208:	02c73023          	sd	a2,32(a4)
    8000120c:	34071073          	csrw	mscratch,a4
    80001210:	00000797          	auipc	a5,0x0
    80001214:	65078793          	addi	a5,a5,1616 # 80001860 <timervec>
    80001218:	30579073          	csrw	mtvec,a5
    8000121c:	300027f3          	csrr	a5,mstatus
    80001220:	0087e793          	ori	a5,a5,8
    80001224:	30079073          	csrw	mstatus,a5
    80001228:	304027f3          	csrr	a5,mie
    8000122c:	0807e793          	ori	a5,a5,128
    80001230:	30479073          	csrw	mie,a5
    80001234:	00813403          	ld	s0,8(sp)
    80001238:	01010113          	addi	sp,sp,16
    8000123c:	00008067          	ret

0000000080001240 <system_main>:
    80001240:	fe010113          	addi	sp,sp,-32
    80001244:	00813823          	sd	s0,16(sp)
    80001248:	00913423          	sd	s1,8(sp)
    8000124c:	00113c23          	sd	ra,24(sp)
    80001250:	02010413          	addi	s0,sp,32
    80001254:	00000097          	auipc	ra,0x0
    80001258:	0c4080e7          	jalr	196(ra) # 80001318 <cpuid>
    8000125c:	00003497          	auipc	s1,0x3
    80001260:	ff448493          	addi	s1,s1,-12 # 80004250 <started>
    80001264:	02050263          	beqz	a0,80001288 <system_main+0x48>
    80001268:	0004a783          	lw	a5,0(s1)
    8000126c:	0007879b          	sext.w	a5,a5
    80001270:	fe078ce3          	beqz	a5,80001268 <system_main+0x28>
    80001274:	0ff0000f          	fence
    80001278:	00003517          	auipc	a0,0x3
    8000127c:	dd850513          	addi	a0,a0,-552 # 80004050 <CONSOLE_STATUS+0x40>
    80001280:	00001097          	auipc	ra,0x1
    80001284:	a7c080e7          	jalr	-1412(ra) # 80001cfc <panic>
    80001288:	00001097          	auipc	ra,0x1
    8000128c:	9d0080e7          	jalr	-1584(ra) # 80001c58 <consoleinit>
    80001290:	00001097          	auipc	ra,0x1
    80001294:	15c080e7          	jalr	348(ra) # 800023ec <printfinit>
    80001298:	00003517          	auipc	a0,0x3
    8000129c:	e9850513          	addi	a0,a0,-360 # 80004130 <CONSOLE_STATUS+0x120>
    800012a0:	00001097          	auipc	ra,0x1
    800012a4:	ab8080e7          	jalr	-1352(ra) # 80001d58 <__printf>
    800012a8:	00003517          	auipc	a0,0x3
    800012ac:	d7850513          	addi	a0,a0,-648 # 80004020 <CONSOLE_STATUS+0x10>
    800012b0:	00001097          	auipc	ra,0x1
    800012b4:	aa8080e7          	jalr	-1368(ra) # 80001d58 <__printf>
    800012b8:	00003517          	auipc	a0,0x3
    800012bc:	e7850513          	addi	a0,a0,-392 # 80004130 <CONSOLE_STATUS+0x120>
    800012c0:	00001097          	auipc	ra,0x1
    800012c4:	a98080e7          	jalr	-1384(ra) # 80001d58 <__printf>
    800012c8:	00001097          	auipc	ra,0x1
    800012cc:	4b0080e7          	jalr	1200(ra) # 80002778 <kinit>
    800012d0:	00000097          	auipc	ra,0x0
    800012d4:	148080e7          	jalr	328(ra) # 80001418 <trapinit>
    800012d8:	00000097          	auipc	ra,0x0
    800012dc:	16c080e7          	jalr	364(ra) # 80001444 <trapinithart>
    800012e0:	00000097          	auipc	ra,0x0
    800012e4:	5c0080e7          	jalr	1472(ra) # 800018a0 <plicinit>
    800012e8:	00000097          	auipc	ra,0x0
    800012ec:	5e0080e7          	jalr	1504(ra) # 800018c8 <plicinithart>
    800012f0:	00000097          	auipc	ra,0x0
    800012f4:	078080e7          	jalr	120(ra) # 80001368 <userinit>
    800012f8:	0ff0000f          	fence
    800012fc:	00100793          	li	a5,1
    80001300:	00003517          	auipc	a0,0x3
    80001304:	d3850513          	addi	a0,a0,-712 # 80004038 <CONSOLE_STATUS+0x28>
    80001308:	00f4a023          	sw	a5,0(s1)
    8000130c:	00001097          	auipc	ra,0x1
    80001310:	a4c080e7          	jalr	-1460(ra) # 80001d58 <__printf>
    80001314:	0000006f          	j	80001314 <system_main+0xd4>

0000000080001318 <cpuid>:
    80001318:	ff010113          	addi	sp,sp,-16
    8000131c:	00813423          	sd	s0,8(sp)
    80001320:	01010413          	addi	s0,sp,16
    80001324:	00020513          	mv	a0,tp
    80001328:	00813403          	ld	s0,8(sp)
    8000132c:	0005051b          	sext.w	a0,a0
    80001330:	01010113          	addi	sp,sp,16
    80001334:	00008067          	ret

0000000080001338 <mycpu>:
    80001338:	ff010113          	addi	sp,sp,-16
    8000133c:	00813423          	sd	s0,8(sp)
    80001340:	01010413          	addi	s0,sp,16
    80001344:	00020793          	mv	a5,tp
    80001348:	00813403          	ld	s0,8(sp)
    8000134c:	0007879b          	sext.w	a5,a5
    80001350:	00779793          	slli	a5,a5,0x7
    80001354:	00004517          	auipc	a0,0x4
    80001358:	f6c50513          	addi	a0,a0,-148 # 800052c0 <cpus>
    8000135c:	00f50533          	add	a0,a0,a5
    80001360:	01010113          	addi	sp,sp,16
    80001364:	00008067          	ret

0000000080001368 <userinit>:
    80001368:	ff010113          	addi	sp,sp,-16
    8000136c:	00813423          	sd	s0,8(sp)
    80001370:	01010413          	addi	s0,sp,16
    80001374:	00813403          	ld	s0,8(sp)
    80001378:	01010113          	addi	sp,sp,16
    8000137c:	00000317          	auipc	t1,0x0
    80001380:	c8430067          	jr	-892(t1) # 80001000 <main>

0000000080001384 <either_copyout>:
    80001384:	ff010113          	addi	sp,sp,-16
    80001388:	00813023          	sd	s0,0(sp)
    8000138c:	00113423          	sd	ra,8(sp)
    80001390:	01010413          	addi	s0,sp,16
    80001394:	02051663          	bnez	a0,800013c0 <either_copyout+0x3c>
    80001398:	00058513          	mv	a0,a1
    8000139c:	00060593          	mv	a1,a2
    800013a0:	0006861b          	sext.w	a2,a3
    800013a4:	00002097          	auipc	ra,0x2
    800013a8:	c60080e7          	jalr	-928(ra) # 80003004 <__memmove>
    800013ac:	00813083          	ld	ra,8(sp)
    800013b0:	00013403          	ld	s0,0(sp)
    800013b4:	00000513          	li	a0,0
    800013b8:	01010113          	addi	sp,sp,16
    800013bc:	00008067          	ret
    800013c0:	00003517          	auipc	a0,0x3
    800013c4:	cb850513          	addi	a0,a0,-840 # 80004078 <CONSOLE_STATUS+0x68>
    800013c8:	00001097          	auipc	ra,0x1
    800013cc:	934080e7          	jalr	-1740(ra) # 80001cfc <panic>

00000000800013d0 <either_copyin>:
    800013d0:	ff010113          	addi	sp,sp,-16
    800013d4:	00813023          	sd	s0,0(sp)
    800013d8:	00113423          	sd	ra,8(sp)
    800013dc:	01010413          	addi	s0,sp,16
    800013e0:	02059463          	bnez	a1,80001408 <either_copyin+0x38>
    800013e4:	00060593          	mv	a1,a2
    800013e8:	0006861b          	sext.w	a2,a3
    800013ec:	00002097          	auipc	ra,0x2
    800013f0:	c18080e7          	jalr	-1000(ra) # 80003004 <__memmove>
    800013f4:	00813083          	ld	ra,8(sp)
    800013f8:	00013403          	ld	s0,0(sp)
    800013fc:	00000513          	li	a0,0
    80001400:	01010113          	addi	sp,sp,16
    80001404:	00008067          	ret
    80001408:	00003517          	auipc	a0,0x3
    8000140c:	c9850513          	addi	a0,a0,-872 # 800040a0 <CONSOLE_STATUS+0x90>
    80001410:	00001097          	auipc	ra,0x1
    80001414:	8ec080e7          	jalr	-1812(ra) # 80001cfc <panic>

0000000080001418 <trapinit>:
    80001418:	ff010113          	addi	sp,sp,-16
    8000141c:	00813423          	sd	s0,8(sp)
    80001420:	01010413          	addi	s0,sp,16
    80001424:	00813403          	ld	s0,8(sp)
    80001428:	00003597          	auipc	a1,0x3
    8000142c:	ca058593          	addi	a1,a1,-864 # 800040c8 <CONSOLE_STATUS+0xb8>
    80001430:	00004517          	auipc	a0,0x4
    80001434:	f1050513          	addi	a0,a0,-240 # 80005340 <tickslock>
    80001438:	01010113          	addi	sp,sp,16
    8000143c:	00001317          	auipc	t1,0x1
    80001440:	5cc30067          	jr	1484(t1) # 80002a08 <initlock>

0000000080001444 <trapinithart>:
    80001444:	ff010113          	addi	sp,sp,-16
    80001448:	00813423          	sd	s0,8(sp)
    8000144c:	01010413          	addi	s0,sp,16
    80001450:	00000797          	auipc	a5,0x0
    80001454:	30078793          	addi	a5,a5,768 # 80001750 <kernelvec>
    80001458:	10579073          	csrw	stvec,a5
    8000145c:	00813403          	ld	s0,8(sp)
    80001460:	01010113          	addi	sp,sp,16
    80001464:	00008067          	ret

0000000080001468 <usertrap>:
    80001468:	ff010113          	addi	sp,sp,-16
    8000146c:	00813423          	sd	s0,8(sp)
    80001470:	01010413          	addi	s0,sp,16
    80001474:	00813403          	ld	s0,8(sp)
    80001478:	01010113          	addi	sp,sp,16
    8000147c:	00008067          	ret

0000000080001480 <usertrapret>:
    80001480:	ff010113          	addi	sp,sp,-16
    80001484:	00813423          	sd	s0,8(sp)
    80001488:	01010413          	addi	s0,sp,16
    8000148c:	00813403          	ld	s0,8(sp)
    80001490:	01010113          	addi	sp,sp,16
    80001494:	00008067          	ret

0000000080001498 <kerneltrap>:
    80001498:	fe010113          	addi	sp,sp,-32
    8000149c:	00813823          	sd	s0,16(sp)
    800014a0:	00113c23          	sd	ra,24(sp)
    800014a4:	00913423          	sd	s1,8(sp)
    800014a8:	02010413          	addi	s0,sp,32
    800014ac:	142025f3          	csrr	a1,scause
    800014b0:	100027f3          	csrr	a5,sstatus
    800014b4:	0027f793          	andi	a5,a5,2
    800014b8:	10079c63          	bnez	a5,800015d0 <kerneltrap+0x138>
    800014bc:	142027f3          	csrr	a5,scause
    800014c0:	0207ce63          	bltz	a5,800014fc <kerneltrap+0x64>
    800014c4:	00003517          	auipc	a0,0x3
    800014c8:	c4c50513          	addi	a0,a0,-948 # 80004110 <CONSOLE_STATUS+0x100>
    800014cc:	00001097          	auipc	ra,0x1
    800014d0:	88c080e7          	jalr	-1908(ra) # 80001d58 <__printf>
    800014d4:	141025f3          	csrr	a1,sepc
    800014d8:	14302673          	csrr	a2,stval
    800014dc:	00003517          	auipc	a0,0x3
    800014e0:	c4450513          	addi	a0,a0,-956 # 80004120 <CONSOLE_STATUS+0x110>
    800014e4:	00001097          	auipc	ra,0x1
    800014e8:	874080e7          	jalr	-1932(ra) # 80001d58 <__printf>
    800014ec:	00003517          	auipc	a0,0x3
    800014f0:	c4c50513          	addi	a0,a0,-948 # 80004138 <CONSOLE_STATUS+0x128>
    800014f4:	00001097          	auipc	ra,0x1
    800014f8:	808080e7          	jalr	-2040(ra) # 80001cfc <panic>
    800014fc:	0ff7f713          	andi	a4,a5,255
    80001500:	00900693          	li	a3,9
    80001504:	04d70063          	beq	a4,a3,80001544 <kerneltrap+0xac>
    80001508:	fff00713          	li	a4,-1
    8000150c:	03f71713          	slli	a4,a4,0x3f
    80001510:	00170713          	addi	a4,a4,1
    80001514:	fae798e3          	bne	a5,a4,800014c4 <kerneltrap+0x2c>
    80001518:	00000097          	auipc	ra,0x0
    8000151c:	e00080e7          	jalr	-512(ra) # 80001318 <cpuid>
    80001520:	06050663          	beqz	a0,8000158c <kerneltrap+0xf4>
    80001524:	144027f3          	csrr	a5,sip
    80001528:	ffd7f793          	andi	a5,a5,-3
    8000152c:	14479073          	csrw	sip,a5
    80001530:	01813083          	ld	ra,24(sp)
    80001534:	01013403          	ld	s0,16(sp)
    80001538:	00813483          	ld	s1,8(sp)
    8000153c:	02010113          	addi	sp,sp,32
    80001540:	00008067          	ret
    80001544:	00000097          	auipc	ra,0x0
    80001548:	3d0080e7          	jalr	976(ra) # 80001914 <plic_claim>
    8000154c:	00a00793          	li	a5,10
    80001550:	00050493          	mv	s1,a0
    80001554:	06f50863          	beq	a0,a5,800015c4 <kerneltrap+0x12c>
    80001558:	fc050ce3          	beqz	a0,80001530 <kerneltrap+0x98>
    8000155c:	00050593          	mv	a1,a0
    80001560:	00003517          	auipc	a0,0x3
    80001564:	b9050513          	addi	a0,a0,-1136 # 800040f0 <CONSOLE_STATUS+0xe0>
    80001568:	00000097          	auipc	ra,0x0
    8000156c:	7f0080e7          	jalr	2032(ra) # 80001d58 <__printf>
    80001570:	01013403          	ld	s0,16(sp)
    80001574:	01813083          	ld	ra,24(sp)
    80001578:	00048513          	mv	a0,s1
    8000157c:	00813483          	ld	s1,8(sp)
    80001580:	02010113          	addi	sp,sp,32
    80001584:	00000317          	auipc	t1,0x0
    80001588:	3c830067          	jr	968(t1) # 8000194c <plic_complete>
    8000158c:	00004517          	auipc	a0,0x4
    80001590:	db450513          	addi	a0,a0,-588 # 80005340 <tickslock>
    80001594:	00001097          	auipc	ra,0x1
    80001598:	498080e7          	jalr	1176(ra) # 80002a2c <acquire>
    8000159c:	00003717          	auipc	a4,0x3
    800015a0:	cb870713          	addi	a4,a4,-840 # 80004254 <ticks>
    800015a4:	00072783          	lw	a5,0(a4)
    800015a8:	00004517          	auipc	a0,0x4
    800015ac:	d9850513          	addi	a0,a0,-616 # 80005340 <tickslock>
    800015b0:	0017879b          	addiw	a5,a5,1
    800015b4:	00f72023          	sw	a5,0(a4)
    800015b8:	00001097          	auipc	ra,0x1
    800015bc:	540080e7          	jalr	1344(ra) # 80002af8 <release>
    800015c0:	f65ff06f          	j	80001524 <kerneltrap+0x8c>
    800015c4:	00001097          	auipc	ra,0x1
    800015c8:	09c080e7          	jalr	156(ra) # 80002660 <uartintr>
    800015cc:	fa5ff06f          	j	80001570 <kerneltrap+0xd8>
    800015d0:	00003517          	auipc	a0,0x3
    800015d4:	b0050513          	addi	a0,a0,-1280 # 800040d0 <CONSOLE_STATUS+0xc0>
    800015d8:	00000097          	auipc	ra,0x0
    800015dc:	724080e7          	jalr	1828(ra) # 80001cfc <panic>

00000000800015e0 <clockintr>:
    800015e0:	fe010113          	addi	sp,sp,-32
    800015e4:	00813823          	sd	s0,16(sp)
    800015e8:	00913423          	sd	s1,8(sp)
    800015ec:	00113c23          	sd	ra,24(sp)
    800015f0:	02010413          	addi	s0,sp,32
    800015f4:	00004497          	auipc	s1,0x4
    800015f8:	d4c48493          	addi	s1,s1,-692 # 80005340 <tickslock>
    800015fc:	00048513          	mv	a0,s1
    80001600:	00001097          	auipc	ra,0x1
    80001604:	42c080e7          	jalr	1068(ra) # 80002a2c <acquire>
    80001608:	00003717          	auipc	a4,0x3
    8000160c:	c4c70713          	addi	a4,a4,-948 # 80004254 <ticks>
    80001610:	00072783          	lw	a5,0(a4)
    80001614:	01013403          	ld	s0,16(sp)
    80001618:	01813083          	ld	ra,24(sp)
    8000161c:	00048513          	mv	a0,s1
    80001620:	0017879b          	addiw	a5,a5,1
    80001624:	00813483          	ld	s1,8(sp)
    80001628:	00f72023          	sw	a5,0(a4)
    8000162c:	02010113          	addi	sp,sp,32
    80001630:	00001317          	auipc	t1,0x1
    80001634:	4c830067          	jr	1224(t1) # 80002af8 <release>

0000000080001638 <devintr>:
    80001638:	142027f3          	csrr	a5,scause
    8000163c:	00000513          	li	a0,0
    80001640:	0007c463          	bltz	a5,80001648 <devintr+0x10>
    80001644:	00008067          	ret
    80001648:	fe010113          	addi	sp,sp,-32
    8000164c:	00813823          	sd	s0,16(sp)
    80001650:	00113c23          	sd	ra,24(sp)
    80001654:	00913423          	sd	s1,8(sp)
    80001658:	02010413          	addi	s0,sp,32
    8000165c:	0ff7f713          	andi	a4,a5,255
    80001660:	00900693          	li	a3,9
    80001664:	04d70c63          	beq	a4,a3,800016bc <devintr+0x84>
    80001668:	fff00713          	li	a4,-1
    8000166c:	03f71713          	slli	a4,a4,0x3f
    80001670:	00170713          	addi	a4,a4,1
    80001674:	00e78c63          	beq	a5,a4,8000168c <devintr+0x54>
    80001678:	01813083          	ld	ra,24(sp)
    8000167c:	01013403          	ld	s0,16(sp)
    80001680:	00813483          	ld	s1,8(sp)
    80001684:	02010113          	addi	sp,sp,32
    80001688:	00008067          	ret
    8000168c:	00000097          	auipc	ra,0x0
    80001690:	c8c080e7          	jalr	-884(ra) # 80001318 <cpuid>
    80001694:	06050663          	beqz	a0,80001700 <devintr+0xc8>
    80001698:	144027f3          	csrr	a5,sip
    8000169c:	ffd7f793          	andi	a5,a5,-3
    800016a0:	14479073          	csrw	sip,a5
    800016a4:	01813083          	ld	ra,24(sp)
    800016a8:	01013403          	ld	s0,16(sp)
    800016ac:	00813483          	ld	s1,8(sp)
    800016b0:	00200513          	li	a0,2
    800016b4:	02010113          	addi	sp,sp,32
    800016b8:	00008067          	ret
    800016bc:	00000097          	auipc	ra,0x0
    800016c0:	258080e7          	jalr	600(ra) # 80001914 <plic_claim>
    800016c4:	00a00793          	li	a5,10
    800016c8:	00050493          	mv	s1,a0
    800016cc:	06f50663          	beq	a0,a5,80001738 <devintr+0x100>
    800016d0:	00100513          	li	a0,1
    800016d4:	fa0482e3          	beqz	s1,80001678 <devintr+0x40>
    800016d8:	00048593          	mv	a1,s1
    800016dc:	00003517          	auipc	a0,0x3
    800016e0:	a1450513          	addi	a0,a0,-1516 # 800040f0 <CONSOLE_STATUS+0xe0>
    800016e4:	00000097          	auipc	ra,0x0
    800016e8:	674080e7          	jalr	1652(ra) # 80001d58 <__printf>
    800016ec:	00048513          	mv	a0,s1
    800016f0:	00000097          	auipc	ra,0x0
    800016f4:	25c080e7          	jalr	604(ra) # 8000194c <plic_complete>
    800016f8:	00100513          	li	a0,1
    800016fc:	f7dff06f          	j	80001678 <devintr+0x40>
    80001700:	00004517          	auipc	a0,0x4
    80001704:	c4050513          	addi	a0,a0,-960 # 80005340 <tickslock>
    80001708:	00001097          	auipc	ra,0x1
    8000170c:	324080e7          	jalr	804(ra) # 80002a2c <acquire>
    80001710:	00003717          	auipc	a4,0x3
    80001714:	b4470713          	addi	a4,a4,-1212 # 80004254 <ticks>
    80001718:	00072783          	lw	a5,0(a4)
    8000171c:	00004517          	auipc	a0,0x4
    80001720:	c2450513          	addi	a0,a0,-988 # 80005340 <tickslock>
    80001724:	0017879b          	addiw	a5,a5,1
    80001728:	00f72023          	sw	a5,0(a4)
    8000172c:	00001097          	auipc	ra,0x1
    80001730:	3cc080e7          	jalr	972(ra) # 80002af8 <release>
    80001734:	f65ff06f          	j	80001698 <devintr+0x60>
    80001738:	00001097          	auipc	ra,0x1
    8000173c:	f28080e7          	jalr	-216(ra) # 80002660 <uartintr>
    80001740:	fadff06f          	j	800016ec <devintr+0xb4>
	...

0000000080001750 <kernelvec>:
    80001750:	f0010113          	addi	sp,sp,-256
    80001754:	00113023          	sd	ra,0(sp)
    80001758:	00213423          	sd	sp,8(sp)
    8000175c:	00313823          	sd	gp,16(sp)
    80001760:	00413c23          	sd	tp,24(sp)
    80001764:	02513023          	sd	t0,32(sp)
    80001768:	02613423          	sd	t1,40(sp)
    8000176c:	02713823          	sd	t2,48(sp)
    80001770:	02813c23          	sd	s0,56(sp)
    80001774:	04913023          	sd	s1,64(sp)
    80001778:	04a13423          	sd	a0,72(sp)
    8000177c:	04b13823          	sd	a1,80(sp)
    80001780:	04c13c23          	sd	a2,88(sp)
    80001784:	06d13023          	sd	a3,96(sp)
    80001788:	06e13423          	sd	a4,104(sp)
    8000178c:	06f13823          	sd	a5,112(sp)
    80001790:	07013c23          	sd	a6,120(sp)
    80001794:	09113023          	sd	a7,128(sp)
    80001798:	09213423          	sd	s2,136(sp)
    8000179c:	09313823          	sd	s3,144(sp)
    800017a0:	09413c23          	sd	s4,152(sp)
    800017a4:	0b513023          	sd	s5,160(sp)
    800017a8:	0b613423          	sd	s6,168(sp)
    800017ac:	0b713823          	sd	s7,176(sp)
    800017b0:	0b813c23          	sd	s8,184(sp)
    800017b4:	0d913023          	sd	s9,192(sp)
    800017b8:	0da13423          	sd	s10,200(sp)
    800017bc:	0db13823          	sd	s11,208(sp)
    800017c0:	0dc13c23          	sd	t3,216(sp)
    800017c4:	0fd13023          	sd	t4,224(sp)
    800017c8:	0fe13423          	sd	t5,232(sp)
    800017cc:	0ff13823          	sd	t6,240(sp)
    800017d0:	cc9ff0ef          	jal	ra,80001498 <kerneltrap>
    800017d4:	00013083          	ld	ra,0(sp)
    800017d8:	00813103          	ld	sp,8(sp)
    800017dc:	01013183          	ld	gp,16(sp)
    800017e0:	02013283          	ld	t0,32(sp)
    800017e4:	02813303          	ld	t1,40(sp)
    800017e8:	03013383          	ld	t2,48(sp)
    800017ec:	03813403          	ld	s0,56(sp)
    800017f0:	04013483          	ld	s1,64(sp)
    800017f4:	04813503          	ld	a0,72(sp)
    800017f8:	05013583          	ld	a1,80(sp)
    800017fc:	05813603          	ld	a2,88(sp)
    80001800:	06013683          	ld	a3,96(sp)
    80001804:	06813703          	ld	a4,104(sp)
    80001808:	07013783          	ld	a5,112(sp)
    8000180c:	07813803          	ld	a6,120(sp)
    80001810:	08013883          	ld	a7,128(sp)
    80001814:	08813903          	ld	s2,136(sp)
    80001818:	09013983          	ld	s3,144(sp)
    8000181c:	09813a03          	ld	s4,152(sp)
    80001820:	0a013a83          	ld	s5,160(sp)
    80001824:	0a813b03          	ld	s6,168(sp)
    80001828:	0b013b83          	ld	s7,176(sp)
    8000182c:	0b813c03          	ld	s8,184(sp)
    80001830:	0c013c83          	ld	s9,192(sp)
    80001834:	0c813d03          	ld	s10,200(sp)
    80001838:	0d013d83          	ld	s11,208(sp)
    8000183c:	0d813e03          	ld	t3,216(sp)
    80001840:	0e013e83          	ld	t4,224(sp)
    80001844:	0e813f03          	ld	t5,232(sp)
    80001848:	0f013f83          	ld	t6,240(sp)
    8000184c:	10010113          	addi	sp,sp,256
    80001850:	10200073          	sret
    80001854:	00000013          	nop
    80001858:	00000013          	nop
    8000185c:	00000013          	nop

0000000080001860 <timervec>:
    80001860:	34051573          	csrrw	a0,mscratch,a0
    80001864:	00b53023          	sd	a1,0(a0)
    80001868:	00c53423          	sd	a2,8(a0)
    8000186c:	00d53823          	sd	a3,16(a0)
    80001870:	01853583          	ld	a1,24(a0)
    80001874:	02053603          	ld	a2,32(a0)
    80001878:	0005b683          	ld	a3,0(a1)
    8000187c:	00c686b3          	add	a3,a3,a2
    80001880:	00d5b023          	sd	a3,0(a1)
    80001884:	00200593          	li	a1,2
    80001888:	14459073          	csrw	sip,a1
    8000188c:	01053683          	ld	a3,16(a0)
    80001890:	00853603          	ld	a2,8(a0)
    80001894:	00053583          	ld	a1,0(a0)
    80001898:	34051573          	csrrw	a0,mscratch,a0
    8000189c:	30200073          	mret

00000000800018a0 <plicinit>:
    800018a0:	ff010113          	addi	sp,sp,-16
    800018a4:	00813423          	sd	s0,8(sp)
    800018a8:	01010413          	addi	s0,sp,16
    800018ac:	00813403          	ld	s0,8(sp)
    800018b0:	0c0007b7          	lui	a5,0xc000
    800018b4:	00100713          	li	a4,1
    800018b8:	02e7a423          	sw	a4,40(a5) # c000028 <_entry-0x73ffffd8>
    800018bc:	00e7a223          	sw	a4,4(a5)
    800018c0:	01010113          	addi	sp,sp,16
    800018c4:	00008067          	ret

00000000800018c8 <plicinithart>:
    800018c8:	ff010113          	addi	sp,sp,-16
    800018cc:	00813023          	sd	s0,0(sp)
    800018d0:	00113423          	sd	ra,8(sp)
    800018d4:	01010413          	addi	s0,sp,16
    800018d8:	00000097          	auipc	ra,0x0
    800018dc:	a40080e7          	jalr	-1472(ra) # 80001318 <cpuid>
    800018e0:	0085171b          	slliw	a4,a0,0x8
    800018e4:	0c0027b7          	lui	a5,0xc002
    800018e8:	00e787b3          	add	a5,a5,a4
    800018ec:	40200713          	li	a4,1026
    800018f0:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>
    800018f4:	00813083          	ld	ra,8(sp)
    800018f8:	00013403          	ld	s0,0(sp)
    800018fc:	00d5151b          	slliw	a0,a0,0xd
    80001900:	0c2017b7          	lui	a5,0xc201
    80001904:	00a78533          	add	a0,a5,a0
    80001908:	00052023          	sw	zero,0(a0)
    8000190c:	01010113          	addi	sp,sp,16
    80001910:	00008067          	ret

0000000080001914 <plic_claim>:
    80001914:	ff010113          	addi	sp,sp,-16
    80001918:	00813023          	sd	s0,0(sp)
    8000191c:	00113423          	sd	ra,8(sp)
    80001920:	01010413          	addi	s0,sp,16
    80001924:	00000097          	auipc	ra,0x0
    80001928:	9f4080e7          	jalr	-1548(ra) # 80001318 <cpuid>
    8000192c:	00813083          	ld	ra,8(sp)
    80001930:	00013403          	ld	s0,0(sp)
    80001934:	00d5151b          	slliw	a0,a0,0xd
    80001938:	0c2017b7          	lui	a5,0xc201
    8000193c:	00a78533          	add	a0,a5,a0
    80001940:	00452503          	lw	a0,4(a0)
    80001944:	01010113          	addi	sp,sp,16
    80001948:	00008067          	ret

000000008000194c <plic_complete>:
    8000194c:	fe010113          	addi	sp,sp,-32
    80001950:	00813823          	sd	s0,16(sp)
    80001954:	00913423          	sd	s1,8(sp)
    80001958:	00113c23          	sd	ra,24(sp)
    8000195c:	02010413          	addi	s0,sp,32
    80001960:	00050493          	mv	s1,a0
    80001964:	00000097          	auipc	ra,0x0
    80001968:	9b4080e7          	jalr	-1612(ra) # 80001318 <cpuid>
    8000196c:	01813083          	ld	ra,24(sp)
    80001970:	01013403          	ld	s0,16(sp)
    80001974:	00d5179b          	slliw	a5,a0,0xd
    80001978:	0c201737          	lui	a4,0xc201
    8000197c:	00f707b3          	add	a5,a4,a5
    80001980:	0097a223          	sw	s1,4(a5) # c201004 <_entry-0x73dfeffc>
    80001984:	00813483          	ld	s1,8(sp)
    80001988:	02010113          	addi	sp,sp,32
    8000198c:	00008067          	ret

0000000080001990 <consolewrite>:
    80001990:	fb010113          	addi	sp,sp,-80
    80001994:	04813023          	sd	s0,64(sp)
    80001998:	04113423          	sd	ra,72(sp)
    8000199c:	02913c23          	sd	s1,56(sp)
    800019a0:	03213823          	sd	s2,48(sp)
    800019a4:	03313423          	sd	s3,40(sp)
    800019a8:	03413023          	sd	s4,32(sp)
    800019ac:	01513c23          	sd	s5,24(sp)
    800019b0:	05010413          	addi	s0,sp,80
    800019b4:	06c05c63          	blez	a2,80001a2c <consolewrite+0x9c>
    800019b8:	00060993          	mv	s3,a2
    800019bc:	00050a13          	mv	s4,a0
    800019c0:	00058493          	mv	s1,a1
    800019c4:	00000913          	li	s2,0
    800019c8:	fff00a93          	li	s5,-1
    800019cc:	01c0006f          	j	800019e8 <consolewrite+0x58>
    800019d0:	fbf44503          	lbu	a0,-65(s0)
    800019d4:	0019091b          	addiw	s2,s2,1
    800019d8:	00148493          	addi	s1,s1,1
    800019dc:	00001097          	auipc	ra,0x1
    800019e0:	a9c080e7          	jalr	-1380(ra) # 80002478 <uartputc>
    800019e4:	03298063          	beq	s3,s2,80001a04 <consolewrite+0x74>
    800019e8:	00048613          	mv	a2,s1
    800019ec:	00100693          	li	a3,1
    800019f0:	000a0593          	mv	a1,s4
    800019f4:	fbf40513          	addi	a0,s0,-65
    800019f8:	00000097          	auipc	ra,0x0
    800019fc:	9d8080e7          	jalr	-1576(ra) # 800013d0 <either_copyin>
    80001a00:	fd5518e3          	bne	a0,s5,800019d0 <consolewrite+0x40>
    80001a04:	04813083          	ld	ra,72(sp)
    80001a08:	04013403          	ld	s0,64(sp)
    80001a0c:	03813483          	ld	s1,56(sp)
    80001a10:	02813983          	ld	s3,40(sp)
    80001a14:	02013a03          	ld	s4,32(sp)
    80001a18:	01813a83          	ld	s5,24(sp)
    80001a1c:	00090513          	mv	a0,s2
    80001a20:	03013903          	ld	s2,48(sp)
    80001a24:	05010113          	addi	sp,sp,80
    80001a28:	00008067          	ret
    80001a2c:	00000913          	li	s2,0
    80001a30:	fd5ff06f          	j	80001a04 <consolewrite+0x74>

0000000080001a34 <consoleread>:
    80001a34:	f9010113          	addi	sp,sp,-112
    80001a38:	06813023          	sd	s0,96(sp)
    80001a3c:	04913c23          	sd	s1,88(sp)
    80001a40:	05213823          	sd	s2,80(sp)
    80001a44:	05313423          	sd	s3,72(sp)
    80001a48:	05413023          	sd	s4,64(sp)
    80001a4c:	03513c23          	sd	s5,56(sp)
    80001a50:	03613823          	sd	s6,48(sp)
    80001a54:	03713423          	sd	s7,40(sp)
    80001a58:	03813023          	sd	s8,32(sp)
    80001a5c:	06113423          	sd	ra,104(sp)
    80001a60:	01913c23          	sd	s9,24(sp)
    80001a64:	07010413          	addi	s0,sp,112
    80001a68:	00060b93          	mv	s7,a2
    80001a6c:	00050913          	mv	s2,a0
    80001a70:	00058c13          	mv	s8,a1
    80001a74:	00060b1b          	sext.w	s6,a2
    80001a78:	00004497          	auipc	s1,0x4
    80001a7c:	8e048493          	addi	s1,s1,-1824 # 80005358 <cons>
    80001a80:	00400993          	li	s3,4
    80001a84:	fff00a13          	li	s4,-1
    80001a88:	00a00a93          	li	s5,10
    80001a8c:	05705e63          	blez	s7,80001ae8 <consoleread+0xb4>
    80001a90:	09c4a703          	lw	a4,156(s1)
    80001a94:	0984a783          	lw	a5,152(s1)
    80001a98:	0007071b          	sext.w	a4,a4
    80001a9c:	08e78463          	beq	a5,a4,80001b24 <consoleread+0xf0>
    80001aa0:	07f7f713          	andi	a4,a5,127
    80001aa4:	00e48733          	add	a4,s1,a4
    80001aa8:	01874703          	lbu	a4,24(a4) # c201018 <_entry-0x73dfefe8>
    80001aac:	0017869b          	addiw	a3,a5,1
    80001ab0:	08d4ac23          	sw	a3,152(s1)
    80001ab4:	00070c9b          	sext.w	s9,a4
    80001ab8:	0b370663          	beq	a4,s3,80001b64 <consoleread+0x130>
    80001abc:	00100693          	li	a3,1
    80001ac0:	f9f40613          	addi	a2,s0,-97
    80001ac4:	000c0593          	mv	a1,s8
    80001ac8:	00090513          	mv	a0,s2
    80001acc:	f8e40fa3          	sb	a4,-97(s0)
    80001ad0:	00000097          	auipc	ra,0x0
    80001ad4:	8b4080e7          	jalr	-1868(ra) # 80001384 <either_copyout>
    80001ad8:	01450863          	beq	a0,s4,80001ae8 <consoleread+0xb4>
    80001adc:	001c0c13          	addi	s8,s8,1
    80001ae0:	fffb8b9b          	addiw	s7,s7,-1
    80001ae4:	fb5c94e3          	bne	s9,s5,80001a8c <consoleread+0x58>
    80001ae8:	000b851b          	sext.w	a0,s7
    80001aec:	06813083          	ld	ra,104(sp)
    80001af0:	06013403          	ld	s0,96(sp)
    80001af4:	05813483          	ld	s1,88(sp)
    80001af8:	05013903          	ld	s2,80(sp)
    80001afc:	04813983          	ld	s3,72(sp)
    80001b00:	04013a03          	ld	s4,64(sp)
    80001b04:	03813a83          	ld	s5,56(sp)
    80001b08:	02813b83          	ld	s7,40(sp)
    80001b0c:	02013c03          	ld	s8,32(sp)
    80001b10:	01813c83          	ld	s9,24(sp)
    80001b14:	40ab053b          	subw	a0,s6,a0
    80001b18:	03013b03          	ld	s6,48(sp)
    80001b1c:	07010113          	addi	sp,sp,112
    80001b20:	00008067          	ret
    80001b24:	00001097          	auipc	ra,0x1
    80001b28:	1d8080e7          	jalr	472(ra) # 80002cfc <push_on>
    80001b2c:	0984a703          	lw	a4,152(s1)
    80001b30:	09c4a783          	lw	a5,156(s1)
    80001b34:	0007879b          	sext.w	a5,a5
    80001b38:	fef70ce3          	beq	a4,a5,80001b30 <consoleread+0xfc>
    80001b3c:	00001097          	auipc	ra,0x1
    80001b40:	234080e7          	jalr	564(ra) # 80002d70 <pop_on>
    80001b44:	0984a783          	lw	a5,152(s1)
    80001b48:	07f7f713          	andi	a4,a5,127
    80001b4c:	00e48733          	add	a4,s1,a4
    80001b50:	01874703          	lbu	a4,24(a4)
    80001b54:	0017869b          	addiw	a3,a5,1
    80001b58:	08d4ac23          	sw	a3,152(s1)
    80001b5c:	00070c9b          	sext.w	s9,a4
    80001b60:	f5371ee3          	bne	a4,s3,80001abc <consoleread+0x88>
    80001b64:	000b851b          	sext.w	a0,s7
    80001b68:	f96bf2e3          	bgeu	s7,s6,80001aec <consoleread+0xb8>
    80001b6c:	08f4ac23          	sw	a5,152(s1)
    80001b70:	f7dff06f          	j	80001aec <consoleread+0xb8>

0000000080001b74 <consputc>:
    80001b74:	10000793          	li	a5,256
    80001b78:	00f50663          	beq	a0,a5,80001b84 <consputc+0x10>
    80001b7c:	00001317          	auipc	t1,0x1
    80001b80:	9f430067          	jr	-1548(t1) # 80002570 <uartputc_sync>
    80001b84:	ff010113          	addi	sp,sp,-16
    80001b88:	00113423          	sd	ra,8(sp)
    80001b8c:	00813023          	sd	s0,0(sp)
    80001b90:	01010413          	addi	s0,sp,16
    80001b94:	00800513          	li	a0,8
    80001b98:	00001097          	auipc	ra,0x1
    80001b9c:	9d8080e7          	jalr	-1576(ra) # 80002570 <uartputc_sync>
    80001ba0:	02000513          	li	a0,32
    80001ba4:	00001097          	auipc	ra,0x1
    80001ba8:	9cc080e7          	jalr	-1588(ra) # 80002570 <uartputc_sync>
    80001bac:	00013403          	ld	s0,0(sp)
    80001bb0:	00813083          	ld	ra,8(sp)
    80001bb4:	00800513          	li	a0,8
    80001bb8:	01010113          	addi	sp,sp,16
    80001bbc:	00001317          	auipc	t1,0x1
    80001bc0:	9b430067          	jr	-1612(t1) # 80002570 <uartputc_sync>

0000000080001bc4 <consoleintr>:
    80001bc4:	fe010113          	addi	sp,sp,-32
    80001bc8:	00813823          	sd	s0,16(sp)
    80001bcc:	00913423          	sd	s1,8(sp)
    80001bd0:	01213023          	sd	s2,0(sp)
    80001bd4:	00113c23          	sd	ra,24(sp)
    80001bd8:	02010413          	addi	s0,sp,32
    80001bdc:	00003917          	auipc	s2,0x3
    80001be0:	77c90913          	addi	s2,s2,1916 # 80005358 <cons>
    80001be4:	00050493          	mv	s1,a0
    80001be8:	00090513          	mv	a0,s2
    80001bec:	00001097          	auipc	ra,0x1
    80001bf0:	e40080e7          	jalr	-448(ra) # 80002a2c <acquire>
    80001bf4:	02048c63          	beqz	s1,80001c2c <consoleintr+0x68>
    80001bf8:	0a092783          	lw	a5,160(s2)
    80001bfc:	09892703          	lw	a4,152(s2)
    80001c00:	07f00693          	li	a3,127
    80001c04:	40e7873b          	subw	a4,a5,a4
    80001c08:	02e6e263          	bltu	a3,a4,80001c2c <consoleintr+0x68>
    80001c0c:	00d00713          	li	a4,13
    80001c10:	04e48063          	beq	s1,a4,80001c50 <consoleintr+0x8c>
    80001c14:	07f7f713          	andi	a4,a5,127
    80001c18:	00e90733          	add	a4,s2,a4
    80001c1c:	0017879b          	addiw	a5,a5,1
    80001c20:	0af92023          	sw	a5,160(s2)
    80001c24:	00970c23          	sb	s1,24(a4)
    80001c28:	08f92e23          	sw	a5,156(s2)
    80001c2c:	01013403          	ld	s0,16(sp)
    80001c30:	01813083          	ld	ra,24(sp)
    80001c34:	00813483          	ld	s1,8(sp)
    80001c38:	00013903          	ld	s2,0(sp)
    80001c3c:	00003517          	auipc	a0,0x3
    80001c40:	71c50513          	addi	a0,a0,1820 # 80005358 <cons>
    80001c44:	02010113          	addi	sp,sp,32
    80001c48:	00001317          	auipc	t1,0x1
    80001c4c:	eb030067          	jr	-336(t1) # 80002af8 <release>
    80001c50:	00a00493          	li	s1,10
    80001c54:	fc1ff06f          	j	80001c14 <consoleintr+0x50>

0000000080001c58 <consoleinit>:
    80001c58:	fe010113          	addi	sp,sp,-32
    80001c5c:	00113c23          	sd	ra,24(sp)
    80001c60:	00813823          	sd	s0,16(sp)
    80001c64:	00913423          	sd	s1,8(sp)
    80001c68:	02010413          	addi	s0,sp,32
    80001c6c:	00003497          	auipc	s1,0x3
    80001c70:	6ec48493          	addi	s1,s1,1772 # 80005358 <cons>
    80001c74:	00048513          	mv	a0,s1
    80001c78:	00002597          	auipc	a1,0x2
    80001c7c:	4d058593          	addi	a1,a1,1232 # 80004148 <CONSOLE_STATUS+0x138>
    80001c80:	00001097          	auipc	ra,0x1
    80001c84:	d88080e7          	jalr	-632(ra) # 80002a08 <initlock>
    80001c88:	00000097          	auipc	ra,0x0
    80001c8c:	7ac080e7          	jalr	1964(ra) # 80002434 <uartinit>
    80001c90:	01813083          	ld	ra,24(sp)
    80001c94:	01013403          	ld	s0,16(sp)
    80001c98:	00000797          	auipc	a5,0x0
    80001c9c:	d9c78793          	addi	a5,a5,-612 # 80001a34 <consoleread>
    80001ca0:	0af4bc23          	sd	a5,184(s1)
    80001ca4:	00000797          	auipc	a5,0x0
    80001ca8:	cec78793          	addi	a5,a5,-788 # 80001990 <consolewrite>
    80001cac:	0cf4b023          	sd	a5,192(s1)
    80001cb0:	00813483          	ld	s1,8(sp)
    80001cb4:	02010113          	addi	sp,sp,32
    80001cb8:	00008067          	ret

0000000080001cbc <console_read>:
    80001cbc:	ff010113          	addi	sp,sp,-16
    80001cc0:	00813423          	sd	s0,8(sp)
    80001cc4:	01010413          	addi	s0,sp,16
    80001cc8:	00813403          	ld	s0,8(sp)
    80001ccc:	00003317          	auipc	t1,0x3
    80001cd0:	74433303          	ld	t1,1860(t1) # 80005410 <devsw+0x10>
    80001cd4:	01010113          	addi	sp,sp,16
    80001cd8:	00030067          	jr	t1

0000000080001cdc <console_write>:
    80001cdc:	ff010113          	addi	sp,sp,-16
    80001ce0:	00813423          	sd	s0,8(sp)
    80001ce4:	01010413          	addi	s0,sp,16
    80001ce8:	00813403          	ld	s0,8(sp)
    80001cec:	00003317          	auipc	t1,0x3
    80001cf0:	72c33303          	ld	t1,1836(t1) # 80005418 <devsw+0x18>
    80001cf4:	01010113          	addi	sp,sp,16
    80001cf8:	00030067          	jr	t1

0000000080001cfc <panic>:
    80001cfc:	fe010113          	addi	sp,sp,-32
    80001d00:	00113c23          	sd	ra,24(sp)
    80001d04:	00813823          	sd	s0,16(sp)
    80001d08:	00913423          	sd	s1,8(sp)
    80001d0c:	02010413          	addi	s0,sp,32
    80001d10:	00050493          	mv	s1,a0
    80001d14:	00002517          	auipc	a0,0x2
    80001d18:	43c50513          	addi	a0,a0,1084 # 80004150 <CONSOLE_STATUS+0x140>
    80001d1c:	00003797          	auipc	a5,0x3
    80001d20:	7807ae23          	sw	zero,1948(a5) # 800054b8 <pr+0x18>
    80001d24:	00000097          	auipc	ra,0x0
    80001d28:	034080e7          	jalr	52(ra) # 80001d58 <__printf>
    80001d2c:	00048513          	mv	a0,s1
    80001d30:	00000097          	auipc	ra,0x0
    80001d34:	028080e7          	jalr	40(ra) # 80001d58 <__printf>
    80001d38:	00002517          	auipc	a0,0x2
    80001d3c:	3f850513          	addi	a0,a0,1016 # 80004130 <CONSOLE_STATUS+0x120>
    80001d40:	00000097          	auipc	ra,0x0
    80001d44:	018080e7          	jalr	24(ra) # 80001d58 <__printf>
    80001d48:	00100793          	li	a5,1
    80001d4c:	00002717          	auipc	a4,0x2
    80001d50:	50f72623          	sw	a5,1292(a4) # 80004258 <panicked>
    80001d54:	0000006f          	j	80001d54 <panic+0x58>

0000000080001d58 <__printf>:
    80001d58:	f3010113          	addi	sp,sp,-208
    80001d5c:	08813023          	sd	s0,128(sp)
    80001d60:	07313423          	sd	s3,104(sp)
    80001d64:	09010413          	addi	s0,sp,144
    80001d68:	05813023          	sd	s8,64(sp)
    80001d6c:	08113423          	sd	ra,136(sp)
    80001d70:	06913c23          	sd	s1,120(sp)
    80001d74:	07213823          	sd	s2,112(sp)
    80001d78:	07413023          	sd	s4,96(sp)
    80001d7c:	05513c23          	sd	s5,88(sp)
    80001d80:	05613823          	sd	s6,80(sp)
    80001d84:	05713423          	sd	s7,72(sp)
    80001d88:	03913c23          	sd	s9,56(sp)
    80001d8c:	03a13823          	sd	s10,48(sp)
    80001d90:	03b13423          	sd	s11,40(sp)
    80001d94:	00003317          	auipc	t1,0x3
    80001d98:	70c30313          	addi	t1,t1,1804 # 800054a0 <pr>
    80001d9c:	01832c03          	lw	s8,24(t1)
    80001da0:	00b43423          	sd	a1,8(s0)
    80001da4:	00c43823          	sd	a2,16(s0)
    80001da8:	00d43c23          	sd	a3,24(s0)
    80001dac:	02e43023          	sd	a4,32(s0)
    80001db0:	02f43423          	sd	a5,40(s0)
    80001db4:	03043823          	sd	a6,48(s0)
    80001db8:	03143c23          	sd	a7,56(s0)
    80001dbc:	00050993          	mv	s3,a0
    80001dc0:	4a0c1663          	bnez	s8,8000226c <__printf+0x514>
    80001dc4:	60098c63          	beqz	s3,800023dc <__printf+0x684>
    80001dc8:	0009c503          	lbu	a0,0(s3)
    80001dcc:	00840793          	addi	a5,s0,8
    80001dd0:	f6f43c23          	sd	a5,-136(s0)
    80001dd4:	00000493          	li	s1,0
    80001dd8:	22050063          	beqz	a0,80001ff8 <__printf+0x2a0>
    80001ddc:	00002a37          	lui	s4,0x2
    80001de0:	00018ab7          	lui	s5,0x18
    80001de4:	000f4b37          	lui	s6,0xf4
    80001de8:	00989bb7          	lui	s7,0x989
    80001dec:	70fa0a13          	addi	s4,s4,1807 # 270f <_entry-0x7fffd8f1>
    80001df0:	69fa8a93          	addi	s5,s5,1695 # 1869f <_entry-0x7ffe7961>
    80001df4:	23fb0b13          	addi	s6,s6,575 # f423f <_entry-0x7ff0bdc1>
    80001df8:	67fb8b93          	addi	s7,s7,1663 # 98967f <_entry-0x7f676981>
    80001dfc:	00148c9b          	addiw	s9,s1,1
    80001e00:	02500793          	li	a5,37
    80001e04:	01998933          	add	s2,s3,s9
    80001e08:	38f51263          	bne	a0,a5,8000218c <__printf+0x434>
    80001e0c:	00094783          	lbu	a5,0(s2)
    80001e10:	00078c9b          	sext.w	s9,a5
    80001e14:	1e078263          	beqz	a5,80001ff8 <__printf+0x2a0>
    80001e18:	0024849b          	addiw	s1,s1,2
    80001e1c:	07000713          	li	a4,112
    80001e20:	00998933          	add	s2,s3,s1
    80001e24:	38e78a63          	beq	a5,a4,800021b8 <__printf+0x460>
    80001e28:	20f76863          	bltu	a4,a5,80002038 <__printf+0x2e0>
    80001e2c:	42a78863          	beq	a5,a0,8000225c <__printf+0x504>
    80001e30:	06400713          	li	a4,100
    80001e34:	40e79663          	bne	a5,a4,80002240 <__printf+0x4e8>
    80001e38:	f7843783          	ld	a5,-136(s0)
    80001e3c:	0007a603          	lw	a2,0(a5)
    80001e40:	00878793          	addi	a5,a5,8
    80001e44:	f6f43c23          	sd	a5,-136(s0)
    80001e48:	42064a63          	bltz	a2,8000227c <__printf+0x524>
    80001e4c:	00a00713          	li	a4,10
    80001e50:	02e677bb          	remuw	a5,a2,a4
    80001e54:	00002d97          	auipc	s11,0x2
    80001e58:	324d8d93          	addi	s11,s11,804 # 80004178 <digits>
    80001e5c:	00900593          	li	a1,9
    80001e60:	0006051b          	sext.w	a0,a2
    80001e64:	00000c93          	li	s9,0
    80001e68:	02079793          	slli	a5,a5,0x20
    80001e6c:	0207d793          	srli	a5,a5,0x20
    80001e70:	00fd87b3          	add	a5,s11,a5
    80001e74:	0007c783          	lbu	a5,0(a5)
    80001e78:	02e656bb          	divuw	a3,a2,a4
    80001e7c:	f8f40023          	sb	a5,-128(s0)
    80001e80:	14c5d863          	bge	a1,a2,80001fd0 <__printf+0x278>
    80001e84:	06300593          	li	a1,99
    80001e88:	00100c93          	li	s9,1
    80001e8c:	02e6f7bb          	remuw	a5,a3,a4
    80001e90:	02079793          	slli	a5,a5,0x20
    80001e94:	0207d793          	srli	a5,a5,0x20
    80001e98:	00fd87b3          	add	a5,s11,a5
    80001e9c:	0007c783          	lbu	a5,0(a5)
    80001ea0:	02e6d73b          	divuw	a4,a3,a4
    80001ea4:	f8f400a3          	sb	a5,-127(s0)
    80001ea8:	12a5f463          	bgeu	a1,a0,80001fd0 <__printf+0x278>
    80001eac:	00a00693          	li	a3,10
    80001eb0:	00900593          	li	a1,9
    80001eb4:	02d777bb          	remuw	a5,a4,a3
    80001eb8:	02079793          	slli	a5,a5,0x20
    80001ebc:	0207d793          	srli	a5,a5,0x20
    80001ec0:	00fd87b3          	add	a5,s11,a5
    80001ec4:	0007c503          	lbu	a0,0(a5)
    80001ec8:	02d757bb          	divuw	a5,a4,a3
    80001ecc:	f8a40123          	sb	a0,-126(s0)
    80001ed0:	48e5f263          	bgeu	a1,a4,80002354 <__printf+0x5fc>
    80001ed4:	06300513          	li	a0,99
    80001ed8:	02d7f5bb          	remuw	a1,a5,a3
    80001edc:	02059593          	slli	a1,a1,0x20
    80001ee0:	0205d593          	srli	a1,a1,0x20
    80001ee4:	00bd85b3          	add	a1,s11,a1
    80001ee8:	0005c583          	lbu	a1,0(a1)
    80001eec:	02d7d7bb          	divuw	a5,a5,a3
    80001ef0:	f8b401a3          	sb	a1,-125(s0)
    80001ef4:	48e57263          	bgeu	a0,a4,80002378 <__printf+0x620>
    80001ef8:	3e700513          	li	a0,999
    80001efc:	02d7f5bb          	remuw	a1,a5,a3
    80001f00:	02059593          	slli	a1,a1,0x20
    80001f04:	0205d593          	srli	a1,a1,0x20
    80001f08:	00bd85b3          	add	a1,s11,a1
    80001f0c:	0005c583          	lbu	a1,0(a1)
    80001f10:	02d7d7bb          	divuw	a5,a5,a3
    80001f14:	f8b40223          	sb	a1,-124(s0)
    80001f18:	46e57663          	bgeu	a0,a4,80002384 <__printf+0x62c>
    80001f1c:	02d7f5bb          	remuw	a1,a5,a3
    80001f20:	02059593          	slli	a1,a1,0x20
    80001f24:	0205d593          	srli	a1,a1,0x20
    80001f28:	00bd85b3          	add	a1,s11,a1
    80001f2c:	0005c583          	lbu	a1,0(a1)
    80001f30:	02d7d7bb          	divuw	a5,a5,a3
    80001f34:	f8b402a3          	sb	a1,-123(s0)
    80001f38:	46ea7863          	bgeu	s4,a4,800023a8 <__printf+0x650>
    80001f3c:	02d7f5bb          	remuw	a1,a5,a3
    80001f40:	02059593          	slli	a1,a1,0x20
    80001f44:	0205d593          	srli	a1,a1,0x20
    80001f48:	00bd85b3          	add	a1,s11,a1
    80001f4c:	0005c583          	lbu	a1,0(a1)
    80001f50:	02d7d7bb          	divuw	a5,a5,a3
    80001f54:	f8b40323          	sb	a1,-122(s0)
    80001f58:	3eeaf863          	bgeu	s5,a4,80002348 <__printf+0x5f0>
    80001f5c:	02d7f5bb          	remuw	a1,a5,a3
    80001f60:	02059593          	slli	a1,a1,0x20
    80001f64:	0205d593          	srli	a1,a1,0x20
    80001f68:	00bd85b3          	add	a1,s11,a1
    80001f6c:	0005c583          	lbu	a1,0(a1)
    80001f70:	02d7d7bb          	divuw	a5,a5,a3
    80001f74:	f8b403a3          	sb	a1,-121(s0)
    80001f78:	42eb7e63          	bgeu	s6,a4,800023b4 <__printf+0x65c>
    80001f7c:	02d7f5bb          	remuw	a1,a5,a3
    80001f80:	02059593          	slli	a1,a1,0x20
    80001f84:	0205d593          	srli	a1,a1,0x20
    80001f88:	00bd85b3          	add	a1,s11,a1
    80001f8c:	0005c583          	lbu	a1,0(a1)
    80001f90:	02d7d7bb          	divuw	a5,a5,a3
    80001f94:	f8b40423          	sb	a1,-120(s0)
    80001f98:	42ebfc63          	bgeu	s7,a4,800023d0 <__printf+0x678>
    80001f9c:	02079793          	slli	a5,a5,0x20
    80001fa0:	0207d793          	srli	a5,a5,0x20
    80001fa4:	00fd8db3          	add	s11,s11,a5
    80001fa8:	000dc703          	lbu	a4,0(s11)
    80001fac:	00a00793          	li	a5,10
    80001fb0:	00900c93          	li	s9,9
    80001fb4:	f8e404a3          	sb	a4,-119(s0)
    80001fb8:	00065c63          	bgez	a2,80001fd0 <__printf+0x278>
    80001fbc:	f9040713          	addi	a4,s0,-112
    80001fc0:	00f70733          	add	a4,a4,a5
    80001fc4:	02d00693          	li	a3,45
    80001fc8:	fed70823          	sb	a3,-16(a4)
    80001fcc:	00078c93          	mv	s9,a5
    80001fd0:	f8040793          	addi	a5,s0,-128
    80001fd4:	01978cb3          	add	s9,a5,s9
    80001fd8:	f7f40d13          	addi	s10,s0,-129
    80001fdc:	000cc503          	lbu	a0,0(s9)
    80001fe0:	fffc8c93          	addi	s9,s9,-1
    80001fe4:	00000097          	auipc	ra,0x0
    80001fe8:	b90080e7          	jalr	-1136(ra) # 80001b74 <consputc>
    80001fec:	ffac98e3          	bne	s9,s10,80001fdc <__printf+0x284>
    80001ff0:	00094503          	lbu	a0,0(s2)
    80001ff4:	e00514e3          	bnez	a0,80001dfc <__printf+0xa4>
    80001ff8:	1a0c1663          	bnez	s8,800021a4 <__printf+0x44c>
    80001ffc:	08813083          	ld	ra,136(sp)
    80002000:	08013403          	ld	s0,128(sp)
    80002004:	07813483          	ld	s1,120(sp)
    80002008:	07013903          	ld	s2,112(sp)
    8000200c:	06813983          	ld	s3,104(sp)
    80002010:	06013a03          	ld	s4,96(sp)
    80002014:	05813a83          	ld	s5,88(sp)
    80002018:	05013b03          	ld	s6,80(sp)
    8000201c:	04813b83          	ld	s7,72(sp)
    80002020:	04013c03          	ld	s8,64(sp)
    80002024:	03813c83          	ld	s9,56(sp)
    80002028:	03013d03          	ld	s10,48(sp)
    8000202c:	02813d83          	ld	s11,40(sp)
    80002030:	0d010113          	addi	sp,sp,208
    80002034:	00008067          	ret
    80002038:	07300713          	li	a4,115
    8000203c:	1ce78a63          	beq	a5,a4,80002210 <__printf+0x4b8>
    80002040:	07800713          	li	a4,120
    80002044:	1ee79e63          	bne	a5,a4,80002240 <__printf+0x4e8>
    80002048:	f7843783          	ld	a5,-136(s0)
    8000204c:	0007a703          	lw	a4,0(a5)
    80002050:	00878793          	addi	a5,a5,8
    80002054:	f6f43c23          	sd	a5,-136(s0)
    80002058:	28074263          	bltz	a4,800022dc <__printf+0x584>
    8000205c:	00002d97          	auipc	s11,0x2
    80002060:	11cd8d93          	addi	s11,s11,284 # 80004178 <digits>
    80002064:	00f77793          	andi	a5,a4,15
    80002068:	00fd87b3          	add	a5,s11,a5
    8000206c:	0007c683          	lbu	a3,0(a5)
    80002070:	00f00613          	li	a2,15
    80002074:	0007079b          	sext.w	a5,a4
    80002078:	f8d40023          	sb	a3,-128(s0)
    8000207c:	0047559b          	srliw	a1,a4,0x4
    80002080:	0047569b          	srliw	a3,a4,0x4
    80002084:	00000c93          	li	s9,0
    80002088:	0ee65063          	bge	a2,a4,80002168 <__printf+0x410>
    8000208c:	00f6f693          	andi	a3,a3,15
    80002090:	00dd86b3          	add	a3,s11,a3
    80002094:	0006c683          	lbu	a3,0(a3) # 2004000 <_entry-0x7dffc000>
    80002098:	0087d79b          	srliw	a5,a5,0x8
    8000209c:	00100c93          	li	s9,1
    800020a0:	f8d400a3          	sb	a3,-127(s0)
    800020a4:	0cb67263          	bgeu	a2,a1,80002168 <__printf+0x410>
    800020a8:	00f7f693          	andi	a3,a5,15
    800020ac:	00dd86b3          	add	a3,s11,a3
    800020b0:	0006c583          	lbu	a1,0(a3)
    800020b4:	00f00613          	li	a2,15
    800020b8:	0047d69b          	srliw	a3,a5,0x4
    800020bc:	f8b40123          	sb	a1,-126(s0)
    800020c0:	0047d593          	srli	a1,a5,0x4
    800020c4:	28f67e63          	bgeu	a2,a5,80002360 <__printf+0x608>
    800020c8:	00f6f693          	andi	a3,a3,15
    800020cc:	00dd86b3          	add	a3,s11,a3
    800020d0:	0006c503          	lbu	a0,0(a3)
    800020d4:	0087d813          	srli	a6,a5,0x8
    800020d8:	0087d69b          	srliw	a3,a5,0x8
    800020dc:	f8a401a3          	sb	a0,-125(s0)
    800020e0:	28b67663          	bgeu	a2,a1,8000236c <__printf+0x614>
    800020e4:	00f6f693          	andi	a3,a3,15
    800020e8:	00dd86b3          	add	a3,s11,a3
    800020ec:	0006c583          	lbu	a1,0(a3)
    800020f0:	00c7d513          	srli	a0,a5,0xc
    800020f4:	00c7d69b          	srliw	a3,a5,0xc
    800020f8:	f8b40223          	sb	a1,-124(s0)
    800020fc:	29067a63          	bgeu	a2,a6,80002390 <__printf+0x638>
    80002100:	00f6f693          	andi	a3,a3,15
    80002104:	00dd86b3          	add	a3,s11,a3
    80002108:	0006c583          	lbu	a1,0(a3)
    8000210c:	0107d813          	srli	a6,a5,0x10
    80002110:	0107d69b          	srliw	a3,a5,0x10
    80002114:	f8b402a3          	sb	a1,-123(s0)
    80002118:	28a67263          	bgeu	a2,a0,8000239c <__printf+0x644>
    8000211c:	00f6f693          	andi	a3,a3,15
    80002120:	00dd86b3          	add	a3,s11,a3
    80002124:	0006c683          	lbu	a3,0(a3)
    80002128:	0147d79b          	srliw	a5,a5,0x14
    8000212c:	f8d40323          	sb	a3,-122(s0)
    80002130:	21067663          	bgeu	a2,a6,8000233c <__printf+0x5e4>
    80002134:	02079793          	slli	a5,a5,0x20
    80002138:	0207d793          	srli	a5,a5,0x20
    8000213c:	00fd8db3          	add	s11,s11,a5
    80002140:	000dc683          	lbu	a3,0(s11)
    80002144:	00800793          	li	a5,8
    80002148:	00700c93          	li	s9,7
    8000214c:	f8d403a3          	sb	a3,-121(s0)
    80002150:	00075c63          	bgez	a4,80002168 <__printf+0x410>
    80002154:	f9040713          	addi	a4,s0,-112
    80002158:	00f70733          	add	a4,a4,a5
    8000215c:	02d00693          	li	a3,45
    80002160:	fed70823          	sb	a3,-16(a4)
    80002164:	00078c93          	mv	s9,a5
    80002168:	f8040793          	addi	a5,s0,-128
    8000216c:	01978cb3          	add	s9,a5,s9
    80002170:	f7f40d13          	addi	s10,s0,-129
    80002174:	000cc503          	lbu	a0,0(s9)
    80002178:	fffc8c93          	addi	s9,s9,-1
    8000217c:	00000097          	auipc	ra,0x0
    80002180:	9f8080e7          	jalr	-1544(ra) # 80001b74 <consputc>
    80002184:	ff9d18e3          	bne	s10,s9,80002174 <__printf+0x41c>
    80002188:	0100006f          	j	80002198 <__printf+0x440>
    8000218c:	00000097          	auipc	ra,0x0
    80002190:	9e8080e7          	jalr	-1560(ra) # 80001b74 <consputc>
    80002194:	000c8493          	mv	s1,s9
    80002198:	00094503          	lbu	a0,0(s2)
    8000219c:	c60510e3          	bnez	a0,80001dfc <__printf+0xa4>
    800021a0:	e40c0ee3          	beqz	s8,80001ffc <__printf+0x2a4>
    800021a4:	00003517          	auipc	a0,0x3
    800021a8:	2fc50513          	addi	a0,a0,764 # 800054a0 <pr>
    800021ac:	00001097          	auipc	ra,0x1
    800021b0:	94c080e7          	jalr	-1716(ra) # 80002af8 <release>
    800021b4:	e49ff06f          	j	80001ffc <__printf+0x2a4>
    800021b8:	f7843783          	ld	a5,-136(s0)
    800021bc:	03000513          	li	a0,48
    800021c0:	01000d13          	li	s10,16
    800021c4:	00878713          	addi	a4,a5,8
    800021c8:	0007bc83          	ld	s9,0(a5)
    800021cc:	f6e43c23          	sd	a4,-136(s0)
    800021d0:	00000097          	auipc	ra,0x0
    800021d4:	9a4080e7          	jalr	-1628(ra) # 80001b74 <consputc>
    800021d8:	07800513          	li	a0,120
    800021dc:	00000097          	auipc	ra,0x0
    800021e0:	998080e7          	jalr	-1640(ra) # 80001b74 <consputc>
    800021e4:	00002d97          	auipc	s11,0x2
    800021e8:	f94d8d93          	addi	s11,s11,-108 # 80004178 <digits>
    800021ec:	03ccd793          	srli	a5,s9,0x3c
    800021f0:	00fd87b3          	add	a5,s11,a5
    800021f4:	0007c503          	lbu	a0,0(a5)
    800021f8:	fffd0d1b          	addiw	s10,s10,-1
    800021fc:	004c9c93          	slli	s9,s9,0x4
    80002200:	00000097          	auipc	ra,0x0
    80002204:	974080e7          	jalr	-1676(ra) # 80001b74 <consputc>
    80002208:	fe0d12e3          	bnez	s10,800021ec <__printf+0x494>
    8000220c:	f8dff06f          	j	80002198 <__printf+0x440>
    80002210:	f7843783          	ld	a5,-136(s0)
    80002214:	0007bc83          	ld	s9,0(a5)
    80002218:	00878793          	addi	a5,a5,8
    8000221c:	f6f43c23          	sd	a5,-136(s0)
    80002220:	000c9a63          	bnez	s9,80002234 <__printf+0x4dc>
    80002224:	1080006f          	j	8000232c <__printf+0x5d4>
    80002228:	001c8c93          	addi	s9,s9,1
    8000222c:	00000097          	auipc	ra,0x0
    80002230:	948080e7          	jalr	-1720(ra) # 80001b74 <consputc>
    80002234:	000cc503          	lbu	a0,0(s9)
    80002238:	fe0518e3          	bnez	a0,80002228 <__printf+0x4d0>
    8000223c:	f5dff06f          	j	80002198 <__printf+0x440>
    80002240:	02500513          	li	a0,37
    80002244:	00000097          	auipc	ra,0x0
    80002248:	930080e7          	jalr	-1744(ra) # 80001b74 <consputc>
    8000224c:	000c8513          	mv	a0,s9
    80002250:	00000097          	auipc	ra,0x0
    80002254:	924080e7          	jalr	-1756(ra) # 80001b74 <consputc>
    80002258:	f41ff06f          	j	80002198 <__printf+0x440>
    8000225c:	02500513          	li	a0,37
    80002260:	00000097          	auipc	ra,0x0
    80002264:	914080e7          	jalr	-1772(ra) # 80001b74 <consputc>
    80002268:	f31ff06f          	j	80002198 <__printf+0x440>
    8000226c:	00030513          	mv	a0,t1
    80002270:	00000097          	auipc	ra,0x0
    80002274:	7bc080e7          	jalr	1980(ra) # 80002a2c <acquire>
    80002278:	b4dff06f          	j	80001dc4 <__printf+0x6c>
    8000227c:	40c0053b          	negw	a0,a2
    80002280:	00a00713          	li	a4,10
    80002284:	02e576bb          	remuw	a3,a0,a4
    80002288:	00002d97          	auipc	s11,0x2
    8000228c:	ef0d8d93          	addi	s11,s11,-272 # 80004178 <digits>
    80002290:	ff700593          	li	a1,-9
    80002294:	02069693          	slli	a3,a3,0x20
    80002298:	0206d693          	srli	a3,a3,0x20
    8000229c:	00dd86b3          	add	a3,s11,a3
    800022a0:	0006c683          	lbu	a3,0(a3)
    800022a4:	02e557bb          	divuw	a5,a0,a4
    800022a8:	f8d40023          	sb	a3,-128(s0)
    800022ac:	10b65e63          	bge	a2,a1,800023c8 <__printf+0x670>
    800022b0:	06300593          	li	a1,99
    800022b4:	02e7f6bb          	remuw	a3,a5,a4
    800022b8:	02069693          	slli	a3,a3,0x20
    800022bc:	0206d693          	srli	a3,a3,0x20
    800022c0:	00dd86b3          	add	a3,s11,a3
    800022c4:	0006c683          	lbu	a3,0(a3)
    800022c8:	02e7d73b          	divuw	a4,a5,a4
    800022cc:	00200793          	li	a5,2
    800022d0:	f8d400a3          	sb	a3,-127(s0)
    800022d4:	bca5ece3          	bltu	a1,a0,80001eac <__printf+0x154>
    800022d8:	ce5ff06f          	j	80001fbc <__printf+0x264>
    800022dc:	40e007bb          	negw	a5,a4
    800022e0:	00002d97          	auipc	s11,0x2
    800022e4:	e98d8d93          	addi	s11,s11,-360 # 80004178 <digits>
    800022e8:	00f7f693          	andi	a3,a5,15
    800022ec:	00dd86b3          	add	a3,s11,a3
    800022f0:	0006c583          	lbu	a1,0(a3)
    800022f4:	ff100613          	li	a2,-15
    800022f8:	0047d69b          	srliw	a3,a5,0x4
    800022fc:	f8b40023          	sb	a1,-128(s0)
    80002300:	0047d59b          	srliw	a1,a5,0x4
    80002304:	0ac75e63          	bge	a4,a2,800023c0 <__printf+0x668>
    80002308:	00f6f693          	andi	a3,a3,15
    8000230c:	00dd86b3          	add	a3,s11,a3
    80002310:	0006c603          	lbu	a2,0(a3)
    80002314:	00f00693          	li	a3,15
    80002318:	0087d79b          	srliw	a5,a5,0x8
    8000231c:	f8c400a3          	sb	a2,-127(s0)
    80002320:	d8b6e4e3          	bltu	a3,a1,800020a8 <__printf+0x350>
    80002324:	00200793          	li	a5,2
    80002328:	e2dff06f          	j	80002154 <__printf+0x3fc>
    8000232c:	00002c97          	auipc	s9,0x2
    80002330:	e2cc8c93          	addi	s9,s9,-468 # 80004158 <CONSOLE_STATUS+0x148>
    80002334:	02800513          	li	a0,40
    80002338:	ef1ff06f          	j	80002228 <__printf+0x4d0>
    8000233c:	00700793          	li	a5,7
    80002340:	00600c93          	li	s9,6
    80002344:	e0dff06f          	j	80002150 <__printf+0x3f8>
    80002348:	00700793          	li	a5,7
    8000234c:	00600c93          	li	s9,6
    80002350:	c69ff06f          	j	80001fb8 <__printf+0x260>
    80002354:	00300793          	li	a5,3
    80002358:	00200c93          	li	s9,2
    8000235c:	c5dff06f          	j	80001fb8 <__printf+0x260>
    80002360:	00300793          	li	a5,3
    80002364:	00200c93          	li	s9,2
    80002368:	de9ff06f          	j	80002150 <__printf+0x3f8>
    8000236c:	00400793          	li	a5,4
    80002370:	00300c93          	li	s9,3
    80002374:	dddff06f          	j	80002150 <__printf+0x3f8>
    80002378:	00400793          	li	a5,4
    8000237c:	00300c93          	li	s9,3
    80002380:	c39ff06f          	j	80001fb8 <__printf+0x260>
    80002384:	00500793          	li	a5,5
    80002388:	00400c93          	li	s9,4
    8000238c:	c2dff06f          	j	80001fb8 <__printf+0x260>
    80002390:	00500793          	li	a5,5
    80002394:	00400c93          	li	s9,4
    80002398:	db9ff06f          	j	80002150 <__printf+0x3f8>
    8000239c:	00600793          	li	a5,6
    800023a0:	00500c93          	li	s9,5
    800023a4:	dadff06f          	j	80002150 <__printf+0x3f8>
    800023a8:	00600793          	li	a5,6
    800023ac:	00500c93          	li	s9,5
    800023b0:	c09ff06f          	j	80001fb8 <__printf+0x260>
    800023b4:	00800793          	li	a5,8
    800023b8:	00700c93          	li	s9,7
    800023bc:	bfdff06f          	j	80001fb8 <__printf+0x260>
    800023c0:	00100793          	li	a5,1
    800023c4:	d91ff06f          	j	80002154 <__printf+0x3fc>
    800023c8:	00100793          	li	a5,1
    800023cc:	bf1ff06f          	j	80001fbc <__printf+0x264>
    800023d0:	00900793          	li	a5,9
    800023d4:	00800c93          	li	s9,8
    800023d8:	be1ff06f          	j	80001fb8 <__printf+0x260>
    800023dc:	00002517          	auipc	a0,0x2
    800023e0:	d8450513          	addi	a0,a0,-636 # 80004160 <CONSOLE_STATUS+0x150>
    800023e4:	00000097          	auipc	ra,0x0
    800023e8:	918080e7          	jalr	-1768(ra) # 80001cfc <panic>

00000000800023ec <printfinit>:
    800023ec:	fe010113          	addi	sp,sp,-32
    800023f0:	00813823          	sd	s0,16(sp)
    800023f4:	00913423          	sd	s1,8(sp)
    800023f8:	00113c23          	sd	ra,24(sp)
    800023fc:	02010413          	addi	s0,sp,32
    80002400:	00003497          	auipc	s1,0x3
    80002404:	0a048493          	addi	s1,s1,160 # 800054a0 <pr>
    80002408:	00048513          	mv	a0,s1
    8000240c:	00002597          	auipc	a1,0x2
    80002410:	d6458593          	addi	a1,a1,-668 # 80004170 <CONSOLE_STATUS+0x160>
    80002414:	00000097          	auipc	ra,0x0
    80002418:	5f4080e7          	jalr	1524(ra) # 80002a08 <initlock>
    8000241c:	01813083          	ld	ra,24(sp)
    80002420:	01013403          	ld	s0,16(sp)
    80002424:	0004ac23          	sw	zero,24(s1)
    80002428:	00813483          	ld	s1,8(sp)
    8000242c:	02010113          	addi	sp,sp,32
    80002430:	00008067          	ret

0000000080002434 <uartinit>:
    80002434:	ff010113          	addi	sp,sp,-16
    80002438:	00813423          	sd	s0,8(sp)
    8000243c:	01010413          	addi	s0,sp,16
    80002440:	100007b7          	lui	a5,0x10000
    80002444:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>
    80002448:	f8000713          	li	a4,-128
    8000244c:	00e781a3          	sb	a4,3(a5)
    80002450:	00300713          	li	a4,3
    80002454:	00e78023          	sb	a4,0(a5)
    80002458:	000780a3          	sb	zero,1(a5)
    8000245c:	00e781a3          	sb	a4,3(a5)
    80002460:	00700693          	li	a3,7
    80002464:	00d78123          	sb	a3,2(a5)
    80002468:	00e780a3          	sb	a4,1(a5)
    8000246c:	00813403          	ld	s0,8(sp)
    80002470:	01010113          	addi	sp,sp,16
    80002474:	00008067          	ret

0000000080002478 <uartputc>:
    80002478:	00002797          	auipc	a5,0x2
    8000247c:	de07a783          	lw	a5,-544(a5) # 80004258 <panicked>
    80002480:	00078463          	beqz	a5,80002488 <uartputc+0x10>
    80002484:	0000006f          	j	80002484 <uartputc+0xc>
    80002488:	fd010113          	addi	sp,sp,-48
    8000248c:	02813023          	sd	s0,32(sp)
    80002490:	00913c23          	sd	s1,24(sp)
    80002494:	01213823          	sd	s2,16(sp)
    80002498:	01313423          	sd	s3,8(sp)
    8000249c:	02113423          	sd	ra,40(sp)
    800024a0:	03010413          	addi	s0,sp,48
    800024a4:	00002917          	auipc	s2,0x2
    800024a8:	dbc90913          	addi	s2,s2,-580 # 80004260 <uart_tx_r>
    800024ac:	00093783          	ld	a5,0(s2)
    800024b0:	00002497          	auipc	s1,0x2
    800024b4:	db848493          	addi	s1,s1,-584 # 80004268 <uart_tx_w>
    800024b8:	0004b703          	ld	a4,0(s1)
    800024bc:	02078693          	addi	a3,a5,32
    800024c0:	00050993          	mv	s3,a0
    800024c4:	02e69c63          	bne	a3,a4,800024fc <uartputc+0x84>
    800024c8:	00001097          	auipc	ra,0x1
    800024cc:	834080e7          	jalr	-1996(ra) # 80002cfc <push_on>
    800024d0:	00093783          	ld	a5,0(s2)
    800024d4:	0004b703          	ld	a4,0(s1)
    800024d8:	02078793          	addi	a5,a5,32
    800024dc:	00e79463          	bne	a5,a4,800024e4 <uartputc+0x6c>
    800024e0:	0000006f          	j	800024e0 <uartputc+0x68>
    800024e4:	00001097          	auipc	ra,0x1
    800024e8:	88c080e7          	jalr	-1908(ra) # 80002d70 <pop_on>
    800024ec:	00093783          	ld	a5,0(s2)
    800024f0:	0004b703          	ld	a4,0(s1)
    800024f4:	02078693          	addi	a3,a5,32
    800024f8:	fce688e3          	beq	a3,a4,800024c8 <uartputc+0x50>
    800024fc:	01f77693          	andi	a3,a4,31
    80002500:	00003597          	auipc	a1,0x3
    80002504:	fc058593          	addi	a1,a1,-64 # 800054c0 <uart_tx_buf>
    80002508:	00d586b3          	add	a3,a1,a3
    8000250c:	00170713          	addi	a4,a4,1
    80002510:	01368023          	sb	s3,0(a3)
    80002514:	00e4b023          	sd	a4,0(s1)
    80002518:	10000637          	lui	a2,0x10000
    8000251c:	02f71063          	bne	a4,a5,8000253c <uartputc+0xc4>
    80002520:	0340006f          	j	80002554 <uartputc+0xdc>
    80002524:	00074703          	lbu	a4,0(a4)
    80002528:	00f93023          	sd	a5,0(s2)
    8000252c:	00e60023          	sb	a4,0(a2) # 10000000 <_entry-0x70000000>
    80002530:	00093783          	ld	a5,0(s2)
    80002534:	0004b703          	ld	a4,0(s1)
    80002538:	00f70e63          	beq	a4,a5,80002554 <uartputc+0xdc>
    8000253c:	00564683          	lbu	a3,5(a2)
    80002540:	01f7f713          	andi	a4,a5,31
    80002544:	00e58733          	add	a4,a1,a4
    80002548:	0206f693          	andi	a3,a3,32
    8000254c:	00178793          	addi	a5,a5,1
    80002550:	fc069ae3          	bnez	a3,80002524 <uartputc+0xac>
    80002554:	02813083          	ld	ra,40(sp)
    80002558:	02013403          	ld	s0,32(sp)
    8000255c:	01813483          	ld	s1,24(sp)
    80002560:	01013903          	ld	s2,16(sp)
    80002564:	00813983          	ld	s3,8(sp)
    80002568:	03010113          	addi	sp,sp,48
    8000256c:	00008067          	ret

0000000080002570 <uartputc_sync>:
    80002570:	ff010113          	addi	sp,sp,-16
    80002574:	00813423          	sd	s0,8(sp)
    80002578:	01010413          	addi	s0,sp,16
    8000257c:	00002717          	auipc	a4,0x2
    80002580:	cdc72703          	lw	a4,-804(a4) # 80004258 <panicked>
    80002584:	02071663          	bnez	a4,800025b0 <uartputc_sync+0x40>
    80002588:	00050793          	mv	a5,a0
    8000258c:	100006b7          	lui	a3,0x10000
    80002590:	0056c703          	lbu	a4,5(a3) # 10000005 <_entry-0x6ffffffb>
    80002594:	02077713          	andi	a4,a4,32
    80002598:	fe070ce3          	beqz	a4,80002590 <uartputc_sync+0x20>
    8000259c:	0ff7f793          	andi	a5,a5,255
    800025a0:	00f68023          	sb	a5,0(a3)
    800025a4:	00813403          	ld	s0,8(sp)
    800025a8:	01010113          	addi	sp,sp,16
    800025ac:	00008067          	ret
    800025b0:	0000006f          	j	800025b0 <uartputc_sync+0x40>

00000000800025b4 <uartstart>:
    800025b4:	ff010113          	addi	sp,sp,-16
    800025b8:	00813423          	sd	s0,8(sp)
    800025bc:	01010413          	addi	s0,sp,16
    800025c0:	00002617          	auipc	a2,0x2
    800025c4:	ca060613          	addi	a2,a2,-864 # 80004260 <uart_tx_r>
    800025c8:	00002517          	auipc	a0,0x2
    800025cc:	ca050513          	addi	a0,a0,-864 # 80004268 <uart_tx_w>
    800025d0:	00063783          	ld	a5,0(a2)
    800025d4:	00053703          	ld	a4,0(a0)
    800025d8:	04f70263          	beq	a4,a5,8000261c <uartstart+0x68>
    800025dc:	100005b7          	lui	a1,0x10000
    800025e0:	00003817          	auipc	a6,0x3
    800025e4:	ee080813          	addi	a6,a6,-288 # 800054c0 <uart_tx_buf>
    800025e8:	01c0006f          	j	80002604 <uartstart+0x50>
    800025ec:	0006c703          	lbu	a4,0(a3)
    800025f0:	00f63023          	sd	a5,0(a2)
    800025f4:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800025f8:	00063783          	ld	a5,0(a2)
    800025fc:	00053703          	ld	a4,0(a0)
    80002600:	00f70e63          	beq	a4,a5,8000261c <uartstart+0x68>
    80002604:	01f7f713          	andi	a4,a5,31
    80002608:	00e806b3          	add	a3,a6,a4
    8000260c:	0055c703          	lbu	a4,5(a1)
    80002610:	00178793          	addi	a5,a5,1
    80002614:	02077713          	andi	a4,a4,32
    80002618:	fc071ae3          	bnez	a4,800025ec <uartstart+0x38>
    8000261c:	00813403          	ld	s0,8(sp)
    80002620:	01010113          	addi	sp,sp,16
    80002624:	00008067          	ret

0000000080002628 <uartgetc>:
    80002628:	ff010113          	addi	sp,sp,-16
    8000262c:	00813423          	sd	s0,8(sp)
    80002630:	01010413          	addi	s0,sp,16
    80002634:	10000737          	lui	a4,0x10000
    80002638:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000263c:	0017f793          	andi	a5,a5,1
    80002640:	00078c63          	beqz	a5,80002658 <uartgetc+0x30>
    80002644:	00074503          	lbu	a0,0(a4)
    80002648:	0ff57513          	andi	a0,a0,255
    8000264c:	00813403          	ld	s0,8(sp)
    80002650:	01010113          	addi	sp,sp,16
    80002654:	00008067          	ret
    80002658:	fff00513          	li	a0,-1
    8000265c:	ff1ff06f          	j	8000264c <uartgetc+0x24>

0000000080002660 <uartintr>:
    80002660:	100007b7          	lui	a5,0x10000
    80002664:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80002668:	0017f793          	andi	a5,a5,1
    8000266c:	0a078463          	beqz	a5,80002714 <uartintr+0xb4>
    80002670:	fe010113          	addi	sp,sp,-32
    80002674:	00813823          	sd	s0,16(sp)
    80002678:	00913423          	sd	s1,8(sp)
    8000267c:	00113c23          	sd	ra,24(sp)
    80002680:	02010413          	addi	s0,sp,32
    80002684:	100004b7          	lui	s1,0x10000
    80002688:	0004c503          	lbu	a0,0(s1) # 10000000 <_entry-0x70000000>
    8000268c:	0ff57513          	andi	a0,a0,255
    80002690:	fffff097          	auipc	ra,0xfffff
    80002694:	534080e7          	jalr	1332(ra) # 80001bc4 <consoleintr>
    80002698:	0054c783          	lbu	a5,5(s1)
    8000269c:	0017f793          	andi	a5,a5,1
    800026a0:	fe0794e3          	bnez	a5,80002688 <uartintr+0x28>
    800026a4:	00002617          	auipc	a2,0x2
    800026a8:	bbc60613          	addi	a2,a2,-1092 # 80004260 <uart_tx_r>
    800026ac:	00002517          	auipc	a0,0x2
    800026b0:	bbc50513          	addi	a0,a0,-1092 # 80004268 <uart_tx_w>
    800026b4:	00063783          	ld	a5,0(a2)
    800026b8:	00053703          	ld	a4,0(a0)
    800026bc:	04f70263          	beq	a4,a5,80002700 <uartintr+0xa0>
    800026c0:	100005b7          	lui	a1,0x10000
    800026c4:	00003817          	auipc	a6,0x3
    800026c8:	dfc80813          	addi	a6,a6,-516 # 800054c0 <uart_tx_buf>
    800026cc:	01c0006f          	j	800026e8 <uartintr+0x88>
    800026d0:	0006c703          	lbu	a4,0(a3)
    800026d4:	00f63023          	sd	a5,0(a2)
    800026d8:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    800026dc:	00063783          	ld	a5,0(a2)
    800026e0:	00053703          	ld	a4,0(a0)
    800026e4:	00f70e63          	beq	a4,a5,80002700 <uartintr+0xa0>
    800026e8:	01f7f713          	andi	a4,a5,31
    800026ec:	00e806b3          	add	a3,a6,a4
    800026f0:	0055c703          	lbu	a4,5(a1)
    800026f4:	00178793          	addi	a5,a5,1
    800026f8:	02077713          	andi	a4,a4,32
    800026fc:	fc071ae3          	bnez	a4,800026d0 <uartintr+0x70>
    80002700:	01813083          	ld	ra,24(sp)
    80002704:	01013403          	ld	s0,16(sp)
    80002708:	00813483          	ld	s1,8(sp)
    8000270c:	02010113          	addi	sp,sp,32
    80002710:	00008067          	ret
    80002714:	00002617          	auipc	a2,0x2
    80002718:	b4c60613          	addi	a2,a2,-1204 # 80004260 <uart_tx_r>
    8000271c:	00002517          	auipc	a0,0x2
    80002720:	b4c50513          	addi	a0,a0,-1204 # 80004268 <uart_tx_w>
    80002724:	00063783          	ld	a5,0(a2)
    80002728:	00053703          	ld	a4,0(a0)
    8000272c:	04f70263          	beq	a4,a5,80002770 <uartintr+0x110>
    80002730:	100005b7          	lui	a1,0x10000
    80002734:	00003817          	auipc	a6,0x3
    80002738:	d8c80813          	addi	a6,a6,-628 # 800054c0 <uart_tx_buf>
    8000273c:	01c0006f          	j	80002758 <uartintr+0xf8>
    80002740:	0006c703          	lbu	a4,0(a3)
    80002744:	00f63023          	sd	a5,0(a2)
    80002748:	00e58023          	sb	a4,0(a1) # 10000000 <_entry-0x70000000>
    8000274c:	00063783          	ld	a5,0(a2)
    80002750:	00053703          	ld	a4,0(a0)
    80002754:	02f70063          	beq	a4,a5,80002774 <uartintr+0x114>
    80002758:	01f7f713          	andi	a4,a5,31
    8000275c:	00e806b3          	add	a3,a6,a4
    80002760:	0055c703          	lbu	a4,5(a1)
    80002764:	00178793          	addi	a5,a5,1
    80002768:	02077713          	andi	a4,a4,32
    8000276c:	fc071ae3          	bnez	a4,80002740 <uartintr+0xe0>
    80002770:	00008067          	ret
    80002774:	00008067          	ret

0000000080002778 <kinit>:
    80002778:	fc010113          	addi	sp,sp,-64
    8000277c:	02913423          	sd	s1,40(sp)
    80002780:	fffff7b7          	lui	a5,0xfffff
    80002784:	00004497          	auipc	s1,0x4
    80002788:	d5b48493          	addi	s1,s1,-677 # 800064df <end+0xfff>
    8000278c:	02813823          	sd	s0,48(sp)
    80002790:	01313c23          	sd	s3,24(sp)
    80002794:	00f4f4b3          	and	s1,s1,a5
    80002798:	02113c23          	sd	ra,56(sp)
    8000279c:	03213023          	sd	s2,32(sp)
    800027a0:	01413823          	sd	s4,16(sp)
    800027a4:	01513423          	sd	s5,8(sp)
    800027a8:	04010413          	addi	s0,sp,64
    800027ac:	000017b7          	lui	a5,0x1
    800027b0:	01100993          	li	s3,17
    800027b4:	00f487b3          	add	a5,s1,a5
    800027b8:	01b99993          	slli	s3,s3,0x1b
    800027bc:	06f9e063          	bltu	s3,a5,8000281c <kinit+0xa4>
    800027c0:	00003a97          	auipc	s5,0x3
    800027c4:	d20a8a93          	addi	s5,s5,-736 # 800054e0 <end>
    800027c8:	0754ec63          	bltu	s1,s5,80002840 <kinit+0xc8>
    800027cc:	0734fa63          	bgeu	s1,s3,80002840 <kinit+0xc8>
    800027d0:	00088a37          	lui	s4,0x88
    800027d4:	fffa0a13          	addi	s4,s4,-1 # 87fff <_entry-0x7ff78001>
    800027d8:	00002917          	auipc	s2,0x2
    800027dc:	a9890913          	addi	s2,s2,-1384 # 80004270 <kmem>
    800027e0:	00ca1a13          	slli	s4,s4,0xc
    800027e4:	0140006f          	j	800027f8 <kinit+0x80>
    800027e8:	000017b7          	lui	a5,0x1
    800027ec:	00f484b3          	add	s1,s1,a5
    800027f0:	0554e863          	bltu	s1,s5,80002840 <kinit+0xc8>
    800027f4:	0534f663          	bgeu	s1,s3,80002840 <kinit+0xc8>
    800027f8:	00001637          	lui	a2,0x1
    800027fc:	00100593          	li	a1,1
    80002800:	00048513          	mv	a0,s1
    80002804:	00000097          	auipc	ra,0x0
    80002808:	5e4080e7          	jalr	1508(ra) # 80002de8 <__memset>
    8000280c:	00093783          	ld	a5,0(s2)
    80002810:	00f4b023          	sd	a5,0(s1)
    80002814:	00993023          	sd	s1,0(s2)
    80002818:	fd4498e3          	bne	s1,s4,800027e8 <kinit+0x70>
    8000281c:	03813083          	ld	ra,56(sp)
    80002820:	03013403          	ld	s0,48(sp)
    80002824:	02813483          	ld	s1,40(sp)
    80002828:	02013903          	ld	s2,32(sp)
    8000282c:	01813983          	ld	s3,24(sp)
    80002830:	01013a03          	ld	s4,16(sp)
    80002834:	00813a83          	ld	s5,8(sp)
    80002838:	04010113          	addi	sp,sp,64
    8000283c:	00008067          	ret
    80002840:	00002517          	auipc	a0,0x2
    80002844:	95050513          	addi	a0,a0,-1712 # 80004190 <digits+0x18>
    80002848:	fffff097          	auipc	ra,0xfffff
    8000284c:	4b4080e7          	jalr	1204(ra) # 80001cfc <panic>

0000000080002850 <freerange>:
    80002850:	fc010113          	addi	sp,sp,-64
    80002854:	000017b7          	lui	a5,0x1
    80002858:	02913423          	sd	s1,40(sp)
    8000285c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80002860:	009504b3          	add	s1,a0,s1
    80002864:	fffff537          	lui	a0,0xfffff
    80002868:	02813823          	sd	s0,48(sp)
    8000286c:	02113c23          	sd	ra,56(sp)
    80002870:	03213023          	sd	s2,32(sp)
    80002874:	01313c23          	sd	s3,24(sp)
    80002878:	01413823          	sd	s4,16(sp)
    8000287c:	01513423          	sd	s5,8(sp)
    80002880:	01613023          	sd	s6,0(sp)
    80002884:	04010413          	addi	s0,sp,64
    80002888:	00a4f4b3          	and	s1,s1,a0
    8000288c:	00f487b3          	add	a5,s1,a5
    80002890:	06f5e463          	bltu	a1,a5,800028f8 <freerange+0xa8>
    80002894:	00003a97          	auipc	s5,0x3
    80002898:	c4ca8a93          	addi	s5,s5,-948 # 800054e0 <end>
    8000289c:	0954e263          	bltu	s1,s5,80002920 <freerange+0xd0>
    800028a0:	01100993          	li	s3,17
    800028a4:	01b99993          	slli	s3,s3,0x1b
    800028a8:	0734fc63          	bgeu	s1,s3,80002920 <freerange+0xd0>
    800028ac:	00058a13          	mv	s4,a1
    800028b0:	00002917          	auipc	s2,0x2
    800028b4:	9c090913          	addi	s2,s2,-1600 # 80004270 <kmem>
    800028b8:	00002b37          	lui	s6,0x2
    800028bc:	0140006f          	j	800028d0 <freerange+0x80>
    800028c0:	000017b7          	lui	a5,0x1
    800028c4:	00f484b3          	add	s1,s1,a5
    800028c8:	0554ec63          	bltu	s1,s5,80002920 <freerange+0xd0>
    800028cc:	0534fa63          	bgeu	s1,s3,80002920 <freerange+0xd0>
    800028d0:	00001637          	lui	a2,0x1
    800028d4:	00100593          	li	a1,1
    800028d8:	00048513          	mv	a0,s1
    800028dc:	00000097          	auipc	ra,0x0
    800028e0:	50c080e7          	jalr	1292(ra) # 80002de8 <__memset>
    800028e4:	00093703          	ld	a4,0(s2)
    800028e8:	016487b3          	add	a5,s1,s6
    800028ec:	00e4b023          	sd	a4,0(s1)
    800028f0:	00993023          	sd	s1,0(s2)
    800028f4:	fcfa76e3          	bgeu	s4,a5,800028c0 <freerange+0x70>
    800028f8:	03813083          	ld	ra,56(sp)
    800028fc:	03013403          	ld	s0,48(sp)
    80002900:	02813483          	ld	s1,40(sp)
    80002904:	02013903          	ld	s2,32(sp)
    80002908:	01813983          	ld	s3,24(sp)
    8000290c:	01013a03          	ld	s4,16(sp)
    80002910:	00813a83          	ld	s5,8(sp)
    80002914:	00013b03          	ld	s6,0(sp)
    80002918:	04010113          	addi	sp,sp,64
    8000291c:	00008067          	ret
    80002920:	00002517          	auipc	a0,0x2
    80002924:	87050513          	addi	a0,a0,-1936 # 80004190 <digits+0x18>
    80002928:	fffff097          	auipc	ra,0xfffff
    8000292c:	3d4080e7          	jalr	980(ra) # 80001cfc <panic>

0000000080002930 <kfree>:
    80002930:	fe010113          	addi	sp,sp,-32
    80002934:	00813823          	sd	s0,16(sp)
    80002938:	00113c23          	sd	ra,24(sp)
    8000293c:	00913423          	sd	s1,8(sp)
    80002940:	02010413          	addi	s0,sp,32
    80002944:	03451793          	slli	a5,a0,0x34
    80002948:	04079c63          	bnez	a5,800029a0 <kfree+0x70>
    8000294c:	00003797          	auipc	a5,0x3
    80002950:	b9478793          	addi	a5,a5,-1132 # 800054e0 <end>
    80002954:	00050493          	mv	s1,a0
    80002958:	04f56463          	bltu	a0,a5,800029a0 <kfree+0x70>
    8000295c:	01100793          	li	a5,17
    80002960:	01b79793          	slli	a5,a5,0x1b
    80002964:	02f57e63          	bgeu	a0,a5,800029a0 <kfree+0x70>
    80002968:	00001637          	lui	a2,0x1
    8000296c:	00100593          	li	a1,1
    80002970:	00000097          	auipc	ra,0x0
    80002974:	478080e7          	jalr	1144(ra) # 80002de8 <__memset>
    80002978:	00002797          	auipc	a5,0x2
    8000297c:	8f878793          	addi	a5,a5,-1800 # 80004270 <kmem>
    80002980:	0007b703          	ld	a4,0(a5)
    80002984:	01813083          	ld	ra,24(sp)
    80002988:	01013403          	ld	s0,16(sp)
    8000298c:	00e4b023          	sd	a4,0(s1)
    80002990:	0097b023          	sd	s1,0(a5)
    80002994:	00813483          	ld	s1,8(sp)
    80002998:	02010113          	addi	sp,sp,32
    8000299c:	00008067          	ret
    800029a0:	00001517          	auipc	a0,0x1
    800029a4:	7f050513          	addi	a0,a0,2032 # 80004190 <digits+0x18>
    800029a8:	fffff097          	auipc	ra,0xfffff
    800029ac:	354080e7          	jalr	852(ra) # 80001cfc <panic>

00000000800029b0 <kalloc>:
    800029b0:	fe010113          	addi	sp,sp,-32
    800029b4:	00813823          	sd	s0,16(sp)
    800029b8:	00913423          	sd	s1,8(sp)
    800029bc:	00113c23          	sd	ra,24(sp)
    800029c0:	02010413          	addi	s0,sp,32
    800029c4:	00002797          	auipc	a5,0x2
    800029c8:	8ac78793          	addi	a5,a5,-1876 # 80004270 <kmem>
    800029cc:	0007b483          	ld	s1,0(a5)
    800029d0:	02048063          	beqz	s1,800029f0 <kalloc+0x40>
    800029d4:	0004b703          	ld	a4,0(s1)
    800029d8:	00001637          	lui	a2,0x1
    800029dc:	00500593          	li	a1,5
    800029e0:	00048513          	mv	a0,s1
    800029e4:	00e7b023          	sd	a4,0(a5)
    800029e8:	00000097          	auipc	ra,0x0
    800029ec:	400080e7          	jalr	1024(ra) # 80002de8 <__memset>
    800029f0:	01813083          	ld	ra,24(sp)
    800029f4:	01013403          	ld	s0,16(sp)
    800029f8:	00048513          	mv	a0,s1
    800029fc:	00813483          	ld	s1,8(sp)
    80002a00:	02010113          	addi	sp,sp,32
    80002a04:	00008067          	ret

0000000080002a08 <initlock>:
    80002a08:	ff010113          	addi	sp,sp,-16
    80002a0c:	00813423          	sd	s0,8(sp)
    80002a10:	01010413          	addi	s0,sp,16
    80002a14:	00813403          	ld	s0,8(sp)
    80002a18:	00b53423          	sd	a1,8(a0)
    80002a1c:	00052023          	sw	zero,0(a0)
    80002a20:	00053823          	sd	zero,16(a0)
    80002a24:	01010113          	addi	sp,sp,16
    80002a28:	00008067          	ret

0000000080002a2c <acquire>:
    80002a2c:	fe010113          	addi	sp,sp,-32
    80002a30:	00813823          	sd	s0,16(sp)
    80002a34:	00913423          	sd	s1,8(sp)
    80002a38:	00113c23          	sd	ra,24(sp)
    80002a3c:	01213023          	sd	s2,0(sp)
    80002a40:	02010413          	addi	s0,sp,32
    80002a44:	00050493          	mv	s1,a0
    80002a48:	10002973          	csrr	s2,sstatus
    80002a4c:	100027f3          	csrr	a5,sstatus
    80002a50:	ffd7f793          	andi	a5,a5,-3
    80002a54:	10079073          	csrw	sstatus,a5
    80002a58:	fffff097          	auipc	ra,0xfffff
    80002a5c:	8e0080e7          	jalr	-1824(ra) # 80001338 <mycpu>
    80002a60:	07852783          	lw	a5,120(a0)
    80002a64:	06078e63          	beqz	a5,80002ae0 <acquire+0xb4>
    80002a68:	fffff097          	auipc	ra,0xfffff
    80002a6c:	8d0080e7          	jalr	-1840(ra) # 80001338 <mycpu>
    80002a70:	07852783          	lw	a5,120(a0)
    80002a74:	0004a703          	lw	a4,0(s1)
    80002a78:	0017879b          	addiw	a5,a5,1
    80002a7c:	06f52c23          	sw	a5,120(a0)
    80002a80:	04071063          	bnez	a4,80002ac0 <acquire+0x94>
    80002a84:	00100713          	li	a4,1
    80002a88:	00070793          	mv	a5,a4
    80002a8c:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80002a90:	0007879b          	sext.w	a5,a5
    80002a94:	fe079ae3          	bnez	a5,80002a88 <acquire+0x5c>
    80002a98:	0ff0000f          	fence
    80002a9c:	fffff097          	auipc	ra,0xfffff
    80002aa0:	89c080e7          	jalr	-1892(ra) # 80001338 <mycpu>
    80002aa4:	01813083          	ld	ra,24(sp)
    80002aa8:	01013403          	ld	s0,16(sp)
    80002aac:	00a4b823          	sd	a0,16(s1)
    80002ab0:	00013903          	ld	s2,0(sp)
    80002ab4:	00813483          	ld	s1,8(sp)
    80002ab8:	02010113          	addi	sp,sp,32
    80002abc:	00008067          	ret
    80002ac0:	0104b903          	ld	s2,16(s1)
    80002ac4:	fffff097          	auipc	ra,0xfffff
    80002ac8:	874080e7          	jalr	-1932(ra) # 80001338 <mycpu>
    80002acc:	faa91ce3          	bne	s2,a0,80002a84 <acquire+0x58>
    80002ad0:	00001517          	auipc	a0,0x1
    80002ad4:	6c850513          	addi	a0,a0,1736 # 80004198 <digits+0x20>
    80002ad8:	fffff097          	auipc	ra,0xfffff
    80002adc:	224080e7          	jalr	548(ra) # 80001cfc <panic>
    80002ae0:	00195913          	srli	s2,s2,0x1
    80002ae4:	fffff097          	auipc	ra,0xfffff
    80002ae8:	854080e7          	jalr	-1964(ra) # 80001338 <mycpu>
    80002aec:	00197913          	andi	s2,s2,1
    80002af0:	07252e23          	sw	s2,124(a0)
    80002af4:	f75ff06f          	j	80002a68 <acquire+0x3c>

0000000080002af8 <release>:
    80002af8:	fe010113          	addi	sp,sp,-32
    80002afc:	00813823          	sd	s0,16(sp)
    80002b00:	00113c23          	sd	ra,24(sp)
    80002b04:	00913423          	sd	s1,8(sp)
    80002b08:	01213023          	sd	s2,0(sp)
    80002b0c:	02010413          	addi	s0,sp,32
    80002b10:	00052783          	lw	a5,0(a0)
    80002b14:	00079a63          	bnez	a5,80002b28 <release+0x30>
    80002b18:	00001517          	auipc	a0,0x1
    80002b1c:	68850513          	addi	a0,a0,1672 # 800041a0 <digits+0x28>
    80002b20:	fffff097          	auipc	ra,0xfffff
    80002b24:	1dc080e7          	jalr	476(ra) # 80001cfc <panic>
    80002b28:	01053903          	ld	s2,16(a0)
    80002b2c:	00050493          	mv	s1,a0
    80002b30:	fffff097          	auipc	ra,0xfffff
    80002b34:	808080e7          	jalr	-2040(ra) # 80001338 <mycpu>
    80002b38:	fea910e3          	bne	s2,a0,80002b18 <release+0x20>
    80002b3c:	0004b823          	sd	zero,16(s1)
    80002b40:	0ff0000f          	fence
    80002b44:	0f50000f          	fence	iorw,ow
    80002b48:	0804a02f          	amoswap.w	zero,zero,(s1)
    80002b4c:	ffffe097          	auipc	ra,0xffffe
    80002b50:	7ec080e7          	jalr	2028(ra) # 80001338 <mycpu>
    80002b54:	100027f3          	csrr	a5,sstatus
    80002b58:	0027f793          	andi	a5,a5,2
    80002b5c:	04079a63          	bnez	a5,80002bb0 <release+0xb8>
    80002b60:	07852783          	lw	a5,120(a0)
    80002b64:	02f05e63          	blez	a5,80002ba0 <release+0xa8>
    80002b68:	fff7871b          	addiw	a4,a5,-1
    80002b6c:	06e52c23          	sw	a4,120(a0)
    80002b70:	00071c63          	bnez	a4,80002b88 <release+0x90>
    80002b74:	07c52783          	lw	a5,124(a0)
    80002b78:	00078863          	beqz	a5,80002b88 <release+0x90>
    80002b7c:	100027f3          	csrr	a5,sstatus
    80002b80:	0027e793          	ori	a5,a5,2
    80002b84:	10079073          	csrw	sstatus,a5
    80002b88:	01813083          	ld	ra,24(sp)
    80002b8c:	01013403          	ld	s0,16(sp)
    80002b90:	00813483          	ld	s1,8(sp)
    80002b94:	00013903          	ld	s2,0(sp)
    80002b98:	02010113          	addi	sp,sp,32
    80002b9c:	00008067          	ret
    80002ba0:	00001517          	auipc	a0,0x1
    80002ba4:	62050513          	addi	a0,a0,1568 # 800041c0 <digits+0x48>
    80002ba8:	fffff097          	auipc	ra,0xfffff
    80002bac:	154080e7          	jalr	340(ra) # 80001cfc <panic>
    80002bb0:	00001517          	auipc	a0,0x1
    80002bb4:	5f850513          	addi	a0,a0,1528 # 800041a8 <digits+0x30>
    80002bb8:	fffff097          	auipc	ra,0xfffff
    80002bbc:	144080e7          	jalr	324(ra) # 80001cfc <panic>

0000000080002bc0 <holding>:
    80002bc0:	00052783          	lw	a5,0(a0)
    80002bc4:	00079663          	bnez	a5,80002bd0 <holding+0x10>
    80002bc8:	00000513          	li	a0,0
    80002bcc:	00008067          	ret
    80002bd0:	fe010113          	addi	sp,sp,-32
    80002bd4:	00813823          	sd	s0,16(sp)
    80002bd8:	00913423          	sd	s1,8(sp)
    80002bdc:	00113c23          	sd	ra,24(sp)
    80002be0:	02010413          	addi	s0,sp,32
    80002be4:	01053483          	ld	s1,16(a0)
    80002be8:	ffffe097          	auipc	ra,0xffffe
    80002bec:	750080e7          	jalr	1872(ra) # 80001338 <mycpu>
    80002bf0:	01813083          	ld	ra,24(sp)
    80002bf4:	01013403          	ld	s0,16(sp)
    80002bf8:	40a48533          	sub	a0,s1,a0
    80002bfc:	00153513          	seqz	a0,a0
    80002c00:	00813483          	ld	s1,8(sp)
    80002c04:	02010113          	addi	sp,sp,32
    80002c08:	00008067          	ret

0000000080002c0c <push_off>:
    80002c0c:	fe010113          	addi	sp,sp,-32
    80002c10:	00813823          	sd	s0,16(sp)
    80002c14:	00113c23          	sd	ra,24(sp)
    80002c18:	00913423          	sd	s1,8(sp)
    80002c1c:	02010413          	addi	s0,sp,32
    80002c20:	100024f3          	csrr	s1,sstatus
    80002c24:	100027f3          	csrr	a5,sstatus
    80002c28:	ffd7f793          	andi	a5,a5,-3
    80002c2c:	10079073          	csrw	sstatus,a5
    80002c30:	ffffe097          	auipc	ra,0xffffe
    80002c34:	708080e7          	jalr	1800(ra) # 80001338 <mycpu>
    80002c38:	07852783          	lw	a5,120(a0)
    80002c3c:	02078663          	beqz	a5,80002c68 <push_off+0x5c>
    80002c40:	ffffe097          	auipc	ra,0xffffe
    80002c44:	6f8080e7          	jalr	1784(ra) # 80001338 <mycpu>
    80002c48:	07852783          	lw	a5,120(a0)
    80002c4c:	01813083          	ld	ra,24(sp)
    80002c50:	01013403          	ld	s0,16(sp)
    80002c54:	0017879b          	addiw	a5,a5,1
    80002c58:	06f52c23          	sw	a5,120(a0)
    80002c5c:	00813483          	ld	s1,8(sp)
    80002c60:	02010113          	addi	sp,sp,32
    80002c64:	00008067          	ret
    80002c68:	0014d493          	srli	s1,s1,0x1
    80002c6c:	ffffe097          	auipc	ra,0xffffe
    80002c70:	6cc080e7          	jalr	1740(ra) # 80001338 <mycpu>
    80002c74:	0014f493          	andi	s1,s1,1
    80002c78:	06952e23          	sw	s1,124(a0)
    80002c7c:	fc5ff06f          	j	80002c40 <push_off+0x34>

0000000080002c80 <pop_off>:
    80002c80:	ff010113          	addi	sp,sp,-16
    80002c84:	00813023          	sd	s0,0(sp)
    80002c88:	00113423          	sd	ra,8(sp)
    80002c8c:	01010413          	addi	s0,sp,16
    80002c90:	ffffe097          	auipc	ra,0xffffe
    80002c94:	6a8080e7          	jalr	1704(ra) # 80001338 <mycpu>
    80002c98:	100027f3          	csrr	a5,sstatus
    80002c9c:	0027f793          	andi	a5,a5,2
    80002ca0:	04079663          	bnez	a5,80002cec <pop_off+0x6c>
    80002ca4:	07852783          	lw	a5,120(a0)
    80002ca8:	02f05a63          	blez	a5,80002cdc <pop_off+0x5c>
    80002cac:	fff7871b          	addiw	a4,a5,-1
    80002cb0:	06e52c23          	sw	a4,120(a0)
    80002cb4:	00071c63          	bnez	a4,80002ccc <pop_off+0x4c>
    80002cb8:	07c52783          	lw	a5,124(a0)
    80002cbc:	00078863          	beqz	a5,80002ccc <pop_off+0x4c>
    80002cc0:	100027f3          	csrr	a5,sstatus
    80002cc4:	0027e793          	ori	a5,a5,2
    80002cc8:	10079073          	csrw	sstatus,a5
    80002ccc:	00813083          	ld	ra,8(sp)
    80002cd0:	00013403          	ld	s0,0(sp)
    80002cd4:	01010113          	addi	sp,sp,16
    80002cd8:	00008067          	ret
    80002cdc:	00001517          	auipc	a0,0x1
    80002ce0:	4e450513          	addi	a0,a0,1252 # 800041c0 <digits+0x48>
    80002ce4:	fffff097          	auipc	ra,0xfffff
    80002ce8:	018080e7          	jalr	24(ra) # 80001cfc <panic>
    80002cec:	00001517          	auipc	a0,0x1
    80002cf0:	4bc50513          	addi	a0,a0,1212 # 800041a8 <digits+0x30>
    80002cf4:	fffff097          	auipc	ra,0xfffff
    80002cf8:	008080e7          	jalr	8(ra) # 80001cfc <panic>

0000000080002cfc <push_on>:
    80002cfc:	fe010113          	addi	sp,sp,-32
    80002d00:	00813823          	sd	s0,16(sp)
    80002d04:	00113c23          	sd	ra,24(sp)
    80002d08:	00913423          	sd	s1,8(sp)
    80002d0c:	02010413          	addi	s0,sp,32
    80002d10:	100024f3          	csrr	s1,sstatus
    80002d14:	100027f3          	csrr	a5,sstatus
    80002d18:	0027e793          	ori	a5,a5,2
    80002d1c:	10079073          	csrw	sstatus,a5
    80002d20:	ffffe097          	auipc	ra,0xffffe
    80002d24:	618080e7          	jalr	1560(ra) # 80001338 <mycpu>
    80002d28:	07852783          	lw	a5,120(a0)
    80002d2c:	02078663          	beqz	a5,80002d58 <push_on+0x5c>
    80002d30:	ffffe097          	auipc	ra,0xffffe
    80002d34:	608080e7          	jalr	1544(ra) # 80001338 <mycpu>
    80002d38:	07852783          	lw	a5,120(a0)
    80002d3c:	01813083          	ld	ra,24(sp)
    80002d40:	01013403          	ld	s0,16(sp)
    80002d44:	0017879b          	addiw	a5,a5,1
    80002d48:	06f52c23          	sw	a5,120(a0)
    80002d4c:	00813483          	ld	s1,8(sp)
    80002d50:	02010113          	addi	sp,sp,32
    80002d54:	00008067          	ret
    80002d58:	0014d493          	srli	s1,s1,0x1
    80002d5c:	ffffe097          	auipc	ra,0xffffe
    80002d60:	5dc080e7          	jalr	1500(ra) # 80001338 <mycpu>
    80002d64:	0014f493          	andi	s1,s1,1
    80002d68:	06952e23          	sw	s1,124(a0)
    80002d6c:	fc5ff06f          	j	80002d30 <push_on+0x34>

0000000080002d70 <pop_on>:
    80002d70:	ff010113          	addi	sp,sp,-16
    80002d74:	00813023          	sd	s0,0(sp)
    80002d78:	00113423          	sd	ra,8(sp)
    80002d7c:	01010413          	addi	s0,sp,16
    80002d80:	ffffe097          	auipc	ra,0xffffe
    80002d84:	5b8080e7          	jalr	1464(ra) # 80001338 <mycpu>
    80002d88:	100027f3          	csrr	a5,sstatus
    80002d8c:	0027f793          	andi	a5,a5,2
    80002d90:	04078463          	beqz	a5,80002dd8 <pop_on+0x68>
    80002d94:	07852783          	lw	a5,120(a0)
    80002d98:	02f05863          	blez	a5,80002dc8 <pop_on+0x58>
    80002d9c:	fff7879b          	addiw	a5,a5,-1
    80002da0:	06f52c23          	sw	a5,120(a0)
    80002da4:	07853783          	ld	a5,120(a0)
    80002da8:	00079863          	bnez	a5,80002db8 <pop_on+0x48>
    80002dac:	100027f3          	csrr	a5,sstatus
    80002db0:	ffd7f793          	andi	a5,a5,-3
    80002db4:	10079073          	csrw	sstatus,a5
    80002db8:	00813083          	ld	ra,8(sp)
    80002dbc:	00013403          	ld	s0,0(sp)
    80002dc0:	01010113          	addi	sp,sp,16
    80002dc4:	00008067          	ret
    80002dc8:	00001517          	auipc	a0,0x1
    80002dcc:	42050513          	addi	a0,a0,1056 # 800041e8 <digits+0x70>
    80002dd0:	fffff097          	auipc	ra,0xfffff
    80002dd4:	f2c080e7          	jalr	-212(ra) # 80001cfc <panic>
    80002dd8:	00001517          	auipc	a0,0x1
    80002ddc:	3f050513          	addi	a0,a0,1008 # 800041c8 <digits+0x50>
    80002de0:	fffff097          	auipc	ra,0xfffff
    80002de4:	f1c080e7          	jalr	-228(ra) # 80001cfc <panic>

0000000080002de8 <__memset>:
    80002de8:	ff010113          	addi	sp,sp,-16
    80002dec:	00813423          	sd	s0,8(sp)
    80002df0:	01010413          	addi	s0,sp,16
    80002df4:	1a060e63          	beqz	a2,80002fb0 <__memset+0x1c8>
    80002df8:	40a007b3          	neg	a5,a0
    80002dfc:	0077f793          	andi	a5,a5,7
    80002e00:	00778693          	addi	a3,a5,7
    80002e04:	00b00813          	li	a6,11
    80002e08:	0ff5f593          	andi	a1,a1,255
    80002e0c:	fff6071b          	addiw	a4,a2,-1
    80002e10:	1b06e663          	bltu	a3,a6,80002fbc <__memset+0x1d4>
    80002e14:	1cd76463          	bltu	a4,a3,80002fdc <__memset+0x1f4>
    80002e18:	1a078e63          	beqz	a5,80002fd4 <__memset+0x1ec>
    80002e1c:	00b50023          	sb	a1,0(a0)
    80002e20:	00100713          	li	a4,1
    80002e24:	1ae78463          	beq	a5,a4,80002fcc <__memset+0x1e4>
    80002e28:	00b500a3          	sb	a1,1(a0)
    80002e2c:	00200713          	li	a4,2
    80002e30:	1ae78a63          	beq	a5,a4,80002fe4 <__memset+0x1fc>
    80002e34:	00b50123          	sb	a1,2(a0)
    80002e38:	00300713          	li	a4,3
    80002e3c:	18e78463          	beq	a5,a4,80002fc4 <__memset+0x1dc>
    80002e40:	00b501a3          	sb	a1,3(a0)
    80002e44:	00400713          	li	a4,4
    80002e48:	1ae78263          	beq	a5,a4,80002fec <__memset+0x204>
    80002e4c:	00b50223          	sb	a1,4(a0)
    80002e50:	00500713          	li	a4,5
    80002e54:	1ae78063          	beq	a5,a4,80002ff4 <__memset+0x20c>
    80002e58:	00b502a3          	sb	a1,5(a0)
    80002e5c:	00700713          	li	a4,7
    80002e60:	18e79e63          	bne	a5,a4,80002ffc <__memset+0x214>
    80002e64:	00b50323          	sb	a1,6(a0)
    80002e68:	00700e93          	li	t4,7
    80002e6c:	00859713          	slli	a4,a1,0x8
    80002e70:	00e5e733          	or	a4,a1,a4
    80002e74:	01059e13          	slli	t3,a1,0x10
    80002e78:	01c76e33          	or	t3,a4,t3
    80002e7c:	01859313          	slli	t1,a1,0x18
    80002e80:	006e6333          	or	t1,t3,t1
    80002e84:	02059893          	slli	a7,a1,0x20
    80002e88:	40f60e3b          	subw	t3,a2,a5
    80002e8c:	011368b3          	or	a7,t1,a7
    80002e90:	02859813          	slli	a6,a1,0x28
    80002e94:	0108e833          	or	a6,a7,a6
    80002e98:	03059693          	slli	a3,a1,0x30
    80002e9c:	003e589b          	srliw	a7,t3,0x3
    80002ea0:	00d866b3          	or	a3,a6,a3
    80002ea4:	03859713          	slli	a4,a1,0x38
    80002ea8:	00389813          	slli	a6,a7,0x3
    80002eac:	00f507b3          	add	a5,a0,a5
    80002eb0:	00e6e733          	or	a4,a3,a4
    80002eb4:	000e089b          	sext.w	a7,t3
    80002eb8:	00f806b3          	add	a3,a6,a5
    80002ebc:	00e7b023          	sd	a4,0(a5)
    80002ec0:	00878793          	addi	a5,a5,8
    80002ec4:	fed79ce3          	bne	a5,a3,80002ebc <__memset+0xd4>
    80002ec8:	ff8e7793          	andi	a5,t3,-8
    80002ecc:	0007871b          	sext.w	a4,a5
    80002ed0:	01d787bb          	addw	a5,a5,t4
    80002ed4:	0ce88e63          	beq	a7,a4,80002fb0 <__memset+0x1c8>
    80002ed8:	00f50733          	add	a4,a0,a5
    80002edc:	00b70023          	sb	a1,0(a4)
    80002ee0:	0017871b          	addiw	a4,a5,1
    80002ee4:	0cc77663          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002ee8:	00e50733          	add	a4,a0,a4
    80002eec:	00b70023          	sb	a1,0(a4)
    80002ef0:	0027871b          	addiw	a4,a5,2
    80002ef4:	0ac77e63          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002ef8:	00e50733          	add	a4,a0,a4
    80002efc:	00b70023          	sb	a1,0(a4)
    80002f00:	0037871b          	addiw	a4,a5,3
    80002f04:	0ac77663          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f08:	00e50733          	add	a4,a0,a4
    80002f0c:	00b70023          	sb	a1,0(a4)
    80002f10:	0047871b          	addiw	a4,a5,4
    80002f14:	08c77e63          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f18:	00e50733          	add	a4,a0,a4
    80002f1c:	00b70023          	sb	a1,0(a4)
    80002f20:	0057871b          	addiw	a4,a5,5
    80002f24:	08c77663          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f28:	00e50733          	add	a4,a0,a4
    80002f2c:	00b70023          	sb	a1,0(a4)
    80002f30:	0067871b          	addiw	a4,a5,6
    80002f34:	06c77e63          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f38:	00e50733          	add	a4,a0,a4
    80002f3c:	00b70023          	sb	a1,0(a4)
    80002f40:	0077871b          	addiw	a4,a5,7
    80002f44:	06c77663          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f48:	00e50733          	add	a4,a0,a4
    80002f4c:	00b70023          	sb	a1,0(a4)
    80002f50:	0087871b          	addiw	a4,a5,8
    80002f54:	04c77e63          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f58:	00e50733          	add	a4,a0,a4
    80002f5c:	00b70023          	sb	a1,0(a4)
    80002f60:	0097871b          	addiw	a4,a5,9
    80002f64:	04c77663          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f68:	00e50733          	add	a4,a0,a4
    80002f6c:	00b70023          	sb	a1,0(a4)
    80002f70:	00a7871b          	addiw	a4,a5,10
    80002f74:	02c77e63          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f78:	00e50733          	add	a4,a0,a4
    80002f7c:	00b70023          	sb	a1,0(a4)
    80002f80:	00b7871b          	addiw	a4,a5,11
    80002f84:	02c77663          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f88:	00e50733          	add	a4,a0,a4
    80002f8c:	00b70023          	sb	a1,0(a4)
    80002f90:	00c7871b          	addiw	a4,a5,12
    80002f94:	00c77e63          	bgeu	a4,a2,80002fb0 <__memset+0x1c8>
    80002f98:	00e50733          	add	a4,a0,a4
    80002f9c:	00b70023          	sb	a1,0(a4)
    80002fa0:	00d7879b          	addiw	a5,a5,13
    80002fa4:	00c7f663          	bgeu	a5,a2,80002fb0 <__memset+0x1c8>
    80002fa8:	00f507b3          	add	a5,a0,a5
    80002fac:	00b78023          	sb	a1,0(a5)
    80002fb0:	00813403          	ld	s0,8(sp)
    80002fb4:	01010113          	addi	sp,sp,16
    80002fb8:	00008067          	ret
    80002fbc:	00b00693          	li	a3,11
    80002fc0:	e55ff06f          	j	80002e14 <__memset+0x2c>
    80002fc4:	00300e93          	li	t4,3
    80002fc8:	ea5ff06f          	j	80002e6c <__memset+0x84>
    80002fcc:	00100e93          	li	t4,1
    80002fd0:	e9dff06f          	j	80002e6c <__memset+0x84>
    80002fd4:	00000e93          	li	t4,0
    80002fd8:	e95ff06f          	j	80002e6c <__memset+0x84>
    80002fdc:	00000793          	li	a5,0
    80002fe0:	ef9ff06f          	j	80002ed8 <__memset+0xf0>
    80002fe4:	00200e93          	li	t4,2
    80002fe8:	e85ff06f          	j	80002e6c <__memset+0x84>
    80002fec:	00400e93          	li	t4,4
    80002ff0:	e7dff06f          	j	80002e6c <__memset+0x84>
    80002ff4:	00500e93          	li	t4,5
    80002ff8:	e75ff06f          	j	80002e6c <__memset+0x84>
    80002ffc:	00600e93          	li	t4,6
    80003000:	e6dff06f          	j	80002e6c <__memset+0x84>

0000000080003004 <__memmove>:
    80003004:	ff010113          	addi	sp,sp,-16
    80003008:	00813423          	sd	s0,8(sp)
    8000300c:	01010413          	addi	s0,sp,16
    80003010:	0e060863          	beqz	a2,80003100 <__memmove+0xfc>
    80003014:	fff6069b          	addiw	a3,a2,-1
    80003018:	0006881b          	sext.w	a6,a3
    8000301c:	0ea5e863          	bltu	a1,a0,8000310c <__memmove+0x108>
    80003020:	00758713          	addi	a4,a1,7
    80003024:	00a5e7b3          	or	a5,a1,a0
    80003028:	40a70733          	sub	a4,a4,a0
    8000302c:	0077f793          	andi	a5,a5,7
    80003030:	00f73713          	sltiu	a4,a4,15
    80003034:	00174713          	xori	a4,a4,1
    80003038:	0017b793          	seqz	a5,a5
    8000303c:	00e7f7b3          	and	a5,a5,a4
    80003040:	10078863          	beqz	a5,80003150 <__memmove+0x14c>
    80003044:	00900793          	li	a5,9
    80003048:	1107f463          	bgeu	a5,a6,80003150 <__memmove+0x14c>
    8000304c:	0036581b          	srliw	a6,a2,0x3
    80003050:	fff8081b          	addiw	a6,a6,-1
    80003054:	02081813          	slli	a6,a6,0x20
    80003058:	01d85893          	srli	a7,a6,0x1d
    8000305c:	00858813          	addi	a6,a1,8
    80003060:	00058793          	mv	a5,a1
    80003064:	00050713          	mv	a4,a0
    80003068:	01088833          	add	a6,a7,a6
    8000306c:	0007b883          	ld	a7,0(a5)
    80003070:	00878793          	addi	a5,a5,8
    80003074:	00870713          	addi	a4,a4,8
    80003078:	ff173c23          	sd	a7,-8(a4)
    8000307c:	ff0798e3          	bne	a5,a6,8000306c <__memmove+0x68>
    80003080:	ff867713          	andi	a4,a2,-8
    80003084:	02071793          	slli	a5,a4,0x20
    80003088:	0207d793          	srli	a5,a5,0x20
    8000308c:	00f585b3          	add	a1,a1,a5
    80003090:	40e686bb          	subw	a3,a3,a4
    80003094:	00f507b3          	add	a5,a0,a5
    80003098:	06e60463          	beq	a2,a4,80003100 <__memmove+0xfc>
    8000309c:	0005c703          	lbu	a4,0(a1)
    800030a0:	00e78023          	sb	a4,0(a5)
    800030a4:	04068e63          	beqz	a3,80003100 <__memmove+0xfc>
    800030a8:	0015c603          	lbu	a2,1(a1)
    800030ac:	00100713          	li	a4,1
    800030b0:	00c780a3          	sb	a2,1(a5)
    800030b4:	04e68663          	beq	a3,a4,80003100 <__memmove+0xfc>
    800030b8:	0025c603          	lbu	a2,2(a1)
    800030bc:	00200713          	li	a4,2
    800030c0:	00c78123          	sb	a2,2(a5)
    800030c4:	02e68e63          	beq	a3,a4,80003100 <__memmove+0xfc>
    800030c8:	0035c603          	lbu	a2,3(a1)
    800030cc:	00300713          	li	a4,3
    800030d0:	00c781a3          	sb	a2,3(a5)
    800030d4:	02e68663          	beq	a3,a4,80003100 <__memmove+0xfc>
    800030d8:	0045c603          	lbu	a2,4(a1)
    800030dc:	00400713          	li	a4,4
    800030e0:	00c78223          	sb	a2,4(a5)
    800030e4:	00e68e63          	beq	a3,a4,80003100 <__memmove+0xfc>
    800030e8:	0055c603          	lbu	a2,5(a1)
    800030ec:	00500713          	li	a4,5
    800030f0:	00c782a3          	sb	a2,5(a5)
    800030f4:	00e68663          	beq	a3,a4,80003100 <__memmove+0xfc>
    800030f8:	0065c703          	lbu	a4,6(a1)
    800030fc:	00e78323          	sb	a4,6(a5)
    80003100:	00813403          	ld	s0,8(sp)
    80003104:	01010113          	addi	sp,sp,16
    80003108:	00008067          	ret
    8000310c:	02061713          	slli	a4,a2,0x20
    80003110:	02075713          	srli	a4,a4,0x20
    80003114:	00e587b3          	add	a5,a1,a4
    80003118:	f0f574e3          	bgeu	a0,a5,80003020 <__memmove+0x1c>
    8000311c:	02069613          	slli	a2,a3,0x20
    80003120:	02065613          	srli	a2,a2,0x20
    80003124:	fff64613          	not	a2,a2
    80003128:	00e50733          	add	a4,a0,a4
    8000312c:	00c78633          	add	a2,a5,a2
    80003130:	fff7c683          	lbu	a3,-1(a5)
    80003134:	fff78793          	addi	a5,a5,-1
    80003138:	fff70713          	addi	a4,a4,-1
    8000313c:	00d70023          	sb	a3,0(a4)
    80003140:	fec798e3          	bne	a5,a2,80003130 <__memmove+0x12c>
    80003144:	00813403          	ld	s0,8(sp)
    80003148:	01010113          	addi	sp,sp,16
    8000314c:	00008067          	ret
    80003150:	02069713          	slli	a4,a3,0x20
    80003154:	02075713          	srli	a4,a4,0x20
    80003158:	00170713          	addi	a4,a4,1
    8000315c:	00e50733          	add	a4,a0,a4
    80003160:	00050793          	mv	a5,a0
    80003164:	0005c683          	lbu	a3,0(a1)
    80003168:	00178793          	addi	a5,a5,1
    8000316c:	00158593          	addi	a1,a1,1
    80003170:	fed78fa3          	sb	a3,-1(a5)
    80003174:	fee798e3          	bne	a5,a4,80003164 <__memmove+0x160>
    80003178:	f89ff06f          	j	80003100 <__memmove+0xfc>

000000008000317c <__putc>:
    8000317c:	fe010113          	addi	sp,sp,-32
    80003180:	00813823          	sd	s0,16(sp)
    80003184:	00113c23          	sd	ra,24(sp)
    80003188:	02010413          	addi	s0,sp,32
    8000318c:	00050793          	mv	a5,a0
    80003190:	fef40593          	addi	a1,s0,-17
    80003194:	00100613          	li	a2,1
    80003198:	00000513          	li	a0,0
    8000319c:	fef407a3          	sb	a5,-17(s0)
    800031a0:	fffff097          	auipc	ra,0xfffff
    800031a4:	b3c080e7          	jalr	-1220(ra) # 80001cdc <console_write>
    800031a8:	01813083          	ld	ra,24(sp)
    800031ac:	01013403          	ld	s0,16(sp)
    800031b0:	02010113          	addi	sp,sp,32
    800031b4:	00008067          	ret

00000000800031b8 <__getc>:
    800031b8:	fe010113          	addi	sp,sp,-32
    800031bc:	00813823          	sd	s0,16(sp)
    800031c0:	00113c23          	sd	ra,24(sp)
    800031c4:	02010413          	addi	s0,sp,32
    800031c8:	fe840593          	addi	a1,s0,-24
    800031cc:	00100613          	li	a2,1
    800031d0:	00000513          	li	a0,0
    800031d4:	fffff097          	auipc	ra,0xfffff
    800031d8:	ae8080e7          	jalr	-1304(ra) # 80001cbc <console_read>
    800031dc:	fe844503          	lbu	a0,-24(s0)
    800031e0:	01813083          	ld	ra,24(sp)
    800031e4:	01013403          	ld	s0,16(sp)
    800031e8:	02010113          	addi	sp,sp,32
    800031ec:	00008067          	ret

00000000800031f0 <console_handler>:
    800031f0:	fe010113          	addi	sp,sp,-32
    800031f4:	00813823          	sd	s0,16(sp)
    800031f8:	00113c23          	sd	ra,24(sp)
    800031fc:	00913423          	sd	s1,8(sp)
    80003200:	02010413          	addi	s0,sp,32
    80003204:	14202773          	csrr	a4,scause
    80003208:	100027f3          	csrr	a5,sstatus
    8000320c:	0027f793          	andi	a5,a5,2
    80003210:	06079e63          	bnez	a5,8000328c <console_handler+0x9c>
    80003214:	00074c63          	bltz	a4,8000322c <console_handler+0x3c>
    80003218:	01813083          	ld	ra,24(sp)
    8000321c:	01013403          	ld	s0,16(sp)
    80003220:	00813483          	ld	s1,8(sp)
    80003224:	02010113          	addi	sp,sp,32
    80003228:	00008067          	ret
    8000322c:	0ff77713          	andi	a4,a4,255
    80003230:	00900793          	li	a5,9
    80003234:	fef712e3          	bne	a4,a5,80003218 <console_handler+0x28>
    80003238:	ffffe097          	auipc	ra,0xffffe
    8000323c:	6dc080e7          	jalr	1756(ra) # 80001914 <plic_claim>
    80003240:	00a00793          	li	a5,10
    80003244:	00050493          	mv	s1,a0
    80003248:	02f50c63          	beq	a0,a5,80003280 <console_handler+0x90>
    8000324c:	fc0506e3          	beqz	a0,80003218 <console_handler+0x28>
    80003250:	00050593          	mv	a1,a0
    80003254:	00001517          	auipc	a0,0x1
    80003258:	e9c50513          	addi	a0,a0,-356 # 800040f0 <CONSOLE_STATUS+0xe0>
    8000325c:	fffff097          	auipc	ra,0xfffff
    80003260:	afc080e7          	jalr	-1284(ra) # 80001d58 <__printf>
    80003264:	01013403          	ld	s0,16(sp)
    80003268:	01813083          	ld	ra,24(sp)
    8000326c:	00048513          	mv	a0,s1
    80003270:	00813483          	ld	s1,8(sp)
    80003274:	02010113          	addi	sp,sp,32
    80003278:	ffffe317          	auipc	t1,0xffffe
    8000327c:	6d430067          	jr	1748(t1) # 8000194c <plic_complete>
    80003280:	fffff097          	auipc	ra,0xfffff
    80003284:	3e0080e7          	jalr	992(ra) # 80002660 <uartintr>
    80003288:	fddff06f          	j	80003264 <console_handler+0x74>
    8000328c:	00001517          	auipc	a0,0x1
    80003290:	f6450513          	addi	a0,a0,-156 # 800041f0 <digits+0x78>
    80003294:	fffff097          	auipc	ra,0xfffff
    80003298:	a68080e7          	jalr	-1432(ra) # 80001cfc <panic>
	...
