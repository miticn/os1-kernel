//
// Created by os on 8/18/22.
//

#ifndef PROJECT_BASE_SLEEP_HPP
#define PROJECT_BASE_SLEEP_HPP
#include "thread.hpp"
extern "C" void retriveRegistersFromThreadStackToSys(void *threadContext);
extern "C" void saveRegistersFromSysToThreadStack(void *threadContext);

class Sleep{
private:
    static thread_t first;
public:
    static void sleep(time_t);
    static thread_t get();
    static void push(thread_t, time_t);
    static time_t getTimeLeft();
    static int isEmpty();
    static int removeThread(thread_t handle);
};
#endif //PROJECT_BASE_SLEEP_HPP
