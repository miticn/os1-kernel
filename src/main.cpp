#include "../lib/console.h"

#include "../lib/hw.h"
#include "../h/syscall_cpp.h"
#include "../h/syscall_c.h"
#include "../h/handle_trap.h"


#include "../h/example_functions.h"
#include "../h/thread.hpp"
#include "../h/scheduler.hpp"
void main(){
    __asm__ volatile("csrw stvec, %[vector]" : : [vector] "r" (&supervisorTrap));
    __asm__ volatile("csrs sstatus, 0x02");//enable interupt

    char* c = new char;
    int* in = new int;
    long* lg = new long;
    *c = 'c';
    __putc(*c);
    int i = mem_free(c);

    mem_free(in);
    mem_free(lg);
    if(i==0){ __putc('i');}
    printString("Zdravo ljudi!");

    thread_t threads[4];
    threads[0] = _thread::thread_create(nullptr,nullptr,nullptr);

    void *stack[2];
    stack[0] = mem_alloc(DEFAULT_STACK_SIZE);
    stack[1] = mem_alloc(DEFAULT_STACK_SIZE);
    stack[0] = (char*)stack[0]+DEFAULT_STACK_SIZE;
    stack[1] = (char*)stack[1]+DEFAULT_STACK_SIZE;
    threads[1] = _thread::thread_create(function1,nullptr,stack[0]);
    threads[2] = _thread::thread_create(function2,nullptr,stack[1]);
    _thread::running = threads[0];



    while(1){
        printString("Main\n");
        thread_t test = Scheduler::firstGet();
        if(test==nullptr) __putc('c');
        _thread::yield();
    }
    delete threads[0];
    delete threads[1];
    delete threads[2];


}