//
// Created by os on 6/26/22.
//
#include "../h/thread.hpp"
#include "../h/scheduler.hpp"
#include "../h/syscall_cpp.h"
#include "../h/mem.h"

extern "C" void retriveRegisters();
extern "C" void saveRegisters();

thread_t _thread::running=0;
int _thread::thread_create(thread_t* handle ,void(*start_routine)(void*), void* arg, void* stack_space){
    *handle = new _thread(start_routine,arg,stack_space);
    if(*handle== 0 ) return -9;
    return 0;
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


void *_thread::operator new(size_t size){
    return __mem_alloc(getNumOfBlocks(size));
}
void _thread::operator delete(void *p){
    ((thread_t)p)->stack = ((char*)((thread_t)p)->stack)- DEFAULT_STACK_SIZE;
    mem_free(((thread_t)p)->stack);
    mem_free(p);
}

int _thread::thread_exit() {
    delete running;
    running = Scheduler::get();
    _thread::exit(&running->myContext);
    return -100;
}