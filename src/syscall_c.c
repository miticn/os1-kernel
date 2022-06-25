#include "../h/syscall_c.h"
#include "../h/mem.h"
#include "../h/abi_codes.h"

void* mem_alloc(size_t size){//use ecall
    __asm__ volatile ("mv a1, %[write] " : : [write] "r" (size));//set first parametar
    __asm__ volatile ("mv a0, %[write] " : : [write] "r" (MEM_ALLOC_CODE));//set a0 to function code
    __asm__ volatile("ecall");
    void *ptr;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (ptr));//get return value
    return ptr;
}
int mem_free(void* ptr){//use ecall
    __asm__ volatile ("mv a1, %[write] " : : [write] "r" ((uint64)ptr));//set first parametar
    __asm__ volatile ("mv a0, %[write] " : : [write] "r" (MEM_FREE_CODE));//set a0 to function code

    __asm__ volatile("ecall");
    int ret;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (ret));//get return value
    return ret;
}