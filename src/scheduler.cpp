//
// Created by os on 6/26/22.
//
#include "../h/scheduler.hpp"

thread_t Scheduler::first = 0;
thread_t Scheduler::last = 0;

thread_t Scheduler::get(){
    if(first == 0){//? no thread
        return 0;
    }
    else{
        thread_t tmp = first;
        first = first->myNode.getNext();
        tmp->myNode.setNext(0);
        return tmp;
    }
}

void Scheduler::push(thread_t thrd){
    thrd->myNode.setNext(0);
    if(first==0){
        first = last = thrd;
    }
    else{
        last->myNode.setNext(thrd);
        last = thrd;
    }
}