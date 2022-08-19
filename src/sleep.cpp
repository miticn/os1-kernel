//
// Created by os on 8/18/22.
//
#include "../h/sleep.hpp"
thread_t Sleep::first = 0;
thread_t Sleep::get() {
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

void Sleep::push(thread_t thrd, time_t time) {
    thread_t i = first;
    thread_t prev = 0;
    while(i!=0 and time >= i->getMyTime()){
        time -= i->getMyTime();
        prev = i;
        i = i->mySchedulerNode.getNext();
    }
    if(prev==0){
        thrd->mySchedulerNode.setNext(first);
        first = thrd;
        thrd->setMyTime(time);
    }
    else{
        thrd->setMyTime(time);
        prev->mySchedulerNode.setNext(thrd);
        thrd->mySchedulerNode.setNext(i);
    }
    //increment those behind
    for(thread_t i=thrd->mySchedulerNode.getNext(); i!=0; i = i->mySchedulerNode.getNext()){
        i->setMyTime(i->getMyTime()+time);
    }
}

void Sleep::sleep(time_t time) {
    saveRegistersFromSysToThreadStack(&_thread::running->myContext);

    thread_t old = _thread::running;
    Sleep::push(old,time);
    _thread::running = Scheduler::get();

    retriveRegistersFromThreadStackToSys(&_thread::running->myContext);
}

time_t Sleep::getTimeLeft() {
    return first->getMyTime();
}

int Sleep::isEmpty() {
    return first == 0;
}
