//
// Created by os on 6/26/22.
//
#include "../h/thread.hpp"
#include "../h/scheduler.hpp"
#include "../h/syscall_cpp.hpp"
#include "../h/mem.h"
#include "../h/sleep.hpp"

extern "C" void retriveRegistersFromThreadStackToSys(void *threadContext);
extern "C" void saveRegistersFromSysToThreadStack(void *threadContext);
extern "C" void setToUserMode();
extern "C" void setToSysMode();

uint64 _thread::savedRegsSystem[34] = {6};
void * _thread::savedRegsSystemPointer = savedRegsSystem;
uint64 _thread::systemStack[DEFAULT_STACK_SIZE*MEM_BLOCK_SIZE] = {6};
void * _thread::systemStackPointer = &systemStack[DEFAULT_STACK_SIZE*MEM_BLOCK_SIZE];

thread_t _thread::running=0;

void _thread::setReturnValue(uint64 val) {
    savedRegsSystem[10] = val;
}
int _thread::thread_create(thread_t* handle ,void(*start_routine)(void*), void* arg, void* stack_space,int start){
    *handle = new _thread(start_routine,arg,stack_space,start);
    if(*handle== 0 ) return -9;
    return 0;
}

void _thread::dispatch(){
    saveRegistersFromSysToThreadStack(&running->myContext);

    thread_t old = running;
    Scheduler::push(old);
    running = Scheduler::get();

    if(running->getPrivilegeLevel()==_thread::ThreadPrivilege::User)
        setToUserMode();
    else if (running->getPrivilegeLevel()==_thread::ThreadPrivilege::System)
        setToSysMode();
    retriveRegistersFromThreadStackToSys(&running->myContext);
}

_thread::_thread(void (*body)(void *), void* arg, void* stack_space, int start):
        body(body),
        stack(stack_space),
        myContext({(uint64)body,(uint64)stack_space})
{
    if (stack!=0) ((uint64*)stack)[10]=(uint64)arg;
    this->started = start;
    this->myPrivilage = ThreadPrivilege::User;
    this->myState = ThreadState::Limbo;
    if(body!=0){
        if (start)
            Scheduler::push(this);
        ((uint64*)stack)[1] = (uint64)&::thread_exit;
    }
};
int _thread::start(){
    if (started==0) {
        Scheduler::push(this);
        started = 1;
        return 0;
    }
    return -5;
}

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

void _thread::thread_exit_class(thread_t handle) {
    if (handle==running)
        thread_exit();
    else{
        //remove from scheduler or sleep or sem and delete
        switch ((handle->myState)) {
            case _thread::ThreadState::Limbo:{
                delThread(handle);
            }
                break;
            case _thread::ThreadState::Semaphore:{
                handle->setMyState(ThreadState::Limbo);
            }
                break;
            case _thread::ThreadState::Sleep:{
                int notFine = Sleep::removeThread(handle);
                if(!notFine)
                    delThread(handle);
            }
                break;
            case _thread::ThreadState::Scheduler:{
                int notFine = Scheduler::removeThread(handle);
                if(!notFine)
                    delThread(handle);
            }
                break;
        }
    }
}

time_t _thread::getMyTime() {
    return myTime;
}

void _thread::setMyTime(time_t time) {
    this->myTime = time;
}

_thread::ThreadState _thread::getMyState() {
    return myState;
}

void _thread::setMyState(_thread::ThreadState newState) {
    myState = newState;
}

_thread::ThreadPrivilege _thread::getPrivilegeLevel() {
    return this->myPrivilage;
}

void _thread::setToSystem() {
    myPrivilage = _thread::ThreadPrivilege::System;
}
