//
// Created by os on 6/24/22.
//
#include "../h/syscall_c.h"
#include "../h/syscall_cpp.h"
void* operator new (size_t size){
    return mem_alloc(size);
}
void operator delete (void* ptr){
    mem_free(ptr);
}