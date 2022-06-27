#pragma once
#include "thread.hpp"

class Scheduler{
private:
    static thread_t first;
    static thread_t last;

public:
    static thread_t get();
    static void push(thread_t);
    static thread_t firstGet(){return first;}
};