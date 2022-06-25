#include "../h/handle_trap.h"
#include "../h/abi_codes.h"
#include "../lib/hw.h"
#include "../h/mem.h"

#include "../lib/console.h"


uint64 timerCount = 8;
extern "C" void handleSupervisorTrap(){
    uint64 scause,syscall_code;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (syscall_code));//get syscall_code

    __asm__ volatile ("csrr %[read], scause" : [read] "=r"(scause));//get scause
    if(scause==0x08UL || scause==0x09UL) {
        uint64 sepc;

        //Prevent ecall loop
        __asm__ volatile ("csrr %[read], sepc" : [read] "=r" (sepc));//get sepc
        sepc = sepc + 4;
        __asm__ volatile ("csrw sepc, %[write] " : : [write] "r"(sepc));//set sepc



        switch((uint64)syscall_code){
            case MEM_ALLOC_CODE: {
                size_t sz;
                __asm__ volatile ("mv %[read], a1" : [read] "=r" (sz));//get first param
                void *ptr = __mem_alloc(sz);
                __asm__ volatile ("mv a0, %[write] " : : [write] "r" (ptr));//set return value
            }
                break;
            case MEM_FREE_CODE:{
                void* ptr;
                __asm__ volatile ("mv %[read], a1" : [read] "=r" (ptr));//get first param
                int ret = __mem_free(ptr);
                __asm__ volatile ("mv a0, %[write] " : : [write] "r" (ret));//set return value
            }
                break;
            case THREAD_CREATE_CODE:
                break;
            case THREAD_EXIT_CODE:
                break;
            case THREAD_DISPATCH_CODE:
                break;
            case SEM_OPEN_CODE:
                break;
            case SEM_CLOSE_CODE:
                break;
            case SEM_WAIT_CODE:
                break;
            case SEM_SIGNAL_CODE:
                break;
            case TIME_SLEEP_CODE:
                break;
            case GETC_CODE:
                break;
            case PUTC_CODE:
                break;
        }

        asm volatile("csrc sip, 0x02");
    }
    else{//if async return a0 to prev value
        asm volatile("ld x10, 0x50(sp)");
    }
    if(scause==(0x01UL<< 63 | 0x01)){ //is timer interupt?
        timerCount++;
        if(timerCount >= 50){
            __putc('a');
            __putc('\n');
            timerCount = 0;
        }
        asm volatile("csrc sip, 0x02");

    }
    console_handler();


}