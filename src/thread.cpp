//
// Created by os on 6/26/22.
//
#include "../h/thread.hpp"
#include "../h/scheduler.hpp"

extern "C" void retriveRegisters();
extern "C" void saveRegisters();

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