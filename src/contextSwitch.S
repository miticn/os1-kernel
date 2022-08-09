.global saveRegistersFromSysToThreadStack
.global retriveRegistersFromThreadStackToSys
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_
.global _ZN7_thread4exitEPNS_7ContextE
.global setParams

.extern _ZN7_thread22savedRegsSystemPointerE

saveRegistersFromSysToThreadStack:#a0 thread sp

    mv a1, sp #old sp backup
    ld a2, _ZN7_thread22savedRegsSystemPointerE # address of saved regs from last thread
    ld sp, 2*8(a2) #thread sp

    addi sp,sp, -256

    #sd x0, 0x00(sp)
    #sd x1, 0x08(sp)
    #sd x2, 0x10(sp)

    #use x28 for temp load
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        ld x28, \index*8(a2)
        sd x28, \index*8(sp)
    .endr

    mv sp,a1 #restore system sp
    ret

retriveRegistersFromThreadStackToSys:#a0 thread sp
     #ld x0, 0x00(sp)
     #ld x1, 0x08(sp)
     #ld x2, 0x10(sp)

    mv a1, sp #old sp backup
    ld sp, 0x08(a0) #thread sp
    ld a2, _ZN7_thread22savedRegsSystemPointerE # address of saved regs from last thread

    ld sp, 2*8(a2)
    .irp index, 3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        ld x28, \index*8(sp)
        sd x28, \index*8(a2)
    .endr

    #mv sp,a1 #restore system sp
    #addi sp, sp, 256
    csrc sip, 0x02
    sret

_ZN7_thread13contextSwitchEPNS_7ContextES1_:# a0 old, a1 -new
    #save sepc to old thread
    csrr x28, sepc
    sd x28, 0x00(a0)

    #get sp from saved regs and store to old thread
    ld x28, _ZN7_thread22savedRegsSystemPointerE
    ld x29, 0x10(x28)
    sd x29, 0x08(a0)

    #load new thread pc to sepc
    ld x28, 0x00(a1)
    csrw sepc,x28

    #ld sp, 0x08(a1)#load new sp to sp
    ret

setParams:
    ret

_ZN7_thread4exitEPNS_7ContextE:
    ld ra, 0x00(a0)
    ld sp, 0x08(a0)
    csrc sip, 0x02
    ret