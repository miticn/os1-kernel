#include "thread.hpp"
class Scheduler{
private:
    thread_t first, last;

public:
    thread_t get();
    void push(thread_t);
};