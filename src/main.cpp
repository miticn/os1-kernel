
#include "../lib/hw.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/handle_trap.h"


#include "../h/thread.hpp"
#include "../h/scheduler.hpp"

void enableInterupt(){
    __asm__ volatile("csrw stvec, %[vector]" : : [vector] "r" (&supervisorTrap));
    __asm__ volatile("csrs sstatus, 0x02");//enable interupt
    //uint64 mask = 256;
    //__asm__ volatile("csrc sstatus, %[mask]" : : [mask] "r"(mask));
}

extern void userMain(void* arg);

void main(){
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

    thread_create(&threads[0],nullptr,nullptr);


    thread_create(&threads[1], &userMain, nullptr);



    _thread::running = threads[0];


    while(Scheduler::firstGet()!=nullptr){
        thread_dispatch();
    }
    delete threads[1];

    //while(1){
    //}
}