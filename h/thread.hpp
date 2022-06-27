#pragma once
#include "../lib/hw.h"
class _thread;
typedef _thread* thread_t;
class _thread{
public:
    static void yield();

    static thread_t thread_create(void(*start_routine)(void*), void* arg, void* stack_space);
    class SchedulerNode{
    private:
        thread_t next;
    public:
        thread_t getNext(){return next;}
        void setNext(thread_t next){this->next = next;}
    };
    SchedulerNode myNode;

    static thread_t running;
private:
    _thread(void (*body)(void *), void* arg, void* stack_space);

    void (*body)(void *);
    void *stack;

    struct Context{//pc and sp in Thread, rest on stack
        uint64 pc;
        uint64 sp;
    };
    Context myContext;

    static void contextSwitch(Context *oldContext, Context *newContext);//yield u projektu?
    static void dispatch();
};
int _thread_create(thread_t* handle, void(*start_routine)(void*), void* arg, void* stack_space);
int _thread_exit ();
void _thread_dispatch ();