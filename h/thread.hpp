#include "../lib/hw.h"
class _thread;
typedef _thread* thread_t;
class _thread{
public:
    static void yield();
    class SchedulerNode{
    private:
        thread_t next;
    public:
        thread_t getNext(){return next;}
        void setNext(thread_t next){this->next = next;}
    };
    SchedulerNode myNode;
private:
    struct Context{//pc and sp in Thread, rest on stack
        uint64 pc;
        uint64 sp;
    };
    void (*body)();
    void *stack;
    Context myContext;
};
int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg);
int thread_exit ();
void thread_dispatch ();