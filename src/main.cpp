
#include "../lib/hw.h"
#include "../h/syscall_cpp.hpp"
#include "../h/syscall_c.h"
#include "../h/handle_trap.h"


#include "../h/thread.hpp"
#include "../h/scheduler.hpp"
#include "../test/example.hpp"
#include "../h/console.h"
#include "../h/sleep.hpp"
void enableInterupt(){
    __asm__ volatile("csrw stvec, %[vector]" : : [vector] "r" (&supervisorTrap));
    __asm__ volatile("csrs sstatus, 0x02");//enable interupt
}
extern void userMain();
void userMainWrapper(void * noArg){
    userMain();
}

void main() {
    enableInterupt();

    thread_t main, PUTC_THREAD, userMain;

    //creating context for main()
    thread_create(&main, nullptr, nullptr);
    _thread::running = main;

    //Starting output thread;
    thread_create_no_start(&PUTC_THREAD,&_console::putc_thread_function, nullptr);
    PUTC_THREAD->setToSystem();
    PUTC_THREAD->start();


    //Starting user thread
    thread_create(&userMain, &userMainWrapper, nullptr);




    //Waiting until all threads finish
    while (!finished_kernel()) {
        thread_dispatch();
    }

    //Deleting system threads;
    delete PUTC_THREAD;
}