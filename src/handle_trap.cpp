#include "../h/handle_trap.h"
#include "../h/abi_codes.h"
#include "../lib/hw.h"
#include "../h/mem.h"
#include "../h/thread.hpp"
#include "../h/sem.hpp"
#include "../h/sleep.hpp"
#include "../h/console.h"



uint64 timerCount = 0;
uint64 timerSleepCount = 0;
extern "C" void handleSupervisorTrap(){
    uint64 scause,syscall_code;
    uint64 a1,a2,a3,a4;

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
            }
                break;
            case MEM_FREE_CODE: {
                void *ptr;
                ptr = (void*)a1;//get first param
                int ret = __mem_free(ptr);
                _thread::setReturnValue((uint64)ret);
            }
                break;
            case THREAD_CREATE_CODE: {
                thread_t *handle = (thread_t *) a1;
                void (*body)(void *) = (void (*)(void *)) a2;
                void *ar = (void *) a3;
                void *stack = (void *) a4;
                int ret_val;

                ret_val = _thread::thread_create(handle, body, ar, stack,1);
                _thread::setReturnValue((uint64)ret_val);
            }
                break;
            case THREAD_CREATE_NO_START_CODE: {
                thread_t *handle = (thread_t *) a1;
                void (*body)(void *) = (void (*)(void *)) a2;
                void *ar = (void *) a3;
                void *stack = (void *) a4;
                int ret_val;

                ret_val = _thread::thread_create(handle, body, ar, stack,0);
                _thread::setReturnValue((uint64)ret_val);
            }
                break;
            case THREAD_START: {
                thread_t handle = (thread_t) a1;
                int ret_val;
                ret_val = handle->start();
                _thread::setReturnValue((uint64)ret_val);
            }
                break;
            case THREAD_EXIT_CODE: {
                int ret = _thread::thread_exit();
                if (ret!=0)
                    _thread::setReturnValue((uint64)ret);
            }
                break;
            case THREAD_EXIT_CLASS_CODE:{
                timerCount = 0;
                thread_t handle = (thread_t ) a1;
                _thread::thread_exit_class(handle);
            }
                break;
            case THREAD_DISPATCH_CODE:
                timerCount = 0;
                _thread::dispatch();
                break;
            case SEM_OPEN_CODE:{
                sem_t *handle = (sem_t *) a1;
                int init = a2;
                _sem::sem_open(handle, init);
                if (*handle!=0)
                    _thread::setReturnValue((uint64)0);
                else
                    _thread::setReturnValue((uint64)-33);
            }
                break;
            case SEM_CLOSE_CODE:{
                sem_t handle = (sem_t) a1;
                _sem::sem_close(handle);
            }
                break;
            case SEM_WAIT_CODE: {
                sem_t handle = (sem_t) a1;
                handle->wait();
                //_thread::setReturnValue((uint64)0);
            }
                break;
            case SEM_SIGNAL_CODE:{
                sem_t handle = (sem_t) a1;
                int ret = handle->signal();
                _thread::setReturnValue((uint64)ret);
            }
                break;
            case TIME_SLEEP_CODE:{
                time_t time = (time_t) a1;
                Sleep::sleep(time);
            }
                break;
            case GETC_CODE: {
                char c = _console::getc();
                _thread::setReturnValue((uint64) c);
            }
                break;
            case PUTC_CODE: {
                _console::putc(a1);
            }
                break;
            case FINISHED: {
                _thread::setReturnValue(Scheduler::firstGet() == nullptr && Sleep::isEmpty() && !_console::waitingInput() && !_console::waitingOutput());//add to check if outbuffer empty
            }
            break;
        }
    }
    else if(scause==(0x01UL<< 63 | 0x01)){ //is timer interupt
        timerCount++;
        if(timerCount >= DEFAULT_TIME_SLICE){
            timerCount = 0;
            _thread::dispatch();
        }
        timerSleepCount++;
        if(Sleep::isEmpty()){
            timerSleepCount = 0;
        }
        while(!(Sleep::isEmpty()) && timerSleepCount>= Sleep::getTimeLeft()){
            timerSleepCount-=Sleep::getTimeLeft();
            thread_t tmp = Sleep::get();
            Scheduler::push(tmp);
        }

    }
    else if(scause==(0x01UL<< 63 | 0x09)){//is console interupt
        int code = plic_claim();
        if (code == 0x0a){
            _console::getc_function();
            plic_complete(code);
        }
    }

}