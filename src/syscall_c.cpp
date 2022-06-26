#include "../h/syscall_c.h"
#include "../h/mem.h"
#include "../h/thread.hpp"
#include "../h/abi_codes.h"
#include "../lib/hw.h"
//always use ecall

void* mem_alloc(size_t size){
    size_t blocks;
    if ((size+sizeof(size_t)) % MEM_BLOCK_SIZE == 0) blocks = (size+sizeof(size_t));
    else blocks = ((size+sizeof(size_t)) / MEM_BLOCK_SIZE + 1);

    __asm__ volatile ("mv a1, %[write] " : : [write] "r" (blocks));//set first parametar
    __asm__ volatile ("mv a0, %[write] " : : [write] "r" (MEM_ALLOC_CODE));//set a0 to function code
    __asm__ volatile("ecall");
    void *ptr;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (ptr));//get return value
    return ptr;
}
int mem_free(void* ptr){
    __asm__ volatile ("mv a1, %[write] " : : [write] "r" ((uint64)ptr));//set first parametar
    __asm__ volatile ("mv a0, %[write] " : : [write] "r" (MEM_FREE_CODE));//set a0 to function code
    __asm__ volatile("ecall");
    int ret;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (ret));//get return value
    return ret;
}


int thread_create(thread_t* handle, void(*start_routine)(void*), void* arg){//allocate stack
    return 0;
}

int thread_exit (){
    return 0;
}

void thread_dispatch (){

}