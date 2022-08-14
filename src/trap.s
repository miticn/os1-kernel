# 1 "src/trap.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/riscv64-linux-gnu/include/stdc-predef.h" 1 3
# 32 "<command-line>" 2
# 1 "src/trap.S"
.extern handleSupervisorTrap

.extern _ZN7_thread18systemStackPointerE
.extern _ZN7_thread22savedRegsSystemPointerE

.align 4
.global supervisorTrap
supervisorTrap:
    addi sp,sp, -8
    sd x28, 0x00(sp) # old x28 on thread stack

    ld x28, _ZN7_thread22savedRegsSystemPointerE# set x28 to system regs

    sd x0, 0x00(x28)
    sd x1, 0x08(x28)
    #sd x2, 0x10(x28)# stack pointer
    sd x3, 0x18(x28)
    sd x4, 0x20(x28)
    sd x5, 0x28(x28)
    sd x6, 0x30(x28)
    sd x7, 0x38(x28)
    sd x8, 0x40(x28)
    sd x9, 0x48(x28)
    sd x10, 0x50(x28)
    sd x11, 0x58(x28)
    sd x12, 0x60(x28)
    sd x13, 0x68(x28)
    sd x14, 0x70(x28)
    sd x15, 0x78(x28)
    sd x16, 0x80(x28)
    sd x17, 0x88(x28)
    sd x18, 0x90(x28)
    sd x19, 0x98(x28)
    sd x20, 0xa0(x28)
    sd x21, 0xa8(x28)
    sd x22, 0xb0(x28)
    sd x23, 0xb8(x28)
    sd x24, 0xc0(x28)
    sd x25, 0xc8(x28)
    sd x26, 0xd0(x28)
    sd x27, 0xd8(x28)
    #sd x28, 0xe0(x28) not here
    sd x29, 0xe8(x28)
    sd x30, 0xf0(x28)
    sd x31, 0xf8(x28)

    ld x29, 0x00(sp) # old x28 load to x29
    sd x29, 0xe0(x28) #old x28 save to savedRegs

    addi sp,sp, 8 #free mem from stack
    sd sp, 0x10(x28) # store stack pointer

    #save all regs x0-x31 + sp on system stack

    ld sp, _ZN7_thread18systemStackPointerE #load system stack
    ld sp, 0x00(sp)
    call handleSupervisorTrap


    # restore old regs
    ld sp, _ZN7_thread22savedRegsSystemPointerE
    ld x1, 0x08(sp)
    #ld x2, 0x10(sp) x2 is stack pointer
    ld x3, 0x18(sp)
    ld x4, 0x20(sp)
    ld x5, 0x28(sp)
    ld x6, 0x30(sp)
    ld x7, 0x38(sp)
    ld x8, 0x40(sp)
    ld x9, 0x48(sp)
    ld x10, 0x50(sp) #return value removed
    ld x11, 0x58(sp)
    ld x12, 0x60(sp)
    ld x13, 0x68(sp)
    ld x14, 0x70(sp)
    ld x15, 0x78(sp)
    ld x16, 0x80(sp)
    ld x17, 0x88(sp)
    ld x18, 0x90(sp)
    ld x19, 0x98(sp)
    ld x20, 0xa0(sp)
    ld x21, 0xa8(sp)
    ld x22, 0xb0(sp)
    ld x23, 0xb8(sp)
    ld x24, 0xc0(sp)
    ld x25, 0xc8(sp)
    ld x26, 0xd0(sp)
    ld x27, 0xd8(sp)
    ld x28, 0xe0(sp)
    ld x29, 0xe8(sp)
    ld x30, 0xf0(sp)
    ld x31, 0xf8(sp)

    ld sp, 0x10(sp)
    #restore all regs x0-x31

    csrc sip, 0x02
    sret
