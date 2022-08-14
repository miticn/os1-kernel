//
// Created by os on 8/13/22.
//

#ifndef PROJECT_BASE_SEM_HPP
#define PROJECT_BASE_SEM_HPP

#include "thread.hpp"
extern "C" void retriveRegistersFromThreadStackToSys(void *threadContext);
extern "C" void saveRegistersFromSysToThreadStack(void *threadContext);


class _sem;
typedef _sem* sem_t;
class _sem{
public:
    _sem(unsigned init):value(init){};


    int wait(){
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
    int signal(){
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
    ~_sem(){

    }
private:
    thread_t first;
    thread_t last;

    unsigned value;

    thread_t get();
    void push(thread_t);
    thread_t firstGet(){return first;}
};

#endif //PROJECT_BASE_SEM_HPP
