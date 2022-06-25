#include "../h/syscall_c.h"
#include "../h/mem.h"

void* mem_alloc(size_t size){//use ecall
    return __mem_alloc(size);
}
int mem_free(void* ptr){//use ecall
    return __mem_free(ptr);
}