
#include "../lib/hw.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/handle_trap.h"


#include "../h/thread.hpp"
#include "../h/scheduler.hpp"
#include "../h/example.h"
void enableInterupt(){
    __asm__ volatile("csrw stvec, %[vector]" : : [vector] "r" (&supervisorTrap));
    __asm__ volatile("csrs sstatus, 0x02");//enable interupt
    //uint64 mask = 256;
    //__asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(mask));
}

extern void userMain(void* arg);

void main() {
    enableInterupt();
/*
    char* c = new char;
    int* in = new int;
    long* lg = new long;
    *c = 'c';
    putc(*c);
    int i = mem_free(c);

    mem_free(in);
    mem_free(lg);
    */
    //if(i==0){ putc('i');}

    thread_t threads[3];

    thread_create(&threads[0], nullptr, nullptr);


    thread_create(&threads[1], &userMain, nullptr);

    //context switch tests
    //thread_create(&threads[1], &function1, nullptr);
    //thread_create(&threads[2], &function2, nullptr);

    //semaphore test
    /*
    void *params[3];
    char ca1;
    sem_open((sem_t*)&params[0],1);
    sem_open((sem_t*)&params[1],0);
    params[2] = &ca1;

    thread_create(&threads[2], &functionSem2Test, &params);
    thread_create(&threads[1], &functionSem1Test, &params);
    */

    _thread::running = threads[0];
    //thread_exit();

    while (Scheduler::firstGet() != nullptr) {
        thread_dispatch();
    }
    delete threads[1];

    //while(1){
    //}
}