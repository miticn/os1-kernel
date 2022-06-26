#include "../h/syscall_c.h"
#include "../h/mem.h"
#include "../h/abi_codes.h"
#include "../lib/hw.h"

void* mem_alloc(size_t size){//use ecall
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
int mem_free(void* ptr){//use ecall
    __asm__ volatile ("mv a1, %[write] " : : [write] "r" ((uint64)ptr));//set first parametar
    __asm__ volatile ("mv a0, %[write] " : : [write] "r" (MEM_FREE_CODE));//set a0 to function code
    __asm__ volatile("ecall");
    int ret;
    __asm__ volatile ("mv %[read], a0" : [read] "=r" (ret));//get return value
    return ret;
}