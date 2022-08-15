//
// Created by os on 6/24/22.
//
#include "../h/syscall_c.h"
#include "../h/syscall_cpp.hpp"
void* operator new (size_t size){
    return mem_alloc(size);
}
void operator delete (void* ptr){
    mem_free(ptr);
}


Thread::Thread(void (*body)(void*), void* arg){
     thread_create_no_start(&this->myHandle,body,arg);
}

int Thread::start() {
    thread_start(this->myHandle);
    return 0;//have to change _thread
}

void Thread::dispatch(){
    thread_dispatch();
}

Thread::Thread(){
    thread_create_no_start(&this->myHandle,&Thread::wrapper,this);
}
int Thread::sleep(time_t){
    return 0;//??????
}

Thread::~Thread(){

}