//
// Created by os on 8/13/22.
//
#include "../h/sem.hpp"
#include "../h/mem.h"

thread_t _sem::get(){
    if(first == 0){//? no thread
        return 0;
    }
    else{
        thread_t tmp = first;
        first = first->mySemNode.getNext();
        tmp->mySemNode.setNext(0);
        return tmp;
    }
}

void _sem::push(thread_t thrd){
    thrd->mySemNode.setNext(0);
    if(first==0){
        first = last = thrd;
    }
    else{
        last->mySemNode.setNext(thrd);
        last = thrd;
    }
}

void _sem::wait(){
    if (value>0){//return 0 and move back to scheduler
        value--;
        _thread::setReturnValue(0);
    }
    else if (value==0){//add to waiting list
        saveRegistersFromSysToThreadStack(&_thread::running->myContext);

        thread_t old = _thread::running;
        _sem::push(old);
        _thread::running = Scheduler::get();

        retriveRegistersFromThreadStackToSys(&_thread::running->myContext);
    }


    //return -1;
}

int _sem::signal(){
    if(first==0)
        value++;
    else{//get first return 0 and send to scheduler
        thread_t signaled = _sem::get();

        //Set return value to 0;
        ((uint64*)(signaled->myContext.sp))[10] = 0; //Set a0/x10 to 0 return

        Scheduler::push(signaled);
    }
    return 0;
}

void _sem::sem_open(sem_t *handle, unsigned int init) {
    *handle = (sem_t)__mem_alloc(getNumOfBlocks(sizeof(_sem)));
    (*handle)->value = init;
    (*handle)->first = 0;
    (*handle)->last = 0;
}

int _sem::sem_close(sem_t handle) {
    thread_t i;
    while( (i = handle->get())!=0){
        ((uint64*)(i->myContext.sp))[10] = -34;//set return value
        Scheduler::push(i);//return to scheduler
    }
    handle->first = handle->last = 0;

    __mem_free(handle);
    return 0;
}
