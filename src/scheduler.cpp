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

int Scheduler::removeThread(thread_t handle){
    //find thread, keep prev, remove from list
    thread_t prev = 0;
    int found = 0;
    for(thread_t i = first; i!=0;i=i->mySchedulerNode.getNext()){
        if(i==handle){
            found=1;
            break;
        }
        prev = i;
    }
    if(found){
        if (handle!=first && handle!=last)
            prev->mySchedulerNode.setNext(handle->mySchedulerNode.getNext());
        else{
            if (handle==first){
                first = first->mySchedulerNode.getNext();
            }
            if (handle==last){
                if(prev==0)
                    last = 0;
                else{
                    prev->mySchedulerNode.setNext(0);
                    last = prev;
                }
            }
        }
    }
    return !found;



}