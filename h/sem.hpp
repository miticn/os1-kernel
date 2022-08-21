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
    static void sem_open(sem_t* handle, unsigned init);
    static int sem_close(sem_t handle);
    void wait();
    int signal();

    _sem();
private:
    thread_t first;
    thread_t last;

    unsigned value;

    thread_t get();
    void push(thread_t);
    thread_t firstGet(){return first;}
};

#endif //PROJECT_BASE_SEM_HPP
