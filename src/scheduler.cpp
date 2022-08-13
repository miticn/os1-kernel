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
        first = first->mySchedulerNode.getNext();
        tmp->mySchedulerNode.setNext(0);
        return tmp;
    }
}

void Scheduler::push(thread_t thrd){
    thrd->mySchedulerNode.setNext(0);
    if(first==0){
        first = last = thrd;
    }
    else{
        last->mySchedulerNode.setNext(thrd);
        last = thrd;
    }
}