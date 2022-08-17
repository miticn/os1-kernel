#include "../h/syscall_c.h"
#include "../h/mem.h"
#include "../h/thread.hpp"
#include "../h/abi_codes.h"
#include "../lib/hw.h"
#include "../lib/console.h"
//always use ecall
extern "C" void setParams(uint64 a0,uint64 a1,uint64 a2,uint64 a3,uint64 a4);

void* mem_alloc(size_t size){
    size_t blocks;
    blocks = getNumOfBlocks(size);


    setParams(MEM_ALLOC_CODE,blocks,0,0,0);
    __asm__ volatile("ecall");
    void *ptr;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (ptr));//get return value
    return ptr;
}
int mem_free(void* ptr){
    setParams(MEM_FREE_CODE,(uint64)ptr,0,0,0);
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

        //alocate space for first pop and set to 0 everything
        stack = (char*)stack+DEFAULT_STACK_SIZE-256;
        uint64* tmpstack=(uint64*)stack;
        for(int i = 0;i<32;i++){
            *(tmpstack+i)=0;
        }
    }
    else
        stack = 0;

    if(body!=0 && stack == 0) return -5;


    setParams(THREAD_CREATE_CODE, (uint64)(hand), (uint64)body, (uint64)ar, (uint64)stack);
    __asm__ volatile("ecall");


    int ret_val;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (ret_val));


    return ret_val;
}
int thread_create_no_start(thread_t* handle, void(*start_routine)(void*), void* arg){
    thread_t* hand= handle;
    void(*body)(void*) = start_routine;
    void* ar=arg;
    void* stack;
    if(body!=0) {
        stack = mem_alloc(DEFAULT_STACK_SIZE);

        //alocate space for first pop and set to 0 everything
        stack = (char*)stack+DEFAULT_STACK_SIZE-256;
        uint64* tmpstack=(uint64*)stack;
        for(int i = 0;i<32;i++){
            *(tmpstack+i)=0;
        }
    }
    else
        stack = 0;

    if(body!=0 && stack == 0) return -5;


    setParams(THREAD_CREATE_NO_START_CODE, (uint64)(hand), (uint64)body, (uint64)ar, (uint64)stack);
    __asm__ volatile("ecall");


    int ret_val;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (ret_val));


    return ret_val;
}
int thread_start(thread_t handle){
    setParams(THREAD_START, (uint64)(handle), 0, 0, 0);
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

void thread_exit_class(thread_t handle){
    setParams(THREAD_EXIT_CLASS_CODE,(uint64)(handle),0,0,0);
    __asm__ volatile("ecall");
}

void thread_dispatch (){
    setParams(THREAD_DISPATCH_CODE,0,0,0,0);
    __asm__ volatile("ecall");

}
int sem_open (sem_t* handle, unsigned init){
    setParams(SEM_OPEN_CODE,(uint64)handle,init,0,0);
    __asm__ volatile("ecall");
    return 0;
}
int sem_close (sem_t handle){
    setParams(SEM_CLOSE_CODE,(uint64)handle,0,0,0);
    __asm__ volatile("ecall");
    return 0;
}
int sem_wait (sem_t id){
    setParams(SEM_WAIT_CODE,(uint64)id,0,0,0);
    __asm__ volatile("ecall");
    return 0;
}
int sem_signal (sem_t id){
    setParams(SEM_SIGNAL_CODE,(uint64)id,0,0,0);
    __asm__ volatile("ecall");
    return 0;
}


void putc(char c){
    setParams(PUTC_CODE,c,0,0,0);
    __asm__ volatile("ecall");
}

char getc(){//ain't working
    return __getc();

    //setParams(GETC_CODE,0,0,0,0);
    //__asm__ volatile("ecall");



    //char ret_val;
    //__asm__ volatile ("mv %[read], a0" : [read] "=r" (ret_val));
    //return ret_val;
}