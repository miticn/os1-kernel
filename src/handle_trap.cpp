#include "../h/handle_trap.h"
#include "../h/abi_codes.h"
#include "../lib/hw.h"
#include "../h/mem.h"
#include "../h/thread.hpp"
#include "../h/sem.hpp"

#include "../lib/console.h"


uint64 timerCount = 8;
extern "C" void handleSupervisorTrap(){
    uint64 scause,syscall_code;
    uint64 a1,a2,a3,a4;
    //__asm__ volatile ("mv %[read], a0" : [read] "=r" (syscall_code));//get syscall_code

    //__asm__ volatile ("mv %[read], a1" : [read] "=r" (a1));
    //__asm__ volatile ("mv %[read], a2" : [read] "=r" (a2));
    //__asm__ volatile ("mv %[read], a3" : [read] "=r" (a3));
    //__asm__ volatile ("mv %[read], a4" : [read] "=r" (a4));


    syscall_code = _thread::savedRegsSystem[10];
    a1 = _thread::savedRegsSystem[11];
    a2 = _thread::savedRegsSystem[12];
    a3 = _thread::savedRegsSystem[13];
    a4 = _thread::savedRegsSystem[14];

    __asm__ volatile ("csrr %[read], scause" : [read] "=r"(scause));//get scause
    if(scause==0x08UL || scause==0x09UL) {
        uint64 sepc;

        //Prevent ecall loop
        __asm__ volatile ("csrr %[read], sepc" : [read] "=r" (sepc));//get sepc
        sepc = sepc + 4;
        __asm__ volatile ("csrw sepc, %[write] " : : [write] "r"(sepc));//set sepc



        switch((uint64)syscall_code) {
            case MEM_ALLOC_CODE: {
                size_t sz;
                sz = a1;
                void *ptr = __mem_alloc(sz);
                _thread::setReturnValue((uint64)ptr);
                //__asm__ volatile ("mv a0, %[write] " : : [write] "r"(ptr));//set return value
            }
                break;
            case MEM_FREE_CODE: {
                void *ptr;
                ptr = (void*)a1;//get first param
                int ret = __mem_free(ptr);
                _thread::setReturnValue((uint64)ret);
                //__asm__ volatile ("mv a0, %[write] " : : [write] "r"(ret));//set return value
            }
                break;
            case THREAD_CREATE_CODE: {
                thread_t *handle = (thread_t *) a1;
                void (*body)(void *) = (void (*)(void *)) a2;
                void *ar = (void *) a3;
                void *stack = (void *) a4;
                int ret_val;

                ret_val = _thread::thread_create(handle, body, ar, stack);

                _thread::setReturnValue((uint64)ret_val);
                //__asm__ volatile ("mv a0, %[write] " : : [write] "r"(ret_val));//set ret value
            }
                break;
            case THREAD_EXIT_CODE: {
                int ret = _thread::thread_exit();
                if (ret!=0)
                    _thread::setReturnValue((uint64)ret);
            }
                break;
            case THREAD_DISPATCH_CODE:
                _thread::dispatch();
                break;
            case SEM_OPEN_CODE:{
                sem_t *handle = (sem_t *) a1;
                int init = a2;
                *handle = new _sem(init);
                if (*handle!=0)
                    _thread::setReturnValue((uint64)0);
                else
                    _thread::setReturnValue((uint64)-33);
            }
                break;
            case SEM_CLOSE_CODE:
                break;
            case SEM_WAIT_CODE: {
                sem_t *handle = (sem_t *) a1;
                int ret = (*handle)->wait();
                _thread::setReturnValue((uint64)ret);
            }
                break;
            case SEM_SIGNAL_CODE:{
                sem_t *handle = (sem_t *) a1;
                int ret = (*handle)->signal();
                _thread::setReturnValue((uint64)ret);
            }
                break;
            case TIME_SLEEP_CODE:
                break;
            case GETC_CODE:
                break;
            case PUTC_CODE:
                __putc(a1);

                break;
        }
        //asm volatile("csrc sip, 0x02");
    }
    //else{//if async return a0 to prev value
        //asm volatile("ld x10, 0x50(sp)");
    //}
    /*if(scause==(0x01UL<< 63 | 0x01)){ //is timer interupt?
        timerCount++;
        if(timerCount >= 50){
            __putc('a');
            __putc('\n');
            timerCount = 0;
        }
        //asm volatile("ld x10, 0x50(sp)");
        //asm volatile("csrc sip, 0x02");

    }*/
    console_handler();


}