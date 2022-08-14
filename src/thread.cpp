//
// Created by os on 6/26/22.
//
#include "../h/thread.hpp"
#include "../h/scheduler.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/mem.h"

extern "C" void retriveRegistersFromThreadStackToSys(void *threadContext);
extern "C" void saveRegistersFromSysToThreadStack(void *threadContext);


uint64 _thread::savedRegsSystem[34] = {6};
void * _thread::savedRegsSystemPointer = savedRegsSystem;
uint64 _thread::systemStack[DEFAULT_STACK_SIZE*MEM_BLOCK_SIZE] = {6};
void * _thread::systemStackPointer = &systemStack[DEFAULT_STACK_SIZE*MEM_BLOCK_SIZE];

thread_t _thread::running=0;

void _thread::setReturnValue(uint64 val) {
    savedRegsSystem[10] = val;
}
int _thread::thread_create(thread_t* handle ,void(*start_routine)(void*), void* arg, void* stack_space){
    *handle = new _thread(start_routine,arg,stack_space);
    if(*handle== 0 ) return -9;
    return 0;
}

void _thread::dispatch(){
    saveRegistersFromSysToThreadStack(&running->myContext);

    thread_t old = running;
    Scheduler::push(old);
    running = Scheduler::get();

    //_thread::contextSwitch(&old->myContext, &running->myContext);//switch ra and sp

    retriveRegistersFromThreadStackToSys(&running->myContext);
}

_thread::_thread(void (*body)(void *), void* arg, void* stack_space):
        body(body),
        stack(stack_space),
        myContext({(uint64)body,(uint64)stack_space})
{
    if (stack!=0) ((uint64*)stack)[10]=(uint64)arg;
    if(body!=0){
        Scheduler::push(this);
        ((uint64*)stack)[1] = (uint64)&::thread_exit;
    }
};


void *_thread::operator new(size_t size){
    return __mem_alloc(getNumOfBlocks(size));
}
void _thread::operator delete(void *p){
    delThread((thread_t)p);
}

int _thread::delThread(thread_t p){
    int r1 = 0;
    if(((thread_t)p)->stack!=0) {
        ((thread_t) p)->stack = ((char *) ((thread_t) p)->stack) - DEFAULT_STACK_SIZE + 256;
        r1 = __mem_free(((thread_t) p)->stack);
    }
    int r2 = __mem_free(p);
    if(r1 !=0 or r2!=0) return -1;
    return 0;
}

int _thread::thread_exit() {
    int r = delThread(running);
    if (r==0){
        running = Scheduler::get();
        retriveRegistersFromThreadStackToSys(&running->myContext);
    }
    return r;
}