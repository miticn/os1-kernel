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