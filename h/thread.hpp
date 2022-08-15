#pragma once
#include "../lib/hw.h"
#include "scheduler.hpp"
#include "node.h"

class _thread;
typedef _thread* thread_t;

class _thread{
private:
    _thread(void (*body)(void *), void* arg, void* stack_space, int start=1);
    void (*body)(void *);
    void *stack;

    int started;

public:
    int start();

    static void dispatch();

    static int thread_create(thread_t* handle ,void(*start_routine)(void*), void* arg, void* stack_space,int start=1);
    static int thread_exit();
    static int delThread(thread_t);
    Node<thread_t> mySchedulerNode,mySemNode;

    struct Context{//pc and sp in Thread, rest on stack
        uint64 pc;
        uint64 sp;
    };

    static thread_t running;
    Context myContext;

    static void * operator new(size_t size);
    static void operator delete(void *p);


    static uint64 savedRegsSystem[34];
    static uint64 systemStack[DEFAULT_STACK_SIZE*MEM_BLOCK_SIZE];
    static void * systemStackPointer;
    static void * savedRegsSystemPointer;
    static void setReturnValue(uint64 val);

};