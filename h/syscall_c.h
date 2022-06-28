#include "../lib/hw.h"

#ifdef __cplusplus
extern "C" {
#endif
    void* mem_alloc(size_t blocks);
    int mem_free(void* ptr);
    class _thread;
    typedef _thread* thread_t;
    int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg);
    int thread_exit ();
    void thread_dispatch ();

    void putc(char c);
#ifdef __cplusplus
}
#endif
