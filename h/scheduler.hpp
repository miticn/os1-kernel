#pragma once
#include "thread.hpp"
class _thread;
typedef _thread* thread_t;

class Scheduler{
private:
    static thread_t first;
    static thread_t last;

public:
    static thread_t get();
    static void push(thread_t);
    static thread_t firstGet(){return first;}
};