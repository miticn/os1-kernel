.global saveRegistersFromSysToThreadStack
.global retriveRegistersFromThreadStackToSys
.global _ZN7_thread13contextSwitchEPNS_7ContextES1_
.global _ZN7_thread4exitEPNS_7ContextE
.global setParams
.global setToUserMode
.global setToSysMode

.extern _ZN7_thread22savedRegsSystemPointerE

saveRegistersFromSysToThreadStack:#a0 thread context backup


    ld a2, _ZN7_thread22savedRegsSystemPointerE # address of saved regs from last thread
    ld a1, 2*8(a2) #thread sp

    addi a1,a1, -256

    #sd x0, 0x00(sp)
    #sd x1, 0x08(sp)
    #sd x2, 0x10(sp)

    #use x28 for temp load
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        ld x28, \index*8(a2)
        sd x28, \index*8(a1)
    .endr

    sd a1, 2*8(a1)

    #save sepc to old thread
    csrr x28, sepc
    sd x28, 0x00(a0)

    #save thread stack
    sd a1, 0x08(a0)
    ret

retriveRegistersFromThreadStackToSys:#a0 thread context backup
     #ld x0, 0x00(sp)
     #ld x1, 0x08(sp)
     #ld x2, 0x10(sp)

    ld x29, 0x08(a0) #thread sp
    ld x30, _ZN7_thread22savedRegsSystemPointerE # address of saved regs from last thread

    #ld sp, 2*8(a2)
    .irp index, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
        ld x28, \index*8(x29)
        sd x28, \index*8(x30)
    .endr

    #load new thread pc to sepc
    ld x28, 0x00(a0)
    csrw sepc,x28


    addi x29, x29, 256
    sd x29, 2*0x08(x30)

    //csrc sip, 0x02
    ret

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

setToUserMode:
    addi t4, zero, 256
    csrc sstatus, t4
    ret

setToSysMode:
    addi t4, zero, 256
    csrs sstatus, t4
    ret

_ZN7_thread4exitEPNS_7ContextE:
    ld ra, 0x00(a0)
    ld sp, 0x08(a0)
    csrc sip, 0x02
    ret