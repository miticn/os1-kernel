#include "../h/syscall_c.h"
#include "../h/mem.h"
#include "../h/thread.hpp"
#include "../h/abi_codes.h"
#include "../lib/hw.h"
//always use ecall
extern "C" void setParams(uint64 a0,uint64 a1,uint64 a2,uint64 a3,uint64 a4);

void* mem_alloc(size_t size){
    size_t blocks;
    blocks = getNumOfBlocks(size);


    setParams(MEM_ALLOC_CODE,blocks,0,0,0);
    //__asm__ volatile ("mv a0, %[write] " : : [write] "r" (MEM_ALLOC_CODE));//set a0 to function code
    //__asm__ volatile ("mv a1, %[write] " : : [write] "r" (blocks));//set first parametar
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
    thread_t* hand= handle;
    void(*body)(void*) = start_routine;
    void* ar=arg;
    void* stack;
    if(body!=0) {
        stack = mem_alloc(DEFAULT_STACK_SIZE);
        stack = (char*)stack+DEFAULT_STACK_SIZE;
    }
    else
        stack = 0;

    if(body!=0 && stack == 0) return -5;



    __asm__ volatile ("mv a1, %[write] " : : [write] "r" (hand));//set first parametar
    __asm__ volatile ("mv a2, %[write] " : : [write] "r" (body));//set 2 parametar
    __asm__ volatile ("mv a3, %[write] " : : [write] "r" (ar));//set 3 parametar
    __asm__ volatile ("mv a4, %[write] " : : [write] "r" (stack));//set 4 parametar
    __asm__ volatile ("mv a0, %[write] " : : [write] "r" (THREAD_CREATE_CODE));//set a0 to function code
    __asm__ volatile("ecall");


    int ret_val;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (ret_val));


    return ret_val;
}

int thread_exit (){
    setParams(THREAD_EXIT_CODE,0,0,0,0);
    __asm__ volatile("ecall");
    return 0;
}

void thread_dispatch (){
    setParams(THREAD_DISPATCH_CODE,0,0,0,0);
    __asm__ volatile("ecall");

}


void putc(char c){
    setParams(PUTC_CODE,c,0,0,0);
    __asm__ volatile("ecall");
}