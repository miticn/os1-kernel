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
    return thread_start(this->myHandle);
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
    thread_exit_class(myHandle);
}

Semaphore::Semaphore(unsigned int init) {
    sem_open(&myHandle, init);
}

Semaphore::~Semaphore() {
    sem_close(myHandle);
}

int Semaphore::wait() {
    return sem_wait(myHandle);
}

int Semaphore::signal() {
    return sem_signal(myHandle);
}

struct PeriodicStructure{
    PeriodicThread *t;
    time_t time;
};

PeriodicThread::PeriodicThread(time_t period) : Thread(&PeriodicThread::wrapperPeriodic, (void*)(new (PeriodicStructure){this, period})){

}

void PeriodicThread::wrapperPeriodic(void *struc) {
    PeriodicThread* t = ((PeriodicStructure*)struc)->t;
    time_t time = ((PeriodicStructure*)struc)->time;
    mem_free(struc);
    while(1){
        time_sleep(time);
        if(t)((PeriodicThread*)t)->periodicActivation();
        else break;
    }
}