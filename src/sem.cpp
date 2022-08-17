//
// Created by os on 8/13/22.
//
#include "../h/sem.hpp"


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

int  _sem::wait(){
    if (value==0){//add to waiting list
        saveRegistersFromSysToThreadStack(&_thread::running->myContext);

        thread_t old = _thread::running;
        _sem::push(old);
        _thread::running = Scheduler::get();

        retriveRegistersFromThreadStackToSys(&_thread::running->myContext);
    }
    else if (value>0){//return 0 and move back to scheduler
        value--;
        return 0;
    }

    return 0;
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