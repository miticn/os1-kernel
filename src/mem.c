#include "mem.h"
#include "../lib/hw.h"

static _frmem *first = 0;
//Keep alocated block size in block
void* __mem_alloc(size_t size){
    //for first alloc;
    if(first == 0) {
        first = HEAP_START_ADDR;
        first->current_size = HEAP_END_ADDR - HEAP_START_ADDR;
        first->next = 0;
    }
    //Calculate size to alloc
    size_t size_to_alloc;
    if (size % MEM_BLOCK_SIZE == 0) size_to_alloc = size;
    else size_to_alloc = (size / MEM_BLOCK_SIZE + 1)* MEM_BLOCK_SIZE;

    if(size_to_alloc)

    //if (first.)

    return 0;
}

int __mem_free(void* ptr){
    return 0;
}
