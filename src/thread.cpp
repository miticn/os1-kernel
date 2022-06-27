//
// Created by os on 6/26/22.
//
#include "../h/thread.hpp"
#include "../h/scheduler.hpp"
#include "../h/syscall_cpp.h"

extern "C" void retriveRegisters();
extern "C" void saveRegisters();

thread_t _thread::running=0;
thread_t _thread::thread_create(void (*start_routine)(void *), void *arg, void *stack_space) {
    return new _thread(start_routine,arg,stack_space);
}

void _thread::yield(){
    saveRegisters();

    _thread::dispatch();

    retriveRegisters();
}

void _thread::dispatch(){
    thread_t old = running;
    Scheduler::push(old);
    running = Scheduler::get();

    _thread::contextSwitch(&old->myContext, &running->myContext);
}

_thread::_thread(void (*body)(void *), void* arg, void* stack_space):
        body(body),
        stack(stack_space),
        myContext({(uint64)body,(uint64)stack_space})
{
    if(body!=0) Scheduler::push(this);
};//add args later