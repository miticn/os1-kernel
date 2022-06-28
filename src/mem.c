#include "../h/mem.h"
#include "../lib/hw.h"

extern const void* HEAP_START_ADDR;
extern const void* HEAP_END_ADDR;

typedef struct header{
    size_t freeMem;
    struct header * next;
} FreeHeader;


static void *first_free;
static int init = 0;

size_t getNumOfBlocks(size_t size) {
    if ((size + sizeof(size_t)) % MEM_BLOCK_SIZE == 0) return (size + sizeof(size_t));
    else return ((size + sizeof(size_t)) / MEM_BLOCK_SIZE + 1);
}

//Keep number of blocks allocated in first block
void* __mem_alloc(size_t blocks){
    //for first alloc;
    if(init == 0){
        first_free = (void *)HEAP_START_ADDR;
        FreeHeader firstRunHeader = {((HEAP_END_ADDR - HEAP_START_ADDR)/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE, 0};
        *(FreeHeader*)HEAP_START_ADDR = firstRunHeader;
        init = 1;
    }

    //Calculate size to alloc
    size_t size_to_alloc;

    size_to_alloc = blocks * MEM_BLOCK_SIZE;

    void *myBlock=0;
    FreeHeader*prev = 0;
    for(FreeHeader* i = first_free;i!=0;i=i->next){//first fit 4 now
        if(i->freeMem > size_to_alloc) {
            myBlock = i;
            break;
        }
        prev = i;
    }
    if(myBlock==0) return 0;

    size_t newFreeMem = ((((FreeHeader*)myBlock)->freeMem-size_to_alloc)/MEM_BLOCK_SIZE)*MEM_BLOCK_SIZE;

    void* allocated;
    if(newFreeMem==0){ //remove elem
        if(prev==0){
            first_free = ((FreeHeader*)first_free)->next;
        }
        else{
            prev->next = ((FreeHeader*)myBlock)->next;
        }
        allocated = ((FreeHeader*)myBlock);
    }
    else{//keep upper, allocate at bottom
        ((FreeHeader*)myBlock)->freeMem = newFreeMem;
        allocated = ((void*)myBlock)+ ((FreeHeader*)myBlock)->freeMem;
    }
    *((size_t*)allocated) = size_to_alloc;
    return allocated+sizeof(size_t);

}

int __mem_free(void* ptr){
    void * freeMemStart = ptr - sizeof(size_t);
    size_t memToFree = *(size_t*)freeMemStart;
    
    if(freeMemStart <HEAP_START_ADDR || freeMemStart + memToFree > HEAP_END_ADDR) return -1;

    FreeHeader init = {memToFree, 0};
    *(FreeHeader*)freeMemStart = init;


    if(ptr < first_free){
        ((FreeHeader*)freeMemStart)->next = first_free;
        first_free = ((FreeHeader*)freeMemStart);

        if(first_free + ((FreeHeader*)first_free)->freeMem == (void*)((FreeHeader*)first_free)->next){//post add cleanup
            ((FreeHeader*)first_free)->freeMem += ((FreeHeader*)first_free)->next->freeMem;
            ((FreeHeader*)first_free)->next = ((FreeHeader*)first_free)->next->next;

        }
    }
    else{
        FreeHeader* i;
        for(i = first_free;i!=0;i=i->next){//add new element to list
            if((void*)i < ptr && (ptr < (void*)i->next || i->next == 0)){
                FreeHeader* tmp = i->next;
                i->next = freeMemStart;
                ((FreeHeader*)freeMemStart)->next = tmp;
                break;
            }
        }
        //post add cleanup
        if(((void*)i->next)+(i->next)->freeMem == (void*)(i->next->next)){
            (i->next)->freeMem += i->next->next->freeMem;
            i->next->next = i->next->next->next;

        }
        if((void*)i+i->freeMem == (void*)i->next){
            i->freeMem += i->next->freeMem;
            i->next = i->next->next;
        }

    }
    

    return 0;
}
