#pragma once
#include "../lib/hw.h"

class _thread;
typedef _thread* thread_t;
class _thread{
public:
    static void dispatch();

    static int thread_create(thread_t* handle ,void(*start_routine)(void*), void* arg, void* stack_space);
    static int thread_exit();
    class SchedulerNode{
    private:
        thread_t next;
    public:
        thread_t getNext(){return next;}
        void setNext(thread_t next){this->next = next;}
    };
    SchedulerNode myNode;

    struct Context{//pc and sp in Thread, rest on stack
        uint64 pc;
        uint64 sp;
    };

    static thread_t running;

    static void exit();
    static void exit(Context *newContext);

    static void * operator new(size_t size);
    static void operator delete(void *p);


    static uint64 savedRegsSystem[34];
    static uint64 systemStack[DEFAULT_STACK_SIZE*MEM_BLOCK_SIZE];
    static void * systemStackPointer;
    static void * savedRegsSystemPointer;
    static void setReturnValue(uint64 val);
private:
    _thread(void (*body)(void *), void* arg, void* stack_space);

    void (*body)(void *);
    void *stack;


    Context myContext;

    static void contextSwitch(Context *oldContext, Context *newContext);//yield u projektu?
};
int _thread_exit ();
void _thread_dispatch ();