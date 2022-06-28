
#include "../lib/hw.h"
#include "../h/syscall_cpp.h"
#include "../h/syscall_c.h"
#include "../h/handle_trap.h"


#include "../h/example_functions.h"
#include "../h/thread.hpp"
#include "../h/scheduler.hpp"
void enableInterupt(){
    __asm__ volatile("csrw stvec, %[vector]" : : [vector] "r" (&supervisorTrap));
    __asm__ volatile("csrs sstatus, 0x02");//enable interupt
}

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
    printString("Zdravo ljudi!\n");

    thread_t threads[3];

    thread_create(&threads[0],nullptr,nullptr);

    thread_create(&threads[1] ,function1,nullptr);
    thread_create(&threads[2] ,function2,nullptr);

    _thread::running = threads[0];



    while(1){
        printString("Main\n");
        thread_t test = Scheduler::firstGet();
        if(test==nullptr) putc('c');
        _thread::yield();
    }
    delete threads[0];
    delete threads[1];
    delete threads[2];


}